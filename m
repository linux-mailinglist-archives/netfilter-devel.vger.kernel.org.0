Return-Path: <netfilter-devel+bounces-12768-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NJZBqg2EGoaVAYAu9opvQ
	(envelope-from <netfilter-devel+bounces-12768-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 12:57:44 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E41A5B2960
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 12:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9528530EAFAA
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 10:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE3F3D4130;
	Fri, 22 May 2026 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kMxbOTPM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HdQVJWS/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zn+L3DRt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Pap94sS1"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9343D4104
	for <netfilter-devel@vger.kernel.org>; Fri, 22 May 2026 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446858; cv=none; b=o66aNfD+FmvH8TokmXEsCNdmGqSIy19eMgu+u73mKzZG35iR/Wo8qvYE8o+nE1JutVGux7wJfXwKvPnCbk33vdTrLx9Kr/ybt8W4n3T7ypcpC03aFeXYErUBHtbyTEW4r/MqtbbQ9C3QqhRRonfz5HiWphe0+kcNdm/VU2dzupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446858; c=relaxed/simple;
	bh=LvfZwekDKzhY+lwc2Toq8mqFmyQ8NwNml6cPjdoVUjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8K6aB78Xl2bn6qhmgghxDZWeoOJ5Ik8f7ZFhbp52Y+pLY/Hz3aKkchXPdFU1G6tcWrmd4HTXlF46HyIlunePBALg/T7Awgzv+X22SWfGaoZqLJjCVhrIXq++cnDZBxI2Y+ZjHvzvZ9Q3YRHzEYjQEzZ67Qcy+2pg95C6pCngj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kMxbOTPM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HdQVJWS/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zn+L3DRt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Pap94sS1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A74A6670B4;
	Fri, 22 May 2026 10:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779446855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CyoBrGtxhdMuOlR+j+ihqUPCKsb0f8cNaKVqC0Ld1Ek=;
	b=kMxbOTPM0BnLCKz9RwsxPITtMhCqjojfmVgYLiaxCueBzUB6lLkSNctO/KxClzDZYofp30
	M/LRRszh2h07YlMS6cC3Y7HTr8ZoW258EVGemI7WMt8JlI+jGTNW8xiXKIx7alO52+vCuW
	RnWvSUNAiAvO1tjS78CydDtvYKKcA5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779446855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CyoBrGtxhdMuOlR+j+ihqUPCKsb0f8cNaKVqC0Ld1Ek=;
	b=HdQVJWS/UkqsKvccUkLaiRy9XnIUTbO1OrdpAYhxewitgXlpiMe/A5xfRMoGXuz4rjI8fh
	ol6wEHro33/JQjCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zn+L3DRt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Pap94sS1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779446854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CyoBrGtxhdMuOlR+j+ihqUPCKsb0f8cNaKVqC0Ld1Ek=;
	b=zn+L3DRtAKQN1sr1wb1XYWiw7p5a5Edx5XVDvyzEboBGjkjCB08b+lklZwSKId6fgy79iw
	93DRT3Jfvr1Ynojt1tTBnngcsPZKiAORDDNTIZaBvB4je5DzOuC7f0NQyiVSmXrCJ0RwE/
	8mYgeCubn83iY4JwTgxTJJF9Li9moWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779446854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CyoBrGtxhdMuOlR+j+ihqUPCKsb0f8cNaKVqC0Ld1Ek=;
	b=Pap94sS1sl8g5iTGB7bQz7cx9Tir7qfiJR2trsdeN8rxc9SXPkgtWVIMWj6/imGWZlo4CX
	PQtTOhCinTzReZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 397C3593A8;
	Fri, 22 May 2026 10:47:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jRHZCUY0EGq8FAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 22 May 2026 10:47:34 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH nf] netfilter: xt_NFQUEUE: prefer raw_smp_processor_id
Date: Fri, 22 May 2026 12:47:17 +0200
Message-ID: <20260522104717.27286-1-fmancera@suse.de>
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
	TAGGED_FROM(0.00)[bounces-12768-lists,netfilter-devel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8E41A5B2960
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With PREEMPT_RCU this triggers a splat because smp_processor_id() can be
preempted while inside a RCU critical section. If xt_NFQUEUE target is
invoked via nft_compat_eval() path, we are inside a RCU critical
section.

Just use the raw version instead.

Fixes: 0ca743a55991 ("netfilter: nf_tables: add compatibility layer for x_tables")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/netfilter/xt_NFQUEUE.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_NFQUEUE.c b/net/netfilter/xt_NFQUEUE.c
index 466da23e36ff..b32d153e3a18 100644
--- a/net/netfilter/xt_NFQUEUE.c
+++ b/net/netfilter/xt_NFQUEUE.c
@@ -91,7 +91,7 @@ nfqueue_tg_v3(struct sk_buff *skb, const struct xt_action_param *par)
 
 	if (info->queues_total > 1) {
 		if (info->flags & NFQ_FLAG_CPU_FANOUT) {
-			int cpu = smp_processor_id();
+			int cpu = raw_smp_processor_id();
 
 			queue = info->queuenum + cpu % info->queues_total;
 		} else {
-- 
2.53.0


