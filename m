Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1DB6B7964
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Mar 2023 14:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCMNrG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Mar 2023 09:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjCMNrE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:47:04 -0400
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918E658C12
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Mar 2023 06:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=k6UftfULumyNXmzqwfsEJbKGbjFYRxG7N1hMZy7L7v0=; b=MhzbVHcM5iCts+eY9bUsChuobq
        2YQ+oD3P3JP40SU8d3fOM/XV7bkRgYbnAC1NAnjziyn5Q+QmQlsLmgzd2QEcqyNuIEXwRRCvqqiFS
        AIu1wIAfezO687vzErcNCvDMpdwGfwhow4nE3UR8u1d1DwV4so/WP1FP85jIgLUgNtyYNkq1lkMXU
        /X4OlqviW3B2hDWI0uXqkhuE/fMV7oEqYwTFEp2TeAlnQI2tP91m4/oag9zUst8UPYCTwQg1QAP1x
        s09o/kEoqNseh2OvOZgTo/rsw5JHs5MSaMsgyICEGpF3y9fCwPQlzengcKYApDtBd7tY0uLpLLB27
        puvWHPTA==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1pbiVo-006qSf-K4; Mon, 13 Mar 2023 13:46:52 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 3/3] netfilter: nft_redir: deduplicate eval call-backs
Date:   Mon, 13 Mar 2023 13:46:49 +0000
Message-Id: <20230313134649.186812-4-jeremy@azazel.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313134649.186812-1-jeremy@azazel.net>
References: <20230313134649.186812-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

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
 net/netfilter/nft_redir.c | 81 ++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 52 deletions(-)

diff --git a/net/netfilter/nft_redir.c b/net/netfilter/nft_redir.c
index 77a459470cb7..1d52a05a8b03 100644
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
@@ -99,26 +101,37 @@ static int nft_redir_dump(struct sk_buff *skb,
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
+	const struct nft_redir *priv = nft_expr_priv(expr);
 	struct nf_nat_range2 range;
 
 	memset(&range, 0, sizeof(range));
+	range.flags = priv->flags;
 	if (priv->sreg_proto_min) {
-		range.min_proto.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_min]);
-		range.max_proto.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_max]);
-		range.flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
+		range.min_proto.all = (__force __be16)
+			nft_reg_load16(&regs->data[priv->sreg_proto_min]);
+		range.max_proto.all = (__force __be16)
+			nft_reg_load16(&regs->data[priv->sreg_proto_max]);
 	}
 
-	range.flags |= priv->flags;
-
-	regs->verdict.code =
-		nf_nat_redirect_ipv4(pkt->skb, &range, nft_hook(pkt));
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
@@ -131,7 +144,7 @@ static struct nft_expr_type nft_redir_ipv4_type;
 static const struct nft_expr_ops nft_redir_ipv4_ops = {
 	.type		= &nft_redir_ipv4_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_redir)),
-	.eval		= nft_redir_ipv4_eval,
+	.eval		= nft_redir_eval,
 	.init		= nft_redir_init,
 	.destroy	= nft_redir_ipv4_destroy,
 	.dump		= nft_redir_dump,
@@ -149,28 +162,6 @@ static struct nft_expr_type nft_redir_ipv4_type __read_mostly = {
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
@@ -181,7 +172,7 @@ static struct nft_expr_type nft_redir_ipv6_type;
 static const struct nft_expr_ops nft_redir_ipv6_ops = {
 	.type		= &nft_redir_ipv6_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_redir)),
-	.eval		= nft_redir_ipv6_eval,
+	.eval		= nft_redir_eval,
 	.init		= nft_redir_init,
 	.destroy	= nft_redir_ipv6_destroy,
 	.dump		= nft_redir_dump,
@@ -200,20 +191,6 @@ static struct nft_expr_type nft_redir_ipv6_type __read_mostly = {
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
@@ -224,7 +201,7 @@ static struct nft_expr_type nft_redir_inet_type;
 static const struct nft_expr_ops nft_redir_inet_ops = {
 	.type		= &nft_redir_inet_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_redir)),
-	.eval		= nft_redir_inet_eval,
+	.eval		= nft_redir_eval,
 	.init		= nft_redir_init,
 	.destroy	= nft_redir_inet_destroy,
 	.dump		= nft_redir_dump,
-- 
2.39.2

