Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2976F97166
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 07:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfHUFKD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Aug 2019 01:10:03 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:31901 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfHUFKC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:10:02 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 2FF5A418BC;
        Wed, 21 Aug 2019 13:09:55 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v5 8/8] netfilter: nft_tunnel: support nft_tunnel_obj offload
Date:   Wed, 21 Aug 2019 13:09:53 +0800
Message-Id: <1566364193-31330-9-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566364193-31330-1-git-send-email-wenxu@ucloud.cn>
References: <1566364193-31330-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVklVSUhNS0tLSUJCT05ITE9ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCo6Qww4DTg#OT84DhFKIzEW
        LCEKCRJVSlVKTk1NSE1PSkJOSU1MVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlISUg3Bg++
X-HM-Tid: 0a6cb294d9962086kuqy2ff5a418bc
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Add nft_tunnel_obj offload for both encap and decap actions

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v5: no change

 net/netfilter/nft_tunnel.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index aa3dc52..b47838d 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -669,6 +669,25 @@ static void nft_tunnel_obj_destroy(const struct nft_ctx *ctx,
 		metadata_dst_free(priv->md);
 }
 
+static int nft_tunnel_obj_offload(struct nft_offload_ctx *ctx,
+				  struct nft_flow_rule *flow,
+				  struct nft_object *obj)
+{
+	struct nft_tunnel_obj *priv = nft_obj_data(obj);
+	struct flow_action_entry *entry;
+
+	entry = &flow->rule->action.entries[ctx->num_actions++];
+
+	if (!priv->tunnel_key_release) {
+		entry->id = FLOW_ACTION_TUNNEL_ENCAP;
+		entry->tunnel = &priv->md->u.tun_info;
+	} else {
+		entry->id = FLOW_ACTION_TUNNEL_DECAP;
+	}
+
+	return 0;
+}
+
 static struct nft_object_type nft_tunnel_obj_type;
 static const struct nft_object_ops nft_tunnel_obj_ops = {
 	.type		= &nft_tunnel_obj_type,
@@ -677,6 +696,7 @@ static void nft_tunnel_obj_destroy(const struct nft_ctx *ctx,
 	.init		= nft_tunnel_obj_init,
 	.destroy	= nft_tunnel_obj_destroy,
 	.dump		= nft_tunnel_obj_dump,
+	.offload	= nft_tunnel_obj_offload,
 };
 
 static struct nft_object_type nft_tunnel_obj_type __read_mostly = {
-- 
1.8.3.1

