Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18408763AF6
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jul 2023 17:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjGZPZm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Jul 2023 11:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjGZPZl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:25:41 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6777794;
        Wed, 26 Jul 2023 08:25:40 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qOgOO-0001HD-F8; Wed, 26 Jul 2023 17:25:36 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netdev@vger.kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Kevin Rich <kevinrich1337@gmail.com>
Subject: [PATCH net 2/3] netfilter: nf_tables: skip immediate deactivate in _PREPARE_ERROR
Date:   Wed, 26 Jul 2023 17:23:48 +0200
Message-ID: <20230726152524.26268-3-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726152524.26268-1-fw@strlen.de>
References: <20230726152524.26268-1-fw@strlen.de>
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

On error when building the rule, the immediate expression unbinds the
chain, hence objects can be deactivated by the transaction records.

Otherwise, it is possible to trigger the following warning:

 WARNING: CPU: 3 PID: 915 at net/netfilter/nf_tables_api.c:2013 nf_tables_chain_destroy+0x1f7/0x210 [nf_tables]
 CPU: 3 PID: 915 Comm: chain-bind-err- Not tainted 6.1.39 #1
 RIP: 0010:nf_tables_chain_destroy+0x1f7/0x210 [nf_tables]

Fixes: 4bedf9eee016 ("netfilter: nf_tables: fix chain binding transaction logic")
Reported-by: Kevin Rich <kevinrich1337@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_immediate.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index 407d7197f75b..fccb3cf7749c 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -125,15 +125,27 @@ static void nft_immediate_activate(const struct nft_ctx *ctx,
 	return nft_data_hold(&priv->data, nft_dreg_to_type(priv->dreg));
 }
 
+static void nft_immediate_chain_deactivate(const struct nft_ctx *ctx,
+					   struct nft_chain *chain,
+					   enum nft_trans_phase phase)
+{
+	struct nft_ctx chain_ctx;
+	struct nft_rule *rule;
+
+	chain_ctx = *ctx;
+	chain_ctx.chain = chain;
+
+	list_for_each_entry(rule, &chain->rules, list)
+		nft_rule_expr_deactivate(&chain_ctx, rule, phase);
+}
+
 static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 				     const struct nft_expr *expr,
 				     enum nft_trans_phase phase)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
 	const struct nft_data *data = &priv->data;
-	struct nft_ctx chain_ctx;
 	struct nft_chain *chain;
-	struct nft_rule *rule;
 
 	if (priv->dreg == NFT_REG_VERDICT) {
 		switch (data->verdict.code) {
@@ -143,20 +155,17 @@ static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 			if (!nft_chain_binding(chain))
 				break;
 
-			chain_ctx = *ctx;
-			chain_ctx.chain = chain;
-
-			list_for_each_entry(rule, &chain->rules, list)
-				nft_rule_expr_deactivate(&chain_ctx, rule, phase);
-
 			switch (phase) {
 			case NFT_TRANS_PREPARE_ERROR:
 				nf_tables_unbind_chain(ctx, chain);
-				fallthrough;
+				nft_deactivate_next(ctx->net, chain);
+				break;
 			case NFT_TRANS_PREPARE:
+				nft_immediate_chain_deactivate(ctx, chain, phase);
 				nft_deactivate_next(ctx->net, chain);
 				break;
 			default:
+				nft_immediate_chain_deactivate(ctx, chain, phase);
 				nft_chain_del(chain);
 				chain->bound = false;
 				nft_use_dec(&chain->table->use);
-- 
2.41.0

