Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600557D4A4C
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Oct 2023 10:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbjJXIeY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Oct 2023 04:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjJXIeK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:34:10 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 651BCD7D
        for <netfilter-devel@vger.kernel.org>; Tue, 24 Oct 2023 01:34:07 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 5/5] netfilter: nf_tables: set->ops->insert returns opaque set element in case of EEXIST
Date:   Tue, 24 Oct 2023 10:33:59 +0200
Message-Id: <20231024083359.24742-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231024083359.24742-1-pablo@netfilter.org>
References: <20231024083359.24742-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Return struct nft_elem_priv instead of struct nft_set_ext for
consistency with ("netfilter: nf_tables: expose opaque set element as
struct nft_elem_priv") and to prepare the introduction of element
timeout updates from control path.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h |  2 +-
 net/netfilter/nf_tables_api.c     | 17 ++++++++++-------
 net/netfilter/nft_set_bitmap.c    |  4 ++--
 net/netfilter/nft_set_hash.c      |  8 ++++----
 net/netfilter/nft_set_pipapo.c    | 10 +++++-----
 net/netfilter/nft_set_rbtree.c    | 10 +++++-----
 6 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index b63f35fb2a99..3bbd13ab1ecf 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -451,7 +451,7 @@ struct nft_set_ops {
 	int				(*insert)(const struct net *net,
 						  const struct nft_set *set,
 						  const struct nft_set_elem *elem,
-						  struct nft_set_ext **ext);
+						  struct nft_elem_priv **priv);
 	void				(*activate)(const struct net *net,
 						    const struct nft_set *set,
 						    struct nft_elem_priv *elem_priv);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3b47f321e65b..f2cbd53e393d 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6332,7 +6332,7 @@ EXPORT_SYMBOL_GPL(nft_set_catchall_lookup);
 static int nft_setelem_catchall_insert(const struct net *net,
 				       struct nft_set *set,
 				       const struct nft_set_elem *elem,
-				       struct nft_set_ext **pext)
+				       struct nft_elem_priv **priv)
 {
 	struct nft_set_elem_catchall *catchall;
 	u8 genmask = nft_genmask_next(net);
@@ -6341,7 +6341,7 @@ static int nft_setelem_catchall_insert(const struct net *net,
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
 		if (nft_set_elem_active(ext, genmask)) {
-			*pext = ext;
+			*priv = catchall->elem;
 			return -EEXIST;
 		}
 	}
@@ -6359,14 +6359,15 @@ static int nft_setelem_catchall_insert(const struct net *net,
 static int nft_setelem_insert(const struct net *net,
 			      struct nft_set *set,
 			      const struct nft_set_elem *elem,
-			      struct nft_set_ext **ext, unsigned int flags)
+			      struct nft_elem_priv **elem_priv,
+			      unsigned int flags)
 {
 	int ret;
 
 	if (flags & NFT_SET_ELEM_CATCHALL)
-		ret = nft_setelem_catchall_insert(net, set, elem, ext);
+		ret = nft_setelem_catchall_insert(net, set, elem, elem_priv);
 	else
-		ret = set->ops->insert(net, set, elem, ext);
+		ret = set->ops->insert(net, set, elem, elem_priv);
 
 	return ret;
 }
@@ -6502,13 +6503,14 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	struct nft_set_ext *ext, *ext2;
 	struct nft_set_elem elem;
 	struct nft_set_binding *binding;
+	struct nft_elem_priv *elem_priv;
 	struct nft_object *obj = NULL;
 	struct nft_userdata *udata;
 	struct nft_data_desc desc;
 	enum nft_registers dreg;
 	struct nft_trans *trans;
-	u64 timeout;
 	u64 expiration;
+	u64 timeout;
 	int err, i;
 	u8 ulen;
 
@@ -6801,9 +6803,10 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 
 	ext->genmask = nft_genmask_cur(ctx->net);
 
-	err = nft_setelem_insert(ctx->net, set, &elem, &ext2, flags);
+	err = nft_setelem_insert(ctx->net, set, &elem, &elem_priv, flags);
 	if (err) {
 		if (err == -EEXIST) {
+			ext2 = nft_set_elem_ext(set, elem_priv);
 			if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA) ^
 			    nft_set_ext_exists(ext2, NFT_SET_EXT_DATA) ||
 			    nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF) ^
diff --git a/net/netfilter/nft_set_bitmap.c b/net/netfilter/nft_set_bitmap.c
index 963edb514641..32df7a16835d 100644
--- a/net/netfilter/nft_set_bitmap.c
+++ b/net/netfilter/nft_set_bitmap.c
@@ -125,7 +125,7 @@ nft_bitmap_get(const struct net *net, const struct nft_set *set,
 
 static int nft_bitmap_insert(const struct net *net, const struct nft_set *set,
 			     const struct nft_set_elem *elem,
-			     struct nft_set_ext **ext)
+			     struct nft_elem_priv **elem_priv)
 {
 	struct nft_bitmap_elem *new = nft_elem_priv_cast(elem->priv), *be;
 	struct nft_bitmap *priv = nft_set_priv(set);
@@ -134,7 +134,7 @@ static int nft_bitmap_insert(const struct net *net, const struct nft_set *set,
 
 	be = nft_bitmap_elem_find(set, new, genmask);
 	if (be) {
-		*ext = &be->ext;
+		*elem_priv = &be->priv;
 		return -EEXIST;
 	}
 
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index e6c00891e334..6c2061bfdae6 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -167,7 +167,7 @@ static bool nft_rhash_update(struct nft_set *set, const u32 *key,
 
 static int nft_rhash_insert(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem,
-			    struct nft_set_ext **ext)
+			    struct nft_elem_priv **elem_priv)
 {
 	struct nft_rhash_elem *he = nft_elem_priv_cast(elem->priv);
 	struct nft_rhash *priv = nft_set_priv(set);
@@ -183,7 +183,7 @@ static int nft_rhash_insert(const struct net *net, const struct nft_set *set,
 	if (IS_ERR(prev))
 		return PTR_ERR(prev);
 	if (prev) {
-		*ext = &prev->ext;
+		*elem_priv = &prev->priv;
 		return -EEXIST;
 	}
 	return 0;
@@ -568,7 +568,7 @@ static u32 nft_jhash(const struct nft_set *set, const struct nft_hash *priv,
 
 static int nft_hash_insert(const struct net *net, const struct nft_set *set,
 			   const struct nft_set_elem *elem,
-			   struct nft_set_ext **ext)
+			   struct nft_elem_priv **elem_priv)
 {
 	struct nft_hash_elem *this = nft_elem_priv_cast(elem->priv), *he;
 	struct nft_hash *priv = nft_set_priv(set);
@@ -580,7 +580,7 @@ static int nft_hash_insert(const struct net *net, const struct nft_set *set,
 		if (!memcmp(nft_set_ext_key(&this->ext),
 			    nft_set_ext_key(&he->ext), set->klen) &&
 		    nft_set_elem_active(&he->ext, genmask)) {
-			*ext = &he->ext;
+			*elem_priv = &he->priv;
 			return -EEXIST;
 		}
 	}
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index f540c2be0caa..701977af3ee8 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1158,13 +1158,13 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
  * @net:	Network namespace
  * @set:	nftables API set representation
  * @elem:	nftables API element representation containing key data
- * @ext2:	Filled with pointer to &struct nft_set_ext in inserted element
+ * @elem_priv:	Filled with pointer to &struct nft_set_ext in inserted element
  *
  * Return: 0 on success, error pointer on failure.
  */
 static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 			     const struct nft_set_elem *elem,
-			     struct nft_set_ext **ext2)
+			     struct nft_elem_priv **elem_priv)
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 	union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
@@ -1195,7 +1195,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 		if (!memcmp(start, dup_key->data, sizeof(*dup_key->data)) &&
 		    !memcmp(end, dup_end->data, sizeof(*dup_end->data))) {
-			*ext2 = &dup->ext;
+			*elem_priv = &dup->priv;
 			return -EEXIST;
 		}
 
@@ -1210,7 +1210,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	if (PTR_ERR(dup) != -ENOENT) {
 		if (IS_ERR(dup))
 			return PTR_ERR(dup);
-		*ext2 = &dup->ext;
+		*elem_priv = &dup->priv;
 		return -ENOTEMPTY;
 	}
 
@@ -1271,7 +1271,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	}
 
 	e = nft_elem_priv_cast(elem->priv);
-	*ext2 = &e->ext;
+	*elem_priv = &e->priv;
 
 	pipapo_map(m, rulemap, e);
 
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index cf344440aab4..1156c34aebe4 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -306,7 +306,7 @@ static bool nft_rbtree_update_first(const struct nft_set *set,
 
 static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 			       struct nft_rbtree_elem *new,
-			       struct nft_set_ext **ext)
+			       struct nft_elem_priv **elem_priv)
 {
 	struct nft_rbtree_elem *rbe, *rbe_le = NULL, *rbe_ge = NULL;
 	struct rb_node *node, *next, *parent, **p, *first = NULL;
@@ -423,7 +423,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	 */
 	if (rbe_ge && !nft_rbtree_cmp(set, new, rbe_ge) &&
 	    nft_rbtree_interval_start(rbe_ge) == nft_rbtree_interval_start(new)) {
-		*ext = &rbe_ge->ext;
+		*elem_priv = &rbe_ge->priv;
 		return -EEXIST;
 	}
 
@@ -432,7 +432,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	 */
 	if (rbe_le && !nft_rbtree_cmp(set, new, rbe_le) &&
 	    nft_rbtree_interval_end(rbe_le) == nft_rbtree_interval_end(new)) {
-		*ext = &rbe_le->ext;
+		*elem_priv = &rbe_le->priv;
 		return -EEXIST;
 	}
 
@@ -484,7 +484,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 
 static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 			     const struct nft_set_elem *elem,
-			     struct nft_set_ext **ext)
+			     struct nft_elem_priv **elem_priv)
 {
 	struct nft_rbtree_elem *rbe = nft_elem_priv_cast(elem->priv);
 	struct nft_rbtree *priv = nft_set_priv(set);
@@ -498,7 +498,7 @@ static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 
 		write_lock_bh(&priv->lock);
 		write_seqcount_begin(&priv->count);
-		err = __nft_rbtree_insert(net, set, rbe, ext);
+		err = __nft_rbtree_insert(net, set, rbe, elem_priv);
 		write_seqcount_end(&priv->count);
 		write_unlock_bh(&priv->lock);
 	} while (err == -EAGAIN);
-- 
2.30.2

