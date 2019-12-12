Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5791711C9C4
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Dec 2019 10:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfLLJoA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 12 Dec 2019 04:44:00 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:29227 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfLLJoA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:44:00 -0500
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id F002D418D2;
        Thu, 12 Dec 2019 17:43:55 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 3/4] netfilter: nf_flow_table_offload: fix miss dst_neigh_lookup for ipv6
Date:   Thu, 12 Dec 2019 17:43:54 +0800
Message-Id: <1576143835-19749-4-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576143835-19749-1-git-send-email-wenxu@ucloud.cn>
References: <1576143835-19749-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSkJOQkJCQkxCQkxJQ09ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MUk6Iyo4Kjg9F0geNhxKFS08
        LyMaCS1VSlVKTkxNSk9IQ0hNSUhLVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUhKSk03Bg++
X-HM-Tid: 0a6ef97e53862086kuqyf002d418d2
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Add dst_neigh_lookup support for ipv6

Fixes: 5c27d8d76ce8 ("netfilter: nf_flow_table_offload: add IPv6 support")
Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 net/netfilter/nf_flow_table_offload.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index aa40d58..2ce6001 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -164,20 +164,26 @@ static int flow_offload_eth_src(struct net *net,
 static int flow_offload_eth_dst(struct net *net,
 				const struct flow_offload *flow,
 				enum flow_offload_tuple_dir dir,
-				struct nf_flow_rule *flow_rule)
+				struct nf_flow_rule *flow_rule,
+				bool ipv6)
 {
-	const struct in_addr *dst_addr_v4 = &flow->tuplehash[!dir].tuple.src_v4;
 	struct flow_action_entry *entry0 = flow_action_entry_next(flow_rule);
 	struct flow_action_entry *entry1 = flow_action_entry_next(flow_rule);
 	const struct dst_entry *dst_cache;
 	unsigned char ha[ETH_ALEN];
 	struct neighbour *n;
+	const void *daddr;
 	u32 mask, val;
 	u8 nud_state;
 	u16 val16;
 
 	dst_cache = flow->tuplehash[dir].tuple.dst_cache;
-	n = dst_neigh_lookup(dst_cache, dst_addr_v4);
+	if (ipv6)
+		daddr = &flow->tuplehash[!dir].tuple.src_v6;
+	else
+		daddr = &flow->tuplehash[!dir].tuple.src_v4;
+
+	n = dst_neigh_lookup(dst_cache, daddr);
 	if (!n)
 		return -ENOENT;
 
@@ -431,7 +437,7 @@ int nf_flow_rule_route_ipv4(struct net *net, const struct flow_offload *flow,
 			    struct nf_flow_rule *flow_rule)
 {
 	if (flow_offload_eth_src(net, flow, dir, flow_rule) < 0 ||
-	    flow_offload_eth_dst(net, flow, dir, flow_rule) < 0)
+	    flow_offload_eth_dst(net, flow, dir, flow_rule, true) < 0)
 		return -1;
 
 	if (flow->flags & FLOW_OFFLOAD_SNAT) {
@@ -457,7 +463,7 @@ int nf_flow_rule_route_ipv6(struct net *net, const struct flow_offload *flow,
 			    struct nf_flow_rule *flow_rule)
 {
 	if (flow_offload_eth_src(net, flow, dir, flow_rule) < 0 ||
-	    flow_offload_eth_dst(net, flow, dir, flow_rule) < 0)
+	    flow_offload_eth_dst(net, flow, dir, flow_rule, false) < 0)
 		return -1;
 
 	if (flow->flags & FLOW_OFFLOAD_SNAT) {
-- 
1.8.3.1

