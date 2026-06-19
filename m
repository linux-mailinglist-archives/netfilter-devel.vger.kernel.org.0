Return-Path: <netfilter-devel+bounces-13353-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pWsXHcIuNWqHoAYAu9opvQ
	(envelope-from <netfilter-devel+bounces-13353-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jun 2026 13:57:54 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B0F6A58D2
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jun 2026 13:57:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=lbj6Fx4O;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13353-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13353-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C67183026E88
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jun 2026 11:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7FD385D82;
	Fri, 19 Jun 2026 11:55:17 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9683859F9;
	Fri, 19 Jun 2026 11:55:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870117; cv=none; b=nIBViop//2o5w7/hpb2PNC1T6tvbUV8bp1+CQK9FUzvtUpzss/P4B7s2e1P6T10fkn1pG2GVqgYrHdjG2wHX0G2ImzGUWAYdQI32cJgVj8KcM7fX0+uWYNRVl3uMWH0ugOvHqTXRZw6usTSq+z41+e/7P+oxgY5zBBAQC9sKFaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870117; c=relaxed/simple;
	bh=k0+DmN2Twec3o4nbr0azlmPkFevxgpDWbOC8tWda470=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLpQz3U9lrWTr7N67e/xV521PZeXU+R5Q0Ak7OOueMxtZG05UgmICxwh3Wm8ZPWhzeSNZ3DtrwEfnLbv/3pZq9r+CWvEOqRkj0uVECezIVNjh4Ulbeo/zfEg2lqYtaixpjQmhZV+YhG/sQRPmeDDNj1ji/egT3ob7TbCJhSxon0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=lbj6Fx4O; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id DE13D60196;
	Fri, 19 Jun 2026 13:55:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781870114;
	bh=bz8ud+BrLrB1cv+fCtki3n0k7zcth4plrPUSLRFy9Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbj6Fx4OOGsvBlTeDuXByp82D6eD7FmecqvS9I/4lEncBRRdd9nnTB0vHUDtMbyWc
	 Q9qZGw8ICSz5hC50Rfjk6VIZ1h+NH2QaO4hYF3OaxAX844nbsUOmpIqd9YMgjJifm0
	 c80Y31DmTqFtrVzq3q9cmwCflpEx7G4jfdgdOdl1kYm2jk2zp2A8V8ugg5fOlIUDpy
	 nlR799YlH+3wEINvL+SNH/RQCttneKXqvAvs84UO3JovO5DprIzBl8PxS8R2KqtCkn
	 PsoolHxC6oVb/NP+UA/GgHYKJtAukNtpQoxxt11Eqel9R+s6ShSRg5bEhwG8sa3YNQ
	 eRXQynR/uDBkg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 13/16] netfilter: nf_reject: skip iphdr options when looking for icmp header
Date: Fri, 19 Jun 2026 13:54:48 +0200
Message-ID: <20260619115452.93949-14-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619115452.93949-1-pablo@netfilter.org>
References: <20260619115452.93949-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13353-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime,strlen.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64B0F6A58D2

From: Florian Westphal <fw@strlen.de>

Not a big deal but this hould have used the real ip header length and not the
base header size.  As-is, if there are options then
nf_skb_is_icmp_unreach() result will be random.

Fixes: db99b2f2b3e2 ("netfilter: nf_reject: don't reply to icmp error messages")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/ipv4/netfilter/nf_reject_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index fecf6621f679..4626dc46808f 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -89,7 +89,7 @@ static bool nf_skb_is_icmp_unreach(const struct sk_buff *skb)
 	if (iph->protocol != IPPROTO_ICMP)
 		return false;
 
-	thoff = skb_network_offset(skb) + sizeof(*iph);
+	thoff = skb_network_offset(skb) + ip_hdrlen(skb);
 
 	tp = skb_header_pointer(skb,
 				thoff + offsetof(struct icmphdr, type),
-- 
2.47.3


