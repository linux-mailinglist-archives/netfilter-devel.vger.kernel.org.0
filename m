Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A41A113B453
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jan 2020 22:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgANV3W (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Jan 2020 16:29:22 -0500
Received: from kadath.azazel.net ([81.187.231.250]:55086 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgANV3U (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=plc2ugXJZPDyInX8U5Ek2zakif7sCVEOMJE7WTe9CH4=; b=GXiHNohEYsw9F3xa0deNtrQ4Zb
        4T3U78nBNOE9Xr2mD3+f+AoqlxmP1L49zaYr9rYRctGlMJGFzNKH3LFgThB/RmJuj3L7POCr1PrJm
        pL3KaoGNw51iQvVHLy8lxwUnVX8CwxfNk1i2YbDgqse2/CpRK8JF+zSG6xtNNmiQEx5fadNRBqxBw
        LAfkCM0l5Z3V1lcZJZGBfkfIOGVJbnW5CotAzKAeK+cuhwRLeylyHX/F/sDYB9rdP1pK94RYUGWwd
        AU6j6/UgBMq/ggAxzxEu0NEtMr2E88OvGYV/oey7p8HbJd1ejqRYg4JyWtOZT2fUuvfIBaPhTuiZa
        WwYj59yQ==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1irTkV-0001Dh-J1; Tue, 14 Jan 2020 21:29:19 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next v2 07/10] netfilter: bitwise: add helper for dumping boolean operations.
Date:   Tue, 14 Jan 2020 21:29:15 +0000
Message-Id: <20200114212918.134062-8-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114212918.134062-1-jeremy@azazel.net>
References: <20200114212918.134062-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Split the code specific to dumping bitwise boolean operations out into a
separate function.  A similar function will be added later for shift
operations.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 net/netfilter/nft_bitwise.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index 5f9d151b7047..40272a45deeb 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -142,6 +142,20 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
 	return -EINVAL;
 }
 
+static int nft_bitwise_dump_bool(struct sk_buff *skb,
+				 const struct nft_bitwise *priv)
+{
+	if (nft_data_dump(skb, NFTA_BITWISE_MASK, &priv->mask,
+			  NFT_DATA_VALUE, priv->len) < 0)
+		return -1;
+
+	if (nft_data_dump(skb, NFTA_BITWISE_XOR, &priv->xor,
+			  NFT_DATA_VALUE, priv->len) < 0)
+		return -1;
+
+	return 0;
+}
+
 static int nft_bitwise_dump(struct sk_buff *skb, const struct nft_expr *expr)
 {
 	const struct nft_bitwise *priv = nft_expr_priv(expr);
@@ -155,15 +169,12 @@ static int nft_bitwise_dump(struct sk_buff *skb, const struct nft_expr *expr)
 	if (nla_put_be32(skb, NFTA_BITWISE_OP, htonl(priv->op)))
 		return -1;
 
-	if (nft_data_dump(skb, NFTA_BITWISE_MASK, &priv->mask,
-			  NFT_DATA_VALUE, priv->len) < 0)
-		return -1;
-
-	if (nft_data_dump(skb, NFTA_BITWISE_XOR, &priv->xor,
-			  NFT_DATA_VALUE, priv->len) < 0)
-		return -1;
+	switch (priv->op) {
+	case NFT_BITWISE_BOOL:
+		return nft_bitwise_dump_bool(skb, priv);
+	}
 
-	return 0;
+	return -1;
 }
 
 static struct nft_data zero;
-- 
2.24.1

