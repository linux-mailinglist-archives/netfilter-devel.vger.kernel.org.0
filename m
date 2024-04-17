Return-Path: <netfilter-devel+bounces-1834-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7528A880C
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Apr 2024 17:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339A9283B18
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Apr 2024 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52120147C8A;
	Wed, 17 Apr 2024 15:48:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F638DEC
	for <netfilter-devel@vger.kernel.org>; Wed, 17 Apr 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368933; cv=none; b=fVl1O3zMxnUUY2oiQpmxJPdjJmC8Y6KIu3y7TEf5O/pcKgmCJcHmqxVr1ENLQApjDK0gYi8ET4PQmd5xXyVnc4oPzRZQMncbL+l8iUN3K9JUPvgygMMKPkmIO6CTWv5miXErkmKhAJzvhAYdtvwWhFIIwZQAm1ei9VRu/6lvSkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368933; c=relaxed/simple;
	bh=KSoFhHw+LWc2kl3v1ksuxSC+6er4Sc5hj6/i55s786M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BcN4HpR5utGw4ywrLKDnjWLqALDQH7X0BxXkx6uDt1GW2+54nBPGeM0vW6q/hlZglKl07r2rzTW+rcWcDT6WRrcdqpyjcRS80XxbfgfM4lHtyU9RZHhlEt852i+OV+9w4dPgB6PmE28lAJIbONv+CPG/Ep8x6v1qW76foycZ9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf 2/3] netfilter: nf_tables: restore set elements when delete set fails
Date: Wed, 17 Apr 2024 17:48:37 +0200
Message-Id: <20240417154838.2047344-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240417154838.2047344-1-pablo@netfilter.org>
References: <20240417154838.2047344-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From abort path, nft_mapelem_activate() needs to restore refcounters to
the original state. Currently, it uses the set->ops->walk() to iterate
over these set elements. The existing set iterator skips inactive
elements in the next generation, this does not work from the abort path
to restore the original state since it has to skip active elements
instead (not inactive ones).

This patch moves the check for inactive elements to the set iterator
callback, then it reverses the logic for the .activate case which
needs to skip active elements.

Toggle next generation bit for elements when delete set command is
invoked and call nft_clear() from .activate (abort) path to restore the
next generation bit.

The splat below shows an object in mappings memleak:

[43929.457523] ------------[ cut here ]------------
[43929.457532] WARNING: CPU: 0 PID: 1139 at include/net/netfilter/nf_tables.h:1237 nft_setelem_data_deactivate+0xe4/0xf0 [nf_tables]
[...]
[43929.458014] RIP: 0010:nft_setelem_data_deactivate+0xe4/0xf0 [nf_tables]
[43929.458076] Code: 83 f8 01 77 ab 49 8d 7c 24 08 e8 37 5e d0 de 49 8b 6c 24 08 48 8d 7d 50 e8 e9 5c d0 de 8b 45 50 8d 50 ff 89 55 50 85 c0 75 86 <0f> 0b eb 82 0f 0b eb b3 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90
[43929.458081] RSP: 0018:ffff888140f9f4b0 EFLAGS: 00010246
[43929.458086] RAX: 0000000000000000 RBX: ffff8881434f5288 RCX: dffffc0000000000
[43929.458090] RDX: 00000000ffffffff RSI: ffffffffa26d28a7 RDI: ffff88810ecc9550
[43929.458093] RBP: ffff88810ecc9500 R08: 0000000000000001 R09: ffffed10281f3e8f
[43929.458096] R10: 0000000000000003 R11: ffff0000ffff0000 R12: ffff8881434f52a0
[43929.458100] R13: ffff888140f9f5f4 R14: ffff888151c7a800 R15: 0000000000000002
[43929.458103] FS:  00007f0c687c4740(0000) GS:ffff888390800000(0000) knlGS:0000000000000000
[43929.458107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[43929.458111] CR2: 00007f58dbe5b008 CR3: 0000000123602005 CR4: 00000000001706f0
[43929.458114] Call Trace:
[43929.458118]  <TASK>
[43929.458121]  ? __warn+0x9f/0x1a0
[43929.458127]  ? nft_setelem_data_deactivate+0xe4/0xf0 [nf_tables]
[43929.458188]  ? report_bug+0x1b1/0x1e0
[43929.458196]  ? handle_bug+0x3c/0x70
[43929.458200]  ? exc_invalid_op+0x17/0x40
[43929.458211]  ? nft_setelem_data_deactivate+0xd7/0xf0 [nf_tables]
[43929.458271]  ? nft_setelem_data_deactivate+0xe4/0xf0 [nf_tables]
[43929.458332]  nft_mapelem_deactivate+0x24/0x30 [nf_tables]
[43929.458392]  nft_rhash_walk+0xdd/0x180 [nf_tables]
[43929.458453]  ? __pfx_nft_rhash_walk+0x10/0x10 [nf_tables]
[43929.458512]  ? rb_insert_color+0x2e/0x280
[43929.458520]  nft_map_deactivate+0xdc/0x1e0 [nf_tables]
[43929.458582]  ? __pfx_nft_map_deactivate+0x10/0x10 [nf_tables]
[43929.458642]  ? __pfx_nft_mapelem_deactivate+0x10/0x10 [nf_tables]
[43929.458701]  ? __rcu_read_unlock+0x46/0x70
[43929.458709]  nft_delset+0xff/0x110 [nf_tables]
[43929.458769]  nft_flush_table+0x16f/0x460 [nf_tables]
[43929.458830]  nf_tables_deltable+0x501/0x580 [nf_tables]

Fixes: 628bd3e49cba ("netfilter: nf_tables: drop map element references from preparation phase")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c  | 44 ++++++++++++++++++++++++++++++----
 net/netfilter/nft_set_bitmap.c |  4 +---
 net/netfilter/nft_set_hash.c   |  8 ++-----
 net/netfilter/nft_set_pipapo.c |  5 +---
 net/netfilter/nft_set_rbtree.c |  4 +---
 5 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a7a34db62ea9..d0c09f899e80 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -594,6 +594,12 @@ static int nft_mapelem_deactivate(const struct nft_ctx *ctx,
 				  const struct nft_set_iter *iter,
 				  struct nft_elem_priv *elem_priv)
 {
+	struct nft_set_ext *ext = nft_set_elem_ext(set, elem_priv);
+
+	if (!nft_set_elem_active(ext, iter->genmask))
+		return 0;
+
+	nft_set_elem_change_active(ctx->net, set, ext);
 	nft_setelem_data_deactivate(ctx->net, set, elem_priv);
 
 	return 0;
@@ -617,6 +623,7 @@ static void nft_map_catchall_deactivate(const struct nft_ctx *ctx,
 		if (!nft_set_elem_active(ext, genmask))
 			continue;
 
+		nft_set_elem_change_active(ctx->net, set, ext);
 		nft_setelem_data_deactivate(ctx->net, set, catchall->elem);
 		break;
 	}
@@ -3880,6 +3887,9 @@ int nft_setelem_validate(const struct nft_ctx *ctx, struct nft_set *set,
 	const struct nft_data *data;
 	int err;
 
+	if (!nft_set_elem_active(ext, iter->genmask))
+		return 0;
+
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_FLAGS) &&
 	    *nft_set_ext_flags(ext) & NFT_SET_ELEM_INTERVAL_END)
 		return 0;
@@ -3903,17 +3913,20 @@ int nft_setelem_validate(const struct nft_ctx *ctx, struct nft_set *set,
 
 int nft_set_catchall_validate(const struct nft_ctx *ctx, struct nft_set *set)
 {
-	u8 genmask = nft_genmask_next(ctx->net);
+	struct nft_set_iter dummy_iter = {
+		.genmask	= nft_genmask_next(ctx->net),
+	};
 	struct nft_set_elem_catchall *catchall;
+
 	struct nft_set_ext *ext;
 	int ret = 0;
 
 	list_for_each_entry_rcu(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (!nft_set_elem_active(ext, genmask))
+		if (!nft_set_elem_active(ext, dummy_iter.genmask))
 			continue;
 
-		ret = nft_setelem_validate(ctx, set, NULL, catchall->elem);
+		ret = nft_setelem_validate(ctx, set, &dummy_iter, catchall->elem);
 		if (ret < 0)
 			return ret;
 	}
@@ -5402,6 +5415,11 @@ static int nf_tables_bind_check_setelem(const struct nft_ctx *ctx,
 					const struct nft_set_iter *iter,
 					struct nft_elem_priv *elem_priv)
 {
+	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem_priv);
+
+	if (!nft_set_elem_active(ext, iter->genmask))
+		return 0;
+
 	return nft_setelem_data_validate(ctx, set, elem_priv);
 }
 
@@ -5494,6 +5512,13 @@ static int nft_mapelem_activate(const struct nft_ctx *ctx,
 				const struct nft_set_iter *iter,
 				struct nft_elem_priv *elem_priv)
 {
+	struct nft_set_ext *ext = nft_set_elem_ext(set, elem_priv);
+
+	/* called from abort path, reverse check to undo changes. */
+	if (nft_set_elem_active(ext, iter->genmask))
+		return 0;
+
+	nft_clear(ctx->net, ext);
 	nft_setelem_data_activate(ctx->net, set, elem_priv);
 
 	return 0;
@@ -5511,6 +5536,7 @@ static void nft_map_catchall_activate(const struct nft_ctx *ctx,
 		if (!nft_set_elem_active(ext, genmask))
 			continue;
 
+		nft_clear(ctx->net, ext);
 		nft_setelem_data_activate(ctx->net, set, catchall->elem);
 		break;
 	}
@@ -5785,6 +5811,9 @@ static int nf_tables_dump_setelem(const struct nft_ctx *ctx,
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem_priv);
 	struct nft_set_dump_args *args;
 
+	if (!nft_set_elem_active(ext, iter->genmask))
+		return 0;
+
 	if (nft_set_elem_expired(ext) || nft_set_elem_is_dead(ext))
 		return 0;
 
@@ -6635,7 +6664,7 @@ static void nft_setelem_activate(struct net *net, struct nft_set *set,
 	struct nft_set_ext *ext = nft_set_elem_ext(set, elem_priv);
 
 	if (nft_setelem_is_catchall(set, elem_priv)) {
-		nft_set_elem_change_active(net, set, ext);
+		nft_clear(net, ext);
 	} else {
 		set->ops->activate(net, set, elem_priv);
 	}
@@ -7317,8 +7346,12 @@ static int nft_setelem_flush(const struct nft_ctx *ctx,
 			     const struct nft_set_iter *iter,
 			     struct nft_elem_priv *elem_priv)
 {
+	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem_priv);
 	struct nft_trans *trans;
 
+	if (!nft_set_elem_active(ext, iter->genmask))
+		return 0;
+
 	trans = nft_trans_alloc_gfp(ctx, NFT_MSG_DELSETELEM,
 				    sizeof(struct nft_trans_elem), GFP_ATOMIC);
 	if (!trans)
@@ -10800,6 +10833,9 @@ static int nf_tables_loop_check_setelem(const struct nft_ctx *ctx,
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem_priv);
 
+	if (!nft_set_elem_active(ext, iter->genmask))
+		return 0;
+
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_FLAGS) &&
 	    *nft_set_ext_flags(ext) & NFT_SET_ELEM_INTERVAL_END)
 		return 0;
diff --git a/net/netfilter/nft_set_bitmap.c b/net/netfilter/nft_set_bitmap.c
index 32df7a16835d..1caa04619dc6 100644
--- a/net/netfilter/nft_set_bitmap.c
+++ b/net/netfilter/nft_set_bitmap.c
@@ -172,7 +172,7 @@ static void nft_bitmap_activate(const struct net *net,
 	nft_bitmap_location(set, nft_set_ext_key(&be->ext), &idx, &off);
 	/* Enter 11 state. */
 	priv->bitmap[idx] |= (genmask << off);
-	nft_set_elem_change_active(net, set, &be->ext);
+	nft_clear(net, &be->ext);
 }
 
 static void nft_bitmap_flush(const struct net *net,
@@ -222,8 +222,6 @@ static void nft_bitmap_walk(const struct nft_ctx *ctx,
 	list_for_each_entry_rcu(be, &priv->list, head) {
 		if (iter->count < iter->skip)
 			goto cont;
-		if (!nft_set_elem_active(&be->ext, iter->genmask))
-			goto cont;
 
 		iter->err = iter->fn(ctx, set, iter, &be->priv);
 
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 6968a3b34236..daa56dda737a 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -199,7 +199,7 @@ static void nft_rhash_activate(const struct net *net, const struct nft_set *set,
 {
 	struct nft_rhash_elem *he = nft_elem_priv_cast(elem_priv);
 
-	nft_set_elem_change_active(net, set, &he->ext);
+	nft_clear(net, &he->ext);
 }
 
 static void nft_rhash_flush(const struct net *net,
@@ -286,8 +286,6 @@ static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 		if (iter->count < iter->skip)
 			goto cont;
-		if (!nft_set_elem_active(&he->ext, iter->genmask))
-			goto cont;
 
 		iter->err = iter->fn(ctx, set, iter, &he->priv);
 		if (iter->err < 0)
@@ -599,7 +597,7 @@ static void nft_hash_activate(const struct net *net, const struct nft_set *set,
 {
 	struct nft_hash_elem *he = nft_elem_priv_cast(elem_priv);
 
-	nft_set_elem_change_active(net, set, &he->ext);
+	nft_clear(net, &he->ext);
 }
 
 static void nft_hash_flush(const struct net *net,
@@ -652,8 +650,6 @@ static void nft_hash_walk(const struct nft_ctx *ctx, struct nft_set *set,
 		hlist_for_each_entry_rcu(he, &priv->table[i], node) {
 			if (iter->count < iter->skip)
 				goto cont;
-			if (!nft_set_elem_active(&he->ext, iter->genmask))
-				goto cont;
 
 			iter->err = iter->fn(ctx, set, iter, &he->priv);
 			if (iter->err < 0)
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 0f903d18bbea..187138afac45 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1847,7 +1847,7 @@ static void nft_pipapo_activate(const struct net *net,
 {
 	struct nft_pipapo_elem *e = nft_elem_priv_cast(elem_priv);
 
-	nft_set_elem_change_active(net, set, &e->ext);
+	nft_clear(net, &e->ext);
 }
 
 /**
@@ -2149,9 +2149,6 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 		e = f->mt[r].e;
 
-		if (!nft_set_elem_active(&e->ext, iter->genmask))
-			goto cont;
-
 		iter->err = iter->fn(ctx, set, iter, &e->priv);
 		if (iter->err < 0)
 			goto out;
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 9944fe479e53..b7ea21327549 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -532,7 +532,7 @@ static void nft_rbtree_activate(const struct net *net,
 {
 	struct nft_rbtree_elem *rbe = nft_elem_priv_cast(elem_priv);
 
-	nft_set_elem_change_active(net, set, &rbe->ext);
+	nft_clear(net, &rbe->ext);
 }
 
 static void nft_rbtree_flush(const struct net *net,
@@ -600,8 +600,6 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
 
 		if (iter->count < iter->skip)
 			goto cont;
-		if (!nft_set_elem_active(&rbe->ext, iter->genmask))
-			goto cont;
 
 		iter->err = iter->fn(ctx, set, iter, &rbe->priv);
 		if (iter->err < 0) {
-- 
2.30.2


