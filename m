Return-Path: <netfilter-devel+bounces-13470-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sm7nANdkPWrQ2QgAu9opvQ
	(envelope-from <netfilter-devel+bounces-13470-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jun 2026 19:26:47 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D96B6C7C58
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jun 2026 19:26:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=carlosgrillet.me header.s=zmail header.b=FXZpcSSC;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13470-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13470-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F4783029250
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jun 2026 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111593EBF23;
	Thu, 25 Jun 2026 17:26:39 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4B3E2ABA;
	Thu, 25 Jun 2026 17:26:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408398; cv=pass; b=eRqiv/uaqL4LMNpQIPqv83xW+vk3ECqD8sfUovT9Z8L7FJR7FEpSQ7rCbSJSWOloiS7M7WxoOd3gq+XWXuacnWKBVmqVhVKvMv96D33staHju/QJrkUBzpMkNIfaiBv+VSiHBpHH6EtkQdwIvhaESHQi4mkcWM90EuVtM6Ru9qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408398; c=relaxed/simple;
	bh=Q8zxDNi/EjehTzh/2KoenWXg+wvxtwcqfPf024Tarcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlEpwHDQyl0QosY5xbd5sGvK9fZs+sr1FjgrRLYlRYBZNFm6Ap8HkKm1/DltmvyqVIzQOEVNZc44fFCPdXTm9PifF+eA8sN6EtJdyQbZyyk3JV0dxWLvFsHqQiLj72Np/ehM+XbwMdpqoecQA40+S+lvU5pF0MPW9OwfWQYsKDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carlosgrillet.me; spf=pass smtp.mailfrom=carlosgrillet.me; dkim=pass (1024-bit key) header.d=carlosgrillet.me header.i=carlos@carlosgrillet.me header.b=FXZpcSSC; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1782408373; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=KcEj2E01cUrpC7mxePrJewu2PavQIfY8Yr5zUblUZFnd2JLthr8WKIo1pi0uh+W/GtAIjeQ1SieW2ceMNEaBgt/VhzhAhH1cvgJVt0j8oDFeMA8/0GTzCFAB2v0BjZXiMFaEfz/CemUVGTGxTPiQp59ygU5Ahtcg6kQ0H20Ev7M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1782408373; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tjsqCk8XummZfBV9VHYmhW07fJViEagjkxcJggc8Kn8=; 
	b=gmgban/VIqx5JDIeYTz6y9RUuXPYlGQ/tB4hGOnr84DrfkdyT2iTHrhfaZkSbeMyOmSDgIsMKfiDK5OvMRBY7GwXxRSb4OZLIZY81tNh2ygoPVGybxLG2x6+2mzU3sHdYG1dzzZSdHJNWjuPOZeCM0aG5136nj9xyv//KZe/mG0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=carlosgrillet.me;
	spf=pass  smtp.mailfrom=carlos@carlosgrillet.me;
	dmarc=pass header.from=<carlos@carlosgrillet.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782408373;
	s=zmail; d=carlosgrillet.me; i=carlos@carlosgrillet.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tjsqCk8XummZfBV9VHYmhW07fJViEagjkxcJggc8Kn8=;
	b=FXZpcSSCVwut6coppWZYOXJE5iAi/c6Q0GWwZyFuIfLdwcrh4IKaMSSnIMv0xOsn
	FjpSUzAB2yIjWy6rjiZElJkm8K5w9tvE10Psepc91DQQiZxG4FNdosiQBu+WbT2N2hp
	6G4TY5oO5WEK0DXZXMEmPKx9FDqRgVhdNoreWWXY=
Received: by mx.zoho.eu with SMTPS id 1782408371297649.5848837070624;
	Thu, 25 Jun 2026 19:26:11 +0200 (CEST)
From: Carlos Grillet <carlos@carlosgrillet.me>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next v2 1/3] netfilter: nf_conntrack_h323_main: replace u_int8_t with u8
Date: Thu, 25 Jun 2026 19:25:46 +0200
Message-ID: <20260625172550.35781-2-carlos@carlosgrillet.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625172550.35781-1-carlos@carlosgrillet.me>
References: <20260625172550.35781-1-carlos@carlosgrillet.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[carlosgrillet.me];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13470-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[carlosgrillet.me:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[carlosgrillet.me:dkim,carlosgrillet.me:email,carlosgrillet.me:mid,carlosgrillet.me:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D96B6C7C58

Use preferred kernel integer type u8 instead of the POSIX u_int8_t
variant.

No functional change.

Signed-off-by: Carlos Grillet <carlos@carlosgrillet.me>
---
 net/netfilter/nf_conntrack_h323_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_h323_main.c b/net/netfilter/nf_conntrack_h323_main.c
index 7f189dceb3c4..68ecaf0daf95 100644
--- a/net/netfilter/nf_conntrack_h323_main.c
+++ b/net/netfilter/nf_conntrack_h323_main.c
@@ -671,7 +671,7 @@ static int expect_h245(struct sk_buff *skb, struct nf_conn *ct,
 static int callforward_do_filter(struct net *net,
 				 const union nf_inet_addr *src,
 				 const union nf_inet_addr *dst,
-				 u_int8_t family)
+				 u8 family)
 {
 	int ret = 0;
 
-- 
2.54.0


