Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C76C13CDB4
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Jan 2020 21:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgAOUF7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Jan 2020 15:05:59 -0500
Received: from kadath.azazel.net ([81.187.231.250]:53240 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbgAOUF7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7tKDT29RaDdXak2Xt6L5xmJeUBMXdr2kwLfSeeZTFPU=; b=gkmnqLYcFTaP7fDkxQMpSpQXM/
        ybzJ/14ES/GgdcL91BKsD1o0mOkfB/H1bS3PNuocgTeC7O1Ki+NA5alXd5aVnkrn8gJYAPRoFfyRC
        B/vawHxjGNMlBsNSnKivJjv7L4ec8FDRza6oEYeKjdXjCq//ZCURFV3p7ky75aSBVaW+nBVnR8vGk
        3BXjhwXdB1nF4NY7yjV3EmMgSDlVd+4GffxJ5kyURqkrYkk8bFX9pSd5RlgIlq/uOEWCzATYFVYvQ
        fiVBPxjY/XUDeGZOqWlMkfQO5hHKTavh8Yl5H/sFSOnpiWE8svY+wzGizMi84qjP1JqyRUKUBz7Kj
        jXbnV37g==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1irovO-00054b-4Z; Wed, 15 Jan 2020 20:05:58 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next v3 03/10] netfilter: bitwise: replace gotos with returns.
Date:   Wed, 15 Jan 2020 20:05:50 +0000
Message-Id: <20200115200557.26202-4-jeremy@azazel.net>
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

When dumping a bitwise expression, if any of the puts fails, we use goto
to jump to a label.  However, no clean-up is required and the only
statement at the label is a return.  Drop the goto's and return
immediately instead.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 net/netfilter/nft_bitwise.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index 85605fb1e360..c15e9beb5243 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -107,24 +107,21 @@ static int nft_bitwise_dump(struct sk_buff *skb, const struct nft_expr *expr)
 	const struct nft_bitwise *priv = nft_expr_priv(expr);
 
 	if (nft_dump_register(skb, NFTA_BITWISE_SREG, priv->sreg))
-		goto nla_put_failure;
+		return -1;
 	if (nft_dump_register(skb, NFTA_BITWISE_DREG, priv->dreg))
-		goto nla_put_failure;
+		return -1;
 	if (nla_put_be32(skb, NFTA_BITWISE_LEN, htonl(priv->len)))
-		goto nla_put_failure;
+		return -1;
 
 	if (nft_data_dump(skb, NFTA_BITWISE_MASK, &priv->mask,
 			  NFT_DATA_VALUE, priv->len) < 0)
-		goto nla_put_failure;
+		return -1;
 
 	if (nft_data_dump(skb, NFTA_BITWISE_XOR, &priv->xor,
 			  NFT_DATA_VALUE, priv->len) < 0)
-		goto nla_put_failure;
+		return -1;
 
 	return 0;
-
-nla_put_failure:
-	return -1;
 }
 
 static struct nft_data zero;
-- 
2.24.1

