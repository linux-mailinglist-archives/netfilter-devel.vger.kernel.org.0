Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5402053B484
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Jun 2022 09:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiFBHoD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 2 Jun 2022 03:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiFBHoC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:44:02 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D7E7131F14
        for <netfilter-devel@vger.kernel.org>; Thu,  2 Jun 2022 00:44:01 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 2/3] netfilter: nf_tables: memleak in nft_expr_init() path
Date:   Thu,  2 Jun 2022 09:43:56 +0200
Message-Id: <20220602074357.332409-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602074357.332409-1-pablo@netfilter.org>
References: <20220602074357.332409-1-pablo@netfilter.org>
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

Since ed0a0c60f0e5 ("netfilter: nft_quota: move stateful fields out of
expression data"), stateful expressions allocate stateful area via
kmalloc().

Call ->ops->destroy() to release expression stateful information before
releasing the expression.

->ops->deactivate() is also called for safety reasons, no stateful
expressions support for this function.

Fixes: 6cafaf4764a3 ("netfilter: nf_tables: fix memory leak if expr init fails")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 5ee4e7b28b61..017b77067852 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2904,6 +2904,11 @@ static struct nft_expr *nft_expr_init(const struct nft_ctx *ctx,
 
 	return expr;
 err_expr_new:
+	if (expr->ops->deactivate)
+		expr->ops->deactivate(ctx, expr, NFT_TRANS_RELEASE);
+	if (expr_info.ops->destroy)
+		expr_info.ops->destroy(ctx, expr);
+
 	kfree(expr);
 err_expr_stateful:
 	owner = expr_info.ops->type->owner;
-- 
2.30.2

