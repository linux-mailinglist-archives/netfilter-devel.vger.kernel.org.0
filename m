Return-Path: <netfilter-devel+bounces-12004-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEkVBGB94mnk6gAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12004-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 20:35:12 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6736A41DFBB
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 20:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E4913020010
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C04134A3BF;
	Fri, 17 Apr 2026 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YoG4bUjs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8iQNfNR8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1mY9xQE1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZXnyoCTL"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E4F3264CE
	for <netfilter-devel@vger.kernel.org>; Fri, 17 Apr 2026 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776450899; cv=none; b=JzfEvZihg8pl3FCxL3+KE82HHZaXLrPoQqLdPtyIaUrIzlqp6O3v5vPCECswE/v9EN1HbPpWS1WvIaEWcA7t+8+T239rOghy22uNj7iXBReaEeOJP8+oLNfvNor3rBgngLfM1HJcngIC/6zM6CddDKbU2tjQm83YQiM5ejxavvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776450899; c=relaxed/simple;
	bh=3raNyK+HitSIc8NPZf6Wg6VHIuW2luRiHcR3S5+8KY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDPcjbbCTvDGj0bjsv9YnYgtPSR3IA4SuPcQT7NEkum1qqkwbASi4DWd+hDA6VPhdlj71kFDshmVEAxlgwzZXZqS47Hu3i/ZzM+r3hi4a7WntsXxMI93/NZs+t084lDShYsGRDebrslJIPlJi35tdtaszF1XHqhFRQ4zFx2PDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YoG4bUjs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8iQNfNR8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1mY9xQE1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZXnyoCTL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC1836A9E8;
	Fri, 17 Apr 2026 18:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776450895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UrX/uUMR+k8sq29o+DdfIXyRnJnVrZizQl8wASbQ+6k=;
	b=YoG4bUjsvo68H18CelugOJUgbHTZW9vLIr8XvPFHknu8HTb9QI3Q9gUhSR42AGHUywbKSv
	1rGJ+0zsPQGQ0sk1Uaq4Ie8XVgS++d21ax+Rlc6k159G2HLtYFUhy9t5lsnEY9yHpAUFKn
	PvdG4Soj5omMu5qWik04RvEU6dFiv6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776450895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UrX/uUMR+k8sq29o+DdfIXyRnJnVrZizQl8wASbQ+6k=;
	b=8iQNfNR8PTKB5Vo1zGhuTo5OQjmGS3BHWKsABjaa8npI284CZJTJeg8gLOWGHJCsCZUjt+
	jaqoKu7dcrTeehBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1mY9xQE1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZXnyoCTL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776450894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UrX/uUMR+k8sq29o+DdfIXyRnJnVrZizQl8wASbQ+6k=;
	b=1mY9xQE1zold+Jxo6zRhvQA9X1+X8p5NwGfKdasWvByNdyJVYcLJCxpwlCwF7WpyomlN39
	npkEmdplhhvq5o17pYCth71o33qIL7mWYTlg+dfAtXEo1gJpRuNgRv2xpcKXsQwpu6lyw3
	1QUtrs5277Ko8cpjhPgp+42BMkKLB1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776450894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UrX/uUMR+k8sq29o+DdfIXyRnJnVrZizQl8wASbQ+6k=;
	b=ZXnyoCTLmeBZqkKUuOxZjOwwjIY4gF1I7vSlnEH6ZvyLIXPPyePA+c55b6xbAGsfMIClIl
	DSVf2mt9GtlQSPBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4083B593AE;
	Fri, 17 Apr 2026 18:34:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qd3zDE594mmFFQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 17 Apr 2026 18:34:54 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netfilter-devel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	coreteam@netfilter.org,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 1/4 nf] netfilter: nft_exthdr: skip SCTP chunk evaluation for non-first fragments
Date: Fri, 17 Apr 2026 20:34:30 +0200
Message-ID: <20260417183433.4739-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12004-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6736A41DFBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The SCTP chunk matching logic in nft_exthdr relies on SCTP common header
being present at the transport header offset. For fragmented packets at
IP level, only the first fragment would match this condition.

The nft_exthdr could be used in a PREROUTING chain with a priority lower
than -400. This would bypass defragmentation. In addition, it can be use
in stateless environments so it should work on a environment where
defragmentation is not being performed at all.

Add a check for pkt->fragoff to ensure exthdr SCTP only evaluates
unfragmented packets or the first fragment in the stream.

Fixes: 133dc203d77d ("netfilter: nft_exthdr: Support SCTP chunks")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/netfilter/nft_exthdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 7eedf4e3ae9c..8eb708bb8cff 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -376,7 +376,7 @@ static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
 	const struct sctp_chunkhdr *sch;
 	struct sctp_chunkhdr _sch;
 
-	if (pkt->tprot != IPPROTO_SCTP)
+	if (pkt->tprot != IPPROTO_SCTP || pkt->fragoff)
 		goto err;
 
 	do {
-- 
2.53.0


