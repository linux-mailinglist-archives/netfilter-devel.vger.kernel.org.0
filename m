Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CBF5512D0
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Jun 2022 10:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbiFTIci (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jun 2022 04:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239842AbiFTIcb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:32:31 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C109512A84
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Jun 2022 01:32:29 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 15/18] optimize: only merge OP_IMPLICIT and OP_EQ relational
Date:   Mon, 20 Jun 2022 10:32:12 +0200
Message-Id: <20220620083215.1021238-16-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220620083215.1021238-1-pablo@netfilter.org>
References: <20220620083215.1021238-1-pablo@netfilter.org>
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

Add test to cover this case.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/optimize.c                                       | 10 ++++++++++
 .../testcases/optimizations/dumps/skip_non_eq.nft    |  6 ++++++
 tests/shell/testcases/optimizations/skip_non_eq      | 12 ++++++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 tests/shell/testcases/optimizations/dumps/skip_non_eq.nft
 create mode 100755 tests/shell/testcases/optimizations/skip_non_eq

diff --git a/src/optimize.c b/src/optimize.c
index e3d4bc785226..e4508fa5116a 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -164,6 +164,11 @@ static bool __stmt_type_eq(const struct stmt *stmt_a, const struct stmt *stmt_b,
 		expr_a = stmt_a->expr;
 		expr_b = stmt_b->expr;
 
+		if (expr_a->op != expr_b->op)
+			return false;
+		if (expr_a->op != OP_IMPLICIT && expr_a->op != OP_EQ)
+			return false;
+
 		if (fully_compare) {
 			if (!stmt_expr_supported(expr_a) ||
 			    !stmt_expr_supported(expr_b))
@@ -351,6 +356,11 @@ static int rule_collect_stmts(struct optimize_ctx *ctx, struct rule *rule)
 		clone = stmt_alloc(&internal_location, stmt->ops);
 		switch (stmt->ops->type) {
 		case STMT_EXPRESSION:
+			if (stmt->expr->op != OP_IMPLICIT &&
+			    stmt->expr->op != OP_EQ) {
+				clone->ops = &unsupported_stmt_ops;
+				break;
+			}
 		case STMT_VERDICT:
 			clone->expr = expr_get(stmt->expr);
 			break;
diff --git a/tests/shell/testcases/optimizations/dumps/skip_non_eq.nft b/tests/shell/testcases/optimizations/dumps/skip_non_eq.nft
new file mode 100644
index 000000000000..6df386550357
--- /dev/null
+++ b/tests/shell/testcases/optimizations/dumps/skip_non_eq.nft
@@ -0,0 +1,6 @@
+table inet x {
+	chain y {
+		iifname "eth0" oifname != "eth0" counter packets 0 bytes 0 accept
+		iifname "eth0" oifname "eth0" counter packets 0 bytes 0 accept
+	}
+}
diff --git a/tests/shell/testcases/optimizations/skip_non_eq b/tests/shell/testcases/optimizations/skip_non_eq
new file mode 100755
index 000000000000..431ed0ad05dc
--- /dev/null
+++ b/tests/shell/testcases/optimizations/skip_non_eq
@@ -0,0 +1,12 @@
+#!/bin/bash
+
+set -e
+
+RULESET="table inet x {
+	chain y {
+		iifname "eth0" oifname != "eth0" counter packets 0 bytes 0 accept
+		iifname "eth0" oifname "eth0" counter packets 0 bytes 0 accept
+	}
+}"
+
+$NFT -o -f - <<< $RULESET
-- 
2.30.2

