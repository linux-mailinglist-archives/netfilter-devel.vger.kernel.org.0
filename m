Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E634BCB59
	for <lists+netfilter-devel@lfdr.de>; Sun, 20 Feb 2022 01:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbiBTAbA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 19 Feb 2022 19:31:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiBTAa7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 19 Feb 2022 19:30:59 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FEDD42A12
        for <netfilter-devel@vger.kernel.org>; Sat, 19 Feb 2022 16:30:39 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 2A19560214
        for <netfilter-devel@vger.kernel.org>; Sun, 20 Feb 2022 01:29:48 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v2 3/5] src: remove rbtree datastructure
Date:   Sun, 20 Feb 2022 01:30:22 +0100
Message-Id: <20220220003024.23317-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220220003024.23317-1-pablo@netfilter.org>
References: <20220220003024.23317-1-pablo@netfilter.org>
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

Not used by anyone anymore, remove it.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes

 include/Makefile.am |   1 -
 include/rbtree.h    |  98 -----------
 src/Makefile.am     |   1 -
 src/rbtree.c        | 388 --------------------------------------------
 src/segtree.c       |   1 -
 5 files changed, 489 deletions(-)
 delete mode 100644 include/rbtree.h
 delete mode 100644 src/rbtree.c

diff --git a/include/Makefile.am b/include/Makefile.am
index 940b7fafb0b4..ff56dfe45fc5 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -17,7 +17,6 @@ noinst_HEADERS = 	cli.h		\
 			mnl.h		\
 			nftables.h	\
 			payload.h	\
-			rbtree.h	\
 			tcpopt.h	\
 			statement.h	\
 			ct.h		\
diff --git a/include/rbtree.h b/include/rbtree.h
deleted file mode 100644
index ac65283fee5b..000000000000
--- a/include/rbtree.h
+++ /dev/null
@@ -1,98 +0,0 @@
-/*
- * Red Black Trees
- * (C) 1999  Andrea Arcangeli <andrea@suse.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- */
-
-#ifndef	NFTABLES_RBTREE_H
-#define	NFTABLES_RBTREE_H
-
-#include <stddef.h>
-
-struct rb_node
-{
-	unsigned long  rb_parent_color;
-#define	RB_RED		0
-#define	RB_BLACK	1
-	struct rb_node *rb_right;
-	struct rb_node *rb_left;
-};
-
-struct rb_root
-{
-	struct rb_node *rb_node;
-};
-
-#define rb_parent(r)   ((struct rb_node *)((r)->rb_parent_color & ~3))
-#define rb_color(r)   ((r)->rb_parent_color & 1)
-#define rb_is_red(r)   (!rb_color(r))
-#define rb_is_black(r) rb_color(r)
-#define rb_set_red(r)  do { (r)->rb_parent_color &= ~1; } while (0)
-#define rb_set_black(r)  do { (r)->rb_parent_color |= 1; } while (0)
-
-static inline void rb_set_parent(struct rb_node *rb, struct rb_node *p)
-{
-	rb->rb_parent_color = (rb->rb_parent_color & 3) | (unsigned long)p;
-}
-static inline void rb_set_color(struct rb_node *rb, int color)
-{
-	rb->rb_parent_color = (rb->rb_parent_color & ~1) | color;
-}
-
-#define RB_ROOT	(struct rb_root) { NULL, }
-#define	rb_entry(ptr, type, member) container_of(ptr, type, member)
-
-#define RB_EMPTY_ROOT(root)	((root)->rb_node == NULL)
-#define RB_EMPTY_NODE(node)	(rb_parent(node) == node)
-#define RB_CLEAR_NODE(node)	(rb_set_parent(node, node))
-
-extern void rb_insert_color(struct rb_node *, struct rb_root *);
-extern void rb_erase(struct rb_node *, struct rb_root *);
-
-/* Find logical next and previous nodes in a tree */
-extern struct rb_node *rb_next(struct rb_node *);
-extern struct rb_node *rb_prev(struct rb_node *);
-extern struct rb_node *rb_first(struct rb_root *);
-extern struct rb_node *rb_last(struct rb_root *);
-
-/* Fast replacement of a single node without remove/rebalance/add/rebalance */
-extern void rb_replace_node(struct rb_node *victim, struct rb_node *new, 
-			    struct rb_root *root);
-
-static inline void rb_link_node(struct rb_node * node, struct rb_node * parent,
-				struct rb_node ** rb_link)
-{
-	node->rb_parent_color = (unsigned long )parent;
-	node->rb_left = node->rb_right = NULL;
-
-	*rb_link = node;
-}
-
-#define rb_for_each_entry(pos, root, member) \
-	for ((pos) = (root)->rb_node ? \
-			rb_entry(rb_first(root), typeof(*pos), member) : NULL; \
-	     (pos) != NULL; \
-	     (pos) = rb_entry(rb_next(&(pos)->member), typeof(*pos), member))
-
-#define rb_for_each_entry_safe(pos, node, next, root, member) \
-	for ((node) = rb_first(root); \
-	     (pos)  = (node) ? rb_entry((node), typeof(*pos), member) : NULL, \
-	     (next) = (node) ? rb_next(node) : NULL, \
-	     (pos) != NULL; \
-	     (node) = (next))
-
-#endif	/* NFTABLES_RBTREE_H */
diff --git a/src/Makefile.am b/src/Makefile.am
index 9c57ebbb8022..7c86d5b17eb7 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -62,7 +62,6 @@ libnftables_la_SOURCES =			\
 		monitor.c			\
 		owner.c				\
 		segtree.c			\
-		rbtree.c			\
 		gmputil.c			\
 		utils.c				\
 		erec.c				\
diff --git a/src/rbtree.c b/src/rbtree.c
deleted file mode 100644
index 325c0123398f..000000000000
--- a/src/rbtree.c
+++ /dev/null
@@ -1,388 +0,0 @@
-/*
- * Red Black Trees
- * (C) 1999  Andrea Arcangeli <andrea@suse.de>
- * (C) 2002  David Woodhouse <dwmw2@infradead.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- */
-
-#include <rbtree.h>
-
-static void __rb_rotate_left(struct rb_node *node, struct rb_root *root)
-{
-	struct rb_node *right = node->rb_right;
-	struct rb_node *parent = rb_parent(node);
-
-	if ((node->rb_right = right->rb_left))
-		rb_set_parent(right->rb_left, node);
-	right->rb_left = node;
-
-	rb_set_parent(right, parent);
-
-	if (parent)
-	{
-		if (node == parent->rb_left)
-			parent->rb_left = right;
-		else
-			parent->rb_right = right;
-	}
-	else
-		root->rb_node = right;
-	rb_set_parent(node, right);
-}
-
-static void __rb_rotate_right(struct rb_node *node, struct rb_root *root)
-{
-	struct rb_node *left = node->rb_left;
-	struct rb_node *parent = rb_parent(node);
-
-	if ((node->rb_left = left->rb_right))
-		rb_set_parent(left->rb_right, node);
-	left->rb_right = node;
-
-	rb_set_parent(left, parent);
-
-	if (parent)
-	{
-		if (node == parent->rb_right)
-			parent->rb_right = left;
-		else
-			parent->rb_left = left;
-	}
-	else
-		root->rb_node = left;
-	rb_set_parent(node, left);
-}
-
-void rb_insert_color(struct rb_node *node, struct rb_root *root)
-{
-	struct rb_node *parent, *gparent;
-
-	while ((parent = rb_parent(node)) && rb_is_red(parent))
-	{
-		gparent = rb_parent(parent);
-
-		if (parent == gparent->rb_left)
-		{
-			{
-				register struct rb_node *uncle = gparent->rb_right;
-				if (uncle && rb_is_red(uncle))
-				{
-					rb_set_black(uncle);
-					rb_set_black(parent);
-					rb_set_red(gparent);
-					node = gparent;
-					continue;
-				}
-			}
-
-			if (parent->rb_right == node)
-			{
-				register struct rb_node *tmp;
-				__rb_rotate_left(parent, root);
-				tmp = parent;
-				parent = node;
-				node = tmp;
-			}
-
-			rb_set_black(parent);
-			rb_set_red(gparent);
-			__rb_rotate_right(gparent, root);
-		} else {
-			{
-				register struct rb_node *uncle = gparent->rb_left;
-				if (uncle && rb_is_red(uncle))
-				{
-					rb_set_black(uncle);
-					rb_set_black(parent);
-					rb_set_red(gparent);
-					node = gparent;
-					continue;
-				}
-			}
-
-			if (parent->rb_left == node)
-			{
-				register struct rb_node *tmp;
-				__rb_rotate_right(parent, root);
-				tmp = parent;
-				parent = node;
-				node = tmp;
-			}
-
-			rb_set_black(parent);
-			rb_set_red(gparent);
-			__rb_rotate_left(gparent, root);
-		}
-	}
-
-	rb_set_black(root->rb_node);
-}
-
-static void __rb_erase_color(struct rb_node *node, struct rb_node *parent,
-			     struct rb_root *root)
-{
-	struct rb_node *other;
-
-	while ((!node || rb_is_black(node)) && node != root->rb_node)
-	{
-		if (parent->rb_left == node)
-		{
-			other = parent->rb_right;
-			if (rb_is_red(other))
-			{
-				rb_set_black(other);
-				rb_set_red(parent);
-				__rb_rotate_left(parent, root);
-				other = parent->rb_right;
-			}
-			if ((!other->rb_left || rb_is_black(other->rb_left)) &&
-			    (!other->rb_right || rb_is_black(other->rb_right)))
-			{
-				rb_set_red(other);
-				node = parent;
-				parent = rb_parent(node);
-			}
-			else
-			{
-				if (!other->rb_right || rb_is_black(other->rb_right))
-				{
-					struct rb_node *o_left;
-					if ((o_left = other->rb_left))
-						rb_set_black(o_left);
-					rb_set_red(other);
-					__rb_rotate_right(other, root);
-					other = parent->rb_right;
-				}
-				rb_set_color(other, rb_color(parent));
-				rb_set_black(parent);
-				if (other->rb_right)
-					rb_set_black(other->rb_right);
-				__rb_rotate_left(parent, root);
-				node = root->rb_node;
-				break;
-			}
-		}
-		else
-		{
-			other = parent->rb_left;
-			if (rb_is_red(other))
-			{
-				rb_set_black(other);
-				rb_set_red(parent);
-				__rb_rotate_right(parent, root);
-				other = parent->rb_left;
-			}
-			if ((!other->rb_left || rb_is_black(other->rb_left)) &&
-			    (!other->rb_right || rb_is_black(other->rb_right)))
-			{
-				rb_set_red(other);
-				node = parent;
-				parent = rb_parent(node);
-			}
-			else
-			{
-				if (!other->rb_left || rb_is_black(other->rb_left))
-				{
-					register struct rb_node *o_right;
-					if ((o_right = other->rb_right))
-						rb_set_black(o_right);
-					rb_set_red(other);
-					__rb_rotate_left(other, root);
-					other = parent->rb_left;
-				}
-				rb_set_color(other, rb_color(parent));
-				rb_set_black(parent);
-				if (other->rb_left)
-					rb_set_black(other->rb_left);
-				__rb_rotate_right(parent, root);
-				node = root->rb_node;
-				break;
-			}
-		}
-	}
-	if (node)
-		rb_set_black(node);
-}
-
-void rb_erase(struct rb_node *node, struct rb_root *root)
-{
-	struct rb_node *child, *parent;
-	int color;
-
-	if (!node->rb_left)
-		child = node->rb_right;
-	else if (!node->rb_right)
-		child = node->rb_left;
-	else
-	{
-		struct rb_node *old = node, *left;
-
-		node = node->rb_right;
-		while ((left = node->rb_left) != NULL)
-			node = left;
-		child = node->rb_right;
-		parent = rb_parent(node);
-		color = rb_color(node);
-
-		if (child)
-			rb_set_parent(child, parent);
-		if (parent == old) {
-			parent->rb_right = child;
-			parent = node;
-		} else
-			parent->rb_left = child;
-
-		node->rb_parent_color = old->rb_parent_color;
-		node->rb_right = old->rb_right;
-		node->rb_left = old->rb_left;
-
-		if (rb_parent(old))
-		{
-			if (rb_parent(old)->rb_left == old)
-				rb_parent(old)->rb_left = node;
-			else
-				rb_parent(old)->rb_right = node;
-		} else
-			root->rb_node = node;
-
-		rb_set_parent(old->rb_left, node);
-		if (old->rb_right)
-			rb_set_parent(old->rb_right, node);
-		goto color;
-	}
-
-	parent = rb_parent(node);
-	color = rb_color(node);
-
-	if (child)
-		rb_set_parent(child, parent);
-	if (parent)
-	{
-		if (parent->rb_left == node)
-			parent->rb_left = child;
-		else
-			parent->rb_right = child;
-	}
-	else
-		root->rb_node = child;
-
- color:
-	if (color == RB_BLACK)
-		__rb_erase_color(child, parent, root);
-}
-
-/*
- * This function returns the first node (in sort order) of the tree.
- */
-struct rb_node *rb_first(struct rb_root *root)
-{
-	struct rb_node	*n;
-
-	n = root->rb_node;
-	if (!n)
-		return NULL;
-	while (n->rb_left)
-		n = n->rb_left;
-	return n;
-}
-
-struct rb_node *rb_last(struct rb_root *root)
-{
-	struct rb_node	*n;
-
-	n = root->rb_node;
-	if (!n)
-		return NULL;
-	while (n->rb_right)
-		n = n->rb_right;
-	return n;
-}
-
-struct rb_node *rb_next(struct rb_node *node)
-{
-	struct rb_node *parent;
-
-	if (rb_parent(node) == node)
-		return NULL;
-
-	/* If we have a right-hand child, go down and then left as far
-	   as we can. */
-	if (node->rb_right) {
-		node = node->rb_right;
-		while (node->rb_left)
-			node=node->rb_left;
-		return node;
-	}
-
-	/* No right-hand children.  Everything down and left is
-	   smaller than us, so any 'next' node must be in the general
-	   direction of our parent. Go up the tree; any time the
-	   ancestor is a right-hand child of its parent, keep going
-	   up. First time it's a left-hand child of its parent, said
-	   parent is our 'next' node. */
-	while ((parent = rb_parent(node)) && node == parent->rb_right)
-		node = parent;
-
-	return parent;
-}
-
-struct rb_node *rb_prev(struct rb_node *node)
-{
-	struct rb_node *parent;
-
-	if (rb_parent(node) == node)
-		return NULL;
-
-	/* If we have a left-hand child, go down and then right as far
-	   as we can. */
-	if (node->rb_left) {
-		node = node->rb_left;
-		while (node->rb_right)
-			node=node->rb_right;
-		return node;
-	}
-
-	/* No left-hand children. Go up till we find an ancestor which
-	   is a right-hand child of its parent */
-	while ((parent = rb_parent(node)) && node == parent->rb_left)
-		node = parent;
-
-	return parent;
-}
-
-void rb_replace_node(struct rb_node *victim, struct rb_node *new,
-		     struct rb_root *root)
-{
-	struct rb_node *parent = rb_parent(victim);
-
-	/* Set the surrounding nodes to point to the replacement */
-	if (parent) {
-		if (victim == parent->rb_left)
-			parent->rb_left = new;
-		else
-			parent->rb_right = new;
-	} else {
-		root->rb_node = new;
-	}
-	if (victim->rb_left)
-		rb_set_parent(victim->rb_left, new);
-	if (victim->rb_right)
-		rb_set_parent(victim->rb_right, new);
-
-	/* Copy the pointers/colour from the victim to the replacement */
-	*new = *victim;
-}
diff --git a/src/segtree.c b/src/segtree.c
index 87dfbce38ed8..4eb74485e848 100644
--- a/src/segtree.c
+++ b/src/segtree.c
@@ -19,7 +19,6 @@
 #include <expression.h>
 #include <gmputil.h>
 #include <utils.h>
-#include <rbtree.h>
 
 static void interval_expr_copy(struct expr *dst, struct expr *src)
 {
-- 
2.30.2

