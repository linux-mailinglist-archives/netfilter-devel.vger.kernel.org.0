Return-Path: <netfilter-devel+bounces-13763-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bzuVIAGRTmpPPgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13763-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 20:03:45 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A18729680
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 20:03:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ssi.bg header.s=ssi header.b="A/VOE/aL";
	dmarc=pass (policy=reject) header.from=ssi.bg;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13763-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13763-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B29730074FD
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C8926738C;
	Wed,  8 Jul 2026 18:03:40 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912AB72630;
	Wed,  8 Jul 2026 18:03:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533820; cv=none; b=iKZmXu+9C8SVA1zwKxqpcZjYy3XBmo8NgNfyV0IE9qVilCpRJSYkPRxGojlv9c6G4yCauPNygAppDW9iDyu9a5VFfUh5X9J3NTxf9B2u3NlXX4GIOkasFF1Ux0NfEMp6y7P/7ZKpi1cTUPVQuOoxp7dfOR7VlRu0Y7aM56hveo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533820; c=relaxed/simple;
	bh=SnKOwUbgQhpL15iPG41OgvXV5HpXsi45dAUZAtUVH1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZiFqR/JfXyTAaZyNYOwpVjMyX7JYsgsBoZ8E1auEtJ1JhcTl4U+jGDOMOGhi2mh61vO34ijkhg9pQV6tojfix8q138sGl7BHiqTVt1HyRs6+kJ15526ROsUKgDwzX8Y6Iu8AferyiZMMTf1BKCEgtMtZ8awJAd3n9E4o0usxZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=A/VOE/aL; arc=none smtp.client-ip=193.238.174.39
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id CE62820252;
	Wed, 08 Jul 2026 21:03:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-transfer-encoding:date:from:from:message-id
	:mime-version:reply-to:subject:subject:to:to; s=ssi; bh=nx9MrCJx
	/SDkoXzxyqAcFi79HDgBleOcD9KwiYWQhKI=; b=A/VOE/aLxxtJIvkKNaG45XQF
	XKxfbrGzdsCaED1r47/N3rNWqGyIrOKbshZtfw5xC4z99juzEt7tvMdhJiNdA03q
	Oior5RY+F2vGFBu0ftbsEsdY0ogkNhCTqfPnVfGIB9hfcy12y/DbOyMW09I2vRHX
	qXc383vd3tZ/Jntrl4LaMXaG5RJCJayQHKmyeQTR9d9Wu75iRHMx9P5tjHtXN/G0
	eISQdkgge3CvHkLzui0Tdg+44mXLsErRZzAzV/Zfr9tN1rFtuieazFXEUcFIwtdI
	4z2UmsEGpJjDkBZNryWvGdFP1g8XuIqMmBFkj2TCKhoebFejYQQEeU6HZCElq6Mz
	MLXzmBDh/JAubOGHdNcwpjGCb+yxOeAjUM5UtIjQgdXLfgvubbnEnY3eLhhHqdT6
	k/m0iWGVmmNVGbYBeLsn2S/E1TCUt/WPWtdKBL5xypNNINi38i6NGtGupoYYPDZ0
	virmutag7zHynOZ/2+doqF3/ykOQgOo9QR8AI9ahF8lyLGgIzTn5eDtcGgYa1Mjb
	CFZggd5Ji3/TqUjqoWUfjz5B3iwziqt+ctQNq+2ozDus5AjD7ne6Vjncgt5sGgd0
	edKfsWdMaBH0ZH0+lJd8PoOW9SKBcmuFN4eGCkrUllUWsl4kkqLze/DWam1ThUGg
	nd5GBBySsrC0yGQvkhs=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Wed, 08 Jul 2026 21:03:32 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 3ED06608DF;
	Wed,  8 Jul 2026 21:03:30 +0300 (EEST)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.2/8.18.2) with ESMTP id 668I3Trg077427;
	Wed, 8 Jul 2026 21:03:29 +0300
Received: (from root@localhost)
	by ja.home.ssi.bg (8.18.2/8.18.2/Submit) id 668I3Q8g077426;
	Wed, 8 Jul 2026 21:03:26 +0300
From: Julian Anastasov <ja@ssi.bg>
To: Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: [PATCH nf] ipvs: fix more places with wrong ipv6 transport offsets
Date: Wed,  8 Jul 2026 21:03:15 +0300
Message-ID: <20260708180315.77413-1-ja@ssi.bg>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ssi.bg,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ssi.bg:s=ssi];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13763-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@verge.net.au,m:pablo@netfilter.org,m:fw@strlen.de,m:lvs-devel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ssi.bg:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ssi.bg:from_mime,ssi.bg:email,ssi.bg:mid,ssi.bg:dkim,sashiko.dev:url];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75A18729680

Sashiko reports for more incorrect IPv6 transport offsets.

The app code for TCP was assuming IPv4 network header
even after the ipvsh argument was provided. This can
cause problems with apps over IPv6. As for the only
official app in the kernel tree (FTP) this problem is
harmless because we use Netfilter to mangle the FTP
ports and we do not adjust the TCP seq numbers.

Also, provide correct offset of the ICMPV6 header in
ip_vs_out_icmp_v6() for correct checksum checks when
the IPv6 packet has extension headers.

Fixes: d12e12299a69 ("ipvs: add ipv6 support to ftp")
Fixes: 2a3b791e6e11 ("IPVS: Add/adjust Netfilter hook functions and helpers for v6")
Link: https://sashiko.dev/#/patchset/20260706101624.69471-1-zhaoyz24%40mails.tsinghua.edu.cn
Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 net/netfilter/ipvs/ip_vs_app.c  | 10 ++++------
 net/netfilter/ipvs/ip_vs_core.c |  3 +--
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_app.c b/net/netfilter/ipvs/ip_vs_app.c
index d54d7da58334..b0e00be85cb1 100644
--- a/net/netfilter/ipvs/ip_vs_app.c
+++ b/net/netfilter/ipvs/ip_vs_app.c
@@ -361,14 +361,13 @@ static inline int app_tcp_pkt_out(struct ip_vs_conn *cp, struct sk_buff *skb,
 				  struct ip_vs_iphdr *ipvsh)
 {
 	int diff;
-	const unsigned int tcp_offset = ip_hdrlen(skb);
 	struct tcphdr *th;
 	__u32 seq;
 
-	if (skb_ensure_writable(skb, tcp_offset + sizeof(*th)))
+	if (skb_ensure_writable(skb, ipvsh->len + sizeof(*th)))
 		return 0;
 
-	th = (struct tcphdr *)(skb_network_header(skb) + tcp_offset);
+	th = (struct tcphdr *)(skb_network_header(skb) + ipvsh->len);
 
 	/*
 	 *	Remember seq number in case this pkt gets resized
@@ -438,14 +437,13 @@ static inline int app_tcp_pkt_in(struct ip_vs_conn *cp, struct sk_buff *skb,
 				 struct ip_vs_iphdr *ipvsh)
 {
 	int diff;
-	const unsigned int tcp_offset = ip_hdrlen(skb);
 	struct tcphdr *th;
 	__u32 seq;
 
-	if (skb_ensure_writable(skb, tcp_offset + sizeof(*th)))
+	if (skb_ensure_writable(skb, ipvsh->len + sizeof(*th)))
 		return 0;
 
-	th = (struct tcphdr *)(skb_network_header(skb) + tcp_offset);
+	th = (struct tcphdr *)(skb_network_header(skb) + ipvsh->len);
 
 	/*
 	 *	Remember seq number in case this pkt gets resized
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index 5b427349a257..c9c88c99d07b 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1219,8 +1219,7 @@ static int ip_vs_out_icmp_v6(struct netns_ipvs *ipvs, struct sk_buff *skb,
 	snet.in6 = ciph.saddr.in6;
 	offset = ciph.len;
 	return handle_response_icmp(AF_INET6, skb, &snet, ciph.protocol, cp,
-				    pp, offset, sizeof(struct ipv6hdr),
-				    hooknum);
+				    pp, offset, ipvsh->len, hooknum);
 }
 #endif
 
-- 
2.55.0



