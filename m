Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D943717679E
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Mar 2020 23:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCBWoi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Mar 2020 17:44:38 -0500
Received: from kadath.azazel.net ([81.187.231.250]:42662 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgCBWoh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NC32fWxc2bv2VGuR1Bhak1t38P1C+TSgdw5bWQxp+X4=; b=feN7UQptN4vQHvILVuzrog/hKR
        TMNELRkBBUau03hHVk7dZZ7roDXPsPGnHa+KqTaJ26/E5hxSzc4uynO7sOQDsCXBPgoCwZyMyVk1E
        R1d7ImE/A4OjzAG9CwoH/Mrb/RT0mGD/ZV6DnV8R6OiKhNoCcyluFOSR3iQjWyAi277H2mRFLgkCy
        7fyJSIBPkxyinHWdc0x3TdyBaEhtD/YN4Bkin/e7C98Njwl9AuPTIu6OfGoB64LkKNglOW2fmb6Hv
        gV1/qtekw3xOo0Qnkx49lYQj9RfmjfUoMIL0O3W8jsEbmoFvJ6kOQEJXsQtkE459kAeG/BUCP39OM
        wTp/qPNQ==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1j8tPC-0000Sg-9y; Mon, 02 Mar 2020 22:19:18 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v2 14/18] netlink_delinearize: add support for processing variable payload statement arguments.
Date:   Mon,  2 Mar 2020 22:19:12 +0000
Message-Id: <20200302221916.1005019-15-jeremy@azazel.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302221916.1005019-1-jeremy@azazel.net>
References: <20200302221916.1005019-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If a user uses a variable payload expression in a payload statement, the
structure of the statement value is not handled by the existing
statement postprocessing function, so we need to extend it.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/netlink_delinearize.c | 74 +++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index e8e9e5719ee8..571cab1d932b 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -2514,7 +2514,7 @@ static void stmt_payload_binop_pp(struct rule_pp_ctx *ctx, struct expr *binop)
 	}
 }
 
-static bool stmt_payload_binop_postprocess_i(struct rule_pp_ctx *ctx)
+static bool stmt_payload_binop_postprocess_i_a(struct rule_pp_ctx *ctx)
 {
 	struct expr *expr, *binop, *payload, *value, *mask;
 	struct stmt *stmt = ctx->stmt;
@@ -2568,6 +2568,56 @@ static bool stmt_payload_binop_postprocess_i(struct rule_pp_ctx *ctx)
 	return true;
 }
 
+static bool stmt_payload_binop_postprocess_i_b(struct rule_pp_ctx *ctx)
+{
+	struct expr *expr, *payload, *mask, *xor;
+	struct stmt *stmt = ctx->stmt;
+	unsigned int shift;
+	mpz_t tmp, bitmask;
+
+	expr = stmt->payload.val;
+
+	if (expr->op != OP_XOR)
+		return false;
+
+	if (expr->left->etype != EXPR_BINOP)
+		return false;
+
+	if (expr->left->op != OP_AND)
+		return false;
+
+	xor     = expr->right;
+	mask    = expr->left->right;
+	payload = expr->left->left;
+
+	mpz_init(tmp);
+	mpz_set(tmp, mask->value);
+
+	mpz_init_bitmask(bitmask, payload->len);
+	mpz_xor(bitmask, bitmask, mask->value);
+	mpz_set(mask->value, bitmask);
+	mpz_clear(bitmask);
+
+	if (payload_expr_trim(payload, mask, &ctx->pctx, &shift))
+		payload_match_postprocess(ctx, expr->left, payload);
+
+	if (!payload_is_known(payload)) {
+		mpz_set(mask->value, tmp);
+	} else {
+		if (shift) {
+			expr->right = expr_get(xor->left);
+			expr_free(xor);
+		}
+		expr_free(stmt->payload.expr);
+		stmt->payload.expr = expr_get(payload);
+		stmt->payload.val = expr_get(expr->right);
+		expr_free(expr);
+	}
+
+	mpz_clear(tmp);
+	return true;
+}
+
 static bool stmt_payload_binop_postprocess_ii(struct rule_pp_ctx *ctx)
 {
 	struct expr *expr, *payload, *value;
@@ -2634,21 +2684,30 @@ static bool stmt_payload_binop_postprocess_ii(struct rule_pp_ctx *ctx)
  * and a mask to clear the real payload offset/length.
  *
  * So check if we have one of the following binops:
- * I)
+ *
+ * Ia)
  *           binop (|)
  *       binop(&)   value/set
  * payload   value(mask)
  *
- * This is the normal case, the | RHS is the value the user wants
- * to set, the & RHS is the mask value that discards bits we need
+ * This is the normal constant case, the | RHS is the value the user
+ * wants to set, the & RHS is the mask value that discards bits we need
  * to clear but retains everything unrelated to the set operation.
  *
+ * Ib)
+ *         binop (^)
+ *       binop(&)   value/set
+ * payload   value(mask)
+ *
+ * The user wants to set a variable payload argument.  The ^ RHS is the
+ * variable expression.  The mask is as above.
+ *
  * IIa)
  *     binop (&)
  * payload   mask
  *
  * User specified a zero set value -- netlink bitwise decoding
- * discarded the redundant "| 0" part.  This is identical to I),
+ * discarded the redundant "| 0" part.  This is identical to Ia),
  * we can just set value to 0 after we inferred the real payload size.
  *
  * IIb)
@@ -2671,7 +2730,10 @@ static void stmt_payload_binop_postprocess(struct rule_pp_ctx *ctx)
 
 	switch (expr->left->etype) {
 	case EXPR_BINOP: /* I? */
-		if (stmt_payload_binop_postprocess_i(ctx))
+		if (stmt_payload_binop_postprocess_i_a(ctx))
+			return;
+
+		if (stmt_payload_binop_postprocess_i_b(ctx))
 			return;
 		break;
 	case EXPR_PAYLOAD: /* II? */
-- 
2.25.1

