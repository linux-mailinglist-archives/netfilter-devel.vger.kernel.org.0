Return-Path: <netfilter-devel+bounces-10898-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNKYLWCroGlGlgQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10898-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Feb 2026 21:21:52 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF7D1AF071
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Feb 2026 21:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E83830022F5
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Feb 2026 20:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09978466B6F;
	Thu, 26 Feb 2026 20:21:47 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F6466B65
	for <netfilter-devel@vger.kernel.org>; Thu, 26 Feb 2026 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137306; cv=none; b=YyojJyQ6OaI7H42WbTYhtcs36FPoHKQMtAeFTMqGMmvmYBvSjTU6OC7PNN6tRYBT54h3fjgeuO0MiWrUhS3flvCBtOMnTBBK8QTgUCZe9AQlfZnNkhbmISCrd2YyIzH70howl8gd/Dt2svf3xwc5weRtTW/Fcq9bwIHCh4PN2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137306; c=relaxed/simple;
	bh=sERXavQtOQ1ps0sCix2PfRW7N6eUE8rETWhJnJAWLDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMNDrpioN3YrEq7RInCLVBpXW8rzvEla8x5Q7rQc+SbGWG3iZr+h0jPQKJKhFZh0bn7wmYKagyyqhdbaSPJjN3F9Uy2QAQc9gXFhd6gzQrFOBKMxcHsz6KLH9DzcojnVyeIEW+sdWeB+f69N3pEJ8ONSmZwTO984cDEb3L+g4Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8944760336; Thu, 26 Feb 2026 21:21:44 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v2 2/3] ipv6: make ipv6_anycast_destination logic useable without dst_entry
Date: Thu, 26 Feb 2026 21:21:25 +0100
Message-ID: <20260226202129.15033-3-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226202129.15033-1-fw@strlen.de>
References: <20260226202129.15033-1-fw@strlen.de>
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
	TAGGED_FROM(0.00)[bounces-10898-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CF7D1AF071
X-Rspamd-Action: no action

nft_fib_ipv6 uses ipv6_anycast_destination(), but upcoming patch removes
the dst_entry usage in favor of fib6_result.

Move the 'plen > 127' logic to a new helper and call it from the
existing one.
---
 v2: new in this series.

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


