Return-Path: <netfilter-devel+bounces-2569-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4F3905FFF
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Jun 2024 03:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FB71F2216C
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Jun 2024 01:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DCB8F62;
	Thu, 13 Jun 2024 01:02:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946D0175AD;
	Thu, 13 Jun 2024 01:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240547; cv=none; b=Nv3BcS9O2BPckV0+SUSDU2tt3Yr2P4cHlrsG12X15cTQSPCa7hW2m3262hcFvIm1DF6GPK8bv2IK6A/dmXz32yafggKZ9pW6K25jh2uvPXEme/6vNcpSKTGMFVIZ/YQXKSyqF6wDiK6SopBxRu3yw7I8S/XuY489ZOL28RxDQbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240547; c=relaxed/simple;
	bh=b7XJyGpDFMmfDCjDYu/Oe0IOYP9xiSz9z8L31HPKaUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eqzqPEV7lJ1PVBcvhakLh4hfT+Zr5F3gAPq4beR2akCvRRIw7e1UllO6wv0FnRTGRG+NanX+++WQ9AOdWwboDpwwC4YPXw3IbnKzVnUQYteN/Zn1weLjrexH9O7WBNqEnfv0AmmudYWv/Vzqx0OhiXI6P/em2Y7rlueCXGgs88o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,4.19.x 11/40] netfilter: nf_tables: adapt set backend to use GC transaction API
Date: Thu, 13 Jun 2024 03:01:40 +0200
Message-Id: <20240613010209.104423-12-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240613010209.104423-1-pablo@netfilter.org>
References: <20240613010209.104423-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f6c383b8c31a93752a52697f8430a71dcbc46adf upstream.

Use the GC transaction API to replace the old and buggy gc API and the
busy mark approach.

No set elements are removed from async garbage collection anymore,
instead the _DEAD bit is set on so the set element is not visible from
lookup path anymore. Async GC enqueues transaction work that might be
aborted and retried later.

rbtree and pipapo set backends does not set on the _DEAD bit from the
sync GC path since this runs in control plane path where mutex is held.
In this case, set elements are deactivated, removed and then released
via RCU callback, sync GC never fails.

Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Fixes: 8d8540c4f5e0 ("netfilter: nft_set_rbtree: add timeout support")
Fixes: 9d0982927e79 ("netfilter: nft_hash: add support for timeouts")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_hash.c   |  84 +++++++++++++-------
 net/netfilter/nft_set_rbtree.c | 140 +++++++++++++++++++++------------
 2 files changed, 143 insertions(+), 81 deletions(-)

diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index c899df945b0d..9ff988b1bc1a 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -20,6 +20,9 @@
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables.h>
+#include <net/netns/generic.h>
+
+extern unsigned int nf_tables_net_id;
 
 /* We target a hash table size of 4, element hint is 75% of final size */
 #define NFT_RHASH_ELEMENT_HINT 3
@@ -62,6 +65,8 @@ static inline int nft_rhash_cmp(struct rhashtable_compare_arg *arg,
 
 	if (memcmp(nft_set_ext_key(&he->ext), x->key, x->set->klen))
 		return 1;
+	if (nft_set_elem_is_dead(&he->ext))
+		return 1;
 	if (nft_set_elem_expired(&he->ext))
 		return 1;
 	if (!nft_set_elem_active(&he->ext, x->genmask))
@@ -190,7 +195,6 @@ static void nft_rhash_activate(const struct net *net, const struct nft_set *set,
 	struct nft_rhash_elem *he = elem->priv;
 
 	nft_set_elem_change_active(net, set, &he->ext);
-	nft_set_elem_clear_busy(&he->ext);
 }
 
 static bool nft_rhash_flush(const struct net *net,
@@ -198,12 +202,9 @@ static bool nft_rhash_flush(const struct net *net,
 {
 	struct nft_rhash_elem *he = priv;
 
-	if (!nft_set_elem_mark_busy(&he->ext) ||
-	    !nft_is_active(net, &he->ext)) {
-		nft_set_elem_change_active(net, set, &he->ext);
-		return true;
-	}
-	return false;
+	nft_set_elem_change_active(net, set, &he->ext);
+
+	return true;
 }
 
 static void *nft_rhash_deactivate(const struct net *net,
@@ -220,9 +221,8 @@ static void *nft_rhash_deactivate(const struct net *net,
 
 	rcu_read_lock();
 	he = rhashtable_lookup_fast(&priv->ht, &arg, nft_rhash_params);
-	if (he != NULL &&
-	    !nft_rhash_flush(net, set, he))
-		he = NULL;
+	if (he)
+		nft_set_elem_change_active(net, set, &he->ext);
 
 	rcu_read_unlock();
 
@@ -288,55 +288,80 @@ static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 static void nft_rhash_gc(struct work_struct *work)
 {
+	struct nftables_pernet *nft_net;
 	struct nft_set *set;
 	struct nft_rhash_elem *he;
 	struct nft_rhash *priv;
-	struct nft_set_gc_batch *gcb = NULL;
 	struct rhashtable_iter hti;
+	struct nft_trans_gc *gc;
+	struct net *net;
+	u32 gc_seq;
 	int err;
 
 	priv = container_of(work, struct nft_rhash, gc_work.work);
 	set  = nft_set_container_of(priv);
+	net  = read_pnet(&set->net);
+	nft_net = net_generic(net, nf_tables_net_id);
+	gc_seq = READ_ONCE(nft_net->gc_seq);
+
+	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
+	if (!gc)
+		goto done;
 
 	err = rhashtable_walk_init(&priv->ht, &hti, GFP_KERNEL);
-	if (err)
-		goto schedule;
+	if (err) {
+		nft_trans_gc_destroy(gc);
+		goto done;
+	}
 
 	rhashtable_walk_start(&hti);
 
 	while ((he = rhashtable_walk_next(&hti))) {
 		if (IS_ERR(he)) {
-			if (PTR_ERR(he) != -EAGAIN)
-				goto out;
+			if (PTR_ERR(he) != -EAGAIN) {
+				nft_trans_gc_destroy(gc);
+				gc = NULL;
+				goto try_later;
+			}
 			continue;
 		}
 
+		/* Ruleset has been updated, try later. */
+		if (READ_ONCE(nft_net->gc_seq) != gc_seq) {
+			nft_trans_gc_destroy(gc);
+			gc = NULL;
+			goto try_later;
+		}
+
+		if (nft_set_elem_is_dead(&he->ext))
+			goto dead_elem;
+
 		if (nft_set_ext_exists(&he->ext, NFT_SET_EXT_EXPR)) {
 			struct nft_expr *expr = nft_set_ext_expr(&he->ext);
 
 			if (expr->ops->gc &&
 			    expr->ops->gc(read_pnet(&set->net), expr))
-				goto gc;
+				goto needs_gc_run;
 		}
 		if (!nft_set_elem_expired(&he->ext))
 			continue;
-gc:
-		if (nft_set_elem_mark_busy(&he->ext))
-			continue;
-
-		gcb = nft_set_gc_batch_check(set, gcb, GFP_ATOMIC);
-		if (gcb == NULL)
-			goto out;
-		rhashtable_remove_fast(&priv->ht, &he->node, nft_rhash_params);
-		atomic_dec(&set->nelems);
-		nft_set_gc_batch_add(gcb, he);
+needs_gc_run:
+		nft_set_elem_dead(&he->ext);
+dead_elem:
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (!gc)
+			goto try_later;
+
+		nft_trans_gc_elem_add(gc, he);
 	}
-out:
+try_later:
 	rhashtable_walk_stop(&hti);
 	rhashtable_walk_exit(&hti);
 
-	nft_set_gc_batch_complete(gcb);
-schedule:
+	if (gc)
+		nft_trans_gc_queue_async_done(gc);
+
+done:
 	queue_delayed_work(system_power_efficient_wq, &priv->gc_work,
 			   nft_set_gc_interval(set));
 }
@@ -399,7 +424,6 @@ static void nft_rhash_destroy(const struct nft_ctx *ctx,
 	};
 
 	cancel_delayed_work_sync(&priv->gc_work);
-	rcu_barrier();
 	rhashtable_free_and_destroy(&priv->ht, nft_rhash_elem_destroy,
 				    (void *)&rhash_ctx);
 }
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index fc069ffc38f7..35200be68c15 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -17,6 +17,9 @@
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables.h>
+#include <net/netns/generic.h>
+
+extern unsigned int nf_tables_net_id;
 
 struct nft_rbtree {
 	struct rb_root		root;
@@ -49,6 +52,12 @@ static int nft_rbtree_cmp(const struct nft_set *set,
 		      set->klen);
 }
 
+static bool nft_rbtree_elem_expired(const struct nft_rbtree_elem *rbe)
+{
+	return nft_set_elem_expired(&rbe->ext) ||
+	       nft_set_elem_is_dead(&rbe->ext);
+}
+
 static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
 				const u32 *key, const struct nft_set_ext **ext,
 				unsigned int seq)
@@ -83,7 +92,7 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 				continue;
 			}
 
-			if (nft_set_elem_expired(&rbe->ext))
+			if (nft_rbtree_elem_expired(rbe))
 				return false;
 
 			if (nft_rbtree_interval_end(rbe)) {
@@ -101,7 +110,7 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 
 	if (set->flags & NFT_SET_INTERVAL && interval != NULL &&
 	    nft_set_elem_active(&interval->ext, genmask) &&
-	    !nft_set_elem_expired(&interval->ext) &&
+	    !nft_rbtree_elem_expired(interval) &&
 	    nft_rbtree_interval_start(interval)) {
 		*ext = &interval->ext;
 		return true;
@@ -217,6 +226,18 @@ static void *nft_rbtree_get(const struct net *net, const struct nft_set *set,
 	return rbe;
 }
 
+static void nft_rbtree_gc_remove(struct net *net, struct nft_set *set,
+				 struct nft_rbtree *priv,
+				 struct nft_rbtree_elem *rbe)
+{
+	struct nft_set_elem elem = {
+		.priv   = rbe,
+	};
+
+	nft_setelem_data_deactivate(net, set, &elem);
+	rb_erase(&rbe->node, &priv->root);
+}
+
 static int nft_rbtree_gc_elem(const struct nft_set *__set,
 			      struct nft_rbtree *priv,
 			      struct nft_rbtree_elem *rbe,
@@ -224,11 +245,12 @@ static int nft_rbtree_gc_elem(const struct nft_set *__set,
 {
 	struct nft_set *set = (struct nft_set *)__set;
 	struct rb_node *prev = rb_prev(&rbe->node);
+	struct net *net = read_pnet(&set->net);
 	struct nft_rbtree_elem *rbe_prev;
-	struct nft_set_gc_batch *gcb;
+	struct nft_trans_gc *gc;
 
-	gcb = nft_set_gc_batch_check(set, NULL, GFP_ATOMIC);
-	if (!gcb)
+	gc = nft_trans_gc_alloc(set, 0, GFP_ATOMIC);
+	if (!gc)
 		return -ENOMEM;
 
 	/* search for end interval coming before this element.
@@ -246,17 +268,28 @@ static int nft_rbtree_gc_elem(const struct nft_set *__set,
 
 	if (prev) {
 		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
+		nft_rbtree_gc_remove(net, set, priv, rbe_prev);
+
+		/* There is always room in this trans gc for this element,
+		 * memory allocation never actually happens, hence, the warning
+		 * splat in such case. No need to set NFT_SET_ELEM_DEAD_BIT,
+		 * this is synchronous gc which never fails.
+		 */
+		gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
+		if (WARN_ON_ONCE(!gc))
+			return -ENOMEM;
 
-		rb_erase(&rbe_prev->node, &priv->root);
-		atomic_dec(&set->nelems);
-		nft_set_gc_batch_add(gcb, rbe_prev);
+		nft_trans_gc_elem_add(gc, rbe_prev);
 	}
 
-	rb_erase(&rbe->node, &priv->root);
-	atomic_dec(&set->nelems);
+	nft_rbtree_gc_remove(net, set, priv, rbe);
+	gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
+	if (WARN_ON_ONCE(!gc))
+		return -ENOMEM;
 
-	nft_set_gc_batch_add(gcb, rbe);
-	nft_set_gc_batch_complete(gcb);
+	nft_trans_gc_elem_add(gc, rbe);
+
+	nft_trans_gc_queue_sync_done(gc);
 
 	return 0;
 }
@@ -484,7 +517,6 @@ static void nft_rbtree_activate(const struct net *net,
 	struct nft_rbtree_elem *rbe = elem->priv;
 
 	nft_set_elem_change_active(net, set, &rbe->ext);
-	nft_set_elem_clear_busy(&rbe->ext);
 }
 
 static bool nft_rbtree_flush(const struct net *net,
@@ -492,12 +524,9 @@ static bool nft_rbtree_flush(const struct net *net,
 {
 	struct nft_rbtree_elem *rbe = priv;
 
-	if (!nft_set_elem_mark_busy(&rbe->ext) ||
-	    !nft_is_active(net, &rbe->ext)) {
-		nft_set_elem_change_active(net, set, &rbe->ext);
-		return true;
-	}
-	return false;
+	nft_set_elem_change_active(net, set, &rbe->ext);
+
+	return true;
 }
 
 static void *nft_rbtree_deactivate(const struct net *net,
@@ -574,26 +603,40 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
 
 static void nft_rbtree_gc(struct work_struct *work)
 {
-	struct nft_rbtree_elem *rbe, *rbe_end = NULL, *rbe_prev = NULL;
-	struct nft_set_gc_batch *gcb = NULL;
+	struct nft_rbtree_elem *rbe, *rbe_end = NULL;
+	struct nftables_pernet *nft_net;
 	struct nft_rbtree *priv;
+	struct nft_trans_gc *gc;
 	struct rb_node *node;
 	struct nft_set *set;
+	unsigned int gc_seq;
 	struct net *net;
-	u8 genmask;
 
 	priv = container_of(work, struct nft_rbtree, gc_work.work);
 	set  = nft_set_container_of(priv);
 	net  = read_pnet(&set->net);
-	genmask = nft_genmask_cur(net);
+	nft_net = net_generic(net, nf_tables_net_id);
+	gc_seq  = READ_ONCE(nft_net->gc_seq);
+
+	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
+	if (!gc)
+		goto done;
 
 	write_lock_bh(&priv->lock);
 	write_seqcount_begin(&priv->count);
 	for (node = rb_first(&priv->root); node != NULL; node = rb_next(node)) {
+
+		/* Ruleset has been updated, try later. */
+		if (READ_ONCE(nft_net->gc_seq) != gc_seq) {
+			nft_trans_gc_destroy(gc);
+			gc = NULL;
+			goto try_later;
+		}
+
 		rbe = rb_entry(node, struct nft_rbtree_elem, node);
 
-		if (!nft_set_elem_active(&rbe->ext, genmask))
-			continue;
+		if (nft_set_elem_is_dead(&rbe->ext))
+			goto dead_elem;
 
 		/* elements are reversed in the rbtree for historical reasons,
 		 * from highest to lowest value, that is why end element is
@@ -603,43 +646,38 @@ static void nft_rbtree_gc(struct work_struct *work)
 			rbe_end = rbe;
 			continue;
 		}
+
 		if (!nft_set_elem_expired(&rbe->ext))
 			continue;
 
-		if (nft_set_elem_mark_busy(&rbe->ext)) {
-			rbe_end = NULL;
+		nft_set_elem_dead(&rbe->ext);
+
+		if (!rbe_end)
 			continue;
-		}
 
-		if (rbe_prev) {
-			rb_erase(&rbe_prev->node, &priv->root);
-			rbe_prev = NULL;
-		}
-		gcb = nft_set_gc_batch_check(set, gcb, GFP_ATOMIC);
-		if (!gcb)
-			break;
+		nft_set_elem_dead(&rbe_end->ext);
 
-		atomic_dec(&set->nelems);
-		nft_set_gc_batch_add(gcb, rbe);
-		rbe_prev = rbe;
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (!gc)
+			goto try_later;
 
-		if (rbe_end) {
-			atomic_dec(&set->nelems);
-			nft_set_gc_batch_add(gcb, rbe_end);
-			rb_erase(&rbe_end->node, &priv->root);
-			rbe_end = NULL;
-		}
-		node = rb_next(node);
-		if (!node)
-			break;
+		nft_trans_gc_elem_add(gc, rbe_end);
+		rbe_end = NULL;
+dead_elem:
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (!gc)
+			goto try_later;
+
+		nft_trans_gc_elem_add(gc, rbe);
 	}
-	if (rbe_prev)
-		rb_erase(&rbe_prev->node, &priv->root);
+
+try_later:
 	write_seqcount_end(&priv->count);
 	write_unlock_bh(&priv->lock);
 
-	nft_set_gc_batch_complete(gcb);
-
+	if (gc)
+		nft_trans_gc_queue_async_done(gc);
+done:
 	queue_delayed_work(system_power_efficient_wq, &priv->gc_work,
 			   nft_set_gc_interval(set));
 }
-- 
2.30.2


