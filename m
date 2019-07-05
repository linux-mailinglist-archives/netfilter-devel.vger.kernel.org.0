Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D196066E
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jul 2019 15:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfGENQq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 5 Jul 2019 09:16:46 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:49058 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfGENQq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:16:46 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 9C14F418A1;
        Fri,  5 Jul 2019 21:16:39 +0800 (CST)
From:   wenxu@ucloud.cn
To:     nikolay@cumulusnetworks.com, pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org, bridge@lists.linux-foundation.org
Subject: [PATCH 2/7 nf-next v2] netfilter: nft_meta_bridge: Remove the br_private.h header
Date:   Fri,  5 Jul 2019 21:16:33 +0800
Message-Id: <1562332598-17415-2-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562332598-17415-1-git-send-email-wenxu@ucloud.cn>
References: <1562332598-17415-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVS05LS0tLS0xKTklOTkxZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PiI6KAw4HTgrSQgjCTErVjM4
        VjZPCS5VSlVKTk1JSEhJTkJCTUJKVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlDT043Bg++
X-HM-Tid: 0a6bc247956c2086kuqy9c14f418a1
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Mkae the nft_bridge_meta can't direct access the bridge
internal API.

Signed-off-by: wenxu <wenxu@ucloud.cn>
Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/netfilter/nft_meta_bridge.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index dde8651..2ea8acb 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -8,7 +8,14 @@
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nft_meta.h>
 
-#include "../br_private.h"
+static const struct net_device *
+nft_meta_get_bridge(const struct net_device *dev)
+{
+	if (dev && netif_is_bridge_port(dev))
+		return netdev_master_upper_dev_get_rcu((struct net_device *)dev);
+
+	return NULL;
+}
 
 static void nft_meta_bridge_get_eval(const struct nft_expr *expr,
 				     struct nft_regs *regs,
@@ -17,22 +24,24 @@ static void nft_meta_bridge_get_eval(const struct nft_expr *expr,
 	const struct nft_meta *priv = nft_expr_priv(expr);
 	const struct net_device *in = nft_in(pkt), *out = nft_out(pkt);
 	u32 *dest = &regs->data[priv->dreg];
-	const struct net_bridge_port *p;
+	const struct net_device *br_dev;
 
 	switch (priv->key) {
 	case NFT_META_BRI_IIFNAME:
-		if (in == NULL || (p = br_port_get_rcu(in)) == NULL)
+		br_dev = nft_meta_get_bridge(in);
+		if (!br_dev)
 			goto err;
 		break;
 	case NFT_META_BRI_OIFNAME:
-		if (out == NULL || (p = br_port_get_rcu(out)) == NULL)
+		br_dev = nft_meta_get_bridge(out);
+		if (!br_dev)
 			goto err;
 		break;
 	default:
 		goto out;
 	}
 
-	strncpy((char *)dest, p->br->dev->name, IFNAMSIZ);
+	strncpy((char *)dest, br_dev->name, IFNAMSIZ);
 	return;
 out:
 	return nft_meta_get_eval(expr, regs, pkt);
-- 
1.8.3.1

