Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F13736F302
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Apr 2021 01:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhD2Xn7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Apr 2021 19:43:59 -0400
Received: from mail.netfilter.org ([217.70.188.207]:59546 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhD2Xny (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Apr 2021 19:43:54 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id D529164133
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Apr 2021 01:42:27 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 15/18] evaluate: remove chain from cache on delete chain command
Date:   Fri, 30 Apr 2021 01:42:52 +0200
Message-Id: <20210429234255.16840-16-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210429234255.16840-1-pablo@netfilter.org>
References: <20210429234255.16840-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Update the cache to remove this chain from the evaluation phase. Add
chain_cache_del() function for this purpose.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/cache.h |  2 ++
 src/cache.c     |  5 +++++
 src/evaluate.c  | 24 ++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/cache.h b/include/cache.h
index fddb843b510e..3823e9a78653 100644
--- a/include/cache.h
+++ b/include/cache.h
@@ -62,7 +62,9 @@ struct table;
 struct chain;
 
 void chain_cache_add(struct chain *chain, struct table *table);
+void chain_cache_del(struct chain *chain);
 struct chain *chain_cache_find(const struct table *table, const char *name);
+
 void set_cache_add(struct set *set, struct table *table);
 void set_cache_del(struct set *set);
 struct set *set_cache_find(const struct table *table, const char *name);
diff --git a/src/cache.c b/src/cache.c
index 3c139f1a5dbb..a98ee5954c36 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -278,6 +278,11 @@ void chain_cache_add(struct chain *chain, struct table *table)
 	cache_add(&chain->cache, &table->chain_cache, hash);
 }
 
+void chain_cache_del(struct chain *chain)
+{
+	cache_del(&chain->cache);
+}
+
 struct chain *chain_cache_find(const struct table *table, const char *name)
 {
 	struct chain *chain;
diff --git a/src/evaluate.c b/src/evaluate.c
index e770cffa6d99..49d47d0b4f34 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -4367,6 +4367,28 @@ static void table_del_cache(struct eval_ctx *ctx, struct cmd *cmd)
 	table_free(table);
 }
 
+static void chain_del_cache(struct eval_ctx *ctx, struct cmd *cmd)
+{
+	struct table *table;
+	struct chain *chain;
+
+	if (!cmd->handle.chain.name)
+		return;
+
+	table = table_cache_find(&ctx->nft->cache.table_cache,
+				 cmd->handle.table.name,
+				 cmd->handle.family);
+	if (!table)
+		return;
+
+	chain = chain_cache_find(table, cmd->handle.chain.name);
+	if (!chain)
+		return;
+
+	chain_cache_del(chain);
+	chain_free(chain);
+}
+
 static int cmd_evaluate_delete(struct eval_ctx *ctx, struct cmd *cmd)
 {
 	switch (cmd->obj) {
@@ -4374,7 +4396,9 @@ static int cmd_evaluate_delete(struct eval_ctx *ctx, struct cmd *cmd)
 		return setelem_evaluate(ctx, cmd);
 	case CMD_OBJ_SET:
 	case CMD_OBJ_RULE:
+		return 0;
 	case CMD_OBJ_CHAIN:
+		chain_del_cache(ctx, cmd);
 		return 0;
 	case CMD_OBJ_TABLE:
 		table_del_cache(ctx, cmd);
-- 
2.20.1

