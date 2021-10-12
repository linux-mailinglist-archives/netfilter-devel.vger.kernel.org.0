Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9EA42A3D8
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Oct 2021 14:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbhJLMIi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Oct 2021 08:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbhJLMIh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:08:37 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1280AC061570;
        Tue, 12 Oct 2021 05:06:36 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1maGYE-0006fX-Ha; Tue, 12 Oct 2021 14:06:34 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     lvs-devel@vger.kernel.org, ja@ssi.bg, horms@verge.net.au,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 3/4] netfilter: ipvs: remove unneeded input wrappers
Date:   Tue, 12 Oct 2021 14:06:07 +0200
Message-Id: <20211012120608.21827-4-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012120608.21827-1-fw@strlen.de>
References: <20211012120608.21827-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

After earlier patch ip_vs_hook_in can be used directly.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/ipvs/ip_vs_core.c | 57 +++------------------------------
 1 file changed, 4 insertions(+), 53 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index 2db033455204..ad5f5e50547f 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -2093,55 +2093,6 @@ ip_vs_in_hook(void *priv, struct sk_buff *skb, const struct nf_hook_state *state
 	return ret;
 }
 
-/*
- *	AF_INET handler in NF_INET_LOCAL_IN chain
- *	Schedule and forward packets from remote clients
- */
-static unsigned int
-ip_vs_remote_request4(void *priv, struct sk_buff *skb,
-		      const struct nf_hook_state *state)
-{
-	return ip_vs_in_hook(priv, skb, state);
-}
-
-/*
- *	AF_INET handler in NF_INET_LOCAL_OUT chain
- *	Schedule and forward packets from local clients
- */
-static unsigned int
-ip_vs_local_request4(void *priv, struct sk_buff *skb,
-		     const struct nf_hook_state *state)
-{
-	return ip_vs_in_hook(priv, skb, state);
-}
-
-#ifdef CONFIG_IP_VS_IPV6
-
-/*
- *	AF_INET6 handler in NF_INET_LOCAL_IN chain
- *	Schedule and forward packets from remote clients
- */
-static unsigned int
-ip_vs_remote_request6(void *priv, struct sk_buff *skb,
-		      const struct nf_hook_state *state)
-{
-	return ip_vs_in_hook(priv, skb, state);
-}
-
-/*
- *	AF_INET6 handler in NF_INET_LOCAL_OUT chain
- *	Schedule and forward packets from local clients
- */
-static unsigned int
-ip_vs_local_request6(void *priv, struct sk_buff *skb,
-		     const struct nf_hook_state *state)
-{
-	return ip_vs_in_hook(priv, skb, state);
-}
-
-#endif
-
-
 /*
  *	It is hooked at the NF_INET_FORWARD chain, in order to catch ICMP
  *      related packets destined for 0.0.0.0/0.
@@ -2202,7 +2153,7 @@ static const struct nf_hook_ops ip_vs_ops4[] = {
 	 * or VS/NAT(change destination), so that filtering rules can be
 	 * applied to IPVS. */
 	{
-		.hook		= ip_vs_remote_request4,
+		.hook		= ip_vs_in_hook,
 		.pf		= NFPROTO_IPV4,
 		.hooknum	= NF_INET_LOCAL_IN,
 		.priority	= NF_IP_PRI_NAT_SRC - 1,
@@ -2216,7 +2167,7 @@ static const struct nf_hook_ops ip_vs_ops4[] = {
 	},
 	/* After mangle, schedule and forward local requests */
 	{
-		.hook		= ip_vs_local_request4,
+		.hook		= ip_vs_in_hook,
 		.pf		= NFPROTO_IPV4,
 		.hooknum	= NF_INET_LOCAL_OUT,
 		.priority	= NF_IP_PRI_NAT_DST + 2,
@@ -2251,7 +2202,7 @@ static const struct nf_hook_ops ip_vs_ops6[] = {
 	 * or VS/NAT(change destination), so that filtering rules can be
 	 * applied to IPVS. */
 	{
-		.hook		= ip_vs_remote_request6,
+		.hook		= ip_vs_in_hook,
 		.pf		= NFPROTO_IPV6,
 		.hooknum	= NF_INET_LOCAL_IN,
 		.priority	= NF_IP6_PRI_NAT_SRC - 1,
@@ -2265,7 +2216,7 @@ static const struct nf_hook_ops ip_vs_ops6[] = {
 	},
 	/* After mangle, schedule and forward local requests */
 	{
-		.hook		= ip_vs_local_request6,
+		.hook		= ip_vs_in_hook,
 		.pf		= NFPROTO_IPV6,
 		.hooknum	= NF_INET_LOCAL_OUT,
 		.priority	= NF_IP6_PRI_NAT_DST + 2,
-- 
2.32.0

