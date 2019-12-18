Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60517124A7F
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Dec 2019 15:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLRO7T (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Dec 2019 09:59:19 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:38313 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfLRO7T (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:59:19 -0500
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 4B9EE41638;
        Wed, 18 Dec 2019 22:59:14 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 2/3] netfilter: nf_tables: fix miss activate operation in the
Date:   Wed, 18 Dec 2019 22:59:12 +0800
Message-Id: <1576681153-10578-3-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576681153-10578-1-git-send-email-wenxu@ucloud.cn>
References: <1576681153-10578-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVS01OS0tLSkxNT0lCTE5ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NT46LRw6MTg0F0wBOBYrNCMq
        Ix4aCylVSlVKTkxNTUNKSk5PSENJVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlKQ0o3Bg++
X-HM-Tid: 0a6f1985270c2086kuqy4b9ee41638
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

nf_tables_commit for NFT_MSG_NEWRULE

The new create rule should be activated in the nf_tables_commit.

create a flowtable:
nft add table firewall
nft add flowtable firewall fb1 { hook ingress priority 2 \; devices = { tun1, mlx_pf0vf0 } \; }
nft add chain firewall ftb-all {type filter hook forward priority 0 \; policy accept \; }
nft add rule firewall ftb-all ct zone 1 ip protocol tcp flow offload @fb1
nft add rule firewall ftb-all ct zone 1 ip protocol udp flow offload @fb1

delete the related rule:
nft delete chain firewall ftb-all

The flowtable can be deleted
nft delete flowtable firewall fb1

But failed with: Device is busy

The nf_flowtable->use is not zero for no activated operation.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 net/netfilter/nf_tables_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 27e6a6f..174b362 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7101,6 +7101,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			nf_tables_rule_notify(&trans->ctx,
 					      nft_trans_rule(trans),
 					      NFT_MSG_NEWRULE);
+			nft_rule_expr_activate(&trans->ctx, nft_trans_rule(trans));
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_DELRULE:
-- 
1.8.3.1

