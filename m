Return-Path: <netfilter-devel+bounces-12810-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JrLFZ5tFGoTNQcAu9opvQ
	(envelope-from <netfilter-devel+bounces-12810-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 17:41:18 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCFC5CC68F
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 17:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E5FC3003327
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 15:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63622F7EE5;
	Mon, 25 May 2026 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vThGR87w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+RJQDD1x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vThGR87w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+RJQDD1x"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEDE2E7F3A
	for <netfilter-devel@vger.kernel.org>; Mon, 25 May 2026 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723372; cv=none; b=c4OuM8LZzAyy2rrs7jfavDw5V64j0L941Z61HSTEjtsf9Y6q30ksDWbsxH+kpEVsls3AE0KGnCQy0kx64SaTIapJwMjvQZ78WevX1QgqrQ4cNI7epD5s5F3Kkkqj2/0qopohWbmENdeGnns399AYoqcbWDfBXULrNQkygqLysLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723372; c=relaxed/simple;
	bh=eZGRaXIS3ZeIzXx7sXqRGjvccMpP4Sv4z4/deZBBeRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QUmFzpU34WdnNnxJ2oBPStThHnEWp4B01YYMG9M2bGfOVMH/EyhE0RBKZI9ebKHfhsemR1rKoZfmx4Dh5y6Q9nuhGSHSqYeKrj86k2QolHK14FUvJTFYwzBKtkMztGmjVv1oaBbfxODTNiIVk3v349Hr5SXy5yb8FhFsru9FaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vThGR87w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+RJQDD1x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vThGR87w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+RJQDD1x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99BC36B2C9;
	Mon, 25 May 2026 15:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779723369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZiWDAFtOBDqcLyxUr0aEvoEVzRVSp2/4XjWNvZ6v9Ww=;
	b=vThGR87wM/GcuXTdM8Vzt/ofU0I/UXg33GvpJ7tvx6leNmDlSobp2kliKpbNQ44O+RXokQ
	GFmp5Z2dzSeE6S/+PRIAycPKGHGCITyuChHTxbav9Bih5qA/9lIuSBVdJzvgttRgMoFAl9
	WED5sevs86INMK3Zn/ATqdmZ4PgB1dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779723369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZiWDAFtOBDqcLyxUr0aEvoEVzRVSp2/4XjWNvZ6v9Ww=;
	b=+RJQDD1xU/pn69RQDRhlw/WmXHlPqRzLbLuwWrXxlaEf6LHWGbEOT5fVug7lxygYyTRl9K
	nFJOjOLpFG6VUYCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vThGR87w;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+RJQDD1x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779723369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZiWDAFtOBDqcLyxUr0aEvoEVzRVSp2/4XjWNvZ6v9Ww=;
	b=vThGR87wM/GcuXTdM8Vzt/ofU0I/UXg33GvpJ7tvx6leNmDlSobp2kliKpbNQ44O+RXokQ
	GFmp5Z2dzSeE6S/+PRIAycPKGHGCITyuChHTxbav9Bih5qA/9lIuSBVdJzvgttRgMoFAl9
	WED5sevs86INMK3Zn/ATqdmZ4PgB1dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779723369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZiWDAFtOBDqcLyxUr0aEvoEVzRVSp2/4XjWNvZ6v9Ww=;
	b=+RJQDD1xU/pn69RQDRhlw/WmXHlPqRzLbLuwWrXxlaEf6LHWGbEOT5fVug7lxygYyTRl9K
	nFJOjOLpFG6VUYCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DB0759CFB;
	Mon, 25 May 2026 15:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IiJYB2lsFGo7dQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 25 May 2026 15:36:09 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH nf-next] netfilter: nfnetlink_osf: fix mss parsing on big-endian architectures
Date: Mon, 25 May 2026 17:35:54 +0200
Message-ID: <20260525153554.7136-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12810-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ABCFC5CC68F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MSS calculation in nf_osf_match_one() manually shifts bytes to
construct a 16-bit value before passing it to ntohs().

This works on little-endian hosts but it does not work on big-endian as
the bytes are being always shifted and set in the same way for all
architectures.

Use get_unaligned_be16() to fix this on big-endian systems. It also
simplifies the code.

Fixes: 11eeef41d5f6 ("netfilter: passive OS fingerprint xtables match")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
Note: the nf queue is already busy.. it does not make sense to queue
this there IMHO, let's aim this to nf-next.
---
 net/netfilter/nfnetlink_osf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index acb753ec5697..92002079f8ea 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -95,11 +95,7 @@ static bool nf_osf_match_one(const struct sk_buff *skb,
 
 			switch (*optp) {
 			case OSFOPT_MSS:
-				mss = optp[3];
-				mss <<= 8;
-				mss |= optp[2];
-
-				mss = ntohs((__force __be16)mss);
+				mss = get_unaligned_be16(&optp[2]);
 				break;
 			case OSFOPT_TS:
 				break;
-- 
2.53.0


