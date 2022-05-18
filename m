Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A901B52B74E
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 May 2022 12:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiERKIt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 May 2022 06:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiERKIt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 May 2022 06:08:49 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF45D158949
        for <netfilter-devel@vger.kernel.org>; Wed, 18 May 2022 03:08:47 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc, fw@strlen.de
Subject: [PATCH] netfilter: nf_tables: restrict expression reduction to first expression
Date:   Wed, 18 May 2022 12:08:42 +0200
Message-Id: <20220518100842.1950-1-pablo@netfilter.org>
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

First expression is guaranteed to be evaluated always, therefore, keep
tracking registers and restrict reduction to first expression.

Fixes: b2d306542ff9 ("netfilter: nf_tables: do not reduce read-only expressions")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
@Phil, you mentioned about a way to simplify this patch, I don't see how,
just let me know.

 net/netfilter/nf_tables_api.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 16c3a39689f4..2c82fecc4094 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8362,6 +8362,7 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 	void *data, *data_boundary;
 	struct nft_rule_dp *prule;
 	struct nft_rule *rule;
+	bool reduce;
 
 	/* already handled or inactive chain? */
 	if (chain->blob_next || !nft_is_active_next(net, chain))
@@ -8398,12 +8399,18 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 
 		size = 0;
 		track.last = nft_expr_last(rule);
+		reduce = true;
 		nft_rule_for_each_expr(expr, last, rule) {
 			track.cur = expr;
 
 			if (nft_expr_reduce(&track, expr)) {
-				expr = track.cur;
-				continue;
+				if (reduce) {
+					reduce = false;
+					expr = track.cur;
+					continue;
+				}
+			} else if (reduce) {
+				reduce = false;
 			}
 
 			if (WARN_ON_ONCE(data + expr->ops->size > data_boundary))
-- 
2.30.2

