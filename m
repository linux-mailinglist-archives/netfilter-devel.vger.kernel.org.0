Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601836C6E41
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Mar 2023 17:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCWQ7J (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Mar 2023 12:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjCWQ7H (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:59:07 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7573893E4
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Mar 2023 09:59:06 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     jeremy@azazel.net, fw@strlen.de
Subject: [PATCH nft,v3 03/12] evaluate: don't eval unary arguments
Date:   Thu, 23 Mar 2023 17:58:46 +0100
Message-Id: <20230323165855.559837-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230323165855.559837-1-pablo@netfilter.org>
References: <20230323165855.559837-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Jeremy Sowden <jeremy@azazel.net>

When a unary expression is inserted to implement a byte-order
conversion, the expression being converted has already been evaluated
and so `expr_evaluate_unary` doesn't need to do so.

This is required by {ct|meta} statements with bitwise operations, which
might result in byteorder conversion of the expression.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index b0a7fa761624..e0263f97dcf8 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1198,12 +1198,10 @@ static int expr_evaluate_range(struct eval_ctx *ctx, struct expr **expr)
  */
 static int expr_evaluate_unary(struct eval_ctx *ctx, struct expr **expr)
 {
-	struct expr *unary = *expr, *arg;
+	struct expr *unary = *expr, *arg = unary->arg;
 	enum byteorder byteorder;
 
-	if (expr_evaluate(ctx, &unary->arg) < 0)
-		return -1;
-	arg = unary->arg;
+	/* unary expression arguments has already been evaluated. */
 
 	assert(!expr_is_constant(arg));
 	assert(expr_basetype(arg)->type == TYPE_INTEGER);
-- 
2.30.2

