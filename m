Return-Path: <netfilter-devel+bounces-1069-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85C485D6F3
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Feb 2024 12:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DF41C22DE6
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Feb 2024 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204B246B8B;
	Wed, 21 Feb 2024 11:30:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C3F4596E;
	Wed, 21 Feb 2024 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515027; cv=none; b=u7UA8g5Vljt7ERQUFrSEtEgThbxt1a9U3YBWgYWlhHFpe+PPCHXCm/pHJNXfOy+p/sg7F2cKzYvtIHSRbe7Ezajgk21lIpR7AGkgb/MSmMfoHcEc3ZxAGryiwpFNJUP+SCrZ1krTcKCLhmEYSGoFDPzy9Pws6Nre5QiJlXixQ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515027; c=relaxed/simple;
	bh=94Mxvnna4qsjj5XckeQn2gZ3quN6puUPOeMf2rLtbtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3gNi+6UJKB1JpL3hKbq1rFOkcgKax37jmm1z7FH5IRRIVNHYY8ubeErXXJgswWto0fW3IjwNdaaHK+ZobgfgM0vfSK4Iwoodi9gc5SHzBSF97N4biFfj8BjSIkDm8tdV6cHTnY3lZOYdtGGV5W2eU7gREjhMZEhlOl2rbL+ApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rcknq-0003vA-OG; Wed, 21 Feb 2024 12:30:18 +0100
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net-next 11/12] netfilter: move nf_reinject into nfnetlink_queue modules
Date: Wed, 21 Feb 2024 12:26:13 +0100
Message-ID: <20240221112637.5396-12-fw@strlen.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221112637.5396-1-fw@strlen.de>
References: <20240221112637.5396-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need to keep this in the core, move it to the nfnetlink_queue module.
nf_reroute is moved too, there were no other callers.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter.h        |   1 -
 include/net/netfilter/nf_queue.h |   1 -
 net/netfilter/nf_queue.c         | 106 -----------------------
 net/netfilter/nfnetlink_queue.c  | 142 +++++++++++++++++++++++++++++++
 net/netfilter/utils.c            |  37 --------
 5 files changed, 142 insertions(+), 145 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 80900d910992..ffb5e0297eb5 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -370,7 +370,6 @@ __sum16 nf_checksum_partial(struct sk_buff *skb, unsigned int hook,
 			    u_int8_t protocol, unsigned short family);
 int nf_route(struct net *net, struct dst_entry **dst, struct flowi *fl,
 	     bool strict, unsigned short family);
-int nf_reroute(struct sk_buff *skb, struct nf_queue_entry *entry);
 
 #include <net/flow.h>
 
diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index c81021ab07aa..4aeffddb7586 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -35,7 +35,6 @@ struct nf_queue_handler {
 
 void nf_register_queue_handler(const struct nf_queue_handler *qh);
 void nf_unregister_queue_handler(void);
-void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict);
 
 bool nf_queue_entry_get_refs(struct nf_queue_entry *entry);
 void nf_queue_entry_free(struct nf_queue_entry *entry);
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index e2f334f70281..7f12e56e6e52 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -248,109 +248,3 @@ int nf_queue(struct sk_buff *skb, struct nf_hook_state *state,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nf_queue);
-
-static unsigned int nf_iterate(struct sk_buff *skb,
-			       struct nf_hook_state *state,
-			       const struct nf_hook_entries *hooks,
-			       unsigned int *index)
-{
-	const struct nf_hook_entry *hook;
-	unsigned int verdict, i = *index;
-
-	while (i < hooks->num_hook_entries) {
-		hook = &hooks->hooks[i];
-repeat:
-		verdict = nf_hook_entry_hookfn(hook, skb, state);
-		if (verdict != NF_ACCEPT) {
-			*index = i;
-			if (verdict != NF_REPEAT)
-				return verdict;
-			goto repeat;
-		}
-		i++;
-	}
-
-	*index = i;
-	return NF_ACCEPT;
-}
-
-static struct nf_hook_entries *nf_hook_entries_head(const struct net *net, u8 pf, u8 hooknum)
-{
-	switch (pf) {
-#ifdef CONFIG_NETFILTER_FAMILY_BRIDGE
-	case NFPROTO_BRIDGE:
-		return rcu_dereference(net->nf.hooks_bridge[hooknum]);
-#endif
-	case NFPROTO_IPV4:
-		return rcu_dereference(net->nf.hooks_ipv4[hooknum]);
-	case NFPROTO_IPV6:
-		return rcu_dereference(net->nf.hooks_ipv6[hooknum]);
-	default:
-		WARN_ON_ONCE(1);
-		return NULL;
-	}
-
-	return NULL;
-}
-
-/* Caller must hold rcu read-side lock */
-void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
-{
-	const struct nf_hook_entry *hook_entry;
-	const struct nf_hook_entries *hooks;
-	struct sk_buff *skb = entry->skb;
-	const struct net *net;
-	unsigned int i;
-	int err;
-	u8 pf;
-
-	net = entry->state.net;
-	pf = entry->state.pf;
-
-	hooks = nf_hook_entries_head(net, pf, entry->state.hook);
-
-	i = entry->hook_index;
-	if (WARN_ON_ONCE(!hooks || i >= hooks->num_hook_entries)) {
-		kfree_skb(skb);
-		nf_queue_entry_free(entry);
-		return;
-	}
-
-	hook_entry = &hooks->hooks[i];
-
-	/* Continue traversal iff userspace said ok... */
-	if (verdict == NF_REPEAT)
-		verdict = nf_hook_entry_hookfn(hook_entry, skb, &entry->state);
-
-	if (verdict == NF_ACCEPT) {
-		if (nf_reroute(skb, entry) < 0)
-			verdict = NF_DROP;
-	}
-
-	if (verdict == NF_ACCEPT) {
-next_hook:
-		++i;
-		verdict = nf_iterate(skb, &entry->state, hooks, &i);
-	}
-
-	switch (verdict & NF_VERDICT_MASK) {
-	case NF_ACCEPT:
-	case NF_STOP:
-		local_bh_disable();
-		entry->state.okfn(entry->state.net, entry->state.sk, skb);
-		local_bh_enable();
-		break;
-	case NF_QUEUE:
-		err = nf_queue(skb, &entry->state, i, verdict);
-		if (err == 1)
-			goto next_hook;
-		break;
-	case NF_STOLEN:
-		break;
-	default:
-		kfree_skb(skb);
-	}
-
-	nf_queue_entry_free(entry);
-}
-EXPORT_SYMBOL(nf_reinject);
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 5cf38fc0a366..00f4bd21c59b 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -225,6 +225,148 @@ find_dequeue_entry(struct nfqnl_instance *queue, unsigned int id)
 	return entry;
 }
 
+static unsigned int nf_iterate(struct sk_buff *skb,
+			       struct nf_hook_state *state,
+			       const struct nf_hook_entries *hooks,
+			       unsigned int *index)
+{
+	const struct nf_hook_entry *hook;
+	unsigned int verdict, i = *index;
+
+	while (i < hooks->num_hook_entries) {
+		hook = &hooks->hooks[i];
+repeat:
+		verdict = nf_hook_entry_hookfn(hook, skb, state);
+		if (verdict != NF_ACCEPT) {
+			*index = i;
+			if (verdict != NF_REPEAT)
+				return verdict;
+			goto repeat;
+		}
+		i++;
+	}
+
+	*index = i;
+	return NF_ACCEPT;
+}
+
+static struct nf_hook_entries *nf_hook_entries_head(const struct net *net, u8 pf, u8 hooknum)
+{
+	switch (pf) {
+#ifdef CONFIG_NETFILTER_FAMILY_BRIDGE
+	case NFPROTO_BRIDGE:
+		return rcu_dereference(net->nf.hooks_bridge[hooknum]);
+#endif
+	case NFPROTO_IPV4:
+		return rcu_dereference(net->nf.hooks_ipv4[hooknum]);
+	case NFPROTO_IPV6:
+		return rcu_dereference(net->nf.hooks_ipv6[hooknum]);
+	default:
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
+
+	return NULL;
+}
+
+static int nf_ip_reroute(struct sk_buff *skb, const struct nf_queue_entry *entry)
+{
+#ifdef CONFIG_INET
+	const struct ip_rt_info *rt_info = nf_queue_entry_reroute(entry);
+
+	if (entry->state.hook == NF_INET_LOCAL_OUT) {
+		const struct iphdr *iph = ip_hdr(skb);
+
+		if (!(iph->tos == rt_info->tos &&
+		      skb->mark == rt_info->mark &&
+		      iph->daddr == rt_info->daddr &&
+		      iph->saddr == rt_info->saddr))
+			return ip_route_me_harder(entry->state.net, entry->state.sk,
+						  skb, RTN_UNSPEC);
+	}
+#endif
+	return 0;
+}
+
+static int nf_reroute(struct sk_buff *skb, struct nf_queue_entry *entry)
+{
+	const struct nf_ipv6_ops *v6ops;
+	int ret = 0;
+
+	switch (entry->state.pf) {
+	case AF_INET:
+		ret = nf_ip_reroute(skb, entry);
+		break;
+	case AF_INET6:
+		v6ops = rcu_dereference(nf_ipv6_ops);
+		if (v6ops)
+			ret = v6ops->reroute(skb, entry);
+		break;
+	}
+	return ret;
+}
+
+/* caller must hold rcu read-side lock */
+static void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
+{
+	const struct nf_hook_entry *hook_entry;
+	const struct nf_hook_entries *hooks;
+	struct sk_buff *skb = entry->skb;
+	const struct net *net;
+	unsigned int i;
+	int err;
+	u8 pf;
+
+	net = entry->state.net;
+	pf = entry->state.pf;
+
+	hooks = nf_hook_entries_head(net, pf, entry->state.hook);
+
+	i = entry->hook_index;
+	if (WARN_ON_ONCE(!hooks || i >= hooks->num_hook_entries)) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_NETFILTER_DROP);
+		nf_queue_entry_free(entry);
+		return;
+	}
+
+	hook_entry = &hooks->hooks[i];
+
+	/* Continue traversal iff userspace said ok... */
+	if (verdict == NF_REPEAT)
+		verdict = nf_hook_entry_hookfn(hook_entry, skb, &entry->state);
+
+	if (verdict == NF_ACCEPT) {
+		if (nf_reroute(skb, entry) < 0)
+			verdict = NF_DROP;
+	}
+
+	if (verdict == NF_ACCEPT) {
+next_hook:
+		++i;
+		verdict = nf_iterate(skb, &entry->state, hooks, &i);
+	}
+
+	switch (verdict & NF_VERDICT_MASK) {
+	case NF_ACCEPT:
+	case NF_STOP:
+		local_bh_disable();
+		entry->state.okfn(entry->state.net, entry->state.sk, skb);
+		local_bh_enable();
+		break;
+	case NF_QUEUE:
+		err = nf_queue(skb, &entry->state, i, verdict);
+		if (err == 1)
+			goto next_hook;
+		break;
+	case NF_STOLEN:
+		break;
+	default:
+		kfree_skb(skb);
+	}
+
+	nf_queue_entry_free(entry);
+}
+
 static void nfqnl_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 {
 	const struct nf_ct_hook *ct_hook;
diff --git a/net/netfilter/utils.c b/net/netfilter/utils.c
index acef4155f0da..008419db815a 100644
--- a/net/netfilter/utils.c
+++ b/net/netfilter/utils.c
@@ -179,43 +179,6 @@ int nf_route(struct net *net, struct dst_entry **dst, struct flowi *fl,
 }
 EXPORT_SYMBOL_GPL(nf_route);
 
-static int nf_ip_reroute(struct sk_buff *skb, const struct nf_queue_entry *entry)
-{
-#ifdef CONFIG_INET
-	const struct ip_rt_info *rt_info = nf_queue_entry_reroute(entry);
-
-	if (entry->state.hook == NF_INET_LOCAL_OUT) {
-		const struct iphdr *iph = ip_hdr(skb);
-
-		if (!(iph->tos == rt_info->tos &&
-		      skb->mark == rt_info->mark &&
-		      iph->daddr == rt_info->daddr &&
-		      iph->saddr == rt_info->saddr))
-			return ip_route_me_harder(entry->state.net, entry->state.sk,
-						  skb, RTN_UNSPEC);
-	}
-#endif
-	return 0;
-}
-
-int nf_reroute(struct sk_buff *skb, struct nf_queue_entry *entry)
-{
-	const struct nf_ipv6_ops *v6ops;
-	int ret = 0;
-
-	switch (entry->state.pf) {
-	case AF_INET:
-		ret = nf_ip_reroute(skb, entry);
-		break;
-	case AF_INET6:
-		v6ops = rcu_dereference(nf_ipv6_ops);
-		if (v6ops)
-			ret = v6ops->reroute(skb, entry);
-		break;
-	}
-	return ret;
-}
-
 /* Only get and check the lengths, not do any hop-by-hop stuff. */
 int nf_ip6_check_hbh_len(struct sk_buff *skb, u32 *plen)
 {
-- 
2.43.0


