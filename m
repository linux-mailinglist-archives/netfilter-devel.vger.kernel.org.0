Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C66D351991
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Apr 2021 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbhDARyJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Apr 2021 13:54:09 -0400
Received: from mail.netfilter.org ([217.70.188.207]:53002 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbhDARoy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:44:54 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 9074163E34
        for <netfilter-devel@vger.kernel.org>; Thu,  1 Apr 2021 13:37:20 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] evaluate: use chain hashtable for lookups
Date:   Thu,  1 Apr 2021 13:37:32 +0200
Message-Id: <20210401113732.8328-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Instead of the linear list.

Before this patch:

real    0m21,735s
user    0m20,329s
sys     0m1,384s

After:

real    0m10,910s
user    0m9,448s
sys     0m1,434s

This patch requires a small adjust: Allocate a clone of the existing
chain in the cache, instead of recycling the object to avoid a list
corruption.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 15 ++++++++++-----
 src/rule.c     |  2 +-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index cebf7cb8ef2c..5f64979453ad 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -4106,15 +4106,20 @@ static int chain_evaluate(struct eval_ctx *ctx, struct chain *chain)
 		return table_not_found(ctx);
 
 	if (chain == NULL) {
-		if (chain_lookup(table, &ctx->cmd->handle) == NULL) {
+		if (chain_cache_find(table, &ctx->cmd->handle) == NULL) {
 			chain = chain_alloc(NULL);
 			handle_merge(&chain->handle, &ctx->cmd->handle);
 			chain_cache_add(chain, table);
 		}
 		return 0;
 	} else if (!(chain->flags & CHAIN_F_BINDING)) {
-		if (chain_lookup(table, &chain->handle) == NULL)
-			chain_cache_add(chain_get(chain), table);
+		if (chain_cache_find(table, &chain->handle) == NULL) {
+			struct chain *newchain;
+
+			newchain = chain_alloc(NULL);
+			handle_merge(&newchain->handle, &chain->handle);
+			chain_cache_add(newchain, table);
+		}
 	}
 
 	if (chain->flags & CHAIN_F_BASECHAIN) {
@@ -4440,7 +4445,7 @@ static int cmd_evaluate_list(struct eval_ctx *ctx, struct cmd *cmd)
 		if (table == NULL)
 			return table_not_found(ctx);
 
-		if (chain_lookup(table, &cmd->handle) == NULL)
+		if (chain_cache_find(table, &cmd->handle) == NULL)
 			return chain_not_found(ctx);
 
 		return 0;
@@ -4600,7 +4605,7 @@ static int cmd_evaluate_rename(struct eval_ctx *ctx, struct cmd *cmd)
 		if (table == NULL)
 			return table_not_found(ctx);
 
-		if (chain_lookup(table, &ctx->cmd->handle) == NULL)
+		if (chain_cache_find(table, &ctx->cmd->handle) == NULL)
 			return chain_not_found(ctx);
 
 		break;
diff --git a/src/rule.c b/src/rule.c
index 969318008933..4f1ca22ec9e7 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -2621,7 +2621,7 @@ static int do_command_rename(struct netlink_ctx *ctx, struct cmd *cmd)
 
 	switch (cmd->obj) {
 	case CMD_OBJ_CHAIN:
-		chain = chain_lookup(table, &cmd->handle);
+		chain = chain_cache_find(table, &cmd->handle);
 
 		return mnl_nft_chain_rename(ctx, cmd, chain);
 	default:
-- 
2.20.1

