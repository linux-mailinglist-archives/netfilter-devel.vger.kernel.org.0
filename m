Return-Path: <netfilter-devel+bounces-11104-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKn5HYySsGkukgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11104-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 22:52:12 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B3825882D
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 22:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63CD430F8411
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 21:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B187245005;
	Tue, 10 Mar 2026 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johannes-moeller.dev header.i=@johannes-moeller.dev header.b="vnOfhVHU"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9A41EE033
	for <netfilter-devel@vger.kernel.org>; Tue, 10 Mar 2026 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179363; cv=none; b=fiGDfEh0MdUv7V5yWceOWJ8SXRWg8T2S7Jlm2prBEZatN3GsR0ExDIQFCltZlJGCZ5a22ORkqmN5aGmHA7+zYoEzsawapcGgG4FHPwe1biCJnTyIy9cLRrTLbk0r/GmQQkHppLyLqf4Ep2gYnnRhnwRP6FCo9m1xTosfn4Feh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179363; c=relaxed/simple;
	bh=hYH8Z9qW6L7Pv4SzbvmBYP473SK0UCSUn2tmsDcH0U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GgvtBuGDbEBmO6aOdVwTwRP89adCwImqt5b5bRWODBZo+h/cFbFJfRFoM776nVrxgUKkf7/7WmmaYk8nNyJdefUeZNwC5paBhPu7dtT9gwo3ZDNmqGXTQQPQTmaDxJDJ/bwrrhMGH1Ph26df/06H2cBEmdQ/BJ4ZtTnKhdLEJog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johannes-moeller.dev; spf=pass smtp.mailfrom=johannes-moeller.dev; dkim=pass (2048-bit key) header.d=johannes-moeller.dev header.i=@johannes-moeller.dev header.b=vnOfhVHU; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johannes-moeller.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johannes-moeller.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=johannes-moeller.dev; s=protonmail; t=1773179353; x=1773438553;
	bh=QF6qc+aNL5LpCNRDF2PTtarXrsxuPHhlrVLr96bSGbU=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=vnOfhVHUvAiy2histAJ+80dVFzXEtocqUXWxLq4KchhkEKC+OS3luB8dNZU7UHpV3
	 ZTS+301I9vGi2/py6FZjWgyL2TvJDov+cRinogM4CFXg7Vl/Q0ZcozwDZYVhBH3OsB
	 YJ/r04AIJ/LxO75i1/Zx3dF8VgEU4V+dzyUPk06xWzBi9rXerbnHUsSLFpXbSNeo+d
	 /TV3oD+M23tosE7SNctpo/xWImLzFZCor953EfIbPTgvUnAtMJublpgoXpRJUxM3De
	 k9yqb6elBFXEwk9J/sDbXI4AMo+fFD5Pj+aYsusD5JyyDxtbJP9NaXZcIAYHrA5EW6
	 o2jZ2wiucMovQ==
X-Pm-Submission-Id: 4fVnZw1crNz2ScPP
From: =?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>
To: netfilter-devel@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	=?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>,
	stable@vger.kernel.org
Subject: [PATCH] netfilter: nf_conntrack_sip: fix Content-Length u32 truncation in sip_help_tcp()
Date: Tue, 10 Mar 2026 21:49:01 +0000
Message-ID: <20260310214901.71422-1-research@johannes-moeller.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D7B3825882D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[johannes-moeller.dev:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[johannes-moeller.dev];
	TAGGED_FROM(0.00)[bounces-11104-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[research@johannes-moeller.dev,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[johannes-moeller.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,johannes-moeller.dev:dkim,johannes-moeller.dev:email,johannes-moeller.dev:mid]
X-Rspamd-Action: no action

sip_help_tcp() parses the SIP Content-Length header with
simple_strtoul(), which returns unsigned long, but stores the result in
unsigned int clen.  On 64-bit systems, values exceeding UINT_MAX are
silently truncated before computing the SIP message boundary.

For example, Content-Length 4294967328 (2^32 + 32) is truncated to 32,
causing the parser to miscalculate where the current message ends.  The
loop then treats trailing data in the TCP segment as a second SIP
message and processes it through the SDP parser.

Fix this by changing clen to unsigned long to match the return type of
simple_strtoul(), and reject Content-Length values that exceed the
remaining TCP payload length.

Fixes: f5b321bd37fb ("netfilter: nf_conntrack_sip: add TCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Lukas Johannes Möller <research@johannes-moeller.dev>
---
Note: simple_strtoul() is deprecated; a follow-up patch could convert
to kstrtoul() with stricter input validation.

 net/netfilter/nf_conntrack_sip.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index ca748f8dbff1..eb6295f0e08c 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -1534,7 +1534,8 @@ static int sip_help_tcp(struct sk_buff *skb, unsigned int protoff,
 {
 	struct tcphdr *th, _tcph;
 	unsigned int dataoff, datalen;
-	unsigned int matchoff, matchlen, clen;
+	unsigned int matchoff, matchlen;
+	unsigned long clen;
 	unsigned int msglen, origlen;
 	const char *dptr, *end;
 	s16 diff, tdiff = 0;
@@ -1573,6 +1574,9 @@ static int sip_help_tcp(struct sk_buff *skb, unsigned int protoff,
 		if (dptr + matchoff == end)
 			break;
 
+		if (clen > datalen)
+			break;
+
 		term = false;
 		for (; end + strlen("\r\n\r\n") <= dptr + datalen; end++) {
 			if (end[0] == '\r' && end[1] == '\n' &&

base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
-- 
2.43.0


