Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2C04CBF4A
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Mar 2022 14:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbiCCOAK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 3 Mar 2022 09:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiCCOAJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:00:09 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0FFB64BC9
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Mar 2022 05:59:23 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 7EBCE625FA
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Mar 2022 14:57:47 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] optimize: do not merge unsupported statement expressions
Date:   Thu,  3 Mar 2022 14:59:18 +0100
Message-Id: <20220303135918.660906-1-pablo@netfilter.org>
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

Only value, range, prefix, set and list are supported at this stage.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/optimize.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/optimize.c b/src/optimize.c
index c8bdccf7b610..b4035d0a96fc 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -91,6 +91,22 @@ static bool __expr_cmp(const struct expr *expr_a, const struct expr *expr_b)
 	return true;
 }
 
+static bool stmt_expr_supported(const struct expr *expr)
+{
+	switch (expr->right->etype) {
+	case EXPR_VALUE:
+	case EXPR_RANGE:
+	case EXPR_PREFIX:
+	case EXPR_SET:
+	case EXPR_LIST:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
 static bool __stmt_type_eq(const struct stmt *stmt_a, const struct stmt *stmt_b)
 {
 	struct expr *expr_a, *expr_b;
@@ -103,6 +119,10 @@ static bool __stmt_type_eq(const struct stmt *stmt_a, const struct stmt *stmt_b)
 		expr_a = stmt_a->expr;
 		expr_b = stmt_b->expr;
 
+		if (!stmt_expr_supported(expr_a) ||
+		    !stmt_expr_supported(expr_b))
+			return false;
+
 		return __expr_cmp(expr_a->left, expr_b->left);
 	case STMT_COUNTER:
 	case STMT_NOTRACK:
-- 
2.30.2

