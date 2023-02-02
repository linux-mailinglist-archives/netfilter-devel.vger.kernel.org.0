Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FD56888B5
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Feb 2023 22:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjBBVEi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 2 Feb 2023 16:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjBBVEh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:04:37 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DA5B244AD
        for <netfilter-devel@vger.kernel.org>; Thu,  2 Feb 2023 13:04:36 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] optimize: wrap code to build concatenation in helper function
Date:   Thu,  2 Feb 2023 22:04:31 +0100
Message-Id: <20230202210432.106465-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Move code to build concatenations into helper function, this routine
includes support for expansion of implicit sets containing singleton
values. This is preparation work to reuse existing code in a follow up
patch.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/optimize.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/src/optimize.c b/src/optimize.c
index 289c442dc915..8cec04c02c4f 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -552,20 +552,19 @@ static void merge_stmts(const struct optimize_ctx *ctx,
 	}
 }
 
-static void __merge_concat_stmts(const struct optimize_ctx *ctx, uint32_t i,
-				 const struct merge *merge, struct expr *set)
+static void __merge_concat(const struct optimize_ctx *ctx, uint32_t i,
+			   const struct merge *merge, struct list_head *concat_list)
 {
-	struct expr *concat, *next, *expr, *concat_clone, *clone, *elem;
+	struct expr *concat, *next, *expr, *concat_clone, *clone;
 	LIST_HEAD(pending_list);
-	LIST_HEAD(concat_list);
 	struct stmt *stmt_a;
 	uint32_t k;
 
 	concat = concat_expr_alloc(&internal_location);
-	list_add(&concat->list, &concat_list);
+	list_add(&concat->list, concat_list);
 
 	for (k = 0; k < merge->num_stmts; k++) {
-		list_for_each_entry_safe(concat, next, &concat_list, list) {
+		list_for_each_entry_safe(concat, next, concat_list, list) {
 			stmt_a = ctx->stmt_matrix[i][merge->stmt[k]];
 			switch (stmt_a->expr->right->etype) {
 			case EXPR_SET:
@@ -590,8 +589,17 @@ static void __merge_concat_stmts(const struct optimize_ctx *ctx, uint32_t i,
 				break;
 			}
 		}
-		list_splice_init(&pending_list, &concat_list);
+		list_splice_init(&pending_list, concat_list);
 	}
+}
+
+static void __merge_concat_stmts(const struct optimize_ctx *ctx, uint32_t i,
+				 const struct merge *merge, struct expr *set)
+{
+	struct expr *concat, *next, *elem;
+	LIST_HEAD(concat_list);
+
+	__merge_concat(ctx, i, merge, &concat_list);
 
 	list_for_each_entry_safe(concat, next, &concat_list, list) {
 		list_del(&concat->list);
-- 
2.30.2

