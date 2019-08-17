Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29ABC91041
	for <lists+netfilter-devel@lfdr.de>; Sat, 17 Aug 2019 13:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfHQL1F (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 17 Aug 2019 07:27:05 -0400
Received: from vxsys-smtpclusterma-02.srv.cat ([46.16.60.194]:47227 "EHLO
        vxsys-smtpclusterma-02.srv.cat" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725889AbfHQL1F (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 17 Aug 2019 07:27:05 -0400
Received: from localhost.localdomain (static-79-171-230-77.ipcom.comunitel.net [77.230.171.79])
        by vxsys-smtpclusterma-02.srv.cat (Postfix) with ESMTPA id E03EA24229
        for <netfilter-devel@vger.kernel.org>; Sat, 17 Aug 2019 13:26:59 +0200 (CEST)
From:   Ander Juaristi <a@juaristi.eus>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH v4] netfilter: nft_dynset: support for element deletion
Date:   Sat, 17 Aug 2019 13:26:52 +0200
Message-Id: <20190817112652.9413-1-a@juaristi.eus>
X-Mailer: git-send-email 2.17.1
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch implements the delete operation from the ruleset.

It implements a new delete() function in nft_set_rhash. It is simpler
to use than the already existing remove(), because it only takes the set
and the key as arguments, whereas remove() expects a full
nft_set_elem structure.

Signed-off-by: Ander Juaristi <a@juaristi.eus>
---
 include/net/netfilter/nf_tables.h        | 10 +++++++++-
 include/uapi/linux/netfilter/nf_tables.h |  1 +
 net/netfilter/nft_dynset.c               |  7 +++++++
 net/netfilter/nft_set_hash.c             | 19 +++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 9e8493aad49d..d1f02f89913f 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -287,17 +287,23 @@ struct nft_expr;
  *	struct nft_set_ops - nf_tables set operations
  *
  *	@lookup: look up an element within the set
+ *	@update: update an element if exists, add it if doesn't exist
+ *	@delete: delete an element
  *	@insert: insert new element into set
  *	@activate: activate new element in the next generation
  *	@deactivate: lookup for element and deactivate it in the next generation
  *	@flush: deactivate element in the next generation
  *	@remove: remove element from set
- *	@walk: iterate over all set elemeennts
+ *	@walk: iterate over all set elements
  *	@get: get set elements
  *	@privsize: function to return size of set private data
  *	@init: initialize private data of new set instance
  *	@destroy: destroy private data of set instance
  *	@elemsize: element private size
+ *
+ *	Operations lookup, update and delete have simpler interfaces, are faster
+ *	and currently only used in the packet path. All the rest are slower,
+ *	control plane functions.
  */
 struct nft_set_ops {
 	bool				(*lookup)(const struct net *net,
@@ -312,6 +318,8 @@ struct nft_set_ops {
 						  const struct nft_expr *expr,
 						  struct nft_regs *regs,
 						  const struct nft_set_ext **ext);
+	bool				(*delete)(const struct nft_set *set,
+						  const u32 *key);
 
 	int				(*insert)(const struct net *net,
 						  const struct nft_set *set,
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index c6c8ec5c7c00..e8483e1e7146 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -634,6 +634,7 @@ enum nft_lookup_attributes {
 enum nft_dynset_ops {
 	NFT_DYNSET_OP_ADD,
 	NFT_DYNSET_OP_UPDATE,
+	NFT_DYNSET_OP_DELETE,
 };
 
 enum nft_dynset_flags {
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index bfb9f7463b03..eeab38359469 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -88,6 +88,11 @@ void nft_dynset_eval(const struct nft_expr *expr,
 	const struct nft_expr *sexpr;
 	u64 timeout;
 
+	if (priv->op == NFT_DYNSET_OP_DELETE) {
+		set->ops->delete(set, &regs->data[priv->sreg_key]);
+		return;
+	}
+
 	if (set->ops->update(set, &regs->data[priv->sreg_key], nft_dynset_new,
 			     expr, regs, &ext)) {
 		sexpr = NULL;
@@ -105,6 +110,7 @@ void nft_dynset_eval(const struct nft_expr *expr,
 
 		if (priv->invert)
 			regs->verdict.code = NFT_BREAK;
+
 		return;
 	}
 
@@ -165,6 +171,7 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 	priv->op = ntohl(nla_get_be32(tb[NFTA_DYNSET_OP]));
 	switch (priv->op) {
 	case NFT_DYNSET_OP_ADD:
+	case NFT_DYNSET_OP_DELETE:
 		break;
 	case NFT_DYNSET_OP_UPDATE:
 		if (!(set->flags & NFT_SET_TIMEOUT))
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 03df08801e28..07499296f673 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -237,6 +237,24 @@ static void nft_rhash_remove(const struct net *net,
 	rhashtable_remove_fast(&priv->ht, &he->node, nft_rhash_params);
 }
 
+static bool nft_rhash_delete(const struct nft_set *set,
+			     const u32 *key)
+{
+	struct nft_rhash *priv = nft_set_priv(set);
+	struct nft_rhash_elem *he;
+	struct nft_rhash_cmp_arg arg = {
+		.genmask = NFT_GENMASK_ANY,
+		.set = set,
+		.key = key,
+	};
+
+	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
+	if (he == NULL)
+		return false;
+
+	return rhashtable_remove_fast(&priv->ht, &he->node, nft_rhash_params) == 0;
+}
+
 static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
 			   struct nft_set_iter *iter)
 {
@@ -665,6 +683,7 @@ struct nft_set_type nft_set_rhash_type __read_mostly = {
 		.remove		= nft_rhash_remove,
 		.lookup		= nft_rhash_lookup,
 		.update		= nft_rhash_update,
+		.delete		= nft_rhash_delete,
 		.walk		= nft_rhash_walk,
 		.get		= nft_rhash_get,
 	},
-- 
2.17.1

