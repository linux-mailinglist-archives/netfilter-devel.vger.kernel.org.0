Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846116A010
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jul 2019 02:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbfGPArx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 15 Jul 2019 20:47:53 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:24134 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733022AbfGPArw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 15 Jul 2019 20:47:52 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 2EE1341759;
        Tue, 16 Jul 2019 08:47:47 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v5 1/8] netfilter:nf_flow_table: Refactor flow_offload_tuple to destination
Date:   Tue, 16 Jul 2019 08:47:39 +0800
Message-Id: <1563238066-3105-2-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563238066-3105-1-git-send-email-wenxu@ucloud.cn>
References: <1563238066-3105-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVklVSkhCS0tLSkxMSENIT0lZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxw6LTo4KDg6SQM2TUguQwwy
        TE8KCRZVSlVKTk1ISUhDS01MSUJOVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUxNT043Bg++
X-HM-Tid: 0a6bf83fec042086kuqy2ee1341759
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Add struct flow_offload_dst to support more offload method to replace
dst_cache which only work for route offload.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 include/net/netfilter/nf_flow_table.h | 12 ++++++++++--
 net/netfilter/nf_flow_table_core.c    | 22 +++++++++++-----------
 net/netfilter/nf_flow_table_ip.c      |  4 ++--
 net/netfilter/nft_flow_offload.c      | 10 +++++-----
 4 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index d8c1879..d40d409 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -33,6 +33,10 @@ enum flow_offload_tuple_dir {
 	FLOW_OFFLOAD_DIR_MAX = IP_CT_DIR_MAX
 };
 
+struct flow_offload_dst {
+	struct dst_entry		*dst_cache;
+};
+
 struct flow_offload_tuple {
 	union {
 		struct in_addr		src_v4;
@@ -55,7 +59,7 @@ struct flow_offload_tuple {
 
 	u16				mtu;
 
-	struct dst_entry		*dst_cache;
+	struct flow_offload_dst		dst;
 };
 
 struct flow_offload_tuple_rhash {
@@ -85,8 +89,12 @@ struct nf_flow_route {
 	} tuple[FLOW_OFFLOAD_DIR_MAX];
 };
 
+struct nf_flow_dst {
+	struct nf_flow_route route;
+};
+
 struct flow_offload *flow_offload_alloc(struct nf_conn *ct,
-					struct nf_flow_route *route);
+					struct nf_flow_dst *flow_dst);
 void flow_offload_free(struct flow_offload *flow);
 
 int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow);
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index e3d7972..7e0b5bd 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -24,13 +24,13 @@ struct flow_offload_entry {
 
 static void
 flow_offload_fill_dir(struct flow_offload *flow, struct nf_conn *ct,
-		      struct nf_flow_route *route,
+		      struct nf_flow_dst *flow_dst,
 		      enum flow_offload_tuple_dir dir)
 {
 	struct flow_offload_tuple *ft = &flow->tuplehash[dir].tuple;
 	struct nf_conntrack_tuple *ctt = &ct->tuplehash[dir].tuple;
-	struct dst_entry *other_dst = route->tuple[!dir].dst;
-	struct dst_entry *dst = route->tuple[dir].dst;
+	struct dst_entry *other_dst = flow_dst->route.tuple[!dir].dst;
+	struct dst_entry *dst = flow_dst->route.tuple[dir].dst;
 
 	ft->dir = dir;
 
@@ -57,7 +57,7 @@ struct flow_offload_entry {
 }
 
 struct flow_offload *
-flow_offload_alloc(struct nf_conn *ct, struct nf_flow_route *route)
+flow_offload_alloc(struct nf_conn *ct, struct nf_flow_dst *flow_dst)
 {
 	struct flow_offload_entry *entry;
 	struct flow_offload *flow;
@@ -72,16 +72,16 @@ struct flow_offload *
 
 	flow = &entry->flow;
 
-	if (!dst_hold_safe(route->tuple[FLOW_OFFLOAD_DIR_ORIGINAL].dst))
+	if (!dst_hold_safe(flow_dst->route.tuple[FLOW_OFFLOAD_DIR_ORIGINAL].dst))
 		goto err_dst_cache_original;
 
-	if (!dst_hold_safe(route->tuple[FLOW_OFFLOAD_DIR_REPLY].dst))
+	if (!dst_hold_safe(flow_dst->route.tuple[FLOW_OFFLOAD_DIR_REPLY].dst))
 		goto err_dst_cache_reply;
 
 	entry->ct = ct;
 
-	flow_offload_fill_dir(flow, ct, route, FLOW_OFFLOAD_DIR_ORIGINAL);
-	flow_offload_fill_dir(flow, ct, route, FLOW_OFFLOAD_DIR_REPLY);
+	flow_offload_fill_dir(flow, ct, flow_dst, FLOW_OFFLOAD_DIR_ORIGINAL);
+	flow_offload_fill_dir(flow, ct, flow_dst, FLOW_OFFLOAD_DIR_REPLY);
 
 	if (ct->status & IPS_SRC_NAT)
 		flow->flags |= FLOW_OFFLOAD_SNAT;
@@ -91,7 +91,7 @@ struct flow_offload *
 	return flow;
 
 err_dst_cache_reply:
-	dst_release(route->tuple[FLOW_OFFLOAD_DIR_ORIGINAL].dst);
+	dst_release(flow_dst->route.tuple[FLOW_OFFLOAD_DIR_ORIGINAL].dst);
 err_dst_cache_original:
 	kfree(entry);
 err_ct_refcnt:
@@ -139,8 +139,8 @@ void flow_offload_free(struct flow_offload *flow)
 {
 	struct flow_offload_entry *e;
 
-	dst_release(flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.dst_cache);
-	dst_release(flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.dst_cache);
+	dst_release(flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.dst.dst_cache);
+	dst_release(flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.dst.dst_cache);
 	e = container_of(flow, struct flow_offload_entry, flow);
 	if (flow->flags & FLOW_OFFLOAD_DYING)
 		nf_ct_delete(e->ct, 0, 0);
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index cdfc335..4304070 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -241,7 +241,7 @@ static bool nf_flow_exceeds_mtu(const struct sk_buff *skb, unsigned int mtu)
 
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
-	rt = (struct rtable *)flow->tuplehash[dir].tuple.dst_cache;
+	rt = (struct rtable *)flow->tuplehash[dir].tuple.dst.dst_cache;
 	outdev = rt->dst.dev;
 
 	if (unlikely(nf_flow_exceeds_mtu(skb, flow->tuplehash[dir].tuple.mtu)))
@@ -457,7 +457,7 @@ static int nf_flow_tuple_ipv6(struct sk_buff *skb, const struct net_device *dev,
 
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
-	rt = (struct rt6_info *)flow->tuplehash[dir].tuple.dst_cache;
+	rt = (struct rt6_info *)flow->tuplehash[dir].tuple.dst.dst_cache;
 	outdev = rt->dst.dev;
 
 	if (unlikely(nf_flow_exceeds_mtu(skb, flow->tuplehash[dir].tuple.mtu)))
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index aa5f571..4af94ce 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -73,7 +73,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 	struct nft_flow_offload *priv = nft_expr_priv(expr);
 	struct nf_flowtable *flowtable = &priv->flowtable->data;
 	enum ip_conntrack_info ctinfo;
-	struct nf_flow_route route;
+	struct nf_flow_dst flow_dst;
 	struct flow_offload *flow;
 	enum ip_conntrack_dir dir;
 	bool is_tcp = false;
@@ -108,10 +108,10 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 		goto out;
 
 	dir = CTINFO2DIR(ctinfo);
-	if (nft_flow_route(pkt, ct, &route, dir) < 0)
+	if (nft_flow_route(pkt, ct, &flow_dst.route, dir) < 0)
 		goto err_flow_route;
 
-	flow = flow_offload_alloc(ct, &route);
+	flow = flow_offload_alloc(ct, &flow_dst);
 	if (!flow)
 		goto err_flow_alloc;
 
@@ -124,13 +124,13 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 	if (ret < 0)
 		goto err_flow_add;
 
-	dst_release(route.tuple[!dir].dst);
+	dst_release(flow_dst.route.tuple[!dir].dst);
 	return;
 
 err_flow_add:
 	flow_offload_free(flow);
 err_flow_alloc:
-	dst_release(route.tuple[!dir].dst);
+	dst_release(flow_dst.route.tuple[!dir].dst);
 err_flow_route:
 	clear_bit(IPS_OFFLOAD_BIT, &ct->status);
 out:
-- 
1.8.3.1

