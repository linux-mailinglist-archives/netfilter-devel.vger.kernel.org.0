Return-Path: <netfilter-devel+bounces-13276-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uPZaNn0BMGqoLgUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13276-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2026 15:43:25 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37848686D4E
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2026 15:43:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=carlosgrillet.me header.s=zmail header.b="EboNm/7a";
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13276-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13276-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B62030CBBA5
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2026 13:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871C33F823A;
	Mon, 15 Jun 2026 13:39:36 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A432B29B764;
	Mon, 15 Jun 2026 13:39:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530776; cv=pass; b=urtOCrVlXIfntPXGylWCjBh4sQ1U2lL/bZGr1cSoglK1HihO8pWuVN2bI4gVW3RiFs8kBhiUViexHABWFswBiQ92p8hhuazByfDnNfhCqUaUnIZGRhn3a+rvAPUcl9TosfOFAhvmPyDOjsTJaIy2Pq5HfpJif3VAIfymplZcZM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530776; c=relaxed/simple;
	bh=ngt+z5NZNP2bLxE1iGJFOZGpI8x5OafjofmlhPbgNfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taMR//lBBFGdwFvky9SATn3pV0G0X0WTgkAhZ8SpZBfohsWFOlYk8X4udVyX9U9MnUE6kSLH7DR8eF0pCgXSP1HoqGmZI8MhJJPJP7M6tP+G1DyigJgEhMKEAvpyKWDKi3pcAeySZycvreIFZ9Ibk87STkNCzeonXUgpIhAb7GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carlosgrillet.me; spf=pass smtp.mailfrom=carlosgrillet.me; dkim=pass (1024-bit key) header.d=carlosgrillet.me header.i=carlos@carlosgrillet.me header.b=EboNm/7a; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1781530751; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=PTdOoEa//a9kswSaVWerXeKW/FRH7o79vJvT14EOiPc37FRAD90KCL1LubCaj/YKzDsK2XYSV8D248Yi0wpCZrllv2XGpGgz0gnGv9/Q/02iG3uDR5egDO++COTXtI0gTV1aHva2q+DU6YMA20gV2L6b+4khdWSVzyOJdwTYQ1U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1781530751; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JPDMg/1vcqRmkkaVbSyViyubTh4oMaFo0jk8Xx+5uoQ=; 
	b=lZdK+TlI6e6e7g5fKFH8ou3NL0ndf0uxAMKkwuPWrCrR3bArtAwC3ZuzyowpYRoGbgphUe11K6I4h+Hchapa1neNvIWLx+7ayS/mVUU6Isatntli/PeZcVMUw+sx7Eaovi4vJDgihTwmOdij87o4TOYgE/KjU1yrrwPyKcmoO4Y=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=carlosgrillet.me;
	spf=pass  smtp.mailfrom=carlos@carlosgrillet.me;
	dmarc=pass header.from=<carlos@carlosgrillet.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781530751;
	s=zmail; d=carlosgrillet.me; i=carlos@carlosgrillet.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JPDMg/1vcqRmkkaVbSyViyubTh4oMaFo0jk8Xx+5uoQ=;
	b=EboNm/7aONrDN7WutujFlaZyz9+HqK3Do2BA5t1vX7TmVBjdeyCI6bMfRyQUko6k
	xEsoKilJzS4Vwh+EZDxyTlbb78pjqSLqzL7c/CHKl72Ld9l9TdSX8XbFvCZFqXNwWIU
	3v6Cx0sBzlea9TLS6+UWameZZrcHhGZLciC21x6M=
Received: by mx.zoho.eu with SMTPS id 1781530748585546.7941245997127;
	Mon, 15 Jun 2026 15:39:08 +0200 (CEST)
From: Carlos Grillet <carlos@carlosgrillet.me>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next v2 5/6] netfilter: xt_TCPOPTSTRIP: replace u_int8_t and u_int16_t with u8 and u16
Date: Mon, 15 Jun 2026 15:38:30 +0200
Message-ID: <20260615133835.51273-6-carlos@carlosgrillet.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615133835.51273-1-carlos@carlosgrillet.me>
References: <20260615133835.51273-1-carlos@carlosgrillet.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[carlosgrillet.me];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13276-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,carlosgrillet.me:dkim,carlosgrillet.me:email,carlosgrillet.me:mid,carlosgrillet.me:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37848686D4E

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


