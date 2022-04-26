Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2B750FB06
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Apr 2022 12:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbiDZKlV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 Apr 2022 06:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350028AbiDZKjy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:39:54 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA4A33A29
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Apr 2022 03:29:43 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1njIRw-0002cz-Ej; Tue, 26 Apr 2022 12:29:40 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] src: fix always-true assertions
Date:   Tue, 26 Apr 2022 12:29:35 +0200
Message-Id: <20220426102935.14950-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

assert(1) is a no-op, this should be assert(0). Use BUG() instead.
Add missing CATCHALL to avoid BUG().

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c  | 2 +-
 src/intervals.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index b5f74d2f5051..1447a4c28aee 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1499,7 +1499,7 @@ static int interval_set_eval(struct eval_ctx *ctx, struct set *set,
 	case CMD_GET:
 		break;
 	default:
-		assert(1);
+		BUG("unhandled op %d\n", ctx->cmd->op);
 		break;
 	}
 
diff --git a/src/intervals.c b/src/intervals.c
index a74238525d8d..85ec59eda36a 100644
--- a/src/intervals.c
+++ b/src/intervals.c
@@ -20,6 +20,7 @@ static void setelem_expr_to_range(struct expr *expr)
 	assert(expr->etype == EXPR_SET_ELEM);
 
 	switch (expr->key->etype) {
+	case EXPR_SET_ELEM_CATCHALL:
 	case EXPR_RANGE:
 		break;
 	case EXPR_PREFIX:
@@ -53,7 +54,7 @@ static void setelem_expr_to_range(struct expr *expr)
 		expr->key = key;
 		break;
 	default:
-		assert(1);
+		BUG("unhandled key type %d\n", expr->key->etype);
 	}
 }
 
@@ -185,7 +186,7 @@ static struct expr *interval_expr_key(struct expr *i)
 		elem = i;
 		break;
 	default:
-		assert(1);
+		BUG("unhandled expression type %d\n", i->etype);
 		return NULL;
 	}
 
-- 
2.35.1

