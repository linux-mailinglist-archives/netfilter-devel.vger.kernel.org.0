Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CE23D9FDE
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jul 2021 10:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhG2Ixt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Jul 2021 04:53:49 -0400
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21522 "EHLO
        sender4-of-o55.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhG2Ixt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Jul 2021 04:53:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1627547890; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=WO5BpnYnBnVhYLMf8R6std4iHV8iovVWm2JLJBYJZwj/O6a9N26+WU3FaHdE4B8SQOhz1qEDEvpU0IHreuoUoYV/lqIL1KXoI3d12mQVQ4f5FlDEu4d7cu1OxeN1gQfweraR5ufLeHhROrG5wZl6UoFujI/of6SDxd69cZjfwqY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1627547890; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=OwPo4qO/eS2F1SoQVwnwVxMDmLogfT1Y9LHgpA5fJNU=; 
        b=f1Axw7gPvYelJBwBcY7GFfzUMowbKNcsmd615D/rBjnBrb051ha9KAMFOwCFR3U1A9tLB+HI2KIucoqs2fTsKuRPGjmzLT/moEZK15P0nFuMb4iLOKtwsZ9j/ysO9S8BNSJ7IXpk1CNwSKXjVZXF9NvepbS8Ge1nCkgulk6Zn+s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=proelbtn.com;
        spf=pass  smtp.mailfrom=contact@proelbtn.com;
        dmarc=pass header.from=<contact@proelbtn.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1627547890;
        s=default; d=proelbtn.com; i=contact@proelbtn.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=OwPo4qO/eS2F1SoQVwnwVxMDmLogfT1Y9LHgpA5fJNU=;
        b=TwBrmZ6DHzx5V4fOa0ydWYOOSaDkJw6pgou+d3UYIfavkrgGypBe7scXtGK/L6a+
        7LvnhpRdREGZr8+tlZjJR0tbWa8NlF6QNMb8loUZc6oqdSIaV6ThO7NVsJ8qblcQiO7
        F7sXwkNbuvbbog6j5gUJ5qV+htsQBnAbutJ/Mmcw=
Received: from srv6.prochi.io (softbank060108183144.bbtec.net [60.108.183.144]) by mx.zohomail.com
        with SMTPS id 1627547877023998.4061656425704; Thu, 29 Jul 2021 01:37:57 -0700 (PDT)
From:   Ryoga Saito <contact@proelbtn.com>
To:     netfilter-devel@vger.kernel.org
Cc:     pablo@netfilter.org, stefano.salsano@uniroma2.it,
        andrea.mayer@uniroma2.it, davem@davemloft.net, kuba@kernel.org,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        Ryoga Saito <contact@proelbtn.com>
Subject: [PATCH v2 2/2] netfilter: add netfilter hooks to SRv6 data plane
Date:   Thu, 29 Jul 2021 08:37:13 +0000
Message-Id: <7b59389116e4609487fe9a5696993727f3f82a72.1627546390.git.contact@proelbtn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627546390.git.contact@proelbtn.com>
References: <cover.1627546390.git.contact@proelbtn.com>
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
 net/ipv6/seg6_iptunnel.c |  68 +++++++++++++++++++++--
 net/ipv6/seg6_local.c    | 115 +++++++++++++++++++++++++++------------
 2 files changed, 141 insertions(+), 42 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 897fa59c47de..77a2aafcb52f 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -26,6 +26,7 @@
 #ifdef CONFIG_IPV6_SEG6_HMAC
 #include <net/seg6_hmac.h>
 #endif
+#include <net/netfilter/nf_conntrack.h>
 
 static size_t seg6_lwt_headroom(struct seg6_iptunnel_encap *tuninfo)
 {
@@ -295,25 +296,33 @@ static int seg6_do_srh(struct sk_buff *skb)
 
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
-	struct seg6_lwt *slwt;
+	struct seg6_lwt *slwt = NULL;
 	int err;
 
+	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
+
 	err = seg6_do_srh(skb);
 	if (unlikely(err)) {
 		kfree_skb(skb);
 		return err;
 	}
 
-	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
-
 	preempt_disable();
 	dst = dst_cache_get(&slwt->cache);
 	preempt_enable();
@@ -337,10 +346,35 @@ static int seg6_input(struct sk_buff *skb)
 	if (unlikely(err))
 		return err;
 
-	return dst_input(skb);
+	if (static_branch_unlikely(&nf_ct_lwtunnel_enabled))
+		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
+			       dev_net(skb->dev), NULL, skb, NULL,
+			       skb_dst(skb)->dev, seg6_input_finish);
+
+	return seg6_input_finish(dev_net(skb->dev), NULL, skb);
 }
 
-static int seg6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
+static int seg6_input(struct sk_buff *skb)
+{
+	int proto;
+
+	if (skb->protocol == htons(ETH_P_IPV6))
+		proto = NFPROTO_IPV6;
+	else if (skb->protocol == htons(ETH_P_IP))
+		proto = NFPROTO_IPV4;
+	else
+		return -EINVAL;
+
+	if (static_branch_unlikely(&nf_ct_lwtunnel_enabled))
+		return NF_HOOK(proto, NF_INET_POST_ROUTING, dev_net(skb->dev),
+			       NULL, skb, NULL, skb_dst(skb)->dev,
+			       seg6_input_core);
+
+	return seg6_input_core(dev_net(skb->dev), NULL, skb);
+}
+
+static int seg6_output_core(struct net *net, struct sock *sk,
+			    struct sk_buff *skb)
 {
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
@@ -387,12 +421,34 @@ static int seg6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (unlikely(err))
 		goto drop;
 
+	if (static_branch_unlikely(&nf_ct_lwtunnel_enabled))
+		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net, sk, skb,
+			       NULL, skb_dst(skb)->dev, dst_output);
+
 	return dst_output(net, sk, skb);
 drop:
 	kfree_skb(skb);
 	return err;
 }
 
+static int seg6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
+{
+	int proto;
+
+	if (skb->protocol == htons(ETH_P_IPV6))
+		proto = NFPROTO_IPV6;
+	else if (skb->protocol == htons(ETH_P_IP))
+		proto = NFPROTO_IPV4;
+	else
+		return -EINVAL;
+
+	if (static_branch_unlikely(&nf_ct_lwtunnel_enabled))
+		return NF_HOOK(proto, NF_INET_POST_ROUTING, net, sk, skb, NULL,
+			       skb_dst(skb)->dev, seg6_output_core);
+
+	return seg6_output_core(net, sk, skb);
+}
+
 static int seg6_build_state(struct net *net, struct nlattr *nla,
 			    unsigned int family, const void *cfg,
 			    struct lwtunnel_state **ts,
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 60bf3b877957..d883475be043 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -30,6 +30,7 @@
 #include <net/seg6_local.h>
 #include <linux/etherdevice.h>
 #include <linux/bpf.h>
+#include <net/netfilter/nf_conntrack.h>
 
 #define SEG6_F_ATTR(i)		BIT(i)
 
@@ -413,12 +414,33 @@ static int input_action_end_dx2(struct sk_buff *skb,
 	return -EINVAL;
 }
 
+static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
+				       struct sk_buff *skb)
+{
+	struct dst_entry *orig_dst = skb_dst(skb);
+	struct seg6_local_lwt *slwt = NULL;
+	struct in6_addr *nhaddr = NULL;
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
@@ -429,55 +451,64 @@ static int input_action_end_dx6(struct sk_buff *skb,
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
+	if (static_branch_unlikely(&nf_ct_lwtunnel_enabled))
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
+	struct seg6_local_lwt *slwt = NULL;
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
-
 	nhaddr = slwt->nh4.s_addr ?: iph->daddr;
 
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
+	if (static_branch_unlikely(&nf_ct_lwtunnel_enabled))
+		return NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
+			       dev_net(skb->dev), NULL, skb, NULL,
+			       skb_dst(skb)->dev, input_action_end_dx4_finish);
+
+	return input_action_end_dx4_finish(dev_net(skb->dev), NULL, skb);
 drop:
 	kfree_skb(skb);
 	return -EINVAL;
@@ -645,6 +676,7 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
 	skb_dst_drop(skb);
 
 	skb_set_transport_header(skb, hdrlen);
+	nf_reset_ct(skb);
 
 	return end_dt_vrf_rcv(skb, family, vrf);
 
@@ -1078,22 +1110,18 @@ static void seg6_local_update_counters(struct seg6_local_lwt *slwt,
 	u64_stats_update_end(&pcounters->syncp);
 }
 
-static int seg6_local_input(struct sk_buff *skb)
+static int seg6_local_input_core(struct net *net, struct sock *sk,
+				 struct sk_buff *skb)
 {
 	struct dst_entry *orig_dst = skb_dst(skb);
+	struct seg6_local_lwt *slwt = NULL;
 	struct seg6_action_desc *desc;
-	struct seg6_local_lwt *slwt;
 	unsigned int len = skb->len;
 	int rc;
 
-	if (skb->protocol != htons(ETH_P_IPV6)) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
-
 	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
-	desc = slwt->desc;
 
+	desc = slwt->desc;
 	rc = desc->input(skb, slwt);
 
 	if (!seg6_lwtunnel_counters_enabled(slwt))
@@ -1104,6 +1132,21 @@ static int seg6_local_input(struct sk_buff *skb)
 	return rc;
 }
 
+static int seg6_local_input(struct sk_buff *skb)
+{
+	if (skb->protocol != htons(ETH_P_IPV6)) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	if (static_branch_unlikely(&nf_ct_lwtunnel_enabled))
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

