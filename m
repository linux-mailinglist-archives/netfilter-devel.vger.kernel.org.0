Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD6A14209A
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Jan 2020 23:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgASW5N (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 19 Jan 2020 17:57:13 -0500
Received: from kadath.azazel.net ([81.187.231.250]:56590 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbgASW5M (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 19 Jan 2020 17:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BL75eMWTNtU9WKOLzK9kbjLS5c2hx/WblagWc6PE2+M=; b=Ke7KOxlhN/c+dDlMhAFkYX1OX2
        cXUa5dX57l+sQpp1NkNr2SL6dorTKN/ZOHMBk5Lec8hHBztId6ItiTgpPFwRSLBAboQqyU3WMYrOc
        wpRdkcurap0DDAJL5MQGfpkc/CvQKhUCfh7yD0CAFDw+l+vcxuLT13LxCpWP8ONi9BqOj5r9QzVrt
        qUuw8qN/JMDZQgXOIxrGhaDwg+5FaWCqXL3o4Vyc2P2aVIdVrXKzTQUSjpfPNY2506LJxNGl7Xn7V
        yMYSh7Fw4N/odTe/qEdKxoMYJfV8R/Gshry8rrI9wC7NmjEQRSdkR5Q5tc28/T4MvPM3/ay+EEfv5
        BF3EKIxQ==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1itJVH-0006wh-Ft
        for netfilter-devel@vger.kernel.org; Sun, 19 Jan 2020 22:57:11 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v3 8/9] netlink: add support for handling shift expressions.
Date:   Sun, 19 Jan 2020 22:57:09 +0000
Message-Id: <20200119225710.222976-9-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200119225710.222976-1-jeremy@azazel.net>
References: <20200119225710.222976-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The kernel supports bitwise shift operations, so add support to the
netlink linearization and delinearization code.  The number of bits (the
righthand operand) is expected to be a 32-bit value in host endianness.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/netlink_delinearize.c | 87 ++++++++++++++++++++++++++++++++-------
 src/netlink_linearize.c   | 50 ++++++++++++++++++++--
 2 files changed, 120 insertions(+), 17 deletions(-)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 8f2a5dfacd3e..4dcaaba6218a 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -356,22 +356,17 @@ static void netlink_parse_lookup(struct netlink_parse_ctx *ctx,
 	ctx->stmt = expr_stmt_alloc(loc, expr);
 }
 
-static void netlink_parse_bitwise(struct netlink_parse_ctx *ctx,
-				  const struct location *loc,
-				  const struct nftnl_expr *nle)
+static struct expr *netlink_parse_bitwise_bool(struct netlink_parse_ctx *ctx,
+					       const struct location *loc,
+					       const struct nftnl_expr *nle,
+					       enum nft_registers sreg,
+					       struct expr *left)
+
 {
 	struct nft_data_delinearize nld;
-	enum nft_registers sreg, dreg;
-	struct expr *expr, *left, *mask, *xor, *or;
+	struct expr *expr, *mask, *xor, *or;
 	mpz_t m, x, o;
 
-	sreg = netlink_parse_register(nle, NFTNL_EXPR_BITWISE_SREG);
-	left = netlink_get_register(ctx, loc, sreg);
-	if (left == NULL)
-		return netlink_error(ctx, loc,
-				     "Bitwise expression has no left "
-				     "hand side");
-
 	expr = left;
 
 	nld.value = nftnl_expr_get(nle, NFTNL_EXPR_BITWISE_MASK, &nld.len);
@@ -423,6 +418,62 @@ static void netlink_parse_bitwise(struct netlink_parse_ctx *ctx,
 	mpz_clear(x);
 	mpz_clear(o);
 
+	return expr;
+}
+
+static struct expr *netlink_parse_bitwise_shift(struct netlink_parse_ctx *ctx,
+						const struct location *loc,
+						const struct nftnl_expr *nle,
+						enum ops op,
+						enum nft_registers sreg,
+						struct expr *left)
+{
+	struct nft_data_delinearize nld;
+	struct expr *expr, *right;
+
+	nld.value = nftnl_expr_get(nle, NFTNL_EXPR_BITWISE_DATA, &nld.len);
+	right = netlink_alloc_value(loc, &nld);
+
+	expr = binop_expr_alloc(loc, op, left, right);
+	expr->len = left->len;
+
+	return expr;
+}
+
+static void netlink_parse_bitwise(struct netlink_parse_ctx *ctx,
+				  const struct location *loc,
+				  const struct nftnl_expr *nle)
+{
+	enum nft_registers sreg, dreg;
+	struct expr *expr, *left;
+	enum nft_bitwise_ops op;
+
+	sreg = netlink_parse_register(nle, NFTNL_EXPR_BITWISE_SREG);
+	left = netlink_get_register(ctx, loc, sreg);
+	if (left == NULL)
+		return netlink_error(ctx, loc,
+				     "Bitwise expression has no left "
+				     "hand side");
+
+	op = nftnl_expr_get_u32(nle, NFTNL_EXPR_BITWISE_OP);
+
+	switch (op) {
+	case NFT_BITWISE_BOOL:
+		expr = netlink_parse_bitwise_bool(ctx, loc, nle, sreg,
+						  left);
+		break;
+	case NFT_BITWISE_LSHIFT:
+		expr = netlink_parse_bitwise_shift(ctx, loc, nle, OP_LSHIFT,
+						   sreg, left);
+		break;
+	case NFT_BITWISE_RSHIFT:
+		expr = netlink_parse_bitwise_shift(ctx, loc, nle, OP_RSHIFT,
+						   sreg, left);
+		break;
+	default:
+		BUG("invalid bitwise operation %u\n", op);
+	}
+
 	dreg = netlink_parse_register(nle, NFTNL_EXPR_BITWISE_DREG);
 	netlink_set_register(ctx, dreg, expr);
 }
@@ -2091,8 +2142,16 @@ static void expr_postprocess(struct rule_pp_ctx *ctx, struct expr **exprp)
 		break;
 	case EXPR_BINOP:
 		expr_postprocess(ctx, &expr->left);
-		expr_set_type(expr->right, expr->left->dtype,
-			      expr->left->byteorder);
+		switch (expr->op) {
+		case OP_LSHIFT:
+		case OP_RSHIFT:
+			expr_set_type(expr->right, &integer_type,
+				      BYTEORDER_HOST_ENDIAN);
+			break;
+		default:
+			expr_set_type(expr->right, expr->left->dtype,
+				      expr->left->byteorder);
+		}
 		expr_postprocess(ctx, &expr->right);
 
 		expr_set_type(expr, expr->left->dtype,
diff --git a/src/netlink_linearize.c b/src/netlink_linearize.c
index d5e177d5e75c..1b9abb379577 100644
--- a/src/netlink_linearize.c
+++ b/src/netlink_linearize.c
@@ -545,9 +545,36 @@ static void combine_binop(mpz_t mask, mpz_t xor, const mpz_t m, const mpz_t x)
 	mpz_and(mask, mask, m);
 }
 
-static void netlink_gen_binop(struct netlink_linearize_ctx *ctx,
+static void netlink_gen_shift(struct netlink_linearize_ctx *ctx,
 			      const struct expr *expr,
 			      enum nft_registers dreg)
+{
+	enum nft_bitwise_ops op = expr->op == OP_LSHIFT ?
+		NFT_BITWISE_LSHIFT : NFT_BITWISE_RSHIFT;
+	unsigned int len = div_round_up(expr->len, BITS_PER_BYTE);
+	struct nft_data_linearize nld;
+	struct nftnl_expr *nle;
+
+	netlink_gen_expr(ctx, expr->left, dreg);
+
+	nle = alloc_nft_expr("bitwise");
+	netlink_put_register(nle, NFTNL_EXPR_BITWISE_SREG, dreg);
+	netlink_put_register(nle, NFTNL_EXPR_BITWISE_DREG, dreg);
+	nftnl_expr_set_u32(nle, NFTNL_EXPR_BITWISE_OP, op);
+	nftnl_expr_set_u32(nle, NFTNL_EXPR_BITWISE_LEN, len);
+
+	netlink_gen_raw_data(expr->right->value, expr->right->byteorder,
+			     sizeof(uint32_t), &nld);
+
+	nftnl_expr_set(nle, NFTNL_EXPR_BITWISE_DATA, nld.value,
+		       nld.len);
+
+	nftnl_rule_add_expr(ctx->nlr, nle);
+}
+
+static void netlink_gen_bitwise(struct netlink_linearize_ctx *ctx,
+				const struct expr *expr,
+				enum nft_registers dreg)
 {
 	struct nftnl_expr *nle;
 	struct nft_data_linearize nld;
@@ -562,8 +589,9 @@ static void netlink_gen_binop(struct netlink_linearize_ctx *ctx,
 	mpz_init(val);
 	mpz_init(tmp);
 
-	binops[n++] = left = (void *)expr;
-	while (left->etype == EXPR_BINOP && left->left != NULL)
+	binops[n++] = left = (struct expr *) expr;
+	while (left->etype == EXPR_BINOP && left->left != NULL &&
+	       (left->op == OP_AND || left->op == OP_OR || left->op == OP_XOR))
 		binops[n++] = left = left->left;
 	n--;
 
@@ -598,6 +626,7 @@ static void netlink_gen_binop(struct netlink_linearize_ctx *ctx,
 	nle = alloc_nft_expr("bitwise");
 	netlink_put_register(nle, NFTNL_EXPR_BITWISE_SREG, dreg);
 	netlink_put_register(nle, NFTNL_EXPR_BITWISE_DREG, dreg);
+	nftnl_expr_set_u32(nle, NFTNL_EXPR_BITWISE_OP, NFT_BITWISE_BOOL);
 	nftnl_expr_set_u32(nle, NFTNL_EXPR_BITWISE_LEN, len);
 
 	netlink_gen_raw_data(mask, expr->byteorder, len, &nld);
@@ -613,6 +642,21 @@ static void netlink_gen_binop(struct netlink_linearize_ctx *ctx,
 	nftnl_rule_add_expr(ctx->nlr, nle);
 }
 
+static void netlink_gen_binop(struct netlink_linearize_ctx *ctx,
+			      const struct expr *expr,
+			      enum nft_registers dreg)
+{
+	switch(expr->op) {
+	case OP_LSHIFT:
+	case OP_RSHIFT:
+		netlink_gen_shift(ctx, expr, dreg);
+		break;
+	default:
+		netlink_gen_bitwise(ctx, expr, dreg);
+		break;
+	}
+}
+
 static enum nft_byteorder_ops netlink_gen_unary_op(enum ops op)
 {
 	switch (op) {
-- 
2.24.1

