Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B9B7C8580
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Oct 2023 14:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjJMMSo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Oct 2023 08:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjJMMSn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:18:43 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A60D6
        for <netfilter-devel@vger.kernel.org>; Fri, 13 Oct 2023 05:18:40 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qrH7n-0007ed-Cf; Fri, 13 Oct 2023 14:18:39 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 3/3] netfilter: nft_set_rbtree: prefer sync gc to async worker
Date:   Fri, 13 Oct 2023 14:18:16 +0200
Message-ID: <20231013121821.31322-4-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013121821.31322-1-fw@strlen.de>
References: <20231013121821.31322-1-fw@strlen.de>
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

There is no need for asynchronous garbage collection, rbtree inserts
can only happen from the netlink control plane.

We already perform on-demand gc on insertion, in the area of the
tree where the insertion takes place, but we don't do a full tree
walk there for performance reasons.

Do a full gc walk at the end of the transaction instead and
remove the async worker.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_set_rbtree.c | 124 +++++++++++++++++----------------
 1 file changed, 65 insertions(+), 59 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index e137a0fd4179..5bb6d475e9e1 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -19,7 +19,7 @@ struct nft_rbtree {
 	struct rb_root		root;
 	rwlock_t		lock;
 	seqcount_rwlock_t	count;
-	struct delayed_work	gc_work;
+	unsigned long		last_gc;
 };
 
 struct nft_rbtree_elem {
@@ -48,8 +48,7 @@ static int nft_rbtree_cmp(const struct nft_set *set,
 
 static bool nft_rbtree_elem_expired(const struct nft_rbtree_elem *rbe)
 {
-	return nft_set_elem_expired(&rbe->ext) ||
-	       nft_set_elem_is_dead(&rbe->ext);
+	return nft_set_elem_expired(&rbe->ext);
 }
 
 static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
@@ -508,6 +507,15 @@ static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	return err;
 }
 
+static void nft_rbtree_erase(struct nft_rbtree *priv, struct nft_rbtree_elem *rbe)
+{
+	write_lock_bh(&priv->lock);
+	write_seqcount_begin(&priv->count);
+	rb_erase(&rbe->node, &priv->root);
+	write_seqcount_end(&priv->count);
+	write_unlock_bh(&priv->lock);
+}
+
 static void nft_rbtree_remove(const struct net *net,
 			      const struct nft_set *set,
 			      const struct nft_set_elem *elem)
@@ -515,11 +523,7 @@ static void nft_rbtree_remove(const struct net *net,
 	struct nft_rbtree *priv = nft_set_priv(set);
 	struct nft_rbtree_elem *rbe = elem->priv;
 
-	write_lock_bh(&priv->lock);
-	write_seqcount_begin(&priv->count);
-	rb_erase(&rbe->node, &priv->root);
-	write_seqcount_end(&priv->count);
-	write_unlock_bh(&priv->lock);
+	nft_rbtree_erase(priv, rbe);
 }
 
 static void nft_rbtree_activate(const struct net *net,
@@ -611,45 +615,40 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
 	read_unlock_bh(&priv->lock);
 }
 
-static void nft_rbtree_gc(struct work_struct *work)
+static void nft_rbtree_gc_remove(struct net *net, struct nft_set *set,
+				 struct nft_rbtree *priv,
+				 struct nft_rbtree_elem *rbe)
 {
+	struct nft_set_elem elem = {
+		.priv	= rbe,
+	};
+
+	nft_setelem_data_deactivate(net, set, &elem);
+	nft_rbtree_erase(priv, rbe);
+}
+
+static void nft_rbtree_gc(struct nft_set *set)
+{
+	struct nft_rbtree *priv = nft_set_priv(set);
 	struct nft_rbtree_elem *rbe, *rbe_end = NULL;
 	struct nftables_pernet *nft_net;
-	struct nft_rbtree *priv;
+	struct rb_node *node, *next;
 	struct nft_trans_gc *gc;
-	struct rb_node *node;
-	struct nft_set *set;
-	unsigned int gc_seq;
 	struct net *net;
 
-	priv = container_of(work, struct nft_rbtree, gc_work.work);
 	set  = nft_set_container_of(priv);
 	net  = read_pnet(&set->net);
 	nft_net = nft_pernet(net);
-	gc_seq  = READ_ONCE(nft_net->gc_seq);
 
-	if (nft_set_gc_is_pending(set))
-		goto done;
-
-	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
+	gc = nft_trans_gc_alloc(set, 0, GFP_KERNEL);
 	if (!gc)
-		goto done;
-
-	read_lock_bh(&priv->lock);
-	for (node = rb_first(&priv->root); node != NULL; node = rb_next(node)) {
+		return;
 
-		/* Ruleset has been updated, try later. */
-		if (READ_ONCE(nft_net->gc_seq) != gc_seq) {
-			nft_trans_gc_destroy(gc);
-			gc = NULL;
-			goto try_later;
-		}
+	for (node = rb_first(&priv->root); node ; node = next) {
+		next = rb_next(node);
 
 		rbe = rb_entry(node, struct nft_rbtree_elem, node);
 
-		if (nft_set_elem_is_dead(&rbe->ext))
-			goto dead_elem;
-
 		/* elements are reversed in the rbtree for historical reasons,
 		 * from highest to lowest value, that is why end element is
 		 * always visited before the start element.
@@ -661,37 +660,34 @@ static void nft_rbtree_gc(struct work_struct *work)
 		if (!nft_set_elem_expired(&rbe->ext))
 			continue;
 
-		nft_set_elem_dead(&rbe->ext);
-
-		if (!rbe_end)
-			continue;
-
-		nft_set_elem_dead(&rbe_end->ext);
-
-		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		gc = nft_trans_gc_queue_sync(gc, GFP_KERNEL);
 		if (!gc)
 			goto try_later;
 
-		nft_trans_gc_elem_add(gc, rbe_end);
-		rbe_end = NULL;
-dead_elem:
-		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		/* end element needs to be removed first, it has
+		 * no timeout extension.
+		 */
+		if (rbe_end) {
+			nft_rbtree_gc_remove(net, set, priv, rbe_end);
+			nft_trans_gc_elem_add(gc, rbe_end);
+			rbe_end = NULL;
+		}
+
+		gc = nft_trans_gc_queue_sync(gc, GFP_KERNEL);
 		if (!gc)
 			goto try_later;
 
+		nft_rbtree_gc_remove(net, set, priv, rbe);
 		nft_trans_gc_elem_add(gc, rbe);
 	}
 
-	gc = nft_trans_gc_catchall_async(gc, gc_seq);
-
 try_later:
-	read_unlock_bh(&priv->lock);
 
-	if (gc)
-		nft_trans_gc_queue_async_done(gc);
-done:
-	queue_delayed_work(system_power_efficient_wq, &priv->gc_work,
-			   nft_set_gc_interval(set));
+	if (gc) {
+		gc = nft_trans_gc_catchall_sync(gc);
+		nft_trans_gc_queue_sync_done(gc);
+		priv->last_gc = jiffies;
+	}
 }
 
 static u64 nft_rbtree_privsize(const struct nlattr * const nla[],
@@ -710,11 +706,6 @@ static int nft_rbtree_init(const struct nft_set *set,
 	seqcount_rwlock_init(&priv->count, &priv->lock);
 	priv->root = RB_ROOT;
 
-	INIT_DEFERRABLE_WORK(&priv->gc_work, nft_rbtree_gc);
-	if (set->flags & NFT_SET_TIMEOUT)
-		queue_delayed_work(system_power_efficient_wq, &priv->gc_work,
-				   nft_set_gc_interval(set));
-
 	return 0;
 }
 
@@ -725,8 +716,6 @@ static void nft_rbtree_destroy(const struct nft_ctx *ctx,
 	struct nft_rbtree_elem *rbe;
 	struct rb_node *node;
 
-	cancel_delayed_work_sync(&priv->gc_work);
-	rcu_barrier();
 	while ((node = priv->root.rb_node) != NULL) {
 		rb_erase(node, &priv->root);
 		rbe = rb_entry(node, struct nft_rbtree_elem, node);
@@ -752,6 +741,21 @@ static bool nft_rbtree_estimate(const struct nft_set_desc *desc, u32 features,
 	return true;
 }
 
+static void nft_rbtree_commit(struct nft_set *set)
+{
+	struct nft_rbtree *priv = nft_set_priv(set);
+
+	if (time_after_eq(jiffies, priv->last_gc + nft_set_gc_interval(set)))
+		nft_rbtree_gc(set);
+}
+
+static void nft_rbtree_gc_init(const struct nft_set *set)
+{
+	struct nft_rbtree *priv = nft_set_priv(set);
+
+	priv->last_gc = jiffies;
+}
+
 const struct nft_set_type nft_set_rbtree_type = {
 	.features	= NFT_SET_INTERVAL | NFT_SET_MAP | NFT_SET_OBJECT | NFT_SET_TIMEOUT,
 	.ops		= {
@@ -765,6 +769,8 @@ const struct nft_set_type nft_set_rbtree_type = {
 		.deactivate	= nft_rbtree_deactivate,
 		.flush		= nft_rbtree_flush,
 		.activate	= nft_rbtree_activate,
+		.commit		= nft_rbtree_commit,
+		.gc_init	= nft_rbtree_gc_init,
 		.lookup		= nft_rbtree_lookup,
 		.walk		= nft_rbtree_walk,
 		.get		= nft_rbtree_get,
-- 
2.41.0

