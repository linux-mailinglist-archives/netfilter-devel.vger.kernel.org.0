Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B5544ABC1
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Nov 2021 11:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243623AbhKIKrv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Nov 2021 05:47:51 -0500
Received: from mail.netfilter.org ([217.70.188.207]:50170 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245446AbhKIKru (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Nov 2021 05:47:50 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 6341760639
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Nov 2021 11:43:05 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] cache: move list filter under struct
Date:   Tue,  9 Nov 2021 11:44:56 +0100
Message-Id: <20211109104457.90843-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Wrap the table and set fields for list filtering to prepare for the
introduction element filters.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: no updates.

 include/cache.h |  6 ++++--
 src/cache.c     | 22 +++++++++++-----------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/cache.h b/include/cache.h
index 0523358889de..7d61701a02b5 100644
--- a/include/cache.h
+++ b/include/cache.h
@@ -39,8 +39,10 @@ enum cache_level_flags {
 };
 
 struct nft_cache_filter {
-	const char		*table;
-	const char		*set;
+	struct {
+		const char	*table;
+		const char	*set;
+	} list;
 };
 
 struct nft_cache;
diff --git a/src/cache.c b/src/cache.c
index 0cddd1e1cb48..58397551aafc 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -134,19 +134,19 @@ static unsigned int evaluate_cache_list(struct nft_ctx *nft, struct cmd *cmd,
 	switch (cmd->obj) {
 	case CMD_OBJ_TABLE:
 		if (filter && cmd->handle.table.name)
-			filter->table = cmd->handle.table.name;
+			filter->list.table = cmd->handle.table.name;
 
 		flags |= NFT_CACHE_FULL;
 		break;
 	case CMD_OBJ_SET:
 	case CMD_OBJ_MAP:
 		if (filter && cmd->handle.table.name && cmd->handle.set.name) {
-			filter->table = cmd->handle.table.name;
-			filter->set = cmd->handle.set.name;
+			filter->list.table = cmd->handle.table.name;
+			filter->list.set = cmd->handle.set.name;
 		}
 		if (nft_output_terse(&nft->output))
 			flags |= (NFT_CACHE_FULL & ~NFT_CACHE_SETELEM_BIT);
-		else if (filter->table && filter->set)
+		else if (filter->list.table && filter->list.set)
 			flags |= NFT_CACHE_TABLE | NFT_CACHE_SET | NFT_CACHE_SETELEM;
 		else
 			flags |= NFT_CACHE_FULL;
@@ -183,8 +183,8 @@ unsigned int nft_cache_evaluate(struct nft_ctx *nft, struct list_head *cmds,
 	struct cmd *cmd;
 
 	list_for_each_entry(cmd, cmds, list) {
-		if (filter->table && cmd->op != CMD_LIST)
-			memset(filter, 0, sizeof(*filter));
+		if (filter->list.table && cmd->op != CMD_LIST)
+			memset(&filter->list, 0, sizeof(filter->list));
 
 		switch (cmd->op) {
 		case CMD_ADD:
@@ -377,9 +377,9 @@ static int set_cache_cb(struct nftnl_set *nls, void *arg)
 	if (!set)
 		return -1;
 
-	if (ctx->filter && ctx->filter->set &&
-	    (strcmp(ctx->filter->table, set->handle.table.name) ||
-	     strcmp(ctx->filter->set, set->handle.set.name))) {
+	if (ctx->filter && ctx->filter->list.set &&
+	    (strcmp(ctx->filter->list.table, set->handle.table.name) ||
+	     strcmp(ctx->filter->list.set, set->handle.set.name))) {
 		set_free(set);
 		return 0;
 	}
@@ -637,8 +637,8 @@ static int cache_init_tables(struct netlink_ctx *ctx, struct handle *h,
 	list_for_each_entry_safe(table, next, &ctx->list, list) {
 		list_del(&table->list);
 
-		if (filter && filter->table &&
-		    (strcmp(filter->table, table->handle.table.name))) {
+		if (filter && filter->list.table &&
+		    (strcmp(filter->list.table, table->handle.table.name))) {
 			table_free(table);
 			continue;
 		}
-- 
2.30.2

