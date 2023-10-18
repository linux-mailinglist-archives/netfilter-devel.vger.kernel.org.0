Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6657CD704
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Oct 2023 10:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjJRIvz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Oct 2023 04:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjJRIvy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:51:54 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE089101;
        Wed, 18 Oct 2023 01:51:51 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qt2HL-0006Lt-Bv; Wed, 18 Oct 2023 10:51:47 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netdev@vger.kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        <netfilter-devel@vger.kernel.org>
Subject: [PATCH net-next 6/7] netfilter: bridge: convert br_netfilter to NF_DROP_REASON
Date:   Wed, 18 Oct 2023 10:51:10 +0200
Message-ID: <20231018085118.10829-7-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018085118.10829-1-fw@strlen.de>
References: <20231018085118.10829-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

errno is 0 because these hooks are called from prerouting and forward.
There is no socket that the errno would ever be propagated to.

Other netfilter modules (e.g. nf_nat, conntrack, ...) can be converted
in a similar way.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/bridge/br_netfilter_hooks.c | 26 +++++++++++++-------------
 net/bridge/br_netfilter_ipv6.c  |  6 +++---
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 033034d68f1f..4c0c9f838f5c 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -486,11 +486,11 @@ static unsigned int br_nf_pre_routing(void *priv,
 	struct brnf_net *brnet;
 
 	if (unlikely(!pskb_may_pull(skb, len)))
-		return NF_DROP;
+		return NF_DROP_REASON(skb, SKB_DROP_REASON_PKT_TOO_SMALL, 0);
 
 	p = br_port_get_rcu(state->in);
 	if (p == NULL)
-		return NF_DROP;
+		return NF_DROP_REASON(skb, SKB_DROP_REASON_DEV_READY, 0);
 	br = p->br;
 
 	brnet = net_generic(state->net, brnf_net_id);
@@ -501,7 +501,7 @@ static unsigned int br_nf_pre_routing(void *priv,
 			return NF_ACCEPT;
 		if (!ipv6_mod_enabled()) {
 			pr_warn_once("Module ipv6 is disabled, so call_ip6tables is not supported.");
-			return NF_DROP;
+			return NF_DROP_REASON(skb, SKB_DROP_REASON_IPV6DISABLED, 0);
 		}
 
 		nf_bridge_pull_encap_header_rcsum(skb);
@@ -518,12 +518,12 @@ static unsigned int br_nf_pre_routing(void *priv,
 	nf_bridge_pull_encap_header_rcsum(skb);
 
 	if (br_validate_ipv4(state->net, skb))
-		return NF_DROP;
+		return NF_DROP_REASON(skb, SKB_DROP_REASON_IP_INHDR, 0);
 
 	if (!nf_bridge_alloc(skb))
-		return NF_DROP;
+		return NF_DROP_REASON(skb, SKB_DROP_REASON_NOMEM, 0);
 	if (!setup_pre_routing(skb, state->net))
-		return NF_DROP;
+		return NF_DROP_REASON(skb, SKB_DROP_REASON_DEV_READY, 0);
 
 	nf_bridge = nf_bridge_info_get(skb);
 	nf_bridge->ipv4_daddr = ip_hdr(skb)->daddr;
@@ -590,15 +590,15 @@ static unsigned int br_nf_forward_ip(void *priv,
 	/* Need exclusive nf_bridge_info since we might have multiple
 	 * different physoutdevs. */
 	if (!nf_bridge_unshare(skb))
-		return NF_DROP;
+		return NF_DROP_REASON(skb, SKB_DROP_REASON_NOMEM, 0);
 
 	nf_bridge = nf_bridge_info_get(skb);
 	if (!nf_bridge)
-		return NF_DROP;
+		return NF_DROP_REASON(skb, SKB_DROP_REASON_NOMEM, 0);
 
 	parent = bridge_parent(state->out);
 	if (!parent)
-		return NF_DROP;
+		return NF_DROP_REASON(skb, SKB_DROP_REASON_DEV_READY, 0);
 
 	if (IS_IP(skb) || is_vlan_ip(skb, state->net) ||
 	    is_pppoe_ip(skb, state->net))
@@ -618,13 +618,13 @@ static unsigned int br_nf_forward_ip(void *priv,
 
 	if (pf == NFPROTO_IPV4) {
 		if (br_validate_ipv4(state->net, skb))
-			return NF_DROP;
+			return NF_DROP_REASON(skb, SKB_DROP_REASON_IP_INHDR, 0);
 		IPCB(skb)->frag_max_size = nf_bridge->frag_max_size;
 	}
 
 	if (pf == NFPROTO_IPV6) {
 		if (br_validate_ipv6(state->net, skb))
-			return NF_DROP;
+			return NF_DROP_REASON(skb, SKB_DROP_REASON_IP_INHDR, 0);
 		IP6CB(skb)->frag_max_size = nf_bridge->frag_max_size;
 	}
 
@@ -666,7 +666,7 @@ static unsigned int br_nf_forward_arp(void *priv,
 	}
 
 	if (unlikely(!pskb_may_pull(skb, sizeof(struct arphdr))))
-		return NF_DROP;
+		return NF_DROP_REASON(skb, SKB_DROP_REASON_PKT_TOO_SMALL, 0);
 
 	if (arp_hdr(skb)->ar_pln != 4) {
 		if (is_vlan_arp(skb, state->net))
@@ -831,7 +831,7 @@ static unsigned int br_nf_post_routing(void *priv,
 		return NF_ACCEPT;
 
 	if (!realoutdev)
-		return NF_DROP;
+		return NF_DROP_REASON(skb, SKB_DROP_REASON_DEV_READY, 0);
 
 	if (IS_IP(skb) || is_vlan_ip(skb, state->net) ||
 	    is_pppoe_ip(skb, state->net))
diff --git a/net/bridge/br_netfilter_ipv6.c b/net/bridge/br_netfilter_ipv6.c
index 550039dfc31a..2e24a743f917 100644
--- a/net/bridge/br_netfilter_ipv6.c
+++ b/net/bridge/br_netfilter_ipv6.c
@@ -161,13 +161,13 @@ unsigned int br_nf_pre_routing_ipv6(void *priv,
 	struct nf_bridge_info *nf_bridge;
 
 	if (br_validate_ipv6(state->net, skb))
-		return NF_DROP;
+		return NF_DROP_REASON(skb, SKB_DROP_REASON_IP_INHDR, 0);
 
 	nf_bridge = nf_bridge_alloc(skb);
 	if (!nf_bridge)
-		return NF_DROP;
+		return NF_DROP_REASON(skb, SKB_DROP_REASON_NOMEM, 0);
 	if (!setup_pre_routing(skb, state->net))
-		return NF_DROP;
+		return NF_DROP_REASON(skb, SKB_DROP_REASON_DEV_READY, 0);
 
 	nf_bridge = nf_bridge_info_get(skb);
 	nf_bridge->ipv6_daddr = ipv6_hdr(skb)->daddr;
-- 
2.41.0

