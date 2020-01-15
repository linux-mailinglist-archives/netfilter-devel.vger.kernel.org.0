Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC0B13CF21
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Jan 2020 22:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgAOVcU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Jan 2020 16:32:20 -0500
Received: from kadath.azazel.net ([81.187.231.250]:56848 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgAOVcT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5R7rJZtK438G0Rhnzl9o2VYsf+EsM470cPNvqvVjV8k=; b=bMwasTS+WQ+dehD7xkmLWNi2zO
        KTE/m0vxmCDzQFvwDroWcZnXs9mVfNXe95FS6xThP0A8KDf5sgZgEcnPeONNF3n0jURh3kqS92mfQ
        MrSv2PNNbudARZshIhhqGrWVUFTVFrpVP4XkKXF5ncaBktyRDdtARTllaYpaFInNDs8uUYKNCadW7
        KOoDXM/lleN/GnDkdCmw/wUrLMVcqYn/X7gEVslcPYoiPlTbg+Ec+c7cSFD1zR9ohrMHxexshNzxr
        HUYrziNcy3xe1x097DpzgtoqHKhq16fkrA2Nu2l2DeetD62KP6/CdCCrVeGEuHYoLlv3XPgOwP9kz
        QO7hIWFg==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1irqGw-0008BP-Du; Wed, 15 Jan 2020 21:32:18 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next v4 06/10] netfilter: bitwise: add helper for evaluating boolean operations.
Date:   Wed, 15 Jan 2020 21:32:12 +0000
Message-Id: <20200115213216.77493-7-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115213216.77493-1-jeremy@azazel.net>
References: <20200115213216.77493-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Split the code specific to evaluating bitwise boolean operations out
into a separate function.  Similar functions will be added later for
shift operations.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 net/netfilter/nft_bitwise.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index 4a8d37eb43a4..5f9d151b7047 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -24,16 +24,27 @@ struct nft_bitwise {
 	struct nft_data		xor;
 };
 
+static void nft_bitwise_eval_bool(u32 *dst, const u32 *src,
+				  const struct nft_bitwise *priv)
+{
+	unsigned int i;
+
+	for (i = 0; i < DIV_ROUND_UP(priv->len, 4); i++)
+		dst[i] = (src[i] & priv->mask.data[i]) ^ priv->xor.data[i];
+}
+
 void nft_bitwise_eval(const struct nft_expr *expr,
 		      struct nft_regs *regs, const struct nft_pktinfo *pkt)
 {
 	const struct nft_bitwise *priv = nft_expr_priv(expr);
 	const u32 *src = &regs->data[priv->sreg];
 	u32 *dst = &regs->data[priv->dreg];
-	unsigned int i;
 
-	for (i = 0; i < DIV_ROUND_UP(priv->len, 4); i++)
-		dst[i] = (src[i] & priv->mask.data[i]) ^ priv->xor.data[i];
+	switch (priv->op) {
+	case NFT_BITWISE_BOOL:
+		nft_bitwise_eval_bool(dst, src, priv);
+		break;
+	}
 }
 
 static const struct nla_policy nft_bitwise_policy[NFTA_BITWISE_MAX + 1] = {
-- 
2.24.1

