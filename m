Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28884CC06E
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Mar 2022 15:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiCCO5n (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 3 Mar 2022 09:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiCCO5m (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:57:42 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4077D18FAE0
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Mar 2022 06:56:57 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 8412760743
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Mar 2022 15:55:22 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v3 1/3] optimize: more robust statement merge with vmap
Date:   Thu,  3 Mar 2022 15:56:47 +0100
Message-Id: <20220303145649.843320-1-pablo@netfilter.org>
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

Check expressions that are expected on the rhs rather than using a
catch-all default case.

Actually, lists and sets need to be their own routine, because this
needs the set element key expression to be merged.

This is a follow up to 99eb46969f3d ("optimize: fix vmap with anonymous
sets").

Fixes: 1542082e259b ("optimize: merge same selector with different verdict into verdict map")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: - EXPR_VALUE is possible, parser might allocate this expression before eval.
    - EXPR_CONCAT is also supported.

 src/optimize.c                                 | 18 ++++++++++++++++--
 .../optimizations/dumps/merge_stmts_vmap.nft   |  2 +-
 .../testcases/optimizations/merge_stmts_vmap   |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/src/optimize.c b/src/optimize.c
index 64c0a4dbe764..af075da437f9 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -437,7 +437,6 @@ static void build_verdict_map(struct expr *expr, struct stmt *verdict, struct ex
 
 	switch (expr->etype) {
 	case EXPR_LIST:
-	case EXPR_SET:
 		list_for_each_entry(item, &expr->expressions, list) {
 			elem = set_elem_expr_alloc(&internal_location, expr_get(item));
 			mapping = mapping_expr_alloc(&internal_location, elem,
@@ -445,12 +444,27 @@ static void build_verdict_map(struct expr *expr, struct stmt *verdict, struct ex
 			compound_expr_add(set, mapping);
 		}
 		break;
-	default:
+	case EXPR_SET:
+		list_for_each_entry(item, &expr->expressions, list) {
+			elem = set_elem_expr_alloc(&internal_location, expr_get(item->key));
+			mapping = mapping_expr_alloc(&internal_location, elem,
+						     expr_get(verdict->expr));
+			compound_expr_add(set, mapping);
+		}
+		break;
+	case EXPR_PREFIX:
+	case EXPR_RANGE:
+	case EXPR_VALUE:
+	case EXPR_SYMBOL:
+	case EXPR_CONCAT:
 		elem = set_elem_expr_alloc(&internal_location, expr_get(expr));
 		mapping = mapping_expr_alloc(&internal_location, elem,
 					     expr_get(verdict->expr));
 		compound_expr_add(set, mapping);
 		break;
+	default:
+		assert(0);
+		break;
 	}
 }
 
diff --git a/tests/shell/testcases/optimizations/dumps/merge_stmts_vmap.nft b/tests/shell/testcases/optimizations/dumps/merge_stmts_vmap.nft
index 427572954a18..5a9b3006743b 100644
--- a/tests/shell/testcases/optimizations/dumps/merge_stmts_vmap.nft
+++ b/tests/shell/testcases/optimizations/dumps/merge_stmts_vmap.nft
@@ -4,6 +4,6 @@ table ip x {
 	}
 
 	chain z {
-		tcp dport vmap { 1 : accept, 2-3 : drop }
+		tcp dport vmap { 1 : accept, 2-3 : drop, 4 : accept }
 	}
 }
diff --git a/tests/shell/testcases/optimizations/merge_stmts_vmap b/tests/shell/testcases/optimizations/merge_stmts_vmap
index 6511c7b20cb6..79350076d6c6 100755
--- a/tests/shell/testcases/optimizations/merge_stmts_vmap
+++ b/tests/shell/testcases/optimizations/merge_stmts_vmap
@@ -10,6 +10,7 @@ RULESET="table ip x {
 	chain z {
 		tcp dport { 1 } accept
 		tcp dport 2-3 drop
+		tcp dport 4 accept
 	}
 }"
 
-- 
2.30.2

