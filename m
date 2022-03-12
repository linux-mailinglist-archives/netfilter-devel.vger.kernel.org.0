Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B705A4D6E3F
	for <lists+netfilter-devel@lfdr.de>; Sat, 12 Mar 2022 11:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiCLKtW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 12 Mar 2022 05:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiCLKtW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 12 Mar 2022 05:49:22 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B06E66CBC
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Mar 2022 02:48:15 -0800 (PST)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 54A3A60866;
        Sat, 12 Mar 2022 11:46:06 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nf,v2] netfilter: nf_tables: disable register tracking
Date:   Sat, 12 Mar 2022 11:48:06 +0100
Message-Id: <20220312104806.11432-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
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

The register tracking infrastructure is incomplete, it might lead to
generating incorrect ruleset bytecode, disable it by now given we are
late in the release process.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: nft_expr_reduce() will be updated later on to re-enable this.

 net/netfilter/nf_tables_api.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c86748b3873b..ccbbe039b29b 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8260,6 +8260,11 @@ void nf_tables_trans_destroy_flush_work(void)
 }
 EXPORT_SYMBOL_GPL(nf_tables_trans_destroy_flush_work);
 
+static bool nft_expr_reduce(const struct nft_expr *expr)
+{
+	return false;
+}
+
 static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *chain)
 {
 	const struct nft_expr *expr, *last;
@@ -8307,8 +8312,7 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 		nft_rule_for_each_expr(expr, last, rule) {
 			track.cur = expr;
 
-			if (expr->ops->reduce &&
-			    expr->ops->reduce(&track, expr)) {
+			if (nft_expr_reduce(expr)) {
 				expr = track.cur;
 				continue;
 			}
-- 
2.30.2

