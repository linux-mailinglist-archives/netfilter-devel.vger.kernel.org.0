Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE229209B
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Aug 2019 11:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfHSJpM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Aug 2019 05:45:12 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:34538 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfHSJpM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:45:12 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 24AAD41B84;
        Mon, 19 Aug 2019 17:45:07 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 3/3] netfilter: nf_offload: clear offload things in __nft_release_basechain
Date:   Mon, 19 Aug 2019 17:45:05 +0800
Message-Id: <1566207905-22203-3-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566207905-22203-1-git-send-email-wenxu@ucloud.cn>
References: <1566207905-22203-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVklVSk9KS0tLS0hJT0lPQkhZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBg6FDo6Szg5KTghTyxOAjZR
        TBYwCgFVSlVKTk1NSUtMQktMSUtDVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlJSE83Bg++
X-HM-Tid: 0a6ca944155d2086kuqy24aad41b84
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

When the net_device unregister, the netdevice_notifier will release
the related netdev basedchain and rules in this chains. So it is also
need to clear the offload things

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 net/netfilter/nf_tables_api.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index fe3b7b0..345df36 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7495,16 +7495,25 @@ int nft_data_dump(struct sk_buff *skb, int attr, const struct nft_data *data,
 int __nft_release_basechain(struct nft_ctx *ctx)
 {
 	struct nft_rule *rule, *nr;
+	bool offloaded = false;
 
 	if (WARN_ON(!nft_is_base_chain(ctx->chain)))
 		return 0;
 
+	if (ctx->chain->flags & NFT_CHAIN_HW_OFFLOAD)
+		offloaded = true;
+
 	nf_tables_unregister_hook(ctx->net, ctx->chain->table, ctx->chain);
 	list_for_each_entry_safe(rule, nr, &ctx->chain->rules, list) {
+		if (offloaded)
+			nft_flow_offload_rule(ctx->chain, rule,
+					      NULL, FLOW_CLS_DESTROY);
 		list_del(&rule->list);
 		ctx->chain->use--;
 		nf_tables_rule_release(ctx, rule);
 	}
+	if (offloaded)
+		nft_flow_offload_chain(ctx->chain, FLOW_BLOCK_UNBIND);
 	nft_chain_del(ctx->chain);
 	ctx->table->use--;
 	nf_tables_chain_destroy(ctx);
-- 
1.8.3.1

