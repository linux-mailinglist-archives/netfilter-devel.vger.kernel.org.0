Return-Path: <netfilter-devel+bounces-13000-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X486BMv5HmpebQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13000-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 02 Jun 2026 17:42:03 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D8262FE4D
	for <lists+netfilter-devel@lfdr.de>; Tue, 02 Jun 2026 17:41:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13000-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13000-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46CF830EC92B
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Jun 2026 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3DA3CF04F;
	Tue,  2 Jun 2026 15:04:39 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664923E022A
	for <netfilter-devel@vger.kernel.org>; Tue,  2 Jun 2026 15:04:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412679; cv=none; b=cSrcphcDv73UbLarm5KZB0LsBcuQp5L+pQJzqBNrSI3DzKyXHJ6r1oxQ4NyjnJjbO4IJTIKZOx3Q6Mluaf19t8MXFjO1NEGDP86qO0995U+6NoZmE54kf9A5TKif3i6EopyMNxclAXj34Dyx4Y9VolKNRNVKgyEnFb8jxBMgyIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412679; c=relaxed/simple;
	bh=036CHtRbDar5B7fzaGT2QuwAvBl41twEoGJn3XGH6uI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZV9yOcDhI9meuF0PIceFDQkXs8lJ2LzVXCtiDAP0E2ALOgCs4W1kUgPfrBNqCfLbJq+bqkQRuBNtMeHeX2OwLZGY1an6syO595C2wnsAFextz1TheleMOPqyahVf8sKIo4aTNQPARTpF+L6nBTKwzXVI22RbcAM8gya1+BZoCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0C02F60337; Tue, 02 Jun 2026 17:04:35 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Subject: [PATCH nf] netfilter: nf_queue: reinject must revalidate bridge ports
Date: Tue,  2 Jun 2026 17:04:25 +0200
Message-ID: <20260602150428.5302-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13000-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[strlen.de,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,m:eilaimemedsnaimel@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20D8262FE4D

ebt_redirect_tg() dereferences br_port_get_rcu() return without a
NULL check, causing a kernel panic when the bridge port has been
removed between the original hook invocation and an NFQUEUE
reinject.

A mere NULL check isn't sufficient, however.  As sashiko review
points out userspace can not only remove the port from the bridge,
it could also place the device in a different virtual device, e.g.
macvlan.

If this happens, we must drop the packet, there is no way for us to
reinject it into the bridge path.

Switch to _upper API, we don't need the bridge port structure.
Also, this fix keeps another bug intact:

Both nfnetlink_log and nfnetlink_queue use CONFIG_BRIDGE_NETFILTER
too aggressive, which prevents certain logging features when queueing
in bridge family: NETFILTER_FAMILY_BRIDGE can be enabled while the old
CONFIG_BRIDGE_NETFILTER cruft is off.

Fixes tag is a common ancestor, this was always broken.

Fixes: f350a0a87374 ("bridge: use rx_handler_data pointer to store net_bridge_port pointer")
Reported-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/bridge/netfilter/ebt_dnat.c     |  4 +-
 net/bridge/netfilter/ebt_redirect.c | 16 +++++---
 net/netfilter/nfnetlink_log.c       | 23 +++++++++--
 net/netfilter/nfnetlink_queue.c     | 64 +++++++++++++++++++++++++----
 4 files changed, 89 insertions(+), 18 deletions(-)

diff --git a/net/bridge/netfilter/ebt_dnat.c b/net/bridge/netfilter/ebt_dnat.c
index 3fda71a8579d..73f185cccd63 100644
--- a/net/bridge/netfilter/ebt_dnat.c
+++ b/net/bridge/netfilter/ebt_dnat.c
@@ -39,7 +39,9 @@ ebt_dnat_tg(struct sk_buff *skb, const struct xt_action_param *par)
 			dev = xt_in(par);
 			break;
 		case NF_BR_PRE_ROUTING:
-			dev = br_port_get_rcu(xt_in(par))->br->dev;
+			dev = netdev_master_upper_dev_get_rcu(xt_in(par));
+			if (!dev) /* bridge port removed? */
+				return EBT_DROP;
 			break;
 		default:
 			dev = NULL;
diff --git a/net/bridge/netfilter/ebt_redirect.c b/net/bridge/netfilter/ebt_redirect.c
index 307790562b49..83486cd4d564 100644
--- a/net/bridge/netfilter/ebt_redirect.c
+++ b/net/bridge/netfilter/ebt_redirect.c
@@ -24,12 +24,18 @@ ebt_redirect_tg(struct sk_buff *skb, const struct xt_action_param *par)
 	if (skb_ensure_writable(skb, 0))
 		return EBT_DROP;
 
-	if (xt_hooknum(par) != NF_BR_BROUTING)
-		/* rcu_read_lock()ed by nf_hook_thresh */
-		ether_addr_copy(eth_hdr(skb)->h_dest,
-				br_port_get_rcu(xt_in(par))->br->dev->dev_addr);
-	else
+	if (xt_hooknum(par) != NF_BR_BROUTING) {
+		const struct net_device *dev;
+
+		dev = netdev_master_upper_dev_get_rcu(xt_in(par));
+		if (!dev)
+			return EBT_DROP;
+
+		ether_addr_copy(eth_hdr(skb)->h_dest, dev->dev_addr);
+	} else {
 		ether_addr_copy(eth_hdr(skb)->h_dest, xt_in(par)->dev_addr);
+	}
+
 	skb->pkt_type = PACKET_HOST;
 	return info->target;
 }
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 2439cbbd5b26..fa3657599861 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -451,6 +451,23 @@ static int nfulnl_put_bridge(struct nfulnl_instance *inst, const struct sk_buff
 	return -1;
 }
 
+#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+static int nflog_put_master_ifindex(struct sk_buff *nlskb, int attr,
+				    const struct net_device *dev)
+{
+	const struct net_device *upper;
+
+	if (dev && !netif_is_bridge_port(dev))
+		return 0;
+
+	upper = netdev_master_upper_dev_get_rcu((struct net_device *)dev);
+	if (upper && nla_put_be32(nlskb, attr, htonl(upper->ifindex)))
+		return -EMSGSIZE;
+
+	return 0;
+}
+#endif
+
 /* This is an inline function, we don't really care about a long
  * list of arguments */
 static inline int
@@ -505,8 +522,7 @@ __build_packet_message(struct nfnl_log_net *log,
 			/* rcu_read_lock()ed by nf_hook_thresh or
 			 * nf_log_packet.
 			 */
-			    nla_put_be32(inst->skb, NFULA_IFINDEX_INDEV,
-					 htonl(br_port_get_rcu(indev)->br->dev->ifindex)))
+			    nflog_put_master_ifindex(inst->skb, NFULA_IFINDEX_INDEV, indev))
 				goto nla_put_failure;
 		} else {
 			int physinif;
@@ -542,8 +558,7 @@ __build_packet_message(struct nfnl_log_net *log,
 			/* rcu_read_lock()ed by nf_hook_thresh or
 			 * nf_log_packet.
 			 */
-			    nla_put_be32(inst->skb, NFULA_IFINDEX_OUTDEV,
-					 htonl(br_port_get_rcu(outdev)->br->dev->ifindex)))
+			    nflog_put_master_ifindex(inst->skb, NFULA_IFINDEX_OUTDEV, outdev))
 				goto nla_put_failure;
 		} else {
 			struct net_device *physoutdev;
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 60ab88d45096..c5e29fec419b 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -440,10 +440,47 @@ static bool nf_ct_drop_unconfirmed(const struct nf_queue_entry *entry, bool *is_
 	return false;
 }
 
+static bool nf_bridge_port_valid(const struct net_device *dev)
+{
+	if (!dev)
+		return true;
+
+	return netif_is_bridge_port(dev);
+}
+
+/* queued skbs leave rcu protection.  We bump device refcount so that
+ * the device cannot go away.  However, while packet was out the port
+ * could have been removed from the bridge.
+ *
+ * Ensure in+outdev are still part of a bridge at reinject time.
+ *
+ * The device rx_handler_data could even be pointing at data that is
+ * not a net_bridge_port structure.
+ */
+static bool nf_bridge_ports_valid(const struct nf_queue_entry *entry)
+{
+#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+	if (!nf_bridge_port_valid(entry->physin) ||
+	    !nf_bridge_port_valid(entry->physout))
+		return false;
+#endif
+	if (entry->state.pf != PF_BRIDGE)
+		return true;
+
+	if (!nf_bridge_port_valid(entry->state.in) ||
+	    !nf_bridge_port_valid(entry->state.out))
+		return false;
+
+	return true;
+}
+
 static void nfqnl_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 {
 	const struct nf_ct_hook *ct_hook;
 
+	if (!nf_bridge_ports_valid(entry))
+		verdict = NF_DROP;
+
 	if (verdict == NF_ACCEPT ||
 	    verdict == NF_REPEAT ||
 	    verdict == NF_STOP) {
@@ -636,6 +673,23 @@ static int nf_queue_checksum_help(struct sk_buff *entskb)
 	return skb_checksum_help(entskb);
 }
 
+#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+static int nfqnl_put_master_ifindex(struct sk_buff *nlskb, int attr,
+				    const struct net_device *dev)
+{
+	const struct net_device *upper;
+
+	if (dev && !netif_is_bridge_port(dev))
+		return 0;
+
+	upper = netdev_master_upper_dev_get_rcu((struct net_device *)dev);
+	if (upper && nla_put_be32(nlskb, attr, htonl(upper->ifindex)))
+		return -EMSGSIZE;
+
+	return 0;
+}
+#endif
+
 static struct sk_buff *
 nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 			   struct nf_queue_entry *entry,
@@ -771,10 +825,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 			 * netfilter_bridge) */
 			if (nla_put_be32(skb, NFQA_IFINDEX_PHYSINDEV,
 					 htonl(indev->ifindex)) ||
-			/* this is the bridge group "brX" */
-			/* rcu_read_lock()ed by __nf_queue */
-			    nla_put_be32(skb, NFQA_IFINDEX_INDEV,
-					 htonl(br_port_get_rcu(indev)->br->dev->ifindex)))
+			    nfqnl_put_master_ifindex(skb, NFQA_IFINDEX_INDEV, indev))
 				goto nla_put_failure;
 		} else {
 			int physinif;
@@ -805,10 +856,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 			 * netfilter_bridge) */
 			if (nla_put_be32(skb, NFQA_IFINDEX_PHYSOUTDEV,
 					 htonl(outdev->ifindex)) ||
-			/* this is the bridge group "brX" */
-			/* rcu_read_lock()ed by __nf_queue */
-			    nla_put_be32(skb, NFQA_IFINDEX_OUTDEV,
-					 htonl(br_port_get_rcu(outdev)->br->dev->ifindex)))
+			    nfqnl_put_master_ifindex(skb, NFQA_IFINDEX_OUTDEV, outdev))
 				goto nla_put_failure;
 		} else {
 			int physoutif;
-- 
2.53.0


