Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D738C4C9766
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Mar 2022 21:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbiCAU7Y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 1 Mar 2022 15:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbiCAU7X (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:59:23 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24DE050B04
        for <netfilter-devel@vger.kernel.org>; Tue,  1 Mar 2022 12:58:42 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 0739460745
        for <netfilter-devel@vger.kernel.org>; Tue,  1 Mar 2022 21:57:13 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v3 6/7] evaluate: allow for zero length ranges
Date:   Tue,  1 Mar 2022 21:58:33 +0100
Message-Id: <20220301205834.290720-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220301205834.290720-1-pablo@netfilter.org>
References: <20220301205834.290720-1-pablo@netfilter.org>
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
index 42edb24bf127..96a8fd799aeb 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1017,7 +1017,7 @@ static int expr_evaluate_range(struct eval_ctx *ctx, struct expr **expr)
 	left = range->left;
 	right = range->right;
 
-	if (mpz_cmp(left->value, right->value) >= 0)
+	if (mpz_cmp(left->value, right->value) > 0)
 		return expr_error(ctx->msgs, range,
 				  "Range has zero or negative size");
 	datatype_set(range, left->dtype);
-- 
2.30.2

