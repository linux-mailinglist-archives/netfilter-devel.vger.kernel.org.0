Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2745339F58A
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Jun 2021 13:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhFHLu1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Jun 2021 07:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhFHLu0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:50:26 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FE5C061574
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Jun 2021 04:48:34 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lqaDg-0000oi-NP; Tue, 08 Jun 2021 13:48:32 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf 2/2] netfilter: ipv6: skip ipv6 packets from any to link-local
Date:   Tue,  8 Jun 2021 13:48:18 +0200
Message-Id: <20210608114818.23397-3-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608114818.23397-1-fw@strlen.de>
References: <20210608114818.23397-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The ip6tables rpfilter match has an extra check to skip packets with
"::" source address.

Extend this to ipv6 fib expression.  Else ipv6 duplicate address detection
packets will fail rpf route check -- lookup returns -ENETUNREACH.

While at it, extend the prerouting check to also cover the ingress hook.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1543
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv6/netfilter/nft_fib_ipv6.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index e204163c7036..92f3235fa287 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -135,6 +135,17 @@ void nft_fib6_eval_type(const struct nft_expr *expr, struct nft_regs *regs,
 }
 EXPORT_SYMBOL_GPL(nft_fib6_eval_type);
 
+static bool nft_fib_v6_skip_icmpv6(const struct sk_buff *skb, u8 next, const struct ipv6hdr *iph)
+{
+	if (likely(next != IPPROTO_ICMPV6))
+		return false;
+
+	if (ipv6_addr_type(&iph->saddr) != IPV6_ADDR_ANY)
+		return false;
+
+	return ipv6_addr_type(&iph->daddr) & IPV6_ADDR_LINKLOCAL;
+}
+
 void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 		   const struct nft_pktinfo *pkt)
 {
@@ -163,10 +174,13 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 
 	lookup_flags = nft_fib6_flowi_init(&fl6, priv, pkt, oif, iph);
 
-	if (nft_hook(pkt) == NF_INET_PRE_ROUTING &&
-	    nft_fib_is_loopback(pkt->skb, nft_in(pkt))) {
-		nft_fib_store_result(dest, priv, nft_in(pkt));
-		return;
+	if (nft_hook(pkt) == NF_INET_PRE_ROUTING ||
+	    nft_hook(pkt) == NF_INET_INGRESS) {
+		if (nft_fib_is_loopback(pkt->skb, nft_in(pkt)) ||
+		    nft_fib_v6_skip_icmpv6(pkt->skb, pkt->tprot, iph)) {
+			nft_fib_store_result(dest, priv, nft_in(pkt));
+			return;
+		}
 	}
 
 	*dest = 0;
-- 
2.31.1

