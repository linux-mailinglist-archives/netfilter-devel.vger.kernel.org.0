Return-Path: <netfilter-devel+bounces-8707-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3867CB45CF3
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Sep 2025 17:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F9A1887D2C
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Sep 2025 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDF8393DD1;
	Fri,  5 Sep 2025 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="rUzUvprH";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="IAionUJV"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82D37C108
	for <netfilter-devel@vger.kernel.org>; Fri,  5 Sep 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087133; cv=none; b=McVTTaHBVkzbbK0GeOrrshHjmf2ZN/ndia0ZSTCI2xaOE34orchz6NZ1lLijWt0aCL+gwx8YdaUnmGwK+7npimgjDRdIRo9v30AfFXqeglZrpF2Zxdjf7ZYNJLT5Sf7Waug4ksslKuTI6rsLVP6GPsay1UhN+hpXN1RBOPARrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087133; c=relaxed/simple;
	bh=WGNCmmKEqAWTvGKYZk6nEXt3DwTlEZZuVfY6I+tImqg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aclCMTQHicBWfxM0xtlDcy672JgYbwPykILvi6kebASa7nUDsZNd46gDKxGHnE58vAbnlSItfO5bmDrJI//cmFjlQsb1SfVpwQRKzidbioQnqZHwJotrxq7taYfladnZ1/xSBsuxBmBWudLutpVfp1IHdDtHZydYveZNI5EIGEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=rUzUvprH; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=IAionUJV; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 92F74608D7; Fri,  5 Sep 2025 17:36:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1757086599;
	bh=E/BiHA7XeYXq9ivmgpBvrq31/ZvSrQUTN4ac/FQiCZk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rUzUvprHL6WoBXiBeBO9koXEynY9D724QdZVyRY5qLrU6Dv/Pf0lJzu5ht9a2UK2x
	 INLld9LpmkqjaUPpDG9KvvA0tlwzbW0KcGwdna5c2iaRCXZnCpYehbX1rS9palbuRM
	 MD4ikpNnu9aUNjyyIaO7G5MLAN4uiJlXggIxxg1G7eMNPEZzn6rM7UoqddhnfGxOs7
	 dCXOGL9iOA0JujNAnkak7CZdFEqIOaSJKn04xQo53K1PvJnnp8PEjRaoj96nl7fSaw
	 U7nLtq9I9FbygLjFSmdl36filAi1xyPKxK04I6P+e7b1pwAE6o60cR6VYKREwS9FSK
	 El0VgvHvSzI4Q==
X-Spam-Level: 
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 912A2608B8
	for <netfilter-devel@vger.kernel.org>; Fri,  5 Sep 2025 17:36:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1757086596;
	bh=E/BiHA7XeYXq9ivmgpBvrq31/ZvSrQUTN4ac/FQiCZk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IAionUJV4Lj2/BF5naGdcAiQo701YSzhsueC1UA6Tp1IPzUJd4JR8SQoCj19uLQLL
	 LGcmSLBYO4RwY2IJ1ipfKeQRDTiUUlsehvCFRPIJs3WKcG3Tpm0HfDmicvdQoxPu6E
	 uLGHwj5yMFmEEhtJ1AJIfPrBkv58na5W24pcOG0w8tq7bEjVV5qfV/qIlip7I67zyz
	 OBSR9vVaezrw0QcbfeYpknh94h9lqxGxfLa+5yL53UQvat20AkesD3XZMSWbRdhxsL
	 fZyLvU3I9F/IzBKxFrBwrVxGQpN2x4ccmCorE2svyRSzkdXgn/bem5JAqMHIIz7Dmv
	 5QhaFNz56l16g==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/7] src: normalize set element with EXPR_MAPPING
Date: Fri,  5 Sep 2025 17:36:21 +0200
Message-Id: <20250905153627.1315405-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250905153627.1315405-1-pablo@netfilter.org>
References: <20250905153627.1315405-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EXPR_SET_ELEM provides the timeout, expiration, comment and list of
statements, this is a shim expression.

Currently, expr_set(x)->expressions can have either:

- EXPR_SET_ELEM

        EXPR_SET_ELEM -> EXPR_VALUE

- EXPR_MAPPING, which contains EXPR_SET_ELEM in the lhs.

                      EXPR_SET_ELEM -> EXPR_VALUE
                     /
	EXPR_MAPPING |
                     \
                      EXPR_VALUE

This patch normalizes the expression for mappings:

                                       EXPR_SET_ELEM -> EXPR_VALUE
                                      /
	EXPR_SET_ELEM -> EXPR_MAPPING |
                                      \
                                       EXPR_VALUE

The previous representation makes it natural for expr_print() to print the
timeout, expiration, statements and comments.

	1.1.1.1 counter packets 1 bytes 564 : 0x00000001,

This patch adds an exception for expr_mapping_print() to stick to the
existing representation.

The JSON representation provides this set element information too in the
lhs, which is does not really belong there because it is exposing
transparently the syntax tree for set elements. A workaround to retain
compatibility is included in this patch.

The end goal is to replace EXPR_SET_ELEM by a smaller shim object, to
further reduce memory consumption in set elements in userspace.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/expression.h      |   4 +-
 src/datatype.c            |   1 +
 src/evaluate.c            |  68 +++++++++++---------
 src/expression.c          |  27 ++++++--
 src/intervals.c           | 126 ++++++++++++++++++++++----------------
 src/json.c                |  32 ++++++++--
 src/netlink.c             |  95 ++++++++++++++--------------
 src/netlink_delinearize.c |   9 ++-
 src/optimize.c            |  49 ++++++++-------
 src/parser_bison.y        |  10 ++-
 src/parser_json.c         |  14 +++--
 src/segtree.c             |  31 +++++-----
 12 files changed, 282 insertions(+), 184 deletions(-)

diff --git a/include/expression.h b/include/expression.h
index e73ad90e7e5d..076a6a255228 100644
--- a/include/expression.h
+++ b/include/expression.h
@@ -563,7 +563,9 @@ extern struct expr *set_elem_expr_alloc(const struct location *loc,
 struct expr *set_elem_catchall_expr_alloc(const struct location *loc);
 
 #define expr_type_catchall(__expr)			\
-	((__expr)->etype == EXPR_SET_ELEM_CATCHALL)
+	((__expr)->etype == EXPR_SET_ELEM_CATCHALL ||	\
+	 ((__expr)->etype == EXPR_MAPPING &&		\
+	  (__expr)->left->etype == EXPR_SET_ELEM_CATCHALL))
 
 extern void range_expr_value_low(mpz_t rop, const struct expr *expr);
 extern void range_expr_value_high(mpz_t rop, const struct expr *expr);
diff --git a/src/datatype.c b/src/datatype.c
index f347010f4a1a..f130754fa338 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -1582,6 +1582,7 @@ const struct datatype boolean_type = {
 	.name		= "boolean",
 	.desc		= "boolean type",
 	.size		= 1,
+	.byteorder	= BYTEORDER_HOST_ENDIAN,
 	.parse		= boolean_type_parse,
 	.basetype	= &integer_type,
 	.sym_tbl	= &boolean_tbl,
diff --git a/src/evaluate.c b/src/evaluate.c
index b7e4f71fdfbc..3ed6f1b3f8ca 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1932,6 +1932,9 @@ static bool elem_key_compatible(const struct expr *set_key,
 	if (expr_type_catchall(elem_key))
 		return true;
 
+	if (elem_key->etype == EXPR_MAPPING)
+		return datatype_compatible(set_key->dtype, elem_key->left->dtype);
+
 	return datatype_compatible(set_key->dtype, elem_key->dtype);
 }
 
@@ -2005,14 +2008,6 @@ static int expr_evaluate_set_elem_catchall(struct eval_ctx *ctx, struct expr **e
 	return 0;
 }
 
-static const struct expr *expr_set_elem(const struct expr *expr)
-{
-	if (expr->etype == EXPR_MAPPING)
-		return expr->left;
-
-	return expr;
-}
-
 static int interval_set_eval(struct eval_ctx *ctx, struct set *set,
 			     struct expr *init)
 {
@@ -2064,18 +2059,19 @@ static int expr_evaluate_set(struct eval_ctx *ctx, struct expr **expr)
 	const struct expr *elem;
 
 	list_for_each_entry_safe(i, next, &expr_set(set)->expressions, list) {
+		/* recursive EXPR_SET are merged here. */
 		if (list_member_evaluate(ctx, &i) < 0)
 			return -1;
 
-		if (i->etype == EXPR_MAPPING &&
-		    i->left->etype == EXPR_SET_ELEM &&
-		    i->left->key->etype == EXPR_SET) {
+		if (i->key->etype == EXPR_MAPPING &&
+		    i->key->left->etype == EXPR_SET) {
 			struct expr *new, *j;
 
-			list_for_each_entry(j, &expr_set(i->left->key)->expressions, list) {
+			list_for_each_entry(j, &expr_set(i->key->left)->expressions, list) {
 				new = mapping_expr_alloc(&i->location,
-							 expr_get(j),
-							 expr_get(i->right));
+							 expr_get(j->key),
+							 expr_get(i->key->right));
+				new = set_elem_expr_alloc(&i->location, new);
 				list_add_tail(&new->list, &expr_set(set)->expressions);
 				expr_set(set)->size++;
 			}
@@ -2084,7 +2080,7 @@ static int expr_evaluate_set(struct eval_ctx *ctx, struct expr **expr)
 			continue;
 		}
 
-		elem = expr_set_elem(i);
+		elem = i;
 
 		if (elem->etype == EXPR_SET_ELEM &&
 		    elem->key->etype == EXPR_SET_REF)
@@ -2099,7 +2095,7 @@ static int expr_evaluate_set(struct eval_ctx *ctx, struct expr **expr)
 			list_replace(&i->list, &new->list);
 			expr_free(i);
 			i = new;
-			elem = expr_set_elem(i);
+			elem = i;
 		}
 
 		if (!expr_is_constant(i))
@@ -2115,7 +2111,9 @@ static int expr_evaluate_set(struct eval_ctx *ctx, struct expr **expr)
 			expr_free(i);
 		} else if (!expr_is_singleton(i)) {
 			expr_set(set)->set_flags |= NFT_SET_INTERVAL;
-			if (elem->key->etype == EXPR_CONCAT)
+			if ((elem->key->etype == EXPR_MAPPING &&
+			     elem->key->left->etype == EXPR_CONCAT) ||
+			    elem->key->etype == EXPR_CONCAT)
 				expr_set(set)->set_flags |= NFT_SET_CONCAT;
 		}
 	}
@@ -2186,10 +2184,12 @@ static int mapping_expr_expand(struct eval_ctx *ctx)
 		return 0;
 
 	list_for_each_entry(i, &expr_set(ctx->set->init)->expressions, list) {
-		if (i->etype != EXPR_MAPPING)
+		assert(i->etype == EXPR_SET_ELEM);
+
+		if (i->key->etype != EXPR_MAPPING)
 			return expr_error(ctx->msgs, i,
 					  "expected mapping, not %s", expr_name(i));
-		__mapping_expr_expand(i);
+		__mapping_expr_expand(i->key);
 	}
 
 	return 0;
@@ -2378,6 +2378,7 @@ static bool elem_data_compatible(const struct expr *set_data,
 
 static int expr_evaluate_mapping(struct eval_ctx *ctx, struct expr **expr)
 {
+	const struct expr *key = ctx->ectx.key;
 	struct expr *mapping = *expr;
 	struct set *set = ctx->set;
 	uint32_t datalen;
@@ -2389,6 +2390,8 @@ static int expr_evaluate_mapping(struct eval_ctx *ctx, struct expr **expr)
 		return set_error(ctx, set, "set is not a map");
 
 	expr_set_context(&ctx->ectx, set->key->dtype, set->key->len);
+	ctx->ectx.key = key;
+
 	if (expr_evaluate(ctx, &mapping->left) < 0)
 		return -1;
 	if (!expr_is_constant(mapping->left))
@@ -2691,11 +2694,15 @@ static int __binop_transfer(struct eval_ctx *ctx,
 		break;
 	case EXPR_SET:
 		list_for_each_entry(i, &expr_set(*right)->expressions, list) {
+			assert(i->etype == EXPR_SET_ELEM);
+
 			err = binop_can_transfer(ctx, left, i);
 			if (err <= 0)
 				return err;
 		}
 		list_for_each_entry_safe(i, next, &expr_set(*right)->expressions, list) {
+			assert(i->etype == EXPR_SET_ELEM);
+
 			list_del(&i->list);
 			err = binop_transfer_one(ctx, left, &i);
 			list_add_tail(&i->list, &next->list);
@@ -4463,8 +4470,10 @@ static bool nat_concat_map(struct eval_ctx *ctx, struct stmt *stmt)
 	switch (stmt->nat.addr->mappings->etype) {
 	case EXPR_SET:
 		list_for_each_entry(i, &expr_set(stmt->nat.addr->mappings)->expressions, list) {
-			if (i->etype == EXPR_MAPPING &&
-			    i->right->etype == EXPR_CONCAT) {
+			assert(i->etype == EXPR_SET_ELEM);
+
+			if (i->key->etype == EXPR_MAPPING &&
+			    i->key->right->etype == EXPR_CONCAT) {
 				stmt->nat.type_flags |= STMT_NAT_F_CONCAT;
 				return true;
 			}
@@ -5303,16 +5312,17 @@ static int set_evaluate(struct eval_ctx *ctx, struct set *set)
 	}
 
 	if (set_is_anonymous(set->flags) && set->key->etype == EXPR_CONCAT) {
-		struct expr *i;
+		struct expr *i, *key;
 
 		list_for_each_entry(i, &expr_set(set->init)->expressions, list) {
-			if ((i->etype == EXPR_SET_ELEM &&
-			     i->key->etype != EXPR_CONCAT &&
-			     i->key->etype != EXPR_SET_ELEM_CATCHALL) ||
-			    (i->etype == EXPR_MAPPING &&
-			     i->left->etype == EXPR_SET_ELEM &&
-			     i->left->key->etype != EXPR_CONCAT &&
-			     i->left->key->etype != EXPR_SET_ELEM_CATCHALL))
+			assert (i->etype == EXPR_SET_ELEM);
+
+			key = i->key;
+			if (key->etype == EXPR_MAPPING)
+				key = key->left;
+
+			if (key->etype != EXPR_CONCAT &&
+			    key->etype != EXPR_SET_ELEM_CATCHALL)
 				return expr_error(ctx->msgs, i, "expression is not a concatenation");
 		}
 	}
diff --git a/src/expression.c b/src/expression.c
index 019c263f187b..8b54b6a38ae5 100644
--- a/src/expression.c
+++ b/src/expression.c
@@ -1509,14 +1509,16 @@ struct expr *mapping_expr_alloc(const struct location *loc,
 
 static bool __set_expr_is_vmap(const struct expr *mappings)
 {
-	const struct expr *mapping;
+	const struct expr *elem;
 
 	if (list_empty(&expr_set(mappings)->expressions))
 		return false;
 
-	mapping = list_first_entry(&expr_set(mappings)->expressions, struct expr, list);
-	if (mapping->etype == EXPR_MAPPING &&
-	    mapping->right->etype == EXPR_VERDICT)
+	elem = list_first_entry(&expr_set(mappings)->expressions, struct expr, list);
+	assert(elem->etype == EXPR_SET_ELEM);
+
+	if (elem->key->etype == EXPR_MAPPING &&
+	    elem->key->right->etype == EXPR_VERDICT)
 		return true;
 
 	return false;
@@ -1647,7 +1649,17 @@ static void set_elem_expr_print(const struct expr *expr,
 {
 	struct stmt *stmt;
 
-	expr_print(expr->key, octx);
+	/* The mapping output needs to print lhs first, then timeout, expires,
+	 * comment and list of statements and finally rhs.
+	 *
+	 * Because EXPR_SET_ELEM always comes before EXPR_MAPPING, add this
+	 * special handling to print the output accordingly.
+	 */
+	if (expr->key->etype == EXPR_MAPPING)
+		expr_print(expr->key->left, octx);
+	else
+		expr_print(expr->key, octx);
+
 	list_for_each_entry(stmt, &expr->stmt_list, list) {
 		nft_print(octx, " ");
 		stmt_print(stmt, octx);
@@ -1667,6 +1679,11 @@ static void set_elem_expr_print(const struct expr *expr,
 	}
 	if (expr->comment)
 		nft_print(octx, " comment \"%s\"", expr->comment);
+
+	if (expr->key->etype == EXPR_MAPPING) {
+		nft_print(octx, " : ");
+		expr_print(expr->key->right, octx);
+	}
 }
 
 static void set_elem_expr_destroy(struct expr *expr)
diff --git a/src/intervals.c b/src/intervals.c
index a63c58ac9606..7df5ce2ab4db 100644
--- a/src/intervals.c
+++ b/src/intervals.c
@@ -15,65 +15,73 @@
 
 static void set_to_range(struct expr *init);
 
-static void setelem_expr_to_range(struct expr *expr)
+static void __setelem_expr_to_range(struct expr **exprp)
 {
-	struct expr *key;
+	struct expr *key, *expr = *exprp;
 	mpz_t rop;
 
-	assert(expr->etype == EXPR_SET_ELEM);
-
-	switch (expr->key->etype) {
+	switch (expr->etype) {
 	case EXPR_SET_ELEM_CATCHALL:
 	case EXPR_RANGE_VALUE:
 		break;
 	case EXPR_RANGE:
 		key = constant_range_expr_alloc(&expr->location,
-						expr->key->dtype,
-						expr->key->byteorder,
-						expr->key->len,
-						expr->key->left->value,
-						expr->key->right->value);
-		expr_free(expr->key);
-		expr->key = key;
+						expr->dtype,
+						expr->byteorder,
+						expr->len,
+						expr->left->value,
+						expr->right->value);
+		expr_free(*exprp);
+		*exprp = key;
 		break;
 	case EXPR_PREFIX:
-		if (expr->key->prefix->etype != EXPR_VALUE)
-			BUG("Prefix for unexpected type %d", expr->key->prefix->etype);
+		if (expr->prefix->etype != EXPR_VALUE)
+			BUG("Prefix for unexpected type %d", expr->prefix->etype);
 
 		mpz_init(rop);
-		mpz_bitmask(rop, expr->key->len - expr->key->prefix_len);
+		mpz_bitmask(rop, expr->len - expr->prefix_len);
 		if (expr_basetype(expr)->type == TYPE_STRING)
-			mpz_switch_byteorder(expr->key->prefix->value, expr->len / BITS_PER_BYTE);
+			mpz_switch_byteorder(expr->prefix->value, expr->len / BITS_PER_BYTE);
 
-		mpz_ior(rop, rop, expr->key->prefix->value);
+		mpz_ior(rop, rop, expr->prefix->value);
 		key = constant_range_expr_alloc(&expr->location,
-						expr->key->dtype,
-						expr->key->byteorder,
-						expr->key->len,
-						expr->key->prefix->value,
+						expr->dtype,
+						expr->byteorder,
+						expr->len,
+						expr->prefix->value,
 						rop);
 		mpz_clear(rop);
-		expr_free(expr->key);
-		expr->key = key;
+		expr_free(*exprp);
+		*exprp = key;
 		break;
 	case EXPR_VALUE:
 		if (expr_basetype(expr)->type == TYPE_STRING)
-			mpz_switch_byteorder(expr->key->value, expr->len / BITS_PER_BYTE);
+			mpz_switch_byteorder(expr->value, expr->len / BITS_PER_BYTE);
 
 		key = constant_range_expr_alloc(&expr->location,
-						expr->key->dtype,
-						expr->key->byteorder,
-						expr->key->len,
-						expr->key->value,
-						expr->key->value);
-		expr_free(expr->key);
-		expr->key = key;
+						expr->dtype,
+						expr->byteorder,
+						expr->len,
+						expr->value,
+						expr->value);
+		expr_free(*exprp);
+		*exprp = key;
 		break;
 	default:
-		BUG("unhandled key type %s\n", expr_name(expr->key));
+		BUG("unhandled key type %s\n", expr_name(expr));
 	}
 }
 
+static void setelem_expr_to_range(struct expr *expr)
+{
+	assert(expr->etype == EXPR_SET_ELEM);
+
+	if (expr->key->etype == EXPR_MAPPING)
+		__setelem_expr_to_range(&expr->key->left);
+	else
+		__setelem_expr_to_range(&expr->key);
+}
+
 struct set_automerge_ctx {
 	struct set	*set;
 	struct expr	*init;
@@ -219,9 +227,6 @@ static struct expr *interval_expr_key(struct expr *i)
 	struct expr *elem;
 
 	switch (i->etype) {
-	case EXPR_MAPPING:
-		elem = i->left;
-		break;
 	case EXPR_SET_ELEM:
 		elem = i;
 		break;
@@ -411,9 +416,17 @@ static int setelem_delete(struct list_head *msgs, struct set *set,
 		i = interval_expr_key(elem);
 
 		if (expr_type_catchall(i->key)) {
+			uint32_t len;
+
 			/* Assume max value to simplify handling. */
-			mpz_bitmask(range.low, i->len);
-			mpz_bitmask(range.high, i->len);
+			if (i->key->etype == EXPR_SET_ELEM_CATCHALL)
+				len = i->key->len;
+			else if (i->key->etype == EXPR_MAPPING &&
+				 i->key->left->etype == EXPR_SET_ELEM_CATCHALL)
+				len = i->key->left->len;
+
+			mpz_bitmask(range.low, len);
+			mpz_bitmask(range.high, len);
 		} else {
 			range_expr_value_low(range.low, i);
 			range_expr_value_high(range.high, i);
@@ -677,6 +690,20 @@ static bool segtree_needs_first_segment(const struct set *set,
 	return false;
 }
 
+static bool range_low_is_non_zero(const struct expr *expr)
+{
+	switch (expr->etype) {
+	case EXPR_RANGE_VALUE:
+		return mpz_cmp_ui(expr->range.low, 0);
+	case EXPR_MAPPING:
+		return range_low_is_non_zero(expr->left);
+	default:
+		BUG("unexpected expression %s\n", expr_name(expr));
+		break;
+	}
+	return false;
+}
+
 int set_to_intervals(const struct set *set, struct expr *init, bool add)
 {
 	struct expr *i, *n, *prev = NULL, *elem, *root, *expr;
@@ -693,7 +720,7 @@ int set_to_intervals(const struct set *set, struct expr *init, bool add)
 			break;
 
 		if (segtree_needs_first_segment(set, init, add) &&
-		    mpz_cmp_ui(elem->key->range.low, 0)) {
+		    range_low_is_non_zero(elem->key)) {
 			mpz_init2(p, set->key->len);
 			mpz_set_ui(p, 0);
 			expr = constant_range_expr_alloc(&internal_location,
@@ -703,11 +730,7 @@ int set_to_intervals(const struct set *set, struct expr *init, bool add)
 			mpz_clear(p);
 
 			root = set_elem_expr_alloc(&internal_location, expr);
-			if (i->etype == EXPR_MAPPING) {
-				root = mapping_expr_alloc(&internal_location,
-							  root,
-							  expr_get(i->right));
-			}
+
 			root->flags |= EXPR_F_INTERVAL_END;
 			list_add(&root->list, &intervals);
 			break;
@@ -749,12 +772,11 @@ static struct expr *setelem_key(struct expr *expr)
 	struct expr *key;
 
 	switch (expr->etype) {
-	case EXPR_MAPPING:
-		key = expr->left->key;
-		break;
 	case EXPR_SET_ELEM:
-		key = expr->key;
-		break;
+		if (expr->key->etype == EXPR_MAPPING)
+			return expr->key->left;
+
+		return expr->key;
 	default:
 		BUG("unhandled expression type %d\n", expr->etype);
 		return NULL;
@@ -804,13 +826,13 @@ int setelem_to_interval(const struct set *set, struct expr *elem,
 	if (set->key->byteorder == BYTEORDER_HOST_ENDIAN)
 		mpz_switch_byteorder(low->value, set->key->len / BITS_PER_BYTE);
 
+	if (elem->key->etype == EXPR_MAPPING)
+		low = mapping_expr_alloc(&elem->location,
+					 low, expr_get(elem->key->right));
+
 	low = set_elem_expr_alloc(&key->location, low);
 	set_elem_expr_copy(low, interval_expr_key(elem));
 
-	if (elem->etype == EXPR_MAPPING)
-		low = mapping_expr_alloc(&elem->location,
-					 low, expr_get(elem->right));
-
 	list_add_tail(&low->list, intervals);
 
 	if (adjacent)
diff --git a/src/json.c b/src/json.c
index d06fd0402714..36c03e581b4a 100644
--- a/src/json.c
+++ b/src/json.c
@@ -778,18 +778,19 @@ json_t *set_ref_expr_json(const struct expr *expr, struct output_ctx *octx)
 	}
 }
 
-json_t *set_elem_expr_json(const struct expr *expr, struct output_ctx *octx)
+static json_t *__set_elem_expr_json(const struct expr *expr,
+				    const struct expr *val,
+				    struct output_ctx *octx)
 {
-	json_t *root = expr_print_json(expr->key, octx);
+	json_t *root = expr_print_json(val, octx);
 	struct stmt *stmt;
 	json_t *tmp;
 
-	if (!root)
-		return NULL;
-
 	/* these element attributes require formal set elem syntax */
 	if (expr->timeout || expr->expiration || expr->comment ||
 	    !list_empty(&expr->stmt_list)) {
+		assert(expr->etype == EXPR_SET_ELEM);
+
 		root = nft_json_pack("{s:o}", "val", root);
 
 		if (expr->timeout) {
@@ -818,6 +819,27 @@ json_t *set_elem_expr_json(const struct expr *expr, struct output_ctx *octx)
 	return root;
 }
 
+json_t *set_elem_expr_json(const struct expr *expr, struct output_ctx *octx)
+{
+	json_t *left, *right;
+
+	assert(expr->etype == EXPR_SET_ELEM);
+
+	/* Special handling to retain backwards compatibility: json exposes
+	 * EXPR_MAPPING { left: EXPR_SET_ELEM, right: EXPR_{VALUE,CONCAT,SYMBOL}.
+	 * Revisit this at some point to accept the following input:
+	 * EXPR_SET_ELEM -> EXPR_MAPPING { left, right }
+	 */
+	if (expr->key->etype == EXPR_MAPPING) {
+		left = __set_elem_expr_json(expr, expr->key->left, octx);
+		right = expr_print_json(expr->key->right, octx);
+
+		return nft_json_pack("[o, o]", left, right);
+	}
+
+	return __set_elem_expr_json(expr, expr->key, octx);
+}
+
 json_t *prefix_expr_json(const struct expr *expr, struct output_ctx *octx)
 {
 	json_t *root = expr_print_json(expr->prefix, octx);
diff --git a/src/netlink.c b/src/netlink.c
index 5876c08929f7..10817e5cfb53 100644
--- a/src/netlink.c
+++ b/src/netlink.c
@@ -102,7 +102,7 @@ static void __netlink_gen_data(const struct expr *expr,
 struct nftnl_set_elem *alloc_nftnl_setelem(const struct expr *set,
 					   const struct expr *expr)
 {
-	const struct expr *elem, *data;
+	const struct expr *data, *elem;
 	struct nftnl_set_elem *nlse;
 	struct nft_data_linearize nld;
 	struct nftnl_udata_buf *udbuf = NULL;
@@ -115,18 +115,20 @@ struct nftnl_set_elem *alloc_nftnl_setelem(const struct expr *set,
 	if (nlse == NULL)
 		memory_allocation_error();
 
+	if (expr->etype != EXPR_SET_ELEM)
+		BUG("Unexpected expression type: got %d\n", expr->etype);
+
 	data = NULL;
-	if (expr->etype == EXPR_MAPPING) {
-		elem = expr->left;
-		if (!(expr->flags & EXPR_F_INTERVAL_END))
-			data = expr->right;
+	if (expr->key->etype == EXPR_MAPPING) {
+		if (!(expr->key->flags & EXPR_F_INTERVAL_END))
+			data = expr->key->right;
+
+		key = expr->key->left;
 	} else {
-		elem = expr;
+		key = expr->key;
 	}
-	if (elem->etype != EXPR_SET_ELEM)
-		BUG("Unexpected expression type: got %d\n", elem->etype);
 
-	key = elem->key;
+	elem = expr;
 
 	switch (key->etype) {
 	case EXPR_SET_ELEM_CATCHALL:
@@ -571,6 +573,8 @@ static void netlink_gen_key(const struct expr *expr,
 		return netlink_gen_range(expr, data);
 	case EXPR_PREFIX:
 		return netlink_gen_prefix(expr, data);
+	case EXPR_MAPPING:
+		return netlink_gen_key(expr->left, data);
 	default:
 		BUG("invalid data expression type %s\n", expr_name(expr));
 	}
@@ -1509,41 +1513,6 @@ key_end:
 		return 0;
 	}
 
-	expr = set_elem_expr_alloc(&netlink_location, key);
-	expr->flags |= EXPR_F_KERNEL;
-
-	if (nftnl_set_elem_is_set(nlse, NFTNL_SET_ELEM_TIMEOUT)) {
-		expr->timeout	 = nftnl_set_elem_get_u64(nlse, NFTNL_SET_ELEM_TIMEOUT);
-		if (expr->timeout == 0)
-			expr->timeout	 = NFT_NEVER_TIMEOUT;
-	}
-
-	if (nftnl_set_elem_is_set(nlse, NFTNL_SET_ELEM_EXPIRATION))
-		expr->expiration = nftnl_set_elem_get_u64(nlse, NFTNL_SET_ELEM_EXPIRATION);
-	if (nftnl_set_elem_is_set(nlse, NFTNL_SET_ELEM_USERDATA)) {
-		set_elem_parse_udata(nlse, expr);
-		if (expr->comment)
-			set->elem_has_comment = true;
-	}
-	if (nftnl_set_elem_is_set(nlse, NFTNL_SET_ELEM_EXPR)) {
-		const struct nftnl_expr *nle;
-		struct stmt *stmt;
-
-		nle = nftnl_set_elem_get(nlse, NFTNL_SET_ELEM_EXPR, NULL);
-		stmt = netlink_parse_set_expr(set, &ctx->nft->cache, nle);
-		list_add_tail(&stmt->list, &setelem_parse_ctx.stmt_list);
-	} else if (nftnl_set_elem_is_set(nlse, NFTNL_SET_ELEM_EXPRESSIONS)) {
-		nftnl_set_elem_expr_foreach(nlse, set_elem_parse_expressions,
-					    &setelem_parse_ctx);
-	}
-	list_splice_tail_init(&setelem_parse_ctx.stmt_list, &expr->stmt_list);
-
-	if (flags & NFT_SET_ELEM_INTERVAL_END) {
-		expr->flags |= EXPR_F_INTERVAL_END;
-		if (mpz_cmp_ui(set->key->value, 0) == 0)
-			set->root = true;
-	}
-
 	if (set_is_datamap(set->flags)) {
 		if (nftnl_set_elem_is_set(nlse, NFTNL_SET_ELEM_DATA)) {
 			nld.value = nftnl_set_elem_get(nlse, NFTNL_SET_ELEM_DATA,
@@ -1574,7 +1543,7 @@ key_end:
 		if (data->byteorder == BYTEORDER_HOST_ENDIAN)
 			mpz_switch_byteorder(data->value, data->len / BITS_PER_BYTE);
 
-		expr = mapping_expr_alloc(&netlink_location, expr, data);
+		key = mapping_expr_alloc(&netlink_location, key, data);
 	}
 	if (set_is_objmap(set->flags)) {
 		if (nftnl_set_elem_is_set(nlse, NFTNL_SET_ELEM_OBJREF)) {
@@ -1588,9 +1557,43 @@ key_end:
 		data->dtype = &string_type;
 		data->byteorder = BYTEORDER_HOST_ENDIAN;
 		mpz_switch_byteorder(data->value, data->len / BITS_PER_BYTE);
-		expr = mapping_expr_alloc(&netlink_location, expr, data);
+		key = mapping_expr_alloc(&netlink_location, key, data);
 	}
 out:
+	expr = set_elem_expr_alloc(&netlink_location, key);
+	expr->flags |= EXPR_F_KERNEL;
+
+	if (nftnl_set_elem_is_set(nlse, NFTNL_SET_ELEM_TIMEOUT)) {
+		expr->timeout	 = nftnl_set_elem_get_u64(nlse, NFTNL_SET_ELEM_TIMEOUT);
+		if (expr->timeout == 0)
+			expr->timeout	 = NFT_NEVER_TIMEOUT;
+	}
+
+	if (nftnl_set_elem_is_set(nlse, NFTNL_SET_ELEM_EXPIRATION))
+		expr->expiration = nftnl_set_elem_get_u64(nlse, NFTNL_SET_ELEM_EXPIRATION);
+	if (nftnl_set_elem_is_set(nlse, NFTNL_SET_ELEM_USERDATA)) {
+		set_elem_parse_udata(nlse, expr);
+		if (expr->comment)
+			set->elem_has_comment = true;
+	}
+	if (nftnl_set_elem_is_set(nlse, NFTNL_SET_ELEM_EXPR)) {
+		const struct nftnl_expr *nle;
+		struct stmt *stmt;
+
+		nle = nftnl_set_elem_get(nlse, NFTNL_SET_ELEM_EXPR, NULL);
+		stmt = netlink_parse_set_expr(set, &ctx->nft->cache, nle);
+		list_add_tail(&stmt->list, &setelem_parse_ctx.stmt_list);
+	} else if (nftnl_set_elem_is_set(nlse, NFTNL_SET_ELEM_EXPRESSIONS)) {
+		nftnl_set_elem_expr_foreach(nlse, set_elem_parse_expressions,
+					    &setelem_parse_ctx);
+	}
+	list_splice_tail_init(&setelem_parse_ctx.stmt_list, &expr->stmt_list);
+
+	if (flags & NFT_SET_ELEM_INTERVAL_END) {
+		expr->flags |= EXPR_F_INTERVAL_END;
+		if (mpz_cmp_ui(set->key->value, 0) == 0)
+			set->root = true;
+	}
 	set_expr_add(set->init, expr);
 
 	if (!(flags & NFT_SET_ELEM_INTERVAL_END) &&
diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 990edc824ad9..f4ebdfcbf2f3 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -2493,6 +2493,8 @@ static void binop_adjust(const struct expr *binop, struct expr *right,
 			break;
 
 		list_for_each_entry(i, &expr_set(right->set->init)->expressions, list) {
+			assert(i->etype == EXPR_SET_ELEM);
+
 			switch (i->key->etype) {
 			case EXPR_VALUE:
 				binop_adjust_one(binop, i->key, shift);
@@ -2501,8 +2503,11 @@ static void binop_adjust(const struct expr *binop, struct expr *right,
 				binop_adjust_one(binop, i->key->left, shift);
 				binop_adjust_one(binop, i->key->right, shift);
 				break;
-			case EXPR_SET_ELEM:
-				binop_adjust(binop, i->key->key, shift);
+			case EXPR_MAPPING:
+				if (i->key->left->etype == EXPR_RANGE)
+					binop_adjust(binop, i->key->left, shift);
+				else
+					binop_adjust_one(binop, i->key->left, shift);
 				break;
 			default:
 				BUG("unknown expression type %s\n", expr_name(i->key));
diff --git a/src/optimize.c b/src/optimize.c
index cdd6913a306d..422990d1ca6f 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -751,29 +751,31 @@ static void build_verdict_map(struct expr *expr, struct stmt *verdict,
 	switch (expr->etype) {
 	case EXPR_LIST:
 		list_for_each_entry(item, &expr_list(expr)->expressions, list) {
-			elem = set_elem_expr_alloc(&internal_location, expr_get(item));
+			mapping = mapping_expr_alloc(&internal_location, expr_get(item),
+						     expr_get(verdict->expr));
+
+			elem = set_elem_expr_alloc(&internal_location, mapping);
 			if (counter) {
 				counter_elem = counter_stmt_alloc(&counter->location);
 				list_add_tail(&counter_elem->list, &elem->stmt_list);
 			}
 
-			mapping = mapping_expr_alloc(&internal_location, elem,
-						     expr_get(verdict->expr));
-			set_expr_add(set, mapping);
+			set_expr_add(set, elem);
 		}
 		stmt_free(counter);
 		break;
 	case EXPR_SET:
 		list_for_each_entry(item, &expr_set(expr)->expressions, list) {
-			elem = set_elem_expr_alloc(&internal_location, expr_get(item->key));
+			mapping = mapping_expr_alloc(&internal_location, expr_get(item->key),
+						     expr_get(verdict->expr));
+
+			elem = set_elem_expr_alloc(&internal_location, mapping);
 			if (counter) {
 				counter_elem = counter_stmt_alloc(&counter->location);
 				list_add_tail(&counter_elem->list, &elem->stmt_list);
 			}
 
-			mapping = mapping_expr_alloc(&internal_location, elem,
-						     expr_get(verdict->expr));
-			set_expr_add(set, mapping);
+			set_expr_add(set, elem);
 		}
 		stmt_free(counter);
 		break;
@@ -784,13 +786,14 @@ static void build_verdict_map(struct expr *expr, struct stmt *verdict,
 	case EXPR_VALUE:
 	case EXPR_SYMBOL:
 	case EXPR_CONCAT:
-		elem = set_elem_expr_alloc(&internal_location, expr_get(expr));
+		mapping = mapping_expr_alloc(&internal_location, expr_get(expr),
+					     expr_get(verdict->expr));
+
+		elem = set_elem_expr_alloc(&internal_location, mapping);
 		if (counter)
 			list_add_tail(&counter->list, &elem->stmt_list);
 
-		mapping = mapping_expr_alloc(&internal_location, elem,
-					     expr_get(verdict->expr));
-		set_expr_add(set, mapping);
+		set_expr_add(set, elem);
 		break;
 	default:
 		assert(0);
@@ -890,15 +893,17 @@ static void __merge_concat_stmts_vmap(const struct optimize_ctx *ctx,
 
 	list_for_each_entry_safe(concat, next, &concat_list, list) {
 		list_del(&concat->list);
-		elem = set_elem_expr_alloc(&internal_location, concat);
+
+		mapping = mapping_expr_alloc(&internal_location, concat,
+					     expr_get(verdict->expr));
+
+		elem = set_elem_expr_alloc(&internal_location, mapping);
 		if (counter) {
 			counter_elem = counter_stmt_alloc(&counter->location);
 			list_add_tail(&counter_elem->list, &elem->stmt_list);
 		}
 
-		mapping = mapping_expr_alloc(&internal_location, elem,
-					     expr_get(verdict->expr));
-		set_expr_add(set, mapping);
+		set_expr_add(set, elem);
 	}
 	stmt_free(counter);
 }
@@ -1059,9 +1064,9 @@ static void merge_nat(const struct optimize_ctx *ctx,
 		nat_stmt = ctx->stmt_matrix[i][k];
 		nat_expr = stmt_nat_expr(nat_stmt);
 
-		elem = set_elem_expr_alloc(&internal_location, expr_get(expr));
-		mapping = mapping_expr_alloc(&internal_location, elem, nat_expr);
-		set_expr_add(set, mapping);
+		mapping = mapping_expr_alloc(&internal_location, expr_get(expr), nat_expr);
+		elem = set_elem_expr_alloc(&internal_location, mapping);
+		set_expr_add(set, elem);
 	}
 
 	stmt = ctx->stmt_matrix[from][merge->stmt[0]];
@@ -1116,9 +1121,9 @@ static void merge_concat_nat(const struct optimize_ctx *ctx,
 		nat_stmt = ctx->stmt_matrix[i][k];
 		nat_expr = stmt_nat_expr(nat_stmt);
 
-		elem = set_elem_expr_alloc(&internal_location, concat);
-		mapping = mapping_expr_alloc(&internal_location, elem, nat_expr);
-		set_expr_add(set, mapping);
+		mapping = mapping_expr_alloc(&internal_location, concat, nat_expr);
+		elem = set_elem_expr_alloc(&internal_location, mapping);
+		set_expr_add(set, elem);
 	}
 
 	concat = concat_expr_alloc(&internal_location);
diff --git a/src/parser_bison.y b/src/parser_bison.y
index 3fa75197d1cb..d0cb2f7f929f 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -3337,7 +3337,10 @@ verdict_map_list_expr	:	verdict_map_list_member_expr
 
 verdict_map_list_member_expr:	opt_newline	set_elem_expr	COLON	verdict_expr	opt_newline
 			{
-				$$ = mapping_expr_alloc(&@2, $2, $4);
+				struct expr *expr = $2;
+
+				expr->key = mapping_expr_alloc(&@2, $2->key, $4);
+				$$ = expr;
 			}
 			;
 
@@ -4604,7 +4607,10 @@ set_list_member_expr	:	opt_newline	set_expr	opt_newline
 			}
 			|	opt_newline	set_elem_expr	COLON	set_rhs_expr	opt_newline
 			{
-				$$ = mapping_expr_alloc(&@2, $2, $4);
+				struct expr *expr = $2;
+
+				expr->key = mapping_expr_alloc(&@2, $2->key, $4);
+				$$ = expr;
 			}
 			;
 
diff --git a/src/parser_json.c b/src/parser_json.c
index e78262505d24..875b4b8a5f18 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -1476,7 +1476,7 @@ static struct expr *json_parse_set_expr(struct json_ctx *ctx,
 	}
 
 	json_array_foreach(root, index, value) {
-		struct expr *expr;
+		struct expr *expr, *elem;
 		json_t *jleft, *jright;
 
 		if (!json_unpack(value, "[o, o!]", &jleft, &jright)) {
@@ -1488,8 +1488,13 @@ static struct expr *json_parse_set_expr(struct json_ctx *ctx,
 				expr_free(set_expr);
 				return NULL;
 			}
-			if (expr->etype != EXPR_SET_ELEM)
-				expr = set_elem_expr_alloc(int_loc, expr);
+
+			if (expr->etype != EXPR_SET_ELEM) {
+				elem = set_elem_expr_alloc(int_loc, expr);
+			} else {
+				elem = expr;
+				expr = expr->key;
+			}
 
 			expr2 = json_parse_set_rhs_expr(ctx, jright);
 			if (!expr2) {
@@ -1499,7 +1504,8 @@ static struct expr *json_parse_set_expr(struct json_ctx *ctx,
 				return NULL;
 			}
 			expr2 = mapping_expr_alloc(int_loc, expr, expr2);
-			expr = expr2;
+			elem->key = expr2;
+			expr = elem;
 		} else {
 			expr = json_parse_rhs_expr(ctx, value);
 
diff --git a/src/segtree.c b/src/segtree.c
index 88207a3987b8..b5be0005d1ea 100644
--- a/src/segtree.c
+++ b/src/segtree.c
@@ -113,9 +113,10 @@ struct expr *get_set_intervals(const struct set *set, const struct expr *init)
 static struct expr *expr_value(struct expr *expr)
 {
 	switch (expr->etype) {
-	case EXPR_MAPPING:
-		return expr->left->key;
 	case EXPR_SET_ELEM:
+		if (expr->key->etype == EXPR_MAPPING)
+			return expr->key->left;
+
 		return expr->key;
 	case EXPR_VALUE:
 		return expr;
@@ -167,17 +168,16 @@ out:
 
 static struct expr *__expr_to_set_elem(struct expr *low, struct expr *expr)
 {
-	struct expr *elem = set_elem_expr_alloc(&low->location, expr);
-
-	if (low->etype == EXPR_MAPPING) {
-		interval_expr_copy(elem, low->left);
+	struct expr *elem;
 
-		elem = mapping_expr_alloc(&low->location, elem,
-						    expr_clone(low->right));
-	} else {
-		interval_expr_copy(elem, low);
+	if (low->key->etype == EXPR_MAPPING) {
+		expr = mapping_expr_alloc(&low->location, expr,
+					  expr_clone(low->key->right));
 	}
+
+	elem = set_elem_expr_alloc(&low->location, expr);
 	elem->flags |= EXPR_F_KERNEL;
+	interval_expr_copy(elem, low);
 
 	return elem;
 }
@@ -237,6 +237,8 @@ int get_set_decompose(struct set *cache_set, struct set *set)
 	new_init = set_expr_alloc(&internal_location, set);
 
 	list_for_each_entry_safe(i, next, &expr_set(set->init)->expressions, list) {
+		assert(i->etype == EXPR_SET_ELEM);
+
 		if (i->flags & EXPR_F_INTERVAL_END && left) {
 			list_del(&left->list);
 			list_del(&i->list);
@@ -573,13 +575,10 @@ void interval_map_decompose(struct expr *set)
 	/* Sort elements */
 	n = 0;
 	list_for_each_entry_safe(i, next, &expr_set(set)->expressions, list) {
-		key = NULL;
-		if (i->etype == EXPR_SET_ELEM)
-			key = i->key;
-		else if (i->etype == EXPR_MAPPING)
-			key = i->left->key;
+		assert(i->etype == EXPR_SET_ELEM);
 
-		if (key && expr_type_catchall(key)) {
+		key = i->key;
+		if (expr_type_catchall(key)) {
 			list_del(&i->list);
 			catchall = i;
 			continue;
-- 
2.30.2


