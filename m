Return-Path: <netfilter-devel+bounces-13285-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jh3qNX/tMGpZYwUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13285-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 08:30:23 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2318B68C842
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 08:30:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="aW3ZFOn/";
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13285-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13285-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B1483007291
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 06:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D73B3DC875;
	Tue, 16 Jun 2026 06:30:16 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4523D7D99
	for <netfilter-devel@vger.kernel.org>; Tue, 16 Jun 2026 06:30:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591416; cv=none; b=jjU6tIIfodEDWScBmqESJOTPWrEHtfBSKIVY5Ug95YeODwgfAi/iMDGz9mEeNCvuGaY0WmW5LpZtHdM9XJQMqkwIVVd8TuWNZ5HNBQroE/xJyhUSx24UJiQIz9iuu/Asc8hVH6CjBNHT5YLi88aBdJhBbBBY8NeAP+fynTeOk1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591416; c=relaxed/simple;
	bh=XEC36mzACGCHilvo4lAGsWnkBw/V81r5v4u6FQFOgvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AT0CsdZRU7pDK1S2XimdiFFiLXlEpMFpWecTQafl7z7Fp6uFxhTs5q9dswEg7sIsLb0BaEF0VacU8kz75Was7ZShCW253Nha/vOBfPXfJ8NxOl9L6ds/EU+fRMqjGFabJk3nWw+eRRYWUtbb/qTqOb/jOMPPKDi+aK4BV7+tSNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW3ZFOn/; arc=none smtp.client-ip=209.85.208.174
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39676d82b7fso37490811fa.0
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Jun 2026 23:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781591413; x=1782196213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hv4Oosl+VzlLTaV5qUQl01CH44gb7SsUdMG105aKzy0=;
        b=aW3ZFOn/K+wf9orllp8Z5qGXbk3HAjMAdw5X5/TlzbdoOYU0HaM5jNQI5JXBJCgYND
         0AME4Z1ZcJGJZAMpmva65dVhPsx4jDol1BkxKQ7o/rvzUELNznVxTW4yQKW8pYRZHIUg
         dayoGb4Y5mLdwaCKy8G+Q6E5bpx3aH1/HX4o7gsWTvFcLa2+vwt+x44NHcPnWEGycdNJ
         XezT0nPsMWHWVMfaLECS67Fx8C2Ud84TO+ZyCdd1VnnrVZRdTEM8dzHPJn0eEa3CKeGe
         e/8KlnPrOnNw4OGhMLgMIFMFNARTGhKCot+0C9Iag0jf/TjPOHf5Wzuuo0JdX9iYGTH0
         mmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781591413; x=1782196213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hv4Oosl+VzlLTaV5qUQl01CH44gb7SsUdMG105aKzy0=;
        b=BRhkbQ1kOk/rzXy0Z+lc56WdlsdOfQGeDIPbakpySUC6kpMbtueYm1g8cS2akMatYJ
         sCXgQd42raOH7pMUWsjFlxQ5SltAdqVbNrwMm+YTQQJiHj6dCPEfRskD1+tPwSHFgjye
         J+bH8XjcgYz7/qgyC/kW4heyhYvdcS6xKVVkZTqe0snn8w1fbGiyUM7MEGp7brka2bbt
         6o96YGkV/2Xo2Nn0Wj40JPQ35QBojsbCQRYPQ6nRPRjWGpUPO9jbwzxGtCpyqo3DwEGW
         iAnjWBiXAEYQeXQelS5Zut/yc/k5wfFkqduLUI41MlSzCflLYw4DfXJXA95rilFY+Unh
         4x4g==
X-Forwarded-Encrypted: i=1; AFNElJ+olO0Gw+AdVhdgpWfBF7o52J3s+1RJbiJPQ1tOtZQM4EDV7Mii13myBf7u5nb2C6vP45AQomOsKDUd7EIDd6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ejD/oWdlomKfQXy1s11J3WBe6TA7JAWFKQcaJAQgaIunXVxY
	Anqi/lEufBWdPBKWD/0MI+1R8bPUKUfjw6tS3H3CuI1kgBeCauWs82+3
X-Gm-Gg: Acq92OHsMpdbrZ0ACkocuHjgrhb7vwRRU4wrRyHdwx59K+3B28Og2/y6AU8ywZXaNw7
	TRpewYVIZBTR1rIcfOPR3eABPg1W8CwdGUFPdtEeUrdsZH3x4f7Yn5Rg1FGM7s5BjZba9CC8CNf
	CEcdzzp8svTDGvvCdyfPgRk/Wm6xeJVBXY+C+RRWZrWSStr1+bysu4LsxDOwRMm2rMGY6ijweXX
	6o1dKg4bxWWI2YkKi798NavLCXGI3kRcJGCNEaKd5nnPDxW3gP1EtgXA+7iwAQcqqYKwwSVDolM
	3NhXxXIzlZdJ7cx34l5bWuXrD6XvjCdptH5zsmyVOOyTEnFpYWZs6KlpRVZSDXylGMIKKhA2h/R
	sMhIu6sHTCPj1DEBKTcHHSakW2cFieiTmhvhBQ4sPFE8+0xxffoXrJPbFhFeov/VfDyi8N40g6o
	uvmZiCo9Ifkn/2FWVhfXkM1K8fjiXAVZv+oGojRKPJBlCCdu0vAoeQChWFB/++0gQv2p8c
X-Received: by 2002:a2e:a80e:0:b0:396:6bd5:a9c7 with SMTP id 38308e7fff4ca-3995c85103dmr6238941fa.19.1781591412632;
        Mon, 15 Jun 2026 23:30:12 -0700 (PDT)
Received: from cherrypc.astra-academy.ru (109-252-17-231.nat.spd-mgts.ru. [109.252.17.231])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3995c1a3706sm4045501fa.42.2026.06.15.23.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 23:30:12 -0700 (PDT)
From: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Venkata Mohan Reddy <mohanreddykv@gmail.com>,
	Patrick McHardy <kaber@trash.net>,
	Julius Volz <juliusv@google.com>,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	Wensong Zhang <wensong@linux-vs.org>,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15/6.1/6.6/6.12/6.18] ipvs: skip ipv6 extension headers for csum checks
Date: Tue, 16 Jun 2026 09:30:23 +0300
Message-ID: <20260616063025.648647-1-nazarkalashnikov0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,verge.net.au,ssi.bg,netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,trash.net,vger.kernel.org,linux-vs.org,linuxtesting.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-13285-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:nazarkalashnikov0@gmail.com,m:horms@verge.net.au,m:ja@ssi.bg,m:pablo@netfilter.org,m:kadlec@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mohanreddykv@gmail.com,m:kaber@trash.net,m:juliusv@google.com,m:netdev@vger.kernel.org,m:lvs-devel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:linux-kernel@vger.kernel.org,m:wensong@linux-vs.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[nazarkalashnikov0@gmail.com,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nazarkalashnikov0@gmail.com,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2318B68C842

From: Julian Anastasov <ja@ssi.bg>

commit 05cfe9863ef049d98141dc2969eefde72fb07625 upstream.

Protocol checksum validation fails for IPv6 if there are extension
headers before the protocol header. iph->len already contains its
offset, so use it to fix the problem.

Fixes: 2906f66a5682 ("ipvs: SCTP Trasport Loadbalancing Support")
Fixes: 0bbdd42b7efa ("IPVS: Extend protocol DNAT/SNAT and state handlers")
Signed-off-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
---
Backport fix for CVE-2026-45850
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
index 7da51390cea6..ede4fa3b63f5 100644
--- a/net/netfilter/ipvs/ip_vs_proto_tcp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_tcp.c
@@ -29,7 +29,8 @@
 #include <net/ip_vs.h>
 
 static int
-tcp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp);
+tcp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp,
+	       unsigned int tcphoff);
 
 static int
 tcp_conn_schedule(struct netns_ipvs *ipvs, int af, struct sk_buff *skb,
@@ -166,7 +167,7 @@ tcp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!tcp_csum_check(cp->af, skb, pp))
+		if (!tcp_csum_check(cp->af, skb, pp, tcphoff))
 			return 0;
 
 		/* Call application helper if needed */
@@ -244,7 +245,7 @@ tcp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!tcp_csum_check(cp->af, skb, pp))
+		if (!tcp_csum_check(cp->af, skb, pp, tcphoff))
 			return 0;
 
 		/*
@@ -301,17 +302,9 @@ tcp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 
 
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
@@ -322,7 +315,7 @@ tcp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp)
 			if (csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
 					    &ipv6_hdr(skb)->daddr,
 					    skb->len - tcphoff,
-					    ipv6_hdr(skb)->nexthdr,
+					    IPPROTO_TCP,
 					    skb->csum)) {
 				IP_VS_DBG_RL_PKT(0, af, pp, skb, 0,
 						 "Failed checksum for");
diff --git a/net/netfilter/ipvs/ip_vs_proto_udp.c b/net/netfilter/ipvs/ip_vs_proto_udp.c
index 68260d91c988..ffbebda547fc 100644
--- a/net/netfilter/ipvs/ip_vs_proto_udp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_udp.c
@@ -25,7 +25,8 @@
 #include <net/ip6_checksum.h>
 
 static int
-udp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp);
+udp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp,
+	       unsigned int udphoff);
 
 static int
 udp_conn_schedule(struct netns_ipvs *ipvs, int af, struct sk_buff *skb,
@@ -155,7 +156,7 @@ udp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!udp_csum_check(cp->af, skb, pp))
+		if (!udp_csum_check(cp->af, skb, pp, udphoff))
 			return 0;
 
 		/*
@@ -238,7 +239,7 @@ udp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		int ret;
 
 		/* Some checks before mangling */
-		if (!udp_csum_check(cp->af, skb, pp))
+		if (!udp_csum_check(cp->af, skb, pp, udphoff))
 			return 0;
 
 		/*
@@ -297,17 +298,10 @@ udp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 
 
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
@@ -325,7 +319,7 @@ udp_csum_check(int af, struct sk_buff *skb, struct ip_vs_protocol *pp)
 				if (csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
 						    &ipv6_hdr(skb)->daddr,
 						    skb->len - udphoff,
-						    ipv6_hdr(skb)->nexthdr,
+						    IPPROTO_UDP,
 						    skb->csum)) {
 					IP_VS_DBG_RL_PKT(0, af, pp, skb, 0,
 							 "Failed checksum for");
-- 
2.47.3

