Return-Path: <netfilter-devel+bounces-4458-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF7499C88F
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Oct 2024 13:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855C5280F41
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Oct 2024 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E52B1A7266;
	Mon, 14 Oct 2024 11:14:33 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FA41A2626;
	Mon, 14 Oct 2024 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904473; cv=none; b=PriP7awxrcbZtkbhG2hFKfx4QACWrzZBal0x52FbqJCtIxOMQK5EC2VaYE9r4mYHX3m2v/GL9irgWMIV0msyyGy5sQA6SpkxQSVfR4tWWWyiaKhMhdCSdSn3sfN9r7yrgwJwuGhksWDgrc18258OIxTvQK3SyJGMYDrk4qsn5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904473; c=relaxed/simple;
	bh=toxujpCGeLcVq1nu9SRjeW1Oswo4gbG0y4dbZH8Uzhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mFuBLr+t3mSxZIBBytzJ/whkg4mnAEHTaUyMhchThqFhS+uM65NMLZSeBfgiWUQCHh8fvRffRQbuTVVFMhJTNxzK6NJ04J2J/4/iUFrtbB1D60AMKYcgVBB7k1iyG2zLMxjYbis48yIgcoJqmuKUrQLl0SR76c7sdZBDo1hRwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 5/9] netfilter: nf_tables: prepare for multiple elements in nft_trans_elem structure
Date: Mon, 14 Oct 2024 13:14:16 +0200
Message-Id: <20241014111420.29127-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241014111420.29127-1-pablo@netfilter.org>
References: <20241014111420.29127-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

Add helpers to release the individual elements contained in the
trans_elem container structure.

No functional change intended.

Followup patch will add 'nelems' member and will turn 'priv' into
a flexible array.

These helpers can then loop over all elements.
Care needs to be taken to handle a mix of new elements and existing
elements that are being updated (e.g. timeout refresh).

Before this patch, NEWSETELEM transaction with update is released
early so nft_trans_set_elem_destroy() won't get called, so we need
to skip elements marked as update.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h |  21 ++-
 net/netfilter/nf_tables_api.c     | 221 +++++++++++++++++++++---------
 2 files changed, 168 insertions(+), 74 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 91ae20cb7648..2a2631edab2b 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1754,28 +1754,25 @@ enum nft_trans_elem_flags {
 	NFT_TRANS_UPD_EXPIRATION	= (1 << 1),
 };
 
-struct nft_trans_elem {
-	struct nft_trans		nft_trans;
-	struct nft_set			*set;
-	struct nft_elem_priv		*elem_priv;
+struct nft_trans_one_elem {
+	struct nft_elem_priv		*priv;
 	u64				timeout;
 	u64				expiration;
 	u8				update_flags;
+};
+
+struct nft_trans_elem {
+	struct nft_trans		nft_trans;
+	struct nft_set			*set;
 	bool				bound;
+	unsigned int			nelems;
+	struct nft_trans_one_elem	elems[] __counted_by(nelems);
 };
 
 #define nft_trans_container_elem(t)			\
 	container_of(t, struct nft_trans_elem, nft_trans)
 #define nft_trans_elem_set(trans)			\
 	nft_trans_container_elem(trans)->set
-#define nft_trans_elem_priv(trans)			\
-	nft_trans_container_elem(trans)->elem_priv
-#define nft_trans_elem_update_flags(trans)		\
-	nft_trans_container_elem(trans)->update_flags
-#define nft_trans_elem_timeout(trans)			\
-	nft_trans_container_elem(trans)->timeout
-#define nft_trans_elem_expiration(trans)		\
-	nft_trans_container_elem(trans)->expiration
 #define nft_trans_elem_set_bound(trans)			\
 	nft_trans_container_elem(trans)->bound
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 99bf8abb7ffb..11247e149f17 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6552,28 +6552,51 @@ static void nft_set_elem_expr_destroy(const struct nft_ctx *ctx,
 }
 
 /* Drop references and destroy. Called from gc, dynset and abort path. */
-void nft_set_elem_destroy(const struct nft_set *set,
-			  const struct nft_elem_priv *elem_priv,
-			  bool destroy_expr)
+static void __nft_set_elem_destroy(const struct nft_ctx *ctx,
+				   const struct nft_set *set,
+				   const struct nft_elem_priv *elem_priv,
+				   bool destroy_expr)
 {
 	struct nft_set_ext *ext = nft_set_elem_ext(set, elem_priv);
-	struct nft_ctx ctx = {
-		.net	= read_pnet(&set->net),
-		.family	= set->table->family,
-	};
 
 	nft_data_release(nft_set_ext_key(ext), NFT_DATA_VALUE);
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA))
 		nft_data_release(nft_set_ext_data(ext), set->dtype);
 	if (destroy_expr && nft_set_ext_exists(ext, NFT_SET_EXT_EXPRESSIONS))
-		nft_set_elem_expr_destroy(&ctx, nft_set_ext_expr(ext));
+		nft_set_elem_expr_destroy(ctx, nft_set_ext_expr(ext));
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF))
 		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 
 	kfree(elem_priv);
 }
+
+/* Drop references and destroy. Called from gc and dynset. */
+void nft_set_elem_destroy(const struct nft_set *set,
+			  const struct nft_elem_priv *elem_priv,
+			  bool destroy_expr)
+{
+	struct nft_ctx ctx = {
+		.net	= read_pnet(&set->net),
+		.family	= set->table->family,
+	};
+
+	__nft_set_elem_destroy(&ctx, set, elem_priv, destroy_expr);
+}
 EXPORT_SYMBOL_GPL(nft_set_elem_destroy);
 
+/* Drop references and destroy. Called from abort path. */
+static void nft_trans_set_elem_destroy(const struct nft_ctx *ctx, struct nft_trans_elem *te)
+{
+	int i;
+
+	for (i = 0; i < te->nelems; i++) {
+		if (te->elems[i].update_flags)
+			continue;
+
+		__nft_set_elem_destroy(ctx, te->set, te->elems[i].priv, true);
+	}
+}
+
 /* Destroy element. References have been already dropped in the preparation
  * path via nft_setelem_data_deactivate().
  */
@@ -6589,6 +6612,15 @@ void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
 	kfree(elem_priv);
 }
 
+static void nft_trans_elems_destroy(const struct nft_ctx *ctx,
+				    const struct nft_trans_elem *te)
+{
+	int i;
+
+	for (i = 0; i < te->nelems; i++)
+		nf_tables_set_elem_destroy(ctx, te->set, te->elems[i].priv);
+}
+
 int nft_set_elem_expr_clone(const struct nft_ctx *ctx, struct nft_set *set,
 			    struct nft_expr *expr_array[])
 {
@@ -6745,6 +6777,37 @@ static void nft_setelem_activate(struct net *net, struct nft_set *set,
 	}
 }
 
+static void nft_trans_elem_update(const struct nft_set *set,
+				  const struct nft_trans_one_elem *elem)
+{
+	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
+
+	if (elem->update_flags & NFT_TRANS_UPD_TIMEOUT)
+		WRITE_ONCE(nft_set_ext_timeout(ext)->timeout, elem->timeout);
+
+	if (elem->update_flags & NFT_TRANS_UPD_EXPIRATION)
+		WRITE_ONCE(nft_set_ext_timeout(ext)->expiration, get_jiffies_64() + elem->expiration);
+}
+
+static void nft_trans_elems_activate(const struct nft_ctx *ctx,
+				     const struct nft_trans_elem *te)
+{
+	int i;
+
+	for (i = 0; i < te->nelems; i++) {
+		const struct nft_trans_one_elem *elem = &te->elems[i];
+
+		if (elem->update_flags) {
+			nft_trans_elem_update(te->set, elem);
+			continue;
+		}
+
+		nft_setelem_activate(ctx->net, te->set, elem->priv);
+		nf_tables_setelem_notify(ctx, te->set, elem->priv,
+					 NFT_MSG_NEWSETELEM);
+	}
+}
+
 static int nft_setelem_catchall_deactivate(const struct net *net,
 					   struct nft_set *set,
 					   struct nft_set_elem *elem)
@@ -6827,6 +6890,24 @@ static void nft_setelem_remove(const struct net *net,
 		set->ops->remove(net, set, elem_priv);
 }
 
+static void nft_trans_elems_remove(const struct nft_ctx *ctx,
+				  const struct nft_trans_elem *te)
+{
+	int i;
+
+	for (i = 0; i < te->nelems; i++) {
+		nf_tables_setelem_notify(ctx, te->set,
+					 te->elems[i].priv,
+					 te->nft_trans.msg_type);
+
+		nft_setelem_remove(ctx->net, te->set, te->elems[i].priv);
+		if (!nft_setelem_is_catchall(te->set, te->elems[i].priv)) {
+			atomic_dec(&te->set->nelems);
+			te->set->ndeact--;
+		}
+	}
+}
+
 static bool nft_setelem_valid_key_end(const struct nft_set *set,
 				      struct nlattr **nla, u32 flags)
 {
@@ -7178,22 +7259,26 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			else if (!(nlmsg_flags & NLM_F_EXCL)) {
 				err = 0;
 				if (nft_set_ext_exists(ext2, NFT_SET_EXT_TIMEOUT)) {
+					struct nft_trans_one_elem *update;
+
+					update = &nft_trans_container_elem(trans)->elems[0];
+
 					update_flags = 0;
 					if (timeout != nft_set_ext_timeout(ext2)->timeout) {
-						nft_trans_elem_timeout(trans) = timeout;
+						update->timeout = timeout;
 						if (expiration == 0)
 							expiration = timeout;
 
 						update_flags |= NFT_TRANS_UPD_TIMEOUT;
 					}
 					if (expiration) {
-						nft_trans_elem_expiration(trans) = expiration;
+						update->expiration = expiration;
 						update_flags |= NFT_TRANS_UPD_EXPIRATION;
 					}
 
 					if (update_flags) {
-						nft_trans_elem_priv(trans) = elem_priv;
-						nft_trans_elem_update_flags(trans) = update_flags;
+						update->priv = elem_priv;
+						update->update_flags = update_flags;
 						nft_trans_commit_list_add_elem(ctx->net, trans, GFP_KERNEL);
 						goto err_elem_free;
 					}
@@ -7217,7 +7302,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		}
 	}
 
-	nft_trans_elem_priv(trans) = elem.priv;
+	nft_trans_container_elem(trans)->elems[0].priv = elem.priv;
 	nft_trans_commit_list_add_elem(ctx->net, trans, GFP_KERNEL);
 	return 0;
 
@@ -7355,6 +7440,50 @@ void nft_setelem_data_deactivate(const struct net *net,
 		nft_use_dec(&(*nft_set_ext_obj(ext))->use);
 }
 
+/* similar to nft_trans_elems_remove, but called from abort path to undo newsetelem.
+ * No notifications and no ndeact changes.
+ *
+ * Returns true if set had been added to (i.e., elements need to be removed again).
+ */
+static bool nft_trans_elems_new_abort(const struct nft_ctx *ctx,
+				      const struct nft_trans_elem *te)
+{
+	bool removed = false;
+	int i;
+
+	for (i = 0; i < te->nelems; i++) {
+		if (te->elems[i].update_flags)
+			continue;
+
+		if (!te->set->ops->abort || nft_setelem_is_catchall(te->set, te->elems[i].priv))
+			nft_setelem_remove(ctx->net, te->set, te->elems[i].priv);
+
+		if (!nft_setelem_is_catchall(te->set, te->elems[i].priv))
+			atomic_dec(&te->set->nelems);
+
+		removed = true;
+	}
+
+	return removed;
+}
+
+/* Called from abort path to undo DELSETELEM/DESTROYSETELEM. */
+static void nft_trans_elems_destroy_abort(const struct nft_ctx *ctx,
+					  const struct nft_trans_elem *te)
+{
+	int i;
+
+	for (i = 0; i < te->nelems; i++) {
+		if (!nft_setelem_active_next(ctx->net, te->set, te->elems[i].priv)) {
+			nft_setelem_data_activate(ctx->net, te->set, te->elems[i].priv);
+			nft_setelem_activate(ctx->net, te->set, te->elems[i].priv);
+		}
+
+		if (!nft_setelem_is_catchall(te->set, te->elems[i].priv))
+			te->set->ndeact--;
+	}
+}
+
 static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 			   const struct nlattr *attr)
 {
@@ -7434,7 +7563,7 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
 
 	nft_setelem_data_deactivate(ctx->net, set, elem.priv);
 
-	nft_trans_elem_priv(trans) = elem.priv;
+	nft_trans_container_elem(trans)->elems[0].priv = elem.priv;
 	nft_trans_commit_list_add_elem(ctx->net, trans, GFP_KERNEL);
 	return 0;
 
@@ -7461,7 +7590,8 @@ static int nft_setelem_flush(const struct nft_ctx *ctx,
 		return 0;
 
 	trans = nft_trans_alloc_gfp(ctx, NFT_MSG_DELSETELEM,
-				    sizeof(struct nft_trans_elem), GFP_ATOMIC);
+				    struct_size_t(struct nft_trans_elem, elems, 1),
+				    GFP_ATOMIC);
 	if (!trans)
 		return -ENOMEM;
 
@@ -7470,7 +7600,8 @@ static int nft_setelem_flush(const struct nft_ctx *ctx,
 
 	nft_setelem_data_deactivate(ctx->net, set, elem_priv);
 	nft_trans_elem_set(trans) = set;
-	nft_trans_elem_priv(trans) = elem_priv;
+	nft_trans_container_elem(trans)->nelems = 1;
+	nft_trans_container_elem(trans)->elems[0].priv = elem_priv;
 	nft_trans_commit_list_add_elem(ctx->net, trans, GFP_ATOMIC);
 
 	return 0;
@@ -7487,7 +7618,7 @@ static int __nft_set_catchall_flush(const struct nft_ctx *ctx,
 		return -ENOMEM;
 
 	nft_setelem_data_deactivate(ctx->net, set, elem_priv);
-	nft_trans_elem_priv(trans) = elem_priv;
+	nft_trans_container_elem(trans)->elems[0].priv = elem_priv;
 	nft_trans_commit_list_add_elem(ctx->net, trans, GFP_KERNEL);
 
 	return 0;
@@ -9666,9 +9797,7 @@ static void nft_commit_release(struct nft_trans *trans)
 		break;
 	case NFT_MSG_DELSETELEM:
 	case NFT_MSG_DESTROYSETELEM:
-		nf_tables_set_elem_destroy(&ctx,
-					   nft_trans_elem_set(trans),
-					   nft_trans_elem_priv(trans));
+		nft_trans_elems_destroy(&ctx, nft_trans_container_elem(trans));
 		break;
 	case NFT_MSG_DELOBJ:
 	case NFT_MSG_DESTROYOBJ:
@@ -10521,25 +10650,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 		case NFT_MSG_NEWSETELEM:
 			te = nft_trans_container_elem(trans);
 
-			if (te->update_flags) {
-				const struct nft_set_ext *ext =
-					nft_set_elem_ext(te->set, te->elem_priv);
-
-				if (te->update_flags & NFT_TRANS_UPD_TIMEOUT) {
-					WRITE_ONCE(nft_set_ext_timeout(ext)->timeout,
-						   te->timeout);
-				}
-				if (te->update_flags & NFT_TRANS_UPD_EXPIRATION) {
-					WRITE_ONCE(nft_set_ext_timeout(ext)->expiration,
-						   get_jiffies_64() + te->expiration);
-				}
-			} else {
-				nft_setelem_activate(net, te->set, te->elem_priv);
-			}
+			nft_trans_elems_activate(&ctx, te);
 
-			nf_tables_setelem_notify(&ctx, te->set,
-						 te->elem_priv,
-						 NFT_MSG_NEWSETELEM);
 			if (te->set->ops->commit &&
 			    list_empty(&te->set->pending_update)) {
 				list_add_tail(&te->set->pending_update,
@@ -10551,14 +10663,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 		case NFT_MSG_DESTROYSETELEM:
 			te = nft_trans_container_elem(trans);
 
-			nf_tables_setelem_notify(&ctx, te->set,
-						 te->elem_priv,
-						 trans->msg_type);
-			nft_setelem_remove(net, te->set, te->elem_priv);
-			if (!nft_setelem_is_catchall(te->set, te->elem_priv)) {
-				atomic_dec(&te->set->nelems);
-				te->set->ndeact--;
-			}
+			nft_trans_elems_remove(&ctx, te);
+
 			if (te->set->ops->commit &&
 			    list_empty(&te->set->pending_update)) {
 				list_add_tail(&te->set->pending_update,
@@ -10678,8 +10784,7 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 		nft_set_destroy(&ctx, nft_trans_set(trans));
 		break;
 	case NFT_MSG_NEWSETELEM:
-		nft_set_elem_destroy(nft_trans_elem_set(trans),
-				     nft_trans_elem_priv(trans), true);
+		nft_trans_set_elem_destroy(&ctx, nft_trans_container_elem(trans));
 		break;
 	case NFT_MSG_NEWOBJ:
 		nft_obj_destroy(&ctx, nft_trans_obj(trans));
@@ -10836,18 +10941,15 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWSETELEM:
-			if (nft_trans_elem_update_flags(trans) ||
-			    nft_trans_elem_set_bound(trans)) {
+			if (nft_trans_elem_set_bound(trans)) {
 				nft_trans_destroy(trans);
 				break;
 			}
 			te = nft_trans_container_elem(trans);
-			if (!te->set->ops->abort ||
-			    nft_setelem_is_catchall(te->set, te->elem_priv))
-				nft_setelem_remove(net, te->set, te->elem_priv);
-
-			if (!nft_setelem_is_catchall(te->set, te->elem_priv))
-				atomic_dec(&te->set->nelems);
+			if (!nft_trans_elems_new_abort(&ctx, te)) {
+				nft_trans_destroy(trans);
+				break;
+			}
 
 			if (te->set->ops->abort &&
 			    list_empty(&te->set->pending_update)) {
@@ -10859,12 +10961,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		case NFT_MSG_DESTROYSETELEM:
 			te = nft_trans_container_elem(trans);
 
-			if (!nft_setelem_active_next(net, te->set, te->elem_priv)) {
-				nft_setelem_data_activate(net, te->set, te->elem_priv);
-				nft_setelem_activate(net, te->set, te->elem_priv);
-			}
-			if (!nft_setelem_is_catchall(te->set, te->elem_priv))
-				te->set->ndeact--;
+			nft_trans_elems_destroy_abort(&ctx, te);
 
 			if (te->set->ops->abort &&
 			    list_empty(&te->set->pending_update)) {
-- 
2.30.2


