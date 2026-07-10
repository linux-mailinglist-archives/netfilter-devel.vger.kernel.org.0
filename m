Return-Path: <netfilter-devel+bounces-13832-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PR5PFTgFUWpB+AIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13832-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 16:44:08 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1A873BDBF
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 16:44:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13832-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13832-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0645E307ED9B
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317CD399368;
	Fri, 10 Jul 2026 14:38:00 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8169A395AF2;
	Fri, 10 Jul 2026 14:37:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694280; cv=none; b=pO2G+t4rxCQXH90SWPoOdDApuolR+rmizI28vMTwLFLNTVTTEfHdiDsqL471DxHUQgIX2kC83h0KYX7fwmeKmPbtd+J7KXG1lx0Bh4QsVzILYi0Q8+99om3ZfJqdtjLZJA97AY74Ya0FAq7w+DhZhlAzLbu8m/F8VmWTdAQuV18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694280; c=relaxed/simple;
	bh=/Ctx3z1mNapdwHFWdi6evZ+I2Pcur1bztsXZU79kmKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eV7F20/oWyo/bUMavPdXOkXlAnH8nNGAGFcXeCvr2650oNjcGfo4YqewaJSDcFfrx0IBR2NuAWlvamU/CnGXUob4ikbI/xnKhAl7c8RT6ZlJnsZxqLUXJw3/24+ibHNI71R2IrwnRrvhiHn+ZpFEYQxnC6HNoECvYWDf4ipHyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 94624605B5; Fri, 10 Jul 2026 16:37:55 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 3/9] netfilter: bridge: fix stale prevhdr pointer in br_ip6_fragment()
Date: Fri, 10 Jul 2026 16:37:27 +0200
Message-ID: <20260710143733.29741-4-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710143733.29741-1-fw@strlen.de>
References: <20260710143733.29741-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13832-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:from_mime,strlen.de:email,strlen.de:mid,vger.kernel.org:from_smtp,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C1A873BDBF

From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>

br_ip6_fragment() gets prevhdr, a pointer into the skb head, from
ip6_find_1stfragopt(), then calls skb_checksum_help().  For a cloned skb
skb_checksum_help() reallocates the head via pskb_expand_head(), leaving
prevhdr dangling.  It is later dereferenced in ip6_frag_next(), causing a
use-after-free write.

Save prevhdr's offset before skb_checksum_help() and recompute it after,
like commit ef0efcd3bd3f ("ipv6: Fix dangling pointer when ipv6
fragment").

  BUG: KASAN: slab-use-after-free in ip6_frag_next (net/ipv6/ip6_output.c:857)
  Write of size 1 at addr ffff888013ff5016 by task exploit/141
  Call Trace:
   ...
   kasan_report (mm/kasan/report.c:595)
   ip6_frag_next (net/ipv6/ip6_output.c:857)
   br_ip6_fragment (net/ipv6/netfilter.c:212)
   nf_ct_bridge_post (net/bridge/netfilter/nf_conntrack_bridge.c:407)
   nf_hook_slow (net/netfilter/core.c:619)
   br_forward_finish (net/bridge/br_forward.c:66)
   __br_forward (net/bridge/br_forward.c:115)
   maybe_deliver (net/bridge/br_forward.c:191)
   br_flood (net/bridge/br_forward.c:245)
   br_handle_frame_finish (net/bridge/br_input.c:229)
   br_handle_frame (net/bridge/br_input.c:442)
   ...
   packet_sendmsg (net/packet/af_packet.c:3114)
   ...
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: 764dd163ac92 ("netfilter: nf_conntrack_bridge: add support for IPv6")
Cc: stable@vger.kernel.org
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv6/netfilter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 6d80f85e55fa..a7025ec87035 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -120,7 +120,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	ktime_t tstamp = skb->tstamp;
 	struct ip6_frag_state state;
 	u8 *prevhdr, nexthdr = 0;
-	unsigned int mtu, hlen;
+	unsigned int mtu, hlen, nexthdr_offset;
 	int hroom, err = 0;
 	__be32 frag_id;
 
@@ -129,6 +129,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		goto blackhole;
 	hlen = err;
 	nexthdr = *prevhdr;
+	nexthdr_offset = prevhdr - skb_network_header(skb);
 
 	mtu = skb->dev->mtu;
 	if (frag_max_size > mtu ||
@@ -147,6 +148,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	    (err = skb_checksum_help(skb)))
 		goto blackhole;
 
+	prevhdr = skb_network_header(skb) + nexthdr_offset;
 	hroom = LL_RESERVED_SPACE(skb->dev);
 	if (skb_has_frag_list(skb)) {
 		unsigned int first_len = skb_pagelen(skb);
-- 
2.54.0


