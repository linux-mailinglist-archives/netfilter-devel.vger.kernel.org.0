Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123A565F839
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Jan 2023 01:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjAFAio (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Jan 2023 19:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbjAFAhk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Jan 2023 19:37:40 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0433763F54
        for <netfilter-devel@vger.kernel.org>; Thu,  5 Jan 2023 16:37:37 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v2 4/4] netfilter: nf_tables: allow to create netdev chain without device
Date:   Fri,  6 Jan 2023 01:37:29 +0100
Message-Id: <20230106003729.26596-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230106003729.26596-1-pablo@netfilter.org>
References: <20230106003729.26596-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v2: new in this series.

 net/netfilter/nf_tables_api.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 53531e958f01..80542877f9df 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2005,9 +2005,8 @@ struct nft_chain_hook {
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
@@ -2024,19 +2023,20 @@ static int nft_chain_parse_netdev(struct net *net,
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
@@ -2095,7 +2095,7 @@ static int nft_chain_parse_hook(struct net *net,
 
 	INIT_LIST_HEAD(&hook->list);
 	if (nft_base_chain_netdev(family, hook->num)) {
-		err = nft_chain_parse_netdev(net, ha, &hook->list);
+		err = nft_chain_parse_netdev(net, ha, &hook->list, flags);
 		if (err < 0) {
 			module_put(type->owner);
 			return err;
@@ -2238,8 +2238,8 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 		if (flags & NFT_CHAIN_BINDING)
 			return -EOPNOTSUPP;
 
-		err = nft_chain_parse_hook(net, nla, &hook, family, extack,
-					   true);
+		err = nft_chain_parse_hook(net, nla, &hook, family, flags,
+					   extack, true);
 		if (err < 0)
 			return err;
 
@@ -2381,7 +2381,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 			return -EEXIST;
 		}
 		err = nft_chain_parse_hook(ctx->net, nla, &hook, ctx->family,
-					   extack, false);
+					   flags, extack, false);
 		if (err < 0)
 			return err;
 
@@ -2657,7 +2657,7 @@ static int nft_delchain_hook(struct nft_ctx *ctx, struct nft_chain *chain,
 		return -EOPNOTSUPP;
 
 	err = nft_chain_parse_hook(ctx->net, nla, &chain_hook, ctx->family,
-				   extack, false);
+				   chain->flags, extack, false);
 	if (err < 0)
 		return err;
 
-- 
2.30.2

