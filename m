Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 875087BB47
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Jul 2019 10:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfGaIMm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Jul 2019 04:12:42 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:50763 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfGaIMl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:12:41 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id EFF4441947;
        Wed, 31 Jul 2019 16:12:35 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de, jakub.kicinski@netronome.com,
        jiri@resnulli.us
Cc:     netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next 6/6] netfilter: nf_tables_offload: support indr block call
Date:   Wed, 31 Jul 2019 16:12:33 +0800
Message-Id: <1564560753-32603-7-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564560753-32603-1-git-send-email-wenxu@ucloud.cn>
References: <1564560753-32603-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSENJS0tLS0NDTUJKTEpZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ok06GQw*DTg4GEguPAgBHj5W
        IQhPCjFVSlVKTk1PTk1LTE5NTkhPVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUNNS0M3Bg++
X-HM-Tid: 0a6c47168df52086kuqyeff4441947
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

nftable support indr-block call. It makes nftable an offload vlan
and tunnel device.

nft add table netdev firewall
nft add chain netdev firewall aclout { type filter hook ingress offload device mlx_pf0vf0 priority - 300 \; }
nft add rule netdev firewall aclout ip daddr 10.0.0.1 fwd to vlan0
nft add chain netdev firewall aclin { type filter hook ingress device vlan0 priority - 300 \; }
nft add rule netdev firewall aclin ip daddr 10.0.0.7 fwd to mlx_pf0vf0

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 include/net/netfilter/nf_tables_offload.h |   2 +
 net/netfilter/nf_tables_api.c             |   7 ++
 net/netfilter/nf_tables_offload.c         | 156 +++++++++++++++++++++++++-----
 3 files changed, 141 insertions(+), 24 deletions(-)

diff --git a/include/net/netfilter/nf_tables_offload.h b/include/net/netfilter/nf_tables_offload.h
index 3196663..ac69087 100644
--- a/include/net/netfilter/nf_tables_offload.h
+++ b/include/net/netfilter/nf_tables_offload.h
@@ -63,6 +63,8 @@ struct nft_flow_rule {
 struct nft_flow_rule *nft_flow_rule_create(const struct nft_rule *rule);
 void nft_flow_rule_destroy(struct nft_flow_rule *flow);
 int nft_flow_rule_offload_commit(struct net *net);
+bool nft_indr_get_default_block(struct net_device *dev,
+				struct flow_indr_block_info *info);
 
 #define NFT_OFFLOAD_MATCH(__key, __base, __field, __len, __reg)		\
 	(__reg)->base_offset	=					\
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 605a7cf..6a1d0b2 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7593,6 +7593,11 @@ static void __net_exit nf_tables_exit_net(struct net *net)
 	.exit	= nf_tables_exit_net,
 };
 
+static struct flow_indr_get_block_entry get_block_entry = {
+	.get_block_cb = nft_indr_get_default_block,
+	.list = LIST_HEAD_INIT(get_block_entry.list),
+};
+
 static int __init nf_tables_module_init(void)
 {
 	int err;
@@ -7624,6 +7629,7 @@ static int __init nf_tables_module_init(void)
 		goto err5;
 
 	nft_chain_route_init();
+	flow_indr_add_default_block_cb(&get_block_entry);
 	return err;
 err5:
 	rhltable_destroy(&nft_objname_ht);
@@ -7640,6 +7646,7 @@ static int __init nf_tables_module_init(void)
 
 static void __exit nf_tables_module_exit(void)
 {
+	flow_indr_del_default_block_cb(&get_block_entry);
 	nfnetlink_subsys_unregister(&nf_tables_subsys);
 	unregister_netdevice_notifier(&nf_tables_flowtable_notifier);
 	nft_chain_filter_fini();
diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 64f5fd5..59c9629 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -171,24 +171,114 @@ static int nft_flow_offload_unbind(struct flow_block_offload *bo,
 	return 0;
 }
 
+static int nft_block_setup(struct nft_base_chain *basechain,
+			   struct flow_block_offload *bo,
+			   enum flow_block_command cmd)
+{
+	int err;
+
+	switch (cmd) {
+	case FLOW_BLOCK_BIND:
+		err = nft_flow_offload_bind(bo, basechain);
+		break;
+	case FLOW_BLOCK_UNBIND:
+		err = nft_flow_offload_unbind(bo, basechain);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
+static int nft_block_offload_cmd(struct nft_base_chain *chain,
+				 struct net_device *dev,
+				 enum flow_block_command cmd)
+{
+	struct netlink_ext_ack extack = {};
+	struct flow_block_offload bo = {};
+	int err;
+
+	bo.net = dev_net(dev);
+	bo.block = &chain->flow_block;
+	bo.command = cmd;
+	bo.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
+	bo.extack = &extack;
+	INIT_LIST_HEAD(&bo.cb_list);
+
+	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_BLOCK, &bo);
+	if (err < 0)
+		return err;
+
+	return nft_block_setup(chain, &bo, cmd);
+}
+
+static void nft_indr_block_ing_cmd(struct net_device *dev,
+				   struct flow_block *flow_block,
+				   flow_indr_block_bind_cb_t *cb,
+				   void *cb_priv,
+				   enum flow_block_command cmd)
+{
+	struct netlink_ext_ack extack = {};
+	struct flow_block_offload bo = {};
+	struct nft_base_chain *chain;
+
+	if (flow_block)
+		return;
+
+	chain = container_of(flow_block, struct nft_base_chain, flow_block);
+
+	bo.net = dev_net(dev);
+	bo.block = flow_block;
+	bo.command = cmd;
+	bo.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
+	bo.extack = &extack;
+	INIT_LIST_HEAD(&bo.cb_list);
+
+	cb(dev, cb_priv, TC_SETUP_BLOCK, &bo);
+
+	nft_block_setup(chain, &bo, cmd);
+}
+
+static int nft_indr_block_offload_cmd(struct nft_base_chain *chain,
+				      struct net_device *dev,
+				      enum flow_block_command cmd)
+{
+	struct flow_block_offload bo = {};
+	struct netlink_ext_ack extack = {};
+
+	bo.net = dev_net(dev);
+	bo.block = &chain->flow_block;
+	bo.command = cmd;
+	bo.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
+	bo.extack = &extack;
+	INIT_LIST_HEAD(&bo.cb_list);
+
+	flow_indr_block_call(&chain->flow_block, dev, nft_indr_block_ing_cmd,
+			     &bo, cmd);
+
+	if (list_empty(&bo.cb_list))
+		return -EOPNOTSUPP;
+
+	return nft_block_setup(chain, &bo, cmd);
+}
+
 #define FLOW_SETUP_BLOCK TC_SETUP_BLOCK
 
 static int nft_flow_offload_chain(struct nft_trans *trans,
 				  enum flow_block_command cmd)
 {
 	struct nft_chain *chain = trans->ctx.chain;
-	struct netlink_ext_ack extack = {};
-	struct flow_block_offload bo = {};
 	struct nft_base_chain *basechain;
 	struct net_device *dev;
-	int err;
 
 	if (!nft_is_base_chain(chain))
 		return -EOPNOTSUPP;
 
 	basechain = nft_base_chain(chain);
 	dev = basechain->ops.dev;
-	if (!dev || !dev->netdev_ops->ndo_setup_tc)
+	if (!dev)
 		return -EOPNOTSUPP;
 
 	/* Only default policy to accept is supported for now. */
@@ -197,26 +287,10 @@ static int nft_flow_offload_chain(struct nft_trans *trans,
 	    nft_trans_chain_policy(trans) != NF_ACCEPT)
 		return -EOPNOTSUPP;
 
-	bo.command = cmd;
-	bo.block = &basechain->flow_block;
-	bo.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
-	bo.extack = &extack;
-	INIT_LIST_HEAD(&bo.cb_list);
-
-	err = dev->netdev_ops->ndo_setup_tc(dev, FLOW_SETUP_BLOCK, &bo);
-	if (err < 0)
-		return err;
-
-	switch (cmd) {
-	case FLOW_BLOCK_BIND:
-		err = nft_flow_offload_bind(&bo, basechain);
-		break;
-	case FLOW_BLOCK_UNBIND:
-		err = nft_flow_offload_unbind(&bo, basechain);
-		break;
-	}
-
-	return err;
+	if (dev->netdev_ops->ndo_setup_tc)
+		return nft_block_offload_cmd(basechain, dev, cmd);
+	else
+		return nft_indr_block_offload_cmd(basechain, dev, cmd);
 }
 
 int nft_flow_rule_offload_commit(struct net *net)
@@ -266,3 +340,37 @@ int nft_flow_rule_offload_commit(struct net *net)
 
 	return err;
 }
+
+bool nft_indr_get_default_block(struct net_device *dev,
+				struct flow_indr_block_info *info)
+{
+	struct net *net = dev_net(dev);
+	const struct nft_table *table;
+	const struct nft_chain *chain;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+		if (table->family != NFPROTO_NETDEV)
+			continue;
+
+		list_for_each_entry_rcu(chain, &table->chains, list) {
+			if (nft_is_base_chain(chain)) {
+				struct nft_base_chain *basechain;
+
+				basechain = nft_base_chain(chain);
+				if (!strncmp(basechain->dev_name, dev->name,
+					     IFNAMSIZ)) {
+					info->flow_block = &basechain->flow_block;
+					info->ing_cmd_cb = nft_indr_block_ing_cmd;
+					rcu_read_unlock();
+					return true;
+				}
+			}
+		}
+	}
+
+	rcu_read_unlock();
+
+	return false;
+}
-- 
1.8.3.1

