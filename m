Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4199EAF527
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Sep 2019 06:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbfIKEx3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Sep 2019 00:53:29 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:59584 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfIKEx2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Sep 2019 00:53:28 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 6DA1F417F4;
        Wed, 11 Sep 2019 12:53:25 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v6 2/4] netfilter: nf_offload: refactor the nft_flow_offload_chain function
Date:   Wed, 11 Sep 2019 12:53:22 +0800
Message-Id: <1568177604-26989-3-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568177604-26989-1-git-send-email-wenxu@ucloud.cn>
References: <1568177604-26989-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSkJNS0tLSUpDSEJKT0lZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxQ6Fyo6KTgrKTQYPDcZMAEZ
        T0wKClZVSlVKTk1DSkxMTUtOTk9LVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUhIT083Bg++
X-HM-Tid: 0a6d1eab4b532086kuqy6da1f417f4
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Refactor nft_flow_offload_chain and make it more common

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v6: only refactor nft_flow_offload_chain 

 net/netfilter/nf_tables_offload.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index e200491..367a7fa 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -294,12 +294,13 @@ static int nft_indr_block_offload_cmd(struct nft_base_chain *chain,
 
 #define FLOW_SETUP_BLOCK TC_SETUP_BLOCK
 
-static int nft_flow_offload_chain(struct nft_trans *trans,
+static int nft_flow_offload_chain(struct nft_chain *chain,
+				  u8 *ppolicy,
 				  enum flow_block_command cmd)
 {
-	struct nft_chain *chain = trans->ctx.chain;
 	struct nft_base_chain *basechain;
 	struct net_device *dev;
+	u8 policy;
 
 	if (!nft_is_base_chain(chain))
 		return -EOPNOTSUPP;
@@ -309,10 +310,10 @@ static int nft_flow_offload_chain(struct nft_trans *trans,
 	if (!dev)
 		return -EOPNOTSUPP;
 
+	policy = ppolicy ? *ppolicy : basechain->policy;
+
 	/* Only default policy to accept is supported for now. */
-	if (cmd == FLOW_BLOCK_BIND &&
-	    nft_trans_chain_policy(trans) != -1 &&
-	    nft_trans_chain_policy(trans) != NF_ACCEPT)
+	if (cmd == FLOW_BLOCK_BIND && policy != -1 && policy != NF_ACCEPT)
 		return -EOPNOTSUPP;
 
 	if (dev->netdev_ops->ndo_setup_tc)
@@ -325,6 +326,7 @@ int nft_flow_rule_offload_commit(struct net *net)
 {
 	struct nft_trans *trans;
 	int err = 0;
+	u8 policy;
 
 	list_for_each_entry(trans, &net->nft.commit_list, list) {
 		if (trans->ctx.family != NFPROTO_NETDEV)
@@ -335,13 +337,17 @@ int nft_flow_rule_offload_commit(struct net *net)
 			if (!(trans->ctx.chain->flags & NFT_CHAIN_HW_OFFLOAD))
 				continue;
 
-			err = nft_flow_offload_chain(trans, FLOW_BLOCK_BIND);
+			policy = nft_trans_chain_policy(trans);
+			err = nft_flow_offload_chain(trans->ctx.chain, &policy,
+						     FLOW_BLOCK_BIND);
 			break;
 		case NFT_MSG_DELCHAIN:
 			if (!(trans->ctx.chain->flags & NFT_CHAIN_HW_OFFLOAD))
 				continue;
 
-			err = nft_flow_offload_chain(trans, FLOW_BLOCK_UNBIND);
+			policy = nft_trans_chain_policy(trans);
+			err = nft_flow_offload_chain(trans->ctx.chain, &policy,
+						     FLOW_BLOCK_BIND);
 			break;
 		case NFT_MSG_NEWRULE:
 			if (!(trans->ctx.chain->flags & NFT_CHAIN_HW_OFFLOAD))
-- 
1.8.3.1

