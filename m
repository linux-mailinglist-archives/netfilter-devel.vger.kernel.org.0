Return-Path: <netfilter-devel+bounces-8778-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F4003B535E4
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Sep 2025 16:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED340AA53B0
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Sep 2025 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81DC33EB13;
	Thu, 11 Sep 2025 14:38:48 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BC33CEAA;
	Thu, 11 Sep 2025 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601528; cv=none; b=svAPMBgHi0rNF0L4fLclxOk+w2jRkfGSAvCWyX3YkYbwhXEea74U02GizYrV20+6JRk0en30EZv9YZu0HG7ky/PdSrU6W83XBMoQFnwud711P19ZTwKgBI8jrn+nJyWdten77lUwvDCqXIO/MGXYiGaB5Vlb1AFPzM6kWwTqS7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601528; c=relaxed/simple;
	bh=/NyPCYHf27bdEQpt/sqcbHlzPL7BJBilJAsPHqcFe9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nY8997G+b0y5x0rV7DUkqoQHp4jEKwiKM2w+fSvcfz0By5eWjnq1Zi3huCW3p1uhK4c8ylNApf9EImroUi16vLqxCxG8nae2N3ebxBaEfqOciItBsbKNeL1CiDcrz5UpbnMiqMtFHaS7OA/w8tD6oD4jyusc6wSUeuiYTSlISU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 896F960326; Thu, 11 Sep 2025 16:38:45 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 5/5] netfilter: nf_reject: don't reply to icmp error messages
Date: Thu, 11 Sep 2025 16:38:19 +0200
Message-ID: <20250911143819.14753-6-fw@strlen.de>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250911143819.14753-1-fw@strlen.de>
References: <20250911143819.14753-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp reject code won't reply to a tcp reset.

But the icmp reject 'netdev' family versions will reply to icmp
dst-unreach errors, unlike icmp_send() and icmp6_send() which are used
by the inet family implementation (and internally by the REJECT target).

Check for the icmp(6) type and do not respond if its an unreachable error.

Without this, something like 'ip protocol icmp reject', when used
in a netdev chain attached to 'lo', cause a packet loop.

Same for two hosts that both use such a rule: each error packet
will be replied to.

Such situation persist until the (bogus) rule is amended to ratelimit or
checks the icmp type before the reject statement.

As the inet versions don't do this make the netdev ones follow along.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv4/netfilter/nf_reject_ipv4.c | 25 ++++++++++++++++++++++++
 net/ipv6/netfilter/nf_reject_ipv6.c | 30 +++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 05631abe3f0d..fae4aa4a5f09 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -80,6 +80,27 @@ struct sk_buff *nf_reject_skb_v4_tcp_reset(struct net *net,
 }
 EXPORT_SYMBOL_GPL(nf_reject_skb_v4_tcp_reset);
 
+static bool nf_skb_is_icmp_unreach(const struct sk_buff *skb)
+{
+	const struct iphdr *iph = ip_hdr(skb);
+	u8 *tp, _type;
+	int thoff;
+
+	if (iph->protocol != IPPROTO_ICMP)
+		return false;
+
+	thoff = skb_network_offset(skb) + sizeof(*iph);
+
+	tp = skb_header_pointer(skb,
+				thoff + offsetof(struct icmphdr, type),
+				sizeof(_type), &_type);
+
+	if (!tp)
+		return false;
+
+	return *tp == ICMP_DEST_UNREACH;
+}
+
 struct sk_buff *nf_reject_skb_v4_unreach(struct net *net,
 					 struct sk_buff *oldskb,
 					 const struct net_device *dev,
@@ -100,6 +121,10 @@ struct sk_buff *nf_reject_skb_v4_unreach(struct net *net,
 	if (ip_hdr(oldskb)->frag_off & htons(IP_OFFSET))
 		return NULL;
 
+	/* don't reply to ICMP_DEST_UNREACH with ICMP_DEST_UNREACH. */
+	if (nf_skb_is_icmp_unreach(oldskb))
+		return NULL;
+
 	/* RFC says return as much as we can without exceeding 576 bytes. */
 	len = min_t(unsigned int, 536, oldskb->len);
 
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 6b022449f867..ef5b7e85cffa 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -104,6 +104,32 @@ struct sk_buff *nf_reject_skb_v6_tcp_reset(struct net *net,
 }
 EXPORT_SYMBOL_GPL(nf_reject_skb_v6_tcp_reset);
 
+static bool nf_skb_is_icmp6_unreach(const struct sk_buff *skb)
+{
+	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
+	u8 proto = ip6h->nexthdr;
+	u8 _type, *tp;
+	int thoff;
+	__be16 fo;
+
+	thoff = ipv6_skip_exthdr(skb, ((u8 *)(ip6h + 1) - skb->data), &proto, &fo);
+
+	if (thoff < 0 || thoff >= skb->len || fo != 0)
+		return false;
+
+	if (proto != IPPROTO_ICMPV6)
+		return false;
+
+	tp = skb_header_pointer(skb,
+				thoff + offsetof(struct icmp6hdr, icmp6_type),
+				sizeof(_type), &_type);
+
+	if (!tp)
+		return false;
+
+	return *tp == ICMPV6_DEST_UNREACH;
+}
+
 struct sk_buff *nf_reject_skb_v6_unreach(struct net *net,
 					 struct sk_buff *oldskb,
 					 const struct net_device *dev,
@@ -117,6 +143,10 @@ struct sk_buff *nf_reject_skb_v6_unreach(struct net *net,
 	if (!nf_reject_ip6hdr_validate(oldskb))
 		return NULL;
 
+	/* Don't reply to ICMPV6_DEST_UNREACH with ICMPV6_DEST_UNREACH */
+	if (nf_skb_is_icmp6_unreach(oldskb))
+		return NULL;
+
 	/* Include "As much of invoking packet as possible without the ICMPv6
 	 * packet exceeding the minimum IPv6 MTU" in the ICMP payload.
 	 */
-- 
2.49.1


