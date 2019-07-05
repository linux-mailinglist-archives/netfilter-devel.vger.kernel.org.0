Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E67636066F
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jul 2019 15:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfGENQr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 5 Jul 2019 09:16:47 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:49120 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbfGENQr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:16:47 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id E82AA419E8;
        Fri,  5 Jul 2019 21:16:39 +0800 (CST)
From:   wenxu@ucloud.cn
To:     nikolay@cumulusnetworks.com, pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org, bridge@lists.linux-foundation.org
Subject: [PATCH 6/7 nf-next v2] netfilter: nft_meta_bridge: Add NFT_META_BRI_IIFVPROTO support
Date:   Fri,  5 Jul 2019 21:16:37 +0800
Message-Id: <1562332598-17415-6-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562332598-17415-1-git-send-email-wenxu@ucloud.cn>
References: <1562332598-17415-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSUhPS0tLS0NNTENPSE1ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OVE6Ezo4FTgyUQhNTjA9Vj1L
        SD1PFAlVSlVKTk1JSEhJTUtLS0tJVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlCQkg3Bg++
X-HM-Tid: 0a6bc24796a42086kuqye82aa419e8
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This patch provide a meta to get the bridge vlan proto

nft add rule bridge firewall zones counter meta br_vlan_proto 0x8100

Signed-off-by: wenxu <wenxu@ucloud.cn>
Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 include/uapi/linux/netfilter/nf_tables.h |  2 ++
 net/bridge/netfilter/nft_meta_bridge.c   | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 8a1bd0b..a0d1dbd 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -796,6 +796,7 @@ enum nft_exthdr_attributes {
  * @NFT_META_IIFKIND: packet input interface kind name (dev->rtnl_link_ops->kind)
  * @NFT_META_OIFKIND: packet output interface kind name (dev->rtnl_link_ops->kind)
  * @NFT_META_BRI_IIFPVID: packet input bridge port pvid
+ * @NFT_META_BRI_IIFVPROTO: packet input bridge vlan proto
  */
 enum nft_meta_keys {
 	NFT_META_LEN,
@@ -827,6 +828,7 @@ enum nft_meta_keys {
 	NFT_META_IIFKIND,
 	NFT_META_OIFKIND,
 	NFT_META_BRI_IIFPVID,
+	NFT_META_BRI_IIFVPROTO,
 };
 
 /**
diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index 9487d42..bed66f5 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -49,6 +49,17 @@ static void nft_meta_bridge_get_eval(const struct nft_expr *expr,
 		nft_reg_store16(dest, p_pvid);
 		return;
 	}
+	case NFT_META_BRI_IIFVPROTO: {
+		u16 p_proto;
+
+		br_dev = nft_meta_get_bridge(in);
+		if (!br_dev || !br_vlan_enabled(br_dev))
+			goto err;
+
+		br_vlan_get_proto(br_dev, &p_proto);
+		nft_reg_store16(dest, p_proto);
+		return;
+	}
 	default:
 		goto out;
 	}
@@ -75,6 +86,7 @@ static int nft_meta_bridge_get_init(const struct nft_ctx *ctx,
 		len = IFNAMSIZ;
 		break;
 	case NFT_META_BRI_IIFPVID:
+	case NFT_META_BRI_IIFVPROTO:
 		len = sizeof(u16);
 		break;
 	default:
-- 
1.8.3.1

