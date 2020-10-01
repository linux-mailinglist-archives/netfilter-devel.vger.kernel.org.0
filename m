Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1036628041C
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Oct 2020 18:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbgJAQkC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Oct 2020 12:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731917AbgJAQkC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:40:02 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2293DC0613D0
        for <netfilter-devel@vger.kernel.org>; Thu,  1 Oct 2020 09:40:02 -0700 (PDT)
Received: from localhost ([::1]:47988 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kO1cd-0004Lb-8x; Thu, 01 Oct 2020 18:39:59 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [net-next PATCH 1/2] net: netfilter: Enable fast nft_cmp for inverted matches
Date:   Thu,  1 Oct 2020 18:57:43 +0200
Message-Id: <20201001165744.25466-2-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001165744.25466-1-phil@nwl.cc>
References: <20201001165744.25466-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a boolean indicating NFT_CMP_NEQ. To include it into the match
decision, it is sufficient to XOR it with the data comparison's result.

While being at it, store the mask that is calculated during expression
init and free the eval routine from having to recalculate it each time.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 include/net/netfilter/nf_tables_core.h |  2 ++
 net/netfilter/nf_tables_core.c         |  3 +--
 net/netfilter/nft_cmp.c                | 10 +++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
index 78516de14d316..df2d91c814cb3 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -25,8 +25,10 @@ void nf_tables_core_module_exit(void);
 
 struct nft_cmp_fast_expr {
 	u32			data;
+	u32			mask;
 	enum nft_registers	sreg:8;
 	u8			len;
+	bool			inv;
 };
 
 struct nft_immediate_expr {
diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index 587897a2498b8..e92feacaf5516 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -51,9 +51,8 @@ static void nft_cmp_fast_eval(const struct nft_expr *expr,
 			      struct nft_regs *regs)
 {
 	const struct nft_cmp_fast_expr *priv = nft_expr_priv(expr);
-	u32 mask = nft_cmp_fast_mask(priv->len);
 
-	if ((regs->data[priv->sreg] & mask) == priv->data)
+	if (((regs->data[priv->sreg] & priv->mask) == priv->data) ^ priv->inv)
 		return;
 	regs->verdict.code = NFT_BREAK;
 }
diff --git a/net/netfilter/nft_cmp.c b/net/netfilter/nft_cmp.c
index 16f4d84599ac7..832c3b08991e7 100644
--- a/net/netfilter/nft_cmp.c
+++ b/net/netfilter/nft_cmp.c
@@ -167,7 +167,6 @@ static int nft_cmp_fast_init(const struct nft_ctx *ctx,
 	struct nft_cmp_fast_expr *priv = nft_expr_priv(expr);
 	struct nft_data_desc desc;
 	struct nft_data data;
-	u32 mask;
 	int err;
 
 	err = nft_data_init(NULL, &data, sizeof(data), &desc,
@@ -181,10 +180,11 @@ static int nft_cmp_fast_init(const struct nft_ctx *ctx,
 		return err;
 
 	desc.len *= BITS_PER_BYTE;
-	mask = nft_cmp_fast_mask(desc.len);
 
-	priv->data = data.data[0] & mask;
+	priv->mask = nft_cmp_fast_mask(desc.len);
+	priv->data = data.data[0] & priv->mask;
 	priv->len  = desc.len;
+	priv->inv  = ntohl(nla_get_be32(tb[NFTA_CMP_OP])) != NFT_CMP_EQ;
 	return 0;
 }
 
@@ -201,7 +201,7 @@ static int nft_cmp_fast_offload(struct nft_offload_ctx *ctx,
 		},
 		.sreg	= priv->sreg,
 		.len	= priv->len / BITS_PER_BYTE,
-		.op	= NFT_CMP_EQ,
+		.op	= priv->inv ? NFT_CMP_NEQ : NFT_CMP_EQ,
 	};
 
 	return __nft_cmp_offload(ctx, flow, &cmp);
@@ -272,7 +272,7 @@ nft_cmp_select_ops(const struct nft_ctx *ctx, const struct nlattr * const tb[])
 		goto err1;
 	}
 
-	if (desc.len <= sizeof(u32) && op == NFT_CMP_EQ)
+	if (desc.len <= sizeof(u32) && (op == NFT_CMP_EQ || op == NFT_CMP_NEQ))
 		return &nft_cmp_fast_ops;
 
 	return &nft_cmp_ops;
-- 
2.28.0

