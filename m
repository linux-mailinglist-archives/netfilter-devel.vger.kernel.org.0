Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2286D6F5580
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 May 2023 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjECKAe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 May 2023 06:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjECKAd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 May 2023 06:00:33 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC481A5
        for <netfilter-devel@vger.kernel.org>; Wed,  3 May 2023 03:00:31 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pu9Hg-0004R6-SL; Wed, 03 May 2023 12:00:28 +0200
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>, Rvfg <i@rvf6.com>
Subject: [PATCH nf] netfilter: nf_tables: fix ct untracked match breakage
Date:   Wed,  3 May 2023 12:00:18 +0200
Message-Id: <20230503100018.74845-1-fw@strlen.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

"ct untracked" no longer works properly due to erroneous NFT_BREAK.
We have to check ctinfo enum first.

Fixes: d9e789147605 ("netfilter: nf_tables: avoid retpoline overhead for some ct expression calls")
Reported-by: Rvfg <i@rvf6.com>
Link: https://marc.info/?l=netfilter&m=168294996212038&w=2
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_ct_fast.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_ct_fast.c b/net/netfilter/nft_ct_fast.c
index 89983b0613fa..e684c8a91848 100644
--- a/net/netfilter/nft_ct_fast.c
+++ b/net/netfilter/nft_ct_fast.c
@@ -15,10 +15,6 @@ void nft_ct_get_fast_eval(const struct nft_expr *expr,
 	unsigned int state;
 
 	ct = nf_ct_get(pkt->skb, &ctinfo);
-	if (!ct) {
-		regs->verdict.code = NFT_BREAK;
-		return;
-	}
 
 	switch (priv->key) {
 	case NFT_CT_STATE:
@@ -30,6 +26,16 @@ void nft_ct_get_fast_eval(const struct nft_expr *expr,
 			state = NF_CT_STATE_INVALID_BIT;
 		*dest = state;
 		return;
+	default:
+		break;
+	}
+
+	if (!ct) {
+		regs->verdict.code = NFT_BREAK;
+		return;
+	}
+
+	switch (priv->key) {
 	case NFT_CT_DIRECTION:
 		nft_reg_store8(dest, CTINFO2DIR(ctinfo));
 		return;
-- 
2.40.1

