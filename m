Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F04C4D6029
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Mar 2022 11:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbiCKKyj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Mar 2022 05:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiCKKyi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:54:38 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28CA16BCE2
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Mar 2022 02:53:35 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nSctp-0002DQ-R2; Fri, 11 Mar 2022 11:53:33 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: nft_lookup: only cancel tracking for clobbered dregs
Date:   Fri, 11 Mar 2022 11:53:24 +0100
Message-Id: <20220311105324.11980-1-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In most cases, nft_lookup will be read-only, i.e. won't clobber
registers.  In case of map, we need to cancel the registers that will
see stores.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_lookup.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index 90becbf5bff3..f2242fb08bca 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -253,6 +253,26 @@ static int nft_lookup_validate(const struct nft_ctx *ctx,
 	return 0;
 }
 
+static bool nft_lookup_reduce(struct nft_regs_track *track,
+			      const struct nft_expr *expr)
+{
+	const struct nft_lookup *priv = nft_expr_priv(expr);
+
+	if (priv->set->flags & NFT_SET_MAP) {
+		unsigned int regcount, i, dreg = priv->dreg;
+
+		regcount = DIV_ROUND_UP(priv->set->dlen, NFT_REG32_SIZE);
+
+		/* reset registers that were clobbered */
+		for (i = 0; i < regcount; i++, dreg++) {
+			track->regs[dreg].selector = NULL;
+			track->regs[dreg].bitwise = NULL;
+		}
+	}
+
+	return false;
+}
+
 static const struct nft_expr_ops nft_lookup_ops = {
 	.type		= &nft_lookup_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_lookup)),
@@ -263,6 +283,7 @@ static const struct nft_expr_ops nft_lookup_ops = {
 	.destroy	= nft_lookup_destroy,
 	.dump		= nft_lookup_dump,
 	.validate	= nft_lookup_validate,
+	.reduce		= nft_lookup_reduce,
 };
 
 struct nft_expr_type nft_lookup_type __read_mostly = {
-- 
2.34.1

