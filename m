Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB3B9716C
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 07:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfHUFKZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Aug 2019 01:10:25 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:31899 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfHUFKY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:10:24 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 10FB7418BB;
        Wed, 21 Aug 2019 13:09:55 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v5 7/8] netfilter: nft_objref: add nft_objref_type offload
Date:   Wed, 21 Aug 2019 13:09:52 +0800
Message-Id: <1566364193-31330-8-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566364193-31330-1-git-send-email-wenxu@ucloud.cn>
References: <1566364193-31330-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVklVSUhNS0tLSUJCT05ITE9ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OiI6Igw*NTgwDz8KNBEoIzdP
        Lw9PCxpVSlVKTk1NSE1PSkJOSk1LVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlDTko3Bg++
X-HM-Tid: 0a6cb294d91d2086kuqy10fb7418bb
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

support offload for nft_objref_type

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v5: no offload_actions callback

 include/net/netfilter/nf_tables.h |  3 +++
 net/netfilter/nft_objref.c        | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index dc301e3..ec0135b 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1123,6 +1123,9 @@ struct nft_object_ops {
 	int				(*dump)(struct sk_buff *skb,
 						struct nft_object *obj,
 						bool reset);
+	int				(*offload)(struct nft_offload_ctx *ctx,
+						   struct nft_flow_rule *flow,
+						   struct nft_object *obj);
 	const struct nft_object_type	*type;
 };
 
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index bfd18d2..4a70972 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -10,6 +10,7 @@
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
 #include <net/netfilter/nf_tables.h>
+#include <net/netfilter/nf_tables_offload.h>
 
 #define nft_objref_priv(expr)	*((struct nft_object **)nft_expr_priv(expr))
 
@@ -82,6 +83,18 @@ static void nft_objref_activate(const struct nft_ctx *ctx,
 	obj->use++;
 }
 
+static int nft_objref_offload(struct nft_offload_ctx *ctx,
+			      struct nft_flow_rule *flow,
+			      const struct nft_expr *expr)
+{
+	struct nft_object *obj = nft_objref_priv(expr);
+
+	if (obj->ops->offload)
+		return obj->ops->offload(ctx, flow, obj);
+	else
+		return -EOPNOTSUPP;
+}
+
 static struct nft_expr_type nft_objref_type;
 static const struct nft_expr_ops nft_objref_ops = {
 	.type		= &nft_objref_type,
@@ -91,6 +104,7 @@ static void nft_objref_activate(const struct nft_ctx *ctx,
 	.activate	= nft_objref_activate,
 	.deactivate	= nft_objref_deactivate,
 	.dump		= nft_objref_dump,
+	.offload	= nft_objref_offload,
 };
 
 struct nft_objref_map {
-- 
1.8.3.1

