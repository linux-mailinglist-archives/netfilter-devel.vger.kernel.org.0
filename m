Return-Path: <netfilter-devel+bounces-8570-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8ECB3BECA
	for <lists+netfilter-devel@lfdr.de>; Fri, 29 Aug 2025 17:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7A6163722
	for <lists+netfilter-devel@lfdr.de>; Fri, 29 Aug 2025 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61824314A9B;
	Fri, 29 Aug 2025 15:02:18 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00B19CC02
	for <netfilter-devel@vger.kernel.org>; Fri, 29 Aug 2025 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479738; cv=none; b=sgcFu4cEpEOylYziVxHFUN65Ve8s7ikSZqUDOrgJwA5tydIlnYZ4ROhsZBcnc6+x6eYeY0pQ0olENUFxIiEvBltPJUviSX+awTpfXujNvn3Wd6YV/opErj4QbWFtmsE62t/64uN0lQEIUUIlsHsNYR9X2jIlq7KgQl7+x7oxELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479738; c=relaxed/simple;
	bh=NzaCoj/jdMEY4hzHw7IQXcfWGsqDet21zdI5+j+WZ28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aR/2+Fz16vYx1atj+GN2ObM/zj6y2bPuIFi65HOs0y+y9wacS3tEb71qB7hvq88MwCAOrVDvFA8PjhRQYMHoz4kHf9PmlRZAAonMDVoSdg1+5mCDozUfe6JiNMLO8ZR+14NM7rMwzz8yOBLwYxGXVpN8qTqRDXl5l9fwdAI1UQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id DC2DB60606; Fri, 29 Aug 2025 17:02:12 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: nf_reject_ipv4: remove unneeded exports
Date: Fri, 29 Aug 2025 17:02:03 +0200
Message-ID: <20250829150207.18327-1-fw@strlen.de>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions have no external callers and can be static.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/ipv4/nf_reject.h |  8 ------
 include/net/netfilter/ipv6/nf_reject.h | 10 -------
 net/ipv4/netfilter/nf_reject_ipv4.c    | 27 ++++++++++++-------
 net/ipv6/netfilter/nf_reject_ipv6.c    | 37 +++++++++++++++++---------
 4 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/include/net/netfilter/ipv4/nf_reject.h b/include/net/netfilter/ipv4/nf_reject.h
index c653fcb88354..09de2f2686b5 100644
--- a/include/net/netfilter/ipv4/nf_reject.h
+++ b/include/net/netfilter/ipv4/nf_reject.h
@@ -10,14 +10,6 @@
 void nf_send_unreach(struct sk_buff *skb_in, int code, int hook);
 void nf_send_reset(struct net *net, struct sock *, struct sk_buff *oldskb,
 		   int hook);
-const struct tcphdr *nf_reject_ip_tcphdr_get(struct sk_buff *oldskb,
-					     struct tcphdr *_oth, int hook);
-struct iphdr *nf_reject_iphdr_put(struct sk_buff *nskb,
-				  const struct sk_buff *oldskb,
-				  __u8 protocol, int ttl);
-void nf_reject_ip_tcphdr_put(struct sk_buff *nskb, const struct sk_buff *oldskb,
-			     const struct tcphdr *oth);
-
 struct sk_buff *nf_reject_skb_v4_unreach(struct net *net,
                                          struct sk_buff *oldskb,
                                          const struct net_device *dev,
diff --git a/include/net/netfilter/ipv6/nf_reject.h b/include/net/netfilter/ipv6/nf_reject.h
index d729344ba644..94ec0b9f2838 100644
--- a/include/net/netfilter/ipv6/nf_reject.h
+++ b/include/net/netfilter/ipv6/nf_reject.h
@@ -9,16 +9,6 @@ void nf_send_unreach6(struct net *net, struct sk_buff *skb_in, unsigned char cod
 		      unsigned int hooknum);
 void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		    int hook);
-const struct tcphdr *nf_reject_ip6_tcphdr_get(struct sk_buff *oldskb,
-					      struct tcphdr *otcph,
-					      unsigned int *otcplen, int hook);
-struct ipv6hdr *nf_reject_ip6hdr_put(struct sk_buff *nskb,
-				     const struct sk_buff *oldskb,
-				     __u8 protocol, int hoplimit);
-void nf_reject_ip6_tcphdr_put(struct sk_buff *nskb,
-			      const struct sk_buff *oldskb,
-			      const struct tcphdr *oth, unsigned int otcplen);
-
 struct sk_buff *nf_reject_skb_v6_tcp_reset(struct net *net,
 					   struct sk_buff *oldskb,
 					   const struct net_device *dev,
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 0d3cb2ba6fc8..05631abe3f0d 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -12,6 +12,15 @@
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_bridge.h>
 
+static struct iphdr *nf_reject_iphdr_put(struct sk_buff *nskb,
+					 const struct sk_buff *oldskb,
+					 __u8 protocol, int ttl);
+static void nf_reject_ip_tcphdr_put(struct sk_buff *nskb, const struct sk_buff *oldskb,
+				    const struct tcphdr *oth);
+static const struct tcphdr *
+nf_reject_ip_tcphdr_get(struct sk_buff *oldskb,
+			struct tcphdr *_oth, int hook);
+
 static int nf_reject_iphdr_validate(struct sk_buff *skb)
 {
 	struct iphdr *iph;
@@ -136,8 +145,9 @@ struct sk_buff *nf_reject_skb_v4_unreach(struct net *net,
 }
 EXPORT_SYMBOL_GPL(nf_reject_skb_v4_unreach);
 
-const struct tcphdr *nf_reject_ip_tcphdr_get(struct sk_buff *oldskb,
-					     struct tcphdr *_oth, int hook)
+static const struct tcphdr *
+nf_reject_ip_tcphdr_get(struct sk_buff *oldskb,
+			struct tcphdr *_oth, int hook)
 {
 	const struct tcphdr *oth;
 
@@ -163,11 +173,10 @@ const struct tcphdr *nf_reject_ip_tcphdr_get(struct sk_buff *oldskb,
 
 	return oth;
 }
-EXPORT_SYMBOL_GPL(nf_reject_ip_tcphdr_get);
 
-struct iphdr *nf_reject_iphdr_put(struct sk_buff *nskb,
-				  const struct sk_buff *oldskb,
-				  __u8 protocol, int ttl)
+static struct iphdr *nf_reject_iphdr_put(struct sk_buff *nskb,
+					 const struct sk_buff *oldskb,
+					 __u8 protocol, int ttl)
 {
 	struct iphdr *niph, *oiph = ip_hdr(oldskb);
 
@@ -188,10 +197,9 @@ struct iphdr *nf_reject_iphdr_put(struct sk_buff *nskb,
 
 	return niph;
 }
-EXPORT_SYMBOL_GPL(nf_reject_iphdr_put);
 
-void nf_reject_ip_tcphdr_put(struct sk_buff *nskb, const struct sk_buff *oldskb,
-			  const struct tcphdr *oth)
+static void nf_reject_ip_tcphdr_put(struct sk_buff *nskb, const struct sk_buff *oldskb,
+				    const struct tcphdr *oth)
 {
 	struct iphdr *niph = ip_hdr(nskb);
 	struct tcphdr *tcph;
@@ -218,7 +226,6 @@ void nf_reject_ip_tcphdr_put(struct sk_buff *nskb, const struct sk_buff *oldskb,
 	nskb->csum_start = (unsigned char *)tcph - nskb->head;
 	nskb->csum_offset = offsetof(struct tcphdr, check);
 }
-EXPORT_SYMBOL_GPL(nf_reject_ip_tcphdr_put);
 
 static int nf_reject_fill_skb_dst(struct sk_buff *skb_in)
 {
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index cb2d38e80de9..6b022449f867 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -12,6 +12,19 @@
 #include <linux/netfilter_ipv6.h>
 #include <linux/netfilter_bridge.h>
 
+static struct ipv6hdr *
+nf_reject_ip6hdr_put(struct sk_buff *nskb,
+		     const struct sk_buff *oldskb,
+		     __u8 protocol, int hoplimit);
+static void
+nf_reject_ip6_tcphdr_put(struct sk_buff *nskb,
+			 const struct sk_buff *oldskb,
+			 const struct tcphdr *oth, unsigned int otcplen);
+static const struct tcphdr *
+nf_reject_ip6_tcphdr_get(struct sk_buff *oldskb,
+			 struct tcphdr *otcph,
+			 unsigned int *otcplen, int hook);
+
 static bool nf_reject_v6_csum_ok(struct sk_buff *skb, int hook)
 {
 	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
@@ -146,9 +159,10 @@ struct sk_buff *nf_reject_skb_v6_unreach(struct net *net,
 }
 EXPORT_SYMBOL_GPL(nf_reject_skb_v6_unreach);
 
-const struct tcphdr *nf_reject_ip6_tcphdr_get(struct sk_buff *oldskb,
-					      struct tcphdr *otcph,
-					      unsigned int *otcplen, int hook)
+static const struct tcphdr *
+nf_reject_ip6_tcphdr_get(struct sk_buff *oldskb,
+			 struct tcphdr *otcph,
+			 unsigned int *otcplen, int hook)
 {
 	const struct ipv6hdr *oip6h = ipv6_hdr(oldskb);
 	u8 proto;
@@ -192,11 +206,11 @@ const struct tcphdr *nf_reject_ip6_tcphdr_get(struct sk_buff *oldskb,
 
 	return otcph;
 }
-EXPORT_SYMBOL_GPL(nf_reject_ip6_tcphdr_get);
 
-struct ipv6hdr *nf_reject_ip6hdr_put(struct sk_buff *nskb,
-				     const struct sk_buff *oldskb,
-				     __u8 protocol, int hoplimit)
+static struct ipv6hdr *
+nf_reject_ip6hdr_put(struct sk_buff *nskb,
+		     const struct sk_buff *oldskb,
+		     __u8 protocol, int hoplimit)
 {
 	struct ipv6hdr *ip6h;
 	const struct ipv6hdr *oip6h = ipv6_hdr(oldskb);
@@ -216,11 +230,11 @@ struct ipv6hdr *nf_reject_ip6hdr_put(struct sk_buff *nskb,
 
 	return ip6h;
 }
-EXPORT_SYMBOL_GPL(nf_reject_ip6hdr_put);
 
-void nf_reject_ip6_tcphdr_put(struct sk_buff *nskb,
-			      const struct sk_buff *oldskb,
-			      const struct tcphdr *oth, unsigned int otcplen)
+static void
+nf_reject_ip6_tcphdr_put(struct sk_buff *nskb,
+			 const struct sk_buff *oldskb,
+			 const struct tcphdr *oth, unsigned int otcplen)
 {
 	struct tcphdr *tcph;
 
@@ -248,7 +262,6 @@ void nf_reject_ip6_tcphdr_put(struct sk_buff *nskb,
 				      csum_partial(tcph,
 						   sizeof(struct tcphdr), 0));
 }
-EXPORT_SYMBOL_GPL(nf_reject_ip6_tcphdr_put);
 
 static int nf_reject6_fill_skb_dst(struct sk_buff *skb_in)
 {
-- 
2.49.1


