Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972126E7620
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Apr 2023 11:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjDSJUj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Apr 2023 05:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjDSJUi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:20:38 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B144E5FEC
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Apr 2023 02:20:36 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v3 5/5] netfilter: nf_tables: allow to create netdev chain without device
Date:   Wed, 19 Apr 2023 11:20:29 +0200
Message-Id: <20230419092029.68913-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230419092029.68913-1-pablo@netfilter.org>
References: <20230419092029.68913-1-pablo@netfilter.org>
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

Relax netdev chain creation to allow for loading the ruleset, then
adding/deleting devices at a later stage. Hardware offload does not
support for this feature yet.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: rebase on top of nf-next

 net/netfilter/nf_tables_api.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 2ef92077b98f..c3f52131b47a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2021,9 +2021,8 @@ struct nft_chain_hook {
 	struct list_head		list;
 };
 
-static int nft_chain_parse_netdev(struct net *net,
-				  struct nlattr *tb[],
-				  struct list_head *hook_list)
+static int nft_chain_parse_netdev(struct net *net, struct nlattr *tb[],
+				  struct list_head *hook_list, u32 flags)
 {
 	struct nft_hook *hook;
 	int err;
@@ -2040,19 +2039,20 @@ static int nft_chain_parse_netdev(struct net *net,
 		if (err < 0)
 			return err;
 
-		if (list_empty(hook_list))
-			return -EINVAL;
-	} else {
-		return -EINVAL;
 	}
 
+	if (flags & NFT_CHAIN_HW_OFFLOAD &&
+	    list_empty(hook_list))
+		return -EINVAL;
+
 	return 0;
 }
 
 static int nft_chain_parse_hook(struct net *net,
 				const struct nlattr * const nla[],
 				struct nft_chain_hook *hook, u8 family,
-				struct netlink_ext_ack *extack, bool add)
+				u32 flags, struct netlink_ext_ack *extack,
+				bool add)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 	struct nlattr *ha[NFTA_HOOK_MAX + 1];
@@ -2111,7 +2111,7 @@ static int nft_chain_parse_hook(struct net *net,
 
 	INIT_LIST_HEAD(&hook->list);
 	if (nft_base_chain_netdev(family, hook->num)) {
-		err = nft_chain_parse_netdev(net, ha, &hook->list);
+		err = nft_chain_parse_netdev(net, ha, &hook->list, flags);
 		if (err < 0) {
 			module_put(type->owner);
 			return err;
@@ -2254,8 +2254,8 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 		if (flags & NFT_CHAIN_BINDING)
 			return -EOPNOTSUPP;
 
-		err = nft_chain_parse_hook(net, nla, &hook, family, extack,
-					   true);
+		err = nft_chain_parse_hook(net, nla, &hook, family, flags,
+					   extack, true);
 		if (err < 0)
 			return err;
 
@@ -2397,7 +2397,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 			return -EEXIST;
 		}
 		err = nft_chain_parse_hook(ctx->net, nla, &hook, ctx->family,
-					   extack, false);
+					   flags, extack, false);
 		if (err < 0)
 			return err;
 
@@ -2673,7 +2673,7 @@ static int nft_delchain_hook(struct nft_ctx *ctx, struct nft_chain *chain,
 		return -EOPNOTSUPP;
 
 	err = nft_chain_parse_hook(ctx->net, nla, &chain_hook, ctx->family,
-				   extack, false);
+				   chain->flags, extack, false);
 	if (err < 0)
 		return err;
 
-- 
2.30.2

