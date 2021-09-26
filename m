Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEBB418826
	for <lists+netfilter-devel@lfdr.de>; Sun, 26 Sep 2021 12:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhIZKur (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 26 Sep 2021 06:50:47 -0400
Received: from mail.netfilter.org ([217.70.188.207]:52568 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhIZKuq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 26 Sep 2021 06:50:46 -0400
Received: from localhost.localdomain (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 231C460081
        for <netfilter-devel@vger.kernel.org>; Sun, 26 Sep 2021 12:47:47 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables: honor NLM_F_CREATE and NLM_F_EXCL in event notification
Date:   Sun, 26 Sep 2021 12:49:04 +0200
Message-Id: <20210926104904.5540-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Include the NLM_F_CREATE and NLM_F_EXCL flags in netlink event
notifications, otherwise userspace cannot distiguish between create and
add commands.

Fixes: 96518518cc41 ("netfilter: add nftables")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h |  2 +-
 net/netfilter/nf_tables_api.c     | 57 ++++++++++++++++++++++++-------
 net/netfilter/nft_quota.c         |  2 +-
 3 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 148f5d8ee5ab..a16171c5fd9e 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1202,7 +1202,7 @@ struct nft_object *nft_obj_lookup(const struct net *net,
 
 void nft_obj_notify(struct net *net, const struct nft_table *table,
 		    struct nft_object *obj, u32 portid, u32 seq,
-		    int event, int family, int report, gfp_t gfp);
+		    int event, u16 flags, int family, int report, gfp_t gfp);
 
 /**
  *	struct nft_object_type - stateful object type
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c8acd26c7201..2b668ba6af76 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -780,6 +780,7 @@ static void nf_tables_table_notify(const struct nft_ctx *ctx, int event)
 {
 	struct nftables_pernet *nft_net;
 	struct sk_buff *skb;
+	u16 flags = 0;
 	int err;
 
 	if (!ctx->report &&
@@ -790,8 +791,13 @@ static void nf_tables_table_notify(const struct nft_ctx *ctx, int event)
 	if (skb == NULL)
 		goto err;
 
+	if (ctx->flags & NLM_F_CREATE)
+		flags |= NLM_F_CREATE;
+	if (ctx->flags & NLM_F_EXCL)
+		flags |= NLM_F_EXCL;
+
 	err = nf_tables_fill_table_info(skb, ctx->net, ctx->portid, ctx->seq,
-					event, 0, ctx->family, ctx->table);
+					event, flags, ctx->family, ctx->table);
 	if (err < 0) {
 		kfree_skb(skb);
 		goto err;
@@ -1563,6 +1569,7 @@ static void nf_tables_chain_notify(const struct nft_ctx *ctx, int event)
 {
 	struct nftables_pernet *nft_net;
 	struct sk_buff *skb;
+	u16 flags = 0;
 	int err;
 
 	if (!ctx->report &&
@@ -1573,8 +1580,13 @@ static void nf_tables_chain_notify(const struct nft_ctx *ctx, int event)
 	if (skb == NULL)
 		goto err;
 
+	if (ctx->flags & NLM_F_CREATE)
+		flags |= NLM_F_CREATE;
+	if (ctx->flags & NLM_F_EXCL)
+		flags |= NLM_F_EXCL;
+
 	err = nf_tables_fill_chain_info(skb, ctx->net, ctx->portid, ctx->seq,
-					event, 0, ctx->family, ctx->table,
+					event, flags, ctx->family, ctx->table,
 					ctx->chain);
 	if (err < 0) {
 		kfree_skb(skb);
@@ -2945,6 +2957,8 @@ static void nf_tables_rule_notify(const struct nft_ctx *ctx,
 	}
 	if (ctx->flags & (NLM_F_APPEND | NLM_F_REPLACE))
 		flags |= NLM_F_APPEND;
+	if (ctx->flags & NLM_F_CREATE)
+		flags |= NLM_F_CREATE;
 
 	err = nf_tables_fill_rule_info(skb, ctx->net, ctx->portid, ctx->seq,
 				       event, flags, ctx->family, ctx->table,
@@ -3957,8 +3971,9 @@ static void nf_tables_set_notify(const struct nft_ctx *ctx,
 			         gfp_t gfp_flags)
 {
 	struct nftables_pernet *nft_net = nft_pernet(ctx->net);
-	struct sk_buff *skb;
 	u32 portid = ctx->portid;
+	struct sk_buff *skb;
+	u16 flags = 0;
 	int err;
 
 	if (!ctx->report &&
@@ -3969,7 +3984,12 @@ static void nf_tables_set_notify(const struct nft_ctx *ctx,
 	if (skb == NULL)
 		goto err;
 
-	err = nf_tables_fill_set(skb, ctx, set, event, 0);
+	if (ctx->flags & NLM_F_CREATE)
+		flags |= NLM_F_CREATE;
+	if (ctx->flags & NLM_F_EXCL)
+		flags |= NLM_F_EXCL;
+
+	err = nf_tables_fill_set(skb, ctx, set, event, flags);
 	if (err < 0) {
 		kfree_skb(skb);
 		goto err;
@@ -5245,12 +5265,13 @@ static int nf_tables_getsetelem(struct sk_buff *skb,
 static void nf_tables_setelem_notify(const struct nft_ctx *ctx,
 				     const struct nft_set *set,
 				     const struct nft_set_elem *elem,
-				     int event, u16 flags)
+				     int event)
 {
 	struct nftables_pernet *nft_net;
 	struct net *net = ctx->net;
 	u32 portid = ctx->portid;
 	struct sk_buff *skb;
+	u16 flags = 0;
 	int err;
 
 	if (!ctx->report && !nfnetlink_has_listeners(net, NFNLGRP_NFTABLES))
@@ -5260,6 +5281,11 @@ static void nf_tables_setelem_notify(const struct nft_ctx *ctx,
 	if (skb == NULL)
 		goto err;
 
+	if (ctx->flags & NLM_F_CREATE)
+		flags |= NLM_F_CREATE;
+	if (ctx->flags & NLM_F_EXCL)
+		flags |= NLM_F_EXCL;
+
 	err = nf_tables_fill_setelem_info(skb, ctx, 0, portid, event, flags,
 					  set, elem);
 	if (err < 0) {
@@ -6935,7 +6961,7 @@ static int nf_tables_delobj(struct sk_buff *skb, const struct nfnl_info *info,
 
 void nft_obj_notify(struct net *net, const struct nft_table *table,
 		    struct nft_object *obj, u32 portid, u32 seq, int event,
-		    int family, int report, gfp_t gfp)
+		    u16 flags, int family, int report, gfp_t gfp)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 	struct sk_buff *skb;
@@ -6960,8 +6986,9 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 	if (skb == NULL)
 		goto err;
 
-	err = nf_tables_fill_obj_info(skb, net, portid, seq, event, 0, family,
-				      table, obj, false);
+	err = nf_tables_fill_obj_info(skb, net, portid, seq, event,
+				      flags & (NLM_F_CREATE | NLM_F_EXCL),
+				      family, table, obj, false);
 	if (err < 0) {
 		kfree_skb(skb);
 		goto err;
@@ -6978,7 +7005,7 @@ static void nf_tables_obj_notify(const struct nft_ctx *ctx,
 				 struct nft_object *obj, int event)
 {
 	nft_obj_notify(ctx->net, ctx->table, obj, ctx->portid, ctx->seq, event,
-		       ctx->family, ctx->report, GFP_KERNEL);
+		       ctx->flags, ctx->family, ctx->report, GFP_KERNEL);
 }
 
 /*
@@ -7759,6 +7786,7 @@ static void nf_tables_flowtable_notify(struct nft_ctx *ctx,
 {
 	struct nftables_pernet *nft_net = nft_pernet(ctx->net);
 	struct sk_buff *skb;
+	u16 flags = 0;
 	int err;
 
 	if (!ctx->report &&
@@ -7769,8 +7797,13 @@ static void nf_tables_flowtable_notify(struct nft_ctx *ctx,
 	if (skb == NULL)
 		goto err;
 
+	if (ctx->flags & NLM_F_CREATE)
+		flags |= NLM_F_CREATE;
+	if (ctx->flags & NLM_F_EXCL)
+		flags |= NLM_F_EXCL;
+
 	err = nf_tables_fill_flowtable_info(skb, ctx->net, ctx->portid,
-					    ctx->seq, event, 0,
+					    ctx->seq, event, flags,
 					    ctx->family, flowtable, hook_list);
 	if (err < 0) {
 		kfree_skb(skb);
@@ -8648,7 +8681,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			nft_setelem_activate(net, te->set, &te->elem);
 			nf_tables_setelem_notify(&trans->ctx, te->set,
 						 &te->elem,
-						 NFT_MSG_NEWSETELEM, 0);
+						 NFT_MSG_NEWSETELEM);
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_DELSETELEM:
@@ -8656,7 +8689,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 
 			nf_tables_setelem_notify(&trans->ctx, te->set,
 						 &te->elem,
-						 NFT_MSG_DELSETELEM, 0);
+						 NFT_MSG_DELSETELEM);
 			nft_setelem_remove(net, te->set, &te->elem);
 			if (!nft_setelem_is_catchall(te->set, &te->elem)) {
 				atomic_dec(&te->set->nelems);
diff --git a/net/netfilter/nft_quota.c b/net/netfilter/nft_quota.c
index 0363f533a42b..c4d1389f7185 100644
--- a/net/netfilter/nft_quota.c
+++ b/net/netfilter/nft_quota.c
@@ -60,7 +60,7 @@ static void nft_quota_obj_eval(struct nft_object *obj,
 	if (overquota &&
 	    !test_and_set_bit(NFT_QUOTA_DEPLETED_BIT, &priv->flags))
 		nft_obj_notify(nft_net(pkt), obj->key.table, obj, 0, 0,
-			       NFT_MSG_NEWOBJ, nft_pf(pkt), 0, GFP_ATOMIC);
+			       NFT_MSG_NEWOBJ, 0, nft_pf(pkt), 0, GFP_ATOMIC);
 }
 
 static int nft_quota_do_init(const struct nlattr * const tb[],
-- 
2.30.2

