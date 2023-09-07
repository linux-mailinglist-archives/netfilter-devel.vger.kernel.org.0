Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06979794603
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Sep 2023 00:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244912AbjIFWMc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Sep 2023 18:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjIFWMb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:12:31 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DBC419B9
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Sep 2023 15:12:26 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables: skip deactivation of deleted rules in bound chain
Date:   Thu,  7 Sep 2023 00:12:19 +0200
Message-Id: <20230906221219.1378-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Rules can still be deleted from unbound chains. Mark them as deleted
in the next generation so they are not reachable anymore. Skip deleted
rules when this (now) bound chain is removed.

Fixes: 0a771f7b266b ("netfilter: nf_tables: skip immediate deactivate in _PREPARE_ERROR")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_immediate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index fccb3cf7749c..d6d1d94532eb 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -135,8 +135,13 @@ static void nft_immediate_chain_deactivate(const struct nft_ctx *ctx,
 	chain_ctx = *ctx;
 	chain_ctx.chain = chain;
 
-	list_for_each_entry(rule, &chain->rules, list)
+	list_for_each_entry(rule, &chain->rules, list) {
+		if (!nft_is_active_next(ctx->net, rule))
+			continue;
+
+		nft_deactivate_next(ctx->net, rule);
 		nft_rule_expr_deactivate(&chain_ctx, rule, phase);
+	}
 }
 
 static void nft_immediate_deactivate(const struct nft_ctx *ctx,
-- 
2.30.2

