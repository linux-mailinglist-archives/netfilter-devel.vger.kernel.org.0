Return-Path: <netfilter-devel+bounces-7672-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B36AF0331
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Jul 2025 20:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766AA16719F
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Jul 2025 18:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5645327055A;
	Tue,  1 Jul 2025 18:53:06 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8C1223707
	for <netfilter-devel@vger.kernel.org>; Tue,  1 Jul 2025 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751395986; cv=none; b=OJ6p6XTIFx0n1+imQmHmoC/rEgLbTSzBTCoEXbq3jftIaxjD8Qra+dDyAeO/FmL9TcfaLima7BHFPQGsQO0TUh2+ZF8J/SCwT8MgqdXzXQX4KVL7VrEaRIk0yha7YX22bPaFFccKekTpA/Sc8LfQWWXsoqaGLLy+nuyBowS0sqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751395986; c=relaxed/simple;
	bh=fwF5wScSIAElAt0qslYH/d9puVkTzugdA4IcAIw4ib8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jb6KRfi58OKfw1MEtcbfktzjLNbFKqvpclM7RyqRm6CdGhv+dkuLUAynlmRmjqYrsmvcptAs8ADCRxcEWcZFgnQ1fw2YmwbuzIWfWpnkz8Ryashkky8psFrQw8F/h5j8Qz3sJ+RVXdBvmQNeBavsXdHbE7qJ84Bk2yZFEucIyYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id F1EDB6188E; Tue,  1 Jul 2025 20:53:01 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: sbrivio@redhat.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 2/5] netfilter: nft_set: remove one argument from lookup and update functions
Date: Tue,  1 Jul 2025 20:52:39 +0200
Message-ID: <20250701185245.31370-3-fw@strlen.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701185245.31370-1-fw@strlen.de>
References: <20250701185245.31370-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return the extension pointer instead of passing it as a function
argument to be filled in by the callee.

As-is, whenever false is returned, the extension pointer is not used.

For all set types, when true is returned, the extension pointer was set
to the matching element.

Only exception: nft_set_bitmap doesn't support extensions.
Return a pointer to a static const empty element extension container.

return false -> return NULL
return true -> return the elements' extension pointer.

This saves one function argument.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_tables.h      | 10 ++---
 include/net/netfilter/nf_tables_core.h | 47 ++++++++++++----------
 net/netfilter/nft_dynset.c             |  5 ++-
 net/netfilter/nft_lookup.c             | 27 ++++++-------
 net/netfilter/nft_objref.c             |  5 +--
 net/netfilter/nft_set_bitmap.c         | 11 ++++--
 net/netfilter/nft_set_hash.c           | 54 ++++++++++++--------------
 net/netfilter/nft_set_pipapo.c         | 19 +++++----
 net/netfilter/nft_set_pipapo_avx2.c    | 25 ++++++------
 net/netfilter/nft_set_rbtree.c         | 40 +++++++++----------
 10 files changed, 126 insertions(+), 117 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index e4d8e451e935..2da886716adc 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -459,19 +459,17 @@ struct nft_set_ext;
  *	control plane functions.
  */
 struct nft_set_ops {
-	bool				(*lookup)(const struct net *net,
+	const struct nft_set_ext *	(*lookup)(const struct net *net,
 						  const struct nft_set *set,
-						  const u32 *key,
-						  const struct nft_set_ext **ext);
-	bool				(*update)(struct nft_set *set,
+						  const u32 *key);
+	const struct nft_set_ext *	(*update)(struct nft_set *set,
 						  const u32 *key,
 						  struct nft_elem_priv *
 							(*new)(struct nft_set *,
 							       const struct nft_expr *,
 							       struct nft_regs *),
 						  const struct nft_expr *expr,
-						  struct nft_regs *regs,
-						  const struct nft_set_ext **ext);
+						  struct nft_regs *regs);
 	bool				(*delete)(const struct nft_set *set,
 						  const u32 *key);
 
diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
index 03b6165756fc..6a52fb97b844 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -94,34 +94,41 @@ extern const struct nft_set_type nft_set_pipapo_type;
 extern const struct nft_set_type nft_set_pipapo_avx2_type;
 
 #ifdef CONFIG_MITIGATION_RETPOLINE
-bool nft_rhash_lookup(const struct net *net, const struct nft_set *set,
-		      const u32 *key, const struct nft_set_ext **ext);
-bool nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext);
-bool nft_bitmap_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext);
-bool nft_hash_lookup_fast(const struct net *net,
-			  const struct nft_set *set,
-			  const u32 *key, const struct nft_set_ext **ext);
-bool nft_hash_lookup(const struct net *net, const struct nft_set *set,
-		     const u32 *key, const struct nft_set_ext **ext);
-bool nft_set_do_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext);
+const struct nft_set_ext *
+nft_rhash_lookup(const struct net *net, const struct nft_set *set,
+		 const u32 *key);
+const struct nft_set_ext *
+nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key);
+const struct nft_set_ext *
+nft_bitmap_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key);
+const struct nft_set_ext *
+nft_hash_lookup_fast(const struct net *net, const struct nft_set *set,
+		     const u32 *key);
+const struct nft_set_ext *
+nft_hash_lookup(const struct net *net, const struct nft_set *set,
+		const u32 *key);
+const struct nft_set_ext *
+nft_set_do_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key);
 #else
-static inline bool
+static inline const struct nft_set_ext *
 nft_set_do_lookup(const struct net *net, const struct nft_set *set,
-		  const u32 *key, const struct nft_set_ext **ext)
+		  const u32 *key)
 {
-	return set->ops->lookup(net, set, key, ext);
+	return set->ops->lookup(net, set, key);
 }
 #endif
 
 /* called from nft_pipapo_avx2.c */
-bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext);
+const struct nft_set_ext *
+nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key);
 /* called from nft_set_pipapo.c */
-bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
-			    const u32 *key, const struct nft_set_ext **ext);
+const struct nft_set_ext *
+nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
+			const u32 *key);
 
 void nft_counter_init_seqcount(void);
 
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 88922e0e8e83..e24493d9e776 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -91,8 +91,9 @@ void nft_dynset_eval(const struct nft_expr *expr,
 		return;
 	}
 
-	if (set->ops->update(set, &regs->data[priv->sreg_key], nft_dynset_new,
-			     expr, regs, &ext)) {
+	ext = set->ops->update(set, &regs->data[priv->sreg_key], nft_dynset_new,
+			     expr, regs);
+	if (ext) {
 		if (priv->op == NFT_DYNSET_OP_UPDATE &&
 		    nft_set_ext_exists(ext, NFT_SET_EXT_TIMEOUT) &&
 		    READ_ONCE(nft_set_ext_timeout(ext)->timeout) != 0) {
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index 63ef832b8aa7..40c602ffbcba 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -25,32 +25,33 @@ struct nft_lookup {
 };
 
 #ifdef CONFIG_MITIGATION_RETPOLINE
-bool nft_set_do_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext)
+const struct nft_set_ext *
+nft_set_do_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key)
 {
 	if (set->ops == &nft_set_hash_fast_type.ops)
-		return nft_hash_lookup_fast(net, set, key, ext);
+		return nft_hash_lookup_fast(net, set, key);
 	if (set->ops == &nft_set_hash_type.ops)
-		return nft_hash_lookup(net, set, key, ext);
+		return nft_hash_lookup(net, set, key);
 
 	if (set->ops == &nft_set_rhash_type.ops)
-		return nft_rhash_lookup(net, set, key, ext);
+		return nft_rhash_lookup(net, set, key);
 
 	if (set->ops == &nft_set_bitmap_type.ops)
-		return nft_bitmap_lookup(net, set, key, ext);
+		return nft_bitmap_lookup(net, set, key);
 
 	if (set->ops == &nft_set_pipapo_type.ops)
-		return nft_pipapo_lookup(net, set, key, ext);
+		return nft_pipapo_lookup(net, set, key);
 #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 	if (set->ops == &nft_set_pipapo_avx2_type.ops)
-		return nft_pipapo_avx2_lookup(net, set, key, ext);
+		return nft_pipapo_avx2_lookup(net, set, key);
 #endif
 
 	if (set->ops == &nft_set_rbtree_type.ops)
-		return nft_rbtree_lookup(net, set, key, ext);
+		return nft_rbtree_lookup(net, set, key);
 
 	WARN_ON_ONCE(1);
-	return set->ops->lookup(net, set, key, ext);
+	return set->ops->lookup(net, set, key);
 }
 EXPORT_SYMBOL_GPL(nft_set_do_lookup);
 #endif
@@ -61,12 +62,12 @@ void nft_lookup_eval(const struct nft_expr *expr,
 {
 	const struct nft_lookup *priv = nft_expr_priv(expr);
 	const struct nft_set *set = priv->set;
-	const struct nft_set_ext *ext = NULL;
 	const struct net *net = nft_net(pkt);
+	const struct nft_set_ext *ext;
 	bool found;
 
-	found =	nft_set_do_lookup(net, set, &regs->data[priv->sreg], &ext) ^
-				  priv->invert;
+	ext = nft_set_do_lookup(net, set, &regs->data[priv->sreg]);
+	found = !!ext ^ priv->invert;
 	if (!found) {
 		ext = nft_set_catchall_lookup(net, set);
 		if (!ext) {
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index 09da7a3f9f96..8ee66a86c3bc 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -111,10 +111,9 @@ void nft_objref_map_eval(const struct nft_expr *expr,
 	struct net *net = nft_net(pkt);
 	const struct nft_set_ext *ext;
 	struct nft_object *obj;
-	bool found;
 
-	found = nft_set_do_lookup(net, set, &regs->data[priv->sreg], &ext);
-	if (!found) {
+	ext = nft_set_do_lookup(net, set, &regs->data[priv->sreg]);
+	if (!ext) {
 		ext = nft_set_catchall_lookup(net, set);
 		if (!ext) {
 			regs->verdict.code = NFT_BREAK;
diff --git a/net/netfilter/nft_set_bitmap.c b/net/netfilter/nft_set_bitmap.c
index 12390d2e994f..c24c922f895d 100644
--- a/net/netfilter/nft_set_bitmap.c
+++ b/net/netfilter/nft_set_bitmap.c
@@ -75,16 +75,21 @@ nft_bitmap_active(const u8 *bitmap, u32 idx, u32 off, u8 genmask)
 }
 
 INDIRECT_CALLABLE_SCOPE
-bool nft_bitmap_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext)
+const struct nft_set_ext *
+nft_bitmap_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key)
 {
 	const struct nft_bitmap *priv = nft_set_priv(set);
+	static const struct nft_set_ext found;
 	u8 genmask = nft_genmask_cur(net);
 	u32 idx, off;
 
 	nft_bitmap_location(set, key, &idx, &off);
 
-	return nft_bitmap_active(priv->bitmap, idx, off, genmask);
+	if (nft_bitmap_active(priv->bitmap, idx, off, genmask))
+		return &found;
+
+	return NULL;
 }
 
 static struct nft_bitmap_elem *
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index abb0c8ec6371..9903c737c9f0 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -81,8 +81,9 @@ static const struct rhashtable_params nft_rhash_params = {
 };
 
 INDIRECT_CALLABLE_SCOPE
-bool nft_rhash_lookup(const struct net *net, const struct nft_set *set,
-		      const u32 *key, const struct nft_set_ext **ext)
+const struct nft_set_ext *
+nft_rhash_lookup(const struct net *net, const struct nft_set *set,
+		 const u32 *key)
 {
 	struct nft_rhash *priv = nft_set_priv(set);
 	const struct nft_rhash_elem *he;
@@ -95,9 +96,9 @@ bool nft_rhash_lookup(const struct net *net, const struct nft_set *set,
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
 	if (he != NULL)
-		*ext = &he->ext;
+		return &he->ext;
 
-	return !!he;
+	return NULL;
 }
 
 static struct nft_elem_priv *
@@ -120,14 +121,11 @@ nft_rhash_get(const struct net *net, const struct nft_set *set,
 	return ERR_PTR(-ENOENT);
 }
 
-static bool nft_rhash_update(struct nft_set *set, const u32 *key,
-			     struct nft_elem_priv *
-				   (*new)(struct nft_set *,
-					  const struct nft_expr *,
-					  struct nft_regs *regs),
-			     const struct nft_expr *expr,
-			     struct nft_regs *regs,
-			     const struct nft_set_ext **ext)
+static const struct nft_set_ext *
+nft_rhash_update(struct nft_set *set, const u32 *key,
+		 struct nft_elem_priv *(*new)(struct nft_set *, const struct nft_expr *,
+		 struct nft_regs *regs),
+		 const struct nft_expr *expr, struct nft_regs *regs)
 {
 	struct nft_rhash *priv = nft_set_priv(set);
 	struct nft_rhash_elem *he, *prev;
@@ -161,14 +159,13 @@ static bool nft_rhash_update(struct nft_set *set, const u32 *key,
 	}
 
 out:
-	*ext = &he->ext;
-	return true;
+	return &he->ext;
 
 err2:
 	nft_set_elem_destroy(set, &he->priv, true);
 	atomic_dec(&set->nelems);
 err1:
-	return false;
+	return NULL;
 }
 
 static int nft_rhash_insert(const struct net *net, const struct nft_set *set,
@@ -507,8 +504,9 @@ struct nft_hash_elem {
 };
 
 INDIRECT_CALLABLE_SCOPE
-bool nft_hash_lookup(const struct net *net, const struct nft_set *set,
-		     const u32 *key, const struct nft_set_ext **ext)
+const struct nft_set_ext *
+nft_hash_lookup(const struct net *net, const struct nft_set *set,
+		const u32 *key)
 {
 	struct nft_hash *priv = nft_set_priv(set);
 	u8 genmask = nft_genmask_cur(net);
@@ -519,12 +517,10 @@ bool nft_hash_lookup(const struct net *net, const struct nft_set *set,
 	hash = reciprocal_scale(hash, priv->buckets);
 	hlist_for_each_entry_rcu(he, &priv->table[hash], node) {
 		if (!memcmp(nft_set_ext_key(&he->ext), key, set->klen) &&
-		    nft_set_elem_active(&he->ext, genmask)) {
-			*ext = &he->ext;
-			return true;
-		}
+		    nft_set_elem_active(&he->ext, genmask))
+			return &he->ext;
 	}
-	return false;
+	return NULL;
 }
 
 static struct nft_elem_priv *
@@ -547,9 +543,9 @@ nft_hash_get(const struct net *net, const struct nft_set *set,
 }
 
 INDIRECT_CALLABLE_SCOPE
-bool nft_hash_lookup_fast(const struct net *net,
-			  const struct nft_set *set,
-			  const u32 *key, const struct nft_set_ext **ext)
+const struct nft_set_ext *
+nft_hash_lookup_fast(const struct net *net, const struct nft_set *set,
+		     const u32 *key)
 {
 	struct nft_hash *priv = nft_set_priv(set);
 	u8 genmask = nft_genmask_cur(net);
@@ -562,12 +558,10 @@ bool nft_hash_lookup_fast(const struct net *net,
 	hlist_for_each_entry_rcu(he, &priv->table[hash], node) {
 		k2 = *(u32 *)nft_set_ext_key(&he->ext)->data;
 		if (k1 == k2 &&
-		    nft_set_elem_active(&he->ext, genmask)) {
-			*ext = &he->ext;
-			return true;
-		}
+		    nft_set_elem_active(&he->ext, genmask))
+			return &he->ext;
 	}
-	return false;
+	return NULL;
 }
 
 static u32 nft_jhash(const struct nft_set *set, const struct nft_hash *priv,
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 08fb6720673f..36a4de11995b 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -407,8 +407,9 @@ int pipapo_refill(unsigned long *map, unsigned int len, unsigned int rules,
  *
  * Return: true on match, false otherwise.
  */
-bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext)
+const struct nft_set_ext *
+nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct nft_pipapo_scratch *scratch;
@@ -465,13 +466,15 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 			scratch->map_index = map_index;
 			local_bh_enable();
 
-			return false;
+			return NULL;
 		}
 
 		if (last) {
-			*ext = &f->mt[b].e->ext;
-			if (unlikely(nft_set_elem_expired(*ext) ||
-				     !nft_set_elem_active(*ext, genmask)))
+			const struct nft_set_ext *ext;
+
+			ext = &f->mt[b].e->ext;
+			if (unlikely(nft_set_elem_expired(ext) ||
+				     !nft_set_elem_active(ext, genmask)))
 				goto next_match;
 
 			/* Last field: we're just returning the key without
@@ -482,7 +485,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 			scratch->map_index = map_index;
 			local_bh_enable();
 
-			return true;
+			return ext;
 		}
 
 		/* Swap bitmap indices: res_map is the initial bitmap for the
@@ -497,7 +500,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 
 out:
 	local_bh_enable();
-	return false;
+	return NULL;
 }
 
 /**
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index be7c16c79f71..6c441e2dc8af 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1146,8 +1146,9 @@ static inline void pipapo_resmap_init_avx2(const struct nft_pipapo_match *m, uns
  *
  * Return: true on match, false otherwise.
  */
-bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
-			    const u32 *key, const struct nft_set_ext **ext)
+const struct nft_set_ext *
+nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
+		       const u32 *key)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct nft_pipapo_scratch *scratch;
@@ -1155,17 +1156,18 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	const struct nft_pipapo_match *m;
 	const struct nft_pipapo_field *f;
 	const u8 *rp = (const u8 *)key;
+	const struct nft_set_ext *ext;
 	unsigned long *res, *fill;
 	bool map_index;
-	int i, ret = 0;
+	int i;
 
 	local_bh_disable();
 
 	if (unlikely(!irq_fpu_usable())) {
-		bool fallback_res = nft_pipapo_lookup(net, set, key, ext);
+		ext = nft_pipapo_lookup(net, set, key);
 
 		local_bh_enable();
-		return fallback_res;
+		return ext;
 	}
 
 	m = rcu_dereference(priv->match);
@@ -1182,7 +1184,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	if (unlikely(!scratch)) {
 		kernel_fpu_end();
 		local_bh_enable();
-		return false;
+		return NULL;
 	}
 
 	map_index = scratch->map_index;
@@ -1197,6 +1199,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 next_match:
 	nft_pipapo_for_each_field(f, i, m) {
 		bool last = i == m->field_count - 1, first = !i;
+		int ret = 0;
 
 #define NFT_SET_PIPAPO_AVX2_LOOKUP(b, n)				\
 		(ret = nft_pipapo_avx2_lookup_##b##b_##n(res, fill, f,	\
@@ -1244,10 +1247,10 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 			goto out;
 
 		if (last) {
-			*ext = &f->mt[ret].e->ext;
-			if (unlikely(nft_set_elem_expired(*ext) ||
-				     !nft_set_elem_active(*ext, genmask))) {
-				ret = 0;
+			ext = &f->mt[ret].e->ext;
+			if (unlikely(nft_set_elem_expired(ext) ||
+				     !nft_set_elem_active(ext, genmask))) {
+				ext = NULL;
 				goto next_match;
 			}
 
@@ -1264,5 +1267,5 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	kernel_fpu_end();
 	local_bh_enable();
 
-	return ret >= 0;
+	return ext;
 }
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 2e8ef16ff191..938a257c069e 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -52,9 +52,9 @@ static bool nft_rbtree_elem_expired(const struct nft_rbtree_elem *rbe)
 	return nft_set_elem_expired(&rbe->ext);
 }
 
-static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
-				const u32 *key, const struct nft_set_ext **ext,
-				unsigned int seq)
+static const struct nft_set_ext *
+__nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
+		    const u32 *key, unsigned int seq)
 {
 	struct nft_rbtree *priv = nft_set_priv(set);
 	const struct nft_rbtree_elem *rbe, *interval = NULL;
@@ -65,7 +65,7 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 	parent = rcu_dereference_raw(priv->root.rb_node);
 	while (parent != NULL) {
 		if (read_seqcount_retry(&priv->count, seq))
-			return false;
+			return NULL;
 
 		rbe = rb_entry(parent, struct nft_rbtree_elem, node);
 
@@ -87,50 +87,48 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 			}
 
 			if (nft_rbtree_elem_expired(rbe))
-				return false;
+				return NULL;
 
 			if (nft_rbtree_interval_end(rbe)) {
 				if (nft_set_is_anonymous(set))
-					return false;
+					return NULL;
 				parent = rcu_dereference_raw(parent->rb_left);
 				interval = NULL;
 				continue;
 			}
 
-			*ext = &rbe->ext;
-			return true;
+			return &rbe->ext;
 		}
 	}
 
 	if (set->flags & NFT_SET_INTERVAL && interval != NULL &&
 	    nft_set_elem_active(&interval->ext, genmask) &&
 	    !nft_rbtree_elem_expired(interval) &&
-	    nft_rbtree_interval_start(interval)) {
-		*ext = &interval->ext;
-		return true;
-	}
+	    nft_rbtree_interval_start(interval))
+		return &interval->ext;
 
-	return false;
+	return NULL;
 }
 
 INDIRECT_CALLABLE_SCOPE
-bool nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
-		       const u32 *key, const struct nft_set_ext **ext)
+const struct nft_set_ext *
+nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
+		  const u32 *key)
 {
 	struct nft_rbtree *priv = nft_set_priv(set);
 	unsigned int seq = read_seqcount_begin(&priv->count);
-	bool ret;
+	const struct nft_set_ext *ext;
 
-	ret = __nft_rbtree_lookup(net, set, key, ext, seq);
-	if (ret || !read_seqcount_retry(&priv->count, seq))
-		return ret;
+	ext = __nft_rbtree_lookup(net, set, key, seq);
+	if (ext || !read_seqcount_retry(&priv->count, seq))
+		return ext;
 
 	read_lock_bh(&priv->lock);
 	seq = read_seqcount_begin(&priv->count);
-	ret = __nft_rbtree_lookup(net, set, key, ext, seq);
+	ext = __nft_rbtree_lookup(net, set, key, seq);
 	read_unlock_bh(&priv->lock);
 
-	return ret;
+	return ext;
 }
 
 static bool __nft_rbtree_get(const struct net *net, const struct nft_set *set,
-- 
2.49.0


