Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60435784600
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Aug 2023 17:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbjHVPo3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Aug 2023 11:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbjHVPo3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:44:29 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31E9CC1;
        Tue, 22 Aug 2023 08:44:27 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qYTYL-0003Ig-LJ; Tue, 22 Aug 2023 17:44:21 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netdev@vger.kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        <netfilter-devel@vger.kernel.org>
Subject: [PATCH net-next 10/10] netfilter: nf_tables: allow loop termination for pending fatal signal
Date:   Tue, 22 Aug 2023 17:43:31 +0200
Message-ID: <20230822154336.12888-11-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822154336.12888-1-fw@strlen.de>
References: <20230822154336.12888-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

abort early so task can exit faster if a fatal signal is pending,
no need to continue validation in that case.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3e841e45f2c0..f00a1dff85e8 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3675,6 +3675,9 @@ int nft_chain_validate(const struct nft_ctx *ctx, const struct nft_chain *chain)
 		return -EMLINK;
 
 	list_for_each_entry(rule, &chain->rules, list) {
+		if (fatal_signal_pending(current))
+			return -EINTR;
+
 		if (!nft_is_active_next(ctx->net, rule))
 			continue;
 
@@ -10479,6 +10482,9 @@ static int nf_tables_check_loops(const struct nft_ctx *ctx,
 	if (ctx->chain == chain)
 		return -ELOOP;
 
+	if (fatal_signal_pending(current))
+		return -EINTR;
+
 	list_for_each_entry(rule, &chain->rules, list) {
 		nft_rule_for_each_expr(expr, last, rule) {
 			struct nft_immediate_expr *priv;
-- 
2.41.0

