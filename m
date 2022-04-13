Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302AF4FEC82
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Apr 2022 03:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiDMBwA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Apr 2022 21:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiDMBv6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:51:58 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51E3424F35
        for <netfilter-devel@vger.kernel.org>; Tue, 12 Apr 2022 18:49:38 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nft,v6 7/8] intervals: support to partial deletion with automerge
Date:   Wed, 13 Apr 2022 03:49:29 +0200
Message-Id: <20220413014930.410728-8-pablo@netfilter.org>
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

Splice the existing set element cache with the elements to be deleted
and merge sort it.  The elements to be deleted are identified by the
EXPR_F_REMOVE flag.

The set elements to be deleted is automerged in first place if the
automerge flag is set on.

There are four possible deletion scenarios:

- Exact match, eg. delete [a-b] and there is a [a-b] range in the kernel set.
- Adjust left side of range, eg. delete [a-b] from range [a-x] where x > b.
- Adjust right side of range, eg. delete [a-b] from range [x-b] where x < a.
- Split range, eg. delete [a-b] from range [x-y] where x < a and b < y.

Update nft_evaluate() to use the safe list variant since new commands
are dynamically registered to the list to update ranges.

This patch also restores the set element existence check for Linux
kernels <= 5.7.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/expression.h |   1 +
 include/intervals.h  |   2 +
 src/evaluate.c       |   3 +-
 src/intervals.c      | 250 +++++++++++++++++++++++++++++++++++++++++++
 src/libnftables.c    |   4 +-
 5 files changed, 257 insertions(+), 3 deletions(-)

diff --git a/include/expression.h b/include/expression.h
index c2d67d4c88af..2c3818e89b79 100644
--- a/include/expression.h
+++ b/include/expression.h
@@ -202,6 +202,7 @@ enum expr_flags {
 	EXPR_F_BOOLEAN		= 0x10,
 	EXPR_F_INTERVAL		= 0x20,
 	EXPR_F_KERNEL		= 0x40,
+	EXPR_F_REMOVE		= 0x80,
 };
 
 #include <payload.h>
diff --git a/include/intervals.h b/include/intervals.h
index 797129fc93a5..964804b19dda 100644
--- a/include/intervals.h
+++ b/include/intervals.h
@@ -4,6 +4,8 @@
 void set_to_range(struct expr *init);
 int set_automerge(struct list_head *msgs, struct cmd *cmd, struct set *set,
 		  struct expr *init, unsigned int debug_mask);
+int set_delete(struct list_head *msgs, struct cmd *cmd, struct set *set,
+	       struct expr *init, unsigned int debug_mask);
 int set_overlap(struct list_head *msgs, struct set *set, struct expr *init);
 int set_to_intervals(const struct set *set, struct expr *init, bool add);
 
diff --git a/src/evaluate.c b/src/evaluate.c
index eb147585c862..503b4f036655 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1486,7 +1486,8 @@ static int interval_set_eval(struct eval_ctx *ctx, struct set *set,
 		}
 		break;
 	case CMD_DELETE:
-		set_to_range(init);
+		ret = set_delete(ctx->msgs, ctx->cmd, set, init,
+				 ctx->nft->debug_mask);
 		break;
 	case CMD_GET:
 		break;
diff --git a/src/intervals.c b/src/intervals.c
index 16debf9cd4be..f672d0aac573 100644
--- a/src/intervals.c
+++ b/src/intervals.c
@@ -255,6 +255,256 @@ int set_automerge(struct list_head *msgs, struct cmd *cmd, struct set *set,
 	return 0;
 }
 
+static void remove_elem(struct expr *prev, struct set *set, struct expr *purge)
+{
+	struct expr *clone;
+
+	if (!(prev->flags & EXPR_F_REMOVE)) {
+		if (prev->flags & EXPR_F_KERNEL) {
+			clone = expr_clone(prev);
+			list_move_tail(&clone->list, &purge->expressions);
+		} else {
+			list_del(&prev->list);
+			expr_free(prev);
+		}
+	}
+}
+
+static void __adjust_elem_left(struct set *set, struct expr *prev, struct expr *i,
+			       struct expr *add)
+{
+	prev->flags &= EXPR_F_KERNEL;
+	expr_free(prev->key->left);
+	prev->key->left = expr_get(i->key->right);
+	mpz_add_ui(prev->key->left->value, prev->key->left->value, 1);
+	list_move(&prev->list, &add->expressions);
+}
+
+static void adjust_elem_left(struct set *set, struct expr *prev, struct expr *i,
+			     struct expr *add, struct expr *purge)
+{
+	struct expr *clone;
+
+	remove_elem(prev, set, purge);
+	__adjust_elem_left(set, prev, i, add);
+
+	list_del(&i->list);
+	expr_free(i);
+
+	clone = expr_clone(prev);
+	list_add_tail(&clone->list, &set->existing_set->init->expressions);
+}
+
+static void __adjust_elem_right(struct set *set, struct expr *prev, struct expr *i,
+				struct expr *add)
+{
+	prev->flags &= EXPR_F_KERNEL;
+	expr_free(prev->key->right);
+	prev->key->right = expr_get(i->key->left);
+	mpz_sub_ui(prev->key->right->value, prev->key->right->value, 1);
+	list_move(&prev->list, &add->expressions);
+}
+
+static void adjust_elem_right(struct set *set, struct expr *prev, struct expr *i,
+			      struct expr *add, struct expr *purge)
+{
+	struct expr *clone;
+
+	remove_elem(prev, set, purge);
+	__adjust_elem_right(set, prev, i, add);
+
+	list_del(&i->list);
+	expr_free(i);
+
+	clone = expr_clone(prev);
+	list_add_tail(&clone->list, &set->existing_set->init->expressions);
+}
+
+static void split_range(struct set *set, struct expr *prev, struct expr *i,
+			struct expr *add, struct expr *purge)
+{
+	struct expr *clone;
+
+	clone = expr_clone(prev);
+	list_move_tail(&clone->list, &purge->expressions);
+
+	prev->flags &= EXPR_F_KERNEL;
+	clone = expr_clone(prev);
+	expr_free(clone->key->left);
+	clone->key->left = expr_get(i->key->right);
+	mpz_add_ui(clone->key->left->value, i->key->right->value, 1);
+	list_move(&clone->list, &add->expressions);
+	clone = expr_clone(clone);
+	list_add_tail(&clone->list, &set->existing_set->init->expressions);
+
+	expr_free(prev->key->right);
+	prev->key->right = expr_get(i->key->left);
+	mpz_sub_ui(prev->key->right->value, i->key->left->value, 1);
+	list_move(&prev->list, &add->expressions);
+	clone = expr_clone(prev);
+	list_add_tail(&clone->list, &set->existing_set->init->expressions);
+
+	list_del(&i->list);
+	expr_free(i);
+}
+
+static int setelem_adjust(struct set *set, struct expr *add, struct expr *purge,
+			  struct range *prev_range, struct range *range,
+			  struct expr *prev, struct expr *i)
+{
+	if (mpz_cmp(prev_range->low, range->low) == 0 &&
+	    mpz_cmp(prev_range->high, range->high) > 0) {
+		if (!(prev->flags & EXPR_F_REMOVE) &&
+		    i->flags & EXPR_F_REMOVE)
+			adjust_elem_left(set, prev, i, add, purge);
+	} else if (mpz_cmp(prev_range->low, range->low) < 0 &&
+		   mpz_cmp(prev_range->high, range->high) == 0) {
+		if (!(prev->flags & EXPR_F_REMOVE) &&
+		    i->flags & EXPR_F_REMOVE)
+			adjust_elem_right(set, prev, i, add, purge);
+	} else if (mpz_cmp(prev_range->low, range->low) < 0 &&
+		   mpz_cmp(prev_range->high, range->high) > 0) {
+		if (!(prev->flags & EXPR_F_REMOVE) &&
+		    i->flags & EXPR_F_REMOVE)
+			split_range(set, prev, i, add, purge);
+	} else {
+		return -1;
+	}
+
+	return 0;
+}
+
+static int setelem_delete(struct list_head *msgs, struct set *set,
+			  struct expr *add, struct expr *purge,
+			  struct expr *elems, unsigned int debug_mask)
+{
+	struct expr *i, *next, *prev = NULL;
+	struct range range, prev_range;
+	int err = 0;
+	mpz_t rop;
+
+	mpz_init(prev_range.low);
+	mpz_init(prev_range.high);
+	mpz_init(range.low);
+	mpz_init(range.high);
+	mpz_init(rop);
+
+	list_for_each_entry_safe(i, next, &elems->expressions, list) {
+		if (i->key->etype == EXPR_SET_ELEM_CATCHALL)
+			continue;
+
+		range_expr_value_low(range.low, i);
+		range_expr_value_high(range.high, i);
+
+		if (!prev && i->flags & EXPR_F_REMOVE) {
+			expr_error(msgs, i, "element does not exist");
+			err = -1;
+			goto err;
+		}
+
+		if (!(i->flags & EXPR_F_REMOVE)) {
+			prev = i;
+			mpz_set(prev_range.low, range.low);
+			mpz_set(prev_range.high, range.high);
+			continue;
+		}
+
+		if (mpz_cmp(prev_range.low, range.low) == 0 &&
+		    mpz_cmp(prev_range.high, range.high) == 0) {
+			if (!(prev->flags & EXPR_F_REMOVE) &&
+			    i->flags & EXPR_F_REMOVE) {
+				list_move_tail(&prev->list, &purge->expressions);
+				list_del(&i->list);
+				expr_free(i);
+			}
+		} else if (set->automerge &&
+			   setelem_adjust(set, add, purge, &prev_range, &range, prev, i) < 0) {
+			expr_error(msgs, i, "element does not exist");
+			err = -1;
+			goto err;
+		}
+		prev = NULL;
+	}
+err:
+	mpz_clear(prev_range.low);
+	mpz_clear(prev_range.high);
+	mpz_clear(range.low);
+	mpz_clear(range.high);
+	mpz_clear(rop);
+
+	return err;
+}
+
+static void automerge_delete(struct list_head *msgs, struct set *set,
+			     struct expr *init, unsigned int debug_mask)
+{
+	struct set_automerge_ctx ctx = {
+		.set		= set,
+		.init		= init,
+		.debug_mask	= debug_mask,
+	};
+
+	ctx.purge = set_expr_alloc(&internal_location, set);
+	list_expr_sort(&init->expressions);
+	setelem_automerge(&ctx);
+	expr_free(ctx.purge);
+}
+
+/* detection for unexisting intervals already exists in Linux kernels >= 5.7. */
+int set_delete(struct list_head *msgs, struct cmd *cmd, struct set *set,
+	       struct expr *init, unsigned int debug_mask)
+{
+	struct set *existing_set = set->existing_set;
+	struct expr *i, *add;
+	struct handle h = {};
+	struct cmd *add_cmd;
+	int err;
+
+	set_to_range(init);
+	if (set->automerge)
+		automerge_delete(msgs, set, init, debug_mask);
+
+	list_for_each_entry(i, &init->expressions, list)
+		i->flags |= EXPR_F_REMOVE;
+
+	set_to_range(existing_set->init);
+	list_splice_init(&init->expressions, &existing_set->init->expressions);
+
+	list_expr_sort(&existing_set->init->expressions);
+
+	add = set_expr_alloc(&internal_location, set);
+
+	err = setelem_delete(msgs, set, add, init, existing_set->init, debug_mask);
+	if (err < 0) {
+		expr_free(add);
+		return err;
+	}
+
+	if (debug_mask & NFT_DEBUG_SEGTREE) {
+		list_for_each_entry(i, &init->expressions, list)
+			gmp_printf("remove: [%Zx-%Zx]\n",
+				   i->key->left->value, i->key->right->value);
+		list_for_each_entry(i, &add->expressions, list)
+			gmp_printf("add: [%Zx-%Zx]\n",
+				   i->key->left->value, i->key->right->value);
+		list_for_each_entry(i, &existing_set->init->expressions, list)
+			gmp_printf("existing: [%Zx-%Zx]\n",
+				   i->key->left->value, i->key->right->value);
+	}
+
+	if (list_empty(&add->expressions)) {
+		expr_free(add);
+		return 0;
+	}
+
+	handle_merge(&h, &cmd->handle);
+	add_cmd = cmd_alloc(CMD_ADD, CMD_OBJ_ELEMENTS, &h, &cmd->location, add);
+	add_cmd->elem.set = set_get(set);
+	list_add(&add_cmd->list, &cmd->list);
+
+	return 0;
+}
+
 static int setelem_overlap(struct list_head *msgs, struct set *set,
 			   struct expr *init)
 {
diff --git a/src/libnftables.c b/src/libnftables.c
index dc0932bdbdd0..6a22ea093952 100644
--- a/src/libnftables.c
+++ b/src/libnftables.c
@@ -500,8 +500,8 @@ static int nft_evaluate(struct nft_ctx *nft, struct list_head *msgs,
 			struct list_head *cmds)
 {
 	struct nft_cache_filter *filter;
+	struct cmd *cmd, *next;
 	unsigned int flags;
-	struct cmd *cmd;
 
 	filter = nft_cache_filter_init();
 	flags = nft_cache_evaluate(nft, cmds, filter);
@@ -512,7 +512,7 @@ static int nft_evaluate(struct nft_ctx *nft, struct list_head *msgs,
 
 	nft_cache_filter_fini(filter);
 
-	list_for_each_entry(cmd, cmds, list) {
+	list_for_each_entry_safe(cmd, next, cmds, list) {
 		struct eval_ctx ectx = {
 			.nft	= nft,
 			.msgs	= msgs,
-- 
2.30.2

