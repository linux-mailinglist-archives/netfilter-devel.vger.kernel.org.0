Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4CAA13CF24
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Jan 2020 22:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgAOVcV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Jan 2020 16:32:21 -0500
Received: from kadath.azazel.net ([81.187.231.250]:56854 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgAOVcU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TA0hQNrpxfI6RhSRwgf4ir3ZFAV7W8p1Pb2sW1OGqtc=; b=SfQ1FQ5c94WIO3hqlColS2OiEl
        BOQg+3edTehdf5qrdd/eq/H/TN2Y0/FABNwyoD15R8Kp5m6wQBtupfRLJ24ydjnKG/0rmesxzfH0k
        iz6eR+sx79mIY/XWi6M8UsxqHgzSqy2ToivYS9x/s+f9cQnm0DeNbsDxdvyrhPrAqf6dCJTWMb6bI
        iNjrpUYLCvLE1+hcaTtXgeCtBMcZXmknDxVwmW1o1fobJ6OGdI37/jcIGTUmBdGczwCEFmMeCBXft
        1BZ1J3cX9B9huOdVbCUEijRbW3HnBBpdqpJwygxNQyFtQwuxUpF3iE3GbOq35jMfLvZvNg5pDN3wZ
        zcRWGRdA==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1irqGw-0008BP-Lk; Wed, 15 Jan 2020 21:32:18 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next v4 08/10] netfilter: bitwise: only offload boolean operations.
Date:   Wed, 15 Jan 2020 21:32:14 +0000
Message-Id: <20200115213216.77493-9-jeremy@azazel.net>
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

Only boolean operations supports offloading, so check the type of the
operation and return an error for other types.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 net/netfilter/nft_bitwise.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index 40272a45deeb..582014f696ad 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -186,6 +186,9 @@ static int nft_bitwise_offload(struct nft_offload_ctx *ctx,
 	const struct nft_bitwise *priv = nft_expr_priv(expr);
 	struct nft_offload_reg *reg = &ctx->regs[priv->dreg];
 
+	if (priv->op != NFT_BITWISE_BOOL)
+		return -EOPNOTSUPP;
+
 	if (memcmp(&priv->xor, &zero, sizeof(priv->xor)) ||
 	    priv->sreg != priv->dreg || priv->len != reg->len)
 		return -EOPNOTSUPP;
-- 
2.24.1

