Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1BE7D5117
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Oct 2023 15:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjJXNLJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Oct 2023 09:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjJXNKz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:10:55 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7151B10FA
        for <netfilter-devel@vger.kernel.org>; Tue, 24 Oct 2023 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nW93pXvZpxZ12dk+16SWWgz3CMLN4DRfIwn1T9ltt0A=; b=Yjfnagg4LxEQljH0Uf1Cz+iB3r
        uOPkET6gPgP1eT+5ZKakQIqTCnhdBNUJuNzPuMFiJ0NBcnps6T119Yb/WuTLG7sNrBKdM8VUJNSyt
        TXd8HD41sU3dpIbLSgUjZwUcbZ8Z+19+b9bH+fyRKqD1SG7y+TycwnVJ8k4T8YU1cZsQVefl/KeW3
        ppDTXluHEdhBrktgS9/P17DbpqycpWrtXkckPfL9KSJXvgPnF+IYYI7geRVDjgoZGFNH9+iZogh9s
        4Y73sYE0NSw9JFEO/v1rsB5CCph1+tly+5EpG9GcVl75LFaWbyVD1I6tkwz83cC9Akpuq2smUr87b
        YugEpZFA==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1qvHBE-0001vW-Af; Tue, 24 Oct 2023 15:10:44 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nf-next PATCH] netfilter: nf_tables: Carry reset boolean in nft_set_dump_ctx
Date:   Tue, 24 Oct 2023 15:10:40 +0200
Message-ID: <20231024131040.11622-1-phil@nwl.cc>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Relieve the dump callback from having to check nlmsg_type upon each
call. Prep work for set element reset locking.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 net/netfilter/nf_tables_api.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index bf269534ab0e..1d9382eea035 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5731,6 +5731,7 @@ static void audit_log_nft_set_reset(const struct nft_table *table,
 struct nft_set_dump_ctx {
 	const struct nft_set	*set;
 	struct nft_ctx		ctx;
+	bool			reset;
 };
 
 static int nft_set_catchall_dump(struct net *net, struct sk_buff *skb,
@@ -5770,7 +5771,6 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	bool set_found = false;
 	struct nlmsghdr *nlh;
 	struct nlattr *nest;
-	bool reset = false;
 	u32 portid, seq;
 	int event;
 
@@ -5818,12 +5818,9 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	if (nest == NULL)
 		goto nla_put_failure;
 
-	if (NFNL_MSG_TYPE(cb->nlh->nlmsg_type) == NFT_MSG_GETSETELEM_RESET)
-		reset = true;
-
 	args.cb			= cb;
 	args.skb		= skb;
-	args.reset		= reset;
+	args.reset		= dump_ctx->reset;
 	args.iter.genmask	= nft_genmask_cur(net);
 	args.iter.skip		= cb->args[0];
 	args.iter.count		= 0;
@@ -5833,11 +5830,11 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 
 	if (!args.iter.err && args.iter.count == cb->args[0])
 		args.iter.err = nft_set_catchall_dump(net, skb, set,
-						      reset, cb->seq);
+						      dump_ctx->reset, cb->seq);
 	nla_nest_end(skb, nest);
 	nlmsg_end(skb, nlh);
 
-	if (reset && args.iter.count > args.iter.skip)
+	if (dump_ctx->reset && args.iter.count > args.iter.skip)
 		audit_log_nft_set_reset(table, cb->seq,
 					args.iter.count - args.iter.skip);
 
@@ -6090,6 +6087,9 @@ static int nf_tables_getsetelem(struct sk_buff *skb,
 
 	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
 
+	if (NFNL_MSG_TYPE(info->nlh->nlmsg_type) == NFT_MSG_GETSETELEM_RESET)
+		reset = true;
+
 	if (info->nlh->nlmsg_flags & NLM_F_DUMP) {
 		struct netlink_dump_control c = {
 			.start = nf_tables_dump_set_start,
@@ -6100,6 +6100,7 @@ static int nf_tables_getsetelem(struct sk_buff *skb,
 		struct nft_set_dump_ctx dump_ctx = {
 			.set = set,
 			.ctx = ctx,
+			.reset = reset,
 		};
 
 		c.data = &dump_ctx;
@@ -6109,9 +6110,6 @@ static int nf_tables_getsetelem(struct sk_buff *skb,
 	if (!nla[NFTA_SET_ELEM_LIST_ELEMENTS])
 		return -EINVAL;
 
-	if (NFNL_MSG_TYPE(info->nlh->nlmsg_type) == NFT_MSG_GETSETELEM_RESET)
-		reset = true;
-
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_get_set_elem(&ctx, set, attr, reset);
 		if (err < 0) {
-- 
2.41.0

