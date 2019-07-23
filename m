Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F8718B9
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jul 2019 14:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390039AbfGWMw5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Jul 2019 08:52:57 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:26695 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390011AbfGWMw4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:52:56 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 3A6AA41CF1;
        Tue, 23 Jul 2019 20:52:46 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 6/7] netfilter: nft_fwd_netdev: add fw_netdev action support
Date:   Tue, 23 Jul 2019 20:52:43 +0800
Message-Id: <1563886364-11164-7-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563886364-11164-1-git-send-email-wenxu@ucloud.cn>
References: <1563886364-11164-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSExCS0tLS01MTEpLQ0NZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQg6Igw*Tzg9NlE9SSwOTi0s
        PEtPFEtVSlVKTk1IQ0NNSE1NSEpPVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlDSkI3Bg++
X-HM-Tid: 0a6c1ee42e2a2086kuqy3a6aa41cf1
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

fwd_netdev action offload:
nft --debug=netlink add rule netdev firewall aclout ip daddr 10.0.1.7 fwd to eth0

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 net/netfilter/nft_fwd_netdev.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 61b7f93..06dbd98 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -15,6 +15,7 @@
 #include <net/netfilter/nf_dup_netdev.h>
 #include <net/neighbour.h>
 #include <net/ip.h>
+#include <net/netfilter/nf_tables_offload.h>
 
 struct nft_fwd_netdev {
 	enum nft_registers	sreg_dev:8;
@@ -63,6 +64,33 @@ static int nft_fwd_netdev_dump(struct sk_buff *skb, const struct nft_expr *expr)
 	return -1;
 }
 
+static int nft_fwd_netdev_offload(struct nft_offload_ctx *ctx,
+				  struct nft_flow_rule *flow,
+				  const struct nft_expr *expr)
+{
+	const struct nft_fwd_netdev *priv = nft_expr_priv(expr);
+	struct nft_offload_reg *reg = &ctx->regs[priv->sreg_dev];
+	const struct nft_data *data = &reg->action.data;
+	struct flow_action_entry *entry;
+	struct net_device *dev;
+	int oif = -1;
+
+	if (reg->type != NFT_OFFLOAD_REG_ACTION)
+		return -EOPNOTSUPP;
+
+	entry = &flow->rule->action.entries[ctx->num_actions++];
+
+	memcpy(&oif, data->data, sizeof(oif));
+	dev = __dev_get_by_index(ctx->net, oif);
+	if (!dev)
+		return -EOPNOTSUPP;
+
+	entry->id = FLOW_ACTION_REDIRECT;
+	entry->dev = dev;
+
+	return 0;
+}
+
 struct nft_fwd_neigh {
 	enum nft_registers	sreg_dev:8;
 	enum nft_registers	sreg_addr:8;
@@ -194,6 +222,8 @@ static int nft_fwd_neigh_dump(struct sk_buff *skb, const struct nft_expr *expr)
 	.eval		= nft_fwd_netdev_eval,
 	.init		= nft_fwd_netdev_init,
 	.dump		= nft_fwd_netdev_dump,
+	.offload	= nft_fwd_netdev_offload,
+	.offload_actions = nft_offload_action,
 };
 
 static const struct nft_expr_ops *
-- 
1.8.3.1

