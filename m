Return-Path: <netfilter-devel+bounces-12793-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLbmLsEEEmrDtQYAu9opvQ
	(envelope-from <netfilter-devel+bounces-12793-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 23 May 2026 21:49:21 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 627CC5C0A7D
	for <lists+netfilter-devel@lfdr.de>; Sat, 23 May 2026 21:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F00030198BA
	for <lists+netfilter-devel@lfdr.de>; Sat, 23 May 2026 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEE6335081;
	Sat, 23 May 2026 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MnzvZ1cq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a+hHQK0Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MnzvZ1cq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a+hHQK0Z"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9251C68F
	for <netfilter-devel@vger.kernel.org>; Sat, 23 May 2026 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779565709; cv=none; b=b49uJW6hiMP/it/OwnEIaEeSrA1KRKAmqMI3+URICwej/kzyXDRfgnpHLz1kJmlTNyxunWnVyzPqA7EZ9/x8N46FW7h5vyPU4/arBjZMYB3yWld0b3MUHv4rD2G/dbDKIn3MKkchGloQ3+YZ43ktBCzZc+h/dGk3M+k1ocG8U3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779565709; c=relaxed/simple;
	bh=i5fcyVMx/pxYdjwCuNGaEcmDwnMhp3RMXLtbMcdOxrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxmtxbfxaMjx01khhLH3PeuIuYfM+fD2bZR3EAqcmNLbIeT6i9eDb+7QfFmoZ2rxfHcZ7yoHYt47cdNNdISZQd5YNyqt6VmBiMN6O3ZIjY+gHaP4fwa1fSKTwcGVtmTjzbblNkxDoAmqyEKzO8CDxRggJMdXECla+Kefx7t8gtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MnzvZ1cq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a+hHQK0Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MnzvZ1cq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a+hHQK0Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37E376851B;
	Sat, 23 May 2026 19:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779565701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFc+FmrI31TjpTeBzeACSQoOuuqWrr93OxbmIWnOQMo=;
	b=MnzvZ1cqQ3oogSroxezvM/O5ROSbYPkrC7vZ9AjlMUf2JPKWGF8kU3RCTdbVdR/YyPrECb
	3X9oSJjw9U4s0R8THazPHtEj6h8tTeGKe5SFowRBeZyMHeMORJJv576Z/X/9UVbXhd7U8D
	JNl65Ge94zsO98CFGmK7S7WhUmEyyvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779565701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFc+FmrI31TjpTeBzeACSQoOuuqWrr93OxbmIWnOQMo=;
	b=a+hHQK0ZxCZv4vbYiVkFznyaMnNk1wgEaajFjIbX6gfyDcrwhQGa8hL9vpMHf+xQ6bCV9o
	a9ksRP7yn+l/h1BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MnzvZ1cq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a+hHQK0Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779565701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFc+FmrI31TjpTeBzeACSQoOuuqWrr93OxbmIWnOQMo=;
	b=MnzvZ1cqQ3oogSroxezvM/O5ROSbYPkrC7vZ9AjlMUf2JPKWGF8kU3RCTdbVdR/YyPrECb
	3X9oSJjw9U4s0R8THazPHtEj6h8tTeGKe5SFowRBeZyMHeMORJJv576Z/X/9UVbXhd7U8D
	JNl65Ge94zsO98CFGmK7S7WhUmEyyvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779565701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AFc+FmrI31TjpTeBzeACSQoOuuqWrr93OxbmIWnOQMo=;
	b=a+hHQK0ZxCZv4vbYiVkFznyaMnNk1wgEaajFjIbX6gfyDcrwhQGa8hL9vpMHf+xQ6bCV9o
	a9ksRP7yn+l/h1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0320593A8;
	Sat, 23 May 2026 19:48:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CJeoK4QEEmodWQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sat, 23 May 2026 19:48:20 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/3 nf-next] netfilter: synproxy: drop packets with duplicated timestamp options
Date: Sat, 23 May 2026 21:47:43 +0200
Message-ID: <20260523194743.5888-4-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260523194743.5888-2-fmancera@suse.de>
References: <20260523194743.5888-2-fmancera@suse.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12793-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 627CC5C0A7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RFC 9293 does not mention anything about duplicated options and each
networking stack handles it in their own way. Currently, Linux kernel is
processing options sequentially and in case of duplicated timestamp
options, the value from the latest one overrides the others.

As SYNPROXY is modifying only the first timestamp option found, a packet
can reach the backend server and it might parse the wrong timestamp
value.  As there is not a use-case for duplicated timestamp option, drop
the packet directly when such situation is found.

Fixes: 48b1de4c110a ("netfilter: add SYNPROXY core/target")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/netfilter/nf_synproxy_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index 51a3dd48995b..49ce18f9c8ef 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -189,6 +189,7 @@ synproxy_tstamp_adjust(struct sk_buff *skb, unsigned int protoff,
 		       const struct nf_conn_synproxy *synproxy)
 {
 	unsigned int optoff, optend;
+	bool tstamp_seen = false;
 	__be32 *ptr, old;
 
 	if (synproxy->tsoff == 0)
@@ -216,6 +217,8 @@ synproxy_tstamp_adjust(struct sk_buff *skb, unsigned int protoff,
 				return false;
 			if (op[0] == TCPOPT_TIMESTAMP &&
 			    op[1] == TCPOLEN_TIMESTAMP) {
+				if (tstamp_seen)
+					return false;
 				if (CTINFO2DIR(ctinfo) == IP_CT_DIR_REPLY) {
 					ptr = (__be32 *)&op[2];
 					old = *ptr;
@@ -229,7 +232,10 @@ synproxy_tstamp_adjust(struct sk_buff *skb, unsigned int protoff,
 				}
 				inet_proto_csum_replace4(&th->check, skb,
 							 old, *ptr, false);
-				return true;
+				/* continue parsing options in case there is a
+				 * duplicated tstamp, drop the packet
+				 */
+				tstamp_seen = true;
 			}
 			optoff += op[1];
 		}
-- 
2.53.0


