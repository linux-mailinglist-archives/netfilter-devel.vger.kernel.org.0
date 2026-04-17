Return-Path: <netfilter-devel+bounces-12007-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJEmGW994mnk6gAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12007-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 20:35:27 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC5441DFC9
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 20:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3233300D4C6
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 18:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB0635BDCA;
	Fri, 17 Apr 2026 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TEdlcIDD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kl+mtDOu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TEdlcIDD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kl+mtDOu"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C6534B19F
	for <netfilter-devel@vger.kernel.org>; Fri, 17 Apr 2026 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776450921; cv=none; b=RAFgoUpKkEDUJlk50Dsu5unbiT2aYGbX0KgvapB4oMRV3ob836mXxuhHhL7hUiQwJlmZt552cLS9WfslmGNTNZ7xdd5MJOFEqQKGMpIiu1IGXxlGxSvdfg1F1Fd8MhdpvIXxuceo70u+f2YTrLY5dRtUmwiA2k1tVnGjisSyuwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776450921; c=relaxed/simple;
	bh=izosyhxDTy5NdRy6ayhND//aGqiQP/TpllLGyLhTMRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/CetXs6nAmKxs9DkRSbI9Mw0Fof658WTiRCWGw4Vcl7fW8gjA2+Vq0Jj0DQ15cdU7pn1jxJevdE9KlQ8cgq3WqfQpJK/C1qvCNo3VL2MC///ZExMdwQP6jqJMloo1gOmo2xfA+eNMwDyBkGTjbmsqGGwi3KIlUuRjk0b3eaeGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TEdlcIDD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kl+mtDOu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TEdlcIDD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kl+mtDOu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DBA95BD6D;
	Fri, 17 Apr 2026 18:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776450918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWo1LFCwbN3YfhDdAcKt2Z9T6i6hL9z0LD165eTYsNY=;
	b=TEdlcIDDxHBeg5nIqChjwVFZh/HpQbqhJgu37yCGVHzQ6sYYsy3XMSU85OtRU8DxCyIt8u
	G6wLUmX2SkRco7ZVMR2tICHF3uepJoNLybNVl2TPHCmoCplsY3m/GQVtLWj5D14tDIfOjm
	VexypcFwKA/5jpuAikaHb3bZyixznoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776450918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWo1LFCwbN3YfhDdAcKt2Z9T6i6hL9z0LD165eTYsNY=;
	b=kl+mtDOunZIBz+KPc+2BTY0pIYHbTFaX6sm5lyMmtdaoKlF07Q1ppMZZcPId0f/j0v4rMe
	LhVAr5PedSY2ofDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776450918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWo1LFCwbN3YfhDdAcKt2Z9T6i6hL9z0LD165eTYsNY=;
	b=TEdlcIDDxHBeg5nIqChjwVFZh/HpQbqhJgu37yCGVHzQ6sYYsy3XMSU85OtRU8DxCyIt8u
	G6wLUmX2SkRco7ZVMR2tICHF3uepJoNLybNVl2TPHCmoCplsY3m/GQVtLWj5D14tDIfOjm
	VexypcFwKA/5jpuAikaHb3bZyixznoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776450918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWo1LFCwbN3YfhDdAcKt2Z9T6i6hL9z0LD165eTYsNY=;
	b=kl+mtDOunZIBz+KPc+2BTY0pIYHbTFaX6sm5lyMmtdaoKlF07Q1ppMZZcPId0f/j0v4rMe
	LhVAr5PedSY2ofDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7167593AE;
	Fri, 17 Apr 2026 18:35:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AGbtKWV94mmFFQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 17 Apr 2026 18:35:17 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netfilter-devel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	coreteam@netfilter.org,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 4/4 nf] netfilter: xtables: fix L4 header parsing for non-first fragments
Date: Fri, 17 Apr 2026 20:34:35 +0200
Message-ID: <20260417183433.4739-6-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417183433.4739-1-fmancera@suse.de>
References: <20260417183433.4739-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12007-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: 3AC5441DFC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The TPROXY target and osf match relies on L4 header to operate. For
fragmented packets, every fragment carries the transport protocol
identifier, but only the first fragment contains the L4 header.

As the 'raw' table can be configured to run at priority -450 (before
defragmentation at -400), the target/match can be reached before
reassembly. In this case, non-first fragments have their payload
incorrectly parsed as a TCP/UDP header.

Add a fragment check to ensure TPROXY/osf only evaluates unfragmented
packets or the first fragment in the stream.

Fixes: 902d6a4c2a4f ("netfilter: nf_defrag: Skip defrag if NOTRACK is set")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/netfilter/xt_TPROXY.c | 8 ++++++--
 net/netfilter/xt_osf.c    | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/xt_TPROXY.c b/net/netfilter/xt_TPROXY.c
index e4bea1d346cf..ac4b011ce48c 100644
--- a/net/netfilter/xt_TPROXY.c
+++ b/net/netfilter/xt_TPROXY.c
@@ -40,6 +40,9 @@ tproxy_tg4(struct net *net, struct sk_buff *skb, __be32 laddr, __be16 lport,
 	struct udphdr _hdr, *hp;
 	struct sock *sk;
 
+	if (ip_is_fragment(iph))
+		return NF_DROP;
+
 	hp = skb_header_pointer(skb, ip_hdrlen(skb), sizeof(_hdr), &_hdr);
 	if (hp == NULL)
 		return NF_DROP;
@@ -106,6 +109,7 @@ tproxy_tg6_v1(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
 	const struct xt_tproxy_target_info_v1 *tgi = par->targinfo;
+	unsigned short fragoff = 0;
 	struct udphdr _hdr, *hp;
 	struct sock *sk;
 	const struct in6_addr *laddr;
@@ -113,8 +117,8 @@ tproxy_tg6_v1(struct sk_buff *skb, const struct xt_action_param *par)
 	int thoff = 0;
 	int tproto;
 
-	tproto = ipv6_find_hdr(skb, &thoff, -1, NULL, NULL);
-	if (tproto < 0)
+	tproto = ipv6_find_hdr(skb, &thoff, -1, &fragoff, NULL);
+	if (tproto < 0 || fragoff)
 		return NF_DROP;
 
 	hp = skb_header_pointer(skb, thoff, sizeof(_hdr), &_hdr);
diff --git a/net/netfilter/xt_osf.c b/net/netfilter/xt_osf.c
index dc9485854002..889dff4daff0 100644
--- a/net/netfilter/xt_osf.c
+++ b/net/netfilter/xt_osf.c
@@ -27,6 +27,9 @@
 static bool
 xt_osf_match_packet(const struct sk_buff *skb, struct xt_action_param *p)
 {
+	if (ip_is_fragment(ip_hdr(skb)))
+		return false;
+
 	return nf_osf_match(skb, xt_family(p), xt_hooknum(p), xt_in(p),
 			    xt_out(p), p->matchinfo, xt_net(p), nf_osf_fingers);
 }
-- 
2.53.0


