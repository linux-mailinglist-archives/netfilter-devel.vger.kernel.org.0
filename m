Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C06EACF3B
	for <lists+netfilter-devel@lfdr.de>; Sun,  8 Sep 2019 16:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfIHOT1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 8 Sep 2019 10:19:27 -0400
Received: from m9785.mail.qiye.163.com ([220.181.97.85]:3241 "EHLO
        m9785.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbfIHOT1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 8 Sep 2019 10:19:27 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9785.mail.qiye.163.com (Hmail) with ESMTPA id 0CC8E5C16C9;
        Sun,  8 Sep 2019 22:18:58 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v4 2/4] netfilter: nf_offload: refactor the nft_flow_offload_rule function
Date:   Sun,  8 Sep 2019 22:18:54 +0800
Message-Id: <1567952336-23669-3-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567952336-23669-1-git-send-email-wenxu@ucloud.cn>
References: <1567952336-23669-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVS01OS0tLSkxNT0lCTE5ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQg6Syo4TDgwTDUNKRMZOThO
        PTFPCxdVSlVKTk1MQk5JSEhDSklDVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUhISUk3Bg++
X-HM-Tid: 0a6d113dfc8b2087kuqy0cc8e5c16c9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Refactor nft_flow_offload_rule and make it more common

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v4: no change

 net/netfilter/nf_tables_offload.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 9419486..9657001 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -134,20 +134,20 @@ int nft_chain_offload_priority(struct nft_base_chain *basechain)
 	return 0;
 }
 
-static int nft_flow_offload_rule(struct nft_trans *trans,
+static int nft_flow_offload_rule(struct nft_chain *chain,
+				 struct nft_rule *rule,
+				 struct nft_flow_rule *flow,
 				 enum flow_cls_command command)
 {
-	struct nft_flow_rule *flow = nft_trans_flow_rule(trans);
-	struct nft_rule *rule = nft_trans_rule(trans);
 	struct flow_cls_offload cls_flow = {};
 	struct nft_base_chain *basechain;
 	struct netlink_ext_ack extack;
 	__be16 proto = ETH_P_ALL;
 
-	if (!nft_is_base_chain(trans->ctx.chain))
+	if (!nft_is_base_chain(chain))
 		return -EOPNOTSUPP;
 
-	basechain = nft_base_chain(trans->ctx.chain);
+	basechain = nft_base_chain(chain);
 
 	if (flow)
 		proto = flow->proto;
@@ -162,6 +162,16 @@ static int nft_flow_offload_rule(struct nft_trans *trans,
 	return nft_setup_cb_call(basechain, TC_SETUP_CLSFLOWER, &cls_flow);
 }
 
+static int nft_flow_offload_rule_commit(struct nft_trans *trans,
+					enum flow_cls_command command)
+{
+	struct nft_flow_rule *flow = nft_trans_flow_rule(trans);
+	struct nft_rule *rule = nft_trans_rule(trans);
+	struct nft_chain *chain = trans->ctx.chain;
+
+	return nft_flow_offload_rule(chain, rule, flow, command);
+}
+
 static int nft_flow_offload_bind(struct flow_block_offload *bo,
 				 struct nft_base_chain *basechain)
 {
@@ -337,14 +347,14 @@ int nft_flow_rule_offload_commit(struct net *net)
 			    !(trans->ctx.flags & NLM_F_APPEND))
 				return -EOPNOTSUPP;
 
-			err = nft_flow_offload_rule(trans, FLOW_CLS_REPLACE);
+			err = nft_flow_offload_rule_commit(trans, FLOW_CLS_REPLACE);
 			nft_flow_rule_destroy(nft_trans_flow_rule(trans));
 			break;
 		case NFT_MSG_DELRULE:
 			if (!(trans->ctx.chain->flags & NFT_CHAIN_HW_OFFLOAD))
 				continue;
 
-			err = nft_flow_offload_rule(trans, FLOW_CLS_DESTROY);
+			err = nft_flow_offload_rule_commit(trans, FLOW_CLS_DESTROY);
 			break;
 		}
 
-- 
1.8.3.1

