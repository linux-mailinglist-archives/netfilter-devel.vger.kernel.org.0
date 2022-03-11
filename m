Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2443F4D5BD0
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Mar 2022 07:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiCKHAq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Mar 2022 02:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiCKHAp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:00:45 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDECF19D624
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Mar 2022 22:59:42 -0800 (PST)
Received: from localhost.localdomain (unknown [31.221.131.6])
        by mail.netfilter.org (Postfix) with ESMTPSA id E34C9601DC;
        Fri, 11 Mar 2022 07:57:38 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nf,v4] netfilter: nf_tables: cancel register tracking if .reduce is not defined
Date:   Fri, 11 Mar 2022 07:59:35 +0100
Message-Id: <20220311065935.8401-1-pablo@netfilter.org>
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

Cancel all register tracking if the reduce function is not defined. Add
missing reduce function to cmp, immediate, counter and compat since
these are read-only register.

This patch unbreaks selftests/netfilter/nft_nat_zones.sh.

Fixes: 12e4ecfa244b ("netfilter: nf_tables: add register tracking infrastructure")
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v4: verdict through immediate might also cancel tracking.

 net/netfilter/nf_tables_api.c |  2 ++
 net/netfilter/nft_cmp.c       |  8 ++++++++
 net/netfilter/nft_compat.c    | 14 ++++++++++++++
 net/netfilter/nft_counter.c   |  7 +++++++
 net/netfilter/nft_immediate.c | 14 ++++++++++++++
 5 files changed, 45 insertions(+)

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
 
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index f69cc73c5813..404cc806d12b 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -731,6 +731,12 @@ static const struct nfnetlink_subsystem nfnl_compat_subsys = {
 
 static struct nft_expr_type nft_match_type;
 
+static bool nft_match_reduce(struct nft_regs_track *track,
+			     const struct nft_expr *expr)
+{
+	return false;
+}
+
 static const struct nft_expr_ops *
 nft_match_select_ops(const struct nft_ctx *ctx,
 		     const struct nlattr * const tb[])
@@ -773,6 +779,7 @@ nft_match_select_ops(const struct nft_ctx *ctx,
 	ops->dump = nft_match_dump;
 	ops->validate = nft_match_validate;
 	ops->data = match;
+	ops->reduce = nft_match_reduce;
 
 	matchsize = NFT_EXPR_SIZE(XT_ALIGN(match->matchsize));
 	if (matchsize > NFT_MATCH_LARGE_THRESH) {
@@ -811,6 +818,12 @@ static struct nft_expr_type nft_match_type __read_mostly = {
 
 static struct nft_expr_type nft_target_type;
 
+static bool nft_target_reduce(struct nft_regs_track *track,
+			      const struct nft_expr *expr)
+{
+	return false;
+}
+
 static const struct nft_expr_ops *
 nft_target_select_ops(const struct nft_ctx *ctx,
 		      const struct nlattr * const tb[])
@@ -862,6 +875,7 @@ nft_target_select_ops(const struct nft_ctx *ctx,
 	ops->dump = nft_target_dump;
 	ops->validate = nft_target_validate;
 	ops->data = target;
+	ops->reduce = nft_target_reduce;
 
 	if (family == NFPROTO_BRIDGE)
 		ops->eval = nft_target_eval_bridge;
diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index f179e8c3b0ca..cd923c030353 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -283,6 +283,12 @@ void nft_counter_init_seqcount(void)
 		seqcount_init(per_cpu_ptr(&nft_counter_seq, cpu));
 }
 
+static bool nft_counter_reduce(struct nft_regs_track *track,
+			       const struct nft_expr *expr)
+{
+	return false;
+}
+
 struct nft_expr_type nft_counter_type;
 static const struct nft_expr_ops nft_counter_ops = {
 	.type		= &nft_counter_type,
@@ -293,6 +299,7 @@ static const struct nft_expr_ops nft_counter_ops = {
 	.destroy_clone	= nft_counter_destroy,
 	.dump		= nft_counter_dump,
 	.clone		= nft_counter_clone,
+	.reduce		= nft_counter_reduce,
 	.offload	= nft_counter_offload,
 	.offload_stats	= nft_counter_offload_stats,
 };
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index d0f67d325bdf..45b14af3c523 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -223,6 +223,19 @@ static bool nft_immediate_offload_action(const struct nft_expr *expr)
 	return false;
 }
 
+static bool nft_immediate_reduce(struct nft_regs_track *track,
+				 const struct nft_expr *expr)
+{
+	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
+
+	if (priv->dreg != NFT_REG_VERDICT) {
+		track->regs[priv->dreg].selector = NULL;
+		track->regs[priv->dreg].bitwise = NULL;
+	}
+
+	return false;
+}
+
 static const struct nft_expr_ops nft_imm_ops = {
 	.type		= &nft_imm_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_immediate_expr)),
@@ -233,6 +246,7 @@ static const struct nft_expr_ops nft_imm_ops = {
 	.destroy	= nft_immediate_destroy,
 	.dump		= nft_immediate_dump,
 	.validate	= nft_immediate_validate,
+	.reduce		= nft_immediate_reduce,
 	.offload	= nft_immediate_offload,
 	.offload_action	= nft_immediate_offload_action,
 };
-- 
2.30.2

