Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5CE75EDD
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jul 2019 08:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfGZGSB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 26 Jul 2019 02:18:01 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:10846 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfGZGSB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 26 Jul 2019 02:18:01 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 8E1BB41ABD;
        Fri, 26 Jul 2019 14:17:50 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/3] flow_offload: Support get tcf block immediately
Date:   Fri, 26 Jul 2019 14:17:48 +0800
Message-Id: <1564121869-3398-3-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564121869-3398-1-git-send-email-wenxu@ucloud.cn>
References: <1564121869-3398-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVS09NQkJCQ0pJSklNSk1ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhA6HTo5Fjg5Iks5Sg0OTD84
        IkkaC09VSlVKTk1PSklKQ0xLQklJVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQU9PSEk3Bg++
X-HM-Tid: 0a6c2cedb10e2086kuqy8e1bb41abd
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Because the new flow-indr-block can't get the tcf_block
directly.
It provide a callback to find the tcf block immediately
when the device register and contain a ingress block.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v2: make use of flow_block

 include/net/flow_offload.h |  4 ++++
 net/core/flow_offload.c    | 12 ++++++++++++
 net/sched/cls_api.c        | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index b5ef5be..bfe3a34 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -391,6 +391,10 @@ struct flow_indr_block_dev {
 	struct flow_block *flow_block;
 };
 
+typedef void flow_indr_get_default_block_t(struct flow_indr_block_dev *indr_dev);
+
+void flow_indr_set_default_block_cb(flow_indr_get_default_block_t *cb);
+
 struct flow_indr_block_dev *flow_indr_block_dev_lookup(struct net_device *dev);
 
 int flow_indr_rhashtable_init(void);
diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
index a6785df..eeff99f 100644
--- a/net/core/flow_offload.c
+++ b/net/core/flow_offload.c
@@ -298,6 +298,14 @@ struct flow_indr_block_dev *
 }
 EXPORT_SYMBOL(flow_indr_block_dev_lookup);
 
+static flow_indr_get_default_block_t *flow_indr_get_default_block;
+
+void flow_indr_set_default_block_cb(flow_indr_get_default_block_t *cb)
+{
+	flow_indr_get_default_block = cb;
+}
+EXPORT_SYMBOL(flow_indr_set_default_block_cb);
+
 static struct flow_indr_block_dev *flow_indr_block_dev_get(struct net_device *dev)
 {
 	struct flow_indr_block_dev *indr_dev;
@@ -312,6 +320,10 @@ static struct flow_indr_block_dev *flow_indr_block_dev_get(struct net_device *de
 
 	INIT_LIST_HEAD(&indr_dev->cb_list);
 	indr_dev->dev = dev;
+
+	if (flow_indr_get_default_block)
+		flow_indr_get_default_block(indr_dev);
+
 	if (rhashtable_insert_fast(&indr_setup_block_ht, &indr_dev->ht_node,
 				   flow_indr_setup_block_ht_params)) {
 		kfree(indr_dev);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index d370c52..8d4d7f0 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -576,6 +576,38 @@ static void tc_indr_block_ing_cmd(struct net_device *dev,
 	tcf_block_setup(block, &bo);
 }
 
+static struct tcf_block *tc_dev_ingress_block(struct net_device *dev)
+{
+	const struct Qdisc_class_ops *cops;
+	struct Qdisc *qdisc;
+
+	if (!dev_ingress_queue(dev))
+		return NULL;
+
+	qdisc = dev_ingress_queue(dev)->qdisc_sleeping;
+	if (!qdisc)
+		return NULL;
+
+	cops = qdisc->ops->cl_ops;
+	if (!cops)
+		return NULL;
+
+	if (!cops->tcf_block)
+		return NULL;
+
+	return cops->tcf_block(qdisc, TC_H_MIN_INGRESS, NULL);
+}
+
+static void tc_indr_get_default_block(struct flow_indr_block_dev *indr_dev)
+{
+	struct tcf_block *block = tc_dev_ingress_block(indr_dev->dev);
+
+	if (block) {
+		indr_dev->flow_block = &block->flow_block;
+		indr_dev->ing_cmd_cb = tc_indr_block_ing_cmd;
+	}
+}
+
 static void tc_indr_block_call(struct tcf_block *block, struct net_device *dev,
 			       struct tcf_block_ext_info *ei,
 			       enum flow_block_command command,
@@ -3172,6 +3204,8 @@ static int __init tc_filter_init(void)
 	if (err)
 		goto err_rhash_setup_block_ht;
 
+	flow_indr_set_default_block_cb(tc_indr_get_default_block);
+
 	rtnl_register(PF_UNSPEC, RTM_NEWTFILTER, tc_new_tfilter, NULL,
 		      RTNL_FLAG_DOIT_UNLOCKED);
 	rtnl_register(PF_UNSPEC, RTM_DELTFILTER, tc_del_tfilter, NULL,
-- 
1.8.3.1

