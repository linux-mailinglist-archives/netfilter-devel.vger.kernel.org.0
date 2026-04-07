Return-Path: <netfilter-devel+bounces-11681-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFEbDOwR1Wm30AcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11681-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 16:17:16 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B653F3AFE18
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 16:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B4FC302FDD1
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1E83B8BD8;
	Tue,  7 Apr 2026 14:16:09 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE9134CF;
	Tue,  7 Apr 2026 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571369; cv=none; b=q3o0GwU4g870BoW83SLRziSZk8lQ2dDPn56dvhHXGfNzP2iow50dLgR3bQNlpwKY2KZWzVK/oNNBAq/Uuf4dA7RV5g0tesC6E+6c3SWXG29lZ4sWCYxUbkoMKI5GkduHFwpRDYlBLJKMFVvzBt40UEKi5FuclDzhblku9RHmNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571369; c=relaxed/simple;
	bh=5ooEBCvja8GITC1ZwX5op+f6y6oNMPedSteT7pPEfcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uicNEMyxPioR4PMxaSBGxATl5GwMJOlHPJ3iIY8ghQeM2rFfNU4uNJArPxNt9corlC11vAGh7M2A8S63nGxviTWdSQkG9Fi4jkCIAa08XWf+dhaEm30IT58g9FUewcwKdCCXdIDlKwEooE3L1YcuJnsgxvA/TNQJrvrPiS8BDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id BAD0460660; Tue, 07 Apr 2026 16:16:06 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 05/13] netfilter: nf_conntrack_h323: remove unreliable debug code in decode_octstr
Date: Tue,  7 Apr 2026 16:15:32 +0200
Message-ID: <20260407141540.11549-6-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407141540.11549-1-fw@strlen.de>
References: <20260407141540.11549-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11681-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.934];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B653F3AFE18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The debug code (not enabled in any build) reads up to 6 octets of
the inpt buffer, but does so without bound checks.  Zap this.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_h323_asn1.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index 7b1497ed97d2..09e0f724644f 100644
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
@@ -445,11 +443,6 @@ static int decode_octstr(struct bitstr *bs, const struct field_t *f,
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


