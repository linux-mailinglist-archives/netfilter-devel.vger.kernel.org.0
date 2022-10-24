Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13689609CFD
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Oct 2022 10:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJXInF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Oct 2022 04:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJXInF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:43:05 -0400
X-Greylist: delayed 1838 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 01:43:03 PDT
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C9C36877
        for <netfilter-devel@vger.kernel.org>; Mon, 24 Oct 2022 01:43:02 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MwpVt37rJz9scb
        for <netfilter-devel@vger.kernel.org>; Mon, 24 Oct 2022 08:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1666600982; bh=G0ozwAhkurn65LLZArUjgsc6V5E49b7+xxPb+lM3eM0=;
        h=From:To:Cc:Subject:Date:From;
        b=KFkMUYEV0WSIfDZxRdb6pshxqUIgwW8Bgi/pLsObNSvocQtmsYbUUCj+VeOa8jKpg
         pB3X3UP1d1sUvPmSvug21+jOzibK6cVkAltCTdz/6ueTfsGXlffgv5+8TMbHbEasrG
         sgSUVZFcMMDp/O8+nxE5mySOJn074oxFkJenzf7k=
X-Riseup-User-ID: B44592044B7ED92AB8C63CFE09E8ADD021D165BDBDBDB3119429C051E99FDD82
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4MwpVs0NXJz1yPj;
        Mon, 24 Oct 2022 08:43:00 +0000 (UTC)
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
To:     netfilter-devel@vger.kernel.org
Cc:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH nft v2] src: add support to command "destroy"
Date:   Mon, 24 Oct 2022 10:42:28 +0200
Message-Id: <20221024084228.47990-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

"destroy" command performs a deletion as "delete" command but does not fail
when the object does not exist. As there is no NLM_F_* flag for ignoring such
error, it needs to be ignored directly on error handling.

Example of use:

	# nft list ruleset
        table ip filter {
                chain output {
                }
        }
        # nft destroy table ip missingtable
	# echo $?
	0
        # nft list ruleset
        table ip filter {
                chain output {
                }
        }

Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
v1: initial patch
v2: improve error handling
---
 include/rule.h                                |  2 +
 src/cache.c                                   |  1 +
 src/evaluate.c                                |  3 +
 src/libnftables.c                             | 17 ++++-
 src/parser_bison.y                            | 75 ++++++++++++++++++-
 src/parser_json.c                             | 16 ++--
 src/rule.c                                    |  1 +
 src/scanner.l                                 |  1 +
 .../testcases/rule_management/0011destroy_0   |  8 ++
 .../testcases/rule_management/0012destroy_0   |  7 ++
 .../rule_management/dumps/0011destroy_0.nft   |  4 +
 .../rule_management/dumps/0012destroy_0.nft   |  4 +
 12 files changed, 127 insertions(+), 12 deletions(-)
 create mode 100755 tests/shell/testcases/rule_management/0011destroy_0
 create mode 100755 tests/shell/testcases/rule_management/0012destroy_0
 create mode 100644 tests/shell/testcases/rule_management/dumps/0011destroy_0.nft
 create mode 100644 tests/shell/testcases/rule_management/dumps/0012destroy_0.nft

diff --git a/include/rule.h b/include/rule.h
index ad9f9127..4003c490 100644
--- a/include/rule.h
+++ b/include/rule.h
@@ -562,6 +562,7 @@ void flowtable_print(const struct flowtable *n, struct output_ctx *octx);
  * @CMD_EXPORT:		export the ruleset in a given format
  * @CMD_MONITOR:	event listener
  * @CMD_DESCRIBE:	describe an expression
+ * @CMD_DESTROY:	destroy object
  */
 enum cmd_ops {
 	CMD_INVALID,
@@ -579,6 +580,7 @@ enum cmd_ops {
 	CMD_EXPORT,
 	CMD_MONITOR,
 	CMD_DESCRIBE,
+	CMD_DESTROY,
 };
 
 /**
diff --git a/src/cache.c b/src/cache.c
index 85de970f..a570fd6c 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -391,6 +391,7 @@ int nft_cache_evaluate(struct nft_ctx *nft, struct list_head *cmds,
 			flags = NFT_CACHE_FULL;
 			break;
 		case CMD_DELETE:
+		case CMD_DESTROY:
 			flags |= NFT_CACHE_TABLE |
 				 NFT_CACHE_CHAIN |
 				 NFT_CACHE_SET |
diff --git a/src/evaluate.c b/src/evaluate.c
index 0bf6a0d1..391a51f0 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1547,6 +1547,7 @@ static int interval_set_eval(struct eval_ctx *ctx, struct set *set,
 		}
 		break;
 	case CMD_DELETE:
+	case CMD_DESTROY:
 		ret = set_delete(ctx->msgs, ctx->cmd, set, init,
 				 ctx->nft->debug_mask);
 		break;
@@ -5368,6 +5369,7 @@ static const char * const cmd_op_name[] = {
 	[CMD_EXPORT]	= "export",
 	[CMD_MONITOR]	= "monitor",
 	[CMD_DESCRIBE]	= "describe",
+	[CMD_DESTROY]   = "destroy",
 };
 
 static const char *cmd_op_to_name(enum cmd_ops op)
@@ -5400,6 +5402,7 @@ int cmd_evaluate(struct eval_ctx *ctx, struct cmd *cmd)
 	case CMD_INSERT:
 		return cmd_evaluate_add(ctx, cmd);
 	case CMD_DELETE:
+	case CMD_DESTROY:
 		return cmd_evaluate_delete(ctx, cmd);
 	case CMD_GET:
 		return cmd_evaluate_get(ctx, cmd);
diff --git a/src/libnftables.c b/src/libnftables.c
index a376825d..fea9293b 100644
--- a/src/libnftables.c
+++ b/src/libnftables.c
@@ -30,8 +30,8 @@ static int nft_netlink(struct nft_ctx *nft,
 	};
 	struct cmd *cmd;
 	struct mnl_err *err, *tmp;
+	int ret = 0, err_num = 0;
 	LIST_HEAD(err_list);
-	int ret = 0;
 
 	if (list_empty(cmds))
 		goto out;
@@ -75,8 +75,12 @@ static int nft_netlink(struct nft_ctx *nft,
 			last_seqnum = cmd->seqnum;
 			if (err->seqnum == cmd->seqnum ||
 			    err->seqnum == batch_seqnum) {
-				nft_cmd_error(&ctx, cmd, err);
-				errno = err->err;
+				if (!(err->err == ENOENT &&
+				    cmd->op == CMD_DESTROY)) {
+					nft_cmd_error(&ctx, cmd, err);
+					errno = err->err;
+					err_num++;
+				}
 				if (err->seqnum == cmd->seqnum) {
 					mnl_err_list_free(err);
 					break;
@@ -89,6 +93,13 @@ static int nft_netlink(struct nft_ctx *nft,
 			last_seqnum = UINT32_MAX;
 		}
 	}
+
+	/* discard return code value when all the errors are ENOENT from
+	 * destroy operations.
+	 */
+	if (!err_num)
+		ret = 0;
+
 	/* nfnetlink uses the first netlink message header in the batch whose
 	 * sequence number is zero to report for EOPNOTSUPP and EPERM errors in
 	 * some scenarios. Now it is safe to release pending errors here.
diff --git a/src/parser_bison.y b/src/parser_bison.y
index 760c23cf..02fde05f 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -291,6 +291,8 @@ int nft_lex(void *, void *, void *);
 %token DESCRIBE			"describe"
 %token IMPORT			"import"
 %token EXPORT			"export"
+%token DESTROY			"destroy"
+
 %token MONITOR			"monitor"
 
 %token ALL			"all"
@@ -640,8 +642,8 @@ int nft_lex(void *, void *, void *);
 %type <cmd>			line
 %destructor { cmd_free($$); }	line
 
-%type <cmd>			base_cmd add_cmd replace_cmd create_cmd insert_cmd delete_cmd get_cmd list_cmd reset_cmd flush_cmd rename_cmd export_cmd monitor_cmd describe_cmd import_cmd
-%destructor { cmd_free($$); }	base_cmd add_cmd replace_cmd create_cmd insert_cmd delete_cmd get_cmd list_cmd reset_cmd flush_cmd rename_cmd export_cmd monitor_cmd describe_cmd import_cmd
+%type <cmd>			base_cmd add_cmd replace_cmd create_cmd insert_cmd delete_cmd get_cmd list_cmd reset_cmd flush_cmd rename_cmd export_cmd monitor_cmd describe_cmd import_cmd destroy_cmd
+%destructor { cmd_free($$); }	base_cmd add_cmd replace_cmd create_cmd insert_cmd delete_cmd get_cmd list_cmd reset_cmd flush_cmd rename_cmd export_cmd monitor_cmd describe_cmd import_cmd destroy_cmd
 
 %type <handle>			table_spec tableid_spec table_or_id_spec
 %destructor { handle_free(&$$); } table_spec tableid_spec table_or_id_spec
@@ -1080,6 +1082,7 @@ base_cmd		:	/* empty */	add_cmd		{ $$ = $1; }
 			|	EXPORT		export_cmd	close_scope_export	{ $$ = $2; }
 			|	MONITOR		monitor_cmd	close_scope_monitor	{ $$ = $2; }
 			|	DESCRIBE	describe_cmd	{ $$ = $2; }
+			|	DESTROY		destroy_cmd	{ $$ = $2; }
 			;
 
 add_cmd			:	TABLE		table_spec
@@ -1387,6 +1390,74 @@ delete_cmd		:	TABLE		table_or_id_spec
 			}
 			;
 
+destroy_cmd		:	TABLE		table_or_id_spec
+			{
+				$$ = cmd_alloc(CMD_DESTROY, CMD_OBJ_TABLE, &$2, &@$, NULL);
+			}
+			|	CHAIN		chain_or_id_spec
+			{
+				$$ = cmd_alloc(CMD_DESTROY, CMD_OBJ_CHAIN, &$2, &@$, NULL);
+			}
+			|	RULE		ruleid_spec
+			{
+				$$ = cmd_alloc(CMD_DESTROY, CMD_OBJ_RULE, &$2, &@$, NULL);
+			}
+			|	SET		set_or_id_spec
+			{
+				$$ = cmd_alloc(CMD_DESTROY, CMD_OBJ_SET, &$2, &@$, NULL);
+			}
+			|	MAP		set_spec
+			{
+				$$ = cmd_alloc(CMD_DESTROY, CMD_OBJ_SET, &$2, &@$, NULL);
+			}
+			|	ELEMENT		set_spec	set_block_expr
+			{
+				$$ = cmd_alloc(CMD_DESTROY, CMD_OBJ_ELEMENTS, &$2, &@$, $3);
+			}
+			|	FLOWTABLE	flowtable_spec
+			{
+				$$ = cmd_alloc(CMD_DESTROY, CMD_OBJ_FLOWTABLE, &$2, &@$, NULL);
+			}
+			|	FLOWTABLE	flowtableid_spec
+			{
+				$$ = cmd_alloc(CMD_DESTROY, CMD_OBJ_FLOWTABLE, &$2, &@$, NULL);
+			}
+			|	FLOWTABLE	flowtable_spec	flowtable_block_alloc
+						'{'	flowtable_block	'}'
+			{
+				$5->location = @5;
+				handle_merge(&$3->handle, &$2);
+				$$ = cmd_alloc(CMD_DESTROY, CMD_OBJ_FLOWTABLE, &$2, &@$, $5);
+			}
+			|	COUNTER		obj_or_id_spec	close_scope_counter
+			{
+				$$ = cmd_alloc(CMD_DESTROY, CMD_OBJ_COUNTER, &$2, &@$, NULL);
+			}
+			|	QUOTA		obj_or_id_spec	close_scope_quota
+			{
+				$$ = cmd_alloc(CMD_DESTROY, CMD_OBJ_QUOTA, &$2, &@$, NULL);
+			}
+			|	CT	ct_obj_type	obj_spec	ct_obj_alloc	close_scope_ct
+			{
+				$$ = cmd_alloc_obj_ct(CMD_DESTROY, $2, &$3, &@$, $4);
+				if ($2 == NFT_OBJECT_CT_TIMEOUT)
+					init_list_head(&$4->ct_timeout.timeout_list);
+			}
+			|	LIMIT		obj_or_id_spec	close_scope_limit
+			{
+				$$ = cmd_alloc(CMD_DESTROY, CMD_OBJ_LIMIT, &$2, &@$, NULL);
+			}
+			|	SECMARK		obj_or_id_spec	close_scope_secmark
+			{
+				$$ = cmd_alloc(CMD_DESTROY, CMD_OBJ_SECMARK, &$2, &@$, NULL);
+			}
+			|	SYNPROXY	obj_or_id_spec	close_scope_synproxy
+			{
+				$$ = cmd_alloc(CMD_DESTROY, CMD_OBJ_SYNPROXY, &$2, &@$, NULL);
+			}
+			;
+
+
 get_cmd			:	ELEMENT		set_spec	set_block_expr
 			{
 				$$ = cmd_alloc(CMD_GET, CMD_OBJ_ELEMENTS, &$2, &@$, $3);
diff --git a/src/parser_json.c b/src/parser_json.c
index 76c268f8..75241244 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -2923,7 +2923,7 @@ static struct cmd *json_parse_cmd_add_rule(struct json_ctx *ctx, json_t *root,
 	if (op != CMD_DELETE &&
 	    json_unpack_err(ctx, root, "{s:o}", "expr", &tmp))
 		return NULL;
-	else if (op == CMD_DELETE &&
+	else if ((op == CMD_DELETE || op == CMD_DESTROY) &&
 		 json_unpack_err(ctx, root, "{s:I}", "handle", &h.handle.id))
 		return NULL;
 
@@ -2934,7 +2934,7 @@ static struct cmd *json_parse_cmd_add_rule(struct json_ctx *ctx, json_t *root,
 	h.table.name = xstrdup(h.table.name);
 	h.chain.name = xstrdup(h.chain.name);
 
-	if (op == CMD_DELETE)
+	if (op == CMD_DELETE || op == CMD_DESTROY)
 		return cmd_alloc(op, obj, &h, int_loc, NULL);
 
 	if (!json_is_array(tmp)) {
@@ -3030,7 +3030,7 @@ static struct cmd *json_parse_cmd_add_set(struct json_ctx *ctx, json_t *root,
 	if (op != CMD_DELETE &&
 	    json_unpack_err(ctx, root, "{s:s}", "name", &h.set.name)) {
 		return NULL;
-	} else if (op == CMD_DELETE &&
+	} else if ((op == CMD_DELETE || op == CMD_DESTROY) &&
 		   json_unpack(root, "{s:s}", "name", &h.set.name) &&
 		   json_unpack(root, "{s:I}", "handle", &h.handle.id)) {
 		json_error(ctx, "Either name or handle required to delete a set.");
@@ -3047,6 +3047,7 @@ static struct cmd *json_parse_cmd_add_set(struct json_ctx *ctx, json_t *root,
 
 	switch (op) {
 	case CMD_DELETE:
+	case CMD_DESTROY:
 	case CMD_LIST:
 	case CMD_FLUSH:
 		return cmd_alloc(op, obj, &h, int_loc, NULL);
@@ -3228,7 +3229,7 @@ static struct cmd *json_parse_cmd_add_flowtable(struct json_ctx *ctx,
 	if (op != CMD_DELETE &&
 	    json_unpack_err(ctx, root, "{s:s}", "name", &h.flowtable.name)) {
 		return NULL;
-	} else if (op == CMD_DELETE &&
+	} else if ((op == CMD_DELETE || op == CMD_DESTROY) &&
 		   json_unpack(root, "{s:s}", "name", &h.flowtable.name) &&
 		   json_unpack(root, "{s:I}", "handle", &h.handle.id)) {
 		json_error(ctx, "Either name or handle required to delete a flowtable.");
@@ -3243,7 +3244,7 @@ static struct cmd *json_parse_cmd_add_flowtable(struct json_ctx *ctx,
 	if (h.flowtable.name)
 		h.flowtable.name = xstrdup(h.flowtable.name);
 
-	if (op == CMD_DELETE || op == CMD_LIST)
+	if (op == CMD_DELETE || op == CMD_LIST || op == CMD_DESTROY)
 		return cmd_alloc(op, cmd_obj, &h, int_loc, NULL);
 
 	if (json_unpack_err(ctx, root, "{s:s, s:I}",
@@ -3332,7 +3333,7 @@ static struct cmd *json_parse_cmd_add_object(struct json_ctx *ctx,
 	     cmd_obj == NFT_OBJECT_CT_HELPER) &&
 	    json_unpack_err(ctx, root, "{s:s}", "name", &h.obj.name)) {
 		return NULL;
-	} else if (op == CMD_DELETE &&
+	} else if ((op == CMD_DELETE || op == CMD_DESTROY) &&
 		   cmd_obj != NFT_OBJECT_CT_HELPER &&
 		   json_unpack(root, "{s:s}", "name", &h.obj.name) &&
 		   json_unpack(root, "{s:I}", "handle", &h.handle.id)) {
@@ -3348,7 +3349,7 @@ static struct cmd *json_parse_cmd_add_object(struct json_ctx *ctx,
 	if (h.obj.name)
 		h.obj.name = xstrdup(h.obj.name);
 
-	if (op == CMD_DELETE || op == CMD_LIST) {
+	if (op == CMD_DELETE || op == CMD_LIST || op == CMD_DESTROY) {
 		if (cmd_obj == NFT_OBJECT_CT_HELPER)
 			return cmd_alloc_obj_ct(op, NFT_OBJECT_CT_HELPER,
 						&h, int_loc, obj_alloc(int_loc));
@@ -3861,6 +3862,7 @@ static struct cmd *json_parse_cmd(struct json_ctx *ctx, json_t *root)
 		{ "reset", CMD_RESET, json_parse_cmd_reset },
 		{ "flush", CMD_FLUSH, json_parse_cmd_flush },
 		{ "rename", CMD_RENAME, json_parse_cmd_rename },
+		{ "destroy", CMD_DESTROY, json_parse_cmd_add },
 		//{ "export", CMD_EXPORT, json_parse_cmd_export },
 		//{ "monitor", CMD_MONITOR, json_parse_cmd_monitor },
 		//{ "describe", CMD_DESCRIBE, json_parse_cmd_describe }
diff --git a/src/rule.c b/src/rule.c
index d1ee6c2e..11295648 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -2718,6 +2718,7 @@ int do_command(struct netlink_ctx *ctx, struct cmd *cmd)
 	case CMD_REPLACE:
 		return do_command_replace(ctx, cmd);
 	case CMD_DELETE:
+	case CMD_DESTROY:
 		return do_command_delete(ctx, cmd);
 	case CMD_GET:
 		return do_command_get(ctx, cmd);
diff --git a/src/scanner.l b/src/scanner.l
index 1371cd04..04e9044d 100644
--- a/src/scanner.l
+++ b/src/scanner.l
@@ -357,6 +357,7 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 "import"                { scanner_push_start_cond(yyscanner, SCANSTATE_CMD_IMPORT); return IMPORT; }
 "export"		{ scanner_push_start_cond(yyscanner, SCANSTATE_CMD_EXPORT); return EXPORT; }
 "monitor"		{ scanner_push_start_cond(yyscanner, SCANSTATE_CMD_MONITOR); return MONITOR; }
+"destroy"		{ return DESTROY; }
 
 "position"		{ return POSITION; }
 "index"			{ return INDEX; }
diff --git a/tests/shell/testcases/rule_management/0011destroy_0 b/tests/shell/testcases/rule_management/0011destroy_0
new file mode 100755
index 00000000..895c24a4
--- /dev/null
+++ b/tests/shell/testcases/rule_management/0011destroy_0
@@ -0,0 +1,8 @@
+#!/bin/bash
+
+set -e
+$NFT add table t
+$NFT add chain t c
+$NFT insert rule t c accept # should have handle 2
+
+$NFT destroy rule t c handle 2
diff --git a/tests/shell/testcases/rule_management/0012destroy_0 b/tests/shell/testcases/rule_management/0012destroy_0
new file mode 100755
index 00000000..1b61155e
--- /dev/null
+++ b/tests/shell/testcases/rule_management/0012destroy_0
@@ -0,0 +1,7 @@
+#!/bin/bash
+
+set -e
+$NFT add table t
+$NFT add chain t c
+
+$NFT destroy rule t c handle 3333
diff --git a/tests/shell/testcases/rule_management/dumps/0011destroy_0.nft b/tests/shell/testcases/rule_management/dumps/0011destroy_0.nft
new file mode 100644
index 00000000..1e0d1d60
--- /dev/null
+++ b/tests/shell/testcases/rule_management/dumps/0011destroy_0.nft
@@ -0,0 +1,4 @@
+table ip t {
+	chain c {
+	}
+}
diff --git a/tests/shell/testcases/rule_management/dumps/0012destroy_0.nft b/tests/shell/testcases/rule_management/dumps/0012destroy_0.nft
new file mode 100644
index 00000000..1e0d1d60
--- /dev/null
+++ b/tests/shell/testcases/rule_management/dumps/0012destroy_0.nft
@@ -0,0 +1,4 @@
+table ip t {
+	chain c {
+	}
+}
-- 
2.30.2

