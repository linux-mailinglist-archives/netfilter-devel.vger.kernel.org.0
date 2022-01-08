Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CBD4886AC
	for <lists+netfilter-devel@lfdr.de>; Sat,  8 Jan 2022 23:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiAHW0u (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 8 Jan 2022 17:26:50 -0500
Received: from mail.netfilter.org ([217.70.188.207]:40122 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiAHW0s (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 8 Jan 2022 17:26:48 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id D9F606428F
        for <netfilter-devel@vger.kernel.org>; Sat,  8 Jan 2022 23:23:57 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v2 04/14] netfilter: nft_numgen: move stateful fields out of expression data
Date:   Sat,  8 Jan 2022 23:26:28 +0100
Message-Id: <20220108222638.36037-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108222638.36037-1-pablo@netfilter.org>
References: <20220108222638.36037-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In preparation for the rule blob representation.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_numgen.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_numgen.c b/net/netfilter/nft_numgen.c
index 722cac1e90e0..1d378efd8823 100644
--- a/net/netfilter/nft_numgen.c
+++ b/net/netfilter/nft_numgen.c
@@ -18,7 +18,7 @@ static DEFINE_PER_CPU(struct rnd_state, nft_numgen_prandom_state);
 struct nft_ng_inc {
 	u8			dreg;
 	u32			modulus;
-	atomic_t		counter;
+	atomic_t		*counter;
 	u32			offset;
 };
 
@@ -27,9 +27,9 @@ static u32 nft_ng_inc_gen(struct nft_ng_inc *priv)
 	u32 nval, oval;
 
 	do {
-		oval = atomic_read(&priv->counter);
+		oval = atomic_read(priv->counter);
 		nval = (oval + 1 < priv->modulus) ? oval + 1 : 0;
-	} while (atomic_cmpxchg(&priv->counter, oval, nval) != oval);
+	} while (atomic_cmpxchg(priv->counter, oval, nval) != oval);
 
 	return nval + priv->offset;
 }
@@ -55,6 +55,7 @@ static int nft_ng_inc_init(const struct nft_ctx *ctx,
 			   const struct nlattr * const tb[])
 {
 	struct nft_ng_inc *priv = nft_expr_priv(expr);
+	int err;
 
 	if (tb[NFTA_NG_OFFSET])
 		priv->offset = ntohl(nla_get_be32(tb[NFTA_NG_OFFSET]));
@@ -66,10 +67,22 @@ static int nft_ng_inc_init(const struct nft_ctx *ctx,
 	if (priv->offset + priv->modulus - 1 < priv->offset)
 		return -EOVERFLOW;
 
-	atomic_set(&priv->counter, priv->modulus - 1);
+	priv->counter = kmalloc(sizeof(*priv->counter), GFP_KERNEL);
+	if (!priv->counter)
+		return -ENOMEM;
 
-	return nft_parse_register_store(ctx, tb[NFTA_NG_DREG], &priv->dreg,
-					NULL, NFT_DATA_VALUE, sizeof(u32));
+	atomic_set(priv->counter, priv->modulus - 1);
+
+	err = nft_parse_register_store(ctx, tb[NFTA_NG_DREG], &priv->dreg,
+				       NULL, NFT_DATA_VALUE, sizeof(u32));
+	if (err < 0)
+		goto err;
+
+	return 0;
+err:
+	kfree(priv->counter);
+
+	return err;
 }
 
 static int nft_ng_dump(struct sk_buff *skb, enum nft_registers dreg,
@@ -98,6 +111,14 @@ static int nft_ng_inc_dump(struct sk_buff *skb, const struct nft_expr *expr)
 			   priv->offset);
 }
 
+static void nft_ng_inc_destroy(const struct nft_ctx *ctx,
+			       const struct nft_expr *expr)
+{
+	const struct nft_ng_inc *priv = nft_expr_priv(expr);
+
+	kfree(priv->counter);
+}
+
 struct nft_ng_random {
 	u8			dreg;
 	u32			modulus;
@@ -157,6 +178,7 @@ static const struct nft_expr_ops nft_ng_inc_ops = {
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_ng_inc)),
 	.eval		= nft_ng_inc_eval,
 	.init		= nft_ng_inc_init,
+	.destroy	= nft_ng_inc_destroy,
 	.dump		= nft_ng_inc_dump,
 };
 
-- 
2.30.2

