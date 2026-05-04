Return-Path: <netfilter-devel+bounces-12406-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBR4CzzR+Gm41AIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12406-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 04 May 2026 19:02:52 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6974C1B54
	for <lists+netfilter-devel@lfdr.de>; Mon, 04 May 2026 19:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB3EA304C94C
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 May 2026 17:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC713E0259;
	Mon,  4 May 2026 17:00:39 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895C40DFA7
	for <netfilter-devel@vger.kernel.org>; Mon,  4 May 2026 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914039; cv=none; b=TSaFecCDvzv5m0l4izDD8Z0jS14p22Q6+Hxvh6KjwZ6+8TaF+V9f/9y0tsK7qUupfWMu3ixrgfvML0PWkxxyWk2owdR7lyaA6x+EygAQ74xKrH3e275LZdO/YdtYRo4bXj13q41LnIIyXT8LJdF+Ld3MBdpffyyITIwVMvCL8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914039; c=relaxed/simple;
	bh=USqv3e2ny/2OPetFppHCVH16GeKEu5TKvxNTPyUYjhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipS1ZT9XhhFD2XDm3I20ENZSoC39hGALErsPUZyPK/WE760fuEJ+A5jPE8mMDnsJ56NOhj6IcT8o6kdQvJE1AEORL+mTKjQQu0eg06/AZ9/xuDkn2LXi7LWAgFtD9Q3lTUz9E4qgqESZy1q8WeFmgXDLIUxQNPzd9Q7wA82i+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id AE70D6079C; Mon, 04 May 2026 19:00:29 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] tools: match_nomatch: fix spurious failure in nomatch test
Date: Mon,  4 May 2026 19:00:20 +0200
Message-ID: <20260504170024.9543-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BE6974C1B54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
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
	TAGGED_FROM(0.00)[bounces-12406-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.854];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid,strlen.de:email]

The list is constructed randonly, its possible that it is empty. When
this happens, the test fails.  Skip this instead if that happens.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/shell/helpers/set_match_nomatch_helpers | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/shell/helpers/set_match_nomatch_helpers b/tests/shell/helpers/set_match_nomatch_helpers
index 35114895c68c..04c3f8465bf0 100644
--- a/tests/shell/helpers/set_match_nomatch_helpers
+++ b/tests/shell/helpers/set_match_nomatch_helpers
@@ -301,11 +301,9 @@ test_nomatch()
 
 	wait
 
-	[ "$psent" -eq 0 ] && exit_fatal "empty nomatch list"
-
 	if ip netns exec "$R" $NFT list set ip test s | grep -q 'counter packets 1' ; then
 		ip netns exec "$R" $NFT list set ip test s
-		exit_fatal "Unexpected entry listed as matching"
+		exit_fatal "Unexpected entry listed as matching, sent $psent packets."
 	fi
 
 	if ip netns exec "$R" $NFT list counter ip test nomatch | grep -q "packets $psent"; then
-- 
2.53.0


