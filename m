Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358226BBF61
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Mar 2023 22:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjCOVsM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Mar 2023 17:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjCOVsK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:48:10 -0400
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18DB497EF
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Mar 2023 14:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tVtQkzG28I96RgcnUE7pFLQXMTeZBMGsuKkQhI9uU9k=; b=W8PiaDRZQp60NXxrB4Ulk6VXPr
        tUB6rw2AGtNL9Da4X4VMqJCDAIeezG3DsV5Y/tVbwSmlqbFTbjIwC8Lb8oURftw/JsGkIh2Wvp0Ds
        fzKESUDUGA3OlhNs1hvtfiOazeGnjgy3RPlbMvv5s/dxeEskmYtn8DBXOn+kB3pnCqDlQADUJFtyM
        Nbn8/AmoFoZpyBxD8Fa8rjXzLx8valHD3RqaR1wdPXPmv6HyPXLkGAIIePdua7uwa7yTZmHx/8hsF
        jWPk9lr58cRHDi2DzSVQf+zdhFV8TJGij0LAAjtwMrjQ1OPYKhPnD6IGIu0f1Ga8sKl8Q4LPB/Wj8
        YJfTs78w==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1pcYyc-009sxd-U3; Wed, 15 Mar 2023 21:48:07 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v2 1/2] netfilter: nft_redir: use `struct nf_nat_range2` throughout and deduplicate eval call-backs
Date:   Wed, 15 Mar 2023 21:48:01 +0000
Message-Id: <20230315214802.236464-3-jeremy@azazel.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315214802.236464-1-jeremy@azazel.net>
References: <20230315214802.236464-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

`nf_nat_redirect_ipv4` takes a `struct nf_nat_ipv4_multi_range_compat`,
but converts it internally to a `struct nf_nat_range2`.  Change the
function to take the latter, factor out the code now shared with
`nf_nat_redirect_ipv6`, move the conversion to the xt_REDIRECT module,
and update the ipv4 range initialization in the nft_redir module.

Replace a bare hex constant for 127.0.0.1 with a macro.

Remove `WARN_ON`.  `nf_nat_setup_info` calls `nf_ct_is_confirmed`:

	/* Can't setup nat info for confirmed ct. */
	if (nf_ct_is_confirmed(ct))
		return NF_ACCEPT;

This means that `ct` cannot be null or the kernel will crash, and
implies that `ctinfo` is `IP_CT_NEW` or `IP_CT_RELATED`.

nft_redir has separate ipv4 and ipv6 call-backs which share much of
their code, and an inet one switch containing a switch that calls one of
the others based on the family of the packet.  Merge the ipv4 and ipv6
ones into the inet one in order to get rid of the duplicate code.

Const-qualify the `priv` pointer since we don't need to write through
it.

Assign `priv->flags` to the range instead of OR-ing it in.

Set the `NF_NAT_RANGE_PROTO_SPECIFIED` flag once during init, rather
than on every eval.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Reviewed-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_nat_redirect.h |  3 +-
 net/netfilter/nf_nat_redirect.c         | 71 ++++++++++-----------
 net/netfilter/nft_redir.c               | 84 +++++++++----------------
 net/netfilter/xt_REDIRECT.c             | 10 ++-
 4 files changed, 72 insertions(+), 96 deletions(-)

diff --git a/include/net/netfilter/nf_nat_redirect.h b/include/net/netfilter/nf_nat_redirect.h
index 2418653a66db..279380de904c 100644
--- a/include/net/netfilter/nf_nat_redirect.h
+++ b/include/net/netfilter/nf_nat_redirect.h
@@ -6,8 +6,7 @@
 #include <uapi/linux/netfilter/nf_nat.h>
 
 unsigned int
-nf_nat_redirect_ipv4(struct sk_buff *skb,
-		     const struct nf_nat_ipv4_multi_range_compat *mr,
+nf_nat_redirect_ipv4(struct sk_buff *skb, const struct nf_nat_range2 *range,
 		     unsigned int hooknum);
 unsigned int
 nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
diff --git a/net/netfilter/nf_nat_redirect.c b/net/netfilter/nf_nat_redirect.c
index f91579c821e9..6616ba5d0b04 100644
--- a/net/netfilter/nf_nat_redirect.c
+++ b/net/netfilter/nf_nat_redirect.c
@@ -10,6 +10,7 @@
 
 #include <linux/if.h>
 #include <linux/inetdevice.h>
+#include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
@@ -24,54 +25,56 @@
 #include <net/netfilter/nf_nat.h>
 #include <net/netfilter/nf_nat_redirect.h>
 
+static unsigned int
+nf_nat_redirect(struct sk_buff *skb, const struct nf_nat_range2 *range,
+		const union nf_inet_addr *newdst)
+{
+	struct nf_nat_range2 newrange;
+	enum ip_conntrack_info ctinfo;
+	struct nf_conn *ct;
+
+	ct = nf_ct_get(skb, &ctinfo);
+
+	memset(&newrange, 0, sizeof(newrange));
+
+	newrange.flags		= range->flags | NF_NAT_RANGE_MAP_IPS;
+	newrange.min_addr	= *newdst;
+	newrange.max_addr	= *newdst;
+	newrange.min_proto	= range->min_proto;
+	newrange.max_proto	= range->max_proto;
+
+	return nf_nat_setup_info(ct, &newrange, NF_NAT_MANIP_DST);
+}
+
 unsigned int
-nf_nat_redirect_ipv4(struct sk_buff *skb,
-		     const struct nf_nat_ipv4_multi_range_compat *mr,
+nf_nat_redirect_ipv4(struct sk_buff *skb, const struct nf_nat_range2 *range,
 		     unsigned int hooknum)
 {
-	struct nf_conn *ct;
-	enum ip_conntrack_info ctinfo;
-	__be32 newdst;
-	struct nf_nat_range2 newrange;
+	union nf_inet_addr newdst = {};
 
 	WARN_ON(hooknum != NF_INET_PRE_ROUTING &&
 		hooknum != NF_INET_LOCAL_OUT);
 
-	ct = nf_ct_get(skb, &ctinfo);
-	WARN_ON(!(ct && (ctinfo == IP_CT_NEW || ctinfo == IP_CT_RELATED)));
-
 	/* Local packets: make them go to loopback */
 	if (hooknum == NF_INET_LOCAL_OUT) {
-		newdst = htonl(0x7F000001);
+		newdst.ip = htonl(INADDR_LOOPBACK);
 	} else {
 		const struct in_device *indev;
 
-		newdst = 0;
-
 		indev = __in_dev_get_rcu(skb->dev);
 		if (indev) {
 			const struct in_ifaddr *ifa;
 
 			ifa = rcu_dereference(indev->ifa_list);
 			if (ifa)
-				newdst = ifa->ifa_local;
+				newdst.ip = ifa->ifa_local;
 		}
 
-		if (!newdst)
+		if (!newdst.ip)
 			return NF_DROP;
 	}
 
-	/* Transfer from original range. */
-	memset(&newrange.min_addr, 0, sizeof(newrange.min_addr));
-	memset(&newrange.max_addr, 0, sizeof(newrange.max_addr));
-	newrange.flags	     = mr->range[0].flags | NF_NAT_RANGE_MAP_IPS;
-	newrange.min_addr.ip = newdst;
-	newrange.max_addr.ip = newdst;
-	newrange.min_proto   = mr->range[0].min;
-	newrange.max_proto   = mr->range[0].max;
-
-	/* Hand modified range to generic setup. */
-	return nf_nat_setup_info(ct, &newrange, NF_NAT_MANIP_DST);
+	return nf_nat_redirect(skb, range, &newdst);
 }
 EXPORT_SYMBOL_GPL(nf_nat_redirect_ipv4);
 
@@ -81,14 +84,10 @@ unsigned int
 nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
 		     unsigned int hooknum)
 {
-	struct nf_nat_range2 newrange;
-	struct in6_addr newdst;
-	enum ip_conntrack_info ctinfo;
-	struct nf_conn *ct;
+	union nf_inet_addr newdst = {};
 
-	ct = nf_ct_get(skb, &ctinfo);
 	if (hooknum == NF_INET_LOCAL_OUT) {
-		newdst = loopback_addr;
+		newdst.in6 = loopback_addr;
 	} else {
 		struct inet6_dev *idev;
 		struct inet6_ifaddr *ifa;
@@ -98,7 +97,7 @@ nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
 		if (idev != NULL) {
 			read_lock_bh(&idev->lock);
 			list_for_each_entry(ifa, &idev->addr_list, if_list) {
-				newdst = ifa->addr;
+				newdst.in6 = ifa->addr;
 				addr = true;
 				break;
 			}
@@ -109,12 +108,6 @@ nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
 			return NF_DROP;
 	}
 
-	newrange.flags		= range->flags | NF_NAT_RANGE_MAP_IPS;
-	newrange.min_addr.in6	= newdst;
-	newrange.max_addr.in6	= newdst;
-	newrange.min_proto	= range->min_proto;
-	newrange.max_proto	= range->max_proto;
-
-	return nf_nat_setup_info(ct, &newrange, NF_NAT_MANIP_DST);
+	return nf_nat_redirect(skb, range, &newdst);
 }
 EXPORT_SYMBOL_GPL(nf_nat_redirect_ipv6);
diff --git a/net/netfilter/nft_redir.c b/net/netfilter/nft_redir.c
index 5f7739987559..1d52a05a8b03 100644
--- a/net/netfilter/nft_redir.c
+++ b/net/netfilter/nft_redir.c
@@ -64,6 +64,8 @@ static int nft_redir_init(const struct nft_ctx *ctx,
 		} else {
 			priv->sreg_proto_max = priv->sreg_proto_min;
 		}
+
+		priv->flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
 	}
 
 	if (tb[NFTA_REDIR_FLAGS]) {
@@ -99,25 +101,37 @@ static int nft_redir_dump(struct sk_buff *skb,
 	return -1;
 }
 
-static void nft_redir_ipv4_eval(const struct nft_expr *expr,
-				struct nft_regs *regs,
-				const struct nft_pktinfo *pkt)
+static void nft_redir_eval(const struct nft_expr *expr,
+			   struct nft_regs *regs,
+			   const struct nft_pktinfo *pkt)
 {
-	struct nft_redir *priv = nft_expr_priv(expr);
-	struct nf_nat_ipv4_multi_range_compat mr;
+	const struct nft_redir *priv = nft_expr_priv(expr);
+	struct nf_nat_range2 range;
 
-	memset(&mr, 0, sizeof(mr));
+	memset(&range, 0, sizeof(range));
+	range.flags = priv->flags;
 	if (priv->sreg_proto_min) {
-		mr.range[0].min.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_min]);
-		mr.range[0].max.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_max]);
-		mr.range[0].flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
+		range.min_proto.all = (__force __be16)
+			nft_reg_load16(&regs->data[priv->sreg_proto_min]);
+		range.max_proto.all = (__force __be16)
+			nft_reg_load16(&regs->data[priv->sreg_proto_max]);
 	}
 
-	mr.range[0].flags |= priv->flags;
-
-	regs->verdict.code = nf_nat_redirect_ipv4(pkt->skb, &mr, nft_hook(pkt));
+	switch (nft_pf(pkt)) {
+	case NFPROTO_IPV4:
+		regs->verdict.code = nf_nat_redirect_ipv4(pkt->skb, &range,
+							  nft_hook(pkt));
+		break;
+#ifdef CONFIG_NF_TABLES_IPV6
+	case NFPROTO_IPV6:
+		regs->verdict.code = nf_nat_redirect_ipv6(pkt->skb, &range,
+							  nft_hook(pkt));
+		break;
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
 }
 
 static void
@@ -130,7 +144,7 @@ static struct nft_expr_type nft_redir_ipv4_type;
 static const struct nft_expr_ops nft_redir_ipv4_ops = {
 	.type		= &nft_redir_ipv4_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_redir)),
-	.eval		= nft_redir_ipv4_eval,
+	.eval		= nft_redir_eval,
 	.init		= nft_redir_init,
 	.destroy	= nft_redir_ipv4_destroy,
 	.dump		= nft_redir_dump,
@@ -148,28 +162,6 @@ static struct nft_expr_type nft_redir_ipv4_type __read_mostly = {
 };
 
 #ifdef CONFIG_NF_TABLES_IPV6
-static void nft_redir_ipv6_eval(const struct nft_expr *expr,
-				struct nft_regs *regs,
-				const struct nft_pktinfo *pkt)
-{
-	struct nft_redir *priv = nft_expr_priv(expr);
-	struct nf_nat_range2 range;
-
-	memset(&range, 0, sizeof(range));
-	if (priv->sreg_proto_min) {
-		range.min_proto.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_min]);
-		range.max_proto.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_max]);
-		range.flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
-	}
-
-	range.flags |= priv->flags;
-
-	regs->verdict.code =
-		nf_nat_redirect_ipv6(pkt->skb, &range, nft_hook(pkt));
-}
-
 static void
 nft_redir_ipv6_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
 {
@@ -180,7 +172,7 @@ static struct nft_expr_type nft_redir_ipv6_type;
 static const struct nft_expr_ops nft_redir_ipv6_ops = {
 	.type		= &nft_redir_ipv6_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_redir)),
-	.eval		= nft_redir_ipv6_eval,
+	.eval		= nft_redir_eval,
 	.init		= nft_redir_init,
 	.destroy	= nft_redir_ipv6_destroy,
 	.dump		= nft_redir_dump,
@@ -199,20 +191,6 @@ static struct nft_expr_type nft_redir_ipv6_type __read_mostly = {
 #endif
 
 #ifdef CONFIG_NF_TABLES_INET
-static void nft_redir_inet_eval(const struct nft_expr *expr,
-				struct nft_regs *regs,
-				const struct nft_pktinfo *pkt)
-{
-	switch (nft_pf(pkt)) {
-	case NFPROTO_IPV4:
-		return nft_redir_ipv4_eval(expr, regs, pkt);
-	case NFPROTO_IPV6:
-		return nft_redir_ipv6_eval(expr, regs, pkt);
-	}
-
-	WARN_ON_ONCE(1);
-}
-
 static void
 nft_redir_inet_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
 {
@@ -223,7 +201,7 @@ static struct nft_expr_type nft_redir_inet_type;
 static const struct nft_expr_ops nft_redir_inet_ops = {
 	.type		= &nft_redir_inet_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_redir)),
-	.eval		= nft_redir_inet_eval,
+	.eval		= nft_redir_eval,
 	.init		= nft_redir_init,
 	.destroy	= nft_redir_inet_destroy,
 	.dump		= nft_redir_dump,
diff --git a/net/netfilter/xt_REDIRECT.c b/net/netfilter/xt_REDIRECT.c
index 353ca7801251..ff66b56a3f97 100644
--- a/net/netfilter/xt_REDIRECT.c
+++ b/net/netfilter/xt_REDIRECT.c
@@ -46,7 +46,6 @@ static void redirect_tg_destroy(const struct xt_tgdtor_param *par)
 	nf_ct_netns_put(par->net, par->family);
 }
 
-/* FIXME: Take multiple ranges --RR */
 static int redirect_tg4_check(const struct xt_tgchk_param *par)
 {
 	const struct nf_nat_ipv4_multi_range_compat *mr = par->targinfo;
@@ -65,7 +64,14 @@ static int redirect_tg4_check(const struct xt_tgchk_param *par)
 static unsigned int
 redirect_tg4(struct sk_buff *skb, const struct xt_action_param *par)
 {
-	return nf_nat_redirect_ipv4(skb, par->targinfo, xt_hooknum(par));
+	const struct nf_nat_ipv4_multi_range_compat *mr = par->targinfo;
+	struct nf_nat_range2 range = {
+		.flags       = mr->range[0].flags,
+		.min_proto   = mr->range[0].min,
+		.max_proto   = mr->range[0].max,
+	};
+
+	return nf_nat_redirect_ipv4(skb, &range, xt_hooknum(par));
 }
 
 static struct xt_target redirect_tg_reg[] __read_mostly = {
-- 
2.39.2

