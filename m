Return-Path: <netfilter-devel+bounces-5022-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546AC9C0D31
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Nov 2024 18:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D9028428B
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Nov 2024 17:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610231917E6;
	Thu,  7 Nov 2024 17:47:00 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5323216E0D
	for <netfilter-devel@vger.kernel.org>; Thu,  7 Nov 2024 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001620; cv=none; b=XCNJe0iU1YmodsUtKQ1wjYIkavQNc9peNfMQABkIWh1cXxi5bvFupSQ6y5d4wCuzL3QVkL+draGcJ3rraKOciXlpe2btY54mpa5kejhNXpGB4goMW8AtwIn8s6YzxDHujhg8EscFt8VBqPcnP2E9Mmxa1Nc9iw20aBb5OlYBLY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001620; c=relaxed/simple;
	bh=nMsBjNQFEMT9WK4Nib0PzrzQt7ghYoXsZfFuvrfGaPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkZ64Qbf1s8oKi4Rt6zFxUTtCISEbkr00J/Zs7/YLXuHzx3TxwzoS1HCf+1gVekd/hGq/796jOwPBhIJFi7LVP2AMxskUqBV4zrTQ/PtoEQOp30MOubBsEasdxdv221qMqxMa6+nlctom9l9p+lx9jCdmK4/pUklkmnKbIxPKO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1t96au-0007Li-V4; Thu, 07 Nov 2024 18:46:56 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v4 5/5] netfilter: nf_tables: allocate element update information dynamically
Date: Thu,  7 Nov 2024 18:44:09 +0100
Message-ID: <20241107174415.4690-6-fw@strlen.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107174415.4690-1-fw@strlen.de>
References: <20241107174415.4690-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the timeout/expire/flag members from nft_trans_one_elem struct into
a dybamically allocated structure, only needed when timeout update was
requested.

This halves size of nft_trans_one_elem struct and allows to compact up to
124 elements in one transaction container rather than 62.

This halves memory requirements for a large flush or insert transaction,
where ->update remains NULL.

Care has to be taken to release the extra data in all spots, including
abort path.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_tables.h | 10 ++++--
 net/netfilter/nf_tables_api.c     | 57 +++++++++++++++++++------------
 2 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 14ccf1133a4c..4afa64c81304 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1755,11 +1755,15 @@ enum nft_trans_elem_flags {
 	NFT_TRANS_UPD_EXPIRATION	= (1 << 1),
 };
 
-struct nft_trans_one_elem {
-	struct nft_elem_priv		*priv;
+struct nft_elem_update {
 	u64				timeout;
 	u64				expiration;
-	u8				update_flags;
+	u8				flags;
+};
+
+struct nft_trans_one_elem {
+	struct nft_elem_priv		*priv;
+	struct nft_elem_update		*update;
 };
 
 struct nft_trans_elem {
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e96e538fe2eb..95dc814a9059 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6686,7 +6686,8 @@ static void nft_trans_set_elem_destroy(const struct nft_ctx *ctx, struct nft_tra
 	int i;
 
 	for (i = 0; i < te->nelems; i++) {
-		if (te->elems[i].update_flags)
+		/* skip update request, see nft_trans_elems_new_abort() */
+		if (!te->elems[i].priv)
 			continue;
 
 		__nft_set_elem_destroy(ctx, te->set, te->elems[i].priv, true);
@@ -6877,12 +6878,13 @@ static void nft_trans_elem_update(const struct nft_set *set,
 				  const struct nft_trans_one_elem *elem)
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
+	const struct nft_elem_update *update = elem->update;
 
-	if (elem->update_flags & NFT_TRANS_UPD_TIMEOUT)
-		WRITE_ONCE(nft_set_ext_timeout(ext)->timeout, elem->timeout);
+	if (update->flags & NFT_TRANS_UPD_TIMEOUT)
+		WRITE_ONCE(nft_set_ext_timeout(ext)->timeout, update->timeout);
 
-	if (elem->update_flags & NFT_TRANS_UPD_EXPIRATION)
-		WRITE_ONCE(nft_set_ext_timeout(ext)->expiration, get_jiffies_64() + elem->expiration);
+	if (update->flags & NFT_TRANS_UPD_EXPIRATION)
+		WRITE_ONCE(nft_set_ext_timeout(ext)->expiration, get_jiffies_64() + update->expiration);
 }
 
 static void nft_trans_elems_add(const struct nft_ctx *ctx,
@@ -6891,15 +6893,16 @@ static void nft_trans_elems_add(const struct nft_ctx *ctx,
 	int i;
 
 	for (i = 0; i < te->nelems; i++) {
-		const struct nft_trans_one_elem *elem = &te->elems[i];
+		struct nft_trans_one_elem *elem = &te->elems[i];
 
-		if (elem->update_flags)
+		if (elem->update)
 			nft_trans_elem_update(te->set, elem);
 		else
 			nft_setelem_activate(ctx->net, te->set, elem->priv);
 
 		nf_tables_setelem_notify(ctx, te->set, elem->priv,
 					 NFT_MSG_NEWSETELEM);
+		kfree(elem->update);
 	}
 }
 
@@ -6991,6 +6994,8 @@ static void nft_trans_elems_remove(const struct nft_ctx *ctx,
 	int i;
 
 	for (i = 0; i < te->nelems; i++) {
+		WARN_ON_ONCE(te->elems[i].update);
+
 		nf_tables_setelem_notify(ctx, te->set,
 					 te->elems[i].priv,
 					 te->nft_trans.msg_type);
@@ -7039,7 +7044,6 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	struct nft_data_desc desc;
 	enum nft_registers dreg;
 	struct nft_trans *trans;
-	u8 update_flags;
 	u64 expiration;
 	u64 timeout;
 	int err, i;
@@ -7354,26 +7358,32 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			else if (!(nlmsg_flags & NLM_F_EXCL)) {
 				err = 0;
 				if (nft_set_ext_exists(ext2, NFT_SET_EXT_TIMEOUT)) {
-					struct nft_trans_one_elem *update;
-
-					update = &nft_trans_container_elem(trans)->elems[0];
+					struct nft_elem_update update = { };
 
-					update_flags = 0;
 					if (timeout != nft_set_ext_timeout(ext2)->timeout) {
-						update->timeout = timeout;
+						update.timeout = timeout;
 						if (expiration == 0)
 							expiration = timeout;
 
-						update_flags |= NFT_TRANS_UPD_TIMEOUT;
+						update.flags |= NFT_TRANS_UPD_TIMEOUT;
 					}
 					if (expiration) {
-						update->expiration = expiration;
-						update_flags |= NFT_TRANS_UPD_EXPIRATION;
+						update.expiration = expiration;
+						update.flags |= NFT_TRANS_UPD_EXPIRATION;
 					}
 
-					if (update_flags) {
-						update->priv = elem_priv;
-						update->update_flags = update_flags;
+					if (update.flags) {
+						struct nft_trans_one_elem *ue;
+
+						ue = &nft_trans_container_elem(trans)->elems[0];
+
+						ue->update = kmemdup(&update, sizeof(update), GFP_KERNEL);
+						if (!ue->update) {
+							err = -ENOMEM;
+							goto err_element_clash;
+						}
+
+						ue->priv = elem_priv;
 						nft_trans_commit_list_add_elem(ctx->net, trans, GFP_KERNEL);
 						goto err_elem_free;
 					}
@@ -7541,14 +7551,19 @@ void nft_setelem_data_deactivate(const struct net *net,
  * Returns true if set had been added to (i.e., elements need to be removed again).
  */
 static bool nft_trans_elems_new_abort(const struct nft_ctx *ctx,
-				      const struct nft_trans_elem *te)
+				      struct nft_trans_elem *te)
 {
 	bool removed = false;
 	int i;
 
 	for (i = 0; i < te->nelems; i++) {
-		if (te->elems[i].update_flags)
+		if (te->elems[i].update) {
+			kfree(te->elems[i].update);
+			te->elems[i].update = NULL;
+			/* Update request, so do not release this element */
+			te->elems[i].priv = NULL;
 			continue;
+		}
 
 		if (!te->set->ops->abort || nft_setelem_is_catchall(te->set, te->elems[i].priv))
 			nft_setelem_remove(ctx->net, te->set, te->elems[i].priv);
-- 
2.45.2


