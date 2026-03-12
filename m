Return-Path: <netfilter-devel+bounces-11159-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHhkNkH+smmQRQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11159-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 18:56:17 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 794E4276E28
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 18:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5A3A3046688
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C873C5542;
	Thu, 12 Mar 2026 17:55:55 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FDA38B131
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Mar 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338155; cv=none; b=BrbejVjqHLzvU1lvmK/0C+h9dCXZwL8zotsSer2nN8ba57D4bv+akKfxJ+oZpN9RKftcwFYjK3HpYzHSab+4Gw4hSOHPcQVMywH4uIq0wqAwhcCnRIYoG0+XeMNzvbdG+L5ahf57NpeDxPQsBTvsF8GPIFKYN1dOXa8kOxkdF4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338155; c=relaxed/simple;
	bh=x8bZifU574GNn4vOFRNq5xmMcpNPVqtuE0ezyi19iJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bAsDSthZhcLHlqzuusWUpItRiWg267fIQpoJLaH0qVPxQ0s0hnz3AWYeiJp7xN2GG8AbZTK2I6PHKdqOlhD7QKVgF91Ktk1Vx9MMqVJKHEIRLPFz5Q8uGC0/SDnjtHSTv4u8osnykUQghMQPGeByAU1JJ4YVmcmtohuVeRyHyRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0AD5F60345; Thu, 12 Mar 2026 18:55:46 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: nf_conntrack_h323: remove unreliable debug code in decode_octstr
Date: Thu, 12 Mar 2026 18:55:39 +0100
Message-ID: <20260312175542.27060-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11159-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 794E4276E28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The debug code (not enabled in any build) reads up to 6 octets of
the inpt buffer, but does so without bound checks.  Zap this.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_h323_asn1.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index 62aa22a07876..50a4ef54e301 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -21,7 +21,6 @@
 
 #if H323_TRACE
 #define TAB_SIZE 4
-#define IFTHEN(cond, act) if(cond){act;}
 #ifdef __KERNEL__
 #define PRINT printk
 #else
@@ -29,7 +28,6 @@
 #endif
 #define FNAME(name) name,
 #else
-#define IFTHEN(cond, act)
 #define PRINT(fmt, args...)
 #define FNAME(name)
 #endif
@@ -443,11 +441,6 @@ static int decode_octstr(struct bitstr *bs, const struct field_t *f,
 			BYTE_ALIGN(bs);
 			if (base && (f->attr & DECODE)) {
 				/* The IP Address */
-				IFTHEN(f->lb == 4,
-				       PRINT(" = %d.%d.%d.%d:%d",
-					     bs->cur[0], bs->cur[1],
-					     bs->cur[2], bs->cur[3],
-					     bs->cur[4] * 256 + bs->cur[5]));
 				*((unsigned int *)(base + f->offset)) =
 				    bs->cur - bs->buf;
 			}
-- 
2.52.0


