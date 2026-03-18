Return-Path: <netfilter-devel+bounces-11267-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eXppApOnumlpaQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11267-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 14:24:35 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8402BC156
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 14:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2E683024115
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Mar 2026 13:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE8E3B8BB0;
	Wed, 18 Mar 2026 13:24:32 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B72135D7
	for <netfilter-devel@vger.kernel.org>; Wed, 18 Mar 2026 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773840272; cv=none; b=P7cSFYagBU7cS2F5FyOPWp6LGtULDy2qyVZ2iT3QhcFns7TqM1byxNNUgX8bTnM3s/YFE79uW/igU6KlD8OT7kXXpepAwsEAJrjO4FhgYQBhY3Z5MgvDdgjOfBvjE2qjz+4jAQzTN2Nb5d/qcAYTRRvgM/skM1dATKq13p1Ca2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773840272; c=relaxed/simple;
	bh=mm7OhNmen5YeffG039VQjzWOJYpnQKwMen+0jlRVny0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOWMpeYpWB7uhG7RULGgzz2j2LA4P0UfmdzO4R8w208NCy+gxoANG+3ww2RcClPgXsWrKBaLmPkLxfy3PusyyOq/7/ZSF1FtDVvugBUn+i+NReY1eErOSFdOquHtQIbvwgzJNntf6Xk8lUv9ezmFVZ5AQMlhXHh6tdzIQTCOzNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id ACF0E605C3; Wed, 18 Mar 2026 14:24:22 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: sbrivio@redhat.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH nf 0/2] netfilter: nft_set_pipapo_avx2: don't return non-matching entry
Date: Wed, 18 Mar 2026 14:24:12 +0100
Message-ID: <20260318132417.31661-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11267-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.955];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F8402BC156
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While adding more comprehensive tests for set transactions to
nftables I found nft cannot restore a valid set via:

  (echo flush set t s; cat foo) | nft -f -

... because the avx2 functions can return a non-matching entry iff the entry
that it found in first round was expired.

Patch 1 fixes this bug and patch 2 add a test that triggers the problem.

- C implementation doesn't have this problem
- forcing 'slow' mode in avx2 by axing the actual avx2 routines
  also 'fixes' this issue
- No noticeable performance differences with this patch.
- Also have an alternative fix that calls pipapo_refill OR
  nft_pipapo_avx2_refill, but that diff is significantly larger,
  so I picked the one that is smaller.

Florian Westphal (2):
  netfilter: nft_set_pipapo_avx2: don't return non-matching entry on
    expiry
  selftests: netfilter: nft_concat_range.sh: add check for flush+reload
    bug

 net/netfilter/nft_set_pipapo_avx2.c           | 20 +++---
 .../net/netfilter/nft_concat_range.sh         | 68 ++++++++++++++++++-
 2 files changed, 77 insertions(+), 11 deletions(-)

-- 
2.52.0


