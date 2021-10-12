Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290E442A3D3
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Oct 2021 14:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbhJLMI3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Oct 2021 08:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhJLMI3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:08:29 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3E7C06161C;
        Tue, 12 Oct 2021 05:06:27 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1maGY6-0006eq-8d; Tue, 12 Oct 2021 14:06:26 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     lvs-devel@vger.kernel.org, ja@ssi.bg, horms@verge.net.au,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 1/4] netfilter: ipvs: prepare for hook function reduction
Date:   Tue, 12 Oct 2021 14:06:05 +0200
Message-Id: <20211012120608.21827-2-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012120608.21827-1-fw@strlen.de>
References: <20211012120608.21827-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

ipvs has multiple one-line wrappers for hooks, compact them.

To avoid a large patch make the two most common helpers use the same
function signature as hooks.

Next patches can then remove the oneline wrappers.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/ipvs/ip_vs_core.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index 128690c512df..5a5deee3425c 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1330,12 +1330,15 @@ handle_response(int af, struct sk_buff *skb, struct ip_vs_proto_data *pd,
  *	Check if outgoing packet belongs to the established ip_vs_conn.
  */
 static unsigned int
-ip_vs_out(struct netns_ipvs *ipvs, unsigned int hooknum, struct sk_buff *skb, int af)
+ip_vs_out_hook(void *priv, struct sk_buff *skb, const struct nf_hook_state *state)
 {
+	struct netns_ipvs *ipvs = net_ipvs(state->net);
+	unsigned int hooknum = state->hook;
 	struct ip_vs_iphdr iph;
 	struct ip_vs_protocol *pp;
 	struct ip_vs_proto_data *pd;
 	struct ip_vs_conn *cp;
+	int af = state->pf;
 	struct sock *sk;
 
 	EnterFunction(11);
@@ -1477,7 +1480,7 @@ static unsigned int
 ip_vs_reply4(void *priv, struct sk_buff *skb,
 	     const struct nf_hook_state *state)
 {
-	return ip_vs_out(net_ipvs(state->net), state->hook, skb, AF_INET);
+	return ip_vs_out_hook(priv, skb, state);
 }
 
 /*
@@ -1488,7 +1491,7 @@ static unsigned int
 ip_vs_local_reply4(void *priv, struct sk_buff *skb,
 		   const struct nf_hook_state *state)
 {
-	return ip_vs_out(net_ipvs(state->net), state->hook, skb, AF_INET);
+	return ip_vs_out_hook(priv, skb, state);
 }
 
 #ifdef CONFIG_IP_VS_IPV6
@@ -1502,7 +1505,7 @@ static unsigned int
 ip_vs_reply6(void *priv, struct sk_buff *skb,
 	     const struct nf_hook_state *state)
 {
-	return ip_vs_out(net_ipvs(state->net), state->hook, skb, AF_INET6);
+	return ip_vs_out_hook(priv, skb, state);
 }
 
 /*
@@ -1513,7 +1516,7 @@ static unsigned int
 ip_vs_local_reply6(void *priv, struct sk_buff *skb,
 		   const struct nf_hook_state *state)
 {
-	return ip_vs_out(net_ipvs(state->net), state->hook, skb, AF_INET6);
+	return ip_vs_out_hook(priv, skb, state);
 }
 
 #endif
@@ -1957,8 +1960,10 @@ static int ip_vs_in_icmp_v6(struct netns_ipvs *ipvs, struct sk_buff *skb,
  *	and send it on its way...
  */
 static unsigned int
-ip_vs_in(struct netns_ipvs *ipvs, unsigned int hooknum, struct sk_buff *skb, int af)
+ip_vs_in_hook(void *priv, struct sk_buff *skb, const struct nf_hook_state *state)
 {
+	struct netns_ipvs *ipvs = net_ipvs(state->net);
+	unsigned int hooknum = state->hook;
 	struct ip_vs_iphdr iph;
 	struct ip_vs_protocol *pp;
 	struct ip_vs_proto_data *pd;
@@ -1966,6 +1971,7 @@ ip_vs_in(struct netns_ipvs *ipvs, unsigned int hooknum, struct sk_buff *skb, int
 	int ret, pkts;
 	int conn_reuse_mode;
 	struct sock *sk;
+	int af = state->pf;
 
 	/* Already marked as IPVS request or reply? */
 	if (skb->ipvs_property)
@@ -2145,7 +2151,7 @@ static unsigned int
 ip_vs_remote_request4(void *priv, struct sk_buff *skb,
 		      const struct nf_hook_state *state)
 {
-	return ip_vs_in(net_ipvs(state->net), state->hook, skb, AF_INET);
+	return ip_vs_in_hook(priv, skb, state);
 }
 
 /*
@@ -2156,7 +2162,7 @@ static unsigned int
 ip_vs_local_request4(void *priv, struct sk_buff *skb,
 		     const struct nf_hook_state *state)
 {
-	return ip_vs_in(net_ipvs(state->net), state->hook, skb, AF_INET);
+	return ip_vs_in_hook(priv, skb, state);
 }
 
 #ifdef CONFIG_IP_VS_IPV6
@@ -2169,7 +2175,7 @@ static unsigned int
 ip_vs_remote_request6(void *priv, struct sk_buff *skb,
 		      const struct nf_hook_state *state)
 {
-	return ip_vs_in(net_ipvs(state->net), state->hook, skb, AF_INET6);
+	return ip_vs_in_hook(priv, skb, state);
 }
 
 /*
@@ -2180,7 +2186,7 @@ static unsigned int
 ip_vs_local_request6(void *priv, struct sk_buff *skb,
 		     const struct nf_hook_state *state)
 {
-	return ip_vs_in(net_ipvs(state->net), state->hook, skb, AF_INET6);
+	return ip_vs_in_hook(priv, skb, state);
 }
 
 #endif
-- 
2.32.0

