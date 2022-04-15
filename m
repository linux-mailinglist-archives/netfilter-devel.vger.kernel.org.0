Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EFE502787
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Apr 2022 11:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242880AbiDOJpj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 Apr 2022 05:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245173AbiDOJpj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:45:39 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57031B1ABF
        for <netfilter-devel@vger.kernel.org>; Fri, 15 Apr 2022 02:43:11 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v2 1/3] intervals: add elements with EXPR_F_KERNEL to purge list only
Date:   Fri, 15 Apr 2022 11:43:04 +0200
Message-Id: <20220415094306.642207-1-pablo@netfilter.org>
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

Do not add elements to purge list which are not in the kernel,
otherwise, bogus ENOENT is reported.

Fixes: 3e8d934e4f722 ("intervals: support to partial deletion with automerge")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes

 src/intervals.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/intervals.c b/src/intervals.c
index a8fada9ba079..590a2967c0f3 100644
--- a/src/intervals.c
+++ b/src/intervals.c
@@ -329,8 +329,10 @@ static void split_range(struct set *set, struct expr *prev, struct expr *i,
 {
 	struct expr *clone;
 
-	clone = expr_clone(prev);
-	list_move_tail(&clone->list, &purge->expressions);
+	if (prev->flags & EXPR_F_KERNEL) {
+		clone = expr_clone(prev);
+		list_move_tail(&clone->list, &purge->expressions);
+	}
 
 	prev->flags &= ~EXPR_F_KERNEL;
 	clone = expr_clone(prev);
@@ -413,7 +415,9 @@ static int setelem_delete(struct list_head *msgs, struct set *set,
 		if (mpz_cmp(prev_range.low, range.low) == 0 &&
 		    mpz_cmp(prev_range.high, range.high) == 0) {
 			if (i->flags & EXPR_F_REMOVE) {
-				list_move_tail(&prev->list, &purge->expressions);
+				if (prev->flags & EXPR_F_KERNEL)
+					list_move_tail(&prev->list, &purge->expressions);
+
 				list_del(&i->list);
 				expr_free(i);
 			}
-- 
2.30.2

