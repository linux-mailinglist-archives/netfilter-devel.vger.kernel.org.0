Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569CFACF39
	for <lists+netfilter-devel@lfdr.de>; Sun,  8 Sep 2019 16:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfIHOTJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 8 Sep 2019 10:19:09 -0400
Received: from m9785.mail.qiye.163.com ([220.181.97.85]:3245 "EHLO
        m9785.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfIHOTJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 8 Sep 2019 10:19:09 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9785.mail.qiye.163.com (Hmail) with ESMTPA id 24A535C16CA;
        Sun,  8 Sep 2019 22:18:58 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v4 3/4] netfilter: nf_tables_offload: add __nft_offload_get_chain function
Date:   Sun,  8 Sep 2019 22:18:55 +0800
Message-Id: <1567952336-23669-4-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567952336-23669-1-git-send-email-wenxu@ucloud.cn>
References: <1567952336-23669-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVS01OS0tLSkxNT0lCTE5ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PFE6KSo6CjgxOTVLAxwPOTcN
        PCpPChFVSlVKTk1MQk5JSEhDSkNMVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlDQ003Bg++
X-HM-Tid: 0a6d113dfced2087kuqy24a535c16ca
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Add __nft_offload_get_chain function. It make code more common
and can be used for others.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v4: add __nft_offload_get_chain

 net/netfilter/nf_tables_offload.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 9657001..a471706 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -365,16 +365,13 @@ int nft_flow_rule_offload_commit(struct net *net)
 	return err;
 }
 
-static void nft_indr_block_cb(struct net_device *dev,
-			      flow_indr_block_bind_cb_t *cb, void *cb_priv,
-			      enum flow_block_command cmd)
+static struct nft_chain *__nft_offload_get_chain(struct net_device *dev)
 {
 	struct nft_base_chain *basechain;
 	struct net *net = dev_net(dev);
-	const struct nft_table *table;
-	const struct nft_chain *chain;
+	struct nft_chain *chain;
+	struct nft_table *table;
 
-	mutex_lock(&net->nft.commit_mutex);
 	list_for_each_entry(table, &net->nft.tables, list) {
 		if (table->family != NFPROTO_NETDEV)
 			continue;
@@ -388,11 +385,28 @@ static void nft_indr_block_cb(struct net_device *dev,
 			if (strncmp(basechain->dev_name, dev->name, IFNAMSIZ))
 				continue;
 
-			nft_indr_block_ing_cmd(dev, basechain, cb, cb_priv, cmd);
-			mutex_unlock(&net->nft.commit_mutex);
-			return;
+			return chain;
 		}
 	}
+
+	return NULL;
+}
+
+static void nft_indr_block_cb(struct net_device *dev,
+			      flow_indr_block_bind_cb_t *cb, void *cb_priv,
+			      enum flow_block_command cmd)
+{
+	struct net *net = dev_net(dev);
+	struct nft_chain *chain;
+
+	mutex_lock(&net->nft.commit_mutex);
+	chain = __nft_offload_get_chain(dev);
+	if (chain) {
+		struct nft_base_chain *basechain;
+
+		basechain = nft_base_chain(chain);
+		nft_indr_block_ing_cmd(dev, basechain, cb, cb_priv, cmd);
+	}
 	mutex_unlock(&net->nft.commit_mutex);
 }
 
-- 
1.8.3.1

