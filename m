Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BED04D6B61
	for <lists+netfilter-devel@lfdr.de>; Sat, 12 Mar 2022 01:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiCLAQs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Mar 2022 19:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiCLAQr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Mar 2022 19:16:47 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9EFFFF6
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Mar 2022 16:15:42 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 60CBB60240
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Mar 2022 01:13:36 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next] netfilter: nft_payload: only cancel tracking for clobbered dregs
Date:   Sat, 12 Mar 2022 01:15:38 +0100
Message-Id: <20220312001538.23128-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

payload expression might use more than one single register and clobber
previous data, reset tracking for the remaining registers too.

Fixes: a7c176bf9f0e ("netfilter: nft_payload: track register operations")
Reported-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_payload.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 5cc06aef4345..431f70c8bc15 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -210,6 +210,23 @@ static int nft_payload_dump(struct sk_buff *skb, const struct nft_expr *expr)
 	return -1;
 }
 
+static void nft_update_reg_track(struct nft_regs_track *track,
+				 const struct nft_expr *expr, u8 dreg, u8 len)
+{
+	unsigned int regcount;
+	int i;
+
+	track->regs[dreg].selector = expr;
+	track->regs[dreg].bitwise = NULL;
+
+	dreg++;
+	regcount = DIV_ROUND_UP(len, NFT_REG32_SIZE);
+	for (i = 1; i < regcount; i++, dreg++) {
+		track->regs[dreg].selector = NULL;
+		track->regs[dreg].bitwise = NULL;
+	}
+}
+
 static bool nft_payload_reduce(struct nft_regs_track *track,
 			       const struct nft_expr *expr)
 {
@@ -218,8 +235,7 @@ static bool nft_payload_reduce(struct nft_regs_track *track,
 
 	if (!track->regs[priv->dreg].selector ||
 	    track->regs[priv->dreg].selector->ops != expr->ops) {
-		track->regs[priv->dreg].selector = expr;
-		track->regs[priv->dreg].bitwise = NULL;
+		nft_update_reg_track(track, expr, priv->dreg, priv->len);
 		return false;
 	}
 
@@ -227,8 +243,7 @@ static bool nft_payload_reduce(struct nft_regs_track *track,
 	if (priv->base != payload->base ||
 	    priv->offset != payload->offset ||
 	    priv->len != payload->len) {
-		track->regs[priv->dreg].selector = expr;
-		track->regs[priv->dreg].bitwise = NULL;
+		nft_update_reg_track(track, expr, priv->dreg, priv->len);
 		return false;
 	}
 
-- 
2.30.2

