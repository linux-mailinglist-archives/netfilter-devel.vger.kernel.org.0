Return-Path: <netfilter-devel+bounces-5542-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4089F58A7
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Dec 2024 22:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD28816F032
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Dec 2024 21:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E7A1F9F5F;
	Tue, 17 Dec 2024 21:21:04 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659FB1F9AAD
	for <netfilter-devel@vger.kernel.org>; Tue, 17 Dec 2024 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470464; cv=none; b=ldgQAr5bCww8l5la3ksIHJIQ/t5yrhRi8v3To0jhSO15GJdVFFM4S9raLF9IEWosp3Ql0S8a7vA3cuDebLxSYQ/GWOuHL+48VDkOPPhnToCoOyOmnhEJgMHClrvq0h6GVVnmH4OPKiYOu1/Flt8A0IVCcLRpam/e7Ko+UhgzE68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470464; c=relaxed/simple;
	bh=rEw/kvMUbf60XiLZkSc54K9UHLkqKFmyxehgMK/ciJk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iNtIrS2uyuTGFX+Z5RluzwFFlI9PQKHeQR0eLzfMktPjZOFiQpMsBcnmT+rSh8BJNpbhWxAM+mypEoFGyO2AUbt7iwC0HJ82ch2I1wvqO7CI/gFSG5acW7aeDlXNbC2VT6+qm7BKybdaI2cdbKkrCTZwYHClk6iRVz16bskQik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft 3/6] src: add EXPR_RANGE_VALUE expression and use it
Date: Tue, 17 Dec 2024 22:15:13 +0100
Message-Id: <20241217211516.1644623-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241217211516.1644623-1-pablo@netfilter.org>
References: <20241217211516.1644623-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set element with range takes 4 instances of struct expr:

  EXPR_SET_ELEM -> EXPR_RANGE -> (2) EXPR_VALUE

where EXPR_RANGE represents two references to struct expr with constant
value.

This new EXPR_RANGE_VALUE trims it down to two expressions:

  EXPR_SET_ELEM -> EXPR_RANGE_VALUE

with two direct low and high values that represent the range:

  struct {
      mpz_t low;
      mpz_t high;
  };

this two new direct values in struct expr do not modify its size.

setelem_expr_to_range() translates EXPR_RANGE to EXPR_RANGE_VALUE, this
conversion happens at a later stage.

constant_range_expr_print() translates this structure to constant values
to reuse the existing datatype_print() which relies in singleton values.

The automerge routine has been updated to use EXPR_RANGE_VALUE.

This requires a follow up patch to rework the conversion from range
expression to singleton element to provide a noticeable memory
consumption reduction.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/expression.h | 13 +++++++
 src/expression.c     | 85 +++++++++++++++++++++++++++++++++++++++++
 src/intervals.c      | 90 +++++++++++++++++++++++---------------------
 src/mergesort.c      |  2 +
 4 files changed, 147 insertions(+), 43 deletions(-)

diff --git a/include/expression.h b/include/expression.h
index 877887ff1978..f2b45250872d 100644
--- a/include/expression.h
+++ b/include/expression.h
@@ -48,6 +48,7 @@
  * @EXPR_XFRM		XFRM (ipsec) expression
  * @EXPR_SET_ELEM_CATCHALL catchall element expression
  * @EXPR_FLAGCMP	flagcmp expression
+ * @EXPR_RANGE_VALUE	constant range expression
  */
 enum expr_types {
 	EXPR_INVALID,
@@ -80,6 +81,7 @@ enum expr_types {
 	EXPR_XFRM,
 	EXPR_SET_ELEM_CATCHALL,
 	EXPR_FLAGCMP,
+	EXPR_RANGE_VALUE,
 
 	EXPR_MAX = EXPR_FLAGCMP
 };
@@ -278,6 +280,11 @@ struct expr {
 			/* EXPR_VALUE */
 			mpz_t			value;
 		};
+		struct {
+			/* EXPR_RANGE_VALUE */
+			mpz_t			low;
+			mpz_t			high;
+		} range;
 		struct {
 			/* EXPR_PREFIX */
 			struct expr		*prefix;
@@ -473,6 +480,12 @@ extern struct expr *constant_expr_join(const struct expr *e1,
 				       const struct expr *e2);
 extern struct expr *constant_expr_splice(struct expr *expr, unsigned int len);
 
+extern struct expr *constant_range_expr_alloc(const struct location *loc,
+					      const struct datatype *dtype,
+					      enum byteorder byteorder,
+					      unsigned int len,
+					      mpz_t low, mpz_t high);
+
 extern struct expr *flag_expr_alloc(const struct location *loc,
 				    const struct datatype *dtype,
 				    enum byteorder byteorder,
diff --git a/src/expression.c b/src/expression.c
index 62786f483eed..bee379800501 100644
--- a/src/expression.c
+++ b/src/expression.c
@@ -542,6 +542,86 @@ struct expr *constant_expr_splice(struct expr *expr, unsigned int len)
 	return slice;
 }
 
+static void constant_range_expr_print(const struct expr *expr,
+				      struct output_ctx *octx)
+{
+	unsigned char data[sizeof(struct in6_addr) * BITS_PER_BYTE];
+	unsigned int flags = octx->flags;
+	struct expr *value;
+
+	octx->flags &= ~(NFT_CTX_OUTPUT_SERVICE |
+			 NFT_CTX_OUTPUT_REVERSEDNS |
+			 NFT_CTX_OUTPUT_GUID);
+	octx->flags |= NFT_CTX_OUTPUT_NUMERIC_ALL;
+
+	/* create dummy temporary constant expression to print range. */
+	mpz_export_data(data, expr->range.low, expr->byteorder, expr->len / BITS_PER_BYTE);
+	value = constant_expr_alloc(&expr->location,
+				    expr->dtype,
+				    expr->byteorder,
+				    expr->len,
+				    data);
+	expr_print(value, octx);
+	expr_free(value);
+
+	nft_print(octx, "-");
+
+	mpz_export_data(data, expr->range.high, expr->byteorder, expr->len / BITS_PER_BYTE);
+	value = constant_expr_alloc(&expr->location,
+				    expr->dtype,
+				    expr->byteorder,
+				    expr->len,
+				    data);
+	expr_print(value, octx);
+	expr_free(value);
+
+	octx->flags = flags;
+}
+
+static bool constant_range_expr_cmp(const struct expr *e1, const struct expr *e2)
+{
+	return expr_basetype(e1) == expr_basetype(e2) &&
+	       !mpz_cmp(e1->range.low, e2->range.low) &&
+	       !mpz_cmp(e1->range.high, e2->range.high);
+}
+
+static void constant_range_expr_clone(struct expr *new, const struct expr *expr)
+{
+	mpz_init_set(new->range.low, expr->range.low);
+	mpz_init_set(new->range.high, expr->range.high);
+}
+
+static void constant_range_expr_destroy(struct expr *expr)
+{
+	mpz_clear(expr->range.low);
+	mpz_clear(expr->range.high);
+}
+
+static const struct expr_ops constant_range_expr_ops = {
+	.type		= EXPR_RANGE_VALUE,
+	.name		= "range_value",
+	.print		= constant_range_expr_print,
+	.cmp		= constant_range_expr_cmp,
+	.clone		= constant_range_expr_clone,
+	.destroy	= constant_range_expr_destroy,
+};
+
+struct expr *constant_range_expr_alloc(const struct location *loc,
+				       const struct datatype *dtype,
+				       enum byteorder byteorder,
+				       unsigned int len, mpz_t low, mpz_t high)
+{
+	struct expr *expr;
+
+	expr = expr_alloc(loc, EXPR_RANGE_VALUE, dtype, byteorder, len);
+	expr->flags = EXPR_F_CONSTANT | EXPR_F_SINGLETON;
+
+	mpz_init_set(expr->range.low, low);
+	mpz_init_set(expr->range.high, high);
+
+	return expr;
+}
+
 /*
  * Allocate a constant expression with a single bit set at position n.
  */
@@ -1545,6 +1625,8 @@ void range_expr_value_low(mpz_t rop, const struct expr *expr)
 	switch (expr->etype) {
 	case EXPR_VALUE:
 		return mpz_set(rop, expr->value);
+	case EXPR_RANGE_VALUE:
+		return mpz_set(rop, expr->range.low);
 	case EXPR_PREFIX:
 		return range_expr_value_low(rop, expr->prefix);
 	case EXPR_RANGE:
@@ -1565,6 +1647,8 @@ void range_expr_value_high(mpz_t rop, const struct expr *expr)
 	switch (expr->etype) {
 	case EXPR_VALUE:
 		return mpz_set(rop, expr->value);
+	case EXPR_RANGE_VALUE:
+		return mpz_set(rop, expr->range.high);
 	case EXPR_PREFIX:
 		range_expr_value_low(rop, expr->prefix);
 		assert(expr->len >= expr->prefix_len);
@@ -1616,6 +1700,7 @@ static const struct expr_ops *__expr_ops_by_type(enum expr_types etype)
 	case EXPR_XFRM: return &xfrm_expr_ops;
 	case EXPR_SET_ELEM_CATCHALL: return &set_elem_catchall_expr_ops;
 	case EXPR_FLAGCMP: return &flagcmp_expr_ops;
+	case EXPR_RANGE_VALUE: return &constant_range_expr_ops;
 	}
 
 	return NULL;
diff --git a/src/intervals.c b/src/intervals.c
index 6308cc8e2c08..c46874d9a6ce 100644
--- a/src/intervals.c
+++ b/src/intervals.c
@@ -17,15 +17,24 @@ static void set_to_range(struct expr *init);
 
 static void setelem_expr_to_range(struct expr *expr)
 {
-	unsigned char data[sizeof(struct in6_addr) * BITS_PER_BYTE];
-	struct expr *key, *value;
+	struct expr *key;
 	mpz_t rop;
 
 	assert(expr->etype == EXPR_SET_ELEM);
 
 	switch (expr->key->etype) {
 	case EXPR_SET_ELEM_CATCHALL:
+	case EXPR_RANGE_VALUE:
+		break;
 	case EXPR_RANGE:
+		key = constant_range_expr_alloc(&expr->location,
+						expr->key->dtype,
+						expr->key->byteorder,
+						expr->key->len,
+						expr->key->left->value,
+						expr->key->right->value);
+		expr_free(expr->key);
+		expr->key = key;
 		break;
 	case EXPR_PREFIX:
 		if (expr->key->prefix->etype != EXPR_VALUE)
@@ -37,16 +46,13 @@ static void setelem_expr_to_range(struct expr *expr)
 			mpz_switch_byteorder(expr->key->prefix->value, expr->len / BITS_PER_BYTE);
 
 		mpz_ior(rop, rop, expr->key->prefix->value);
-	        mpz_export_data(data, rop, expr->key->prefix->byteorder,
-				expr->key->prefix->len / BITS_PER_BYTE);
+		key = constant_range_expr_alloc(&expr->location,
+						expr->key->dtype,
+						expr->key->byteorder,
+						expr->key->len,
+						expr->key->prefix->value,
+						rop);
 		mpz_clear(rop);
-		value = constant_expr_alloc(&expr->location,
-					    expr->key->prefix->dtype,
-					    expr->key->prefix->byteorder,
-					    expr->key->prefix->len, data);
-		key = range_expr_alloc(&expr->location,
-				       expr_get(expr->key->prefix),
-				       value);
 		expr_free(expr->key);
 		expr->key = key;
 		break;
@@ -54,9 +60,12 @@ static void setelem_expr_to_range(struct expr *expr)
 		if (expr_basetype(expr)->type == TYPE_STRING)
 			mpz_switch_byteorder(expr->key->value, expr->len / BITS_PER_BYTE);
 
-		key = range_expr_alloc(&expr->location,
-				       expr_clone(expr->key),
-				       expr_get(expr->key));
+		key = constant_range_expr_alloc(&expr->location,
+						expr->key->dtype,
+						expr->key->byteorder,
+						expr->key->len,
+						expr->key->value,
+						expr->key->value);
 		expr_free(expr->key);
 		expr->key = key;
 		break;
@@ -76,8 +85,8 @@ static void purge_elem(struct set_automerge_ctx *ctx, struct expr *i)
 {
 	if (ctx->debug_mask & NFT_DEBUG_SEGTREE) {
 		pr_gmp_debug("remove: [%Zx-%Zx]\n",
-			     i->key->left->value,
-			     i->key->right->value);
+			     i->key->range.low,
+			     i->key->range.high);
 	}
 	list_move_tail(&i->list, &ctx->purge->expressions);
 }
@@ -107,19 +116,16 @@ static bool merge_ranges(struct set_automerge_ctx *ctx,
 	if (prev->flags & EXPR_F_KERNEL) {
 		prev->location = i->location;
 		purge_elem(ctx, prev);
-		expr_free(i->key->left);
-		i->key->left = expr_get(prev->key->left);
+		mpz_set(i->key->range.low, prev->key->range.low);
 		mpz_set(prev_range->high, range->high);
 		return true;
 	} else if (i->flags & EXPR_F_KERNEL) {
 		i->location = prev->location;
 		purge_elem(ctx, i);
-		expr_free(prev->key->right);
-		prev->key->right = expr_get(i->key->right);
+		mpz_set(prev->key->range.high, i->key->range.high);
 		mpz_set(prev_range->high, range->high);
 	} else {
-		expr_free(prev->key->right);
-		prev->key->right = expr_get(i->key->right);
+		mpz_set(prev->key->range.high, i->key->range.high);
 		mpz_set(prev_range->high, range->high);
 		list_del(&i->list);
 		expr_free(i);
@@ -156,6 +162,8 @@ static void set_prev_elem(struct expr **prev, struct expr *i,
 	mpz_set(prev_range->high, range->high);
 }
 
+static struct expr *interval_expr_key(struct expr *i);
+
 static void setelem_automerge(struct set_automerge_ctx *ctx)
 {
 	struct expr *i, *next, *prev = NULL;
@@ -270,7 +278,7 @@ int set_automerge(struct list_head *msgs, struct cmd *cmd, struct set *set,
 		} else if (existing_set) {
 			if (debug_mask & NFT_DEBUG_SEGTREE) {
 				pr_gmp_debug("add: [%Zx-%Zx]\n",
-					     i->key->left->value, i->key->right->value);
+					     i->key->range.low, i->key->range.high);
 			}
 			clone = expr_clone(i);
 			clone->flags |= EXPR_F_KERNEL;
@@ -304,9 +312,8 @@ static void remove_elem(struct expr *prev, struct set *set, struct expr *purge)
 static void __adjust_elem_left(struct set *set, struct expr *prev, struct expr *i)
 {
 	prev->flags &= ~EXPR_F_KERNEL;
-	expr_free(prev->key->left);
-	prev->key->left = expr_get(i->key->right);
-	mpz_add_ui(prev->key->left->value, prev->key->left->value, 1);
+	mpz_set(prev->key->range.low, i->key->range.high);
+	mpz_add_ui(prev->key->range.low, prev->key->range.low, 1);
 	list_move(&prev->list, &set->existing_set->init->expressions);
 }
 
@@ -324,9 +331,8 @@ static void adjust_elem_left(struct set *set, struct expr *prev, struct expr *i,
 static void __adjust_elem_right(struct set *set, struct expr *prev, struct expr *i)
 {
 	prev->flags &= ~EXPR_F_KERNEL;
-	expr_free(prev->key->right);
-	prev->key->right = expr_get(i->key->left);
-	mpz_sub_ui(prev->key->right->value, prev->key->right->value, 1);
+	mpz_set(prev->key->range.high, i->key->range.low);
+	mpz_sub_ui(prev->key->range.high, prev->key->range.high, 1);
 	list_move(&prev->list, &set->existing_set->init->expressions);
 }
 
@@ -355,14 +361,12 @@ static void split_range(struct set *set, struct expr *prev, struct expr *i,
 
 	prev->flags &= ~EXPR_F_KERNEL;
 	clone = expr_clone(prev);
-	expr_free(clone->key->left);
-	clone->key->left = expr_get(i->key->right);
-	mpz_add_ui(clone->key->left->value, i->key->right->value, 1);
+	mpz_set(clone->key->range.low, i->key->range.high);
+	mpz_add_ui(clone->key->range.low, i->key->range.high, 1);
 	list_add_tail(&clone->list, &set->existing_set->init->expressions);
 
-	expr_free(prev->key->right);
-	prev->key->right = expr_get(i->key->left);
-	mpz_sub_ui(prev->key->right->value, i->key->left->value, 1);
+	mpz_set(prev->key->range.high, i->key->range.low);
+	mpz_sub_ui(prev->key->range.high, i->key->range.low, 1);
 	list_move(&prev->list, &set->existing_set->init->expressions);
 
 	list_del(&i->list);
@@ -535,13 +539,13 @@ int set_delete(struct list_head *msgs, struct cmd *cmd, struct set *set,
 	if (debug_mask & NFT_DEBUG_SEGTREE) {
 		list_for_each_entry(i, &init->expressions, list)
 			pr_gmp_debug("remove: [%Zx-%Zx]\n",
-				     i->key->left->value, i->key->right->value);
+				     i->key->range.low, i->key->range.high);
 		list_for_each_entry(i, &add->expressions, list)
 			pr_gmp_debug("add: [%Zx-%Zx]\n",
-				     i->key->left->value, i->key->right->value);
+				     i->key->range.low, i->key->range.high);
 		list_for_each_entry(i, &existing_set->init->expressions, list)
 			pr_gmp_debug("existing: [%Zx-%Zx]\n",
-				     i->key->left->value, i->key->right->value);
+				     i->key->range.low, i->key->range.high);
 	}
 
 	if (list_empty(&add->expressions)) {
@@ -696,7 +700,7 @@ int set_to_intervals(const struct set *set, struct expr *init, bool add)
 			continue;
 
 		if (!prev && segtree_needs_first_segment(set, init, add) &&
-		    mpz_cmp_ui(elem->key->left->value, 0)) {
+		    mpz_cmp_ui(elem->key->range.low, 0)) {
 			mpz_set_ui(p, 0);
 			expr = constant_expr_alloc(&internal_location,
 						   set->key->dtype,
@@ -720,15 +724,15 @@ int set_to_intervals(const struct set *set, struct expr *init, bool add)
 				mpz_switch_byteorder(p, set->key->len / BITS_PER_BYTE);
 
 			if (!(set->flags & NFT_SET_ANONYMOUS) ||
-			    mpz_cmp(p, elem->key->left->value) != 0)
+			    mpz_cmp(p, elem->key->range.low) != 0)
 				list_add_tail(&newelem->list, &intervals);
 			else
 				expr_free(newelem);
 		}
 		newelem = NULL;
 
-		if (mpz_scan0(elem->key->right->value, 0) != set->key->len) {
-			mpz_add_ui(p, elem->key->right->value, 1);
+		if (mpz_scan0(elem->key->range.high, 0) != set->key->len) {
+			mpz_add_ui(p, elem->key->range.high, 1);
 			expr = constant_expr_alloc(&elem->key->location, set->key->dtype,
 						   set->key->byteorder, set->key->len,
 						   NULL);
@@ -750,7 +754,7 @@ int set_to_intervals(const struct set *set, struct expr *init, bool add)
 		expr = constant_expr_alloc(&elem->key->location, set->key->dtype,
 					   set->key->byteorder, set->key->len, NULL);
 
-		mpz_set(expr->value, elem->key->left->value);
+		mpz_set(expr->value, elem->key->range.low);
 		if (set->key->byteorder == BYTEORDER_HOST_ENDIAN)
 			mpz_switch_byteorder(expr->value, set->key->len / BITS_PER_BYTE);
 
diff --git a/src/mergesort.c b/src/mergesort.c
index 5e676be16369..0452d60ad42b 100644
--- a/src/mergesort.c
+++ b/src/mergesort.c
@@ -38,6 +38,8 @@ static mpz_srcptr expr_msort_value(const struct expr *expr, mpz_t value)
 		return expr_msort_value(expr->left, value);
 	case EXPR_VALUE:
 		return expr->value;
+	case EXPR_RANGE_VALUE:
+		return expr->range.low;
 	case EXPR_CONCAT:
 		concat_expr_msort_value(expr, value);
 		break;
-- 
2.30.2


