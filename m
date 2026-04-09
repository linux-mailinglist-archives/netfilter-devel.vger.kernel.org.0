Return-Path: <netfilter-devel+bounces-11762-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LHBAFaW12lNQAgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11762-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 14:06:46 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CAD3CA18D
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 14:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D9623076D63
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Apr 2026 11:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1379A3C3BFD;
	Thu,  9 Apr 2026 11:58:04 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D073C276B
	for <netfilter-devel@vger.kernel.org>; Thu,  9 Apr 2026 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735884; cv=none; b=tQYX3bToCO2mEtKJz+j9HWK0N4rOJJACmNRdGA9ws0F0V6fH9nd17mcdhbXYfZ50ZRxZ65ri6aHEYiJeBJ4jCjuDNoUiNGOuAFfTwqJuCbwfo/upZ8Njy6r9pJ3xtrewPtftIyBHVfb+hVjSjou6Kd/uIxw6YWlRtAW+Jj3amDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735884; c=relaxed/simple;
	bh=y+Qwv3tYHwhGL+9ry1tIpTJrDbjuSjsrqaFxldAfxWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vAfbDebKHYfWiL+dG5Ry/G/6ZWJ1M9AgmC0IOM/N11w1SDRN1WKU2K96mfOZ89ZAICp9Krghiu4+hOeWBnrKLapuVE6QkId7ZL+gvbkdWB1Ul57PzJoEqlcP1vL5/9HbqfcxKQoonjFo/Ux+JEMl+yMzdEPFEII2WwgKWCH90OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id AABF460636; Thu, 09 Apr 2026 13:58:00 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] doc: ct count should be restricted via new
Date: Thu,  9 Apr 2026 13:57:53 +0200
Message-ID: <20260409115756.27931-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11762-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.835];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:email,strlen.de:mid]
X-Rspamd-Queue-Id: A5CAD3CA18D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Not doing it will affect existing flows, which is likely not wanted.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 doc/payload-expression.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/payload-expression.txt b/doc/payload-expression.txt
index 8b538968c84b..817b7a3c76b1 100644
--- a/doc/payload-expression.txt
+++ b/doc/payload-expression.txt
@@ -934,5 +934,5 @@ ct_id|
 .restrict the number of parallel connections to a server
 --------------------
 nft add set filter ssh_flood '{ type ipv4_addr; flags dynamic; }'
-nft add rule filter input tcp dport 22 add @ssh_flood '{ ip saddr ct count over 2 }' reject
+nft add rule filter input ct state new tcp dport 22 add @ssh_flood '{ ip saddr ct count over 2 }' reject
 --------------------
-- 
2.52.0


