Return-Path: <netfilter-devel+bounces-1110-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D7C869A9A
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Feb 2024 16:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CF61C2476A
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Feb 2024 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE73146009;
	Tue, 27 Feb 2024 15:41:00 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F1B145B37
	for <netfilter-devel@vger.kernel.org>; Tue, 27 Feb 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048460; cv=none; b=pxLtwgk5/2q87l//nFU8Sa3vhzy8c7cmlUGirSgW+TFESeAjkJZqQ/XXVxkG09SCWLD7iioI03mMdOSaCuMZTOTiqTbZivh3yncus0Uhs1nPvhCIXKR1aNOqjsPNUpRrlQiKM/rBYVtQm5S0qimd3bqOVnAvuqe2l2BG9S09U54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048460; c=relaxed/simple;
	bh=ClwzSuSmHYMw1S4Rc+YAnxSDRbqukV0Sw9Tn+JhY69Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcOD08sOmkPMPHzI3PbCnOKqeE87n7NtWlIOnTYknVmK3t8TSQee3t1v5GCApL5wHD/WWAk3ZK59WrMNZcylieGmx5kBHJO2GePYeEfdh0JFXxsVosyHSKt6hz5+eRmvNJqTfB9BAPYU6tkFCZXKC/oFofGKT7RPDMdqhG/h4GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rezZg-0005XT-Ad; Tue, 27 Feb 2024 16:40:56 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v2 nf] netfilter: bridge: confirm multicast packets before passing them up the stack
Date: Tue, 27 Feb 2024 16:17:51 +0100
Message-ID: <20240227151754.15409-1-fw@strlen.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

conntrack nf_confirm logic cannot handle cloned skbs referencing
the same nf_conn entry, which will happen for multicast (broadcast)
frames on bridges.

 Example:
    macvlan0
       |
      br0
     /  \
  ethX    ethY

 ethX (or Y) receives a L2 multicast or broadcast packet containing
 an IP packet, flow is not yet in conntrack table.

 1. skb passes through bridge and fake-ip (br_netfilter)Prerouting.
    -> skb->_nfct now references a unconfirmed entry
 2. skb is broad/mcast packet. bridge now passes clones out on each bridge
    interface.
 3. skb gets passed up the stack.
 4. In macvlan case, macvlan driver retains clone(s) of the mcast skb
    and schedules a work queue to send them out on the lower devices.

    The clone skb->_nfct is not a copy, it is the same entry as the
    original skb.  The macvlan rx handler then returns RX_HANDLER_PASS.
 5. Normal conntrack hooks (in NF_INET_LOCAL_IN) confirm the orig skb.

The Macvlan broadcast worker and normal confirm path will race.

This race will not happen if step 2 already confirmed a clone. In that
case later steps perform skb_clone() with skb->_nfct already confirmed (in
hash table).  This works fine.

But such confirmation won't happen when eb/ip/nftables rules dropped the
packets before they reached the nf_confirm step in postrouting.

Pablo points out that nf_conntrack_bridge doesn't allow use of stateful
nat, so we can safely discard the nf_conn entry and let inet call
conntrack again.

This doesn't work for bridge netfilter: skb could have a nat
transformation. Also bridge nf prevents re-invocation of inet prerouting
via 'sabotage_in' hook.

Work around this problem by explicit confirmation of the entry at LOCAL_IN
time, before upper layer has a chance to clone the unconfirmed entry.

The downside is that this disables NAT and conntrack helpers.

Alternative fix would be to add locking to all code parts that deal with
unconfirmed packets, but even if that could be done in a sane way this
opens up other problems, for example:

-m physdev --physdev-out eth0 -j SNAT --snat-to 1.2.3.4
-m physdev --physdev-out eth1 -j SNAT --snat-to 1.2.3.5

For multicast case, only one of such conflicting mappings will be
created, conntrack only handles 1:1 NAT mappings.

Users should set create a setup that explicitly marks such traffic
NOTRACK (conntrack bypass) to avoid this, but we cannot auto-bypass
them, ruleset might have accept rules for untracked traffic already,
so user-visible behaviour would change.

Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217777
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2: let nf_conntrack_bridge discard the ct entry instead so
 inet prerouting can do another conntrack lookup after cloning.

 include/linux/netfilter.h                  |  1 +
 net/bridge/br_netfilter_hooks.c            | 96 ++++++++++++++++++++++
 net/bridge/netfilter/nf_conntrack_bridge.c | 30 +++++++
 net/netfilter/nf_conntrack_core.c          |  1 +
 4 files changed, 128 insertions(+)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 80900d910992..ce660d51549b 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -474,6 +474,7 @@ struct nf_ct_hook {
 			      const struct sk_buff *);
 	void (*attach)(struct sk_buff *nskb, const struct sk_buff *skb);
 	void (*set_closing)(struct nf_conntrack *nfct);
+	int (*confirm)(struct sk_buff *skb);
 };
 extern const struct nf_ct_hook __rcu *nf_ct_hook;
 
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index ed1720890757..35e10c5a766d 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -43,6 +43,10 @@
 #include <linux/sysctl.h>
 #endif
 
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+#include <net/netfilter/nf_conntrack_core.h>
+#endif
+
 static unsigned int brnf_net_id __read_mostly;
 
 struct brnf_net {
@@ -553,6 +557,90 @@ static unsigned int br_nf_pre_routing(void *priv,
 	return NF_STOLEN;
 }
 
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+/* conntracks' nf_confirm logic cannot handle cloned skbs referencing
+ * the same nf_conn entry, which will happen for multicast (broadcast)
+ * Frames on bridges.
+ *
+ * Example:
+ *      macvlan0
+ *      br0
+ *  ethX  ethY
+ *
+ * ethX (or Y) receives multicast or broadcast packet containing
+ * an IP packet, not yet in conntrack table.
+ *
+ * 1. skb passes through bridge and fake-ip (br_netfilter)Prerouting.
+ *    -> skb->_nfct now references a unconfirmed entry
+ * 2. skb is broad/mcast packet. bridge now passes clones out on each bridge
+ *    interface.
+ * 3. skb gets passed up the stack.
+ * 4. In macvlan case, macvlan driver retains clone(s) of the mcast skb
+ *    and schedules a work queue to send them out on the lower devices.
+ *
+ *    The clone skb->_nfct is not a copy, it is the same entry as the
+ *    original skb.  The macvlan rx handler then returns RX_HANDLER_PASS.
+ * 5. Normal conntrack hooks (in NF_INET_LOCAL_IN) confirm the orig skb.
+ *
+ * The Macvlan broadcast worker and normal confirm path will race.
+ *
+ * This race will not happen if step 2 already confirmed a clone. In that
+ * case later steps perform skb_clone() with skb->_nfct already confirmed (in
+ * hash table).  This works fine.
+ *
+ * But such confirmation won't happen when eb/ip/nftables rules dropped the
+ * packets before they reached the nf_confirm step in postrouting.
+ *
+ * Work around this problem by explicit confirmation of the entry at
+ * LOCAL_IN time, before upper layer has a chance to clone the unconfirmed
+ * entry.
+ *
+ */
+static unsigned int br_nf_local_in(void *priv,
+				   struct sk_buff *skb,
+				   const struct nf_hook_state *state)
+{
+	struct nf_conntrack *nfct = skb_nfct(skb);
+	const struct nf_ct_hook *ct_hook;
+	struct nf_conn *ct;
+	int ret;
+
+	if (!nfct || skb->pkt_type == PACKET_HOST)
+		return NF_ACCEPT;
+
+	ct = container_of(nfct, struct nf_conn, ct_general);
+	if (likely(nf_ct_is_confirmed(ct)))
+		return NF_ACCEPT;
+
+	WARN_ON_ONCE(skb_shared(skb));
+	WARN_ON_ONCE(refcount_read(&nfct->use) != 1);
+
+	/* We can't call nf_confirm here, it would create a dependency
+	 * on nf_conntrack module.
+	 */
+	ct_hook = rcu_dereference(nf_ct_hook);
+	if (!ct_hook) {
+		skb->_nfct = 0ul;
+		nf_conntrack_put(nfct);
+		return NF_ACCEPT;
+	}
+
+	nf_bridge_pull_encap_header(skb);
+	ret = ct_hook->confirm(skb);
+	switch (ret & NF_VERDICT_MASK) {
+	case NF_STOLEN:
+		return NF_STOLEN;
+	default:
+		nf_bridge_push_encap_header(skb);
+		break;
+	}
+
+	ct = container_of(nfct, struct nf_conn, ct_general);
+	WARN_ON_ONCE(!nf_ct_is_confirmed(ct));
+
+	return ret;
+}
+#endif
 
 /* PF_BRIDGE/FORWARD *************************************************/
 static int br_nf_forward_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
@@ -964,6 +1052,14 @@ static const struct nf_hook_ops br_nf_ops[] = {
 		.hooknum = NF_BR_PRE_ROUTING,
 		.priority = NF_BR_PRI_BRNF,
 	},
+#if IS_ENABLED(CONFIG_NF_CONNTRACK)
+	{
+		.hook = br_nf_local_in,
+		.pf = NFPROTO_BRIDGE,
+		.hooknum = NF_BR_LOCAL_IN,
+		.priority = NF_BR_PRI_LAST,
+	},
+#endif
 	{
 		.hook = br_nf_forward,
 		.pf = NFPROTO_BRIDGE,
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index abb090f94ed2..6f877e31709b 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -291,6 +291,30 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 	return nf_conntrack_in(skb, &bridge_state);
 }
 
+static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
+				    const struct nf_hook_state *state)
+{
+	enum ip_conntrack_info ctinfo;
+	struct nf_conn *ct;
+
+	if (skb->pkt_type == PACKET_HOST)
+		return NF_ACCEPT;
+
+	/* nf_conntrack_confirm() cannot handle concurrent clones,
+	 * this happens for broad/multicast frames with e.g. macvlan on top
+	 * of the bridge device.
+	 */
+	ct = nf_ct_get(skb, &ctinfo);
+	if (!ct || nf_ct_is_confirmed(ct) || nf_ct_is_template(ct))
+		return NF_ACCEPT;
+
+	/* let inet prerouting call conntrack again */
+	skb->_nfct = 0;
+	nf_ct_put(ct);
+
+	return NF_ACCEPT;
+}
+
 static void nf_ct_bridge_frag_save(struct sk_buff *skb,
 				   struct nf_bridge_frag_data *data)
 {
@@ -385,6 +409,12 @@ static struct nf_hook_ops nf_ct_bridge_hook_ops[] __read_mostly = {
 		.hooknum	= NF_BR_PRE_ROUTING,
 		.priority	= NF_IP_PRI_CONNTRACK,
 	},
+	{
+		.hook		= nf_ct_bridge_in,
+		.pf		= NFPROTO_BRIDGE,
+		.hooknum	= NF_BR_LOCAL_IN,
+		.priority	= NF_IP_PRI_CONNTRACK_CONFIRM,
+	},
 	{
 		.hook		= nf_ct_bridge_post,
 		.pf		= NFPROTO_BRIDGE,
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 2e5f3864d353..5b876fa7f9af 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2756,6 +2756,7 @@ static const struct nf_ct_hook nf_conntrack_hook = {
 	.get_tuple_skb  = nf_conntrack_get_tuple_skb,
 	.attach		= nf_conntrack_attach,
 	.set_closing	= nf_conntrack_set_closing,
+	.confirm	= __nf_conntrack_confirm,
 };
 
 void nf_conntrack_init_end(void)
-- 
2.43.0


