Return-Path: <netfilter-devel+bounces-10799-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEGjBKuYlGkoFwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10799-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Feb 2026 17:34:51 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E8214E407
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Feb 2026 17:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE9C43029AA9
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Feb 2026 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CA036F42E;
	Tue, 17 Feb 2026 16:33:15 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF433335BCC;
	Tue, 17 Feb 2026 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345995; cv=none; b=Z8t7T1K7OrORR7t+YHCsr+mUs5nUVgXUQCYjYy+lF7X9QCixWa1aXk51huxlK0dGI6HgVO2G2ZI3ptROi4q5vSQfe2MbLsThn8YqBuylfe51x0CBml7VUHqFNwSmB3cKmF5T8o42NTZdYIHznueXs2djvkcui00ki++5EMilo/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345995; c=relaxed/simple;
	bh=8PLDj5S+rzBQKHoMgCvxtICj5QZak0cy6ZSfjakIOC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkVB+QuguP0RY3yIarSsmRmJ+HeYymLlhXOOS1hkYHSrpufFg7CnMv35OrxxA7uGcXuLfgLJNq4TY62Vks9YWi0Eo3cneQioCoYQRTus6ry+nTtfSuPcP6pYWahWkPJt8YBT8v1axtX0x3JRTFDAK0rLTRLKux1zLJT14ptOz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 46B6760683; Tue, 17 Feb 2026 17:33:12 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 07/10] ipvs: skip ipv6 extension headers for csum checks
Date: Tue, 17 Feb 2026 17:32:30 +0100
Message-ID: <20260217163233.31455-8-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260217163233.31455-1-fw@strlen.de>
References: <20260217163233.31455-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10799-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4E8214E407
X-Rspamd-Action: no action

From: Julian Anastasov <ja@ssi.bg>

Protocol checksum validation fails for IPv6 if there are extension
headers before the protocol header. iph->len already contains its
offset, so use it to fix the problem.

Fixes: 2906f66a5682 ("ipvs: SCTP Trasport Loadbalancing Support")
Fixes: 0bbdd42b7efa ("IPVS: Extend protocol DNAT/SNAT and state handlers")
Signed-off-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/ipvs/ip_vs_proto_sctp.c | 18 ++++++------------
 net/netfilter/ipvs/ip_vs_proto_tcp.c  | 21 +++++++--------------
 net/netfilter/ipvs/ip_vs_proto_udp.c  | 20 +++++++-------------
 3 files changed, 20 insertions(+), 39 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_proto_sctp.c b/net/netfilter/ipvs/ip_vs_proto_sctp.c
index 83e452916403..63c78a1f3918 100644
--- a/net/netfilter/ipvs/ip_vs_proto_sctp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_sctp.c
@@ -10,7 +10,8 @@
 #include <net/ip_vs.h>
 
 static int
-sctp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp);
+sctp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp,
+		unsigned int sctphoff);
 
 static int
 sctp_conn_schedule(struct netns_ipvs *ipvs, int af, struct sk_buff *skb,
@@ -108,7 +109,7 @@ sctp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!sctp_csum_check(cp->af, skb, pp))
+		if (!sctp_csum_check(cp->af, skb, pp, sctphoff))
 			return 0;
 
 		/* Call application helper if needed */
@@ -156,7 +157,7 @@ sctp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!sctp_csum_check(cp->af, skb, pp))
+		if (!sctp_csum_check(cp->af, skb, pp, sctphoff))
 			return 0;
 
 		/* Call application helper if needed */
@@ -185,19 +186,12 @@ sctp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 }
 
 static int
-sctp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp)
+sctp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp,
+		unsigned int sctphoff)
 {
-	unsigned int sctphoff;
 	struct sctphdr *sh;
 	__le32 cmp, val;
 
-#ifdef CONFIG_IP_VS_IPV6
-	if (af == AF_INET6)
-		sctphoff = sizeof(struct ipv6hdr);
-	else
-#endif
-		sctphoff = ip_hdrlen(skb);
-
 	sh = (struct sctphdr *)(skb->data + sctphoff);
 	cmp = sh->checksum;
 	val = sctp_compute_cksum(skb, sctphoff);
diff --git a/net/netfilter/ipvs/ip_vs_proto_tcp.c b/net/netfilter/ipvs/ip_vs_proto_tcp.c
index f68a1533ee45..8cc0a8ce6241 100644
--- a/net/netfilter/ipvs/ip_vs_proto_tcp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_tcp.c
@@ -28,7 +28,8 @@
 #include <net/ip_vs.h>
 
 static int
-tcp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp);
+tcp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp,
+	       unsigned int tcphoff);
 
 static int
 tcp_conn_schedule(struct netns_ipvs *ipvs, int af, struct sk_buff *skb,
@@ -165,7 +166,7 @@ tcp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!tcp_csum_check(cp->af, skb, pp))
+		if (!tcp_csum_check(cp->af, skb, pp, tcphoff))
 			return 0;
 
 		/* Call application helper if needed */
@@ -243,7 +244,7 @@ tcp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!tcp_csum_check(cp->af, skb, pp))
+		if (!tcp_csum_check(cp->af, skb, pp, tcphoff))
 			return 0;
 
 		/*
@@ -300,17 +301,9 @@ tcp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 
 
 static int
-tcp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp)
+tcp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp,
+	       unsigned int tcphoff)
 {
-	unsigned int tcphoff;
-
-#ifdef CONFIG_IP_VS_IPV6
-	if (af == AF_INET6)
-		tcphoff = sizeof(struct ipv6hdr);
-	else
-#endif
-		tcphoff = ip_hdrlen(skb);
-
 	switch (skb->ip_summed) {
 	case CHECKSUM_NONE:
 		skb->csum = skb_checksum(skb, tcphoff, skb->len - tcphoff, 0);
@@ -321,7 +314,7 @@ tcp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp)
 			if (csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
 					    &ipv6_hdr(skb)->daddr,
 					    skb->len - tcphoff,
-					    ipv6_hdr(skb)->nexthdr,
+					    IPPROTO_TCP,
 					    skb->csum)) {
 				IP_VS_DBG_RL_PKT(0, af, pp, skb, 0,
 						 "Failed checksum for");
diff --git a/net/netfilter/ipvs/ip_vs_proto_udp.c b/net/netfilter/ipvs/ip_vs_proto_udp.c
index 0f0107c80dd2..f9de632e38cd 100644
--- a/net/netfilter/ipvs/ip_vs_proto_udp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_udp.c
@@ -24,7 +24,8 @@
 #include <net/ip6_checksum.h>
 
 static int
-udp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp);
+udp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp,
+	       unsigned int udphoff);
 
 static int
 udp_conn_schedule(struct netns_ipvs *ipvs, int af, struct sk_buff *skb,
@@ -154,7 +155,7 @@ udp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!udp_csum_check(cp->af, skb, pp))
+		if (!udp_csum_check(cp->af, skb, pp, udphoff))
 			return 0;
 
 		/*
@@ -237,7 +238,7 @@ udp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!udp_csum_check(cp->af, skb, pp))
+		if (!udp_csum_check(cp->af, skb, pp, udphoff))
 			return 0;
 
 		/*
@@ -296,17 +297,10 @@ udp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 
 
 static int
-udp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp)
+udp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp,
+	       unsigned int udphoff)
 {
 	struct udphdr _udph, *uh;
-	unsigned int udphoff;
-
-#ifdef CONFIG_IP_VS_IPV6
-	if (af == AF_INET6)
-		udphoff = sizeof(struct ipv6hdr);
-	else
-#endif
-		udphoff = ip_hdrlen(skb);
 
 	uh = skb_header_pointer(skb, udphoff, sizeof(_udph), &_udph);
 	if (uh == NULL)
@@ -324,7 +318,7 @@ udp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp)
 				if (csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
 						    &ipv6_hdr(skb)->daddr,
 						    skb->len - udphoff,
-						    ipv6_hdr(skb)->nexthdr,
+						    IPPROTO_UDP,
 						    skb->csum)) {
 					IP_VS_DBG_RL_PKT(0, af, pp, skb, 0,
 							 "Failed checksum for");
-- 
2.52.0


