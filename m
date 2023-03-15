Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB056BBF5A
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Mar 2023 22:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCOVry (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Mar 2023 17:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjCOVrx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:47:53 -0400
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066A1A2C0B
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Mar 2023 14:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2LYLJq3Ao9tEgEBp/SLKFMNttvRJ0FMt3wbeJ7JsF4Y=; b=lyJibh6LKAZ4YRQZ1rTcD15j+J
        ABvJQN/bx05ujly+IQlkjFsqeLjMKZw/AyLW9sUi6iUcNl54aCN+gbFUhwhTH+lu12kiGc2tYP5dY
        hoF5gG4t1mBGaQsEOnZpPMftJ4gMuVon2/VpKtgIVcPgSxKPTV4dPXXgTH2KS/FoW7+1TARMsOJuk
        x8ZwgchDsz05M1XFbbtM4ap3IWyj86QEe/AJVbL2b+/BqBKjkEW0R7GLCE2Niyk7Pau71oP06qlVM
        YjFL53T/0vxeQORzBJYKarEzMg9ov4LoPyy0g73x0gsE0gmFEOMWRl8fyDT4NTodez795z/aeBZR3
        NUL5FTmA==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1pcYyI-009swn-Oo
        for netfilter-devel@vger.kernel.org; Wed, 15 Mar 2023 21:47:46 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next 2/3] netfilter: nft_masq: deduplicate eval call-backs
Date:   Wed, 15 Mar 2023 21:47:34 +0000
Message-Id: <20230315214735.236444-3-jeremy@azazel.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315214735.236444-1-jeremy@azazel.net>
References: <20230315214735.236444-1-jeremy@azazel.net>
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

nft_masq has separate ipv4 and ipv6 call-backs which share much of their
code, and an inet one switch containing a switch that calls one of the
others based on the family of the packet.  Merge the ipv4 and ipv6 ones
into the inet one in order to get rid of the duplicate code.

Const-qualify the `priv` pointer since we don't need to write through
it.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 net/netfilter/nft_masq.c | 75 ++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 46 deletions(-)

diff --git a/net/netfilter/nft_masq.c b/net/netfilter/nft_masq.c
index e55e455275c4..4bd79306eebd 100644
--- a/net/netfilter/nft_masq.c
+++ b/net/netfilter/nft_masq.c
@@ -96,23 +96,39 @@ static int nft_masq_dump(struct sk_buff *skb,
 	return -1;
 }
 
-static void nft_masq_ipv4_eval(const struct nft_expr *expr,
-			       struct nft_regs *regs,
-			       const struct nft_pktinfo *pkt)
+static void nft_masq_eval(const struct nft_expr *expr,
+			  struct nft_regs *regs,
+			  const struct nft_pktinfo *pkt)
 {
-	struct nft_masq *priv = nft_expr_priv(expr);
+	const struct nft_masq *priv = nft_expr_priv(expr);
 	struct nf_nat_range2 range;
 
 	memset(&range, 0, sizeof(range));
 	range.flags = priv->flags;
 	if (priv->sreg_proto_min) {
-		range.min_proto.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_min]);
-		range.max_proto.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_max]);
+		range.min_proto.all = (__force __be16)
+			nft_reg_load16(&regs->data[priv->sreg_proto_min]);
+		range.max_proto.all = (__force __be16)
+			nft_reg_load16(&regs->data[priv->sreg_proto_max]);
+	}
+
+	switch (nft_pf(pkt)) {
+	case NFPROTO_IPV4:
+		regs->verdict.code = nf_nat_masquerade_ipv4(pkt->skb,
+							    nft_hook(pkt),
+							    &range,
+							    nft_out(pkt));
+		break;
+#ifdef CONFIG_NF_TABLES_IPV6
+	case NFPROTO_IPV6:
+		regs->verdict.code = nf_nat_masquerade_ipv6(pkt->skb, &range,
+							    nft_out(pkt));
+		break;
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		break;
 	}
-	regs->verdict.code = nf_nat_masquerade_ipv4(pkt->skb, nft_hook(pkt),
-						    &range, nft_out(pkt));
 }
 
 static void
@@ -125,7 +141,7 @@ static struct nft_expr_type nft_masq_ipv4_type;
 static const struct nft_expr_ops nft_masq_ipv4_ops = {
 	.type		= &nft_masq_ipv4_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_masq)),
-	.eval		= nft_masq_ipv4_eval,
+	.eval		= nft_masq_eval,
 	.init		= nft_masq_init,
 	.destroy	= nft_masq_ipv4_destroy,
 	.dump		= nft_masq_dump,
@@ -143,25 +159,6 @@ static struct nft_expr_type nft_masq_ipv4_type __read_mostly = {
 };
 
 #ifdef CONFIG_NF_TABLES_IPV6
-static void nft_masq_ipv6_eval(const struct nft_expr *expr,
-			       struct nft_regs *regs,
-			       const struct nft_pktinfo *pkt)
-{
-	struct nft_masq *priv = nft_expr_priv(expr);
-	struct nf_nat_range2 range;
-
-	memset(&range, 0, sizeof(range));
-	range.flags = priv->flags;
-	if (priv->sreg_proto_min) {
-		range.min_proto.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_min]);
-		range.max_proto.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_max]);
-	}
-	regs->verdict.code = nf_nat_masquerade_ipv6(pkt->skb, &range,
-						    nft_out(pkt));
-}
-
 static void
 nft_masq_ipv6_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
 {
@@ -172,7 +169,7 @@ static struct nft_expr_type nft_masq_ipv6_type;
 static const struct nft_expr_ops nft_masq_ipv6_ops = {
 	.type		= &nft_masq_ipv6_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_masq)),
-	.eval		= nft_masq_ipv6_eval,
+	.eval		= nft_masq_eval,
 	.init		= nft_masq_init,
 	.destroy	= nft_masq_ipv6_destroy,
 	.dump		= nft_masq_dump,
@@ -204,20 +201,6 @@ static inline void nft_masq_module_exit_ipv6(void) {}
 #endif
 
 #ifdef CONFIG_NF_TABLES_INET
-static void nft_masq_inet_eval(const struct nft_expr *expr,
-			       struct nft_regs *regs,
-			       const struct nft_pktinfo *pkt)
-{
-	switch (nft_pf(pkt)) {
-	case NFPROTO_IPV4:
-		return nft_masq_ipv4_eval(expr, regs, pkt);
-	case NFPROTO_IPV6:
-		return nft_masq_ipv6_eval(expr, regs, pkt);
-	}
-
-	WARN_ON_ONCE(1);
-}
-
 static void
 nft_masq_inet_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
 {
@@ -228,7 +211,7 @@ static struct nft_expr_type nft_masq_inet_type;
 static const struct nft_expr_ops nft_masq_inet_ops = {
 	.type		= &nft_masq_inet_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_masq)),
-	.eval		= nft_masq_inet_eval,
+	.eval		= nft_masq_eval,
 	.init		= nft_masq_init,
 	.destroy	= nft_masq_inet_destroy,
 	.dump		= nft_masq_dump,
-- 
2.39.2

