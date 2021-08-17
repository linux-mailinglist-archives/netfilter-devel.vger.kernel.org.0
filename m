Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633E93EE8B4
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Aug 2021 10:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbhHQIlK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Aug 2021 04:41:10 -0400
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21563 "EHLO
        sender4-of-o55.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhHQIlK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:41:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1629189597; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IgmcjaZKJk5EC7kfOpZ1k54qbMujt9+iw69fKeDFftNVDxebakjGW1Xuez/8iHE95crZA+N/rodNAMBDnHSF09gIhx6GYNPy/mjo1JD1eKRfN4N/OD7ND4dDY5do1Nv9R+D9VKwgO2kQ3NkP8/LZ/LipTnKIXVVyikHyPFxV2VU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1629189597; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=2upSKHGZqtnrKU856c9efnJQavyakqzwS8NnbUPJGas=; 
        b=FVNywPGv7hAwqDcXJHdGbaI4qKiQLVoPcP0fmwKDvaoEa8P8nLkwxadiHTuVSPE8TuYUuIYhQsxsKe9XLtF6Rbu9bJzVbPOOKVF56GHm1N7sdx53s0QSof7wwItwvhj22tfLGN3UIMndKfNqH6D8O9u2bY7tfDz3IY5PncqZLOs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=proelbtn.com;
        spf=pass  smtp.mailfrom=contact@proelbtn.com;
        dmarc=pass header.from=<contact@proelbtn.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1629189597;
        s=default; d=proelbtn.com; i=contact@proelbtn.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=2upSKHGZqtnrKU856c9efnJQavyakqzwS8NnbUPJGas=;
        b=cy4aYVnyuIewOq5Gj13VTmo5uI14NX02ZpoZQA6LSRwuRSVMGqpnWVlFrmmO/YtG
        EqF9tYzUxESIMKeKMznU/LtQLeQafZwYwHcQy/hRjRBxFJJiL5MRBznkQ8goV55JMtC
        zOaD0lOsinNXwDoU4zD3OqznvZHOev1jdOmsj7KY=
Received: from kerneldev.prochi.io (softbank060108183144.bbtec.net [60.108.183.144]) by mx.zohomail.com
        with SMTPS id 162918959719911.496015609779306; Tue, 17 Aug 2021 01:39:57 -0700 (PDT)
From:   Ryoga Saito <contact@proelbtn.com>
To:     netfilter-devel@vger.kernel.org
Cc:     pablo@netfilter.org, stefano.salsano@uniroma2.it,
        andrea.mayer@uniroma2.it, davem@davemloft.net, kuba@kernel.org,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        Ryoga Saito <contact@proelbtn.com>
Subject: [PATCH v7 2/2] netfilter: add netfilter hooks to SRv6 data plane
Date:   Tue, 17 Aug 2021 08:39:38 +0000
Message-Id: <20210817083938.15051-3-contact@proelbtn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817083938.15051-1-contact@proelbtn.com>
References: <20210817083938.15051-1-contact@proelbtn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch introduces netfilter hooks for solving the problem that
conntrack couldn't record both inner flows and outer flows.

Signed-off-by: Ryoga Saito <contact@proelbtn.com>
---
 net/ipv6/seg6_iptunnel.c |  74 ++++++++++++++++++++++++--
 net/ipv6/seg6_local.c    | 110 +++++++++++++++++++++++++++------------
 2 files changed, 148 insertions(+), 36 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 897fa59c47de..f0288464a06f 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -26,6 +26,7 @@
 #ifdef CONFIG_IPV6_SEG6_HMAC
 #include <net/seg6_hmac.h>
 #endif
+#include <net/lwtunnel.h>
 
 static size_t seg6_lwt_headroom(struct seg6_iptunnel_encap *tuninfo)
 {
@@ -295,11 +296,19 @@ static int seg6_do_srh(struct sk_buff *skb)
 
 	ipv6_hdr(skb)->payload_len = htons(skb->len - sizeof(struct ipv6hdr));
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
+	nf_reset_ct(skb);
 
 	return 0;
 }
 
-static int seg6_input(struct sk_buff *skb)
+static int seg6_input_finish(struct net *net, struct sock *sk,
+			     struct sk_buff *skb)
+{
+	return dst_input(skb);
+}
+
+static int seg6_input_core(struct net *net, struct sock *sk,
+			   struct sk_buff *skb)
 {
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
@@ -337,10 +346,41 @@ static int seg6_input(struct sk_buff *skb)
 	if (unlikely(err))
 		return err;
 
-	return dst_input(skb);
+	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
+		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
+			       dev_net(skb->dev), NULL, skb, NULL,
+			       skb_dst(skb)->dev, seg6_input_finish);
+
+	return seg6_input_finish(dev_net(skb->dev), NULL, skb);
 }
 
-static int seg6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
+static int seg6_input_nf(struct sk_buff *skb)
+{
+	struct net_device *dev = skb_dst(skb)->dev;
+	struct net *net = dev_net(skb->dev);
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		return NF_HOOK(NFPROTO_IPV4, NF_INET_POST_ROUTING, net, NULL,
+			       skb, NULL, dev, seg6_input_core);
+	case htons(ETH_P_IPV6):
+		return NF_HOOK(NFPROTO_IPV6, NF_INET_POST_ROUTING, net, NULL,
+			       skb, NULL, dev, seg6_input_core);
+	}
+
+	return -EINVAL;
+}
+
+static int seg6_input(struct sk_buff *skb)
+{
+	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
+		return seg6_input_nf(skb);
+
+	return seg6_input_core(dev_net(skb->dev), NULL, skb);
+}
+
+static int seg6_output_core(struct net *net, struct sock *sk,
+			    struct sk_buff *skb)
 {
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
@@ -387,12 +427,40 @@ static int seg6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (unlikely(err))
 		goto drop;
 
+	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
+		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net, sk, skb,
+			       NULL, skb_dst(skb)->dev, dst_output);
+
 	return dst_output(net, sk, skb);
 drop:
 	kfree_skb(skb);
 	return err;
 }
 
+static int seg6_output_nf(struct net *net, struct sock *sk, struct sk_buff *skb)
+{
+	struct net_device *dev = skb_dst(skb)->dev;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		return NF_HOOK(NFPROTO_IPV4, NF_INET_POST_ROUTING, net, sk, skb,
+			       NULL, dev, seg6_output_core);
+	case htons(ETH_P_IPV6):
+		return NF_HOOK(NFPROTO_IPV6, NF_INET_POST_ROUTING, net, sk, skb,
+			       NULL, dev, seg6_output_core);
+	}
+
+	return -EINVAL;
+}
+
+static int seg6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
+{
+	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
+		return seg6_output_nf(net, sk, skb);
+
+	return seg6_output_core(net, sk, skb);
+}
+
 static int seg6_build_state(struct net *net, struct nlattr *nla,
 			    unsigned int family, const void *cfg,
 			    struct lwtunnel_state **ts,
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 60bf3b877957..cc9d573fc85a 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -30,6 +30,7 @@
 #include <net/seg6_local.h>
 #include <linux/etherdevice.h>
 #include <linux/bpf.h>
+#include <net/lwtunnel.h>
 
 #define SEG6_F_ATTR(i)		BIT(i)
 
@@ -413,12 +414,33 @@ static int input_action_end_dx2(struct sk_buff *skb,
 	return -EINVAL;
 }
 
+static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
+				       struct sk_buff *skb)
+{
+	struct dst_entry *orig_dst = skb_dst(skb);
+	struct in6_addr *nhaddr = NULL;
+	struct seg6_local_lwt *slwt;
+
+	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
+
+	/* The inner packet is not associated to any local interface,
+	 * so we do not call netif_rx().
+	 *
+	 * If slwt->nh6 is set to ::, then lookup the nexthop for the
+	 * inner packet's DA. Otherwise, use the specified nexthop.
+	 */
+	if (!ipv6_addr_any(&slwt->nh6))
+		nhaddr = &slwt->nh6;
+
+	seg6_lookup_nexthop(skb, nhaddr, 0);
+
+	return dst_input(skb);
+}
+
 /* decapsulate and forward to specified nexthop */
 static int input_action_end_dx6(struct sk_buff *skb,
 				struct seg6_local_lwt *slwt)
 {
-	struct in6_addr *nhaddr = NULL;
-
 	/* this function accepts IPv6 encapsulated packets, with either
 	 * an SRH with SL=0, or no SRH.
 	 */
@@ -429,40 +451,30 @@ static int input_action_end_dx6(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
 		goto drop;
 
-	/* The inner packet is not associated to any local interface,
-	 * so we do not call netif_rx().
-	 *
-	 * If slwt->nh6 is set to ::, then lookup the nexthop for the
-	 * inner packet's DA. Otherwise, use the specified nexthop.
-	 */
-
-	if (!ipv6_addr_any(&slwt->nh6))
-		nhaddr = &slwt->nh6;
-
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
+	nf_reset_ct(skb);
 
-	seg6_lookup_nexthop(skb, nhaddr, 0);
+	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
+		return NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING,
+			       dev_net(skb->dev), NULL, skb, NULL,
+			       skb_dst(skb)->dev, input_action_end_dx6_finish);
 
-	return dst_input(skb);
+	return input_action_end_dx6_finish(dev_net(skb->dev), NULL, skb);
 drop:
 	kfree_skb(skb);
 	return -EINVAL;
 }
 
-static int input_action_end_dx4(struct sk_buff *skb,
-				struct seg6_local_lwt *slwt)
+static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
+				       struct sk_buff *skb)
 {
+	struct dst_entry *orig_dst = skb_dst(skb);
+	struct seg6_local_lwt *slwt;
 	struct iphdr *iph;
 	__be32 nhaddr;
 	int err;
 
-	if (!decap_and_validate(skb, IPPROTO_IPIP))
-		goto drop;
-
-	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-		goto drop;
-
-	skb->protocol = htons(ETH_P_IP);
+	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
 
 	iph = ip_hdr(skb);
 
@@ -470,14 +482,34 @@ static int input_action_end_dx4(struct sk_buff *skb,
 
 	skb_dst_drop(skb);
 
-	skb_set_transport_header(skb, sizeof(struct iphdr));
-
 	err = ip_route_input(skb, nhaddr, iph->saddr, 0, skb->dev);
-	if (err)
-		goto drop;
+	if (err) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	return dst_input(skb);
+}
+
+static int input_action_end_dx4(struct sk_buff *skb,
+				struct seg6_local_lwt *slwt)
+{
+	if (!decap_and_validate(skb, IPPROTO_IPIP))
+		goto drop;
+
+	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+		goto drop;
+
+	skb->protocol = htons(ETH_P_IP);
+	skb_set_transport_header(skb, sizeof(struct iphdr));
+	nf_reset_ct(skb);
+
+	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
+		return NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
+			       dev_net(skb->dev), NULL, skb, NULL,
+			       skb_dst(skb)->dev, input_action_end_dx4_finish);
 
+	return input_action_end_dx4_finish(dev_net(skb->dev), NULL, skb);
 drop:
 	kfree_skb(skb);
 	return -EINVAL;
@@ -645,6 +677,7 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
 	skb_dst_drop(skb);
 
 	skb_set_transport_header(skb, hdrlen);
+	nf_reset_ct(skb);
 
 	return end_dt_vrf_rcv(skb, family, vrf);
 
@@ -1078,7 +1111,8 @@ static void seg6_local_update_counters(struct seg6_local_lwt *slwt,
 	u64_stats_update_end(&pcounters->syncp);
 }
 
-static int seg6_local_input(struct sk_buff *skb)
+static int seg6_local_input_core(struct net *net, struct sock *sk,
+				 struct sk_buff *skb)
 {
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct seg6_action_desc *desc;
@@ -1086,11 +1120,6 @@ static int seg6_local_input(struct sk_buff *skb)
 	unsigned int len = skb->len;
 	int rc;
 
-	if (skb->protocol != htons(ETH_P_IPV6)) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
-
 	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
 	desc = slwt->desc;
 
@@ -1104,6 +1133,21 @@ static int seg6_local_input(struct sk_buff *skb)
 	return rc;
 }
 
+static int seg6_local_input(struct sk_buff *skb)
+{
+	if (skb->protocol != htons(ETH_P_IPV6)) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
+		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_IN,
+			       dev_net(skb->dev), NULL, skb, skb->dev, NULL,
+			       seg6_local_input_core);
+
+	return seg6_local_input_core(dev_net(skb->dev), NULL, skb);
+}
+
 static const struct nla_policy seg6_local_policy[SEG6_LOCAL_MAX + 1] = {
 	[SEG6_LOCAL_ACTION]	= { .type = NLA_U32 },
 	[SEG6_LOCAL_SRH]	= { .type = NLA_BINARY },
-- 
2.25.1

