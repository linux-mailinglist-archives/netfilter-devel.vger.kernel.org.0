Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF153AA60A
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Jun 2021 23:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhFPVTc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Jun 2021 17:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhFPVTc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Jun 2021 17:19:32 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC0BC061574
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Jun 2021 14:17:25 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ltcua-0002T6-65; Wed, 16 Jun 2021 23:17:24 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     jake.owen@superloop.com, Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 1/8] evaluate: fix hash expression maxval
Date:   Wed, 16 Jun 2021 23:16:45 +0200
Message-Id: <20210616211652.11765-2-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616211652.11765-1-fw@strlen.de>
References: <20210616211652.11765-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

It needs to account for the offset too.

Fixes: 9bee0c86f179 ("src: add offset attribute for hash expression")
Fixes: d4f9a8fb9e9a ("src: add offset attribute for numgen expression")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index aa7ec9bee4ae..bebdb3f827e9 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1657,17 +1657,20 @@ static void expr_dtype_integer_compatible(struct eval_ctx *ctx,
 static int expr_evaluate_numgen(struct eval_ctx *ctx, struct expr **exprp)
 {
 	struct expr *expr = *exprp;
+	unsigned int maxval;
 
 	expr_dtype_integer_compatible(ctx, expr);
 
+	maxval = expr->numgen.mod + expr->numgen.offset - 1;
 	__expr_set_context(&ctx->ectx, expr->dtype, expr->byteorder, expr->len,
-			   expr->numgen.mod - 1);
+			   maxval);
 	return 0;
 }
 
 static int expr_evaluate_hash(struct eval_ctx *ctx, struct expr **exprp)
 {
 	struct expr *expr = *exprp;
+	unsigned int maxval;
 
 	expr_dtype_integer_compatible(ctx, expr);
 
@@ -1680,8 +1683,9 @@ static int expr_evaluate_hash(struct eval_ctx *ctx, struct expr **exprp)
          * expression to be hashed. Since this input is transformed to a 4 bytes
 	 * integer, restore context to the datatype that results from hashing.
 	 */
+	maxval = expr->hash.mod + expr->hash.offset - 1;
 	__expr_set_context(&ctx->ectx, expr->dtype, expr->byteorder, expr->len,
-			   expr->hash.mod - 1);
+			   maxval);
 
 	return 0;
 }
-- 
2.31.1

