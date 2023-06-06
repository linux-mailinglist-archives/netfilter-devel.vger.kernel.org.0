Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59758724940
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Jun 2023 18:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbjFFQfq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Jun 2023 12:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237905AbjFFQfp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:35:45 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DB5410DB
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Jun 2023 09:35:44 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nf-next,v2 7/7] netfilter: nf_tables: skip comment match when building blob
Date:   Tue,  6 Jun 2023 18:35:33 +0200
Message-Id: <20230606163533.1533-8-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230606163533.1533-1-pablo@netfilter.org>
References: <20230606163533.1533-1-pablo@netfilter.org>
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

Use tracking infrastructure to skip the comment match when building
the ruleset blob, this restores the comment match suppression done in
c828414ac935 ("netfilter: nft_compat: suppress comment match"). If
.track returns -1, then skip the expression.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes

 net/netfilter/nf_tables_api.c |  4 ++++
 net/netfilter/nft_compat.c    | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index dc0b5e1ada16..6b33fd0228e5 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8918,6 +8918,10 @@ static int nft_expr_track(struct nft_expr_track_ctx *ctx,
 	ret = expr->ops->track(ctx, &expr_track->expr[num_exprs], expr);
 	if (ret > 0)
 		return 1;
+	else if (ret < 0) {
+		expr_track->num_exprs--;
+		return 0;
+	}
 
 	switch (num_exprs) {
 	case 0:
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index af88078caf99..c72e2a39fe34 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -734,6 +734,18 @@ static const struct nfnetlink_subsystem nfnl_compat_subsys = {
 
 static struct nft_expr_type nft_match_type;
 
+static int nft_match_track(struct nft_expr_track_ctx *ctx,
+			   struct nft_expr_track *track,
+			   const struct nft_expr *expr)
+{
+	const struct xt_match *match = expr->ops->data;
+
+	if (!strcmp(match->name, "comment"))
+		return -1;
+
+	return 1;
+}
+
 static const struct nft_expr_ops *
 nft_match_select_ops(const struct nft_ctx *ctx,
 		     const struct nlattr * const tb[])
@@ -776,6 +788,7 @@ nft_match_select_ops(const struct nft_ctx *ctx,
 	ops->dump = nft_match_dump;
 	ops->validate = nft_match_validate;
 	ops->data = match;
+	ops->track = nft_match_track;
 
 	matchsize = NFT_EXPR_SIZE(XT_ALIGN(match->matchsize));
 	if (matchsize > NFT_MATCH_LARGE_THRESH) {
-- 
2.30.2

