Return-Path: <netfilter-devel+bounces-8433-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93E9B2F39C
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Aug 2025 11:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A3B5E3E32
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Aug 2025 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB3B2EF67F;
	Thu, 21 Aug 2025 09:13:26 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from localhost.localdomain (203.red-83-63-38.staticip.rima-tde.net [83.63.38.203])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1B02E4270
	for <netfilter-devel@vger.kernel.org>; Thu, 21 Aug 2025 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.63.38.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767606; cv=none; b=rNnPER55O8DVcnrxpBU01SYQbpDq2olbgi4+10Xj7V1ljb9Ig0bb2u0YfCuXjIwYpiSNQGywy/NaI0bnJ9co0F8bdiStBuZYRu+GEUO9AXACaYVg3ZzUUQQchN61Mf2oIc7HZ6Rv1infXGrLfct4bWzj0/4xXLbwR9qsTdJDJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767606; c=relaxed/simple;
	bh=LPKL0rqF7PrfltIDNffW5772Pkkkr++GEsuqtG2DfQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXsTiRDXZ9LiCGepX4hcm0plcPoYoWPauXesIQEU8bvE7J4jSCegRzJA+k5RWfrVpplV0Iz2JGlfCKyVRpox8mHGiIGijIgIrfkJxk2U0v1sJauT/HAG/BjyxLMLG7Ovw4x6rq6TsSBXvZORxvtCdlr2AIi2wu71US3FoPzpR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=83.63.38.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 0455B2165AFD; Thu, 21 Aug 2025 11:13:21 +0200 (CEST)
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org,
	pablo@netfilter.org,
	fw@strlen.de,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 6/7 nft v3] tunnel: add tunnel object and statement json support
Date: Thu, 21 Aug 2025 11:13:01 +0200
Message-ID: <20250821091302.9032-6-fmancera@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821091302.9032-1-fmancera@suse.de>
References: <20250821091302.9032-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: added ipv6 support
---
 include/json.h    |   2 +
 include/tunnel.h  |   4 +
 src/json.c        |  96 ++++++++++++++++++-
 src/parser_json.c | 236 +++++++++++++++++++++++++++++++++++++++++++++-
 src/tunnel.c      |  21 +++++
 5 files changed, 351 insertions(+), 8 deletions(-)

diff --git a/include/json.h b/include/json.h
index b61eeafe..42e1c861 100644
--- a/include/json.h
+++ b/include/json.h
@@ -31,6 +31,7 @@ json_t *binop_expr_json(const struct expr *expr, struct output_ctx *octx);
 json_t *relational_expr_json(const struct expr *expr, struct output_ctx *octx);
 json_t *range_expr_json(const struct expr *expr, struct output_ctx *octx);
 json_t *meta_expr_json(const struct expr *expr, struct output_ctx *octx);
+json_t *tunnel_expr_json(const struct expr *expr, struct output_ctx *octx);
 json_t *payload_expr_json(const struct expr *expr, struct output_ctx *octx);
 json_t *ct_expr_json(const struct expr *expr, struct output_ctx *octx);
 json_t *concat_expr_json(const struct expr *expr, struct output_ctx *octx);
@@ -160,6 +161,7 @@ EXPR_PRINT_STUB(fib_expr)
 EXPR_PRINT_STUB(constant_expr)
 EXPR_PRINT_STUB(socket_expr)
 EXPR_PRINT_STUB(osf_expr)
+EXPR_PRINT_STUB(tunnel_expr)
 EXPR_PRINT_STUB(xfrm_expr)
 
 EXPR_PRINT_STUB(integer_type)
diff --git a/include/tunnel.h b/include/tunnel.h
index 9e6bd97a..e2d87d2c 100644
--- a/include/tunnel.h
+++ b/include/tunnel.h
@@ -25,6 +25,10 @@ extern const struct tunnel_template tunnel_templates[];
 	.byteorder	= (__byteorder),			\
 }
 
+struct error_record *tunnel_key_parse(const struct location *loc,
+			       const char *str,
+			       unsigned int *value);
+
 extern struct expr *tunnel_expr_alloc(const struct location *loc,
 				      enum nft_tunnel_keys key);
 
diff --git a/src/json.c b/src/json.c
index bb14e1bd..d06fd040 100644
--- a/src/json.c
+++ b/src/json.c
@@ -373,7 +373,31 @@ static json_t *timeout_policy_json(uint8_t l4, const uint32_t *timeout)
 	return root ? : json_null();
 }
 
-static json_t *obj_print_json(const struct obj *obj)
+static json_t *tunnel_erspan_print_json(const struct obj *obj)
+{
+	json_t *tunnel;
+
+	switch (obj->tunnel.erspan.version) {
+	case 1:
+		tunnel = json_pack("{s:i, s:i}",
+				   "version", obj->tunnel.erspan.version,
+				   "index", obj->tunnel.erspan.v1.index);
+		break;
+	case 2:
+		tunnel = json_pack("{s:i, s:s, s:i}",
+				   "version", obj->tunnel.erspan.version,
+				   "dir", obj->tunnel.erspan.v2.direction ?
+						"egress" : "ingress",
+				   "hwid", obj->tunnel.erspan.v2.hwid);
+		break;
+	default:
+		BUG("Unknown tunnel erspan version %d", obj->tunnel.erspan.version);
+	}
+
+	return tunnel;
+}
+
+static json_t *obj_print_json(struct output_ctx *octx, const struct obj *obj)
 {
 	const char *rate_unit = NULL, *burst_unit = NULL;
 	const char *type = obj_type_name(obj->type);
@@ -488,7 +512,61 @@ static json_t *obj_print_json(const struct obj *obj)
 		json_decref(tmp);
 		break;
 	case NFT_OBJECT_TUNNEL:
-		/* TODO */
+		tmp = json_pack("{s:i, s:o, s:o, s:i, s:i, s:i, s:i}",
+				"id", obj->tunnel.id,
+				obj->tunnel.src->dtype->type == TYPE_IPADDR ? "src-ipv4" : "src-ipv6",
+				expr_print_json(obj->tunnel.src, octx),
+				obj->tunnel.dst->dtype->type == TYPE_IPADDR ? "dst-ipv4" : "dst-ipv6",
+				expr_print_json(obj->tunnel.dst, octx),
+				"sport", obj->tunnel.sport,
+				"dport", obj->tunnel.dport,
+				"tos", obj->tunnel.tos,
+				"ttl", obj->tunnel.ttl);
+
+		switch (obj->tunnel.type) {
+		case TUNNEL_UNSPEC:
+			break;
+		case TUNNEL_ERSPAN:
+			json_object_set_new(tmp, "type", json_string("erspan"));
+			json_object_set_new(tmp, "tunnel",
+					    tunnel_erspan_print_json(obj));
+			break;
+		case TUNNEL_VXLAN:
+			json_object_set_new(tmp, "type", json_string("vxlan"));
+			json_object_set_new(tmp, "tunnel",
+					    json_pack("{s:i}",
+						      "gbp",
+						      obj->tunnel.vxlan.gbp));
+			break;
+		case TUNNEL_GENEVE:
+			struct tunnel_geneve *geneve;
+			json_t *opts = json_array();
+
+			list_for_each_entry(geneve, &obj->tunnel.geneve_opts, list) {
+				char data_str[256];
+				json_t *opt;
+				int offset;
+
+				data_str[0] = '0';
+				data_str[1] = 'x';
+				offset = 2;
+				for (uint32_t i = 0; i < geneve->data_len; i++)
+					offset += snprintf(data_str + offset,
+							   3, "%x", geneve->data[i]);
+
+				opt = json_pack("{s:i, s:i, s:s}",
+						"class", geneve->geneve_class,
+						"opt-type", geneve->type,
+						"data", data_str);
+				json_array_append_new(opts, opt);
+			}
+
+			json_object_set_new(tmp, "type", json_string("geneve"));
+			json_object_set_new(tmp, "tunnel", opts);
+			break;
+		}
+		json_object_update(root, tmp);
+		json_decref(tmp);
 		break;
 	}
 
@@ -1115,6 +1193,12 @@ json_t *xfrm_expr_json(const struct expr *expr, struct output_ctx *octx)
 	return nft_json_pack("{s:o}", "ipsec", root);
 }
 
+json_t *tunnel_expr_json(const struct expr *expr, struct output_ctx *octx)
+{
+	return json_pack("{s:{s:s}}", "tunnel",
+			 "key", tunnel_templates[expr->tunnel.key].token);
+}
+
 json_t *integer_type_json(const struct expr *expr, struct output_ctx *octx)
 {
 	char buf[1024] = "0x";
@@ -1731,7 +1815,7 @@ static json_t *table_print_json_full(struct netlink_ctx *ctx,
 		json_array_append_new(root, tmp);
 	}
 	list_for_each_entry(obj, &table->obj_cache.list, cache.list) {
-		tmp = obj_print_json(obj);
+		tmp = obj_print_json(&ctx->nft->output, obj);
 		json_array_append_new(root, tmp);
 	}
 	list_for_each_entry(set, &table->set_cache.list, cache.list) {
@@ -1906,7 +1990,7 @@ static json_t *do_list_obj_json(struct netlink_ctx *ctx,
 			     strcmp(cmd->handle.obj.name, obj->handle.obj.name)))
 				continue;
 
-			json_array_append_new(root, obj_print_json(obj));
+			json_array_append_new(root, obj_print_json(&ctx->nft->output, obj));
 		}
 	}
 
@@ -2125,7 +2209,9 @@ void monitor_print_element_json(struct netlink_mon_handler *monh,
 void monitor_print_obj_json(struct netlink_mon_handler *monh,
 			    const char *cmd, struct obj *o)
 {
-	monitor_print_json(monh, cmd, obj_print_json(o));
+	struct output_ctx *octx = &monh->ctx->nft->output;
+
+	monitor_print_json(monh, cmd, obj_print_json(octx, o));
 }
 
 void monitor_print_flowtable_json(struct netlink_mon_handler *monh,
diff --git a/src/parser_json.c b/src/parser_json.c
index ebb96d79..8bca6a59 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -439,6 +439,23 @@ static struct expr *json_parse_meta_expr(struct json_ctx *ctx,
 	return meta_expr_alloc(int_loc, key);
 }
 
+static struct expr *json_parse_tunnel_expr(struct json_ctx *ctx,
+					   const char *type, json_t *root)
+{
+	struct error_record *erec;
+	unsigned int key;
+	const char *name;
+
+	if (json_unpack_err(ctx, root, "{s:s}", "key", &name))
+		return NULL;
+	erec = tunnel_key_parse(int_loc, name, &key);
+	if (erec) {
+		erec_queue(erec, ctx->msgs);
+		return NULL;
+	}
+	return tunnel_expr_alloc(int_loc, key);
+}
+
 static struct expr *json_parse_osf_expr(struct json_ctx *ctx,
 					const char *type, json_t *root)
 {
@@ -1642,6 +1659,7 @@ static struct expr *json_parse_expr(struct json_ctx *ctx, json_t *root)
 		{ "rt", json_parse_rt_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
 		{ "ct", json_parse_ct_expr, CTX_F_RHS | CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_MANGLE | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
 		{ "numgen", json_parse_numgen_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
+		{ "tunnel", json_parse_tunnel_expr, CTX_F_RHS | CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SES | CTX_F_MAP },
 		/* below two are hash expr */
 		{ "jhash", json_parse_hash_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
 		{ "symhash", json_parse_hash_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
@@ -2202,6 +2220,23 @@ static struct stmt *json_parse_secmark_stmt(struct json_ctx *ctx,
 	return stmt;
 }
 
+static struct stmt *json_parse_tunnel_stmt(struct json_ctx *ctx,
+					   const char *key, json_t *value)
+{
+	struct stmt *stmt;
+
+	stmt = objref_stmt_alloc(int_loc);
+	stmt->objref.type = NFT_OBJECT_TUNNEL;
+	stmt->objref.expr = json_parse_stmt_expr(ctx, value);
+	if (!stmt->objref.expr) {
+		json_error(ctx, "Invalid tunnel reference.");
+		stmt_free(stmt);
+		return NULL;
+	}
+
+	return stmt;
+}
+
 static unsigned int json_parse_nat_flag(const char *flag)
 {
 	const struct {
@@ -2870,6 +2905,7 @@ static struct stmt *json_parse_stmt(struct json_ctx *ctx, json_t *root)
 		{ "synproxy", json_parse_synproxy_stmt },
 		{ "reset", json_parse_optstrip_stmt },
 		{ "secmark", json_parse_secmark_stmt },
+		{ "tunnel", json_parse_tunnel_stmt },
 	};
 	const char *type;
 	unsigned int i;
@@ -3518,14 +3554,139 @@ static int json_parse_ct_timeout_policy(struct json_ctx *ctx,
 	return 0;
 }
 
+static int json_parse_tunnel_erspan(struct json_ctx *ctx,
+				    json_t *root, struct obj *obj)
+{
+	const char *dir;
+	json_t *tmp;
+	int i;
+
+	if (json_unpack_err(ctx, root, "{s:o}", "tunnel", &tmp))
+		return 1;
+
+	if (json_unpack_err(ctx, tmp, "{s:i}", "version", &obj->tunnel.erspan.version))
+		return 1;
+
+	switch (obj->tunnel.erspan.version) {
+	case 1:
+		if (json_unpack_err(ctx, tmp, "{s:i}",
+				    "index", &obj->tunnel.erspan.v1.index))
+			return 1;
+		break;
+	case 2:
+		if (json_unpack_err(ctx, tmp, "{s:s, s:i}",
+				   "dir", &dir,
+				   "hwid", &i))
+			return 1;
+		obj->tunnel.erspan.v2.hwid = i;
+
+		if (!strcmp(dir, "ingress")) {
+			obj->tunnel.erspan.v2.direction = 0;
+		} else if (!strcmp(dir, "egress")) {
+			obj->tunnel.erspan.v2.direction = 1;
+		} else {
+			json_error(ctx, "Invalid direction '%s'.", dir);
+			return 1;
+		}
+		break;
+	default:
+		json_error(ctx, "Invalid erspan version %u" , obj->tunnel.erspan.version);
+		return 1;
+	}
+
+	return 0;
+}
+
+static enum tunnel_type json_parse_tunnel_type(struct json_ctx *ctx,
+					       const char *type)
+{
+	const struct {
+		const char *type;
+		int val;
+	} type_tbl[] = {
+		{ "erspan", TUNNEL_ERSPAN },
+		{ "vxlan", TUNNEL_VXLAN },
+		{ "geneve", TUNNEL_GENEVE },
+	};
+	unsigned int i;
+
+	if (!type)
+		return TUNNEL_UNSPEC;
+
+	for (i = 0; i < array_size(type_tbl); i++) {
+		if (!strcmp(type, type_tbl[i].type))
+			return type_tbl[i].val;
+	}
+
+	return TUNNEL_UNSPEC;
+}
+
+static int json_parse_tunnel_src_and_dst(struct json_ctx *ctx,
+					 json_t *root,
+					 struct obj *obj)
+{
+	bool is_ipv4 = false, src_set = false, dst_set = false;
+	struct expr *expr;
+	json_t *tmp;
+
+	if (!json_unpack(root, "{s:o}", "src-ipv4", &tmp)) {
+		is_ipv4 = true;
+		src_set = true;
+		expr = json_parse_expr(ctx, tmp);
+		if (!expr)
+			return -1;
+		datatype_set(expr, &ipaddr_type);
+		obj->tunnel.src = expr;
+	}
+
+	if (!json_unpack(root, "{s:o}", "src-ipv6", &tmp)) {
+		if (is_ipv4 || src_set)
+			return -1;
+		src_set = true;
+		expr = json_parse_expr(ctx, tmp);
+		if (!expr)
+			return -1;
+		datatype_set(expr, &ip6addr_type);
+		obj->tunnel.src = expr;
+	}
+
+	if (!json_unpack(root, "{s:o}", "dst-ipv4", &tmp)) {
+		dst_set = true;
+		if (!is_ipv4)
+			return -1;
+		expr = json_parse_expr(ctx, tmp);
+		if (!expr)
+			return -1;
+		datatype_set(expr, &ipaddr_type);
+		obj->tunnel.dst = expr;
+	}
+
+	if (!json_unpack(root, "{s:o}", "dst-ipv6", &tmp)) {
+		if (is_ipv4 || dst_set)
+			return -1;
+		dst_set = true;
+		expr = json_parse_expr(ctx, tmp);
+		if (!expr)
+			return -1;
+		datatype_set(expr, &ip6addr_type);
+		obj->tunnel.dst = expr;
+	}
+
+	if (!dst_set || !src_set)
+		return -1;
+
+	return 0;
+}
+
 static struct cmd *json_parse_cmd_add_object(struct json_ctx *ctx,
 					     json_t *root, enum cmd_ops op,
 					     enum cmd_obj cmd_obj)
 {
-	const char *family, *tmp, *rate_unit = "packets", *burst_unit = "bytes";
+	const char *family, *tmp = NULL, *rate_unit = "packets", *burst_unit = "bytes";
 	uint32_t l3proto = NFPROTO_UNSPEC;
 	int inv = 0, flags = 0, i, j;
 	struct handle h = { 0 };
+	json_t *tmp_json;
 	struct obj *obj;
 
 	if (json_unpack_err(ctx, root, "{s:s, s:s}",
@@ -3713,8 +3874,77 @@ static struct cmd *json_parse_cmd_add_object(struct json_ctx *ctx,
 
 		obj->synproxy.flags |= flags;
 		break;
-	case CMD_OBJ_TUNNEL:
-		/* TODO */
+	case NFT_OBJECT_TUNNEL:
+		cmd_obj = CMD_OBJ_TUNNEL;
+		obj->type = NFT_OBJECT_TUNNEL;
+
+		if (json_parse_tunnel_src_and_dst(ctx, root, obj))
+			goto err_free_obj;
+
+		json_unpack(root, "{s:i}", "id", &obj->tunnel.id);
+		json_unpack(root, "{s:i}", "sport", &i);
+		obj->tunnel.sport = i;
+		json_unpack(root, "{s:i}", "dport", &i);
+		obj->tunnel.sport = i;
+		json_unpack(root, "{s:i}", "ttl", &i);
+		obj->tunnel.ttl = i;
+		json_unpack(root, "{s:i}", "tos", &i);
+		obj->tunnel.tos = i;
+		json_unpack(root, "{s:s}", "type", &tmp);
+
+		obj->tunnel.type = json_parse_tunnel_type(ctx, tmp);
+		switch (obj->tunnel.type) {
+		case TUNNEL_UNSPEC:
+			break;
+		case TUNNEL_ERSPAN:
+			if (json_parse_tunnel_erspan(ctx, root, obj))
+				goto err_free_obj;
+			break;
+		case TUNNEL_VXLAN:
+			if (json_unpack_err(ctx, root,
+					    "{s:o}", "tunnel", &tmp_json))
+				goto err_free_obj;
+
+			json_unpack(tmp_json, "{s:i}",
+				    "gbp", &obj->tunnel.vxlan.gbp);
+			break;
+		case TUNNEL_GENEVE:
+			json_t *value;
+			size_t index;
+
+			if (json_unpack_err(ctx, root,
+					    "{s:o}", "tunnel", &tmp_json))
+				goto err_free_obj;
+
+			json_array_foreach(tmp_json, index, value) {
+				struct tunnel_geneve *geneve = xmalloc(sizeof(struct tunnel_geneve));
+				if (!geneve)
+					memory_allocation_error();
+
+				if (json_unpack_err(ctx, value, "{s:i, s:i, s:s}",
+						    "class", &i,
+						    "opt-type", &j,
+						    "data", &tmp)) {
+					free(geneve);
+					goto err_free_obj;
+				}
+				geneve->geneve_class = i;
+				geneve->type = j;
+
+				if (tunnel_geneve_data_str2array(tmp,
+								 geneve->data,
+								 &geneve->data_len)) {
+					free(geneve);
+					goto err_free_obj;
+				}
+
+				if (index == 0)
+					init_list_head(&obj->tunnel.geneve_opts);
+
+				list_add_tail(&geneve->list, &obj->tunnel.geneve_opts);
+			}
+			break;
+		}
 		break;
 	default:
 		BUG("Invalid CMD '%d'", cmd_obj);
diff --git a/src/tunnel.c b/src/tunnel.c
index cd92d039..a311246b 100644
--- a/src/tunnel.c
+++ b/src/tunnel.c
@@ -6,6 +6,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <nft.h>
+
 #include <errno.h>
 #include <limits.h>
 #include <stddef.h>
@@ -38,6 +40,24 @@ const struct tunnel_template tunnel_templates[] = {
 						4 * 8, BYTEORDER_HOST_ENDIAN),
 };
 
+struct error_record *tunnel_key_parse(const struct location *loc,
+				      const char *str,
+				      unsigned int *value)
+{
+	unsigned int i;
+
+	for (i = 0; i < array_size(tunnel_templates); i++) {
+		if (!tunnel_templates[i].token ||
+		    strcmp(tunnel_templates[i].token, str))
+			continue;
+
+		*value = i;
+		return NULL;
+	}
+
+	return error(loc, "syntax error, unexpected %s", str);
+}
+
 static void tunnel_expr_print(const struct expr *expr, struct output_ctx *octx)
 {
 	uint32_t key = expr->tunnel.key;
@@ -63,6 +83,7 @@ const struct expr_ops tunnel_expr_ops = {
 	.type		= EXPR_TUNNEL,
 	.name		= "tunnel",
 	.print		= tunnel_expr_print,
+	.json		= tunnel_expr_json,
 	.cmp		= tunnel_expr_cmp,
 	.clone		= tunnel_expr_clone,
 };
-- 
2.50.1


