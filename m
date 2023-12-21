Return-Path: <netfilter-devel+bounces-458-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F422281B384
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Dec 2023 11:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AC1AB22C48
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Dec 2023 10:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA144F884;
	Thu, 21 Dec 2023 10:25:34 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9C4EB54
	for <netfilter-devel@vger.kernel.org>; Thu, 21 Dec 2023 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rGGF8-0000uz-7o; Thu, 21 Dec 2023 11:25:30 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft v2] src: do not allow to chain more than 16 binops
Date: Thu, 21 Dec 2023 11:25:14 +0100
Message-ID: <20231221102521.2172-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netlink_linearize.c has never supported more than 16 chained binops.
Adding more is possible but overwrites the stack in
netlink_gen_bitwise().

Add a recursion counter to catch this at eval stage.

Its not enough to just abort once the counter hits
NFT_MAX_EXPR_RECURSION.

This is because there are valid test cases that exceed this.
For example, evaluation of 1 | 2 will merge the constans, so even
if there are a dozen recursive eval calls this will not end up
with large binop chain post-evaluation.

v2: allow more than 16 binops iff the evaluation function
    did constant-merging.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/expression.h                          |  1 +
 include/rule.h                                |  6 ++-
 src/evaluate.c                                | 39 ++++++++++++++++++-
 src/netlink_linearize.c                       |  7 +++-
 .../bogons/nft-f/huge_binop_expr_chain_crash  |  5 +++
 5 files changed, 53 insertions(+), 5 deletions(-)
 create mode 100644 tests/shell/testcases/bogons/nft-f/huge_binop_expr_chain_crash

diff --git a/include/expression.h b/include/expression.h
index 809089c89974..f5d7e160a9aa 100644
--- a/include/expression.h
+++ b/include/expression.h
@@ -13,6 +13,7 @@
 
 #define NFT_MAX_EXPR_LEN_BYTES (NFT_REG32_COUNT * sizeof(uint32_t))
 #define NFT_MAX_EXPR_LEN_BITS  (NFT_MAX_EXPR_LEN_BYTES * BITS_PER_BYTE)
+#define NFT_MAX_EXPR_RECURSION 16
 
 /**
  * enum expr_types
diff --git a/include/rule.h b/include/rule.h
index 6236d2927c0a..6835fe069165 100644
--- a/include/rule.h
+++ b/include/rule.h
@@ -753,10 +753,13 @@ extern void cmd_free(struct cmd *cmd);
  * @rule:	current rule
  * @set:	current set
  * @stmt:	current statement
+ * @stmt_len:	current statement template length
+ * @recursion:  expr evaluation recursion counter
  * @cache:	cache context
  * @debug_mask: debugging bitmask
  * @ectx:	expression context
- * @pctx:	payload context
+ * @_pctx:	payload contexts
+ * @inner_desc: inner header description
  */
 struct eval_ctx {
 	struct nft_ctx		*nft;
@@ -767,6 +770,7 @@ struct eval_ctx {
 	struct set		*set;
 	struct stmt		*stmt;
 	uint32_t		stmt_len;
+	uint32_t		recursion;
 	struct expr_ctx		ectx;
 	struct proto_ctx	_pctx[2];
 	const struct proto_desc	*inner_desc;
diff --git a/src/evaluate.c b/src/evaluate.c
index 26f0110f66ea..41524eef12b7 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1418,6 +1418,13 @@ static int expr_evaluate_binop(struct eval_ctx *ctx, struct expr **expr)
 	struct expr *op = *expr, *left, *right;
 	const char *sym = expr_op_symbols[op->op];
 	unsigned int max_shift_len = ctx->ectx.len;
+	int ret = -1;
+
+	if (ctx->recursion >= USHRT_MAX)
+		return expr_binary_error(ctx->msgs, op, NULL,
+					 "Binary operation limit %u reached ",
+					 ctx->recursion);
+	ctx->recursion++;
 
 	if (expr_evaluate(ctx, &op->left) < 0)
 		return -1;
@@ -1472,14 +1479,42 @@ static int expr_evaluate_binop(struct eval_ctx *ctx, struct expr **expr)
 	switch (op->op) {
 	case OP_LSHIFT:
 	case OP_RSHIFT:
-		return expr_evaluate_shift(ctx, expr);
+		ret = expr_evaluate_shift(ctx, expr);
+		break;
 	case OP_AND:
 	case OP_XOR:
 	case OP_OR:
-		return expr_evaluate_bitwise(ctx, expr);
+		ret = expr_evaluate_bitwise(ctx, expr);
+		break;
 	default:
 		BUG("invalid binary operation %u\n", op->op);
 	}
+
+
+	if (ctx->recursion == 0)
+		BUG("recursion counter underflow");
+
+	/* can't check earlier: evaluate functions might do constant-merging + expr_free.
+	 *
+	 * So once we've evaluate everything check for remaining length of the
+	 * binop chain.
+	 */
+	if (--ctx->recursion == 0) {
+		unsigned int to_linearize = 0;
+
+		op = *expr;
+	        while (op && op->etype == EXPR_BINOP && op->left != NULL) {
+			to_linearize++;
+			op = op->left;
+
+			if (to_linearize >= NFT_MAX_EXPR_RECURSION)
+				return expr_binary_error(ctx->msgs, op, NULL,
+							 "Binary operation limit %u reached ",
+							 NFT_MAX_EXPR_RECURSION);
+		}
+	}
+
+	return ret;
 }
 
 static int list_member_evaluate(struct eval_ctx *ctx, struct expr **expr)
diff --git a/src/netlink_linearize.c b/src/netlink_linearize.c
index d8b41a088948..50dbd36c1b8e 100644
--- a/src/netlink_linearize.c
+++ b/src/netlink_linearize.c
@@ -695,10 +695,10 @@ static void netlink_gen_bitwise(struct netlink_linearize_ctx *ctx,
 				const struct expr *expr,
 				enum nft_registers dreg)
 {
+	struct expr *binops[NFT_MAX_EXPR_RECURSION];
 	struct nftnl_expr *nle;
 	struct nft_data_linearize nld;
 	struct expr *left, *i;
-	struct expr *binops[16];
 	mpz_t mask, xor, val, tmp;
 	unsigned int len;
 	int n = 0;
@@ -710,8 +710,11 @@ static void netlink_gen_bitwise(struct netlink_linearize_ctx *ctx,
 
 	binops[n++] = left = (struct expr *) expr;
 	while (left->etype == EXPR_BINOP && left->left != NULL &&
-	       (left->op == OP_AND || left->op == OP_OR || left->op == OP_XOR))
+	       (left->op == OP_AND || left->op == OP_OR || left->op == OP_XOR)) {
+		if (n == array_size(binops))
+			BUG("NFT_MAX_EXPR_RECURSION limit reached");
 		binops[n++] = left = left->left;
+	}
 
 	netlink_gen_expr(ctx, binops[--n], dreg);
 
diff --git a/tests/shell/testcases/bogons/nft-f/huge_binop_expr_chain_crash b/tests/shell/testcases/bogons/nft-f/huge_binop_expr_chain_crash
new file mode 100644
index 000000000000..8d1da7262cfb
--- /dev/null
+++ b/tests/shell/testcases/bogons/nft-f/huge_binop_expr_chain_crash
@@ -0,0 +1,5 @@
+table t {
+	chain c {
+		meta oifname^a^b^c^d^e^f^g^h^i^j^k^l^m^n^o^p^q^r^s^t^u^v^w^x^y^z^A^B^C^D^E^F^G^H^I^J^K^L^M^N^O^P^Q^R^S^T^U^V^W^X^Y^Z^0^1^2^3^4^5^6^7^8^9 bar
+	}
+}
-- 
2.41.0


