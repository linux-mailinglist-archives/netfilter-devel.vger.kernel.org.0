Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC277CFBEE
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Oct 2023 16:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbjJSODq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 Oct 2023 10:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345904AbjJSODp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:03:45 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E9F126
        for <netfilter-devel@vger.kernel.org>; Thu, 19 Oct 2023 07:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3NDoK4v3DUago+9j3M8dc9yYb8pXSUSGZc4QRTKcvZo=; b=NurRIYDOpNQt1ilclh0oLmI/Yo
        GdXFC44C5Yd/KC6mHexLpPGE+qnLh+tN5qoqxdnFjv40YTJLZyuxt2oqi4JXiemkVAnpPWoXTF+Wh
        ml7RR6OOpyI7k/DodO58P8uBN8F6mBd32vjDvPk5lwcH41g0YL607Muy9WrV9ViZ2ZDPh6T20C7n3
        R18bDfI6AfdOaCjENiXB08Bra6y9VrKVur2ZPbD2tyfYkz+BGE62RCcYdtqHEgshb8gX9b19xKg06
        bcYvyw/FomnNq+hQ8W90Wwfg9PFUlE/xewiEtbSRwuct7AFV9mZ2pUhVbzwkTEWbMppAuSeV1Nsvk
        q36MpD9A==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1qtTci-0002PE-Km; Thu, 19 Oct 2023 16:03:40 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: [nf-next PATCH v4 2/3] netfilter: nf_tables: Introduce nf_tables_getrule_single()
Date:   Thu, 19 Oct 2023 16:03:35 +0200
Message-ID: <20231019140336.31563-3-phil@nwl.cc>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019140336.31563-1-phil@nwl.cc>
References: <20231019140336.31563-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Outsource the reply skb preparation for non-dump getrule requests into a
distinct function. Prep work for rule reset locking.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
No changes since v3
---
 net/netfilter/nf_tables_api.c | 74 ++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 77ae5bc4931c..19b3f0087c67 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3586,65 +3586,81 @@ static int nf_tables_dump_rules_done(struct netlink_callback *cb)
 }
 
 /* called with rcu_read_lock held */
-static int nf_tables_getrule(struct sk_buff *skb, const struct nfnl_info *info,
-			     const struct nlattr * const nla[])
+static struct sk_buff *
+nf_tables_getrule_single(u32 portid, const struct nfnl_info *info,
+			 const struct nlattr * const nla[], bool reset)
 {
-	struct nftables_pernet *nft_net = nft_pernet(info->net);
 	struct netlink_ext_ack *extack = info->extack;
 	u8 genmask = nft_genmask_cur(info->net);
 	u8 family = info->nfmsg->nfgen_family;
-	u32 portid = NETLINK_CB(skb).portid;
 	const struct nft_chain *chain;
 	const struct nft_rule *rule;
 	struct net *net = info->net;
 	struct nft_table *table;
 	struct sk_buff *skb2;
-	bool reset = false;
-	char *buf;
 	int err;
 
-	if (info->nlh->nlmsg_flags & NLM_F_DUMP) {
-		struct netlink_dump_control c = {
-			.start= nf_tables_dump_rules_start,
-			.dump = nf_tables_dump_rules,
-			.done = nf_tables_dump_rules_done,
-			.module = THIS_MODULE,
-			.data = (void *)nla,
-		};
-
-		return nft_netlink_dump_start_rcu(info->sk, skb, info->nlh, &c);
-	}
-
 	table = nft_table_lookup(net, nla[NFTA_RULE_TABLE], family, genmask, 0);
 	if (IS_ERR(table)) {
 		NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_TABLE]);
-		return PTR_ERR(table);
+		return ERR_CAST(table);
 	}
 
 	chain = nft_chain_lookup(net, table, nla[NFTA_RULE_CHAIN], genmask);
 	if (IS_ERR(chain)) {
 		NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN]);
-		return PTR_ERR(chain);
+		return ERR_CAST(chain);
 	}
 
 	rule = nft_rule_lookup(chain, nla[NFTA_RULE_HANDLE]);
 	if (IS_ERR(rule)) {
 		NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_HANDLE]);
-		return PTR_ERR(rule);
+		return ERR_CAST(rule);
 	}
 
 	skb2 = alloc_skb(NLMSG_GOODSIZE, GFP_ATOMIC);
 	if (!skb2)
-		return -ENOMEM;
-
-	if (NFNL_MSG_TYPE(info->nlh->nlmsg_type) == NFT_MSG_GETRULE_RESET)
-		reset = true;
+		return ERR_PTR(-ENOMEM);
 
 	err = nf_tables_fill_rule_info(skb2, net, portid,
 				       info->nlh->nlmsg_seq, NFT_MSG_NEWRULE, 0,
 				       family, table, chain, rule, 0, reset);
-	if (err < 0)
-		goto err_fill_rule_info;
+	if (err < 0) {
+		kfree_skb(skb2);
+		return ERR_PTR(err);
+	}
+
+	return skb2;
+}
+
+static int nf_tables_getrule(struct sk_buff *skb, const struct nfnl_info *info,
+			     const struct nlattr * const nla[])
+{
+	struct nftables_pernet *nft_net = nft_pernet(info->net);
+	u32 portid = NETLINK_CB(skb).portid;
+	struct net *net = info->net;
+	struct sk_buff *skb2;
+	bool reset = false;
+	char *buf;
+
+	if (info->nlh->nlmsg_flags & NLM_F_DUMP) {
+		struct netlink_dump_control c = {
+			.start= nf_tables_dump_rules_start,
+			.dump = nf_tables_dump_rules,
+			.done = nf_tables_dump_rules_done,
+			.module = THIS_MODULE,
+			.data = (void *)nla,
+		};
+
+		return nft_netlink_dump_start_rcu(info->sk, skb, info->nlh, &c);
+	}
+
+	if (NFNL_MSG_TYPE(info->nlh->nlmsg_type) == NFT_MSG_GETRULE_RESET)
+		reset = true;
+
+	skb2 = nf_tables_getrule_single(portid, info, nla, reset);
+	if (IS_ERR(skb2))
+		return PTR_ERR(skb2);
 
 	if (!reset)
 		return nfnetlink_unicast(skb2, net, portid);
@@ -3658,10 +3674,6 @@ static int nf_tables_getrule(struct sk_buff *skb, const struct nfnl_info *info,
 	kfree(buf);
 
 	return nfnetlink_unicast(skb2, net, portid);
-
-err_fill_rule_info:
-	kfree_skb(skb2);
-	return err;
 }
 
 void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule)
-- 
2.41.0

