Return-Path: <netfilter-devel+bounces-13288-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6OCrM9WWMWprngUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13288-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 20:32:53 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB126943B9
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 20:32:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=carlosgrillet.me header.s=zmail header.b=XCp6tkzQ;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13288-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13288-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91251320BDBC
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 18:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B770947CC62;
	Tue, 16 Jun 2026 18:30:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8111135AC3E;
	Tue, 16 Jun 2026 18:30:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634656; cv=pass; b=iN5N7/toQZwjg3nmJvpo7cCKtTd8lsenjFoUkUfHgydq54srrkXqCz+bjtLCmAb/50n6Wor6wDzmsXKsJ/WzRpqJ9dnO2RdyuhzjUPHpPGh9jJtTO3KMK1BPn4j+bPGc01VXb6z4w4ONAVrAwaISMicHQoN9XsYTYnwdRs1tEW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634656; c=relaxed/simple;
	bh=ngt+z5NZNP2bLxE1iGJFOZGpI8x5OafjofmlhPbgNfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mltUTL6ueGdjMYkcXnnWdly2BNkNeVpua1pXcOumABaQ7OLPzEfK4Orh1z/ps2eij0gSh0IuX1aLjt3hGqfk+VoAFl+78mwwFh3nyEkPfxIl/ldJMJ46qDufGBxoI7B91sFI6xDohXBO2ZFmh2H02hohSI3sUA3fRq1D+IMSESM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carlosgrillet.me; spf=pass smtp.mailfrom=carlosgrillet.me; dkim=pass (1024-bit key) header.d=carlosgrillet.me header.i=carlos@carlosgrillet.me header.b=XCp6tkzQ; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1781634629; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Nv00CGoCHuj10kw1mfB3kd08pWt4Ge0cexRfPI2nzVZFwfyV4LX+V32wAm9lKzvTe5+sJyP7eXORQaDoFmi5Pf06+uX253wBaxos+qnz9vY1DKxObsdi/ieJtAEibkKB3MK7hW5+mepaQVC/pyxNfuF0MDNQgCIEJZcsOJ2Dj4U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1781634629; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JPDMg/1vcqRmkkaVbSyViyubTh4oMaFo0jk8Xx+5uoQ=; 
	b=MPqaK3/vus4dmGK+NVediASbRa7MD6+kmr+v52IUEYv08ScE49VewgM9NvdKUipVsWT1AfxlgvI8v/VIuQ32w/97EeBwsTi2QQBCkJT4d8ZlRbPEUHTd2X2gixAuXs6sVENZMfJiHORNZrqeYjZZAMvC/h3FKpRO52ZLppP8w9k=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=carlosgrillet.me;
	spf=pass  smtp.mailfrom=carlos@carlosgrillet.me;
	dmarc=pass header.from=<carlos@carlosgrillet.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781634629;
	s=zmail; d=carlosgrillet.me; i=carlos@carlosgrillet.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JPDMg/1vcqRmkkaVbSyViyubTh4oMaFo0jk8Xx+5uoQ=;
	b=XCp6tkzQtd0apuYISsB0MV2uOo1YDbaOFoTfAHE7yDI8qICW3Jj1fQmzRFpGygwd
	KjNjGVlIFtobecwNs72RHbnjstdLs8yzRKR/hBinp8kF4HLwigKm2Cn9a8catDEwscG
	SrZ3XrLUKbxvvgnwNEz4iLtyDZ/4J798Tr7nGnLg=
Received: by mx.zoho.eu with SMTPS id 1781634627909242.72722566967752;
	Tue, 16 Jun 2026 20:30:27 +0200 (CEST)
From: Carlos Grillet <carlos@carlosgrillet.me>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next v3 4/4] netfilter: xt_TCPOPTSTRIP: replace u_int8_t and u_int16_t with u8 and u16
Date: Tue, 16 Jun 2026 20:29:46 +0200
Message-ID: <20260616182948.96865-5-carlos@carlosgrillet.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616182948.96865-1-carlos@carlosgrillet.me>
References: <20260616182948.96865-1-carlos@carlosgrillet.me>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[carlosgrillet.me:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13288-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	DMARC_NA(0.00)[carlosgrillet.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[carlosgrillet.me:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,carlosgrillet.me:dkim,carlosgrillet.me:email,carlosgrillet.me:mid,carlosgrillet.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BB126943B9

Replace POSIX u_int8_t/u_int16_t with preferred kernel types u8/u16

No functional changes.

Signed-off-by: Carlos Grillet <carlos@carlosgrillet.me>
---
 net/netfilter/xt_TCPOPTSTRIP.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/xt_TCPOPTSTRIP.c b/net/netfilter/xt_TCPOPTSTRIP.c
index 93f064306901..265d21697847 100644
--- a/net/netfilter/xt_TCPOPTSTRIP.c
+++ b/net/netfilter/xt_TCPOPTSTRIP.c
@@ -16,7 +16,7 @@
 #include <linux/netfilter/x_tables.h>
 #include <linux/netfilter/xt_TCPOPTSTRIP.h>
 
-static inline unsigned int optlen(const u_int8_t *opt, unsigned int offset)
+static inline unsigned int optlen(const u8 *opt, unsigned int offset)
 {
 	/* Beware zero-length options: make finite progress */
 	if (opt[offset] <= TCPOPT_NOP || opt[offset+1] == 0)
@@ -33,8 +33,8 @@ tcpoptstrip_mangle_packet(struct sk_buff *skb,
 	const struct xt_tcpoptstrip_target_info *info = par->targinfo;
 	struct tcphdr *tcph, _th;
 	unsigned int optl, i, j;
-	u_int16_t n, o;
-	u_int8_t *opt;
+	u16 n, o;
+	u8 *opt;
 	int tcp_hdrlen;
 
 	/* This is a fragment, no TCP header is available */
@@ -97,7 +97,7 @@ tcpoptstrip_tg6(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
 	int tcphoff;
-	u_int8_t nexthdr;
+	u8 nexthdr;
 	__be16 frag_off;
 
 	nexthdr = ipv6h->nexthdr;
-- 
2.54.0


