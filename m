Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB9A52BD0C
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 May 2022 16:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbiERMvj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 May 2022 08:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiERMvi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 May 2022 08:51:38 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 768DF9FE4
        for <netfilter-devel@vger.kernel.org>; Wed, 18 May 2022 05:51:37 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, phil@nwl.cc
Subject: [PATCH nf] netfilter: nf_tables: disable expression reduction infra
Date:   Wed, 18 May 2022 14:51:34 +0200
Message-Id: <20220518125134.193358-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Either userspace or kernelspace need to pre-fetch keys inconditionally
before comparisons for this to work. Otherwise, register tracking data
is misleading and it might result in reducing expressions which are not
yet registers.

First expression is also guaranteed to be evaluated always, therefore,
since some expression, eg. nft_meta for certain keys to break before
comparison. Other expressions such as nft_socket rely on packet
evaluation for the socket object, otherwise break before the comparison,
in this case tracking should be canceled.

This patch disables this infrastructure by now.

Fixes: b2d306542ff9 ("netfilter: nf_tables: do not reduce read-only expressions")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 16c3a39689f4..a096b9fbbbdf 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8342,16 +8342,7 @@ EXPORT_SYMBOL_GPL(nf_tables_trans_destroy_flush_work);
 static bool nft_expr_reduce(struct nft_regs_track *track,
 			    const struct nft_expr *expr)
 {
-	if (!expr->ops->reduce) {
-		pr_warn_once("missing reduce for expression %s ",
-			     expr->ops->type->name);
-		return false;
-	}
-
-	if (nft_reduce_is_readonly(expr))
-		return false;
-
-	return expr->ops->reduce(track, expr);
+	return false;
 }
 
 static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *chain)
-- 
2.30.2

