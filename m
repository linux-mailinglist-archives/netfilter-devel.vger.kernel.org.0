Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A504EA9F5
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Mar 2022 11:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiC2JCb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Mar 2022 05:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiC2JC3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:02:29 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59DA3209A5A
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Mar 2022 02:00:46 -0700 (PDT)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 593BF63016
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Mar 2022 10:57:34 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v2 2/4] src: allow to use typeof of raw expressions in set declaration
Date:   Tue, 29 Mar 2022 11:00:39 +0200
Message-Id: <20220329090041.1156012-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220329090041.1156012-1-pablo@netfilter.org>
References: <20220329090041.1156012-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Use the dynamic datatype to allocate an instance of TYPE_INTEGER and set
length and byteorder. Add missing information to the set userdata area
for raw payload expressions which allows to rebuild the set typeof from
the listing path.

A few examples:

- With anonymous sets:

  nft add rule x y ip saddr . @ih,32,32 { 1.1.1.1 . 0x14, 2.2.2.2 . 0x1e }

- With named sets:

 table x {
        set y {
                typeof ip saddr . @ih,32,32
                elements = { 1.1.1.1 . 0x14 }
        }
 }

Incremental updates are also supported, eg.

 nft add element x y { 3.3.3.3 . 0x28 }

expr_evaluate_concat() is used to evaluate both set key definitions
and set key values, using two different function might help to simplify
this code in the future.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: - fix vmap with anonymous maps.
    - add more tests.

 include/datatype.h                            |  1 +
 include/expression.h                          |  2 +
 src/datatype.c                                |  2 +-
 src/evaluate.c                                | 75 ++++++++++++++++---
 src/expression.c                              |  6 +-
 src/mnl.c                                     |  4 +-
 src/netlink.c                                 | 33 +++++---
 src/payload.c                                 | 55 ++++++++++++--
 .../testcases/maps/dumps/typeof_raw_0.nft     | 13 ++++
 tests/shell/testcases/maps/typeof_raw_0       | 18 +++++
 .../testcases/sets/dumps/typeof_raw_0.nft     | 12 +++
 tests/shell/testcases/sets/typeof_raw_0       | 17 +++++
 12 files changed, 205 insertions(+), 33 deletions(-)
 create mode 100644 tests/shell/testcases/maps/dumps/typeof_raw_0.nft
 create mode 100755 tests/shell/testcases/maps/typeof_raw_0
 create mode 100644 tests/shell/testcases/sets/dumps/typeof_raw_0.nft
 create mode 100755 tests/shell/testcases/sets/typeof_raw_0

diff --git a/include/datatype.h b/include/datatype.h
index f5bb9dc4d937..b296cc1cac80 100644
--- a/include/datatype.h
+++ b/include/datatype.h
@@ -176,6 +176,7 @@ extern const struct datatype *datatype_lookup_byname(const char *name);
 extern struct datatype *datatype_get(const struct datatype *dtype);
 extern void datatype_set(struct expr *expr, const struct datatype *dtype);
 extern void datatype_free(const struct datatype *dtype);
+struct datatype *dtype_clone(const struct datatype *orig_dtype);
 
 struct parse_ctx {
 	struct symbol_tables	*tbl;
diff --git a/include/expression.h b/include/expression.h
index 742fcdd7bf75..78f788b3c377 100644
--- a/include/expression.h
+++ b/include/expression.h
@@ -120,6 +120,7 @@ struct expr_ctx {
 	enum byteorder		byteorder;
 	unsigned int		len;
 	unsigned int		maxval;
+	const struct expr	*key;
 };
 
 static inline void __expr_set_context(struct expr_ctx *ctx,
@@ -131,6 +132,7 @@ static inline void __expr_set_context(struct expr_ctx *ctx,
 	ctx->byteorder	= byteorder;
 	ctx->len	= len;
 	ctx->maxval	= maxval;
+	ctx->key	= NULL;
 }
 
 static inline void expr_set_context(struct expr_ctx *ctx,
diff --git a/src/datatype.c b/src/datatype.c
index b2e667cef2c6..2e31c8585bdc 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -1136,7 +1136,7 @@ void datatype_set(struct expr *expr, const struct datatype *dtype)
 	expr->dtype = datatype_get(dtype);
 }
 
-static struct datatype *dtype_clone(const struct datatype *orig_dtype)
+struct datatype *dtype_clone(const struct datatype *orig_dtype)
 {
 	struct datatype *dtype;
 
diff --git a/src/evaluate.c b/src/evaluate.c
index 04d42b800103..61dd4fea10e6 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1246,7 +1246,15 @@ static int expr_evaluate_concat(struct eval_ctx *ctx, struct expr **expr)
 	uint32_t type = dtype ? dtype->type : 0, ntype = 0;
 	int off = dtype ? dtype->subtypes : 0;
 	unsigned int flags = EXPR_F_CONSTANT | EXPR_F_SINGLETON;
-	struct expr *i, *next;
+	struct expr *i, *next, *key = NULL;
+	const struct expr *key_ctx = NULL;
+	uint32_t size = 0;
+
+	if (ctx->ectx.key && ctx->ectx.key->etype == EXPR_CONCAT) {
+		key_ctx = ctx->ectx.key;
+		assert(!list_empty(&ctx->ectx.key->expressions));
+		key = list_first_entry(&ctx->ectx.key->expressions, struct expr, list);
+	}
 
 	list_for_each_entry_safe(i, next, &(*expr)->expressions, list) {
 		unsigned dsize_bytes;
@@ -1263,16 +1271,31 @@ static int expr_evaluate_concat(struct eval_ctx *ctx, struct expr **expr)
 						 "expecting %s",
 						 dtype->desc);
 
-		if (dtype == NULL)
+		if (key) {
+			tmp = key->dtype;
+			off--;
+		} else if (dtype == NULL) {
 			tmp = datatype_lookup(TYPE_INVALID);
-		else
+		} else {
 			tmp = concat_subtype_lookup(type, --off);
+		}
+
 		expr_set_context(&ctx->ectx, tmp, tmp->size);
 
 		if (list_member_evaluate(ctx, &i) < 0)
 			return -1;
 		flags &= i->flags;
 
+		if (!key && i->dtype->type == TYPE_INTEGER) {
+			struct datatype *clone;
+
+			clone = dtype_clone(i->dtype);
+			clone->size = i->len;
+			clone->byteorder = i->byteorder;
+			clone->refcnt = 1;
+			i->dtype = clone;
+		}
+
 		if (dtype == NULL && i->dtype->size == 0)
 			return expr_binary_error(ctx->msgs, i, *expr,
 						 "can not use variable sized "
@@ -1284,11 +1307,14 @@ static int expr_evaluate_concat(struct eval_ctx *ctx, struct expr **expr)
 
 		dsize_bytes = div_round_up(i->dtype->size, BITS_PER_BYTE);
 		(*expr)->field_len[(*expr)->field_count++] = dsize_bytes;
+		size += netlink_padded_len(i->dtype->size);
+		if (key)
+			key = list_next_entry(key, list);
 	}
 
 	(*expr)->flags |= flags;
 	datatype_set(*expr, concat_type_alloc(ntype));
-	(*expr)->len   = (*expr)->dtype->size;
+	(*expr)->len   = size;
 
 	if (off > 0)
 		return expr_error(ctx->msgs, *expr,
@@ -1297,6 +1323,10 @@ static int expr_evaluate_concat(struct eval_ctx *ctx, struct expr **expr)
 				  dtype->desc, (*expr)->dtype->desc);
 
 	expr_set_context(&ctx->ectx, (*expr)->dtype, (*expr)->len);
+	if (!key_ctx)
+		ctx->ectx.key = *expr;
+	else
+		ctx->ectx.key = key_ctx;
 
 	return 0;
 }
@@ -1390,6 +1420,7 @@ static int expr_evaluate_set_elem(struct eval_ctx *ctx, struct expr **expr)
 
 		key = ctx->set->key;
 		__expr_set_context(&ctx->ectx, key->dtype, key->byteorder, key->len, 0);
+		ctx->ectx.key = key;
 	}
 
 	if (expr_evaluate(ctx, &elem->key) < 0)
@@ -1563,14 +1594,21 @@ static int expr_evaluate_map(struct eval_ctx *ctx, struct expr **expr)
 
 	switch (map->mappings->etype) {
 	case EXPR_SET:
-		key = constant_expr_alloc(&map->location,
-					  ctx->ectx.dtype,
-					  ctx->ectx.byteorder,
-					  ctx->ectx.len, NULL);
+		if (ctx->ectx.key && ctx->ectx.key->etype == EXPR_CONCAT) {
+			key = expr_clone(ctx->ectx.key);
+		} else {
+			key = constant_expr_alloc(&map->location,
+						  ctx->ectx.dtype,
+						  ctx->ectx.byteorder,
+						  ctx->ectx.len, NULL);
+		}
 
 		dtype = set_datatype_alloc(ectx.dtype, ectx.byteorder);
-		data = constant_expr_alloc(&netlink_location, dtype,
-					   dtype->byteorder, ectx.len, NULL);
+		if (dtype->type == TYPE_VERDICT)
+			data = verdict_expr_alloc(&netlink_location, 0, NULL);
+		else
+			data = constant_expr_alloc(&netlink_location, dtype,
+						   dtype->byteorder, ectx.len, NULL);
 
 		mappings = implicit_set_declaration(ctx, "__map%d",
 						    key, data,
@@ -3920,8 +3958,8 @@ static int set_key_data_error(struct eval_ctx *ctx, const struct set *set,
 static int set_expr_evaluate_concat(struct eval_ctx *ctx, struct expr **expr)
 {
 	unsigned int flags = EXPR_F_CONSTANT | EXPR_F_SINGLETON;
+	uint32_t ntype = 0, size = 0;
 	struct expr *i, *next;
-	uint32_t ntype = 0;
 
 	list_for_each_entry_safe(i, next, &(*expr)->expressions, list) {
 		unsigned dsize_bytes;
@@ -3932,6 +3970,17 @@ static int set_expr_evaluate_concat(struct eval_ctx *ctx, struct expr **expr)
 			return expr_error(ctx->msgs, i,
 					  "specify either ip or ip6 for address matching");
 
+		if (i->etype == EXPR_PAYLOAD && i->payload.is_raw &&
+		    i->dtype->type == TYPE_INTEGER) {
+			struct datatype *dtype;
+
+			dtype = dtype_clone(i->dtype);
+			dtype->size = i->len;
+			dtype->byteorder = i->byteorder;
+			dtype->refcnt = 1;
+			i->dtype = dtype;
+		}
+
 		if (i->dtype->size == 0)
 			return expr_binary_error(ctx->msgs, i, *expr,
 						 "can not use variable sized "
@@ -3945,13 +3994,15 @@ static int set_expr_evaluate_concat(struct eval_ctx *ctx, struct expr **expr)
 
 		dsize_bytes = div_round_up(i->dtype->size, BITS_PER_BYTE);
 		(*expr)->field_len[(*expr)->field_count++] = dsize_bytes;
+		size += netlink_padded_len(i->dtype->size);
 	}
 
 	(*expr)->flags |= flags;
 	datatype_set(*expr, concat_type_alloc(ntype));
-	(*expr)->len   = (*expr)->dtype->size;
+	(*expr)->len   = size;
 
 	expr_set_context(&ctx->ectx, (*expr)->dtype, (*expr)->len);
+	ctx->ectx.key = *expr;
 
 	return 0;
 }
diff --git a/src/expression.c b/src/expression.c
index 612f2c06d1b1..9c9a7ced9121 100644
--- a/src/expression.c
+++ b/src/expression.c
@@ -18,6 +18,7 @@
 #include <expression.h>
 #include <statement.h>
 #include <datatype.h>
+#include <netlink.h>
 #include <rule.h>
 #include <gmputil.h>
 #include <utils.h>
@@ -950,7 +951,7 @@ static struct expr *concat_expr_parse_udata(const struct nftnl_udata *attr)
 	const struct nftnl_udata *ud[NFTNL_UDATA_SET_KEY_CONCAT_NEST_MAX] = {};
 	const struct datatype *dtype;
 	struct expr *concat_expr;
-	uint32_t dt = 0;
+	uint32_t dt = 0, len = 0;
 	unsigned int i;
 	int err;
 
@@ -991,6 +992,7 @@ static struct expr *concat_expr_parse_udata(const struct nftnl_udata *attr)
 
 		dt = concat_subtype_add(dt, expr->dtype->type);
 		compound_expr_add(concat_expr, expr);
+		len += netlink_padded_len(expr->len);
 	}
 
 	dtype = concat_type_alloc(dt);
@@ -998,7 +1000,7 @@ static struct expr *concat_expr_parse_udata(const struct nftnl_udata *attr)
 		goto err_free;
 
 	concat_expr->dtype = datatype_get(dtype);
-	concat_expr->len = dtype->size;
+	concat_expr->len = len;
 
 	return concat_expr;
 
diff --git a/src/mnl.c b/src/mnl.c
index 6be991a4827c..e83e0a16b491 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -1093,9 +1093,7 @@ static void set_key_expression(struct netlink_ctx *ctx,
 {
 	struct nftnl_udata *nest1, *nest2;
 
-	if (expr->flags & EXPR_F_CONSTANT ||
-	    set_is_anonymous(set_flags) ||
-	    !expr_ops(expr)->build_udata)
+	if (!expr_ops(expr)->build_udata)
 		return;
 
 	nest1 = nftnl_udata_nest_start(udbuf, type);
diff --git a/src/netlink.c b/src/netlink.c
index ac73e96f9d24..775c6f5170e2 100644
--- a/src/netlink.c
+++ b/src/netlink.c
@@ -1105,17 +1105,25 @@ static struct expr *netlink_parse_interval_elem(const struct set *set,
 	return range_expr_to_prefix(range);
 }
 
-static struct expr *concat_elem_expr(struct expr *expr,
+static struct expr *concat_elem_expr(struct expr *key,
 				     const struct datatype *dtype,
 				     struct expr *data, int *off)
 {
 	const struct datatype *subtype;
+	struct expr *expr;
 
-	subtype = concat_subtype_lookup(dtype->type, --(*off));
-
-	expr = constant_expr_splice(data, subtype->size);
-	expr->dtype = subtype;
-	expr->byteorder = subtype->byteorder;
+	if (key) {
+		(*off)--;
+		expr = constant_expr_splice(data, key->len);
+		expr->dtype = datatype_get(key->dtype);
+		expr->byteorder = key->byteorder;
+		expr->len = key->len;
+	} else {
+		subtype = concat_subtype_lookup(dtype->type, --(*off));
+		expr = constant_expr_splice(data, subtype->size);
+		expr->dtype = subtype;
+		expr->byteorder = subtype->byteorder;
+	}
 
 	if (expr->byteorder == BYTEORDER_HOST_ENDIAN)
 		mpz_switch_byteorder(expr->value, expr->len / BITS_PER_BYTE);
@@ -1133,13 +1141,18 @@ static struct expr *netlink_parse_concat_elem_key(const struct set *set,
 						  struct expr *data)
 {
 	const struct datatype *dtype = set->key->dtype;
-	struct expr *concat, *expr;
+	struct expr *concat, *expr, *n = NULL;
 	int off = dtype->subtypes;
 
+	if (set->key->etype == EXPR_CONCAT)
+		n = list_first_entry(&set->key->expressions, struct expr, list);
+
 	concat = concat_expr_alloc(&data->location);
 	while (off > 0) {
-		expr = concat_elem_expr(expr, dtype, data, &off);
+		expr = concat_elem_expr(n, dtype, data, &off);
 		compound_expr_add(concat, expr);
+		if (set->key->etype == EXPR_CONCAT)
+			n = list_next_entry(n, list);
 	}
 
 	expr_free(data);
@@ -1159,7 +1172,7 @@ static struct expr *netlink_parse_concat_elem(const struct set *set,
 
 	concat = concat_expr_alloc(&data->location);
 	while (off > 0) {
-		expr = concat_elem_expr(expr, dtype, data, &off);
+		expr = concat_elem_expr(NULL, dtype, data, &off);
 		list_add_tail(&expr->list, &expressions);
 	}
 
@@ -1171,7 +1184,7 @@ static struct expr *netlink_parse_concat_elem(const struct set *set,
 		while (off > 0) {
 			left = list_first_entry(&expressions, struct expr, list);
 
-			expr = concat_elem_expr(expr, dtype, data, &off);
+			expr = concat_elem_expr(NULL, dtype, data, &off);
 			list_del(&left->list);
 
 			range = range_expr_alloc(&data->location, left, expr);
diff --git a/src/payload.c b/src/payload.c
index f433c38421a4..fd6f7011365d 100644
--- a/src/payload.c
+++ b/src/payload.c
@@ -124,11 +124,17 @@ static void payload_expr_pctx_update(struct proto_ctx *ctx,
 
 #define NFTNL_UDATA_SET_KEY_PAYLOAD_DESC 0
 #define NFTNL_UDATA_SET_KEY_PAYLOAD_TYPE 1
-#define NFTNL_UDATA_SET_KEY_PAYLOAD_MAX 2
+#define NFTNL_UDATA_SET_KEY_PAYLOAD_BASE 2
+#define NFTNL_UDATA_SET_KEY_PAYLOAD_OFFSET 3
+#define NFTNL_UDATA_SET_KEY_PAYLOAD_LEN 4
+#define NFTNL_UDATA_SET_KEY_PAYLOAD_MAX 5
 
 static unsigned int expr_payload_type(const struct proto_desc *desc,
 				      const struct proto_hdr_template *tmpl)
 {
+	if (desc->id == PROTO_DESC_UNKNOWN)
+		return 0;
+
 	return (unsigned int)(tmpl - &desc->templates[0]);
 }
 
@@ -142,6 +148,15 @@ static int payload_expr_build_udata(struct nftnl_udata_buf *udbuf,
 	nftnl_udata_put_u32(udbuf, NFTNL_UDATA_SET_KEY_PAYLOAD_DESC, desc->id);
 	nftnl_udata_put_u32(udbuf, NFTNL_UDATA_SET_KEY_PAYLOAD_TYPE, type);
 
+	if (desc->id == 0) {
+		nftnl_udata_put_u32(udbuf, NFTNL_UDATA_SET_KEY_PAYLOAD_BASE,
+				    expr->payload.base);
+		nftnl_udata_put_u32(udbuf, NFTNL_UDATA_SET_KEY_PAYLOAD_OFFSET,
+				    expr->payload.offset);
+		nftnl_udata_put_u32(udbuf, NFTNL_UDATA_SET_KEY_PAYLOAD_LEN,
+				    expr->len);
+	}
+
 	return 0;
 }
 
@@ -159,6 +174,9 @@ static int payload_parse_udata(const struct nftnl_udata *attr, void *data)
 	switch (type) {
 	case NFTNL_UDATA_SET_KEY_PAYLOAD_DESC:
 	case NFTNL_UDATA_SET_KEY_PAYLOAD_TYPE:
+	case NFTNL_UDATA_SET_KEY_PAYLOAD_BASE:
+	case NFTNL_UDATA_SET_KEY_PAYLOAD_OFFSET:
+	case NFTNL_UDATA_SET_KEY_PAYLOAD_LEN:
 		if (len != sizeof(uint32_t))
 			return -1;
 		break;
@@ -173,8 +191,10 @@ static int payload_parse_udata(const struct nftnl_udata *attr, void *data)
 static struct expr *payload_expr_parse_udata(const struct nftnl_udata *attr)
 {
 	const struct nftnl_udata *ud[NFTNL_UDATA_SET_KEY_PAYLOAD_MAX + 1] = {};
+	unsigned int type, base, offset, len;
 	const struct proto_desc *desc;
-	unsigned int type;
+	bool is_raw = false;
+	struct expr *expr;
 	int err;
 
 	err = nftnl_udata_parse(nftnl_udata_get(attr), nftnl_udata_len(attr),
@@ -187,12 +207,37 @@ static struct expr *payload_expr_parse_udata(const struct nftnl_udata *attr)
 		return NULL;
 
 	desc = find_proto_desc(ud[NFTNL_UDATA_SET_KEY_PAYLOAD_DESC]);
-	if (!desc)
-		return NULL;
+	if (!desc) {
+		if (!ud[NFTNL_UDATA_SET_KEY_PAYLOAD_BASE] ||
+		    !ud[NFTNL_UDATA_SET_KEY_PAYLOAD_OFFSET] ||
+		    !ud[NFTNL_UDATA_SET_KEY_PAYLOAD_LEN])
+			return NULL;
+
+		base = nftnl_udata_get_u32(ud[NFTNL_UDATA_SET_KEY_PAYLOAD_BASE]);
+		offset = nftnl_udata_get_u32(ud[NFTNL_UDATA_SET_KEY_PAYLOAD_OFFSET]);
+		len = nftnl_udata_get_u32(ud[NFTNL_UDATA_SET_KEY_PAYLOAD_LEN]);
+		is_raw = true;
+	}
 
 	type = nftnl_udata_get_u32(ud[NFTNL_UDATA_SET_KEY_PAYLOAD_TYPE]);
 
-	return payload_expr_alloc(&internal_location, desc, type);
+	expr = payload_expr_alloc(&internal_location, desc, type);
+
+	if (is_raw) {
+		struct datatype *dtype;
+
+		expr->payload.base = base;
+		expr->payload.offset = offset;
+		expr->payload.is_raw = true;
+		expr->len = len;
+		dtype = dtype_clone(&xinteger_type);
+		dtype->size = len;
+		dtype->byteorder = BYTEORDER_BIG_ENDIAN;
+		dtype->refcnt = 1;
+		expr->dtype = dtype;
+	}
+
+	return expr;
 }
 
 const struct expr_ops payload_expr_ops = {
diff --git a/tests/shell/testcases/maps/dumps/typeof_raw_0.nft b/tests/shell/testcases/maps/dumps/typeof_raw_0.nft
new file mode 100644
index 000000000000..e876425b2bc6
--- /dev/null
+++ b/tests/shell/testcases/maps/dumps/typeof_raw_0.nft
@@ -0,0 +1,13 @@
+table ip x {
+	map y {
+		typeof ip saddr . @ih,32,32 : verdict
+		elements = { 1.1.1.1 . 0x14 : accept,
+			     7.7.7.7 . 0x86 : accept,
+			     7.7.7.8 . 0x97 : drop }
+	}
+
+	chain y {
+		ip saddr . @ih,32,32 vmap @y
+		ip saddr . @ih,32,32 vmap { 4.4.4.4 . 0x34 : accept, 5.5.5.5 . 0x45 : drop }
+	}
+}
diff --git a/tests/shell/testcases/maps/typeof_raw_0 b/tests/shell/testcases/maps/typeof_raw_0
new file mode 100755
index 000000000000..e3da7825cb7b
--- /dev/null
+++ b/tests/shell/testcases/maps/typeof_raw_0
@@ -0,0 +1,18 @@
+#!/bin/bash
+
+EXPECTED="table ip x {
+	map y {
+		typeof ip saddr . @ih,32,32: verdict
+		elements = { 1.1.1.1 . 0x14 : accept, 2.2.2.2 . 0x1e : drop }
+	}
+
+	chain y {
+		ip saddr . @ih,32,32 vmap @y
+		ip saddr . @ih,32,32 vmap { 4.4.4.4 . 0x34 : accept, 5.5.5.5 . 0x45 : drop}
+	}
+}"
+
+set -e
+$NFT -f - <<< $EXPECTED
+$NFT add element ip x y { 7.7.7.7 . 0x86 : accept, 7.7.7.8 . 0x97 : drop }
+$NFT delete element ip x y { 2.2.2.2 . 0x1e : drop }
diff --git a/tests/shell/testcases/sets/dumps/typeof_raw_0.nft b/tests/shell/testcases/sets/dumps/typeof_raw_0.nft
new file mode 100644
index 000000000000..499ff167f51d
--- /dev/null
+++ b/tests/shell/testcases/sets/dumps/typeof_raw_0.nft
@@ -0,0 +1,12 @@
+table inet t {
+	set y {
+		typeof ip daddr . @ih,32,32
+		elements = { 1.1.1.1 . 0x14,
+			     2.2.2.2 . 0x20 }
+	}
+
+	chain y {
+		ip saddr . @ih,32,32 { 1.1.1.1 . 0x14, 2.2.2.2 . 0x1e }
+		ip daddr . @ih,32,32 @y
+	}
+}
diff --git a/tests/shell/testcases/sets/typeof_raw_0 b/tests/shell/testcases/sets/typeof_raw_0
new file mode 100755
index 000000000000..36396b5c2e1d
--- /dev/null
+++ b/tests/shell/testcases/sets/typeof_raw_0
@@ -0,0 +1,17 @@
+#!/bin/bash
+
+EXPECTED="table inet t {
+	set y {
+		typeof ip daddr . @ih,32,32
+		elements = { 1.1.1.1 . 0x14, 2.2.2.2 . 0x20}
+	}
+
+	chain y {
+		ip saddr . @ih,32,32 { 1.1.1.1 . 0x14, 2.2.2.2 . 0x1e }
+		ip daddr . @ih,32,32 @y
+	}
+}"
+
+set -e
+$NFT -f - <<< $EXPECTED
+
-- 
2.30.2

