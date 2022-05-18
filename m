Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ED052B88C
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 May 2022 13:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiERLUQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 May 2022 07:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbiERLUK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 May 2022 07:20:10 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 522C5174918
        for <netfilter-devel@vger.kernel.org>; Wed, 18 May 2022 04:20:09 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v2] netfilter: nf_tables: restrict expression reduction to first expression
Date:   Wed, 18 May 2022 13:20:05 +0200
Message-Id: <20220518112005.83193-1-pablo@netfilter.org>
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
v2: simplify logic, proposed by Phil Sutter.

 net/netfilter/nf_tables_api.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 16c3a39689f4..3365160f3403 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8362,6 +8362,7 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 	void *data, *data_boundary;
 	struct nft_rule_dp *prule;
 	struct nft_rule *rule;
+	bool reduce;
 
 	/* already handled or inactive chain? */
 	if (chain->blob_next || !nft_is_active_next(net, chain))
@@ -8398,13 +8399,16 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 
 		size = 0;
 		track.last = nft_expr_last(rule);
+		reduce = true;
 		nft_rule_for_each_expr(expr, last, rule) {
 			track.cur = expr;
 
-			if (nft_expr_reduce(&track, expr)) {
+			if (nft_expr_reduce(&track, expr) && reduce) {
+				reduce = false;
 				expr = track.cur;
 				continue;
 			}
+			reduce = false;
 
 			if (WARN_ON_ONCE(data + expr->ops->size > data_boundary))
 				return -ENOMEM;
-- 
2.30.2

