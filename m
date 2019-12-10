Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBDE9118153
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Dec 2019 08:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfLJH02 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Dec 2019 02:26:28 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:36221 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfLJH02 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Dec 2019 02:26:28 -0500
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 0DEFA41A6B;
        Tue, 10 Dec 2019 15:26:26 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v3 1/4] netfilter: nf_flow_table_offload: refactor nf_flow_table_offload_setup to support indir setup
Date:   Tue, 10 Dec 2019 15:26:22 +0800
Message-Id: <1575962785-14812-2-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575962785-14812-1-git-send-email-wenxu@ucloud.cn>
References: <1575962785-14812-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSkhNQkJCQk1PTEpPS05ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PSI6Qjo5Tzg1H0kVSBE5MA0c
        Ew4KCQ9VSlVKTkxOQk1JTENNTklMVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUhOSEo3Bg++
X-HM-Tid: 0a6eeeb3b9342086kuqy0defa41a6b
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Refactor nf_flow_table_offload_setup to support indir setup in
the next patch

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v3: no change

 net/netfilter/nf_flow_table_offload.c | 54 ++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index de7a0d1..89eb1a5 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -808,26 +808,31 @@ static int nf_flow_table_block_setup(struct nf_flowtable *flowtable,
 	return err;
 }
 
-int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
-				struct net_device *dev,
-				enum flow_block_command cmd)
+static void nf_flow_table_block_offload_init(struct flow_block_offload *bo,
+					     struct net *net,
+					     enum flow_block_command cmd,
+					     struct nf_flowtable *flowtable,
+					     struct netlink_ext_ack *extack)
+{
+	memset(bo, 0, sizeof(*bo));
+	bo->net		= net;
+	bo->block	= &flowtable->flow_block;
+	bo->command	= cmd;
+	bo->binder_type	= FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
+	bo->extack	= extack;
+	INIT_LIST_HEAD(&bo->cb_list);
+}
+
+static int nf_flow_table_offload_cmd(struct nf_flowtable *flowtable,
+				     struct net_device *dev,
+				     enum flow_block_command cmd)
 {
 	struct netlink_ext_ack extack = {};
-	struct flow_block_offload bo = {};
+	struct flow_block_offload bo;
 	int err;
 
-	if (!(flowtable->flags & NF_FLOWTABLE_HW_OFFLOAD))
-		return 0;
-
-	if (!dev->netdev_ops->ndo_setup_tc)
-		return -EOPNOTSUPP;
-
-	bo.net		= dev_net(dev);
-	bo.block	= &flowtable->flow_block;
-	bo.command	= cmd;
-	bo.binder_type	= FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
-	bo.extack	= &extack;
-	INIT_LIST_HEAD(&bo.cb_list);
+	nf_flow_table_block_offload_init(&bo, dev_net(dev), cmd, flowtable,
+					 &extack);
 
 	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_FT, &bo);
 	if (err < 0)
@@ -835,6 +840,23 @@ int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
 
 	return nf_flow_table_block_setup(flowtable, &bo, cmd);
 }
+
+int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
+				struct net_device *dev,
+				enum flow_block_command cmd)
+{
+	int err;
+
+	if (!(flowtable->flags & NF_FLOWTABLE_HW_OFFLOAD))
+		return 0;
+
+	if (dev->netdev_ops->ndo_setup_tc)
+		err = nf_flow_table_offload_cmd(flowtable, dev, cmd);
+	else
+		err = -EOPNOTSUPP;
+
+	return err;
+}
 EXPORT_SYMBOL_GPL(nf_flow_table_offload_setup);
 
 int nf_flow_table_offload_init(void)
-- 
1.8.3.1

