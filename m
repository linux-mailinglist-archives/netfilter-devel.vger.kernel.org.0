Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27A611CA36
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Dec 2019 11:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbfLLKHT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 12 Dec 2019 05:07:19 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:43636 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbfLLKHT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:07:19 -0500
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 8347041A46;
        Thu, 12 Dec 2019 18:07:17 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 1/3] netfilter: nf_flow_table_offload: fix dst_neigh lookup for dnat
Date:   Thu, 12 Dec 2019 18:07:15 +0800
Message-Id: <1576145237-20290-2-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576145237-20290-1-git-send-email-wenxu@ucloud.cn>
References: <1576145237-20290-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVklVSk9PS0tLS05IT0tOTE1ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzI6OCo*GTg5F0gDTQgaKBYC
        ASgwCihVSlVKTkxNSk9OSUhMTkNKVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlKS0g3Bg++
X-HM-Tid: 0a6ef993b62e2086kuqy8347041a46
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Get the dst_neigh through dst_ip, The dst_ip should get
through peer tuple.src_v4 fix for dnat case.

Fixes: c29f74e0df7a ("netfilter: nf_flow_table: hardware offload support")
Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 net/netfilter/nf_flow_table_offload.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index de7a0d1..91dd6eb 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -166,14 +166,16 @@ static int flow_offload_eth_dst(struct net *net,
 				enum flow_offload_tuple_dir dir,
 				struct nf_flow_rule *flow_rule)
 {
-	const struct flow_offload_tuple *tuple = &flow->tuplehash[dir].tuple;
 	struct flow_action_entry *entry0 = flow_action_entry_next(flow_rule);
 	struct flow_action_entry *entry1 = flow_action_entry_next(flow_rule);
+	const void *daddr = &flow->tuplehash[!dir].tuple.src_v4;
+	const struct dst_entry *dst_cache;
 	struct neighbour *n;
 	u32 mask, val;
 	u16 val16;
 
-	n = dst_neigh_lookup(tuple->dst_cache, &tuple->dst_v4);
+	dst_cache = flow->tuplehash[dir].tuple.dst_cache;
+	n = dst_neigh_lookup(dst_cache, daddr);
 	if (!n)
 		return -ENOENT;
 
-- 
1.8.3.1

