Return-Path: <netfilter-devel+bounces-12038-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEFRG8kF5mkIqgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12038-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 12:54:01 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4CE429A1D
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 12:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1873E30048E9
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 10:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F4A3890E5;
	Mon, 20 Apr 2026 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VPRcIsxF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0pevoeGf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VPRcIsxF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0pevoeGf"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7B2BE05E
	for <netfilter-devel@vger.kernel.org>; Mon, 20 Apr 2026 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682120; cv=none; b=S0Kr1b3dgfaSkL87jLrFM7t3bcg6bVXWyn/wP9nqrKuvIcg0d2hUcjsFevjrAPnBtIt/4vOkeV9I37W3lgFeoNaYntUYkqt3jIaxHwj/Z9Rd3hp2nOud5ci07kA74Fv2RAKnvXD8yiZPFAnPwNYzRgwKDhl+augwEAAe2ZUVwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682120; c=relaxed/simple;
	bh=nOsNaff3MEdUO6nQdwoCMXHlYHz+jAD0iAqI/OpEFsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9EGvscybu8mbFw69DDmAin3qStizq3klo6N6p4ukTt6SEnIMkVDXz5TUd3x+gGR6bF6dw8ao4ty9rvwb2Ltl95qSAONCS3ytD4uSfGVfTcBU5+IDfhhPtKfWX6JO19vB6X8OJzvXB9nEErizT4bO1js3GNDNcDzf0MlfPHw9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VPRcIsxF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0pevoeGf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VPRcIsxF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0pevoeGf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3180B5BCFB;
	Mon, 20 Apr 2026 10:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776682117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsmWKgBEdsaNgrsUJLHuHpT56+lMxN5eht4XrSEWbt8=;
	b=VPRcIsxFkQux85IMEDI4O90nt6GDV1f4h21gl+Ewqb5AmNYjm0Vx/RPzzAi25Vm0Pu7P6v
	FIUHFrfSfq1q4fbFb0AqC+fWkZU1WUZ6J1hRePOfnAwGBcNPGyY77bqCKuevIh/plFtFWS
	7FJazSQAoMDaaPHQfZ3cg7kNPyvQnWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776682117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsmWKgBEdsaNgrsUJLHuHpT56+lMxN5eht4XrSEWbt8=;
	b=0pevoeGfZXH4IlGEkEso4BWdg+pVEMmvRihks1yl0RRrZarxA8Z70KRBR2kRac/1HlBqq2
	qiFtJZ2Ws4FT2ACg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776682117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsmWKgBEdsaNgrsUJLHuHpT56+lMxN5eht4XrSEWbt8=;
	b=VPRcIsxFkQux85IMEDI4O90nt6GDV1f4h21gl+Ewqb5AmNYjm0Vx/RPzzAi25Vm0Pu7P6v
	FIUHFrfSfq1q4fbFb0AqC+fWkZU1WUZ6J1hRePOfnAwGBcNPGyY77bqCKuevIh/plFtFWS
	7FJazSQAoMDaaPHQfZ3cg7kNPyvQnWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776682117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsmWKgBEdsaNgrsUJLHuHpT56+lMxN5eht4XrSEWbt8=;
	b=0pevoeGfZXH4IlGEkEso4BWdg+pVEMmvRihks1yl0RRrZarxA8Z70KRBR2kRac/1HlBqq2
	qiFtJZ2Ws4FT2ACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B28A2593AE;
	Mon, 20 Apr 2026 10:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KEuqKIQE5mkFFgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 20 Apr 2026 10:48:36 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org,
	ecklm94@gmail.com,
	phil@nwl.cc,
	fw@strlen.de,
	pablo@netfilter.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/2 nf v2] netfilter: xtables: fix L4 header parsing for non-first fragments
Date: Mon, 20 Apr 2026 12:47:45 +0200
Message-ID: <20260420104745.10338-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260420104745.10338-1-fmancera@suse.de>
References: <20260420104745.10338-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[netfilter.org,gmail.com,nwl.cc,strlen.de,suse.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12038-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BC4CE429A1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Multiple targets and matches relies on L4 header to operate. For
fragmented packets, every fragment carries the transport protocol
identifier, but only the first fragment contains the L4 header.

As the 'raw' table can be configured to run at priority -450 (before
defragmentation at -400), the target/match can be reached before
reassembly. In this case, non-first fragments have their payload
incorrectly parsed as a TCP/UDP header. This would be of course a
misconfiguration scenario. In most of the cases this just lead to a
unreliable behavior for fragmented traffic.

Add a fragment check to ensure target/match only evaluates unfragmented
packets or the first fragment in the stream.

Fixes: 902d6a4c2a4f ("netfilter: nf_defrag: Skip defrag if NOTRACK is set")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: handled ecn, socket and tcpmss matches
---
 net/netfilter/xt_TPROXY.c | 11 +++++++++--
 net/netfilter/xt_ecn.c    |  3 +++
 net/netfilter/xt_osf.c    |  3 +++
 net/netfilter/xt_socket.c | 10 ++++++++--
 net/netfilter/xt_tcpmss.c |  3 +++
 5 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/xt_TPROXY.c b/net/netfilter/xt_TPROXY.c
index e4bea1d346cf..5f60e7298a1e 100644
--- a/net/netfilter/xt_TPROXY.c
+++ b/net/netfilter/xt_TPROXY.c
@@ -86,6 +86,9 @@ tproxy_tg4_v0(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	const struct xt_tproxy_target_info *tgi = par->targinfo;
 
+	if (par->fragoff)
+		return NF_DROP;
+
 	return tproxy_tg4(xt_net(par), skb, tgi->laddr, tgi->lport,
 			  tgi->mark_mask, tgi->mark_value);
 }
@@ -95,6 +98,9 @@ tproxy_tg4_v1(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	const struct xt_tproxy_target_info_v1 *tgi = par->targinfo;
 
+	if (par->fragoff)
+		return NF_DROP;
+
 	return tproxy_tg4(xt_net(par), skb, tgi->laddr.ip, tgi->lport,
 			  tgi->mark_mask, tgi->mark_value);
 }
@@ -106,6 +112,7 @@ tproxy_tg6_v1(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
 	const struct xt_tproxy_target_info_v1 *tgi = par->targinfo;
+	unsigned short fragoff = 0;
 	struct udphdr _hdr, *hp;
 	struct sock *sk;
 	const struct in6_addr *laddr;
@@ -113,8 +120,8 @@ tproxy_tg6_v1(struct sk_buff *skb, const struct xt_action_param *par)
 	int thoff = 0;
 	int tproto;
 
-	tproto = ipv6_find_hdr(skb, &thoff, -1, NULL, NULL);
-	if (tproto < 0)
+	tproto = ipv6_find_hdr(skb, &thoff, -1, &fragoff, NULL);
+	if (tproto < 0 || fragoff)
 		return NF_DROP;
 
 	hp = skb_header_pointer(skb, thoff, sizeof(_hdr), &_hdr);
diff --git a/net/netfilter/xt_ecn.c b/net/netfilter/xt_ecn.c
index b96e8203ac54..cd97c2fac6e7 100644
--- a/net/netfilter/xt_ecn.c
+++ b/net/netfilter/xt_ecn.c
@@ -30,6 +30,9 @@ static bool match_tcp(const struct sk_buff *skb, struct xt_action_param *par)
 	struct tcphdr _tcph;
 	const struct tcphdr *th;
 
+	if (par->fragoff)
+		return false;
+
 	/* In practice, TCP match does this, so can't fail.  But let's
 	 * be good citizens.
 	 */
diff --git a/net/netfilter/xt_osf.c b/net/netfilter/xt_osf.c
index dc9485854002..e8807caede68 100644
--- a/net/netfilter/xt_osf.c
+++ b/net/netfilter/xt_osf.c
@@ -27,6 +27,9 @@
 static bool
 xt_osf_match_packet(const struct sk_buff *skb, struct xt_action_param *p)
 {
+	if (p->fragoff)
+		return false;
+
 	return nf_osf_match(skb, xt_family(p), xt_hooknum(p), xt_in(p),
 			    xt_out(p), p->matchinfo, xt_net(p), nf_osf_fingers);
 }
diff --git a/net/netfilter/xt_socket.c b/net/netfilter/xt_socket.c
index 76e01f292aaf..d366e294f1aa 100644
--- a/net/netfilter/xt_socket.c
+++ b/net/netfilter/xt_socket.c
@@ -55,8 +55,11 @@ socket_match(const struct sk_buff *skb, struct xt_action_param *par,
 	if (sk && !net_eq(xt_net(par), sock_net(sk)))
 		sk = NULL;
 
-	if (!sk)
+	if (!sk) {
+		if (par->fragoff)
+			return false;
 		sk = nf_sk_lookup_slow_v4(xt_net(par), skb, xt_in(par));
+	}
 
 	if (sk) {
 		bool wildcard;
@@ -116,8 +119,11 @@ socket_mt6_v1_v2_v3(const struct sk_buff *skb, struct xt_action_param *par)
 	if (sk && !net_eq(xt_net(par), sock_net(sk)))
 		sk = NULL;
 
-	if (!sk)
+	if (!sk) {
+		if (par->fragoff)
+			return false;
 		sk = nf_sk_lookup_slow_v6(xt_net(par), skb, xt_in(par));
+	}
 
 	if (sk) {
 		bool wildcard;
diff --git a/net/netfilter/xt_tcpmss.c b/net/netfilter/xt_tcpmss.c
index 0d32d4841cb3..69844cc8dbb8 100644
--- a/net/netfilter/xt_tcpmss.c
+++ b/net/netfilter/xt_tcpmss.c
@@ -32,6 +32,9 @@ tcpmss_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	u8 _opt[15 * 4 - sizeof(_tcph)];
 	unsigned int i, optlen;
 
+	if (par->fragoff)
+		return false;
+
 	/* If we don't have the whole header, drop packet. */
 	th = skb_header_pointer(skb, par->thoff, sizeof(_tcph), &_tcph);
 	if (th == NULL)
-- 
2.53.0


