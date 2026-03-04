Return-Path: <netfilter-devel+bounces-10953-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCoQGpccqGmYoAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10953-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 12:50:47 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F951FF4C0
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 12:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2593C303D665
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Mar 2026 11:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0E138C2BD;
	Wed,  4 Mar 2026 11:49:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A56F3ACEE7;
	Wed,  4 Mar 2026 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624982; cv=none; b=LrX6P58p1tplcKtTor48ROyfcHFzZPLFHNBTm/8elVGORZZpGy8ZElcSIN2IBm7wba4TgPoIF1gNTzpqBu4HzOyBezYwn6Of+9uvpfE2/6OyKOFqRskNq5B4UtnD37FTloU35sLBK7yeMtK0kIHpaKj28xbwYasPp/S0DgD/PCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624982; c=relaxed/simple;
	bh=fFykOyBM0Jx1zFEUpEvUNzOWuz4QDvTdxu6HtjO5UZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCPhEdpsdEjkf3PEHeQ87SA8mhf585IZm4qBhvcUIxb0PjkE1LAooqYF6CUkjm8nXkl60eX8lVbGh7YwIZGYRz4ZYesu6wdHpf8RB0+KTXA42jwNFaH2JxsHTa1O9x4DyA61H1Xm+H8SbK5EKxbC6XmufP//BSF3KrABchqIZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B64966026E; Wed, 04 Mar 2026 12:49:38 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 02/14] ipv6: make ipv6_anycast_destination logic usable without dst_entry
Date: Wed,  4 Mar 2026 12:49:09 +0100
Message-ID: <20260304114921.31042-3-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304114921.31042-1-fw@strlen.de>
References: <20260304114921.31042-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 04F951FF4C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10953-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

nft_fib_ipv6 uses ipv6_anycast_destination(), but upcoming patch removes
the dst_entry usage in favor of fib6_result.

Move the 'plen > 127' logic to a new helper and call it from the
existing one.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/ip6_route.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index a55f9bf95fe3..0c8eeb6abe7a 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -252,15 +252,22 @@ static inline bool ipv6_unicast_destination(const struct sk_buff *skb)
 	return rt->rt6i_flags & RTF_LOCAL;
 }
 
+static inline bool __ipv6_anycast_destination(const struct rt6key *rt6i_dst,
+					      u32 rt6i_flags,
+					      const struct in6_addr *daddr)
+{
+	return rt6i_flags & RTF_ANYCAST ||
+	       (rt6i_dst->plen < 127 &&
+	       !(rt6i_flags & (RTF_GATEWAY | RTF_NONEXTHOP)) &&
+	       ipv6_addr_equal(&rt6i_dst->addr, daddr));
+}
+
 static inline bool ipv6_anycast_destination(const struct dst_entry *dst,
 					    const struct in6_addr *daddr)
 {
 	const struct rt6_info *rt = dst_rt6_info(dst);
 
-	return rt->rt6i_flags & RTF_ANYCAST ||
-		(rt->rt6i_dst.plen < 127 &&
-		 !(rt->rt6i_flags & (RTF_GATEWAY | RTF_NONEXTHOP)) &&
-		 ipv6_addr_equal(&rt->rt6i_dst.addr, daddr));
+	return __ipv6_anycast_destination(&rt->rt6i_dst, rt->rt6i_flags, daddr);
 }
 
 int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
-- 
2.52.0


