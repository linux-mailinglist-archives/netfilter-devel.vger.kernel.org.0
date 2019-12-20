Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBB81277BD
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Dec 2019 10:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfLTJIw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Dec 2019 04:08:52 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:63808 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfLTJIv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:08:51 -0500
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 70018419E6;
        Fri, 20 Dec 2019 17:08:46 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nft_flow_offload: fix unnecessary use counter decrease in destory
Date:   Fri, 20 Dec 2019 17:08:46 +0800
Message-Id: <1576832926-4268-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVDQklCQkJDQ0xPTU1PSFlXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NVE6TCo5OjgyPUMKHBkcEi8V
        FQwaFAFVSlVKTkxNQ0hJQklNTU5LVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpCSk03Bg++
X-HM-Tid: 0a6f2291033b2086kuqy70018419e6
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

create a flowtable:
nft add table firewall
nft add flowtable firewall fb1 { hook ingress priority 2 \; devices = { tun1,
mlx_pf0vf0 } \; }
nft add chain firewall ftb-all {type filter hook forward priority 0 \; policy
accept \; }
nft add rule firewall ftb-all ct zone 1 ip protocol tcp flow offload @fb1
nft add rule firewall ftb-all ct zone 1 ip protocol udp flow offload @fb1

delete the related rule:
nft delete chain firewall ftb-all

The flowtable can be deleted
nft delete flowtable firewall fb1

But failed with: Device is busy

The nf_flowtable->use is not zero and overflow for unnecessary use counter
decrease..

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 net/netfilter/nft_flow_offload.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index dd82ff2..b70b489 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -200,9 +200,6 @@ static void nft_flow_offload_activate(const struct nft_ctx *ctx,
 static void nft_flow_offload_destroy(const struct nft_ctx *ctx,
 				     const struct nft_expr *expr)
 {
-	struct nft_flow_offload *priv = nft_expr_priv(expr);
-
-	priv->flowtable->use--;
 	nf_ct_netns_put(ctx->net, ctx->family);
 }
 
-- 
1.8.3.1

