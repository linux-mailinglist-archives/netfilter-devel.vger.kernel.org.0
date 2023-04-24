Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA96D7CF0
	for <lists+netfilter-devel@lfdr.de>; Wed,  5 Apr 2023 14:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbjDEMsK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Apr 2023 08:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbjDEMsJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:48:09 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A1292D44
        for <netfilter-devel@vger.kernel.org>; Wed,  5 Apr 2023 05:48:06 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v2 4/4] optimize: support for redirect and masquerade
Date:   Wed,  5 Apr 2023 14:48:01 +0200
Message-Id: <20230405124801.365577-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The redirect and masquerade statements can be handled as verdicts:

- if redirect statement specifies no ports.
- masquerade statement, in any case.

Exceptions to the rule: If redirect statement specifies ports, then nat
map transformation can be used iif both statements specify ports.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1668
Fixes: 0a6dbfce6dc3 ("optimize: merge nat rules with same selectors into map")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: - skip merging if redirect already uses a map
    - add stmt_nat_type() helper function
    - indentation fix in __stmt_type_eq()

 src/optimize.c                                | 151 ++++++++++++++----
 .../optimizations/dumps/merge_nat.nft         |   4 +
 tests/shell/testcases/optimizations/merge_nat |   7 +
 3 files changed, 130 insertions(+), 32 deletions(-)

diff --git a/src/optimize.c b/src/optimize.c
index e0154beb556d..22dfbcd92e5e 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -239,21 +239,58 @@ static bool __stmt_type_eq(const struct stmt *stmt_a, const struct stmt *stmt_b,
 		if (stmt_a->nat.type != stmt_b->nat.type ||
 		    stmt_a->nat.flags != stmt_b->nat.flags ||
 		    stmt_a->nat.family != stmt_b->nat.family ||
-		    stmt_a->nat.type_flags != stmt_b->nat.type_flags ||
-		    (stmt_a->nat.addr &&
-		     stmt_a->nat.addr->etype != EXPR_SYMBOL &&
-		     stmt_a->nat.addr->etype != EXPR_RANGE) ||
-		    (stmt_b->nat.addr &&
-		     stmt_b->nat.addr->etype != EXPR_SYMBOL &&
-		     stmt_b->nat.addr->etype != EXPR_RANGE) ||
-		    (stmt_a->nat.proto &&
-		     stmt_a->nat.proto->etype != EXPR_SYMBOL &&
-		     stmt_a->nat.proto->etype != EXPR_RANGE) ||
-		    (stmt_b->nat.proto &&
-		     stmt_b->nat.proto->etype != EXPR_SYMBOL &&
-		     stmt_b->nat.proto->etype != EXPR_RANGE))
+		    stmt_a->nat.type_flags != stmt_b->nat.type_flags)
 			return false;
 
+		switch (stmt_a->nat.type) {
+		case NFT_NAT_SNAT:
+		case NFT_NAT_DNAT:
+			if ((stmt_a->nat.addr &&
+			     stmt_a->nat.addr->etype != EXPR_SYMBOL &&
+			     stmt_a->nat.addr->etype != EXPR_RANGE) ||
+			    (stmt_b->nat.addr &&
+			     stmt_b->nat.addr->etype != EXPR_SYMBOL &&
+			     stmt_b->nat.addr->etype != EXPR_RANGE) ||
+			    (stmt_a->nat.proto &&
+			     stmt_a->nat.proto->etype != EXPR_SYMBOL &&
+			     stmt_a->nat.proto->etype != EXPR_RANGE) ||
+			    (stmt_b->nat.proto &&
+			     stmt_b->nat.proto->etype != EXPR_SYMBOL &&
+			     stmt_b->nat.proto->etype != EXPR_RANGE))
+				return false;
+			break;
+		case NFT_NAT_MASQ:
+			break;
+		case NFT_NAT_REDIR:
+			if ((stmt_a->nat.proto &&
+			     stmt_a->nat.proto->etype != EXPR_SYMBOL &&
+			     stmt_a->nat.proto->etype != EXPR_RANGE) ||
+			    (stmt_b->nat.proto &&
+			     stmt_b->nat.proto->etype != EXPR_SYMBOL &&
+			     stmt_b->nat.proto->etype != EXPR_RANGE))
+				return false;
+
+			/* it should be possible to infer implicit redirections
+			 * such as:
+			 *
+			 *	tcp dport 1234 redirect
+			 *	tcp dport 3456 redirect to :7890
+			 * merge:
+			 *	redirect to tcp dport map { 1234 : 1234, 3456 : 7890 }
+			 *
+			 * currently not implemented.
+			 */
+			if (fully_compare &&
+			    stmt_a->nat.type == NFT_NAT_REDIR &&
+			    stmt_b->nat.type == NFT_NAT_REDIR &&
+			    (!!stmt_a->nat.proto ^ !!stmt_b->nat.proto))
+				return false;
+
+			break;
+		default:
+			assert(0);
+		}
+
 		return true;
 	default:
 		/* ... Merging anything else is yet unsupported. */
@@ -837,12 +874,35 @@ static bool stmt_verdict_cmp(const struct optimize_ctx *ctx,
 	return true;
 }
 
-static int stmt_nat_find(const struct optimize_ctx *ctx)
+static int stmt_nat_type(const struct optimize_ctx *ctx, int from,
+			 enum nft_nat_etypes *nat_type)
 {
+	uint32_t j;
+
+	for (j = 0; j < ctx->num_stmts; j++) {
+		if (!ctx->stmt_matrix[from][j])
+			continue;
+
+		if (ctx->stmt_matrix[from][j]->ops->type == STMT_NAT) {
+			*nat_type = ctx->stmt_matrix[from][j]->nat.type;
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+static int stmt_nat_find(const struct optimize_ctx *ctx, int from)
+{
+	enum nft_nat_etypes nat_type;
 	uint32_t i;
 
+	if (stmt_nat_type(ctx, from, &nat_type) < 0)
+		return -1;
+
 	for (i = 0; i < ctx->num_stmts; i++) {
-		if (ctx->stmt[i]->ops->type != STMT_NAT)
+		if (ctx->stmt[i]->ops->type != STMT_NAT ||
+		    ctx->stmt[i]->nat.type != nat_type)
 			continue;
 
 		return i;
@@ -858,9 +918,13 @@ static struct expr *stmt_nat_expr(struct stmt *nat_stmt)
 	assert(nat_stmt->ops->type == STMT_NAT);
 
 	if (nat_stmt->nat.proto) {
-		nat_expr = concat_expr_alloc(&internal_location);
-		compound_expr_add(nat_expr, expr_get(nat_stmt->nat.addr));
-		compound_expr_add(nat_expr, expr_get(nat_stmt->nat.proto));
+		if (nat_stmt->nat.addr) {
+			nat_expr = concat_expr_alloc(&internal_location);
+			compound_expr_add(nat_expr, expr_get(nat_stmt->nat.addr));
+			compound_expr_add(nat_expr, expr_get(nat_stmt->nat.proto));
+		} else {
+			nat_expr = expr_get(nat_stmt->nat.proto);
+		}
 		expr_free(nat_stmt->nat.proto);
 		nat_stmt->nat.proto = NULL;
 	} else {
@@ -881,7 +945,7 @@ static void merge_nat(const struct optimize_ctx *ctx,
 	struct stmt *stmt, *nat_stmt;
 	uint32_t i;
 
-	k = stmt_nat_find(ctx);
+	k = stmt_nat_find(ctx, from);
 	assert(k >= 0);
 
 	set = set_expr_alloc(&internal_location, NULL);
@@ -914,7 +978,10 @@ static void merge_nat(const struct optimize_ctx *ctx,
 		nat_stmt->nat.family = family;
 
 	expr_free(nat_stmt->nat.addr);
-	nat_stmt->nat.addr = expr;
+	if (nat_stmt->nat.type == NFT_NAT_REDIR)
+		nat_stmt->nat.proto = expr;
+	else
+		nat_stmt->nat.addr = expr;
 
 	remove_counter(ctx, from);
 	list_del(&stmt->list);
@@ -930,7 +997,7 @@ static void merge_concat_nat(const struct optimize_ctx *ctx,
 	struct stmt *stmt, *nat_stmt;
 	uint32_t i, j;
 
-	k = stmt_nat_find(ctx);
+	k = stmt_nat_find(ctx, from);
 	assert(k >= 0);
 
 	set = set_expr_alloc(&internal_location, NULL);
@@ -1015,22 +1082,36 @@ static void rule_optimize_print(struct output_ctx *octx,
 	fprintf(octx->error_fp, "%s\n", line);
 }
 
-static enum stmt_types merge_stmt_type(const struct optimize_ctx *ctx,
-				       uint32_t from, uint32_t to)
+enum {
+	MERGE_BY_VERDICT,
+	MERGE_BY_NAT_MAP,
+	MERGE_BY_NAT,
+};
+
+static uint32_t merge_stmt_type(const struct optimize_ctx *ctx,
+				uint32_t from, uint32_t to)
 {
+	const struct stmt *stmt;
 	uint32_t i, j;
 
 	for (i = from; i <= to; i++) {
 		for (j = 0; j < ctx->num_stmts; j++) {
-			if (!ctx->stmt_matrix[i][j])
+			stmt = ctx->stmt_matrix[i][j];
+			if (!stmt)
 				continue;
-			if (ctx->stmt_matrix[i][j]->ops->type == STMT_NAT)
-				return STMT_NAT;
+			if (stmt->ops->type == STMT_NAT) {
+				if ((stmt->nat.type == NFT_NAT_REDIR &&
+				     !stmt->nat.proto) ||
+				    stmt->nat.type == NFT_NAT_MASQ)
+					return MERGE_BY_NAT;
+
+				return MERGE_BY_NAT_MAP;
+			}
 		}
 	}
 
 	/* merge by verdict, even if no verdict is specified. */
-	return STMT_VERDICT;
+	return MERGE_BY_VERDICT;
 }
 
 static void merge_rules(const struct optimize_ctx *ctx,
@@ -1038,14 +1119,14 @@ static void merge_rules(const struct optimize_ctx *ctx,
 			const struct merge *merge,
 			struct output_ctx *octx)
 {
-	enum stmt_types stmt_type;
+	uint32_t merge_type;
 	bool same_verdict;
 	uint32_t i;
 
-	stmt_type = merge_stmt_type(ctx, from, to);
+	merge_type = merge_stmt_type(ctx, from, to);
 
-	switch (stmt_type) {
-	case STMT_VERDICT:
+	switch (merge_type) {
+	case MERGE_BY_VERDICT:
 		same_verdict = stmt_verdict_cmp(ctx, from, to);
 		if (merge->num_stmts > 1) {
 			if (same_verdict)
@@ -1059,12 +1140,18 @@ static void merge_rules(const struct optimize_ctx *ctx,
 				merge_stmts_vmap(ctx, from, to, merge);
 		}
 		break;
-	case STMT_NAT:
+	case MERGE_BY_NAT_MAP:
 		if (merge->num_stmts > 1)
 			merge_concat_nat(ctx, from, to, merge);
 		else
 			merge_nat(ctx, from, to, merge);
 		break;
+	case MERGE_BY_NAT:
+		if (merge->num_stmts > 1)
+			merge_concat_stmts(ctx, from, to, merge);
+		else
+			merge_stmts(ctx, from, to, merge);
+		break;
 	default:
 		assert(0);
 	}
diff --git a/tests/shell/testcases/optimizations/dumps/merge_nat.nft b/tests/shell/testcases/optimizations/dumps/merge_nat.nft
index dd17905dbfeb..48d18a676ee0 100644
--- a/tests/shell/testcases/optimizations/dumps/merge_nat.nft
+++ b/tests/shell/testcases/optimizations/dumps/merge_nat.nft
@@ -8,6 +8,7 @@ table ip test2 {
 	chain y {
 		oif "lo" accept
 		dnat ip to tcp dport map { 80 : 1.1.1.1 . 8001, 81 : 2.2.2.2 . 9001 }
+		ip saddr { 10.141.11.0/24, 10.141.13.0/24 } masquerade
 	}
 }
 table ip test3 {
@@ -15,12 +16,15 @@ table ip test3 {
 		oif "lo" accept
 		snat to ip saddr . tcp sport map { 1.1.1.1 . 1024-65535 : 3.3.3.3, 2.2.2.2 . 1024-65535 : 4.4.4.4 }
 		oifname "enp2s0" snat ip to ip saddr map { 10.1.1.0/24 : 72.2.3.66-72.2.3.78 }
+		tcp dport { 8888, 9999 } redirect
 	}
 }
 table ip test4 {
 	chain y {
 		oif "lo" accept
 		dnat ip to ip daddr . tcp dport map { 1.1.1.1 . 80 : 4.4.4.4 . 8000, 2.2.2.2 . 81 : 3.3.3.3 . 9000 }
+		redirect to :tcp dport map { 83 : 8083, 84 : 8084 }
+		tcp dport 85 redirect
 	}
 }
 table inet nat {
diff --git a/tests/shell/testcases/optimizations/merge_nat b/tests/shell/testcases/optimizations/merge_nat
index edf7f4c438b9..3a57d9402301 100755
--- a/tests/shell/testcases/optimizations/merge_nat
+++ b/tests/shell/testcases/optimizations/merge_nat
@@ -17,6 +17,8 @@ RULESET="table ip test2 {
                 oif lo accept
                 tcp dport 80 dnat to 1.1.1.1:8001
                 tcp dport 81 dnat to 2.2.2.2:9001
+                ip saddr 10.141.11.0/24 masquerade
+                ip saddr 10.141.13.0/24 masquerade
         }
 }"
 
@@ -28,6 +30,8 @@ RULESET="table ip test3 {
                 ip saddr 1.1.1.1 tcp sport 1024-65535 snat to 3.3.3.3
                 ip saddr 2.2.2.2 tcp sport 1024-65535 snat to 4.4.4.4
                 oifname enp2s0 snat ip to ip saddr map { 10.1.1.0/24 : 72.2.3.66-72.2.3.78 }
+                tcp dport 8888 redirect
+                tcp dport 9999 redirect
         }
 }"
 
@@ -38,6 +42,9 @@ RULESET="table ip test4 {
                 oif lo accept
                 ip daddr 1.1.1.1 tcp dport 80 dnat to 4.4.4.4:8000
                 ip daddr 2.2.2.2 tcp dport 81 dnat to 3.3.3.3:9000
+                tcp dport 83 redirect to :8083
+                tcp dport 84 redirect to :8084
+                tcp dport 85 redirect
         }
 }"
 
-- 
2.30.2

