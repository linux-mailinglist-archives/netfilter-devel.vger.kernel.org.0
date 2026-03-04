Return-Path: <netfilter-devel+bounces-10951-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCFgF3ccqGmYoAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10951-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 12:50:15 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BBB1FF48C
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 12:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 523CF300D16E
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Mar 2026 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A52035C1BA;
	Wed,  4 Mar 2026 11:49:35 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A5239F173;
	Wed,  4 Mar 2026 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624975; cv=none; b=Rn2XLbD3Iku7oWDc5lIxw7Jyu2HxUQvFsDKHsOaOkiKV+mZuGFCXV4jyzUsKwLO9WSHT2Yb81cczIwie1HnIgoOaIWAtDXRcfVeu62WvWYWi4GAQH7BFLYjG1jYSGpKLBbg9kS7cMb8NQOU8DVYIF7SMntOqJSl5l07ZL+LLBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624975; c=relaxed/simple;
	bh=tNgMebyVLVIysFUKRyPizBE2w0Ibu+FjhaowLCsqS4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3tyBy92MQV9LMJbnDhNcBmgG2EG1CHiciYGfmkx2EU1uwdZosNNU9Lk5TrrovLfB1PCvmUy1umsl7BsSsJlKRb0fJY+rIK67JQK4RC2JCQnliG0T/Y5RxGNsjvJgCud031SKRDuzQ0RwgkxML8Cb/II1FHFqrE5uNk4+ctXBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0E30D6026E; Wed, 04 Mar 2026 12:49:30 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 00/14] netfilter: updates for net-next
Date: Wed,  4 Mar 2026 12:49:07 +0100
Message-ID: <20260304114921.31042-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E4BBB1FF48C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10951-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Action: no action

Hi,

The following patchset contains Netfilter updates for *net-next*,
including changes to IPv6 stack and updates to IPVS from Julian Anastasov.

1) ipv6: export fib6_lookup for nft_fib_ipv6 module
2) factor out ipv6_anycast_destination logic so its usable without
   dst_entry.  These are dependencies for patch 3.
3) switch nft_fib_ipv6 module to no longer need temporary dst_entry
   object allocations by using fib6_lookup() + RCU.
   This gets us ~13% higher packet rate in my tests.

Patches 4 to 8, from Eric Dumazet, zap sk_callback_lock usage in
netfilter.  Patch 9 removes another sk_callback_lock instance.

Remaining patches, from Julian Anastasov, improve IPVS, Quoting Julian:
* Add infrastructure for resizable hash tables based on hlist_bl.
* Change the 256-bucket service hash table to be resizable.
* Change the global connection table to be per-net and resizable.
* Make connection hashing more secure for setups with multiple services.

Please, pull these changes from:
The following changes since commit 4ad96a7c9e2cebbbdc68369438a736a133539f1d:

  selftests: net: add macvlan multicast test for shared source MAC (2026-03-03 18:08:13 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git tags/nf-next-26-03-04

for you to fetch changes up to f20c73b0460d15301cf1bddf0f85d060a38a75df:

  ipvs: use more keys for connection hashing (2026-03-04 11:45:45 +0100)

----------------------------------------------------------------
netfilter pull request nf-next-26-03-04

----------------------------------------------------------------

Eric Dumazet (5):
  netfilter: nf_log_syslog: no longer acquire sk_callback_lock in
    nf_log_dump_sk_uid_gid()
  netfilter: xt_owner: no longer acquire sk_callback_lock in mt_owner()
  netfilter: nft_meta: no longer acquire sk_callback_lock in
    nft_meta_get_eval_skugid()
  netfilter: nfnetlink_log: no longer acquire sk_callback_lock
  netfilter: nfnetlink_queue: no longer acquire sk_callback_lock

Florian Westphal (4):
  ipv6: export fib6_lookup for nft_fib_ipv6
  ipv6: make ipv6_anycast_destination logic usable without dst_entry
  netfilter: nft_fib_ipv6: switch to fib6_lookup
  netfilter: nfnetlink_queue: remove locking in nfqnl_get_sk_secctx

Julian Anastasov (5):
  rculist_bl: add hlist_bl_for_each_entry_continue_rcu
  ipvs: add resizable hash tables
  ipvs: use resizable hash table for services
  ipvs: switch to per-net connection table
  ipvs: use more keys for connection hashing

 include/linux/rculist_bl.h        |  49 +-
 include/net/ip6_route.h           |  15 +-
 include/net/ip_vs.h               | 377 ++++++++++--
 net/ipv6/fib6_rules.c             |   3 +
 net/ipv6/ip6_fib.c                |   3 +
 net/ipv6/netfilter/nft_fib_ipv6.c |  79 ++-
 net/netfilter/ipvs/ip_vs_conn.c   | 991 ++++++++++++++++++++++--------
 net/netfilter/ipvs/ip_vs_core.c   | 179 ++++++
 net/netfilter/ipvs/ip_vs_ctl.c    | 691 +++++++++++++++++----
 net/netfilter/ipvs/ip_vs_pe_sip.c |   4 +-
 net/netfilter/ipvs/ip_vs_sync.c   |  23 +
 net/netfilter/nf_log_syslog.c     |  16 +-
 net/netfilter/nfnetlink_log.c     |  19 +-
 net/netfilter/nfnetlink_queue.c   |  24 +-
 net/netfilter/nft_meta.c          |  23 +-
 net/netfilter/xt_owner.c          |  28 +-
 16 files changed, 2011 insertions(+), 513 deletions(-)

-- 
2.52.0

