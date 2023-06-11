Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA7072B426
	for <lists+netfilter-devel@lfdr.de>; Sun, 11 Jun 2023 23:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjFKVWM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 11 Jun 2023 17:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFKVWM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 11 Jun 2023 17:22:12 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E8211AB
        for <netfilter-devel@vger.kernel.org>; Sun, 11 Jun 2023 14:22:09 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 2/6] netfilter: nf_tables: disallow element updates of bound anonymous sets
Date:   Sun, 11 Jun 2023 23:21:59 +0200
Message-Id: <20230611212203.1127-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230611212203.1127-1-pablo@netfilter.org>
References: <20230611212203.1127-1-pablo@netfilter.org>
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

Anonymous sets come with NFT_SET_CONSTANT from userspace. Although API
allows to create anonymous sets without NFT_SET_CONSTANT, it makes no
sense to allow to add and to delete elements for bound anonymous sets.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 467c2a20e16d..f008fdbe83e1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6644,7 +6644,8 @@ static int nf_tables_newsetelem(struct sk_buff *skb,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
@@ -6918,7 +6919,9 @@ static int nf_tables_delsetelem(struct sk_buff *skb,
 	set = nft_set_lookup(table, nla[NFTA_SET_ELEM_LIST_SET], genmask);
 	if (IS_ERR(set))
 		return PTR_ERR(set);
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
-- 
2.30.2

