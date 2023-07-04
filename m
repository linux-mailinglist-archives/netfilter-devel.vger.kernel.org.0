Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9DC746BFC
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Jul 2023 10:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjGDIeA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 Jul 2023 04:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjGDIdW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:33:22 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8F70F2
        for <netfilter-devel@vger.kernel.org>; Tue,  4 Jul 2023 01:33:11 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] expression: define .clone for catchall set element
Date:   Tue,  4 Jul 2023 10:33:04 +0200
Message-Id: <20230704083305.6399-1-pablo@netfilter.org>
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

Otherwise reuse of catchall set element expression in variable triggers
a null-pointer dereference.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/expression.c                              | 15 +++++++++++--
 .../shell/testcases/maps/0017_map_variable_0  | 21 +++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)
 create mode 100755 tests/shell/testcases/maps/0017_map_variable_0

diff --git a/src/expression.c b/src/expression.c
index 9b53f43b5267..34902c842d16 100644
--- a/src/expression.c
+++ b/src/expression.c
@@ -1342,9 +1342,8 @@ static void set_elem_expr_destroy(struct expr *expr)
 		stmt_free(stmt);
 }
 
-static void set_elem_expr_clone(struct expr *new, const struct expr *expr)
+static void __set_elem_expr_clone(struct expr *new, const struct expr *expr)
 {
-	new->key = expr_clone(expr->key);
 	new->expiration = expr->expiration;
 	new->timeout = expr->timeout;
 	if (expr->comment)
@@ -1352,6 +1351,12 @@ static void set_elem_expr_clone(struct expr *new, const struct expr *expr)
 	init_list_head(&new->stmt_list);
 }
 
+static void set_elem_expr_clone(struct expr *new, const struct expr *expr)
+{
+	new->key = expr_clone(expr->key);
+	__set_elem_expr_clone(new, expr);
+}
+
 static const struct expr_ops set_elem_expr_ops = {
 	.type		= EXPR_SET_ELEM,
 	.name		= "set element",
@@ -1379,11 +1384,17 @@ static void set_elem_catchall_expr_print(const struct expr *expr,
 	nft_print(octx, "*");
 }
 
+static void set_elem_catchall_expr_clone(struct expr *new, const struct expr *expr)
+{
+	__set_elem_expr_clone(new, expr);
+}
+
 static const struct expr_ops set_elem_catchall_expr_ops = {
 	.type		= EXPR_SET_ELEM_CATCHALL,
 	.name		= "catch-all set element",
 	.print		= set_elem_catchall_expr_print,
 	.json		= set_elem_catchall_expr_json,
+	.clone		= set_elem_catchall_expr_clone,
 };
 
 struct expr *set_elem_catchall_expr_alloc(const struct location *loc)
diff --git a/tests/shell/testcases/maps/0017_map_variable_0 b/tests/shell/testcases/maps/0017_map_variable_0
new file mode 100755
index 000000000000..70cea88de238
--- /dev/null
+++ b/tests/shell/testcases/maps/0017_map_variable_0
@@ -0,0 +1,21 @@
+#!/bin/bash
+
+set -e
+
+RULESET="define x = {
+        1.1.1.1 : 2,
+        * : 3,
+}
+
+table ip x {
+        map y {
+                typeof ip saddr : mark
+                elements = \$x
+        }
+        map z {
+                typeof ip saddr : mark
+                elements = \$x
+        }
+}"
+
+$NFT -f - <<< "$RULESET"
-- 
2.30.2

