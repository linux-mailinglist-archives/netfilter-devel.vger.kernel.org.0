Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FECE74A82
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jul 2019 11:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfGYJzq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Jul 2019 05:55:46 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:18606 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYJzq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:55:46 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 6235941D6A;
        Thu, 25 Jul 2019 17:55:39 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next 1/3] flow_offload: move tc indirect block to flow offload
Date:   Thu, 25 Jul 2019 17:55:31 +0800
Message-Id: <1564048533-27283-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVJS0hLS0tLTUNNTU9OTllXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzI6Sxw4KDg*HFZKDTguMyMK
        L00aCTxVSlVKTk1PS09DTkhCTUtLVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlKSUtPNwY+
X-HM-Tid: 0a6c288ebf2c2086kuqy6235941d6a
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

move tc indirect block to flow_offload.c. The nf_tables
can use the indr block architecture.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  10 +-
 .../net/ethernet/netronome/nfp/flower/offload.c    |  10 +-
 include/net/flow_offload.h                         |  40 ++++
 include/net/pkt_cls.h                              |  35 ----
 include/net/sch_generic.h                          |   3 -
 net/core/flow_offload.c                            | 189 +++++++++++++++++
 net/sched/cls_api.c                                | 225 ++-------------------
 7 files changed, 254 insertions(+), 258 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 7f747cb..074573b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -785,9 +785,9 @@ static int mlx5e_rep_indr_register_block(struct mlx5e_rep_priv *rpriv,
 {
 	int err;
 
-	err = __tc_indr_block_cb_register(netdev, rpriv,
-					  mlx5e_rep_indr_setup_tc_cb,
-					  rpriv);
+	err = __flow_indr_block_cb_register(netdev, rpriv,
+					    mlx5e_rep_indr_setup_tc_cb,
+					    rpriv);
 	if (err) {
 		struct mlx5e_priv *priv = netdev_priv(rpriv->netdev);
 
@@ -800,8 +800,8 @@ static int mlx5e_rep_indr_register_block(struct mlx5e_rep_priv *rpriv,
 static void mlx5e_rep_indr_unregister_block(struct mlx5e_rep_priv *rpriv,
 					    struct net_device *netdev)
 {
-	__tc_indr_block_cb_unregister(netdev, mlx5e_rep_indr_setup_tc_cb,
-				      rpriv);
+	__flow_indr_block_cb_unregister(netdev, mlx5e_rep_indr_setup_tc_cb,
+					rpriv);
 }
 
 static int mlx5e_nic_rep_netdevice_event(struct notifier_block *nb,
diff --git a/drivers/net/ethernet/netronome/nfp/flower/offload.c b/drivers/net/ethernet/netronome/nfp/flower/offload.c
index e209f15..6a0f034 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -1479,16 +1479,16 @@ int nfp_flower_reg_indir_block_handler(struct nfp_app *app,
 		return NOTIFY_OK;
 
 	if (event == NETDEV_REGISTER) {
-		err = __tc_indr_block_cb_register(netdev, app,
-						  nfp_flower_indr_setup_tc_cb,
-						  app);
+		err = __flow_indr_block_cb_register(netdev, app,
+						    nfp_flower_indr_setup_tc_cb,
+						    app);
 		if (err)
 			nfp_flower_cmsg_warn(app,
 					     "Indirect block reg failed - %s\n",
 					     netdev->name);
 	} else if (event == NETDEV_UNREGISTER) {
-		__tc_indr_block_cb_unregister(netdev,
-					      nfp_flower_indr_setup_tc_cb, app);
+		__flow_indr_block_cb_unregister(netdev,
+						nfp_flower_indr_setup_tc_cb, app);
 	}
 
 	return NOTIFY_OK;
diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index b16d216..373028e 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <net/flow_dissector.h>
+#include <linux/rhashtable.h>
 
 struct flow_match {
 	struct flow_dissector	*dissector;
@@ -347,4 +348,43 @@ static inline void flow_block_init(struct flow_block *flow_block)
 	INIT_LIST_HEAD(&flow_block->cb_list);
 }
 
+typedef int flow_indr_block_bind_cb_t(struct net_device *dev, void *cb_priv,
+				      enum tc_setup_type type, void *type_data);
+
+struct flow_indr_block_cb {
+	struct list_head list;
+	void *cb_priv;
+	flow_indr_block_bind_cb_t *cb;
+	void *cb_ident;
+};
+
+typedef void flow_indr_block_ing_cmd_t(struct net_device *dev, void *block,
+				       struct flow_indr_block_cb *indr_block_cb,
+				       enum flow_block_command command);
+
+struct flow_indr_block_dev {
+	struct rhash_head ht_node;
+	struct net_device *dev;
+	unsigned int refcnt;
+	struct list_head cb_list;
+	flow_indr_block_ing_cmd_t *cmd_cb;
+	void *block;
+};
+
+struct flow_indr_block_dev *flow_indr_block_dev_lookup(struct net_device *dev);
+
+int flow_indr_rhashtable_init(void);
+
+int __flow_indr_block_cb_register(struct net_device *dev, void *cb_priv,
+				  flow_indr_block_bind_cb_t *cb, void *cb_ident);
+
+void __flow_indr_block_cb_unregister(struct net_device *dev,
+				     flow_indr_block_bind_cb_t *cb, void *cb_ident);
+
+int flow_indr_block_cb_register(struct net_device *dev, void *cb_priv,
+				flow_indr_block_bind_cb_t *cb, void *cb_ident);
+
+void flow_indr_block_cb_unregister(struct net_device *dev,
+				   flow_indr_block_bind_cb_t *cb, void *cb_ident);
+
 #endif /* _NET_FLOW_OFFLOAD_H */
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index e429809..0790a4e 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -70,15 +70,6 @@ static inline struct Qdisc *tcf_block_q(struct tcf_block *block)
 	return block->q;
 }
 
-int __tc_indr_block_cb_register(struct net_device *dev, void *cb_priv,
-				tc_indr_block_bind_cb_t *cb, void *cb_ident);
-int tc_indr_block_cb_register(struct net_device *dev, void *cb_priv,
-			      tc_indr_block_bind_cb_t *cb, void *cb_ident);
-void __tc_indr_block_cb_unregister(struct net_device *dev,
-				   tc_indr_block_bind_cb_t *cb, void *cb_ident);
-void tc_indr_block_cb_unregister(struct net_device *dev,
-				 tc_indr_block_bind_cb_t *cb, void *cb_ident);
-
 int tcf_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 		 struct tcf_result *res, bool compat_mode);
 
@@ -137,32 +128,6 @@ void tc_setup_cb_block_unregister(struct tcf_block *block, flow_setup_cb_t *cb,
 {
 }
 
-static inline
-int __tc_indr_block_cb_register(struct net_device *dev, void *cb_priv,
-				tc_indr_block_bind_cb_t *cb, void *cb_ident)
-{
-	return 0;
-}
-
-static inline
-int tc_indr_block_cb_register(struct net_device *dev, void *cb_priv,
-			      tc_indr_block_bind_cb_t *cb, void *cb_ident)
-{
-	return 0;
-}
-
-static inline
-void __tc_indr_block_cb_unregister(struct net_device *dev,
-				   tc_indr_block_bind_cb_t *cb, void *cb_ident)
-{
-}
-
-static inline
-void tc_indr_block_cb_unregister(struct net_device *dev,
-				 tc_indr_block_bind_cb_t *cb, void *cb_ident)
-{
-}
-
 static inline int tcf_classify(struct sk_buff *skb, const struct tcf_proto *tp,
 			       struct tcf_result *res, bool compat_mode)
 {
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 6b6b012..d9f359a 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -23,9 +23,6 @@
 struct module;
 struct bpf_flow_keys;
 
-typedef int tc_indr_block_bind_cb_t(struct net_device *dev, void *cb_priv,
-				    enum tc_setup_type type, void *type_data);
-
 struct qdisc_rate_table {
 	struct tc_ratespec rate;
 	u32		data[256];
diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
index d63b970..77e18dc 100644
--- a/net/core/flow_offload.c
+++ b/net/core/flow_offload.c
@@ -2,6 +2,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <net/flow_offload.h>
+#include <linux/rtnetlink.h>
 
 struct flow_rule *flow_rule_alloc(unsigned int num_actions)
 {
@@ -280,3 +281,191 @@ int flow_block_cb_setup_simple(struct flow_block_offload *f,
 	}
 }
 EXPORT_SYMBOL(flow_block_cb_setup_simple);
+
+static struct rhashtable indr_setup_block_ht;
+
+static const struct rhashtable_params flow_indr_setup_block_ht_params = {
+	.key_offset	= offsetof(struct flow_indr_block_dev, dev),
+	.head_offset	= offsetof(struct flow_indr_block_dev, ht_node),
+	.key_len	= sizeof(struct net_device *),
+};
+
+struct flow_indr_block_dev *
+flow_indr_block_dev_lookup(struct net_device *dev)
+{
+	return rhashtable_lookup_fast(&indr_setup_block_ht, &dev,
+				      flow_indr_setup_block_ht_params);
+}
+EXPORT_SYMBOL(flow_indr_block_dev_lookup);
+
+static struct flow_indr_block_dev *flow_indr_block_dev_get(struct net_device *dev)
+{
+	struct flow_indr_block_dev *indr_dev;
+
+	indr_dev = flow_indr_block_dev_lookup(dev);
+	if (indr_dev)
+		goto inc_ref;
+
+	indr_dev = kzalloc(sizeof(*indr_dev), GFP_KERNEL);
+	if (!indr_dev)
+		return NULL;
+
+	INIT_LIST_HEAD(&indr_dev->cb_list);
+	indr_dev->dev = dev;
+	if (rhashtable_insert_fast(&indr_setup_block_ht, &indr_dev->ht_node,
+				   flow_indr_setup_block_ht_params)) {
+		kfree(indr_dev);
+		return NULL;
+	}
+
+inc_ref:
+	indr_dev->refcnt++;
+	return indr_dev;
+}
+
+static void flow_indr_block_dev_put(struct flow_indr_block_dev *indr_dev)
+{
+	if (--indr_dev->refcnt)
+		return;
+
+	rhashtable_remove_fast(&indr_setup_block_ht, &indr_dev->ht_node,
+			       flow_indr_setup_block_ht_params);
+	kfree(indr_dev);
+}
+
+static struct flow_indr_block_cb *
+flow_indr_block_cb_lookup(struct flow_indr_block_dev *indr_dev,
+			  flow_indr_block_bind_cb_t *cb, void *cb_ident)
+{
+	struct flow_indr_block_cb *indr_block_cb;
+
+	list_for_each_entry(indr_block_cb, &indr_dev->cb_list, list)
+		if (indr_block_cb->cb == cb &&
+		    indr_block_cb->cb_ident == cb_ident)
+			return indr_block_cb;
+	return NULL;
+}
+
+static struct flow_indr_block_cb *
+flow_indr_block_cb_add(struct flow_indr_block_dev *indr_dev, void *cb_priv,
+		       flow_indr_block_bind_cb_t *cb, void *cb_ident)
+{
+	struct flow_indr_block_cb *indr_block_cb;
+
+	indr_block_cb = flow_indr_block_cb_lookup(indr_dev, cb, cb_ident);
+	if (indr_block_cb)
+		return ERR_PTR(-EEXIST);
+
+	indr_block_cb = kzalloc(sizeof(*indr_block_cb), GFP_KERNEL);
+	if (!indr_block_cb)
+		return ERR_PTR(-ENOMEM);
+
+	indr_block_cb->cb_priv = cb_priv;
+	indr_block_cb->cb = cb;
+	indr_block_cb->cb_ident = cb_ident;
+	list_add(&indr_block_cb->list, &indr_dev->cb_list);
+
+	return indr_block_cb;
+}
+
+static void flow_indr_block_cb_del(struct flow_indr_block_cb *indr_block_cb)
+{
+	list_del(&indr_block_cb->list);
+	kfree(indr_block_cb);
+}
+
+int __flow_indr_block_cb_register(struct net_device *dev, void *cb_priv,
+				  flow_indr_block_bind_cb_t *cb,
+				  void *cb_ident)
+{
+	struct flow_indr_block_cb *indr_block_cb;
+	struct flow_indr_block_dev *indr_dev;
+	int err;
+
+	indr_dev = flow_indr_block_dev_get(dev);
+	if (!indr_dev)
+		return -ENOMEM;
+
+	indr_block_cb = flow_indr_block_cb_add(indr_dev, cb_priv, cb, cb_ident);
+	err = PTR_ERR_OR_ZERO(indr_block_cb);
+	if (err)
+		goto err_dev_put;
+
+	if (indr_dev->cmd_cb)
+		indr_dev->cmd_cb(indr_dev->dev, indr_dev->block, indr_block_cb,
+				 FLOW_BLOCK_BIND);
+
+	return 0;
+
+err_dev_put:
+	flow_indr_block_dev_put(indr_dev);
+	return err;
+}
+EXPORT_SYMBOL_GPL(__flow_indr_block_cb_register);
+
+int flow_indr_block_cb_register(struct net_device *dev, void *cb_priv,
+				flow_indr_block_bind_cb_t *cb,
+				void *cb_ident)
+{
+	int err;
+
+	rtnl_lock();
+	err = __flow_indr_block_cb_register(dev, cb_priv, cb, cb_ident);
+	rtnl_unlock();
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(flow_indr_block_cb_register);
+
+void __flow_indr_block_cb_unregister(struct net_device *dev,
+				     flow_indr_block_bind_cb_t *cb,
+				     void *cb_ident)
+{
+	struct flow_indr_block_cb *indr_block_cb;
+	struct flow_indr_block_dev *indr_dev;
+
+	indr_dev = flow_indr_block_dev_lookup(dev);
+	if (!indr_dev)
+		return;
+
+	indr_block_cb = flow_indr_block_cb_lookup(indr_dev, cb, cb_ident);
+	if (!indr_block_cb)
+		return;
+
+	/* Send unbind message if required to free any block cbs. */
+	if (indr_dev->cmd_cb)
+		indr_dev->cmd_cb(indr_dev->dev, indr_dev->block,
+				 indr_block_cb,
+				 FLOW_BLOCK_UNBIND);
+
+	flow_indr_block_cb_del(indr_block_cb);
+	flow_indr_block_dev_put(indr_dev);
+}
+EXPORT_SYMBOL_GPL(__flow_indr_block_cb_unregister);
+
+void flow_indr_block_cb_unregister(struct net_device *dev,
+				   flow_indr_block_bind_cb_t *cb,
+				   void *cb_ident)
+{
+	rtnl_lock();
+	__flow_indr_block_cb_unregister(dev, cb, cb_ident);
+	rtnl_unlock();
+}
+EXPORT_SYMBOL_GPL(flow_indr_block_cb_unregister);
+
+static bool rhash_table_init;
+int flow_indr_rhashtable_init(void)
+{
+	int err = 0;
+
+	if (!rhash_table_init) {
+		err = rhashtable_init(&indr_setup_block_ht,
+				      &flow_indr_setup_block_ht_params);
+
+		if (!err)
+			rhash_table_init = true;
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(flow_indr_rhashtable_init);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index efd3cfb..359d92f 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -36,6 +36,7 @@
 #include <net/tc_act/tc_sample.h>
 #include <net/tc_act/tc_skbedit.h>
 #include <net/tc_act/tc_ct.h>
+#include <net/flow_offload.h>
 
 extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
 
@@ -544,235 +545,39 @@ static void tcf_chain_flush(struct tcf_chain *chain, bool rtnl_held)
 	}
 }
 
-static struct tcf_block *tc_dev_ingress_block(struct net_device *dev)
-{
-	const struct Qdisc_class_ops *cops;
-	struct Qdisc *qdisc;
-
-	if (!dev_ingress_queue(dev))
-		return NULL;
-
-	qdisc = dev_ingress_queue(dev)->qdisc_sleeping;
-	if (!qdisc)
-		return NULL;
-
-	cops = qdisc->ops->cl_ops;
-	if (!cops)
-		return NULL;
-
-	if (!cops->tcf_block)
-		return NULL;
-
-	return cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
-}
-
-static struct rhashtable indr_setup_block_ht;
-
-struct tc_indr_block_dev {
-	struct rhash_head ht_node;
-	struct net_device *dev;
-	unsigned int refcnt;
-	struct list_head cb_list;
-	struct tcf_block *block;
-};
-
-struct tc_indr_block_cb {
-	struct list_head list;
-	void *cb_priv;
-	tc_indr_block_bind_cb_t *cb;
-	void *cb_ident;
-};
-
-static const struct rhashtable_params tc_indr_setup_block_ht_params = {
-	.key_offset	= offsetof(struct tc_indr_block_dev, dev),
-	.head_offset	= offsetof(struct tc_indr_block_dev, ht_node),
-	.key_len	= sizeof(struct net_device *),
-};
-
-static struct tc_indr_block_dev *
-tc_indr_block_dev_lookup(struct net_device *dev)
-{
-	return rhashtable_lookup_fast(&indr_setup_block_ht, &dev,
-				      tc_indr_setup_block_ht_params);
-}
-
-static struct tc_indr_block_dev *tc_indr_block_dev_get(struct net_device *dev)
-{
-	struct tc_indr_block_dev *indr_dev;
-
-	indr_dev = tc_indr_block_dev_lookup(dev);
-	if (indr_dev)
-		goto inc_ref;
-
-	indr_dev = kzalloc(sizeof(*indr_dev), GFP_KERNEL);
-	if (!indr_dev)
-		return NULL;
-
-	INIT_LIST_HEAD(&indr_dev->cb_list);
-	indr_dev->dev = dev;
-	indr_dev->block = tc_dev_ingress_block(dev);
-	if (rhashtable_insert_fast(&indr_setup_block_ht, &indr_dev->ht_node,
-				   tc_indr_setup_block_ht_params)) {
-		kfree(indr_dev);
-		return NULL;
-	}
-
-inc_ref:
-	indr_dev->refcnt++;
-	return indr_dev;
-}
-
-static void tc_indr_block_dev_put(struct tc_indr_block_dev *indr_dev)
-{
-	if (--indr_dev->refcnt)
-		return;
-
-	rhashtable_remove_fast(&indr_setup_block_ht, &indr_dev->ht_node,
-			       tc_indr_setup_block_ht_params);
-	kfree(indr_dev);
-}
-
-static struct tc_indr_block_cb *
-tc_indr_block_cb_lookup(struct tc_indr_block_dev *indr_dev,
-			tc_indr_block_bind_cb_t *cb, void *cb_ident)
-{
-	struct tc_indr_block_cb *indr_block_cb;
-
-	list_for_each_entry(indr_block_cb, &indr_dev->cb_list, list)
-		if (indr_block_cb->cb == cb &&
-		    indr_block_cb->cb_ident == cb_ident)
-			return indr_block_cb;
-	return NULL;
-}
-
-static struct tc_indr_block_cb *
-tc_indr_block_cb_add(struct tc_indr_block_dev *indr_dev, void *cb_priv,
-		     tc_indr_block_bind_cb_t *cb, void *cb_ident)
-{
-	struct tc_indr_block_cb *indr_block_cb;
-
-	indr_block_cb = tc_indr_block_cb_lookup(indr_dev, cb, cb_ident);
-	if (indr_block_cb)
-		return ERR_PTR(-EEXIST);
-
-	indr_block_cb = kzalloc(sizeof(*indr_block_cb), GFP_KERNEL);
-	if (!indr_block_cb)
-		return ERR_PTR(-ENOMEM);
-
-	indr_block_cb->cb_priv = cb_priv;
-	indr_block_cb->cb = cb;
-	indr_block_cb->cb_ident = cb_ident;
-	list_add(&indr_block_cb->list, &indr_dev->cb_list);
-
-	return indr_block_cb;
-}
-
-static void tc_indr_block_cb_del(struct tc_indr_block_cb *indr_block_cb)
-{
-	list_del(&indr_block_cb->list);
-	kfree(indr_block_cb);
-}
-
 static int tcf_block_setup(struct tcf_block *block,
 			   struct flow_block_offload *bo);
 
-static void tc_indr_block_ing_cmd(struct tc_indr_block_dev *indr_dev,
-				  struct tc_indr_block_cb *indr_block_cb,
+static void tc_indr_block_ing_cmd(struct net_device *dev, void *block,
+				  struct flow_indr_block_cb *indr_block_cb,
 				  enum flow_block_command command)
 {
+	struct tcf_block *t_block = (struct tcf_block *)block;
 	struct flow_block_offload bo = {
 		.command	= command,
 		.binder_type	= FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS,
-		.net		= dev_net(indr_dev->dev),
-		.block_shared	= tcf_block_non_null_shared(indr_dev->block),
+		.net		= dev_net(dev),
+		.block_shared	= tcf_block_non_null_shared(t_block),
 	};
 	INIT_LIST_HEAD(&bo.cb_list);
 
-	if (!indr_dev->block)
-		return;
-
-	bo.block = &indr_dev->block->flow_block;
-
-	indr_block_cb->cb(indr_dev->dev, indr_block_cb->cb_priv, TC_SETUP_BLOCK,
-			  &bo);
-	tcf_block_setup(indr_dev->block, &bo);
-}
-
-int __tc_indr_block_cb_register(struct net_device *dev, void *cb_priv,
-				tc_indr_block_bind_cb_t *cb, void *cb_ident)
-{
-	struct tc_indr_block_cb *indr_block_cb;
-	struct tc_indr_block_dev *indr_dev;
-	int err;
-
-	indr_dev = tc_indr_block_dev_get(dev);
-	if (!indr_dev)
-		return -ENOMEM;
-
-	indr_block_cb = tc_indr_block_cb_add(indr_dev, cb_priv, cb, cb_ident);
-	err = PTR_ERR_OR_ZERO(indr_block_cb);
-	if (err)
-		goto err_dev_put;
-
-	tc_indr_block_ing_cmd(indr_dev, indr_block_cb, FLOW_BLOCK_BIND);
-	return 0;
-
-err_dev_put:
-	tc_indr_block_dev_put(indr_dev);
-	return err;
-}
-EXPORT_SYMBOL_GPL(__tc_indr_block_cb_register);
-
-int tc_indr_block_cb_register(struct net_device *dev, void *cb_priv,
-			      tc_indr_block_bind_cb_t *cb, void *cb_ident)
-{
-	int err;
-
-	rtnl_lock();
-	err = __tc_indr_block_cb_register(dev, cb_priv, cb, cb_ident);
-	rtnl_unlock();
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(tc_indr_block_cb_register);
-
-void __tc_indr_block_cb_unregister(struct net_device *dev,
-				   tc_indr_block_bind_cb_t *cb, void *cb_ident)
-{
-	struct tc_indr_block_cb *indr_block_cb;
-	struct tc_indr_block_dev *indr_dev;
-
-	indr_dev = tc_indr_block_dev_lookup(dev);
-	if (!indr_dev)
+	if (!t_block)
 		return;
 
-	indr_block_cb = tc_indr_block_cb_lookup(indr_dev, cb, cb_ident);
-	if (!indr_block_cb)
-		return;
+	bo.block = &t_block->flow_block;
 
-	/* Send unbind message if required to free any block cbs. */
-	tc_indr_block_ing_cmd(indr_dev, indr_block_cb, FLOW_BLOCK_UNBIND);
-	tc_indr_block_cb_del(indr_block_cb);
-	tc_indr_block_dev_put(indr_dev);
-}
-EXPORT_SYMBOL_GPL(__tc_indr_block_cb_unregister);
+	indr_block_cb->cb(dev, indr_block_cb->cb_priv, TC_SETUP_BLOCK, &bo);
 
-void tc_indr_block_cb_unregister(struct net_device *dev,
-				 tc_indr_block_bind_cb_t *cb, void *cb_ident)
-{
-	rtnl_lock();
-	__tc_indr_block_cb_unregister(dev, cb, cb_ident);
-	rtnl_unlock();
+	tcf_block_setup(t_block, &bo);
 }
-EXPORT_SYMBOL_GPL(tc_indr_block_cb_unregister);
 
 static void tc_indr_block_call(struct tcf_block *block, struct net_device *dev,
 			       struct tcf_block_ext_info *ei,
 			       enum flow_block_command command,
 			       struct netlink_ext_ack *extack)
 {
-	struct tc_indr_block_cb *indr_block_cb;
-	struct tc_indr_block_dev *indr_dev;
+	struct flow_indr_block_cb *indr_block_cb;
+	struct flow_indr_block_dev *indr_dev;
 	struct flow_block_offload bo = {
 		.command	= command,
 		.binder_type	= ei->binder_type,
@@ -783,11 +588,12 @@ static void tc_indr_block_call(struct tcf_block *block, struct net_device *dev,
 	};
 	INIT_LIST_HEAD(&bo.cb_list);
 
-	indr_dev = tc_indr_block_dev_lookup(dev);
+	indr_dev = flow_indr_block_dev_lookup(dev);
 	if (!indr_dev)
 		return;
 
 	indr_dev->block = command == FLOW_BLOCK_BIND ? block : NULL;
+	indr_dev->cmd_cb = command == FLOW_BLOCK_BIND ? tc_indr_block_ing_cmd : NULL;
 
 	list_for_each_entry(indr_block_cb, &indr_dev->cb_list, list)
 		indr_block_cb->cb(dev, indr_block_cb->cb_priv, TC_SETUP_BLOCK,
@@ -3333,8 +3139,7 @@ static int __init tc_filter_init(void)
 	if (err)
 		goto err_register_pernet_subsys;
 
-	err = rhashtable_init(&indr_setup_block_ht,
-			      &tc_indr_setup_block_ht_params);
+	err = flow_indr_rhashtable_init();
 	if (err)
 		goto err_rhash_setup_block_ht;
 
-- 
1.8.3.1

