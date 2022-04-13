Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B24FEC80
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Apr 2022 03:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiDMBv7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Apr 2022 21:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiDMBv5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:51:57 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E322120BDD
        for <netfilter-devel@vger.kernel.org>; Tue, 12 Apr 2022 18:49:37 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nft,v6 6/8] evaluate: allow for zero length ranges
Date:   Wed, 13 Apr 2022 03:49:28 +0200
Message-Id: <20220413014930.410728-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220413014930.410728-1-pablo@netfilter.org>
References: <20220413014930.410728-1-pablo@netfilter.org>
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

Allow for ranges such as, eg. 30-30.

This is required by the new intervals.c code, which normalize constant,
prefix set elements to all ranges.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 7f748c4993a4..eb147585c862 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1029,7 +1029,7 @@ static int expr_evaluate_range(struct eval_ctx *ctx, struct expr **expr)
 	left = range->left;
 	right = range->right;
 
-	if (mpz_cmp(left->value, right->value) >= 0)
+	if (mpz_cmp(left->value, right->value) > 0)
 		return expr_error(ctx->msgs, range,
 				  "Range has zero or negative size");
 	datatype_set(range, left->dtype);
-- 
2.30.2

