Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8FC4D6FD7
	for <lists+netfilter-devel@lfdr.de>; Sat, 12 Mar 2022 16:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiCLPt2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 12 Mar 2022 10:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiCLPt0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:49:26 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4F368BE23
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Mar 2022 07:48:20 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 08198625FB
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Mar 2022 16:46:10 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 4/9] netfilter: nft_lookup: only cancel tracking for clobbered dregs
Date:   Sat, 12 Mar 2022 16:48:06 +0100
Message-Id: <20220312154811.68611-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220312154811.68611-1-pablo@netfilter.org>
References: <20220312154811.68611-1-pablo@netfilter.org>
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

From: Florian Westphal <fw@strlen.de>

In most cases, nft_lookup will be read-only, i.e. won't clobber
registers.  In case of map, we need to cancel the registers that will
see stores.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_lookup.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index 90becbf5bff3..dfae12759c7c 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -253,6 +253,17 @@ static int nft_lookup_validate(const struct nft_ctx *ctx,
 	return 0;
 }
 
+static bool nft_lookup_reduce(struct nft_regs_track *track,
+			      const struct nft_expr *expr)
+{
+	const struct nft_lookup *priv = nft_expr_priv(expr);
+
+	if (priv->set->flags & NFT_SET_MAP)
+		nft_reg_track_cancel(track, priv->dreg, priv->set->dlen);
+
+	return false;
+}
+
 static const struct nft_expr_ops nft_lookup_ops = {
 	.type		= &nft_lookup_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_lookup)),
@@ -263,6 +274,7 @@ static const struct nft_expr_ops nft_lookup_ops = {
 	.destroy	= nft_lookup_destroy,
 	.dump		= nft_lookup_dump,
 	.validate	= nft_lookup_validate,
+	.reduce		= nft_lookup_reduce,
 };
 
 struct nft_expr_type nft_lookup_type __read_mostly = {
-- 
2.30.2

