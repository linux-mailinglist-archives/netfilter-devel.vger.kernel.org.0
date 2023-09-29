Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74127B3A88
	for <lists+netfilter-devel@lfdr.de>; Fri, 29 Sep 2023 21:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjI2TTd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 29 Sep 2023 15:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjI2TTc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:19:32 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7261B2
        for <netfilter-devel@vger.kernel.org>; Fri, 29 Sep 2023 12:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4iLw5HydcjFP3TigUtAIxxhOcyZtHMIgKKljcHJTXk4=; b=Yq1dE4DPPHsE3x0hBcL8DwEpLB
        slBCzSLQgw3VVZpQwyK3Mn5BRfEyWbGhgUohANJZZHPL2ObxdusHW1zGn/7IZYOdasKsKS5LkOdfw
        rjI3D0Zeuhi3qakymHbcO8wjtsbiA3vughjmO0cf097lbe0Zw3v/Zc4yljw/pgX1NxEWxIr8HSirD
        rMEtUEF2dss5BUZIoyMVbdVYCYtqcO1DLNk+JLdupt8mFUfrDfQ2lsIEoT/1vmk33ecLQmopJ1X/C
        B6DSHbokUWA/lvGsAnOLus9mfEPrfF70WNTywUyriJQMi3j2eD76c0wU48knkVtrfKKCBInacelmz
        JZq1UEZA==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1qmJ1L-0005EP-Es; Fri, 29 Sep 2023 21:19:27 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: [nf-next PATCH 4/5] netfilter: nf_tables: Carry s_idx in nft_rule_dump_ctx
Date:   Fri, 29 Sep 2023 21:19:21 +0200
Message-ID: <20230929191922.6230-5-phil@nwl.cc>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929191922.6230-1-phil@nwl.cc>
References: <20230929191922.6230-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In order to move the context into struct netlink_callback's scratch
area, the latter must be unused first.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 net/netfilter/nf_tables_api.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 21dd6a27ca598..a8c8d9d116d56 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3441,6 +3441,7 @@ static void audit_log_rule_reset(const struct nft_table *table,
 }
 
 struct nft_rule_dump_ctx {
+	unsigned int s_idx;
 	char *table;
 	char *chain;
 	bool reset;
@@ -3455,7 +3456,6 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 	struct nft_rule_dump_ctx *ctx = cb->data;
 	struct net *net = sock_net(skb->sk);
 	const struct nft_rule *rule, *prule;
-	unsigned int s_idx = cb->args[0];
 	unsigned int entries = 0;
 	int ret = 0;
 	u64 handle;
@@ -3464,7 +3464,7 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 	list_for_each_entry_rcu(rule, &chain->rules, list) {
 		if (!nft_is_active(net, rule))
 			goto cont_skip;
-		if (*idx < s_idx)
+		if (*idx < ctx->s_idx)
 			goto cont;
 		if (prule)
 			handle = prule->handle;
@@ -3498,7 +3498,7 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
 	const struct nfgenmsg *nfmsg = nlmsg_data(cb->nlh);
-	const struct nft_rule_dump_ctx *ctx = cb->data;
+	struct nft_rule_dump_ctx *ctx = cb->data;
 	struct nft_table *table;
 	const struct nft_chain *chain;
 	unsigned int idx = 0;
@@ -3547,7 +3547,7 @@ static int nf_tables_dump_rules(struct sk_buff *skb,
 done:
 	rcu_read_unlock();
 
-	cb->args[0] = idx;
+	ctx->s_idx = idx;
 	return skb->len;
 }
 
-- 
2.41.0

