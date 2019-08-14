Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C04BD8D07C
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2019 12:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfHNKQz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 14 Aug 2019 06:16:55 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:55614 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfHNKQz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:16:55 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 9CD8141BC3;
        Wed, 14 Aug 2019 18:16:50 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v4 10/12] netfilter: nft_tunnel: add NFTA_TUNNEL_KEY_RELEASE action
Date:   Wed, 14 Aug 2019 18:16:46 +0800
Message-Id: <1565777808-28735-11-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565777808-28735-1-git-send-email-wenxu@ucloud.cn>
References: <1565777808-28735-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSUhCQkJCQ0JLSElMT05ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nyo6Nww5SDg#MTkuAjAVCDQ9
        QylPCTxVSlVKTk1OTExMQ0pLTUNDVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQU9LSkM3Bg++
X-HM-Tid: 0a6c8fa154de2086kuqy9cd8141bc3
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Add new NFTA_TUNNEL_KEY_RELEASE action for future offload
feature

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v4: no change

 include/uapi/linux/netfilter/nf_tables.h |  1 +
 net/netfilter/nft_tunnel.c               | 24 +++++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index bfb051f..b37b8a7 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1758,6 +1758,7 @@ enum nft_tunnel_key_attributes {
 	NFTA_TUNNEL_KEY_SPORT,
 	NFTA_TUNNEL_KEY_DPORT,
 	NFTA_TUNNEL_KEY_OPTS,
+	NFTA_TUNNEL_KEY_RELEASE,
 	__NFTA_TUNNEL_KEY_MAX
 };
 #define NFTA_TUNNEL_KEY_MAX	(__NFTA_TUNNEL_KEY_MAX - 1)
diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 018ec27..aa3dc52 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -247,6 +247,7 @@ struct nft_tunnel_opts {
 struct nft_tunnel_obj {
 	struct metadata_dst	*md;
 	struct nft_tunnel_opts	opts;
+	bool tunnel_key_release;
 };
 
 static const struct nla_policy nft_tunnel_ip_policy[NFTA_TUNNEL_KEY_IP_MAX + 1] = {
@@ -431,6 +432,7 @@ static int nft_tunnel_obj_opts_init(const struct nft_ctx *ctx,
 	[NFTA_TUNNEL_KEY_TOS]	= { .type = NLA_U8, },
 	[NFTA_TUNNEL_KEY_TTL]	= { .type = NLA_U8, },
 	[NFTA_TUNNEL_KEY_OPTS]	= { .type = NLA_NESTED, },
+	[NFTA_TUNNEL_KEY_RELEASE]	= { .type = NLA_U8, },
 };
 
 static int nft_tunnel_obj_init(const struct nft_ctx *ctx,
@@ -442,6 +444,12 @@ static int nft_tunnel_obj_init(const struct nft_ctx *ctx,
 	struct metadata_dst *md;
 	int err;
 
+	if (tb[NFTA_TUNNEL_KEY_RELEASE]) {
+		priv->tunnel_key_release = !!nla_get_u8(tb[NFTA_TUNNEL_KEY_RELEASE]);
+		if (priv->tunnel_key_release)
+			return 0;
+	}
+
 	if (!tb[NFTA_TUNNEL_KEY_ID])
 		return -EINVAL;
 
@@ -524,8 +532,11 @@ static inline void nft_tunnel_obj_eval(struct nft_object *obj,
 	struct sk_buff *skb = pkt->skb;
 
 	skb_dst_drop(skb);
-	dst_hold((struct dst_entry *) priv->md);
-	skb_dst_set(skb, (struct dst_entry *) priv->md);
+
+	if (!priv->tunnel_key_release) {
+		dst_hold((struct dst_entry *)priv->md);
+		skb_dst_set(skb, (struct dst_entry *)priv->md);
+	}
 }
 
 static int nft_tunnel_ip_dump(struct sk_buff *skb, struct ip_tunnel_info *info)
@@ -627,6 +638,12 @@ static int nft_tunnel_obj_dump(struct sk_buff *skb,
 	struct nft_tunnel_obj *priv = nft_obj_data(obj);
 	struct ip_tunnel_info *info = &priv->md->u.tun_info;
 
+	if (priv->tunnel_key_release) {
+		if (nla_put_u8(skb, NFTA_TUNNEL_KEY_RELEASE, 1))
+			goto nla_put_failure;
+		return 0;
+	}
+
 	if (nla_put_be32(skb, NFTA_TUNNEL_KEY_ID,
 			 tunnel_id_to_key32(info->key.tun_id)) ||
 	    nft_tunnel_ip_dump(skb, info) < 0 ||
@@ -648,7 +665,8 @@ static void nft_tunnel_obj_destroy(const struct nft_ctx *ctx,
 {
 	struct nft_tunnel_obj *priv = nft_obj_data(obj);
 
-	metadata_dst_free(priv->md);
+	if (!priv->tunnel_key_release)
+		metadata_dst_free(priv->md);
 }
 
 static struct nft_object_type nft_tunnel_obj_type;
-- 
1.8.3.1

