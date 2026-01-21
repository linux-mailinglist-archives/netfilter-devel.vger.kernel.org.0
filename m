Return-Path: <netfilter-devel+bounces-10358-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPMuAO0ZcGkEVwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10358-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jan 2026 01:12:29 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A054E5D5
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jan 2026 01:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51E9078AC3F
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jan 2026 00:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E5521CC55;
	Wed, 21 Jan 2026 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="r7WkOaMl"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5424A3C
	for <netfilter-devel@vger.kernel.org>; Wed, 21 Jan 2026 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768954145; cv=none; b=YL5qHv/Lavxu8SPDW+F38dexA3v7Hm9I/2LjBvyEQ1ROmB6mnXVN6W581ST+2yVeG5d1297M2i+J56tLBopBtWV9RgN65ZHYDkz1NDo0Pb6bxWgfjI5tj4KBG+J5K/HxUR5v6FfF9/UHXv/BcjvSKEfQV5qq6dwMaVOnCtxroTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768954145; c=relaxed/simple;
	bh=BxpEd/7aeCIaap5n5gTpBWJH3Se3bYf8H8qg9QypToM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4l+VaEdUEHuzqRnjrVY/qs19FVJNjrFCrtVQZogozDHdWBMyMfbLsEVwscjfUEYJCyk+ejXNIe9vWoyvDRdoJ9a6myqkfeR9ao+5jnN1TVPNryHqn82x04gkS83V8JNjYfE+TT0P5/3k7e5+B1+J1HFRqW7yKPdHnMFJqUk1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=r7WkOaMl; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id C691760179;
	Wed, 21 Jan 2026 01:08:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1768954132;
	bh=msFsGOEc1Ah1R1uPvUyiAB/SoebrIODc1gtRd7jzJlc=;
	h=From:To:Cc:Subject:Date:From;
	b=r7WkOaMlJYMe+SVBt7ZI0X+MTidmtMmDTtZbaxebpKZAEsdsDF34QpyFjChTogM/U
	 IndxiRRmnnO3qdFQyOPqy3wM1ceAzQ+IS+lWNieGdPUbuhgbveYGRHYi+D2sDVK0eZ
	 Daz3w8cctdmXUCOMt4ZRczuy0R40BnZZHVsTdLpuO7SrgP7SCTnWQbMp/dZy3eQYFJ
	 FsT0M0fsuKzNC20IR2SJtGyBok95q2VQV6w4JBpolVLNF4qfR5umS1hI0iLR7p51jb
	 FTlhHN/djy4+FYIBtsg/hHjF/vJ/UKz41TiiwsEnBTaT5leEY2Yi+PLYg1s1I/dGFS
	 sM29+2KXVNO2g==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nf-next,v2 0/4] convert rbtree to binary search array
Date: Wed, 21 Jan 2026 01:08:43 +0100
Message-ID: <20260121000847.294125-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
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
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10358-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,netfilter.org:mid,netfilter.org:dkim]
X-Rspamd-Queue-Id: 68A054E5D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

v2: - fix kdoc in 1/4
    - fix sparse warning in nft_rbtree_destroy() in 2/4
    - add 4/4, new in this series.

Florian reported that there is currently an issue with interval matching
in the rbtree, allowing for false negative lookup during transaction.
 
This series addresses this issue by translating the rbtree, which keeps
the intervals in order, to binary search. The array is published to
packet path through RCU. The idea is to keep using the rbtree
datastructure for control plane, which needs to deal with updates, then
generate an array using this rbtree for binary search lookups. 

Patch #1 allows to call .remove in case .abort is defined, which is
needed by this new approach. Only pipapo needs to skip .remove to speed.
 
Patch #2 add the binary search array approach for interval matching.
 
Patch #3 updates .get to use the binary search array to find for
(closest or exact) interval matching.

Patch #4 removes seqcount_rwlock_t as it is not needed anymore (new in
this series).

This can possibly go to nf.git alternatively since it qualifies as bugfix,
feel free to pick the best route for it.

Pablo Neira Ayuso (4):
  netfilter: nf_tables: add .abort_skip_removal flag for set types
  netfilter: nft_set_rbtree: translate rbtree to array for binary search
  netfilter: nft_set_rbtree: use binary search array in get command
  netfilter: nft_set_rbtree: remove seqcount_rwlock_t

 include/net/netfilter/nf_tables.h |   2 +
 net/netfilter/nf_tables_api.c     |   3 +-
 net/netfilter/nft_set_pipapo.c    |   2 +
 net/netfilter/nft_set_rbtree.c    | 429 ++++++++++++++++++++----------
 4 files changed, 291 insertions(+), 145 deletions(-)

-- 
2.47.3


