Return-Path: <netfilter-devel+bounces-10900-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNWzLJmroGlulgQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10900-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Feb 2026 21:22:49 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1CC1AF0A0
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Feb 2026 21:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D5B63001327
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Feb 2026 20:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DAC4534BB;
	Thu, 26 Feb 2026 20:22:47 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C95343CEF6
	for <netfilter-devel@vger.kernel.org>; Thu, 26 Feb 2026 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137367; cv=none; b=BHSkYiEpKaZz1a4oeEWyr9OzKIT+A6HClIGSn0m0ErveIdYROSw+JJicTrZusHTYmr3giywBM8rSu60EUDLyfIsMrDAP8ZM3zDqOo6/fKctbneV5GLnxKC7bNSp4PPhfobw0sZR0AsOUnkcuyetgPqz5kvsMT6UiVmVsP9MrVX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137367; c=relaxed/simple;
	bh=9Z7n4QG4iBBq3zMBhKbhbmEYNk3BcZl5AQm59qzDD9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CXSonWgJU2oGi2Hy9GJYF+UmrHsMSYqvSnvR0A3+h8vD5utBdGm/ft5YjoJQjJ5vcHPraC8jXaoW/7jwXSdJ2hfR1NpvE1EwY3IBM2afHYCg+hl1qQf502GiEgYp+G1b3X92LdLCf9ksIS6pWmd625rmbP6ygkIj/fL65mXgsHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3D94960336; Thu, 26 Feb 2026 21:22:44 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: nfnetlink_queue: remove locking in nfqnl_get_sk_secctx
Date: Thu, 26 Feb 2026 21:22:36 +0100
Message-ID: <20260226202239.15132-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10900-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[strlen.de:server fail,sto.lore.kernel.org:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,strlen.de:mid,strlen.de:email]
X-Rspamd-Queue-Id: 7B1CC1AF0A0
X-Rspamd-Action: no action

We don't need the cb lock here.  Also, if skb was NULL we'd have crashed
already.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nfnetlink_queue.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index fbe5a8d71433..5390d085329a 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -592,15 +592,8 @@ static int nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsm_context *ctx)
 {
 	int seclen = 0;
 #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
-
-	if (!skb || !sk_fullsock(skb->sk))
-		return 0;
-
-	read_lock_bh(&skb->sk->sk_callback_lock);
-
 	if (skb->secmark)
 		seclen = security_secid_to_secctx(skb->secmark, ctx);
-	read_unlock_bh(&skb->sk->sk_callback_lock);
 #endif
 	return seclen;
 }
-- 
2.52.0


