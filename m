Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19EFB718B6
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jul 2019 14:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfGWMww (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Jul 2019 08:52:52 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:26711 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390014AbfGWMwv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:52:51 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 5196D41A92;
        Tue, 23 Jul 2019 20:52:46 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 7/7] netfilter: nft_payload: add nft_set_payload offload support
Date:   Tue, 23 Jul 2019 20:52:44 +0800
Message-Id: <1563886364-11164-8-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563886364-11164-1-git-send-email-wenxu@ucloud.cn>
References: <1563886364-11164-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSExCS0tLS01MTEpLQ0NZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pjo6PQw*Cjg*PlEWMiM2Th8s
        MxYKCgtVSlVKTk1IQ0NNSE1NT0pIVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUhPSEg3Bg++
X-HM-Tid: 0a6c1ee42e882086kuqy5196d41a92
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

currently payload set only support ll header

nft --debug=netlink add rule netdev firewall aclout ip daddr 10.0.1.7 @ll,0,48
set 0x00002e9ca06e2596 @ll,48,48 set 0xfaffffffffff fwd to eth0

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 net/netfilter/nft_payload.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 36efa1c..544fc40 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -572,12 +572,68 @@ static int nft_payload_set_dump(struct sk_buff *skb, const struct nft_expr *expr
 	return -1;
 }
 
+static int nft_payload_set_offload(struct nft_offload_ctx *ctx,
+				   struct nft_flow_rule *flow,
+				   const struct nft_expr *expr)
+{
+	const struct nft_payload_set *priv = nft_expr_priv(expr);
+	struct nft_offload_reg *reg = &ctx->regs[priv->sreg];
+	const struct nft_data *data = &reg->action.data;
+	struct flow_action_entry *entry;
+	u32 len = priv->len;
+	u32 offset, last;
+	int n_actions, i;
+
+	if (priv->base != NFT_PAYLOAD_LL_HEADER || len > 16)
+		return -EOPNOTSUPP;
+
+	offset = priv->offset;
+	n_actions = len >> 2;
+	last = len & 0x3;
+
+	for (i = 0; i < n_actions; i++) {
+		entry = &flow->rule->action.entries[ctx->num_actions++];
+
+		entry->id = FLOW_ACTION_MANGLE;
+		entry->mangle.htype = FLOW_ACT_MANGLE_HDR_TYPE_ETH;
+		entry->mangle.mask = 0;
+		entry->mangle.val = data->data[i];
+		entry->mangle.offset = offset;
+		offset = offset + 4;
+	}
+
+	if (last) {
+		entry = &flow->rule->action.entries[ctx->num_actions++];
+
+		entry->id = FLOW_ACTION_MANGLE;
+		entry->mangle.htype = FLOW_ACT_MANGLE_HDR_TYPE_ETH;
+		entry->mangle.mask = ~((1 << (last * 8)) - 1);
+		entry->mangle.val = data->data[i];
+		entry->mangle.offset = offset;
+	}
+
+	return 0;
+}
+
+static int nft_payload_set_offload_actions(const struct nft_expr *expr)
+{
+	const struct nft_payload_set *priv = nft_expr_priv(expr);
+	u32 len = priv->len;
+
+	if (priv->base != NFT_PAYLOAD_LL_HEADER || len > 16)
+		return 0;
+
+	return (len >> 2) + !!(len & 3);
+}
+
 static const struct nft_expr_ops nft_payload_set_ops = {
 	.type		= &nft_payload_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_payload_set)),
 	.eval		= nft_payload_set_eval,
 	.init		= nft_payload_set_init,
 	.dump		= nft_payload_set_dump,
+	.offload	= nft_payload_set_offload,
+	.offload_actions = nft_payload_set_offload_actions,
 };
 
 static const struct nft_expr_ops *
-- 
1.8.3.1

