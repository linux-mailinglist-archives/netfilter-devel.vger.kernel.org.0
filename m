Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766E046F810
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Dec 2021 01:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhLJAck (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Dec 2021 19:32:40 -0500
Received: from mail.netfilter.org ([217.70.188.207]:44416 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbhLJAcg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:32:36 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 885AB6009B
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Dec 2021 01:26:37 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 03/11] netfilter: nft_quota: move stateful fields out of expression data
Date:   Fri, 10 Dec 2021 01:28:46 +0100
Message-Id: <20211210002854.144328-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210002854.144328-1-pablo@netfilter.org>
References: <20211210002854.144328-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In preparation for the rule blob representation.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_quota.c | 52 +++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_quota.c b/net/netfilter/nft_quota.c
index c4d1389f7185..0484aef74273 100644
--- a/net/netfilter/nft_quota.c
+++ b/net/netfilter/nft_quota.c
@@ -15,13 +15,13 @@
 struct nft_quota {
 	atomic64_t	quota;
 	unsigned long	flags;
-	atomic64_t	consumed;
+	atomic64_t	*consumed;
 };
 
 static inline bool nft_overquota(struct nft_quota *priv,
 				 const struct sk_buff *skb)
 {
-	return atomic64_add_return(skb->len, &priv->consumed) >=
+	return atomic64_add_return(skb->len, priv->consumed) >=
 	       atomic64_read(&priv->quota);
 }
 
@@ -90,13 +90,23 @@ static int nft_quota_do_init(const struct nlattr * const tb[],
 			return -EOPNOTSUPP;
 	}
 
+	priv->consumed = kmalloc(sizeof(*priv->consumed), GFP_KERNEL);
+	if (!priv->consumed)
+		return -ENOMEM;
+
 	atomic64_set(&priv->quota, quota);
 	priv->flags = flags;
-	atomic64_set(&priv->consumed, consumed);
+	atomic64_set(priv->consumed, consumed);
 
 	return 0;
 }
 
+static void nft_quota_do_destroy(const struct nft_ctx *ctx,
+				 struct nft_quota *priv)
+{
+	kfree(priv->consumed);
+}
+
 static int nft_quota_obj_init(const struct nft_ctx *ctx,
 			      const struct nlattr * const tb[],
 			      struct nft_object *obj)
@@ -128,7 +138,7 @@ static int nft_quota_do_dump(struct sk_buff *skb, struct nft_quota *priv,
 	 * that we see, don't go over the quota boundary in what we send to
 	 * userspace.
 	 */
-	consumed = atomic64_read(&priv->consumed);
+	consumed = atomic64_read(priv->consumed);
 	quota = atomic64_read(&priv->quota);
 	if (consumed >= quota) {
 		consumed_cap = quota;
@@ -145,7 +155,7 @@ static int nft_quota_do_dump(struct sk_buff *skb, struct nft_quota *priv,
 		goto nla_put_failure;
 
 	if (reset) {
-		atomic64_sub(consumed, &priv->consumed);
+		atomic64_sub(consumed, priv->consumed);
 		clear_bit(NFT_QUOTA_DEPLETED_BIT, &priv->flags);
 	}
 	return 0;
@@ -162,11 +172,20 @@ static int nft_quota_obj_dump(struct sk_buff *skb, struct nft_object *obj,
 	return nft_quota_do_dump(skb, priv, reset);
 }
 
+static void nft_quota_obj_destroy(const struct nft_ctx *ctx,
+				  struct nft_object *obj)
+{
+	struct nft_quota *priv = nft_obj_data(obj);
+
+	return nft_quota_do_destroy(ctx, priv);
+}
+
 static struct nft_object_type nft_quota_obj_type;
 static const struct nft_object_ops nft_quota_obj_ops = {
 	.type		= &nft_quota_obj_type,
 	.size		= sizeof(struct nft_quota),
 	.init		= nft_quota_obj_init,
+	.destroy	= nft_quota_obj_destroy,
 	.eval		= nft_quota_obj_eval,
 	.dump		= nft_quota_obj_dump,
 	.update		= nft_quota_obj_update,
@@ -205,12 +224,35 @@ static int nft_quota_dump(struct sk_buff *skb, const struct nft_expr *expr)
 	return nft_quota_do_dump(skb, priv, false);
 }
 
+static void nft_quota_destroy(const struct nft_ctx *ctx,
+			      const struct nft_expr *expr)
+{
+	struct nft_quota *priv = nft_expr_priv(expr);
+
+	return nft_quota_do_destroy(ctx, priv);
+}
+
+static int nft_quota_clone(struct nft_expr *dst, const struct nft_expr *src)
+{
+	struct nft_quota *priv_dst = nft_expr_priv(dst);
+
+	priv_dst->consumed = kmalloc(sizeof(*priv_dst->consumed), GFP_ATOMIC);
+	if (priv_dst->consumed)
+		return -ENOMEM;
+
+	atomic64_set(priv_dst->consumed, 0);
+
+	return 0;
+}
+
 static struct nft_expr_type nft_quota_type;
 static const struct nft_expr_ops nft_quota_ops = {
 	.type		= &nft_quota_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_quota)),
 	.eval		= nft_quota_eval,
 	.init		= nft_quota_init,
+	.destroy	= nft_quota_destroy,
+	.clone		= nft_quota_clone,
 	.dump		= nft_quota_dump,
 };
 
-- 
2.30.2

