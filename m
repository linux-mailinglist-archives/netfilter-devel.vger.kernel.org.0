Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A39D13CDB9
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Jan 2020 21:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgAOUGD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Jan 2020 15:06:03 -0500
Received: from kadath.azazel.net ([81.187.231.250]:53248 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbgAOUF7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=i+fBimlTPau0lDkrNNI71WL6xuGUWlxZIBhqG5nGY1A=; b=RtrHHrGEDxkoTOvSsW0q+TjXXn
        kNY2cOpjEc03CQvcZAk50WgCxYooGAISYpZmadq5h+QDBpb76Yp6mUPvTSaXCiEWCCQcmuCFcf/Ie
        zrb2ODOZUAwfeBB8sf40n7FNtwHzja+H8EM9WA34FzFQJI64g682xww7GTLx8+ft60Yh/p7CB3Zol
        HYfpacJsN9qRKjXsL1HzPgVDoXI2OszLYstrLhOsLhk2OeaHJweqYaO+gswbZDyEEftxvTc9S3QzS
        TCgkGNm4HiB/T7Iura0Sn80z5HOA8FDMGtUVpip1BGzZQtcEFnutTvGBceQjWGdyPOO767n0ry9Cf
        VT+kvtfg==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1irovO-00054b-CU; Wed, 15 Jan 2020 20:05:58 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next v3 05/10] netfilter: bitwise: add helper for initializing boolean operations.
Date:   Wed, 15 Jan 2020 20:05:52 +0000
Message-Id: <20200115200557.26202-6-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115200557.26202-1-jeremy@azazel.net>
References: <20200115200557.26202-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Split the code specific to initializing bitwise boolean operations out
into a separate function.  A similar function will be added later for
shift operations.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 net/netfilter/nft_bitwise.c | 67 +++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index 4884716d844a..4a8d37eb43a4 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -45,20 +45,53 @@ static const struct nla_policy nft_bitwise_policy[NFTA_BITWISE_MAX + 1] = {
 	[NFTA_BITWISE_OP]	= { .type = NLA_U32 },
 };
 
+static int nft_bitwise_init_bool(struct nft_bitwise *priv,
+				 const struct nlattr *const tb[])
+{
+	struct nft_data_desc d1, d2;
+	int err;
+
+	if (!tb[NFTA_BITWISE_MASK] ||
+	    !tb[NFTA_BITWISE_XOR])
+		return -EINVAL;
+
+	err = nft_data_init(NULL, &priv->mask, sizeof(priv->mask), &d1,
+			    tb[NFTA_BITWISE_MASK]);
+	if (err < 0)
+		return err;
+	if (d1.type != NFT_DATA_VALUE || d1.len != priv->len) {
+		err = -EINVAL;
+		goto err1;
+	}
+
+	err = nft_data_init(NULL, &priv->xor, sizeof(priv->xor), &d2,
+			    tb[NFTA_BITWISE_XOR]);
+	if (err < 0)
+		goto err1;
+	if (d2.type != NFT_DATA_VALUE || d2.len != priv->len) {
+		err = -EINVAL;
+		goto err2;
+	}
+
+	return 0;
+err2:
+	nft_data_release(&priv->xor, d2.type);
+err1:
+	nft_data_release(&priv->mask, d1.type);
+	return err;
+}
+
 static int nft_bitwise_init(const struct nft_ctx *ctx,
 			    const struct nft_expr *expr,
 			    const struct nlattr * const tb[])
 {
 	struct nft_bitwise *priv = nft_expr_priv(expr);
-	struct nft_data_desc d1, d2;
 	u32 len;
 	int err;
 
 	if (!tb[NFTA_BITWISE_SREG] ||
 	    !tb[NFTA_BITWISE_DREG] ||
-	    !tb[NFTA_BITWISE_LEN]  ||
-	    !tb[NFTA_BITWISE_MASK] ||
-	    !tb[NFTA_BITWISE_XOR])
+	    !tb[NFTA_BITWISE_LEN])
 		return -EINVAL;
 
 	err = nft_parse_u32_check(tb[NFTA_BITWISE_LEN], U8_MAX, &len);
@@ -90,30 +123,12 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
 		priv->op = NFT_BITWISE_BOOL;
 	}
 
-	err = nft_data_init(NULL, &priv->mask, sizeof(priv->mask), &d1,
-			    tb[NFTA_BITWISE_MASK]);
-	if (err < 0)
-		return err;
-	if (d1.type != NFT_DATA_VALUE || d1.len != priv->len) {
-		err = -EINVAL;
-		goto err1;
-	}
-
-	err = nft_data_init(NULL, &priv->xor, sizeof(priv->xor), &d2,
-			    tb[NFTA_BITWISE_XOR]);
-	if (err < 0)
-		goto err1;
-	if (d2.type != NFT_DATA_VALUE || d2.len != priv->len) {
-		err = -EINVAL;
-		goto err2;
+	switch(priv->op) {
+	case NFT_BITWISE_BOOL:
+		return nft_bitwise_init_bool(priv, tb);
 	}
 
-	return 0;
-err2:
-	nft_data_release(&priv->xor, d2.type);
-err1:
-	nft_data_release(&priv->mask, d1.type);
-	return err;
+	return -EINVAL;
 }
 
 static int nft_bitwise_dump(struct sk_buff *skb, const struct nft_expr *expr)
-- 
2.24.1

