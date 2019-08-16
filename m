Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47FE79041A
	for <lists+netfilter-devel@lfdr.de>; Fri, 16 Aug 2019 16:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfHPOpA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 16 Aug 2019 10:45:00 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:46176 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727334AbfHPOpA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:45:00 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hydTN-0002ny-Rb; Fri, 16 Aug 2019 16:44:57 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nftables 3/8] src: store expr, not dtype to track data in sets
Date:   Fri, 16 Aug 2019 16:42:36 +0200
Message-Id: <20190816144241.11469-4-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816144241.11469-1-fw@strlen.de>
References: <20190816144241.11469-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This will be needed once we add support for the 'typeof' keyword to
handle maps that could e.g. store 'ct helper' "type" values.

Instead of:

set foo {
	type ipv4_addr . mark;

this would allow

set foo {
	typeof(ip saddr) . typeof(ct mark);

(exact syntax TBD).

This would be needed to allow sets that store variable-sized data types
(string, integer and the like) that can't be used at at the moment.

Adding special data types for everything is problematic due to the
large amount of different types needed.

For anonymous sets, e.g. "string" can be used because the needed size can
be inferred from the statement, e.g.  'osf name { "Windows", "Linux }',
but in case of named sets that won't work because 'type string' lacks the
context needed to derive the size information.

With 'typeof(osf name)' the context is there, but at the moment it won't
help because the expression is discarded instantly and only the data
type is retained.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/datatype.h |  1 -
 include/netlink.h  |  1 -
 include/rule.h     |  6 ++---
 src/datatype.c     |  5 ----
 src/evaluate.c     | 58 ++++++++++++++++++++++++++++++++--------------
 src/expression.c   |  2 +-
 src/json.c         |  4 ++--
 src/mnl.c          |  6 ++---
 src/monitor.c      |  2 +-
 src/netlink.c      | 32 ++++++++++++-------------
 src/parser_bison.y |  3 +--
 src/parser_json.c  |  8 +++++--
 src/rule.c         |  8 +++----
 src/segtree.c      |  8 +++++--
 14 files changed, 81 insertions(+), 63 deletions(-)

diff --git a/include/datatype.h b/include/datatype.h
index c1d08cc29e47..87fef59dd1a6 100644
--- a/include/datatype.h
+++ b/include/datatype.h
@@ -287,7 +287,6 @@ concat_subtype_lookup(uint32_t type, unsigned int n)
 
 extern const struct datatype *
 set_datatype_alloc(const struct datatype *orig_dtype, unsigned int byteorder);
-extern void set_datatype_destroy(const struct datatype *dtype);
 
 extern void time_print(uint64_t msec, struct output_ctx *octx);
 extern struct error_record *time_parse(const struct location *loc,
diff --git a/include/netlink.h b/include/netlink.h
index 279723f33d31..6aead9a8c5e2 100644
--- a/include/netlink.h
+++ b/include/netlink.h
@@ -190,6 +190,5 @@ int netlink_events_trace_cb(const struct nlmsghdr *nlh, int type,
 			    struct netlink_mon_handler *monh);
 
 enum nft_data_types dtype_map_to_kernel(const struct datatype *dtype);
-const struct datatype *dtype_map_from_kernel(enum nft_data_types type);
 
 #endif /* NFTABLES_NETLINK_H */
diff --git a/include/rule.h b/include/rule.h
index 0ef6aacdd71b..331815643362 100644
--- a/include/rule.h
+++ b/include/rule.h
@@ -274,8 +274,7 @@ extern struct rule *rule_lookup_by_index(const struct chain *chain,
  * @gc_int:	garbage collection interval
  * @timeout:	default timeout value
  * @key:	key expression (data type, length))
- * @datatype:	mapping data type
- * @datalen:	mapping data len
+ * @data:	mapping data expression
  * @objtype:	mapping object type
  * @init:	initializer
  * @rg_cache:	cached range element (left)
@@ -292,8 +291,7 @@ struct set {
 	uint32_t		gc_int;
 	uint64_t		timeout;
 	struct expr		*key;
-	const struct datatype	*datatype;
-	unsigned int		datalen;
+	struct expr		*data;
 	uint32_t		objtype;
 	struct expr		*init;
 	struct expr		*rg_cache;
diff --git a/src/datatype.c b/src/datatype.c
index c5a013463eb9..2111a72d4bed 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -1187,11 +1187,6 @@ const struct datatype *set_datatype_alloc(const struct datatype *orig_dtype,
 	return dtype;
 }
 
-void set_datatype_destroy(const struct datatype *dtype)
-{
-	datatype_free(dtype);
-}
-
 static struct error_record *time_unit_parse(const struct location *loc,
 					    const char *str, uint64_t *unit)
 {
diff --git a/src/evaluate.c b/src/evaluate.c
index 831eb7c25c5c..bbae6220a2cd 100755
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1338,6 +1338,7 @@ static int expr_evaluate_map(struct eval_ctx *ctx, struct expr **expr)
 {
 	struct expr_ctx ectx = ctx->ectx;
 	struct expr *map = *expr, *mappings;
+	const struct datatype *dtype;
 	struct expr *key;
 
 	expr_set_context(&ctx->ectx, NULL, 0);
@@ -1360,10 +1361,14 @@ static int expr_evaluate_map(struct eval_ctx *ctx, struct expr **expr)
 		mappings = implicit_set_declaration(ctx, "__map%d",
 						    key,
 						    mappings);
-		mappings->set->datatype =
-			datatype_get(set_datatype_alloc(ectx.dtype,
-							ectx.byteorder));
-		mappings->set->datalen  = ectx.len;
+
+		dtype = set_datatype_alloc(ectx.dtype, ectx.byteorder);
+
+		mappings->set->data = constant_expr_alloc(&netlink_location,
+							  dtype, dtype->byteorder,
+							  ectx.len, NULL);
+		if (ectx.len && mappings->set->data->len != ectx.len)
+			BUG("%d vs %d\n", mappings->set->data->len, ectx.len);
 
 		map->mappings = mappings;
 
@@ -1399,7 +1404,7 @@ static int expr_evaluate_map(struct eval_ctx *ctx, struct expr **expr)
 					 map->mappings->set->key->dtype->desc,
 					 map->map->dtype->desc);
 
-	datatype_set(map, map->mappings->set->datatype);
+	datatype_set(map, map->mappings->set->data->dtype);
 	map->flags |= EXPR_F_CONSTANT;
 
 	/* Data for range lookups needs to be in big endian order */
@@ -1429,7 +1434,12 @@ static int expr_evaluate_mapping(struct eval_ctx *ctx, struct expr **expr)
 				  "Key must be a constant");
 	mapping->flags |= mapping->left->flags & EXPR_F_SINGLETON;
 
-	expr_set_context(&ctx->ectx, set->datatype, set->datalen);
+	if (set->data) {
+		expr_set_context(&ctx->ectx, set->data->dtype, set->data->len);
+	} else {
+		assert((set->flags & NFT_SET_MAP) == 0);
+	}
+
 	if (expr_evaluate(ctx, &mapping->right) < 0)
 		return -1;
 	if (!expr_is_constant(mapping->right))
@@ -1999,7 +2009,7 @@ static int stmt_evaluate_arg(struct eval_ctx *ctx, struct stmt *stmt,
 					 (*expr)->len);
 	else if ((*expr)->dtype->type != TYPE_INTEGER &&
 		 !datatype_equal((*expr)->dtype, dtype))
-		return stmt_binary_error(ctx, *expr, stmt,
+		return stmt_binary_error(ctx, *expr, stmt,		/* verdict vs invalid? */
 					 "datatype mismatch: expected %s, "
 					 "expression has type %s",
 					 dtype->desc, (*expr)->dtype->desc);
@@ -2983,9 +2993,9 @@ static int stmt_evaluate_map(struct eval_ctx *ctx, struct stmt *stmt)
 				  "Key expression comments are not supported");
 
 	if (stmt_evaluate_arg(ctx, stmt,
-			      stmt->map.set->set->datatype,
-			      stmt->map.set->set->datalen,
-			      stmt->map.set->set->datatype->byteorder,
+			      stmt->map.set->set->data->dtype,
+			      stmt->map.set->set->data->len,
+			      stmt->map.set->set->data->byteorder,
 			      &stmt->map.data->key) < 0)
 		return -1;
 	if (expr_is_constant(stmt->map.data))
@@ -3031,8 +3041,12 @@ static int stmt_evaluate_objref_map(struct eval_ctx *ctx, struct stmt *stmt)
 
 		mappings = implicit_set_declaration(ctx, "__objmap%d",
 						    key, mappings);
-		mappings->set->datatype = &string_type;
-		mappings->set->datalen  = NFT_OBJ_MAXNAMELEN * BITS_PER_BYTE;
+
+		mappings->set->data = constant_expr_alloc(&netlink_location,
+							  &string_type,
+							  BYTEORDER_HOST_ENDIAN,
+							  NFT_OBJ_MAXNAMELEN * BITS_PER_BYTE,
+							  NULL);
 		mappings->set->objtype  = stmt->objref.type;
 
 		map->mappings = mappings;
@@ -3067,7 +3081,7 @@ static int stmt_evaluate_objref_map(struct eval_ctx *ctx, struct stmt *stmt)
 					 map->mappings->set->key->dtype->desc,
 					 map->map->dtype->desc);
 
-	datatype_set(map, map->mappings->set->datatype);
+	datatype_set(map, map->mappings->set->data->dtype);
 	map->flags |= EXPR_F_CONSTANT;
 
 	/* Data for range lookups needs to be in big endian order */
@@ -3212,17 +3226,25 @@ static int set_evaluate(struct eval_ctx *ctx, struct set *set)
 		return set_error(ctx, set, "concatenated types not supported in interval sets");
 
 	if (set_is_datamap(set->flags)) {
-		if (set->datatype == NULL)
+		if (set->data == NULL)
 			return set_error(ctx, set, "map definition does not "
 					 "specify mapping data type");
 
-		set->datalen = set->datatype->size;
-		if (set->datalen == 0 && set->datatype->type != TYPE_VERDICT)
+		if (set->data->len == 0 && set->data->dtype->type != TYPE_VERDICT)
 			return set_error(ctx, set, "unqualified mapping data "
 					 "type specified in map definition");
 	} else if (set_is_objmap(set->flags)) {
-		set->datatype = &string_type;
-		set->datalen  = NFT_OBJ_MAXNAMELEN * BITS_PER_BYTE;
+		if (set->data) {
+			assert(set->data->etype == EXPR_VALUE);
+			assert(set->data->dtype == &string_type);
+		}
+
+		assert(set->data == NULL);
+		set->data = constant_expr_alloc(&netlink_location, &string_type,
+						BYTEORDER_HOST_ENDIAN,
+						NFT_OBJ_MAXNAMELEN * BITS_PER_BYTE,
+						NULL);
+
 	}
 
 	ctx->set = set;
diff --git a/src/expression.c b/src/expression.c
index cb49e0b73f5a..09005c650ede 100644
--- a/src/expression.c
+++ b/src/expression.c
@@ -994,7 +994,7 @@ static void map_expr_print(const struct expr *expr, struct output_ctx *octx)
 {
 	expr_print(expr->map, octx);
 	if (expr->mappings->etype == EXPR_SET_REF &&
-	    expr->mappings->set->datatype->type == TYPE_VERDICT)
+	    expr->mappings->set->data->dtype->type == TYPE_VERDICT)
 		nft_print(octx, " vmap ");
 	else
 		nft_print(octx, " map ");
diff --git a/src/json.c b/src/json.c
index 55ce05315d37..3481f2e0677f 100644
--- a/src/json.c
+++ b/src/json.c
@@ -82,7 +82,7 @@ static json_t *set_print_json(struct output_ctx *octx, const struct set *set)
 
 	if (set_is_datamap(set->flags)) {
 		type = "map";
-		datatype_ext = set->datatype->name;
+		datatype_ext = set->data->dtype->name;
 	} else if (set_is_objmap(set->flags)) {
 		type = "map";
 		datatype_ext = obj_type_name(set->objtype);
@@ -617,7 +617,7 @@ json_t *map_expr_json(const struct expr *expr, struct output_ctx *octx)
 	const char *type = "map";
 
 	if (expr->mappings->etype == EXPR_SET_REF &&
-	    expr->mappings->set->datatype->type == TYPE_VERDICT)
+	    expr->mappings->set->data->dtype->type == TYPE_VERDICT)
 		type = "vmap";
 
 	return json_pack("{s:{s:o, s:o}}", type,
diff --git a/src/mnl.c b/src/mnl.c
index 9c1f5356c9b9..034f21709a19 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -815,9 +815,9 @@ int mnl_nft_set_add(struct netlink_ctx *ctx, const struct cmd *cmd,
 			  div_round_up(set->key->len, BITS_PER_BYTE));
 	if (set_is_datamap(set->flags)) {
 		nftnl_set_set_u32(nls, NFTNL_SET_DATA_TYPE,
-				  dtype_map_to_kernel(set->datatype));
+				  dtype_map_to_kernel(set->data->dtype));
 		nftnl_set_set_u32(nls, NFTNL_SET_DATA_LEN,
-				  set->datalen / BITS_PER_BYTE);
+				  set->data->len / BITS_PER_BYTE);
 	}
 	if (set_is_objmap(set->flags))
 		nftnl_set_set_u32(nls, NFTNL_SET_OBJ_TYPE, set->objtype);
@@ -849,7 +849,7 @@ int mnl_nft_set_add(struct netlink_ctx *ctx, const struct cmd *cmd,
 
 	if (set_is_datamap(set->flags) &&
 	    !nftnl_udata_put_u32(udbuf, NFTNL_UDATA_SET_DATABYTEORDER,
-				 set->datatype->byteorder))
+				 set->data->byteorder))
 		memory_allocation_error();
 
 	if (set->automerge &&
diff --git a/src/monitor.c b/src/monitor.c
index 40c381149cda..d90bbfd4d505 100644
--- a/src/monitor.c
+++ b/src/monitor.c
@@ -401,7 +401,7 @@ static int netlink_events_setelem_cb(const struct nlmsghdr *nlh, int type,
 	 */
 	dummyset = set_alloc(monh->loc);
 	dummyset->key = expr_clone(set->key);
-	dummyset->datatype = set->datatype;
+	dummyset->data = set->data;
 	dummyset->flags = set->flags;
 	dummyset->init = set_expr_alloc(monh->loc, set);
 
diff --git a/src/netlink.c b/src/netlink.c
index f8e1120447d9..773b98cec61a 100644
--- a/src/netlink.c
+++ b/src/netlink.c
@@ -520,7 +520,7 @@ enum nft_data_types dtype_map_to_kernel(const struct datatype *dtype)
 	}
 }
 
-const struct datatype *dtype_map_from_kernel(enum nft_data_types type)
+static const struct datatype *dtype_map_from_kernel(enum nft_data_types type)
 {
 	switch (type) {
 	case NFT_DATA_VERDICT:
@@ -567,10 +567,10 @@ struct set *netlink_delinearize_set(struct netlink_ctx *ctx,
 				    const struct nftnl_set *nls)
 {
 	const struct nftnl_udata *ud[NFTNL_UDATA_SET_MAX + 1] = {};
-	uint32_t flags, key, data, data_len, objtype = 0;
 	enum byteorder keybyteorder = BYTEORDER_INVALID;
 	enum byteorder databyteorder = BYTEORDER_INVALID;
-	const struct datatype *keytype, *datatype;
+	const struct datatype *keytype, *datatype = NULL;
+	uint32_t flags, key, objtype = 0;
 	bool automerge = false;
 	const char *udata;
 	struct set *set;
@@ -604,6 +604,8 @@ struct set *netlink_delinearize_set(struct netlink_ctx *ctx,
 
 	flags = nftnl_set_get_u32(nls, NFTNL_SET_FLAGS);
 	if (set_is_datamap(flags)) {
+		uint32_t data;
+
 		data = nftnl_set_get_u32(nls, NFTNL_SET_DATA_TYPE);
 		datatype = dtype_map_from_kernel(data);
 		if (datatype == NULL) {
@@ -612,8 +614,7 @@ struct set *netlink_delinearize_set(struct netlink_ctx *ctx,
 					 data);
 			return NULL;
 		}
-	} else
-		datatype = NULL;
+	}
 
 	if (set_is_objmap(flags)) {
 		objtype = nftnl_set_get_u32(nls, NFTNL_SET_OBJ_TYPE);
@@ -636,16 +637,13 @@ struct set *netlink_delinearize_set(struct netlink_ctx *ctx,
 
 	set->objtype = objtype;
 
+	set->data = NULL;
 	if (datatype)
-		set->datatype = datatype_get(set_datatype_alloc(datatype,
-								databyteorder));
-	else
-		set->datatype = NULL;
-
-	if (nftnl_set_is_set(nls, NFTNL_SET_DATA_LEN)) {
-		data_len = nftnl_set_get_u32(nls, NFTNL_SET_DATA_LEN);
-		set->datalen = data_len * BITS_PER_BYTE;
-	}
+		set->data = constant_expr_alloc(&netlink_location,
+						set_datatype_alloc(datatype, databyteorder),
+						databyteorder,
+						nftnl_set_get_u32(nls, NFTNL_SET_DATA_LEN) * BITS_PER_BYTE,
+						NULL);
 
 	if (nftnl_set_is_set(nls, NFTNL_SET_TIMEOUT))
 		set->timeout = nftnl_set_get_u64(nls, NFTNL_SET_TIMEOUT);
@@ -830,10 +828,10 @@ int netlink_delinearize_setelem(struct nftnl_set_elem *nlse,
 			goto out;
 
 		data = netlink_alloc_data(&netlink_location, &nld,
-					  set->datatype->type == TYPE_VERDICT ?
+					  set->data->dtype->type == TYPE_VERDICT ?
 					  NFT_REG_VERDICT : NFT_REG_1);
-		datatype_set(data, set->datatype);
-		data->byteorder = set->datatype->byteorder;
+		datatype_set(data, set->data->dtype);
+		data->byteorder = set->data->byteorder;
 		if (data->byteorder == BYTEORDER_HOST_ENDIAN)
 			mpz_switch_byteorder(data->value, data->len / BITS_PER_BYTE);
 
diff --git a/src/parser_bison.y b/src/parser_bison.y
index bff5e274c787..c531ee1d1dd8 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -1690,9 +1690,8 @@ map_block		:	/* empty */	{ $$ = $<set>-1; }
 						stmt_separator
 			{
 				$1->key = $3;
-				$1->datatype = $5->dtype;
+				$1->data = $5;
 
-				expr_free($5);
 				$1->flags |= NFT_SET_MAP;
 				$$ = $1;
 			}
diff --git a/src/parser_json.c b/src/parser_json.c
index a969bd4c3676..fbb90da60a83 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -2791,11 +2791,15 @@ static struct cmd *json_parse_cmd_add_set(struct json_ctx *ctx, json_t *root,
 	}
 
 	if (!json_unpack(root, "{s:s}", "map", &dtype_ext)) {
+		const struct datatype *dtype;
+
 		set->objtype = string_to_nft_object(dtype_ext);
 		if (set->objtype) {
 			set->flags |= NFT_SET_OBJECT;
-		} else if (datatype_lookup_byname(dtype_ext)) {
-			set->datatype = datatype_lookup_byname(dtype_ext);
+		} else if ((dtype = datatype_lookup_byname(dtype_ext))) {
+			set->data = constant_expr_alloc(&netlink_location,
+							dtype, dtype->byteorder,
+							dtype->size, NULL);
 			set->flags |= NFT_SET_MAP;
 		} else {
 			json_error(ctx, "Invalid map type '%s'.", dtype_ext);
diff --git a/src/rule.c b/src/rule.c
index 5655e8c011e4..aee08ea12c8b 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -330,8 +330,8 @@ struct set *set_clone(const struct set *set)
 	new_set->gc_int		= set->gc_int;
 	new_set->timeout	= set->timeout;
 	new_set->key		= expr_clone(set->key);
-	new_set->datatype	= datatype_get(set->datatype);
-	new_set->datalen	= set->datalen;
+	if (set->data)
+		new_set->data	= expr_clone(set->data);
 	new_set->objtype	= set->objtype;
 	new_set->policy		= set->policy;
 	new_set->automerge	= set->automerge;
@@ -354,7 +354,7 @@ void set_free(struct set *set)
 		expr_free(set->init);
 	handle_free(&set->handle);
 	expr_free(set->key);
-	set_datatype_destroy(set->datatype);
+	expr_free(set->data);
 	xfree(set);
 }
 
@@ -468,7 +468,7 @@ static void set_print_declaration(const struct set *set,
 	nft_print(octx, "%s%stype %s",
 		  opts->tab, opts->tab, set->key->dtype->name);
 	if (set_is_datamap(set->flags))
-		nft_print(octx, " : %s", set->datatype->name);
+		nft_print(octx, " : %s", set->data->dtype->name);
 	else if (set_is_objmap(set->flags))
 		nft_print(octx, " : %s", obj_type_name(set->objtype));
 
diff --git a/src/segtree.c b/src/segtree.c
index eff0653a8dfb..cfb892c3bb34 100644
--- a/src/segtree.c
+++ b/src/segtree.c
@@ -79,8 +79,12 @@ static void seg_tree_init(struct seg_tree *tree, const struct set *set,
 	tree->root	= RB_ROOT;
 	tree->keytype	= set->key->dtype;
 	tree->keylen	= set->key->len;
-	tree->datatype	= set->datatype;
-	tree->datalen	= set->datalen;
+	tree->datatype	= NULL;
+	tree->datalen	= 0;
+	if (set->data) {
+		tree->datatype	= set->data->dtype;
+		tree->datalen	= set->data->len;
+	}
 	tree->byteorder	= first->byteorder;
 	tree->debug_mask = debug_mask;
 }
-- 
2.21.0

