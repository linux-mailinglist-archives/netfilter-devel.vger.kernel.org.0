Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100C85F5CCA
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Oct 2022 00:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJEWhs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Oct 2022 18:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJEWhr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:37:47 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D721D7B7BF
        for <netfilter-devel@vger.kernel.org>; Wed,  5 Oct 2022 15:37:46 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v2 5/6] netfilter: nft_meta: add inner match support
Date:   Thu,  6 Oct 2022 00:37:39 +0200
Message-Id: <20221005223740.22991-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221005223740.22991-1-pablo@netfilter.org>
References: <20221005223740.22991-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add support for inner meta matching on:

- NFT_META_PROTOCOL: to match on the ethertype, this can be used
  regardless tunnel protocol provides no link layer header, in that case
  nft_inner sets on the ethertype based on the IP header version field.
- NFT_META_L4PROTO: to match on the layer 4 protocol.

These meta expression are usually autogenerated as dependencies by
userspace nftables.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nft_meta.h |  6 ++++
 net/netfilter/nft_inner.c        |  8 +++++
 net/netfilter/nft_meta.c         | 62 ++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/include/net/netfilter/nft_meta.h b/include/net/netfilter/nft_meta.h
index 9b51cc67de54..f3a5285a511c 100644
--- a/include/net/netfilter/nft_meta.h
+++ b/include/net/netfilter/nft_meta.h
@@ -46,4 +46,10 @@ int nft_meta_set_validate(const struct nft_ctx *ctx,
 
 bool nft_meta_get_reduce(struct nft_regs_track *track,
 			 const struct nft_expr *expr);
+
+struct nft_inner_tun_ctx;
+void nft_meta_inner_eval(const struct nft_expr *expr,
+			 struct nft_regs *regs, const struct nft_pktinfo *pkt,
+			 struct nft_inner_tun_ctx *tun_ctx);
+
 #endif
diff --git a/net/netfilter/nft_inner.c b/net/netfilter/nft_inner.c
index 0e1c1d7dd823..6e874a986bfa 100644
--- a/net/netfilter/nft_inner.c
+++ b/net/netfilter/nft_inner.c
@@ -12,6 +12,7 @@
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables_core.h>
 #include <net/netfilter/nf_tables.h>
+#include <net/netfilter/nft_meta.h>
 #include <net/netfilter/nf_tables_offload.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
@@ -27,11 +28,13 @@ struct __nft_expr {
 	const struct nft_expr_ops	*ops;
 	union {
 		struct nft_payload	payload;
+		struct nft_meta		meta;
 	} __attribute__((aligned(__alignof__(u64))));
 };
 
 enum {
 	NFT_INNER_EXPR_PAYLOAD,
+	NFT_INNER_EXPR_META,
 };
 
 struct nft_inner {
@@ -224,6 +227,9 @@ static void nft_inner_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	case NFT_INNER_EXPR_PAYLOAD:
 		nft_payload_inner_eval((struct nft_expr *)&priv->expr, regs, pkt, tun_ctx);
 		break;
+	case NFT_INNER_EXPR_META:
+		nft_meta_inner_eval((struct nft_expr *)&priv->expr, regs, pkt, tun_ctx);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		goto err;
@@ -293,6 +299,8 @@ static int nft_inner_init(const struct nft_ctx *ctx,
 
 	if (!strcmp(expr_info.ops->type->name, "payload"))
 		priv->expr_type = NFT_INNER_EXPR_PAYLOAD;
+	else if (!strcmp(expr_info.ops->type->name, "meta"))
+		priv->expr_type = NFT_INNER_EXPR_META;
 	else
 		return -EINVAL;
 
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 55d2d49c3425..8c39adeebb5c 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -831,9 +831,71 @@ nft_meta_select_ops(const struct nft_ctx *ctx,
 	return ERR_PTR(-EINVAL);
 }
 
+static int nft_meta_inner_init(const struct nft_ctx *ctx,
+			       const struct nft_expr *expr,
+			       const struct nlattr * const tb[])
+{
+	struct nft_meta *priv = nft_expr_priv(expr);
+	unsigned int len;
+
+	priv->key = ntohl(nla_get_be32(tb[NFTA_META_KEY]));
+	switch (priv->key) {
+	case NFT_META_PROTOCOL:
+		len = sizeof(u16);
+		break;
+	case NFT_META_L4PROTO:
+		len = sizeof(u32);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	priv->len = len;
+
+	return nft_parse_register_store(ctx, tb[NFTA_META_DREG], &priv->dreg,
+					NULL, NFT_DATA_VALUE, len);
+}
+
+void nft_meta_inner_eval(const struct nft_expr *expr,
+			 struct nft_regs *regs,
+			 const struct nft_pktinfo *pkt,
+			 struct nft_inner_tun_ctx *tun_ctx)
+{
+	const struct nft_meta *priv = nft_expr_priv(expr);
+	u32 *dest = &regs->data[priv->dreg];
+
+	switch (priv->key) {
+	case NFT_META_PROTOCOL:
+		nft_reg_store16(dest, (__force u16)tun_ctx->llproto);
+		break;
+	case NFT_META_L4PROTO:
+		if (!(tun_ctx->flags & NFT_PAYLOAD_CTX_INNER_TH))
+			goto err;
+
+		nft_reg_store8(dest, tun_ctx->l4proto);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		goto err;
+	}
+	return;
+
+err:
+	regs->verdict.code = NFT_BREAK;
+}
+EXPORT_SYMBOL_GPL(nft_meta_inner_eval);
+
+static const struct nft_expr_ops nft_meta_inner_ops = {
+	.type		= &nft_meta_type,
+	.size		= NFT_EXPR_SIZE(sizeof(struct nft_meta)),
+	.init		= nft_meta_inner_init,
+	.dump		= nft_meta_get_dump,
+	/* direct call to nft_meta_inner_eval(). */
+};
+
 struct nft_expr_type nft_meta_type __read_mostly = {
 	.name		= "meta",
 	.select_ops	= nft_meta_select_ops,
+	.inner_ops	= &nft_meta_inner_ops,
 	.policy		= nft_meta_policy,
 	.maxattr	= NFTA_META_MAX,
 	.owner		= THIS_MODULE,
-- 
2.30.2

