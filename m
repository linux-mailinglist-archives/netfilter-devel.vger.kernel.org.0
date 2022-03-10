Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7E74D54B0
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Mar 2022 23:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbiCJWiz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Mar 2022 17:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237358AbiCJWit (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:38:49 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4BB5B2387
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Mar 2022 14:37:45 -0800 (PST)
Received: from localhost.localdomain (unknown [46.222.150.172])
        by mail.netfilter.org (Postfix) with ESMTPSA id AB95460022;
        Thu, 10 Mar 2022 23:35:40 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nf] netfilter: nf_tables: cancel register tracking if .reduce is not defined
Date:   Thu, 10 Mar 2022 23:37:37 +0100
Message-Id: <20220310223737.5261-1-pablo@netfilter.org>
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

Cancel all register tracking if the the reduce function is not defined.
Add missing reduce function to cmp since this is a read-only operation.

This unbreaks selftests/netfilter/nft_nat_zones.sh.

Fixes: 12e4ecfa244b ("netfilter: nf_tables: add register tracking infrastructure")
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 2 ++
 net/netfilter/nft_cmp.c       | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c86748b3873b..861a3a36024a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8311,6 +8311,8 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 			    expr->ops->reduce(&track, expr)) {
 				expr = track.cur;
 				continue;
+			} else if (expr->ops->reduce == NULL) {
+				memset(track.regs, 0, sizeof(track.regs));
 			}
 
 			if (WARN_ON_ONCE(data + expr->ops->size > data_boundary))
diff --git a/net/netfilter/nft_cmp.c b/net/netfilter/nft_cmp.c
index 47b6d05f1ae6..23bef7df48f1 100644
--- a/net/netfilter/nft_cmp.c
+++ b/net/netfilter/nft_cmp.c
@@ -187,12 +187,19 @@ static int nft_cmp_offload(struct nft_offload_ctx *ctx,
 	return __nft_cmp_offload(ctx, flow, priv);
 }
 
+static bool nft_cmp_reduce(struct nft_regs_track *track,
+			   const struct nft_expr *expr)
+{
+	return false;
+}
+
 static const struct nft_expr_ops nft_cmp_ops = {
 	.type		= &nft_cmp_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_cmp_expr)),
 	.eval		= nft_cmp_eval,
 	.init		= nft_cmp_init,
 	.dump		= nft_cmp_dump,
+	.reduce		= nft_cmp_reduce,
 	.offload	= nft_cmp_offload,
 };
 
@@ -269,6 +276,7 @@ const struct nft_expr_ops nft_cmp_fast_ops = {
 	.eval		= NULL,	/* inlined */
 	.init		= nft_cmp_fast_init,
 	.dump		= nft_cmp_fast_dump,
+	.reduce		= nft_cmp_reduce,
 	.offload	= nft_cmp_fast_offload,
 };
 
-- 
2.30.2

