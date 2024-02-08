Return-Path: <netfilter-devel+bounces-966-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677A184DF9C
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Feb 2024 12:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E991928C650
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Feb 2024 11:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D806F075;
	Thu,  8 Feb 2024 11:28:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116EB6BFCA;
	Thu,  8 Feb 2024 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391722; cv=none; b=CV9EeJxGUnj3WOR4qpo7GWOdq/TRSZrhw1YZcdk/4JSKkd0CtqdN7IOHBk5rADHX80ZE0x6zjfkWS6MF79uZ7V9gJK49qo4oWQGGdNRuOsdXxFLgIMPvWDM9iud5y1r6iTFAOn4zeiBkS8cNlUt7Go3IYerqSQ2cksISDQApdRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391722; c=relaxed/simple;
	bh=mjZCA2oTXaPNqvxrblpxeZdt1vWT+fBYjE0eqqSr9wU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pWJn7iNLz4VlNwuGpKhjnx+kJPVmuyCzlI0Erc2dOnHwMUwn9hX+3tT9M7Waurfvpnxo/55zhSjgMTXldBTLulqOI9Qgz5PTw2T1eUqH6CMq93BWCW5pvSiV0gKz2HPDRcM3IPD9Bod41jqC95Zy8Jv7OqcdSRXp5e94nH+9pfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	kadlec@netfilter.org
Subject: [PATCH net,v2 00/13] Netfilter fixes for net
Date: Thu,  8 Feb 2024 12:28:21 +0100
Message-Id: <20240208112834.1433-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This v2 including changes requested by Paolo Abeni.

-o-

Hi,

The following patchset contains Netfilter fixes for net:

1) Narrow down target/match revision to u8 in nft_compat.

2) Bail out with unused flags in nft_compat.

3) Restrict layer 4 protocol to u16 in nft_compat.

4) Remove static in pipapo get command that slipped through when
   reducing set memory footprint.

5) Follow up incremental fix for the ipset performance regression,
   this includes the missing gc cancellation, from Jozsef Kadlecsik.

6) Allow to filter by zone 0 in ctnetlink, do not interpret zone 0
   as no filtering, from Felix Huettner.

7) Reject direction for NFT_CT_ID.

8) Use timestamp to check for set element expiration while transaction
   is handled to prevent garbage collection from removing set elements
   that were just added by this transaction. Packet path and netlink
   dump/get path still use current time to check for expiration.

9) Restore NF_REPEAT in nfnetlink_queue, from Florian Westphal.

10) map_index needs to be percpu and per-set, not just percpu.
    At this time its possible for a pipapo set to fill the all-zero part
    with ones and take the 'might have bits set' as 'start-from-zero' area.
    From Florian Westphal. This includes three patches:

    - Change scratchpad area to a structure that provides space for a
      per-set-and-cpu toggle and uses it of the percpu one.

    - Add a new free helper to prepare for the next patch.

    - Remove the scratch_aligned pointer and makes AVX2 implementation
      use the exact same memory addresses for read/store of the matching
      state.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-24-02-08

Thanks.

----------------------------------------------------------------

The following changes since commit eef00a82c568944f113f2de738156ac591bbd5cd:

  inet: read sk->sk_family once in inet_recv_error() (2024-02-04 16:06:53 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-24-02-08

for you to fetch changes up to 5a8cdf6fd860ac5e6d08d72edbcecee049a7fec4:

  netfilter: nft_set_pipapo: remove scratch_aligned pointer (2024-02-08 12:24:02 +0100)

----------------------------------------------------------------
netfilter pull request 24-02-08

----------------------------------------------------------------
Felix Huettner (1):
      netfilter: ctnetlink: fix filtering for zone 0

Florian Westphal (4):
      netfilter: nfnetlink_queue: un-break NF_REPEAT
      netfilter: nft_set_pipapo: store index in scratch maps
      netfilter: nft_set_pipapo: add helper to release pcpu scratch area
      netfilter: nft_set_pipapo: remove scratch_aligned pointer

Jozsef Kadlecsik (1):
      netfilter: ipset: Missing gc cancellations fixed

Pablo Neira Ayuso (7):
      netfilter: nft_compat: narrow down revision to unsigned 8-bits
      netfilter: nft_compat: reject unused compat flag
      netfilter: nft_compat: restrict match/target protocol to u16
      netfilter: nft_set_pipapo: remove static in nft_pipapo_get()
      netfilter: nft_ct: reject direction for ct id
      netfilter: nf_tables: use timestamp to check for set element timeout
      netfilter: nft_set_rbtree: skip end interval element from gc

 include/net/netfilter/nf_tables.h                  |  16 ++-
 include/uapi/linux/netfilter/nf_tables.h           |   2 +
 net/netfilter/ipset/ip_set_core.c                  |   2 +
 net/netfilter/ipset/ip_set_hash_gen.h              |   4 +-
 net/netfilter/nf_conntrack_netlink.c               |  12 +-
 net/netfilter/nf_tables_api.c                      |   4 +-
 net/netfilter/nfnetlink_queue.c                    |  13 ++-
 net/netfilter/nft_compat.c                         |  17 ++-
 net/netfilter/nft_ct.c                             |   3 +
 net/netfilter/nft_set_hash.c                       |   8 +-
 net/netfilter/nft_set_pipapo.c                     | 128 +++++++++++----------
 net/netfilter/nft_set_pipapo.h                     |  18 ++-
 net/netfilter/nft_set_pipapo_avx2.c                |  17 ++-
 net/netfilter/nft_set_rbtree.c                     |  17 +--
 .../selftests/netfilter/conntrack_dump_flush.c     |  43 ++++++-
 15 files changed, 202 insertions(+), 102 deletions(-)

