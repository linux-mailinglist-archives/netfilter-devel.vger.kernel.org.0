Return-Path: <netfilter-devel+bounces-10816-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLqoBlRqmGn4IAMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10816-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Feb 2026 15:06:12 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F63716823C
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Feb 2026 15:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03C4F3019171
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Feb 2026 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A782DE6E6;
	Fri, 20 Feb 2026 14:06:08 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800751E22E9
	for <netfilter-devel@vger.kernel.org>; Fri, 20 Feb 2026 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596368; cv=none; b=iuy35ukOw4DgN1uThxiccOigImVCqIBLy4Tmtc4savuYCoEXCkQMLV4iKZTTHQqyHKhjAFkGHCaq75VPUitQvvNt2/9ejA4h2BKPIRVRxUF3w7dFLiuSY6voaDIPSo5yVkPqyK37hO03nixvjxTbF8Hm4iTOe1sRjFEh1D2prQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596368; c=relaxed/simple;
	bh=ntpWtPdW22AmqH8IFgrABqzoDkgOR2xqJ6rDn28Heq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLrC/0I6froYCIgyfG8GDHJawgnOqqp2akfTfkyg1mMPvsoX4W43zcCLa/27KPUTTxiAIZ2zieYzozKPqIWJFbjwXWnBlXJNZOvJWrQxJxnVZim0voeBkr0RSzB1Jq5tg/SNPXOoSCZXwjDHjb4LgUsU1va/QWQmTpKWWDiaoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 719B26090A; Fri, 20 Feb 2026 15:06:04 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/3] nf_tables: minor spring cleanup
Date: Fri, 20 Feb 2026 15:05:40 +0100
Message-ID: <20260220140553.21155-1-fw@strlen.de>
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
	TAGGED_FROM(0.00)[bounces-10816-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: 7F63716823C
X-Rspamd-Action: no action

These three patches make minor cleanups in the nf_tables codebase.

1). in rbtree we no longer need to disable BH processing:
    The tree root lock is no longer taken from the packet path.

2). nf_tables has a few EXPORT_SYMBOL that can be removed.

3). The register tracking infrastructure has been disabled for
    a long time, so finally remove this dead code.

No Functional changes intended.

Florian Westphal (3):
  netfilter: nft_set_rbtree: don't disable bh when acquiring tree lock
  netfilter: nf_tables: drop obsolete EXPORT_SYMBOLs
  netfilter: nf_tables: remove register tracking infrastructure

 include/net/netfilter/nf_tables.h        |  32 -------
 include/net/netfilter/nft_fib.h          |   2 -
 include/net/netfilter/nft_meta.h         |   3 -
 net/bridge/netfilter/nft_meta_bridge.c   |  20 -----
 net/bridge/netfilter/nft_reject_bridge.c |   1 -
 net/ipv4/netfilter/nft_dup_ipv4.c        |   1 -
 net/ipv4/netfilter/nft_fib_ipv4.c        |   2 -
 net/ipv4/netfilter/nft_reject_ipv4.c     |   1 -
 net/ipv6/netfilter/nft_dup_ipv6.c        |   1 -
 net/ipv6/netfilter/nft_fib_ipv6.c        |   2 -
 net/ipv6/netfilter/nft_reject_ipv6.c     |   1 -
 net/netfilter/nf_tables_api.c            |  78 -----------------
 net/netfilter/nft_bitwise.c              | 104 -----------------------
 net/netfilter/nft_byteorder.c            |  11 ---
 net/netfilter/nft_cmp.c                  |   3 -
 net/netfilter/nft_compat.c               |  10 ---
 net/netfilter/nft_connlimit.c            |   1 -
 net/netfilter/nft_counter.c              |   1 -
 net/netfilter/nft_ct.c                   |  46 ----------
 net/netfilter/nft_dup_netdev.c           |   1 -
 net/netfilter/nft_dynset.c               |   1 -
 net/netfilter/nft_exthdr.c               |  34 --------
 net/netfilter/nft_fib.c                  |  42 ---------
 net/netfilter/nft_fib_inet.c             |   1 -
 net/netfilter/nft_fib_netdev.c           |   1 -
 net/netfilter/nft_flow_offload.c         |   1 -
 net/netfilter/nft_fwd_netdev.c           |   2 -
 net/netfilter/nft_hash.c                 |  36 --------
 net/netfilter/nft_immediate.c            |  12 ---
 net/netfilter/nft_last.c                 |   1 -
 net/netfilter/nft_limit.c                |   2 -
 net/netfilter/nft_log.c                  |   1 -
 net/netfilter/nft_lookup.c               |  12 ---
 net/netfilter/nft_masq.c                 |   3 -
 net/netfilter/nft_meta.c                 |  45 ----------
 net/netfilter/nft_nat.c                  |   2 -
 net/netfilter/nft_numgen.c               |  22 -----
 net/netfilter/nft_objref.c               |   2 -
 net/netfilter/nft_osf.c                  |  25 ------
 net/netfilter/nft_payload.c              |  47 ----------
 net/netfilter/nft_queue.c                |   2 -
 net/netfilter/nft_quota.c                |   1 -
 net/netfilter/nft_range.c                |   1 -
 net/netfilter/nft_redir.c                |   3 -
 net/netfilter/nft_reject_inet.c          |   1 -
 net/netfilter/nft_reject_netdev.c        |   1 -
 net/netfilter/nft_rt.c                   |   1 -
 net/netfilter/nft_set_rbtree.c           |  23 ++---
 net/netfilter/nft_socket.c               |  26 ------
 net/netfilter/nft_synproxy.c             |   1 -
 net/netfilter/nft_tproxy.c               |   1 -
 net/netfilter/nft_tunnel.c               |  26 ------
 net/netfilter/nft_xfrm.c                 |  27 ------
 53 files changed, 9 insertions(+), 718 deletions(-)

-- 
2.52.0


