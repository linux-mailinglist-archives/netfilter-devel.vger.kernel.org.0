Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D5658254F
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Jul 2022 13:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiG0LUb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Jul 2022 07:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiG0LU3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:20:29 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A465A101F0
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Jul 2022 04:20:28 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1oGf5X-0003c2-5W; Wed, 27 Jul 2022 13:20:27 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 4/7] debug: dump the l2 protocol stack
Date:   Wed, 27 Jul 2022 13:20:00 +0200
Message-Id: <20220727112003.26022-5-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220727112003.26022-1-fw@strlen.de>
References: <20220727112003.26022-1-fw@strlen.de>
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

Previously we used to print the cumulative size of the headers,
update this to print the tracked l2 stack.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/proto.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/proto.c b/src/proto.c
index 2663f216860b..c49648275e12 100644
--- a/src/proto.c
+++ b/src/proto.c
@@ -154,6 +154,12 @@ static void proto_ctx_debug(const struct proto_ctx *ctx, enum proto_bases base,
 	if (!(debug_mask & NFT_DEBUG_PROTO_CTX))
 		return;
 
+	if (base == PROTO_BASE_LL_HDR && ctx->stacked_ll_count) {
+		pr_debug(" saved ll headers:");
+		for (i = 0; i < ctx->stacked_ll_count; i++)
+			pr_debug(" %s", ctx->stacked_ll[i]->name);
+	}
+
 	pr_debug("update %s protocol context:\n", proto_base_names[base]);
 	for (i = PROTO_BASE_LL_HDR; i <= PROTO_BASE_MAX; i++) {
 		pr_debug(" %-20s: %s",
-- 
2.35.1

