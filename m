Return-Path: <netfilter-devel+bounces-10926-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHzWFU0wp2mbfgAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10926-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Mar 2026 20:02:37 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 068021F598D
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Mar 2026 20:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EFDE30398EF
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Mar 2026 19:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF73A370D65;
	Tue,  3 Mar 2026 19:02:26 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1CA37267D
	for <netfilter-devel@vger.kernel.org>; Tue,  3 Mar 2026 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564546; cv=none; b=Y9bDENEpCWEtg/uzouxUxmhfwrVHR8OI6dMcEyWMK8kMqrEF7GWoMaTTNIZ+BgBsCybVVEh8w2n4SUNyxB2SJsr+9kEeWY9Q+LcoUofJ238K/+PDpg42hAAO9mBEua263u1x2BrXJTfj6Pzoo9ixRkaW71F/zQijCXyx75utEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564546; c=relaxed/simple;
	bh=BV/q+xn5OcKG2klUL/CFHlAKb3qVoXenlAHBdev1ois=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SDOkyBqEIrOB4j3m+eUNhSCkdRR7uAO4KONt8sU0IXvazgwGJhZUMetE1viiRBulqb+9eMHS5fTxYgXbhBWKfUauLt17pmaEwmLgdD+gRU4WhPcrHcGohm/gkiS44g9kNGlIp2KCkDZa0vh3B2O54qpaD5q3gnvC7fuozZKD3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8DA8C60CFF; Tue, 03 Mar 2026 20:02:23 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: sbrivio@redhat.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH nf 0/2] netfilter: nft_set_pipapo: fix UaF during gc walk
Date: Tue,  3 Mar 2026 20:02:06 +0100
Message-ID: <20260303190218.19781-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 068021F598D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10926-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Action: no action

Yiming Qian reports Use-after-free in the pipapo set type:
  Under a large number of expired elements, commit-time GC can run for a very
  long time in a non-preemptible context, triggering soft lockup warnings and
  RCU stall reports (local denial of service).

As-is, elements are unlinked from the clone.  But the expired elements
are also reachable from the live copy.

Therefore, we must not queue them for freeing until after the clone
has been exposed to other CPUs and one grace period has elapsed.

Split gc into unlink + reclaim phase to resolve this bug.

Florian Westphal (2):
  netfilter: nft_set_pipapo: split gc in unlink and reclaim phase
  netfilter: nft_set_pipapo: prevent soft lockup during gc walk

 net/netfilter/nft_set_pipapo.c | 69 +++++++++++++++++++++++++---------
 net/netfilter/nft_set_pipapo.h |  4 ++
 2 files changed, 56 insertions(+), 17 deletions(-)
-- 
2.52.0


