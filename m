Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB9D59B430
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Aug 2022 16:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiHUOBc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 21 Aug 2022 10:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiHUOA1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 21 Aug 2022 10:00:27 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E525424BD1
        for <netfilter-devel@vger.kernel.org>; Sun, 21 Aug 2022 06:59:32 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v2] netfilter: nft_dup: validate family and chains
Date:   Sun, 21 Aug 2022 15:59:24 +0200
Message-Id: <20220821135924.2539-1-pablo@netfilter.org>
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

This only supports for netdev family and ingress and egress hooks.

Fixes: 502061f81d3e ("netfilter: nf_tables: add packet duplication to the netdev family")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: family is already validated via .family field in expression type

 net/netfilter/nft_dup_netdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/netfilter/nft_dup_netdev.c b/net/netfilter/nft_dup_netdev.c
index 63507402716d..1d5bbe8d2660 100644
--- a/net/netfilter/nft_dup_netdev.c
+++ b/net/netfilter/nft_dup_netdev.c
@@ -44,6 +44,14 @@ static int nft_dup_netdev_init(const struct nft_ctx *ctx,
 				       sizeof(int));
 }
 
+static int nft_dup_netdev_validate(const struct nft_ctx *ctx,
+				   const struct nft_expr *expr,
+				   const struct nft_data **data)
+{
+	return nft_chain_validate_hooks(ctx->chain, (1 << NF_NETDEV_INGRESS) |
+						    (1 << NF_NETDEV_EGRESS));
+}
+
 static int nft_dup_netdev_dump(struct sk_buff *skb, const struct nft_expr *expr)
 {
 	struct nft_dup_netdev *priv = nft_expr_priv(expr);
@@ -79,6 +87,7 @@ static const struct nft_expr_ops nft_dup_netdev_ops = {
 	.eval		= nft_dup_netdev_eval,
 	.init		= nft_dup_netdev_init,
 	.dump		= nft_dup_netdev_dump,
+	.validate	= nft_dup_netdev_validate,
 	.reduce		= NFT_REDUCE_READONLY,
 	.offload	= nft_dup_netdev_offload,
 	.offload_action	= nft_dup_netdev_offload_action,
-- 
2.30.2

