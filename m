Return-Path: <netfilter-devel+bounces-13826-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kG0AFjbPUGpy5QIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13826-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 12:53:42 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBECB739DDE
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 12:53:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13826-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13826-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80E57308AC41
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 10:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B3941226D;
	Fri, 10 Jul 2026 10:47:40 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F89413D9C
	for <netfilter-devel@vger.kernel.org>; Fri, 10 Jul 2026 10:47:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680459; cv=none; b=enELWgtnZpXYKC23lIKpqarqeE957iFZqDtK55wFGGgbg9BjRrJq+bih3qCoydmleYMQZs4N+9JmeEAzHbOGh+6DwGpukO/cE97yAiECgX7d6219UTzoUv5SMBAUxtXdTqPvXWu6k5Hcl6vFo1pO5FU24KSEA08uBnQ7RyRQBC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680459; c=relaxed/simple;
	bh=v+MyMtFMwnZ5HOv09A0sC5zX3IS4ojfSfloxazMnuJY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aMfWgGltXXBxpa3s6sPrpJRKTdWRraeaLjdUBMH+5y0ULD6ewXUsy2dutoAIJkDnA900tbGhovCT26SZWfNcvJkW1iAPX2cciJ3Ho1Aln2l9JJ6KHdO1l6orjjv0AtAc/5RkfuHCQDE03msKpULk5vqWJyq1qOdZ5SEceTPLQKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A9CDB60491; Fri, 10 Jul 2026 12:47:31 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf] netfilter: x_physdev: masks are not c-strings
Date: Fri, 10 Jul 2026 12:47:23 +0200
Message-ID: <20260710104727.23363-1-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13826-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:from_mime,strlen.de:email,strlen.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBECB739DDE

... and must not be subjected to the 'nul terminated' constraint.
If the interface name is 15 characters long, the mask is 16-bytes
'0xff' (to cover for \0) and the valid device name is rejected.

Fixes: 8df772afc9d0 ("netfilter: x_physdev: reject empty or not-nul terminated device names")
Cc: stable@vger.kernel.org
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 I'm dumb.  I pushed a test case to iptables.git and will include
 this in todays nf -> net batch.

 net/netfilter/xt_physdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/netfilter/xt_physdev.c b/net/netfilter/xt_physdev.c
index dd98f758176c..a388881c68d4 100644
--- a/net/netfilter/xt_physdev.c
+++ b/net/netfilter/xt_physdev.c
@@ -130,11 +130,6 @@ static int physdev_mt_check(const struct xt_mtchk_param *par)
 		if (X(physoutdev))
 			return -ENAMETOOLONG;
 	}
-
-	if (X(in_mask))
-		return -ENAMETOOLONG;
-	if (X(out_mask))
-		return -ENAMETOOLONG;
 #undef X
 
 	if (!brnf_probed) {
-- 
2.54.0


