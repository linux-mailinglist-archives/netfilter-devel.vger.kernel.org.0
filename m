Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031417D4D26
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Oct 2023 12:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjJXKBc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Oct 2023 06:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjJXKB3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1F7D7E
        for <netfilter-devel@vger.kernel.org>; Tue, 24 Oct 2023 03:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698141645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=izmvnUVlfbDWbg+X+PqeW4SYfbt2LympQ+Q8LCo5YW8=;
        b=gXa+MKmrC7RsnRWwDVdtgICSCVtZIJAPCDIpkg1bWzAOQpjZceckEI/cZoc3cZiJGrmJl0
        qy40oeW6UBt7tVMN5FxkoFIE+rlWxkfGE3lEw/SFsDdyWlI14YN43kZvtBJkoOHiYBV+F6
        DN8w3huqsVVix+PVA8JV8j0hgLRsX60=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-fkQfhzdlMc63pGwc0vWlig-1; Tue, 24 Oct 2023 06:00:44 -0400
X-MC-Unique: fkQfhzdlMc63pGwc0vWlig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2D603C025C1
        for <netfilter-devel@vger.kernel.org>; Tue, 24 Oct 2023 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 001571121318;
        Tue, 24 Oct 2023 10:00:42 +0000 (UTC)
From:   Thomas Haller <thaller@redhat.com>
To:     NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Thomas Haller <thaller@redhat.com>
Subject: [PATCH nft v2 3/4] all: add free_const() and use it instead of xfree()
Date:   Tue, 24 Oct 2023 11:57:09 +0200
Message-ID: <20231024095820.1068949-4-thaller@redhat.com>
In-Reply-To: <20231024095820.1068949-1-thaller@redhat.com>
References: <20231024095820.1068949-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Almost everywhere xmalloc() and friends is used instead of malloc().
This is almost everywhere paired with xfree().

xfree() has two problems. First, it brings the wrong notion that
xmalloc() should be paired with xfree(), as if xmalloc() would not use
the plain malloc() allocator. In practices, xfree() just wraps free(),
and it wouldn't make sense any other way. xfree() should go away. This
will be addressed in the next commit.

The problem addressed by this commit is that xfree() accepts a const
pointer. Paired with the practice of almost always using xfree() instead
of free(), all our calls to xfree() cast away constness of the pointer,
regardless whether that is necessary. Declaring a pointer as const
should help us to catch wrong uses. If the xfree() function always casts
aways const, the compiler doesn't help.

There are many places that rightly cast away const during free. But not
all of them. Add a free_const() macro, which is like free(), but accepts
const pointers. We should always make an intentional choice whether to
use free() or free_const(). Having a free_const() macro makes this very
common choice clearer, instead of adding a (void*) cast at many places.

Note that we now pair xmalloc() allocations with a free() call (instead
of xfree(). That inconsistency will be resolved in the next commit.

Signed-off-by: Thomas Haller <thaller@redhat.com>
---
 include/nft.h      |   6 ++
 src/ct.c           |   2 +-
 src/datatype.c     |   8 +--
 src/evaluate.c     |   8 +--
 src/expression.c   |   4 +-
 src/libnftables.c  |  12 ++--
 src/mnl.c          |  12 ++--
 src/optimize.c     |   2 +-
 src/parser_bison.y | 144 ++++++++++++++++++++++-----------------------
 src/rule.c         |  36 ++++++------
 src/scanner.l      |   4 +-
 src/statement.c    |   2 +-
 src/xt.c           |   2 +-
 13 files changed, 124 insertions(+), 118 deletions(-)

diff --git a/include/nft.h b/include/nft.h
index 3c894e5b67a7..a2d62dbf4808 100644
--- a/include/nft.h
+++ b/include/nft.h
@@ -9,4 +9,10 @@
 #include <stdlib.h>
 #include <string.h>
 
+/* Just free(), but casts to a (void*). This is for places where
+ * we have a const pointer that we know we want to free. We could just
+ * do the (void*) cast, but free_const() makes it clear that this is
+ * something we frequently need to do and it's intentional. */
+#define free_const(ptr) free((void *)(ptr))
+
 #endif /* NFTABLES_NFT_H */
diff --git a/src/ct.c b/src/ct.c
index 1dda799d117e..ebfd90a1ab0d 100644
--- a/src/ct.c
+++ b/src/ct.c
@@ -570,7 +570,7 @@ static void flow_offload_stmt_print(const struct stmt *stmt,
 
 static void flow_offload_stmt_destroy(struct stmt *stmt)
 {
-	xfree(stmt->flow.table_name);
+	free_const(stmt->flow.table_name);
 }
 
 static const struct stmt_ops flow_offload_stmt_ops = {
diff --git a/src/datatype.c b/src/datatype.c
index 6362735809f7..ca251138bba9 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -908,8 +908,8 @@ void rt_symbol_table_free(const struct symbol_table *tbl)
 	const struct symbolic_constant *s;
 
 	for (s = tbl->symbols; s->identifier != NULL; s++)
-		xfree(s->identifier);
-	xfree(tbl);
+		free_const(s->identifier);
+	free_const(tbl);
 }
 
 void mark_table_init(struct nft_ctx *ctx)
@@ -1266,8 +1266,8 @@ void datatype_free(const struct datatype *ptr)
 	if (--dtype->refcnt > 0)
 		return;
 
-	xfree(dtype->name);
-	xfree(dtype->desc);
+	free_const(dtype->name);
+	free_const(dtype->desc);
 	xfree(dtype);
 }
 
diff --git a/src/evaluate.c b/src/evaluate.c
index 9d5f0e4d94ad..be90a13f05a1 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -4013,7 +4013,7 @@ static int stmt_evaluate_chain(struct eval_ctx *ctx, struct stmt *stmt)
 		memset(&h, 0, sizeof(h));
 		handle_merge(&h, &chain->handle);
 		h.family = ctx->rule->handle.family;
-		xfree(h.table.name);
+		free_const(h.table.name);
 		h.table.name = xstrdup(ctx->rule->handle.table.name);
 		h.chain.location = stmt->location;
 		h.chain_id = chain->handle.chain_id;
@@ -4033,9 +4033,9 @@ static int stmt_evaluate_chain(struct eval_ctx *ctx, struct stmt *stmt)
 			struct handle h2 = {};
 
 			handle_merge(&rule->handle, &ctx->rule->handle);
-			xfree(rule->handle.table.name);
+			free_const(rule->handle.table.name);
 			rule->handle.table.name = xstrdup(ctx->rule->handle.table.name);
-			xfree(rule->handle.chain.name);
+			free_const(rule->handle.chain.name);
 			rule->handle.chain.name = NULL;
 			rule->handle.chain_id = chain->handle.chain_id;
 			if (rule_evaluate(&rule_ctx, rule, CMD_INVALID) < 0)
@@ -5138,7 +5138,7 @@ static int ct_timeout_evaluate(struct eval_ctx *ctx, struct obj *obj)
 
 		ct->timeout[ts->timeout_index] = ts->timeout_value;
 		list_del(&ts->head);
-		xfree(ts->timeout_str);
+		free_const(ts->timeout_str);
 		xfree(ts);
 	}
 
diff --git a/src/expression.c b/src/expression.c
index a21dfec25722..0b4a537af526 100644
--- a/src/expression.c
+++ b/src/expression.c
@@ -314,7 +314,7 @@ static void symbol_expr_clone(struct expr *new, const struct expr *expr)
 
 static void symbol_expr_destroy(struct expr *expr)
 {
-	xfree(expr->identifier);
+	free_const(expr->identifier);
 }
 
 static const struct expr_ops symbol_expr_ops = {
@@ -1335,7 +1335,7 @@ static void set_elem_expr_destroy(struct expr *expr)
 {
 	struct stmt *stmt, *next;
 
-	xfree(expr->comment);
+	free_const(expr->comment);
 	expr_free(expr->key);
 	list_for_each_entry_safe(stmt, next, &expr->stmt_list, list)
 		stmt_free(stmt);
diff --git a/src/libnftables.c b/src/libnftables.c
index 41f54c0c7370..866b5c6be6c8 100644
--- a/src/libnftables.c
+++ b/src/libnftables.c
@@ -154,8 +154,8 @@ void nft_ctx_clear_vars(struct nft_ctx *ctx)
 	unsigned int i;
 
 	for (i = 0; i < ctx->num_vars; i++) {
-		xfree(ctx->vars[i].key);
-		xfree(ctx->vars[i].value);
+		free_const(ctx->vars[i].key);
+		free_const(ctx->vars[i].value);
 	}
 	ctx->num_vars = 0;
 	xfree(ctx->vars);
@@ -743,12 +743,12 @@ err:
 
 		list_for_each_entry_safe(indesc, next, &nft->vars_ctx.indesc_list, list) {
 			if (indesc->name)
-				xfree(indesc->name);
+				free_const(indesc->name);
 
 			xfree(indesc);
 		}
 	}
-	xfree(nft->vars_ctx.buf);
+	free_const(nft->vars_ctx.buf);
 
 	if (!rc &&
 	    nft_output_json(&nft->output) &&
@@ -799,12 +799,12 @@ int nft_run_cmd_from_filename(struct nft_ctx *nft, const char *filename)
 
 	if (nft->optimize_flags) {
 		ret = nft_run_optimized_file(nft, filename);
-		xfree(nft->stdin_buf);
+		free_const(nft->stdin_buf);
 		return ret;
 	}
 
 	ret = __nft_run_cmd_from_filename(nft, filename);
-	xfree(nft->stdin_buf);
+	free_const(nft->stdin_buf);
 
 	return ret;
 }
diff --git a/src/mnl.c b/src/mnl.c
index 0fb36bd588ee..0158924c2f50 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -776,9 +776,9 @@ static void nft_dev_array_free(const struct nft_dev *dev_array)
 	int i = 0;
 
 	while (dev_array[i].ifname != NULL)
-		xfree(dev_array[i++].ifname);
+		free_const(dev_array[i++].ifname);
 
-	xfree(dev_array);
+	free_const(dev_array);
 }
 
 static void mnl_nft_chain_devs_build(struct nlmsghdr *nlh, struct cmd *cmd)
@@ -2175,10 +2175,10 @@ static struct basehook *basehook_alloc(void)
 static void basehook_free(struct basehook *b)
 {
 	list_del(&b->list);
-	xfree(b->module_name);
-	xfree(b->hookfn);
-	xfree(b->chain);
-	xfree(b->table);
+	free_const(b->module_name);
+	free_const(b->hookfn);
+	free_const(b->chain);
+	free_const(b->table);
 	xfree(b);
 }
 
diff --git a/src/optimize.c b/src/optimize.c
index 27e0ffe1e124..9ae9283d7b6c 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -1194,7 +1194,7 @@ static void merge_rules(const struct optimize_ctx *ctx,
 	}
 
 	if (ctx->rule[from]->comment) {
-		xfree(ctx->rule[from]->comment);
+		free_const(ctx->rule[from]->comment);
 		ctx->rule[from]->comment = NULL;
 	}
 
diff --git a/src/parser_bison.y b/src/parser_bison.y
index f0652ba651c6..8f202bbee207 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -153,13 +153,13 @@ static struct expr *ifname_expr_alloc(const struct location *location,
 	struct expr *expr;
 
 	if (length == 0) {
-		xfree(name);
+		free_const(name);
 		erec_queue(error(location, "empty interface name"), queue);
 		return NULL;
 	}
 
 	if (length > 16) {
-		xfree(name);
+		free_const(name);
 		erec_queue(error(location, "interface name too long"), queue);
 		return NULL;
 	}
@@ -167,7 +167,7 @@ static struct expr *ifname_expr_alloc(const struct location *location,
 	expr = constant_expr_alloc(location, &ifname_type, BYTEORDER_HOST_ENDIAN,
 				   length * BITS_PER_BYTE, name);
 
-	xfree(name);
+	free_const(name);
 
 	return expr;
 }
@@ -357,7 +357,7 @@ int nft_lex(void *, void *, void *);
 %token <string> STRING		"string"
 %token <string> QUOTED_STRING	"quoted string"
 %token <string> ASTERISK_STRING	"string with a trailing asterisk"
-%destructor { xfree($$); }	STRING QUOTED_STRING ASTERISK_STRING
+%destructor { free_const($$); }	STRING QUOTED_STRING ASTERISK_STRING
 
 %token LL_HDR			"ll"
 %token NETWORK_HDR		"nh"
@@ -673,7 +673,7 @@ int nft_lex(void *, void *, void *);
 %type <limit_rate>		limit_rate_bytes
 
 %type <string>			identifier type_identifier string comment_spec
-%destructor { xfree($$); }	identifier type_identifier string comment_spec
+%destructor { free_const($$); }	identifier type_identifier string comment_spec
 
 %type <val>			time_spec time_spec_or_num_s quota_used
 
@@ -708,7 +708,7 @@ int nft_lex(void *, void *, void *);
 %type <val32>			int_num	chain_policy
 %type <prio_spec>		extended_prio_spec prio_spec
 %type <string>			extended_prio_name quota_unit	basehook_device_name
-%destructor { xfree($$); }	extended_prio_name quota_unit	basehook_device_name
+%destructor { free_const($$); }	extended_prio_name quota_unit	basehook_device_name
 
 %type <expr>			dev_spec
 %destructor { xfree($$); }	dev_spec
@@ -927,7 +927,7 @@ int nft_lex(void *, void *, void *);
 
 %type <val>			markup_format
 %type <string>			monitor_event
-%destructor { xfree($$); }	monitor_event
+%destructor { free_const($$); }	monitor_event
 %type <val>			monitor_object	monitor_format
 
 %type <val>			synproxy_ts	synproxy_sack
@@ -1052,10 +1052,10 @@ close_scope_xt		: { scanner_pop_start_cond(nft->scanner, PARSER_SC_XT); }
 common_block		:	INCLUDE		QUOTED_STRING	stmt_separator
 			{
 				if (scanner_include_file(nft, scanner, $2, &@$) < 0) {
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
-				xfree($2);
+				free_const($2);
 			}
 			|	DEFINE		identifier	'='	initializer_expr	stmt_separator
 			{
@@ -1065,19 +1065,19 @@ common_block		:	INCLUDE		QUOTED_STRING	stmt_separator
 					erec_queue(error(&@2, "redefinition of symbol '%s'", $2),
 						   state->msgs);
 					expr_free($4);
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
 
 				symbol_bind(scope, $2, $4);
-				xfree($2);
+				free_const($2);
 			}
 			|	REDEFINE	identifier	'='	initializer_expr	stmt_separator
 			{
 				struct scope *scope = current_scope(state);
 
 				symbol_bind(scope, $2, $4);
-				xfree($2);
+				free_const($2);
 			}
 			|	UNDEFINE	identifier	stmt_separator
 			{
@@ -1086,10 +1086,10 @@ common_block		:	INCLUDE		QUOTED_STRING	stmt_separator
 				if (symbol_unbind(scope, $2) < 0) {
 					erec_queue(error(&@2, "undefined symbol '%s'", $2),
 						   state->msgs);
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
-				xfree($2);
+				free_const($2);
 			}
 			|	error		stmt_separator
 			{
@@ -1878,21 +1878,21 @@ table_options		:	FLAGS		STRING
 			{
 				if (strcmp($2, "dormant") == 0) {
 					$<table>0->flags |= TABLE_F_DORMANT;
-					xfree($2);
+					free_const($2);
 				} else if (strcmp($2, "owner") == 0) {
 					$<table>0->flags |= TABLE_F_OWNER;
-					xfree($2);
+					free_const($2);
 				} else {
 					erec_queue(error(&@2, "unknown table option %s", $2),
 						   state->msgs);
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
 			}
 			|	comment_spec
 			{
 				if (already_set($<table>0->comment, &@$, state)) {
-					xfree($1);
+					free_const($1);
 					YYERROR;
 				}
 				$<table>0->comment = $1;
@@ -2063,7 +2063,7 @@ chain_block		:	/* empty */	{ $$ = $<chain>-1; }
 			|	chain_block	comment_spec	stmt_separator
 			{
 				if (already_set($1->comment, &@2, state)) {
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
 				$1->comment = $2;
@@ -2189,7 +2189,7 @@ set_block		:	/* empty */	{ $$ = $<set>-1; }
 			|	set_block	comment_spec	stmt_separator
 			{
 				if (already_set($1->comment, &@2, state)) {
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
 				$1->comment = $2;
@@ -2306,7 +2306,7 @@ map_block		:	/* empty */	{ $$ = $<set>-1; }
 			|	map_block	comment_spec	stmt_separator
 			{
 				if (already_set($1->comment, &@2, state)) {
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
 				$1->comment = $2;
@@ -2345,10 +2345,10 @@ flowtable_block		:	/* empty */	{ $$ = $<flowtable>-1; }
 				if ($$->hook.name == NULL) {
 					erec_queue(error(&@3, "unknown chain hook"),
 						   state->msgs);
-					xfree($3);
+					free_const($3);
 					YYERROR;
 				}
-				xfree($3);
+				free_const($3);
 
 				$$->priority = $4;
 			}
@@ -2422,12 +2422,12 @@ data_type_atom_expr	:	type_identifier
 				if (dtype == NULL) {
 					erec_queue(error(&@1, "unknown datatype %s", $1),
 						   state->msgs);
-					xfree($1);
+					free_const($1);
 					YYERROR;
 				}
 				$$ = constant_expr_alloc(&@1, dtype, dtype->byteorder,
 							 dtype->size, NULL);
-				xfree($1);
+				free_const($1);
 			}
 			|	TIME
 			{
@@ -2464,7 +2464,7 @@ counter_block		:	/* empty */	{ $$ = $<obj>-1; }
 			|	counter_block	  comment_spec
 			{
 				if (already_set($<obj>1->comment, &@2, state)) {
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
 				$<obj>1->comment = $2;
@@ -2481,7 +2481,7 @@ quota_block		:	/* empty */	{ $$ = $<obj>-1; }
 			|	quota_block	comment_spec
 			{
 				if (already_set($<obj>1->comment, &@2, state)) {
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
 				$<obj>1->comment = $2;
@@ -2498,7 +2498,7 @@ ct_helper_block		:	/* empty */	{ $$ = $<obj>-1; }
 			|       ct_helper_block     comment_spec
 			{
 				if (already_set($<obj>1->comment, &@2, state)) {
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
 				$<obj>1->comment = $2;
@@ -2519,7 +2519,7 @@ ct_timeout_block	:	/*empty */
 			|       ct_timeout_block     comment_spec
 			{
 				if (already_set($<obj>1->comment, &@2, state)) {
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
 				$<obj>1->comment = $2;
@@ -2536,7 +2536,7 @@ ct_expect_block		:	/*empty */	{ $$ = $<obj>-1; }
 			|       ct_expect_block     comment_spec
 			{
 				if (already_set($<obj>1->comment, &@2, state)) {
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
 				$<obj>1->comment = $2;
@@ -2553,7 +2553,7 @@ limit_block		:	/* empty */	{ $$ = $<obj>-1; }
 			|       limit_block     comment_spec
 			{
 				if (already_set($<obj>1->comment, &@2, state)) {
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
 				$<obj>1->comment = $2;
@@ -2570,7 +2570,7 @@ secmark_block		:	/* empty */	{ $$ = $<obj>-1; }
 			|       secmark_block     comment_spec
 			{
 				if (already_set($<obj>1->comment, &@2, state)) {
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
 				$<obj>1->comment = $2;
@@ -2587,7 +2587,7 @@ synproxy_block		:	/* empty */	{ $$ = $<obj>-1; }
 			|       synproxy_block     comment_spec
 			{
 				if (already_set($<obj>1->comment, &@2, state)) {
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
 				$<obj>1->comment = $2;
@@ -2608,12 +2608,12 @@ hook_spec		:	TYPE		close_scope_type	STRING		HOOK		STRING		dev_spec	prio_spec
 				if (chain_type == NULL) {
 					erec_queue(error(&@3, "unknown chain type"),
 						   state->msgs);
-					xfree($3);
+					free_const($3);
 					YYERROR;
 				}
 				$<chain>0->type.loc = @3;
 				$<chain>0->type.str = xstrdup(chain_type);
-				xfree($3);
+				free_const($3);
 
 				$<chain>0->loc = @$;
 				$<chain>0->hook.loc = @5;
@@ -2621,10 +2621,10 @@ hook_spec		:	TYPE		close_scope_type	STRING		HOOK		STRING		dev_spec	prio_spec
 				if ($<chain>0->hook.name == NULL) {
 					erec_queue(error(&@5, "unknown chain hook"),
 						   state->msgs);
-					xfree($5);
+					free_const($5);
 					YYERROR;
 				}
-				xfree($5);
+				free_const($5);
 
 				$<chain>0->dev_expr	= $6;
 				$<chain>0->priority	= $7;
@@ -2671,7 +2671,7 @@ extended_prio_spec	:	int_num
 								BYTEORDER_HOST_ENDIAN,
 								strlen($1) * BITS_PER_BYTE,
 								$1);
-				xfree($1);
+				free_const($1);
 				$$ = spec;
 			}
 			|	extended_prio_name PLUS NUM
@@ -2684,7 +2684,7 @@ extended_prio_spec	:	int_num
 								BYTEORDER_HOST_ENDIAN,
 								strlen(str) * BITS_PER_BYTE,
 								str);
-				xfree($1);
+				free_const($1);
 				$$ = spec;
 			}
 			|	extended_prio_name DASH NUM
@@ -2697,7 +2697,7 @@ extended_prio_spec	:	int_num
 								BYTEORDER_HOST_ENDIAN,
 								strlen(str) * BITS_PER_BYTE,
 								str);
-				xfree($1);
+				free_const($1);
 				$$ = spec;
 			}
 			;
@@ -2782,7 +2782,7 @@ time_spec		:	STRING
 				uint64_t res;
 
 				erec = time_parse(&@1, $1, &res);
-				xfree($1);
+				free_const($1);
 				if (erec != NULL) {
 					erec_queue(erec, state->msgs);
 					YYERROR;
@@ -2983,7 +2983,7 @@ comment_spec		:	COMMENT		string
 					erec_queue(error(&@2, "comment too long, %d characters maximum allowed",
 							 NFTNL_UDATA_COMMENT_MAXLEN),
 						   state->msgs);
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
 				$$ = $2;
@@ -3084,8 +3084,8 @@ stmt			:	verdict_stmt
 xt_stmt			:	XT	STRING	string
 			{
 				$$ = NULL;
-				xfree($2);
-				xfree($3);
+				free_const($2);
+				free_const($3);
 				erec_queue(error(&@$, "unsupported xtables compat expression, use iptables-nft with this ruleset"),
 					   state->msgs);
 				YYERROR;
@@ -3243,7 +3243,7 @@ log_arg			:	PREFIX			string
 					expr = constant_expr_alloc(&@$, &string_type,
 								   BYTEORDER_HOST_ENDIAN,
 								   (strlen($2) + 1) * BITS_PER_BYTE, $2);
-					xfree($2);
+					free_const($2);
 					$<stmt>0->log.prefix = expr;
 					$<stmt>0->log.flags |= STMT_LOG_PREFIX;
 					break;
@@ -3317,7 +3317,7 @@ log_arg			:	PREFIX			string
 									   state->msgs);
 							}
 							expr_free(expr);
-							xfree($2);
+							free_const($2);
 							YYERROR;
 						}
 						item = variable_expr_alloc(&@$, scope, sym);
@@ -3347,7 +3347,7 @@ log_arg			:	PREFIX			string
 					}
 				}
 
-				xfree($2);
+				free_const($2);
 				$<stmt>0->log.prefix	 = expr;
 				$<stmt>0->log.flags 	|= STMT_LOG_PREFIX;
 			}
@@ -3400,10 +3400,10 @@ level_type		:	string
 				else {
 					erec_queue(error(&@1, "invalid log level"),
 						   state->msgs);
-					xfree($1);
+					free_const($1);
 					YYERROR;
 				}
-				xfree($1);
+				free_const($1);
 			}
 			;
 
@@ -3493,7 +3493,7 @@ quota_used		:	/* empty */	{ $$ = 0; }
 				uint64_t rate;
 
 				erec = data_unit_parse(&@$, $3, &rate);
-				xfree($3);
+				free_const($3);
 				if (erec != NULL) {
 					erec_queue(erec, state->msgs);
 					YYERROR;
@@ -3508,7 +3508,7 @@ quota_stmt		:	QUOTA	quota_mode NUM quota_unit quota_used	close_scope_quota
 				uint64_t rate;
 
 				erec = data_unit_parse(&@$, $4, &rate);
-				xfree($4);
+				free_const($4);
 				if (erec != NULL) {
 					erec_queue(erec, state->msgs);
 					YYERROR;
@@ -3552,7 +3552,7 @@ limit_rate_bytes	:	NUM     STRING
 				uint64_t rate, unit;
 
 				erec = rate_parse(&@$, $2, &rate, &unit);
-				xfree($2);
+				free_const($2);
 				if (erec != NULL) {
 					erec_queue(erec, state->msgs);
 					YYERROR;
@@ -3574,7 +3574,7 @@ limit_bytes		:	NUM	BYTES		{ $$ = $1; }
 				uint64_t rate;
 
 				erec = data_unit_parse(&@$, $2, &rate);
-				xfree($2);
+				free_const($2);
 				if (erec != NULL) {
 					erec_queue(erec, state->msgs);
 					YYERROR;
@@ -3603,7 +3603,7 @@ reject_with_expr	:	STRING
 			{
 				$$ = symbol_expr_alloc(&@$, SYMBOL_VALUE,
 						       current_scope(state), $1);
-				xfree($1);
+				free_const($1);
 			}
 			|	integer_expr	{ $$ = $1; }
 			;
@@ -4267,12 +4267,12 @@ variable_expr		:	'$'	identifier
 						erec_queue(error(&@2, "unknown identifier '%s'", $2),
 							   state->msgs);
 					}
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
 
 				$$ = variable_expr_alloc(&@$, scope, sym);
-				xfree($2);
+				free_const($2);
 			}
 			;
 
@@ -4282,7 +4282,7 @@ symbol_expr		:	variable_expr
 				$$ = symbol_expr_alloc(&@$, SYMBOL_VALUE,
 						       current_scope(state),
 						       $1);
-				xfree($1);
+				free_const($1);
 			}
 			;
 
@@ -4295,7 +4295,7 @@ set_ref_symbol_expr	:	AT	identifier	close_scope_at
 				$$ = symbol_expr_alloc(&@$, SYMBOL_SET,
 						       current_scope(state),
 						       $2);
-				xfree($2);
+				free_const($2);
 			}
 			;
 
@@ -4392,10 +4392,10 @@ osf_ttl			:	/* empty */
 				else {
 					erec_queue(error(&@2, "invalid ttl option"),
 						   state->msgs);
-					xfree($2);
+					free_const($2);
 					YYERROR;
 				}
-				xfree($2);
+				free_const($2);
 			}
 			;
 
@@ -4565,7 +4565,7 @@ set_elem_option		:	TIMEOUT			time_spec
 			|	comment_spec
 			{
 				if (already_set($<expr>0->comment, &@1, state)) {
-					xfree($1);
+					free_const($1);
 					YYERROR;
 				}
 				$<expr>0->comment = $1;
@@ -4647,7 +4647,7 @@ set_elem_stmt		:	COUNTER	close_scope_counter
 				uint64_t rate;
 
 				erec = data_unit_parse(&@$, $4, &rate);
-				xfree($4);
+				free_const($4);
 				if (erec != NULL) {
 					erec_queue(erec, state->msgs);
 					YYERROR;
@@ -4680,7 +4680,7 @@ set_elem_expr_option	:	TIMEOUT			time_spec
 			|	comment_spec
 			{
 				if (already_set($<expr>0->comment, &@1, state)) {
-					xfree($1);
+					free_const($1);
 					YYERROR;
 				}
 				$<expr>0->comment = $1;
@@ -4732,7 +4732,7 @@ quota_config		:	quota_mode NUM quota_unit quota_used
 				uint64_t rate;
 
 				erec = data_unit_parse(&@$, $3, &rate);
-				xfree($3);
+				free_const($3);
 				if (erec != NULL) {
 					erec_queue(erec, state->msgs);
 					YYERROR;
@@ -4761,10 +4761,10 @@ secmark_config		:	string
 				ret = snprintf(secmark->ctx, sizeof(secmark->ctx), "%s", $1);
 				if (ret <= 0 || ret >= (int)sizeof(secmark->ctx)) {
 					erec_queue(error(&@1, "invalid context '%s', max length is %u\n", $1, (int)sizeof(secmark->ctx)), state->msgs);
-					xfree($1);
+					free_const($1);
 					YYERROR;
 				}
-				xfree($1);
+				free_const($1);
 			}
 			;
 
@@ -4801,7 +4801,7 @@ ct_helper_config		:	TYPE	QUOTED_STRING	PROTOCOL	ct_l4protoname	stmt_separator	cl
 					erec_queue(error(&@2, "invalid name '%s', max length is %u\n", $2, (int)sizeof(ct->name)), state->msgs);
 					YYERROR;
 				}
-				xfree($2);
+				free_const($2);
 
 				ct->l4proto = $4;
 			}
@@ -5196,7 +5196,7 @@ chain_expr		:	variable_expr
 							 BYTEORDER_HOST_ENDIAN,
 							 strlen($1) * BITS_PER_BYTE,
 							 $1);
-				xfree($1);
+				free_const($1);
 			}
 			;
 
@@ -5214,7 +5214,7 @@ meta_expr		:	META	meta_key	close_scope_meta
 				unsigned int key;
 
 				erec = meta_key_parse(&@$, $2, &key);
-				xfree($2);
+				free_const($2);
 				if (erec != NULL) {
 					erec_queue(erec, state->msgs);
 					YYERROR;
@@ -5291,7 +5291,7 @@ meta_stmt		:	META	meta_key	SET	stmt_expr	close_scope_meta
 				unsigned int key;
 
 				erec = meta_key_parse(&@$, $2, &key);
-				xfree($2);
+				free_const($2);
 				if (erec != NULL) {
 					erec_queue(erec, state->msgs);
 					YYERROR;
@@ -5602,10 +5602,10 @@ payload_base_spec	:	LL_HDR		{ $$ = PROTO_BASE_LL_HDR; }
 					$$ = PROTO_BASE_INNER_HDR;
 				} else {
 					erec_queue(error(&@1, "unknown raw payload base"), state->msgs);
-					xfree($1);
+					free_const($1);
 					YYERROR;
 				}
-				xfree($1);
+				free_const($1);
 			}
 			;
 
diff --git a/src/rule.c b/src/rule.c
index 739b7a541583..b40a54d77759 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -104,11 +104,11 @@ int timeout_str2num(uint16_t l4proto, struct timeout_state *ts)
 
 void handle_free(struct handle *h)
 {
-	xfree(h->table.name);
-	xfree(h->chain.name);
-	xfree(h->set.name);
-	xfree(h->flowtable.name);
-	xfree(h->obj.name);
+	free_const(h->table.name);
+	free_const(h->chain.name);
+	free_const(h->set.name);
+	free_const(h->flowtable.name);
+	free_const(h->obj.name);
 }
 
 void handle_merge(struct handle *dst, const struct handle *src)
@@ -194,7 +194,7 @@ void set_free(struct set *set)
 
 	expr_free(set->init);
 	if (set->comment)
-		xfree(set->comment);
+		free_const(set->comment);
 	handle_free(&set->handle);
 	list_for_each_entry_safe(stmt, next, &set->stmt_list, list)
 		stmt_free(stmt);
@@ -479,7 +479,7 @@ void rule_free(struct rule *rule)
 		return;
 	stmt_list_free(&rule->stmts);
 	handle_free(&rule->handle);
-	xfree(rule->comment);
+	free_const(rule->comment);
 	xfree(rule);
 }
 
@@ -557,7 +557,7 @@ void scope_release(const struct scope *scope)
 	list_for_each_entry_safe(sym, next, &scope->symbols, list) {
 		assert(sym->refcnt == 1);
 		list_del(&sym->list);
-		xfree(sym->identifier);
+		free_const(sym->identifier);
 		expr_free(sym->expr);
 		xfree(sym);
 	}
@@ -597,7 +597,7 @@ struct symbol *symbol_get(const struct scope *scope, const char *identifier)
 static void symbol_put(struct symbol *sym)
 {
 	if (--sym->refcnt == 0) {
-		xfree(sym->identifier);
+		free_const(sym->identifier);
 		expr_free(sym->expr);
 		xfree(sym);
 	}
@@ -730,14 +730,14 @@ void chain_free(struct chain *chain)
 		rule_free(rule);
 	handle_free(&chain->handle);
 	scope_release(&chain->scope);
-	xfree(chain->type.str);
+	free_const(chain->type.str);
 	expr_free(chain->dev_expr);
 	for (i = 0; i < chain->dev_array_len; i++)
-		xfree(chain->dev_array[i]);
+		free_const(chain->dev_array[i]);
 	xfree(chain->dev_array);
 	expr_free(chain->priority.expr);
 	expr_free(chain->policy);
-	xfree(chain->comment);
+	free_const(chain->comment);
 	xfree(chain);
 }
 
@@ -1151,7 +1151,7 @@ void table_free(struct table *table)
 	if (--table->refcnt > 0)
 		return;
 	if (table->comment)
-		xfree(table->comment);
+		free_const(table->comment);
 	list_for_each_entry_safe(chain, next, &table->chains, list)
 		chain_free(chain);
 	list_for_each_entry_safe(chain, next, &table->chain_bindings, cache.list)
@@ -1348,7 +1348,7 @@ struct monitor *monitor_alloc(uint32_t format, uint32_t type, const char *event)
 
 void monitor_free(struct monitor *m)
 {
-	xfree(m->event);
+	free_const(m->event);
 	xfree(m);
 }
 
@@ -1404,7 +1404,7 @@ void cmd_free(struct cmd *cmd)
 		}
 	}
 	xfree(cmd->attr);
-	xfree(cmd->arg);
+	free_const(cmd->arg);
 	xfree(cmd);
 }
 
@@ -1642,14 +1642,14 @@ void obj_free(struct obj *obj)
 {
 	if (--obj->refcnt > 0)
 		return;
-	xfree(obj->comment);
+	free_const(obj->comment);
 	handle_free(&obj->handle);
 	if (obj->type == NFT_OBJECT_CT_TIMEOUT) {
 		struct timeout_state *ts, *next;
 
 		list_for_each_entry_safe(ts, next, &obj->ct_timeout.timeout_list, head) {
 			list_del(&ts->head);
-			xfree(ts->timeout_str);
+			free_const(ts->timeout_str);
 			xfree(ts);
 		}
 	}
@@ -2062,7 +2062,7 @@ void flowtable_free(struct flowtable *flowtable)
 
 	if (flowtable->dev_array != NULL) {
 		for (i = 0; i < flowtable->dev_array_len; i++)
-			xfree(flowtable->dev_array[i]);
+			free_const(flowtable->dev_array[i]);
 		xfree(flowtable->dev_array);
 	}
 	xfree(flowtable);
diff --git a/src/scanner.l b/src/scanner.l
index 88376b7a2199..93a31f27fe10 100644
--- a/src/scanner.l
+++ b/src/scanner.l
@@ -1261,8 +1261,8 @@ void *scanner_init(struct parser_state *state)
 static void input_descriptor_destroy(const struct input_descriptor *indesc)
 {
 	if (indesc->name)
-		xfree(indesc->name);
-	xfree(indesc);
+		free_const(indesc->name);
+	free_const(indesc);
 }
 
 static void input_descriptor_list_destroy(struct parser_state *state)
diff --git a/src/statement.c b/src/statement.c
index 475611664946..801784089f47 100644
--- a/src/statement.c
+++ b/src/statement.c
@@ -183,7 +183,7 @@ static void meter_stmt_destroy(struct stmt *stmt)
 	expr_free(stmt->meter.key);
 	expr_free(stmt->meter.set);
 	stmt_free(stmt->meter.stmt);
-	xfree(stmt->meter.name);
+	free_const(stmt->meter.name);
 }
 
 static const struct stmt_ops meter_stmt_ops = {
diff --git a/src/xt.c b/src/xt.c
index 3cb5f028b20e..48b2873b8c00 100644
--- a/src/xt.c
+++ b/src/xt.c
@@ -124,7 +124,7 @@ void xt_stmt_xlate(const struct stmt *stmt, struct output_ctx *octx)
 
 void xt_stmt_destroy(struct stmt *stmt)
 {
-	xfree(stmt->xt.name);
+	free_const(stmt->xt.name);
 	xfree(stmt->xt.info);
 }
 
-- 
2.41.0

