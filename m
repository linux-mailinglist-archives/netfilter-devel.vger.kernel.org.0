Return-Path: <netfilter-devel+bounces-12986-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPfSOJHeHWpsfQkAu9opvQ
	(envelope-from <netfilter-devel+bounces-12986-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 01 Jun 2026 21:33:37 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79932624AF4
	for <lists+netfilter-devel@lfdr.de>; Mon, 01 Jun 2026 21:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5E58305E8A1
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Jun 2026 19:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A86438239A;
	Mon,  1 Jun 2026 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0ix3DHd7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jjzHXar9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0ix3DHd7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jjzHXar9"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F97370D70
	for <netfilter-devel@vger.kernel.org>; Mon,  1 Jun 2026 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342312; cv=none; b=Tn0AYMrPf61W+4xA4v7g0dcub1qvkY+n6eM3Nb0PVoHxf74bKuRXYUt3fjpptim4pGC4qmbdvPDkClwiLfM+hvzhpQRfCFVvLGpSl3iR8AxUlkD2xCT4IL+Fm+pnsrFUJ4W7HnOA52/FD4t+IULS5rLt5RfCvZqEJquhMPC4oRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342312; c=relaxed/simple;
	bh=NIou8mRzYvfdnJ73Qnh7UIc2IJjZr7MC1uuOcYH9TPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8fcrEjtoWcKipDpoubB8prOK9TzwHwKV3qWKARgJHaQeBYvh0UEs1uwqKB61x72HiNjgBCfeboBw9kI6aHLxodaUzgayWhsQahx2SOslMXp6OxZSpqvpZksAL424MU55vMgswNoSVBIgiIMi1ks22lYPIvXwZJfE+mhrvax2N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0ix3DHd7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jjzHXar9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0ix3DHd7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jjzHXar9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C04A6873B;
	Mon,  1 Jun 2026 19:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780342269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vrQ2yg8H7n33xIeab4Nf7JlB+qR9ttmdSCmAv+AE3g=;
	b=0ix3DHd7HnyGUcZ0sJWu7dBdEjWqvQ/B4J3raXDRT/pXUCWwvmOI0ik3WVTqDkvD9H5rWJ
	doRupF0mkHZS+bC3WBs0p2tHR+VhgLAf5dZ6JmU2c/zIBebEOST1mg7O3QDj+Gnc+eJXmR
	rhcylt4Eg5w0l7GtqAX+Mo40TQXPREU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780342269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vrQ2yg8H7n33xIeab4Nf7JlB+qR9ttmdSCmAv+AE3g=;
	b=jjzHXar9FpfzI/cFBFt9V+BaEyyTaRs/x4pF/DflH8lVuls20rdY2fmT7FV/bkLRpFxQYP
	0gnWMHYxzRwwi8Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0ix3DHd7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jjzHXar9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780342269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vrQ2yg8H7n33xIeab4Nf7JlB+qR9ttmdSCmAv+AE3g=;
	b=0ix3DHd7HnyGUcZ0sJWu7dBdEjWqvQ/B4J3raXDRT/pXUCWwvmOI0ik3WVTqDkvD9H5rWJ
	doRupF0mkHZS+bC3WBs0p2tHR+VhgLAf5dZ6JmU2c/zIBebEOST1mg7O3QDj+Gnc+eJXmR
	rhcylt4Eg5w0l7GtqAX+Mo40TQXPREU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780342269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vrQ2yg8H7n33xIeab4Nf7JlB+qR9ttmdSCmAv+AE3g=;
	b=jjzHXar9FpfzI/cFBFt9V+BaEyyTaRs/x4pF/DflH8lVuls20rdY2fmT7FV/bkLRpFxQYP
	0gnWMHYxzRwwi8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2089779A7;
	Mon,  1 Jun 2026 19:31:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +FfWJPzdHWobLwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 01 Jun 2026 19:31:08 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org,
	phil@nwl.cc,
	fw@strlen.de,
	pablo@netfilter.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 9/9 nf-next] netfilter: conncount: use DEBUG_NET_WARN_ON_ONCE on reaching count limit
Date: Mon,  1 Jun 2026 21:30:49 +0200
Message-ID: <20260601193049.8131-10-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601193049.8131-1-fmancera@suse.de>
References: <20260601193049.8131-1-fmancera@suse.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12986-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 79932624AF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace WARN_ON_ONCE with DEBUG_NET_WARN_ON_ONCE in __nf_conncount_add.
The function handles count limit breaches safely by returning
-EOVERFLOW, so a production backtrace is not needed. This prevents
unnecessary system panics when panic_on_warn=1 is enabled in production
systems.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/netfilter/nf_conncount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index ab28b47395bd..7d970a87234c 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -246,7 +246,8 @@ static int __nf_conncount_add(struct net *net,
 	list->last_gc_count = list->count;
 
 add_new_node:
-	if (WARN_ON_ONCE(list->count > INT_MAX)) {
+	if (unlikely(list->count > INT_MAX)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
 		err = -EOVERFLOW;
 		goto out_put;
 	}
-- 
2.54.0


