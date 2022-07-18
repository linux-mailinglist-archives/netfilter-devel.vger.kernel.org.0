Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCBE5785FD
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 Jul 2022 17:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiGRPCd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 Jul 2022 11:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGRPCd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:02:33 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CDBA22BF8
        for <netfilter-devel@vger.kernel.org>; Mon, 18 Jul 2022 08:02:32 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/2] cache: validate handle string length
Date:   Mon, 18 Jul 2022 17:02:27 +0200
Message-Id: <20220718150227.506532-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220718150227.506532-1-pablo@netfilter.org>
References: <20220718150227.506532-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Maximum supported string length for handle is NFT_NAME_MAXLEN, report an
error if user is exceeding this limit.

By validating from the cache evaluation phase, both the native and json
parsers handle input are validated.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/cache.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 2 deletions(-)

diff --git a/src/cache.c b/src/cache.c
index 9e2fe950a884..8cae35deb90a 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -16,6 +16,7 @@
 #include <mnl.h>
 #include <libnftnl/chain.h>
 #include <linux/netfilter.h>
+#include <linux/netfilter/nf_tables.h>
 
 static unsigned int evaluate_cache_add(struct cmd *cmd, unsigned int flags)
 {
@@ -262,6 +263,107 @@ static unsigned int evaluate_cache_list(struct nft_ctx *nft, struct cmd *cmd,
 	return flags;
 }
 
+static int nft_cmd_validate(const struct cmd *cmd, struct list_head *msgs)
+{
+	const struct handle *h = &cmd->handle;
+	const struct location *loc;
+
+	switch (cmd->obj) {
+	case CMD_OBJ_TABLE:
+		if (h->table.name &&
+		    strlen(h->table.name) > NFT_NAME_MAXLEN) {
+			loc = &h->table.location;
+			goto err_name_too_long;
+		}
+		break;
+	case CMD_OBJ_RULE:
+	case CMD_OBJ_CHAIN:
+	case CMD_OBJ_CHAINS:
+		if (strlen(h->table.name) > NFT_NAME_MAXLEN) {
+			loc = &h->table.location;
+			goto err_name_too_long;
+		}
+		if (h->chain.name &&
+		    strlen(h->chain.name) > NFT_NAME_MAXLEN) {
+			loc = &h->chain.location;
+			goto err_name_too_long;
+		}
+		break;
+	case CMD_OBJ_ELEMENTS:
+	case CMD_OBJ_SET:
+	case CMD_OBJ_SETS:
+	case CMD_OBJ_MAP:
+	case CMD_OBJ_MAPS:
+	case CMD_OBJ_METER:
+	case CMD_OBJ_METERS:
+		if (h->table.name &&
+		    strlen(h->table.name) > NFT_NAME_MAXLEN) {
+			loc = &h->table.location;
+			goto err_name_too_long;
+		}
+		if (h->set.name &&
+		    strlen(h->set.name) > NFT_NAME_MAXLEN) {
+			loc = &h->set.location;
+			goto err_name_too_long;
+		}
+		break;
+	case CMD_OBJ_FLOWTABLE:
+	case CMD_OBJ_FLOWTABLES:
+		if (h->table.name &&
+		    strlen(h->table.name) > NFT_NAME_MAXLEN) {
+			loc = &h->table.location;
+			goto err_name_too_long;
+		}
+		if (cmd->handle.flowtable.name &&
+		    strlen(cmd->handle.flowtable.name) > NFT_NAME_MAXLEN) {
+			loc = &h->flowtable.location;
+			goto err_name_too_long;
+		}
+		break;
+	case CMD_OBJ_INVALID:
+	case CMD_OBJ_EXPR:
+	case CMD_OBJ_RULESET:
+	case CMD_OBJ_MARKUP:
+	case CMD_OBJ_MONITOR:
+	case CMD_OBJ_SETELEMS:
+	case CMD_OBJ_HOOKS:
+		break;
+	case CMD_OBJ_COUNTER:
+	case CMD_OBJ_COUNTERS:
+	case CMD_OBJ_QUOTA:
+	case CMD_OBJ_QUOTAS:
+	case CMD_OBJ_LIMIT:
+	case CMD_OBJ_LIMITS:
+	case CMD_OBJ_SECMARK:
+	case CMD_OBJ_SECMARKS:
+	case CMD_OBJ_SYNPROXY:
+	case CMD_OBJ_SYNPROXYS:
+	case CMD_OBJ_CT_HELPER:
+	case CMD_OBJ_CT_HELPERS:
+	case CMD_OBJ_CT_TIMEOUT:
+	case CMD_OBJ_CT_EXPECT:
+		if (h->table.name &&
+		    strlen(h->table.name) > NFT_NAME_MAXLEN) {
+			loc = &h->table.location;
+			goto err_name_too_long;
+		}
+		if (h->obj.name &&
+		    strlen(h->obj.name) > NFT_NAME_MAXLEN) {
+			loc = &h->obj.location;
+			goto err_name_too_long;
+		}
+		break;
+	}
+
+	return 0;
+
+err_name_too_long:
+	erec_queue(error(loc, "name too long, %d characters maximum allowed",
+			 NFT_NAME_MAXLEN),
+		   msgs);
+	return -1;
+}
+
 int nft_cache_evaluate(struct nft_ctx *nft, struct list_head *cmds,
 		       struct list_head *msgs, struct nft_cache_filter *filter,
 		       unsigned int *pflags)
@@ -270,8 +372,8 @@ int nft_cache_evaluate(struct nft_ctx *nft, struct list_head *cmds,
 	struct cmd *cmd;
 
 	list_for_each_entry(cmd, cmds, list) {
-		if (filter->list.table && cmd->op != CMD_LIST)
-			memset(&filter->list, 0, sizeof(filter->list));
+		if (nft_cmd_validate(cmd, msgs) < 0)
+			return -1;
 
 		switch (cmd->op) {
 		case CMD_ADD:
-- 
2.30.2

