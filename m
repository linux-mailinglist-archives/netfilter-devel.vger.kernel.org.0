Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A9F6ED6B8
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Apr 2023 23:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjDXVVu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Apr 2023 17:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjDXVVt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:21:49 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C3276E80
        for <netfilter-devel@vger.kernel.org>; Mon, 24 Apr 2023 14:21:48 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] json: allow to specify comment on table
Date:   Mon, 24 Apr 2023 23:21:45 +0200
Message-Id: <20230424212145.213584-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
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

 # sudo nft add table inet test3 '{comment "this is a comment";}'
 # nft list ruleset
 table inet test3 {
        comment "this is a comment"
 }
 # nft -j list ruleset
 {"nftables": [{"metainfo": {"version": "1.0.7", "release_name": "Old Doc Yak", "json_schema_version": 1}}, {"table": {"family": "inet", "name": "test3", "handle": 3, "comment": "this is a comment"}}]}
 # nft -j list ruleset > test.json
 # nft flush ruleset
 # nft -j -f test.json
 # nft -j list ruleset
 {"nftables": [{"metainfo": {"version": "1.0.7", "release_name": "Old Doc Yak", "json_schema_version": 1}}, {"table": {"family": "inet", "name": "test3", "handle": 4, "comment": "this is a comment"}}]}

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1670
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/json.c        |  3 +++
 src/parser_json.c | 20 +++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/src/json.c b/src/json.c
index f15461d33894..ae00055d71f5 100644
--- a/src/json.c
+++ b/src/json.c
@@ -510,6 +510,9 @@ static json_t *table_print_json(const struct table *table)
 	if (tmp)
 		json_object_set_new(root, "flags", tmp);
 
+	if (table->comment)
+		json_object_set_new(root, "comment", json_string(table->comment));
+
 	return json_pack("{s:o}", "table", root);
 }
 
diff --git a/src/parser_json.c b/src/parser_json.c
index ec0c02a044e2..95f6bdcd943d 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -2789,17 +2789,21 @@ static struct stmt *json_parse_stmt(struct json_ctx *ctx, json_t *root)
 static struct cmd *json_parse_cmd_add_table(struct json_ctx *ctx, json_t *root,
 					    enum cmd_ops op, enum cmd_obj obj)
 {
+	const char *family = "", *comment = NULL;
 	struct handle h = {
 		.table.location = *int_loc,
 	};
-	const char *family = "";
+	struct table *table = NULL;
 
 	if (json_unpack_err(ctx, root, "{s:s}",
 			    "family", &family))
 		return NULL;
-	if (op != CMD_DELETE &&
-	    json_unpack_err(ctx, root, "{s:s}", "name", &h.table.name)) {
-		return NULL;
+
+	if (op != CMD_DELETE) {
+		if (json_unpack_err(ctx, root, "{s:s}", "name", &h.table.name))
+			return NULL;
+
+		json_unpack(root, "{s:s}", "comment", &comment);
 	} else if (op == CMD_DELETE &&
 		   json_unpack(root, "{s:s}", "name", &h.table.name) &&
 		   json_unpack(root, "{s:I}", "handle", &h.handle.id)) {
@@ -2813,10 +2817,16 @@ static struct cmd *json_parse_cmd_add_table(struct json_ctx *ctx, json_t *root,
 	if (h.table.name)
 		h.table.name = xstrdup(h.table.name);
 
+	if (comment) {
+		table = table_alloc();
+		handle_merge(&table->handle, &h);
+		table->comment = xstrdup(comment);
+	}
+
 	if (op == CMD_ADD)
 		json_object_del(root, "handle");
 
-	return cmd_alloc(op, obj, &h, int_loc, NULL);
+	return cmd_alloc(op, obj, &h, int_loc, table);
 }
 
 static struct expr *parse_policy(const char *policy)
-- 
2.30.2

