Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 096A274CA1
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jul 2019 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403890AbfGYLNN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Jul 2019 07:13:13 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:19978 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391544AbfGYLNN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:13:13 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id B433741D96;
        Thu, 25 Jul 2019 19:12:57 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v6 8/8] netfilter: Support the bridge family in flow table
Date:   Thu, 25 Jul 2019 19:12:56 +0800
Message-Id: <1564053176-28605-9-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564053176-28605-1-git-send-email-wenxu@ucloud.cn>
References: <1564053176-28605-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVQkJJS0tLSE9KT0pOT0pZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzI6FCo*FDg3LlYwDQ0rPxYx
        TxhPCT5VSlVKTk1PS05ISkxMQ0lOVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQU9LTkM3Bg++
X-HM-Tid: 0a6c28d585952086kuqyb433741d96
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This patch add the bridge flow table type. Implement the datapath
flow table to forward both IPV4 and IPV6 traffic through bridge.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v6: rebase Kconfig file to master

 net/bridge/netfilter/Kconfig                |  8 +++++
 net/bridge/netfilter/Makefile               |  1 +
 net/bridge/netfilter/nf_flow_table_bridge.c | 48 +++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 net/bridge/netfilter/nf_flow_table_bridge.c

diff --git a/net/bridge/netfilter/Kconfig b/net/bridge/netfilter/Kconfig
index 5040fe4..ad100cb 100644
--- a/net/bridge/netfilter/Kconfig
+++ b/net/bridge/netfilter/Kconfig
@@ -41,6 +41,14 @@ config NF_CONNTRACK_BRIDGE
 
 	  To compile it as a module, choose M here.  If unsure, say N.
 
+config NF_FLOW_TABLE_BRIDGE
+	tristate "Netfilter flow table bridge module"
+	depends on NF_FLOW_TABLE && NF_CONNTRACK_BRIDGE
+	help
+          This option adds the flow table bridge support.
+
+	  To compile it as a module, choose M here.
+
 menuconfig BRIDGE_NF_EBTABLES
 	tristate "Ethernet Bridge tables (ebtables) support"
 	depends on BRIDGE && NETFILTER && NETFILTER_XTABLES
diff --git a/net/bridge/netfilter/Makefile b/net/bridge/netfilter/Makefile
index 8e2c575..627b269 100644
--- a/net/bridge/netfilter/Makefile
+++ b/net/bridge/netfilter/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_NFT_BRIDGE_REJECT)  += nft_reject_bridge.o
 
 # connection tracking
 obj-$(CONFIG_NF_CONNTRACK_BRIDGE) += nf_conntrack_bridge.o
+obj-$(CONFIG_NF_FLOW_TABLE_BRIDGE) += nf_flow_table_bridge.o
 
 # packet logging
 obj-$(CONFIG_NF_LOG_BRIDGE) += nf_log_bridge.o
diff --git a/net/bridge/netfilter/nf_flow_table_bridge.c b/net/bridge/netfilter/nf_flow_table_bridge.c
new file mode 100644
index 0000000..c4fdd4a
--- /dev/null
+++ b/net/bridge/netfilter/nf_flow_table_bridge.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/netfilter.h>
+#include <net/netfilter/nf_flow_table.h>
+#include <net/netfilter/nf_tables.h>
+
+static unsigned int
+nf_flow_offload_bridge_hook(void *priv, struct sk_buff *skb,
+			    const struct nf_hook_state *state)
+{
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		return nf_flow_offload_ip_hook(priv, skb, state);
+	case htons(ETH_P_IPV6):
+		return nf_flow_offload_ipv6_hook(priv, skb, state);
+	}
+
+	return NF_ACCEPT;
+}
+
+static struct nf_flowtable_type flowtable_bridge = {
+	.family		= NFPROTO_BRIDGE,
+	.init		= nf_flow_table_init,
+	.free		= nf_flow_table_free,
+	.hook		= nf_flow_offload_bridge_hook,
+	.owner		= THIS_MODULE,
+};
+
+static int __init nf_flow_bridge_module_init(void)
+{
+	nft_register_flowtable_type(&flowtable_bridge);
+
+	return 0;
+}
+
+static void __exit nf_flow_bridge_module_exit(void)
+{
+	nft_unregister_flowtable_type(&flowtable_bridge);
+}
+
+module_init(nf_flow_bridge_module_init);
+module_exit(nf_flow_bridge_module_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("wenxu <wenxu@ucloud.cn>");
+MODULE_ALIAS_NF_FLOWTABLE(7); /* NFPROTO_BRIDGE */
-- 
1.8.3.1

