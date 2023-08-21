Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F295A782D16
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Aug 2023 17:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjHUPS1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Aug 2023 11:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjHUPS1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:18:27 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF14DF1
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Aug 2023 08:18:25 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qY6fg-0003wo-J5; Mon, 21 Aug 2023 17:18:24 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: nf_tables: allow loop termination for pending fatal signal
Date:   Mon, 21 Aug 2023 17:18:17 +0200
Message-ID: <20230821151820.21155-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index c62227ae7746..271c643f055f 100644
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
 
@@ -10459,6 +10462,9 @@ static int nf_tables_check_loops(const struct nft_ctx *ctx,
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

