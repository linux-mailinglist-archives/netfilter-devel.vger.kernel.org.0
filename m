Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886343812A4
	for <lists+netfilter-devel@lfdr.de>; Fri, 14 May 2021 23:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhENVLx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 14 May 2021 17:11:53 -0400
Received: from mail.netfilter.org ([217.70.188.207]:35916 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhENVLw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 14 May 2021 17:11:52 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id A7CA86415A
        for <netfilter-devel@vger.kernel.org>; Fri, 14 May 2021 23:09:48 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nftables,v2] parser_bison: add shortcut syntax for matching flags without binary operations
Date:   Fri, 14 May 2021 23:10:35 +0200
Message-Id: <20210514211035.5567-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds the following shortcut syntax:

	expression flags / flags

instead of:

	expression and flags == flags

For example:

	tcp flags syn,ack / syn,ack,fin,rst
                  ^^^^^^^   ^^^^^^^^^^^^^^^
                   value         mask

instead of:

	tcp flags and (syn|ack|fin|rst) == syn|ack

The second list of comma-separated flags represents the mask which are
examined and the first list of comma-separated flags must be set.

You can also use the != operator with this syntax:

	tcp flags != fin,rst / syn,ack,fin,rst

This shortcut is based on the prefix notation, but it is also similar to
the iptables tcp matching syntax.

This patch introduces the flagcmp expression to print the tcp flags in
this new notation. The delinearize path transforms the binary expression
to this new flagcmp expression whenever possible.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: add flagcmp expression.
    update parser and delinearize path to use it.

 include/expression.h        | 11 +++++++
 src/evaluate.c              | 17 ++++++++++
 src/expression.c            | 48 ++++++++++++++++++++++++++++
 src/netlink_delinearize.c   | 64 ++++++++++++++++++++++++-------------
 src/parser_bison.y          | 16 ++++++++++
 tests/py/inet/tcp.t         |  2 +-
 tests/py/inet/tcp.t.payload |  2 +-
 7 files changed, 136 insertions(+), 24 deletions(-)

diff --git a/include/expression.h b/include/expression.h
index be703d755b6e..742fcdd7bf75 100644
--- a/include/expression.h
+++ b/include/expression.h
@@ -72,6 +72,7 @@ enum expr_types {
 	EXPR_FIB,
 	EXPR_XFRM,
 	EXPR_SET_ELEM_CATCHALL,
+	EXPR_FLAGCMP,
 };
 #define EXPR_MAX EXPR_XFRM
 
@@ -370,6 +371,12 @@ struct expr {
 			uint8_t			ttl;
 			uint32_t		flags;
 		} osf;
+		struct {
+			/* EXPR_FLAGCMP */
+			struct expr		*expr;
+			struct expr		*mask;
+			struct expr		*value;
+		} flagcmp;
 	};
 };
 
@@ -500,6 +507,10 @@ extern struct expr *set_elem_expr_alloc(const struct location *loc,
 
 struct expr *set_elem_catchall_expr_alloc(const struct location *loc);
 
+struct expr *flagcmp_expr_alloc(const struct location *loc, enum ops op,
+				struct expr *expr, struct expr *mask,
+				struct expr *value);
+
 extern void range_expr_value_low(mpz_t rop, const struct expr *expr);
 extern void range_expr_value_high(mpz_t rop, const struct expr *expr);
 
diff --git a/src/evaluate.c b/src/evaluate.c
index 2e31ed10ccb7..a3a1d1c026a7 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2134,6 +2134,21 @@ static int expr_evaluate_xfrm(struct eval_ctx *ctx, struct expr **exprp)
 	return expr_evaluate_primary(ctx, exprp);
 }
 
+static int expr_evaluate_flagcmp(struct eval_ctx *ctx, struct expr **exprp)
+{
+	struct expr *expr = *exprp, *binop, *rel;
+
+	binop = binop_expr_alloc(&expr->location, OP_AND,
+				 expr_get(expr->flagcmp.expr),
+				 expr_get(expr->flagcmp.mask));
+	rel = relational_expr_alloc(&expr->location, expr->op, binop,
+				    expr_get(expr->flagcmp.value));
+	expr_free(expr);
+	*exprp = rel;
+
+	return expr_evaluate(ctx, exprp);
+}
+
 static int expr_evaluate(struct eval_ctx *ctx, struct expr **expr)
 {
 	if (ctx->nft->debug_mask & NFT_DEBUG_EVALUATION) {
@@ -2203,6 +2218,8 @@ static int expr_evaluate(struct eval_ctx *ctx, struct expr **expr)
 		return expr_evaluate_xfrm(ctx, expr);
 	case EXPR_SET_ELEM_CATCHALL:
 		return 0;
+	case EXPR_FLAGCMP:
+		return expr_evaluate_flagcmp(ctx, expr);
 	default:
 		BUG("unknown expression type %s\n", expr_name(*expr));
 	}
diff --git a/src/expression.c b/src/expression.c
index b3400751f312..c17ff8341281 100644
--- a/src/expression.c
+++ b/src/expression.c
@@ -1351,6 +1351,53 @@ struct expr *set_elem_catchall_expr_alloc(const struct location *loc)
 	return expr;
 }
 
+static void flagcmp_expr_print(const struct expr *expr, struct output_ctx *octx)
+{
+	expr_print(expr->flagcmp.expr, octx);
+	nft_print(octx, " ");
+	expr_print(expr->flagcmp.mask, octx);
+	nft_print(octx, " / ");
+	expr_print(expr->flagcmp.value, octx);
+}
+
+static void flagcmp_expr_clone(struct expr *new, const struct expr *expr)
+{
+	new->flagcmp.expr = expr_clone(expr->flagcmp.expr);
+	new->flagcmp.mask = expr_clone(expr->flagcmp.mask);
+	new->flagcmp.value = expr_clone(expr->flagcmp.value);
+}
+
+static void flagcmp_expr_destroy(struct expr *expr)
+{
+	expr_free(expr->flagcmp.expr);
+	expr_free(expr->flagcmp.mask);
+	expr_free(expr->flagcmp.value);
+}
+
+static const struct expr_ops flagcmp_expr_ops = {
+	.type		= EXPR_FLAGCMP,
+	.name		= "flags comparison",
+	.print		= flagcmp_expr_print,
+	.clone		= flagcmp_expr_clone,
+	.destroy	= flagcmp_expr_destroy,
+};
+
+struct expr *flagcmp_expr_alloc(const struct location *loc, enum ops op,
+				struct expr *match, struct expr *mask,
+				struct expr *value)
+{
+	struct expr *expr;
+
+	expr = expr_alloc(loc, EXPR_FLAGCMP, match->dtype, match->byteorder,
+			  match->len);
+	expr->op = op;
+	expr->flagcmp.expr = match;
+	expr->flagcmp.mask = mask;
+	expr->flagcmp.value = value;
+
+	return expr;
+}
+
 void range_expr_value_low(mpz_t rop, const struct expr *expr)
 {
 	switch (expr->etype) {
@@ -1427,6 +1474,7 @@ static const struct expr_ops *__expr_ops_by_type(enum expr_types etype)
 	case EXPR_FIB: return &fib_expr_ops;
 	case EXPR_XFRM: return &xfrm_expr_ops;
 	case EXPR_SET_ELEM_CATCHALL: return &set_elem_catchall_expr_ops;
+	case EXPR_FLAGCMP: return &flagcmp_expr_ops;
 	}
 
 	BUG("Unknown expression type %d\n", etype);
diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 81fe4c166499..bfebb9f5ce20 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -2166,35 +2166,55 @@ static void map_binop_postprocess(struct rule_pp_ctx *ctx, struct expr *expr)
 		binop_postprocess(ctx, expr);
 }
 
-static void relational_binop_postprocess(struct rule_pp_ctx *ctx, struct expr *expr)
+static void relational_binop_postprocess(struct rule_pp_ctx *ctx,
+					 struct expr **exprp)
 {
-	struct expr *binop = expr->left, *value = expr->right;
+	struct expr *expr = *exprp, *binop = expr->left, *value = expr->right;
 
 	if (binop->op == OP_AND && (expr->op == OP_NEQ || expr->op == OP_EQ) &&
 	    value->dtype->basetype &&
-	    value->dtype->basetype->type == TYPE_BITMASK &&
-	    value->etype == EXPR_VALUE &&
-	    !mpz_cmp_ui(value->value, 0)) {
-		/* Flag comparison: data & flags != 0
-		 *
-		 * Split the flags into a list of flag values and convert the
-		 * op to OP_EQ.
-		 */
-		expr_free(value);
-
-		expr->left  = expr_get(binop->left);
-		expr->right = binop_tree_to_list(NULL, binop->right);
-		switch (expr->op) {
-		case OP_NEQ:
-			expr->op = OP_IMPLICIT;
+	    value->dtype->basetype->type == TYPE_BITMASK) {
+		switch (value->etype) {
+		case EXPR_VALUE:
+			if (!mpz_cmp_ui(value->value, 0)) {
+				/* Flag comparison: data & flags != 0
+				 *
+				 * Split the flags into a list of flag values and convert the
+				 * op to OP_EQ.
+				 */
+				expr_free(value);
+
+				expr->left  = expr_get(binop->left);
+				expr->right = binop_tree_to_list(NULL, binop->right);
+				switch (expr->op) {
+				case OP_NEQ:
+					expr->op = OP_IMPLICIT;
+					break;
+				case OP_EQ:
+					expr->op = OP_NEG;
+					break;
+				default:
+					BUG("unknown operation type %d\n", expr->op);
+				}
+				expr_free(binop);
+			} else {
+				*exprp = flagcmp_expr_alloc(&expr->location, expr->op,
+							    expr_get(binop->left),
+							    expr_get(value),
+							    binop_tree_to_list(NULL, binop->right));
+				expr_free(expr);
+			}
 			break;
-		case OP_EQ:
-			expr->op = OP_NEG;
+		case EXPR_BINOP:
+			*exprp = flagcmp_expr_alloc(&expr->location, expr->op,
+						    expr_get(binop->left),
+						    binop_tree_to_list(NULL, value),
+						    binop_tree_to_list(NULL, binop->right));
+			expr_free(expr);
 			break;
 		default:
-			BUG("unknown operation type %d\n", expr->op);
+			break;
 		}
-		expr_free(binop);
 	} else if (binop->left->dtype->flags & DTYPE_F_PREFIX &&
 		   binop->op == OP_AND && expr->right->etype == EXPR_VALUE &&
 		   expr_mask_is_prefix(binop->right)) {
@@ -2403,7 +2423,7 @@ static void expr_postprocess(struct rule_pp_ctx *ctx, struct expr **exprp)
 			meta_match_postprocess(ctx, expr);
 			break;
 		case EXPR_BINOP:
-			relational_binop_postprocess(ctx, expr);
+			relational_binop_postprocess(ctx, exprp);
 			break;
 		default:
 			break;
diff --git a/src/parser_bison.y b/src/parser_bison.y
index 000eb40a20a4..cdb04fa8d19b 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -4463,6 +4463,22 @@ relational_expr		:	expr	/* implicit */	rhs_expr
 			{
 				$$ = relational_expr_alloc(&@$, OP_IMPLICIT, $1, $2);
 			}
+			|	expr	/* implicit */	basic_rhs_expr	SLASH	list_rhs_expr
+			{
+				$$ = flagcmp_expr_alloc(&@$, OP_EQ, $1, $4, $2);
+			}
+			|	expr	/* implicit */	list_rhs_expr	SLASH	list_rhs_expr
+			{
+				$$ = flagcmp_expr_alloc(&@$, OP_EQ, $1, $4, $2);
+			}
+			|	expr	relational_op	basic_rhs_expr	SLASH	list_rhs_expr
+			{
+				$$ = flagcmp_expr_alloc(&@$, $2, $1, $5, $3);
+			}
+			|	expr	relational_op	list_rhs_expr	SLASH	list_rhs_expr
+			{
+				$$ = flagcmp_expr_alloc(&@$, $2, $1, $5, $3);
+			}
 			|	expr	relational_op	rhs_expr
 			{
 				$$ = relational_expr_alloc(&@2, $2, $1, $3);
diff --git a/tests/py/inet/tcp.t b/tests/py/inet/tcp.t
index 5f2caea98759..a8d46831213a 100644
--- a/tests/py/inet/tcp.t
+++ b/tests/py/inet/tcp.t
@@ -77,7 +77,7 @@ tcp flags != { fin, urg, ecn, cwr} drop;ok
 tcp flags cwr;ok
 tcp flags != cwr;ok
 tcp flags == syn;ok
-tcp flags & (syn|fin) == (syn|fin);ok;tcp flags & (fin | syn) == fin | syn
+tcp flags fin,syn / fin,syn;ok
 tcp flags & (fin | syn | rst | psh | ack | urg | ecn | cwr) == fin | syn | rst | psh | ack | urg | ecn | cwr;ok;tcp flags == 0xff
 tcp flags { syn, syn | ack };ok
 tcp flags & (fin | syn | rst | psh | ack | urg) == { fin, ack, psh | ack, fin | psh | ack };ok
diff --git a/tests/py/inet/tcp.t.payload b/tests/py/inet/tcp.t.payload
index da932b6d8c12..07ac151c2d27 100644
--- a/tests/py/inet/tcp.t.payload
+++ b/tests/py/inet/tcp.t.payload
@@ -434,7 +434,7 @@ inet test-inet input
   [ payload load 1b @ transport header + 13 => reg 1 ]
   [ cmp eq reg 1 0x00000002 ]
 
-# tcp flags & (syn|fin) == (syn|fin)
+# tcp flags fin,syn / fin,syn
 inet test-inet input
   [ meta load l4proto => reg 1 ]
   [ cmp eq reg 1 0x00000006 ]
-- 
2.20.1

