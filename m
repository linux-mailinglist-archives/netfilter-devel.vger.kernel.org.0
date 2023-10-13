Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30F07C8360
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Oct 2023 12:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjJMKmE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Oct 2023 06:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjJMKmD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:42:03 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2D4AD
        for <netfilter-devel@vger.kernel.org>; Fri, 13 Oct 2023 03:42:01 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qrFcG-00070D-4C; Fri, 13 Oct 2023 12:42:00 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] evaluate: suggest != in negation error message
Date:   Fri, 13 Oct 2023 12:41:49 +0200
Message-ID: <20231013104154.7482-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

  when I run sudo nft insert rule filter FORWARD iifname "ens2f1" ip saddr not @ip_macs counter drop comment \" BLOCK ALL NON REGISTERED IP/MACS \"
  I get: Error: negation can only be used with singleton bitmask values

And even I did not spot the problem immediately.

I don't think "not" should have been added, its easily confused with
"not equal"/"neq"/!= and hides that this is (allegedly) a bit operation.

At least suggest to use != instead in the error message, I suspect it
might lessen the pain.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index c699a9bc7b86..b7ae9113b5a8 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2480,7 +2480,7 @@ static int expr_evaluate_relational(struct eval_ctx *ctx, struct expr **expr)
 			    right->dtype->basetype == NULL ||
 			    right->dtype->basetype->type != TYPE_BITMASK)
 				return expr_binary_error(ctx->msgs, left, right,
-							 "negation can only be used with singleton bitmask values");
+							 "negation can only be used with singleton bitmask values.  Did you mean \"!=\"?");
 		}
 
 		switch (right->etype) {
-- 
2.41.0

