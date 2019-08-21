Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E15F97168
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 07:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfHUFKH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Aug 2019 01:10:07 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:31897 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfHUFKH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:10:07 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id C07A3418AB;
        Wed, 21 Aug 2019 13:09:54 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v5 5/8] netfilter: nft_tunnel: support tunnel meta match offload
Date:   Wed, 21 Aug 2019 13:09:50 +0800
Message-Id: <1566364193-31330-6-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566364193-31330-1-git-send-email-wenxu@ucloud.cn>
References: <1566364193-31330-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSktIS0tLS09PQ0lJTUJZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MC46Vhw5SjgrOT8VQxE8IzkS
        KT8aFC1VSlVKTk1NSE1PSkJPQkpNVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUhCT003Bg++
X-HM-Tid: 0a6cb294d8042086kuqyc07a3418ab
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Add tunnel meta match offload. Currently support for NFT_TUNNEL_ID
NFT_TUNNEL_SRC_IP and NFT_TUNNEL_DST_IP

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v5: no change

 include/net/netfilter/nf_tables_offload.h |  5 ++++
 net/netfilter/nft_tunnel.c                | 41 +++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/net/netfilter/nf_tables_offload.h b/include/net/netfilter/nf_tables_offload.h
index 8a5969d9..cafc262 100644
--- a/include/net/netfilter/nf_tables_offload.h
+++ b/include/net/netfilter/nf_tables_offload.h
@@ -44,6 +44,11 @@ struct nft_flow_key {
 	struct flow_dissector_key_ip			ip;
 	struct flow_dissector_key_vlan			vlan;
 	struct flow_dissector_key_eth_addrs		eth_addrs;
+	struct flow_dissector_key_keyid         enc_key_id;
+	union {
+		struct flow_dissector_key_ipv4_addrs	enc_ipv4;
+		struct flow_dissector_key_ipv6_addrs	enc_ipv6;
+	};
 } __aligned(BITS_PER_LONG / 8); /* Ensure that we can do comparisons as longs. */
 
 struct nft_flow_match {
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 58b6083..018ec27 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -11,6 +11,7 @@
 #include <net/ip_tunnels.h>
 #include <net/vxlan.h>
 #include <net/erspan.h>
+#include <net/netfilter/nf_tables_offload.h>
 
 struct nft_tunnel {
 	enum nft_tunnel_keys	key:8;
@@ -177,6 +178,45 @@ static int nft_tunnel_get_dump(struct sk_buff *skb,
 	return -1;
 }
 
+static int nft_tunnel_get_offload(struct nft_offload_ctx *ctx,
+				  struct nft_flow_rule *flow,
+				  const struct nft_expr *expr)
+{
+	const struct nft_tunnel *priv = nft_expr_priv(expr);
+	struct nft_offload_reg *reg = &ctx->regs[priv->dreg];
+
+	if (priv->mode == NFT_TUNNEL_MODE_TX)
+		return -EOPNOTSUPP;
+
+	switch (priv->key) {
+	case NFT_TUNNEL_ID:
+		NFT_OFFLOAD_MATCH(FLOW_DISSECTOR_KEY_ENC_KEYID, enc_key_id, keyid,
+				  sizeof(__u32), reg);
+		break;
+	case NFT_TUNNEL_IP_SRC:
+		NFT_OFFLOAD_MATCH(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS, enc_ipv4, src,
+				  sizeof(__u32), reg);
+		break;
+	case NFT_TUNNEL_IP_DST:
+		NFT_OFFLOAD_MATCH(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS, enc_ipv4, dst,
+				  sizeof(__u32), reg);
+		break;
+	case NFT_TUNNEL_IP6_SRC:
+		NFT_OFFLOAD_MATCH(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS, enc_ipv6, src,
+				  sizeof(struct in6_addr), reg);
+		break;
+	case NFT_TUNNEL_IP6_DST:
+		NFT_OFFLOAD_MATCH(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS, enc_ipv6, dst,
+				  sizeof(struct in6_addr), reg);
+		break;
+	case NFT_TUNNEL_PATH:
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static struct nft_expr_type nft_tunnel_type;
 static const struct nft_expr_ops nft_tunnel_get_ops = {
 	.type		= &nft_tunnel_type,
@@ -184,6 +224,7 @@ static int nft_tunnel_get_dump(struct sk_buff *skb,
 	.eval		= nft_tunnel_get_eval,
 	.init		= nft_tunnel_get_init,
 	.dump		= nft_tunnel_get_dump,
+	.offload	= nft_tunnel_get_offload,
 };
 
 static struct nft_expr_type nft_tunnel_type __read_mostly = {
-- 
1.8.3.1

