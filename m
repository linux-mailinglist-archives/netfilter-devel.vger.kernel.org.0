Return-Path: <netfilter-devel+bounces-12097-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC07Fs+i5mmfzAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12097-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2026 00:03:59 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6267434765
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2026 00:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56644302C754
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 22:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80793D0908;
	Mon, 20 Apr 2026 22:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="ToVhpBxZ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB4D3CFF56;
	Mon, 20 Apr 2026 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722546; cv=none; b=N5s9KINPger9cHGCUUp1WUFn05SUfxzEIL4lnXyCK9QFT4e7zi4GHa29wDGEQ9eqYCS55DxYIUR8cAU0bX/IMtDGfTkYGnCJbllECjZbgo0XMgY3MWxMQWOlgfTE6hV1o/ySP8Y0jN25dFlXLOZCyPTS1OEyUUgF3JTs5w0TjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722546; c=relaxed/simple;
	bh=7q3VQOHclokl7NX2rALACwIZJuUkGnUzaCI0eYmDBLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=te1mXBsP3uN+cVtNoC0s3OihXOxHDv8IzioROty+U/+zwCKJkLP+DqjCAzrln9nCBAQvpcbs33locr9vRJ/H/2HMWpLJgNRha0UKA/enPfugUuWRLDBv4Z71Ae8yZySD2XUG1SEh87dNy47VeITVH5Rzt59JTRH16p9MW08ztWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=ToVhpBxZ; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 1A7F960263;
	Tue, 21 Apr 2026 00:02:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776722543;
	bh=QfjrvEMigLmW4gaPRVPEIkGuoJt1xZ0L/ydTlhts/NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ToVhpBxZl83mv5IBIShC6DK71eGo+xECsY3sY/9SBGDdVl7WHOJl8MqPyIEnoKcTs
	 wICZC/JRviANuLYHx4tsm5MjcElYm8WWumVQNU0UcWog/fXcOeulyDNL/tw/IrGOlm
	 S+tuHKGPI5ZnGV2qNilqISvfXPqa6VTsJ6xuE/zdwuiJB9knR00FZbSxTe3nO1E8m6
	 jXxMg2qK+G2hre1FLEMT69D6wVRwIeHVgWCQb+QK/OIbrLNiwNcQpjq3fvraFj8fDZ
	 Fv45vEssqHvxM7kU2KN9H7xfY0WRBUqC16vceGXKuYrfuYfG9jBUR22SFd1LeiVFgo
	 qFPqpAdGTNMoA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 3/8] netfilter: conntrack: remove sprintf usage
Date: Tue, 21 Apr 2026 00:02:10 +0200
Message-ID: <20260420220215.111510-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420220215.111510-1-pablo@netfilter.org>
References: <20260420220215.111510-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12097-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:email,netfilter.org:email,netfilter.org:dkim,netfilter.org:mid]
X-Rspamd-Queue-Id: C6267434765
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Florian Westphal <fw@strlen.de>

Replace it with scnprintf, the buffer sizes are expected to be large enough
to hold the result, no need for snprintf+overflow check.

Increase buffer size in mangle_content_len() while at it.

BUG: KASAN: stack-out-of-bounds in vsnprintf+0xea5/0x1270
Write of size 1 at addr [..]
 vsnprintf+0xea5/0x1270
 sprintf+0xb1/0xe0
 mangle_content_len+0x1ac/0x280
 nf_nat_sdp_session+0x1cc/0x240
 process_sdp+0x8f8/0xb80
 process_invite_request+0x108/0x2b0
 process_sip_msg+0x5da/0xf50
 sip_help_tcp+0x45e/0x780
 nf_confirm+0x34d/0x990
 [..]

Fixes: 9fafcd7b2032 ("[NETFILTER]: nf_conntrack/nf_nat: add SIP helper port")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_nat_amanda.c |  2 +-
 net/netfilter/nf_nat_sip.c    | 33 ++++++++++++++++++---------------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/net/netfilter/nf_nat_amanda.c b/net/netfilter/nf_nat_amanda.c
index 98deef6cde69..8f1054920a85 100644
--- a/net/netfilter/nf_nat_amanda.c
+++ b/net/netfilter/nf_nat_amanda.c
@@ -50,7 +50,7 @@ static unsigned int help(struct sk_buff *skb,
 		return NF_DROP;
 	}
 
-	sprintf(buffer, "%u", port);
+	snprintf(buffer, sizeof(buffer), "%u", port);
 	if (!nf_nat_mangle_udp_packet(skb, exp->master, ctinfo,
 				      protoff, matchoff, matchlen,
 				      buffer, strlen(buffer))) {
diff --git a/net/netfilter/nf_nat_sip.c b/net/netfilter/nf_nat_sip.c
index cf4aeb299bde..c845b6d1a2bd 100644
--- a/net/netfilter/nf_nat_sip.c
+++ b/net/netfilter/nf_nat_sip.c
@@ -68,25 +68,27 @@ static unsigned int mangle_packet(struct sk_buff *skb, unsigned int protoff,
 }
 
 static int sip_sprintf_addr(const struct nf_conn *ct, char *buffer,
+			    size_t size,
 			    const union nf_inet_addr *addr, bool delim)
 {
 	if (nf_ct_l3num(ct) == NFPROTO_IPV4)
-		return sprintf(buffer, "%pI4", &addr->ip);
+		return scnprintf(buffer, size, "%pI4", &addr->ip);
 	else {
 		if (delim)
-			return sprintf(buffer, "[%pI6c]", &addr->ip6);
+			return scnprintf(buffer, size, "[%pI6c]", &addr->ip6);
 		else
-			return sprintf(buffer, "%pI6c", &addr->ip6);
+			return scnprintf(buffer, size, "%pI6c", &addr->ip6);
 	}
 }
 
 static int sip_sprintf_addr_port(const struct nf_conn *ct, char *buffer,
+				 size_t size,
 				 const union nf_inet_addr *addr, u16 port)
 {
 	if (nf_ct_l3num(ct) == NFPROTO_IPV4)
-		return sprintf(buffer, "%pI4:%u", &addr->ip, port);
+		return scnprintf(buffer, size, "%pI4:%u", &addr->ip, port);
 	else
-		return sprintf(buffer, "[%pI6c]:%u", &addr->ip6, port);
+		return scnprintf(buffer, size, "[%pI6c]:%u", &addr->ip6, port);
 }
 
 static int map_addr(struct sk_buff *skb, unsigned int protoff,
@@ -119,7 +121,7 @@ static int map_addr(struct sk_buff *skb, unsigned int protoff,
 	if (nf_inet_addr_cmp(&newaddr, addr) && newport == port)
 		return 1;
 
-	buflen = sip_sprintf_addr_port(ct, buffer, &newaddr, ntohs(newport));
+	buflen = sip_sprintf_addr_port(ct, buffer, sizeof(buffer), &newaddr, ntohs(newport));
 	return mangle_packet(skb, protoff, dataoff, dptr, datalen,
 			     matchoff, matchlen, buffer, buflen);
 }
@@ -212,7 +214,7 @@ static unsigned int nf_nat_sip(struct sk_buff *skb, unsigned int protoff,
 					       &addr, true) > 0 &&
 		    nf_inet_addr_cmp(&addr, &ct->tuplehash[dir].tuple.src.u3) &&
 		    !nf_inet_addr_cmp(&addr, &ct->tuplehash[!dir].tuple.dst.u3)) {
-			buflen = sip_sprintf_addr(ct, buffer,
+			buflen = sip_sprintf_addr(ct, buffer, sizeof(buffer),
 					&ct->tuplehash[!dir].tuple.dst.u3,
 					true);
 			if (!mangle_packet(skb, protoff, dataoff, dptr, datalen,
@@ -229,7 +231,7 @@ static unsigned int nf_nat_sip(struct sk_buff *skb, unsigned int protoff,
 					       &addr, false) > 0 &&
 		    nf_inet_addr_cmp(&addr, &ct->tuplehash[dir].tuple.dst.u3) &&
 		    !nf_inet_addr_cmp(&addr, &ct->tuplehash[!dir].tuple.src.u3)) {
-			buflen = sip_sprintf_addr(ct, buffer,
+			buflen = sip_sprintf_addr(ct, buffer, sizeof(buffer),
 					&ct->tuplehash[!dir].tuple.src.u3,
 					false);
 			if (!mangle_packet(skb, protoff, dataoff, dptr, datalen,
@@ -247,7 +249,7 @@ static unsigned int nf_nat_sip(struct sk_buff *skb, unsigned int protoff,
 		    htons(n) == ct->tuplehash[dir].tuple.dst.u.udp.port &&
 		    htons(n) != ct->tuplehash[!dir].tuple.src.u.udp.port) {
 			__be16 p = ct->tuplehash[!dir].tuple.src.u.udp.port;
-			buflen = sprintf(buffer, "%u", ntohs(p));
+			buflen = scnprintf(buffer, sizeof(buffer), "%u", ntohs(p));
 			if (!mangle_packet(skb, protoff, dataoff, dptr, datalen,
 					   poff, plen, buffer, buflen)) {
 				nf_ct_helper_log(skb, ct, "cannot mangle rport");
@@ -418,7 +420,8 @@ static unsigned int nf_nat_sip_expect(struct sk_buff *skb, unsigned int protoff,
 
 	if (!nf_inet_addr_cmp(&exp->tuple.dst.u3, &exp->saved_addr) ||
 	    exp->tuple.dst.u.udp.port != exp->saved_proto.udp.port) {
-		buflen = sip_sprintf_addr_port(ct, buffer, &newaddr, port);
+		buflen = sip_sprintf_addr_port(ct, buffer, sizeof(buffer),
+					       &newaddr, port);
 		if (!mangle_packet(skb, protoff, dataoff, dptr, datalen,
 				   matchoff, matchlen, buffer, buflen)) {
 			nf_ct_helper_log(skb, ct, "cannot mangle packet");
@@ -438,8 +441,8 @@ static int mangle_content_len(struct sk_buff *skb, unsigned int protoff,
 {
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn *ct = nf_ct_get(skb, &ctinfo);
+	char buffer[sizeof("4294967295")];
 	unsigned int matchoff, matchlen;
-	char buffer[sizeof("65536")];
 	int buflen, c_len;
 
 	/* Get actual SDP length */
@@ -454,7 +457,7 @@ static int mangle_content_len(struct sk_buff *skb, unsigned int protoff,
 			      &matchoff, &matchlen) <= 0)
 		return 0;
 
-	buflen = sprintf(buffer, "%u", c_len);
+	buflen = scnprintf(buffer, sizeof(buffer), "%u", c_len);
 	return mangle_packet(skb, protoff, dataoff, dptr, datalen,
 			     matchoff, matchlen, buffer, buflen);
 }
@@ -491,7 +494,7 @@ static unsigned int nf_nat_sdp_addr(struct sk_buff *skb, unsigned int protoff,
 	char buffer[INET6_ADDRSTRLEN];
 	unsigned int buflen;
 
-	buflen = sip_sprintf_addr(ct, buffer, addr, false);
+	buflen = sip_sprintf_addr(ct, buffer, sizeof(buffer), addr, false);
 	if (mangle_sdp_packet(skb, protoff, dataoff, dptr, datalen,
 			      sdpoff, type, term, buffer, buflen))
 		return 0;
@@ -509,7 +512,7 @@ static unsigned int nf_nat_sdp_port(struct sk_buff *skb, unsigned int protoff,
 	char buffer[sizeof("nnnnn")];
 	unsigned int buflen;
 
-	buflen = sprintf(buffer, "%u", port);
+	buflen = scnprintf(buffer, sizeof(buffer), "%u", port);
 	if (!mangle_packet(skb, protoff, dataoff, dptr, datalen,
 			   matchoff, matchlen, buffer, buflen))
 		return 0;
@@ -529,7 +532,7 @@ static unsigned int nf_nat_sdp_session(struct sk_buff *skb, unsigned int protoff
 	unsigned int buflen;
 
 	/* Mangle session description owner and contact addresses */
-	buflen = sip_sprintf_addr(ct, buffer, addr, false);
+	buflen = sip_sprintf_addr(ct, buffer, sizeof(buffer), addr, false);
 	if (mangle_sdp_packet(skb, protoff, dataoff, dptr, datalen, sdpoff,
 			      SDP_HDR_OWNER, SDP_HDR_MEDIA, buffer, buflen))
 		return 0;
-- 
2.47.3


