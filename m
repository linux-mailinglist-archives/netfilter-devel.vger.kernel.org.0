Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FE34D6FD6
	for <lists+netfilter-devel@lfdr.de>; Sat, 12 Mar 2022 16:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiCLPt1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 12 Mar 2022 10:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiCLPt0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:49:26 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 170068B6F1
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Mar 2022 07:48:20 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 54C1462FEA
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Mar 2022 16:46:11 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 5/9] netfilter: nft_meta: extend reduce support to bridge family
Date:   Sat, 12 Mar 2022 16:48:07 +0100
Message-Id: <20220312154811.68611-6-pablo@netfilter.org>
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

its enough to export the meta get reduce helper and then call it
from nft_meta_bridge too.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nft_meta.h       | 2 ++
 net/bridge/netfilter/nft_meta_bridge.c | 1 +
 net/netfilter/nft_meta.c               | 5 +++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/netfilter/nft_meta.h b/include/net/netfilter/nft_meta.h
index 246fd023dcf4..9b51cc67de54 100644
--- a/include/net/netfilter/nft_meta.h
+++ b/include/net/netfilter/nft_meta.h
@@ -44,4 +44,6 @@ int nft_meta_set_validate(const struct nft_ctx *ctx,
 			  const struct nft_expr *expr,
 			  const struct nft_data **data);
 
+bool nft_meta_get_reduce(struct nft_regs_track *track,
+			 const struct nft_expr *expr);
 #endif
diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index 380a31ebf840..8c3eaba87ad2 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -99,6 +99,7 @@ static const struct nft_expr_ops nft_meta_bridge_get_ops = {
 	.eval		= nft_meta_bridge_get_eval,
 	.init		= nft_meta_bridge_get_init,
 	.dump		= nft_meta_get_dump,
+	.reduce		= nft_meta_get_reduce,
 };
 
 static bool nft_meta_bridge_set_reduce(struct nft_regs_track *track,
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 994ff41f4119..92b000f0e183 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -752,8 +752,8 @@ static int nft_meta_get_offload(struct nft_offload_ctx *ctx,
 	return 0;
 }
 
-static bool nft_meta_get_reduce(struct nft_regs_track *track,
-				const struct nft_expr *expr)
+bool nft_meta_get_reduce(struct nft_regs_track *track,
+			 const struct nft_expr *expr)
 {
 	const struct nft_meta *priv = nft_expr_priv(expr);
 	const struct nft_meta *meta;
@@ -776,6 +776,7 @@ static bool nft_meta_get_reduce(struct nft_regs_track *track,
 
 	return nft_expr_reduce_bitwise(track, expr);
 }
+EXPORT_SYMBOL_GPL(nft_meta_get_reduce);
 
 static const struct nft_expr_ops nft_meta_get_ops = {
 	.type		= &nft_meta_type,
-- 
2.30.2

