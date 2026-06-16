Return-Path: <netfilter-devel+bounces-13292-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y43IBT6hMWqRogUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13292-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 21:17:18 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EA8694E81
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 21:17:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13292-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13292-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9244D3059312
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 19:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F2B349CC5;
	Tue, 16 Jun 2026 19:17:14 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2881344D88
	for <netfilter-devel@vger.kernel.org>; Tue, 16 Jun 2026 19:17:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637434; cv=none; b=YN4S81yF4WY6dwL5JYlQZ5PVQLGFbqo7KU2OcNRyJkRX8aVe2uA4ASu9q52XQuYmvubaU8ySEXeu7jWhNTSP/lvlz3u/8vWi5BMi6NOh36aCGBdO1chjYiB/GyIab0I9HRJjyNEK0MNZKYZUzh6tt8/899gTs+tKJEV/xnvwiYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637434; c=relaxed/simple;
	bh=DLN+0iUfpUi1bdruR4u4FtSpkzyBBNdciRQC97Ub8Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tsgmGisY5dXjPqfy3YrqXJIonxHy8ceK56eBr+3sW+Z1HGygMylEgWlHyKu2S666zzqaKkllLavusWp9ofz4vumOgvsZrecENZSWVns9iNuYVXvaxcYXuNHJfI7IExpOJFkFBmGUMR5XA2oHkHHSBegKFCH7YDkr4OkTM7hjEpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id E455560634; Tue, 16 Jun 2026 21:17:04 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: nfnetlink: make OOM conditions fatal
Date: Tue, 16 Jun 2026 21:16:56 +0200
Message-ID: <20260616191658.2510-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13292-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,strlen.de:email,strlen.de:mid,strlen.de:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79EA8694E81

Batch support design attempts to process the entire batch, even
after a call has returned an error.  The advantage is that userspace
gets all errors in one go.

The disadvantages are:
 1. ->call() needs to cope with bad-state-due-to-previous-error
 2. One error can trigger a cascade of followup errors which
    can obfuscate the real problem.

Make -ENOMEM fatal, if we cannot allocate some object there is
a high chance we're going to report followup errors that are
nonsensical from userspace point of view.

Fixes: 0628b123c96d ("netfilter: nfnetlink: add batch support and use it from nf_tables")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Not strictly required, but I think it makes sense to stop
 the batch early, as-is we might produce many silly followup errors.

 net/netfilter/nfnetlink.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index 47f3ed441f64..a1d480e4789c 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -531,6 +531,13 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 				status |= NFNL_BATCH_REPLAY;
 				goto done;
 			}
+
+			/* No point in further processing; followup errors can
+			 * be bogus (e.g. -ENOENT because object that next
+			 * rule/element wants could not be inserted).
+			 */
+			if (err == -ENOMEM)
+				goto ack;
 		}
 ack:
 		if (nlh->nlmsg_flags & NLM_F_ACK || err) {
-- 
2.53.0


