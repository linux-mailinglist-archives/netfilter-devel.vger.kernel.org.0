Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747CB4D6FD9
	for <lists+netfilter-devel@lfdr.de>; Sat, 12 Mar 2022 16:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiCLPt3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 12 Mar 2022 10:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiCLPt0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:49:26 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70B548BE1B
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Mar 2022 07:48:20 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 9B51662FF3
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Mar 2022 16:46:11 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 6/9] netfilter: nft_numgen: cancel register tracking
Date:   Sat, 12 Mar 2022 16:48:08 +0100
Message-Id: <20220312154811.68611-7-pablo@netfilter.org>
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

Random and increment are stateful, each invocation results in fresh output.
Cancel register tracking for these two expressions.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_numgen.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/netfilter/nft_numgen.c b/net/netfilter/nft_numgen.c
index 1d378efd8823..81b40c663d86 100644
--- a/net/netfilter/nft_numgen.c
+++ b/net/netfilter/nft_numgen.c
@@ -85,6 +85,16 @@ static int nft_ng_inc_init(const struct nft_ctx *ctx,
 	return err;
 }
 
+static bool nft_ng_inc_reduce(struct nft_regs_track *track,
+				 const struct nft_expr *expr)
+{
+	const struct nft_ng_inc *priv = nft_expr_priv(expr);
+
+	nft_reg_track_cancel(track, priv->dreg, NFT_REG32_SIZE);
+
+	return false;
+}
+
 static int nft_ng_dump(struct sk_buff *skb, enum nft_registers dreg,
 		       u32 modulus, enum nft_ng_types type, u32 offset)
 {
@@ -172,6 +182,16 @@ static int nft_ng_random_dump(struct sk_buff *skb, const struct nft_expr *expr)
 			   priv->offset);
 }
 
+static bool nft_ng_random_reduce(struct nft_regs_track *track,
+				 const struct nft_expr *expr)
+{
+	const struct nft_ng_random *priv = nft_expr_priv(expr);
+
+	nft_reg_track_cancel(track, priv->dreg, NFT_REG32_SIZE);
+
+	return false;
+}
+
 static struct nft_expr_type nft_ng_type;
 static const struct nft_expr_ops nft_ng_inc_ops = {
 	.type		= &nft_ng_type,
@@ -180,6 +200,7 @@ static const struct nft_expr_ops nft_ng_inc_ops = {
 	.init		= nft_ng_inc_init,
 	.destroy	= nft_ng_inc_destroy,
 	.dump		= nft_ng_inc_dump,
+	.reduce		= nft_ng_inc_reduce,
 };
 
 static const struct nft_expr_ops nft_ng_random_ops = {
@@ -188,6 +209,7 @@ static const struct nft_expr_ops nft_ng_random_ops = {
 	.eval		= nft_ng_random_eval,
 	.init		= nft_ng_random_init,
 	.dump		= nft_ng_random_dump,
+	.reduce		= nft_ng_random_reduce,
 };
 
 static const struct nft_expr_ops *
-- 
2.30.2

