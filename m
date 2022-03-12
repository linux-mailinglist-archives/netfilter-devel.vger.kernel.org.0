Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452C84D6FDB
	for <lists+netfilter-devel@lfdr.de>; Sat, 12 Mar 2022 16:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiCLPta (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 12 Mar 2022 10:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiCLPt0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:49:26 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1339C8BE35
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Mar 2022 07:48:21 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 4BFE160868
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Mar 2022 16:46:12 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 8/9] netfilter: nft_hash: track register operations
Date:   Sat, 12 Mar 2022 16:48:10 +0100
Message-Id: <20220312154811.68611-9-pablo@netfilter.org>
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

Check if the destination register already contains the data that this
osf store expression performs. Always cancel register tracking for jhash
since this requires tracking multiple source registers in case of
concatenations. Perform register tracking (without bitwise) for symhash
since input does not come from source register.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_hash.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/netfilter/nft_hash.c b/net/netfilter/nft_hash.c
index f829f5289e16..20f40ae451da 100644
--- a/net/netfilter/nft_hash.c
+++ b/net/netfilter/nft_hash.c
@@ -165,6 +165,16 @@ static int nft_jhash_dump(struct sk_buff *skb,
 	return -1;
 }
 
+static bool nft_jhash_reduce(struct nft_regs_track *track,
+			     const struct nft_expr *expr)
+{
+	const struct nft_jhash *priv = nft_expr_priv(expr);
+
+	nft_reg_track_cancel(track, priv->dreg, sizeof(u32));
+
+	return false;
+}
+
 static int nft_symhash_dump(struct sk_buff *skb,
 			    const struct nft_expr *expr)
 {
@@ -185,6 +195,31 @@ static int nft_symhash_dump(struct sk_buff *skb,
 	return -1;
 }
 
+static bool nft_symhash_reduce(struct nft_regs_track *track,
+			       const struct nft_expr *expr)
+{
+	struct nft_symhash *priv = nft_expr_priv(expr);
+	struct nft_symhash *symhash;
+
+	if (!track->regs[priv->dreg].selector ||
+	    track->regs[priv->dreg].selector->ops != expr->ops) {
+		nft_reg_track_update(track, expr, priv->dreg, sizeof(u32));
+		return false;
+	}
+
+	symhash = nft_expr_priv(track->regs[priv->dreg].selector);
+	if (priv->offset != symhash->offset ||
+	    priv->modulus != symhash->modulus) {
+		nft_reg_track_update(track, expr, priv->dreg, sizeof(u32));
+		return false;
+	}
+
+	if (!track->regs[priv->dreg].bitwise)
+		return true;
+
+	return false;
+}
+
 static struct nft_expr_type nft_hash_type;
 static const struct nft_expr_ops nft_jhash_ops = {
 	.type		= &nft_hash_type,
@@ -192,6 +227,7 @@ static const struct nft_expr_ops nft_jhash_ops = {
 	.eval		= nft_jhash_eval,
 	.init		= nft_jhash_init,
 	.dump		= nft_jhash_dump,
+	.reduce		= nft_jhash_reduce,
 };
 
 static const struct nft_expr_ops nft_symhash_ops = {
@@ -200,6 +236,7 @@ static const struct nft_expr_ops nft_symhash_ops = {
 	.eval		= nft_symhash_eval,
 	.init		= nft_symhash_init,
 	.dump		= nft_symhash_dump,
+	.reduce		= nft_symhash_reduce,
 };
 
 static const struct nft_expr_ops *
-- 
2.30.2

