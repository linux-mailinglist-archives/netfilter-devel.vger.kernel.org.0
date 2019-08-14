Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7072D8D079
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2019 12:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfHNKQx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 14 Aug 2019 06:16:53 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:55398 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfHNKQx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:16:53 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 8A6C541BB8;
        Wed, 14 Aug 2019 18:16:49 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v4 02/12] netfilter: nf_tables_offload: add offload_actions callback
Date:   Wed, 14 Aug 2019 18:16:38 +0800
Message-Id: <1565777808-28735-3-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565777808-28735-1-git-send-email-wenxu@ucloud.cn>
References: <1565777808-28735-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVklVSk9PS0tLS05IT0tOTE1ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTo6Qzo*ITgxPTk1EjcyCDJM
        DRUaCjZVSlVKTk1OTExMQ0tCTU5CVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUhDQ0g3Bg++
X-HM-Tid: 0a6c8fa150ac2086kuqy8a6c541bb8
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

There will be zero one or serval actions for some expr. such as
payload set and immediate. The one payload set action maybe split
to several offload entries. And only NFT_REG_VERDICT immediate
action has 1 offload entry

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v4: no change

 include/net/netfilter/nf_tables.h         | 7 ++++++-
 include/net/netfilter/nf_tables_offload.h | 2 --
 net/netfilter/nf_tables_offload.c         | 4 ++--
 net/netfilter/nft_immediate.c             | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index dc301e3..5cf71a0 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -787,7 +787,7 @@ struct nft_expr_ops {
 	int				(*offload)(struct nft_offload_ctx *ctx,
 						   struct nft_flow_rule *flow,
 						   const struct nft_expr *expr);
-	u32				offload_flags;
+	int				(*offload_actions)(const struct nft_expr *expr);
 	const struct nft_expr_type	*type;
 	void				*data;
 };
@@ -796,6 +796,11 @@ struct nft_expr_ops {
 #define NFT_EXPR_SIZE(size)		(sizeof(struct nft_expr) + \
 					 ALIGN(size, __alignof__(struct nft_expr)))
 
+static inline int nft_offload_action(const struct nft_expr *expr)
+{
+	return 1;
+}
+
 /**
  *	struct nft_expr - nf_tables expression
  *
diff --git a/include/net/netfilter/nf_tables_offload.h b/include/net/netfilter/nf_tables_offload.h
index 71453fd..ff032fb 100644
--- a/include/net/netfilter/nf_tables_offload.h
+++ b/include/net/netfilter/nf_tables_offload.h
@@ -59,8 +59,6 @@ struct nft_flow_rule {
 	struct flow_rule	*rule;
 };
 
-#define NFT_OFFLOAD_F_ACTION	(1 << 0)
-
 struct nft_rule;
 struct nft_flow_rule *nft_flow_rule_create(struct net *net, const struct nft_rule *rule);
 void nft_flow_rule_destroy(struct nft_flow_rule *flow);
diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 9d9a864..e097189 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -42,8 +42,8 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net, const struct nft_rul
 
 	expr = nft_expr_first(rule);
 	while (expr->ops && expr != nft_expr_last(rule)) {
-		if (expr->ops->offload_flags & NFT_OFFLOAD_F_ACTION)
-			num_actions++;
+		if (expr->ops->offload_actions)
+			num_actions += expr->ops->offload_actions(expr);
 
 		expr = nft_expr_next(expr);
 	}
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index c7f0ef7..a2110be 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -173,7 +173,7 @@ static int nft_immediate_offload(struct nft_offload_ctx *ctx,
 	.dump		= nft_immediate_dump,
 	.validate	= nft_immediate_validate,
 	.offload	= nft_immediate_offload,
-	.offload_flags	= NFT_OFFLOAD_F_ACTION,
+	.offload_actions = nft_offload_action,
 };
 
 struct nft_expr_type nft_imm_type __read_mostly = {
-- 
1.8.3.1

