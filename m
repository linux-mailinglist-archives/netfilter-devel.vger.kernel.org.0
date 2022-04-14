Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F37501919
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 Apr 2022 18:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiDNQxu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 14 Apr 2022 12:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245208AbiDNQw6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:52:58 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33DC5139AE3
        for <netfilter-devel@vger.kernel.org>; Thu, 14 Apr 2022 09:22:02 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/2] intervals: fix deletion of multiple ranges with automerge
Date:   Thu, 14 Apr 2022 18:21:58 +0200
Message-Id: <20220414162158.636939-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220414162158.636939-1-pablo@netfilter.org>
References: <20220414162158.636939-1-pablo@netfilter.org>
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

Iterate over the list of elements to be deleted, then splice one
EXPR_F_REMOVE element at a time to update the list of existing sets
incrementally.

Fixes: 3e8d934e4f722 ("intervals: support to partial deletion with automerge")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/intervals.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/src/intervals.c b/src/intervals.c
index 590a2967c0f3..7254a23ccf7c 100644
--- a/src/intervals.c
+++ b/src/intervals.c
@@ -454,34 +454,43 @@ static void automerge_delete(struct list_head *msgs, struct set *set,
 	expr_free(ctx.purge);
 }
 
+static int __set_delete(struct list_head *msgs, struct expr *i,	struct set *set,
+			struct expr *add, struct expr *init,
+			struct set *existing_set, unsigned int debug_mask)
+{
+	i->flags |= EXPR_F_REMOVE;
+	list_move(&i->list, &existing_set->init->expressions);
+	list_expr_sort(&existing_set->init->expressions);
+
+	return setelem_delete(msgs, set, add, init, existing_set->init, debug_mask);
+}
+
 /* detection for unexisting intervals already exists in Linux kernels >= 5.7. */
 int set_delete(struct list_head *msgs, struct cmd *cmd, struct set *set,
 	       struct expr *init, unsigned int debug_mask)
 {
 	struct set *existing_set = set->existing_set;
-	struct expr *i, *add;
+	struct expr *i, *next, *add;
 	struct handle h = {};
 	struct cmd *add_cmd;
+	LIST_HEAD(del_list);
 	int err;
 
 	set_to_range(init);
 	if (set->automerge)
 		automerge_delete(msgs, set, init, debug_mask);
 
-	list_for_each_entry(i, &init->expressions, list)
-		i->flags |= EXPR_F_REMOVE;
-
 	set_to_range(existing_set->init);
-	list_splice_init(&init->expressions, &existing_set->init->expressions);
-
-	list_expr_sort(&existing_set->init->expressions);
-
 	add = set_expr_alloc(&internal_location, set);
 
-	err = setelem_delete(msgs, set, add, init, existing_set->init, debug_mask);
-	if (err < 0) {
-		expr_free(add);
-		return err;
+	list_splice_init(&init->expressions, &del_list);
+
+	list_for_each_entry_safe(i, next, &del_list, list) {
+		err = __set_delete(msgs, i, set, add, init, existing_set, debug_mask);
+		if (err < 0) {
+			expr_free(add);
+			return err;
+		}
 	}
 
 	if (debug_mask & NFT_DEBUG_SEGTREE) {
-- 
2.30.2

