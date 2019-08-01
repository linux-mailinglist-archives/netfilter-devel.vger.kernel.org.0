Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 669CC7DD2E
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Aug 2019 16:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbfHAOBo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Aug 2019 10:01:44 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:22909 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbfHAOBo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:01:44 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 53172417BA;
        Thu,  1 Aug 2019 22:01:28 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v3 9/9] netfilter: nft_tunnel: support nft_tunnel_obj offload
Date:   Thu,  1 Aug 2019 22:01:26 +0800
Message-Id: <1564668086-16260-10-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564668086-16260-1-git-send-email-wenxu@ucloud.cn>
References: <1564668086-16260-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSk5JS0tLS01CTUpDSUhZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pjo6TBw4Ljg8Mk8eVi8pI1YK
        CBUKCRJVSlVKTk1PTU1DS0NDT0pOVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlISU43Bg++
X-HM-Tid: 0a6c4d7c50202086kuqy53172417ba
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Add nft_tunnel_obj offload for both encap and decap actions

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v3: no change

 net/netfilter/nft_tunnel.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/netfilter/nft_tunnel.c b/net/netfilter/nft_tunnel.c
index 078dcee..8b232b0 100644
--- a/net/netfilter/nft_tunnel.c
+++ b/net/netfilter/nft_tunnel.c
@@ -633,6 +633,25 @@ static void nft_tunnel_obj_destroy(const struct nft_ctx *ctx,
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
@@ -641,6 +660,7 @@ static void nft_tunnel_obj_destroy(const struct nft_ctx *ctx,
 	.init		= nft_tunnel_obj_init,
 	.destroy	= nft_tunnel_obj_destroy,
 	.dump		= nft_tunnel_obj_dump,
+	.offload	= nft_tunnel_obj_offload,
 };
 
 static struct nft_object_type nft_tunnel_obj_type __read_mostly = {
-- 
1.8.3.1

