Return-Path: <netfilter-devel+bounces-10694-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGR8DUIJhmkRJQQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10694-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 06 Feb 2026 16:31:14 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5BEFFC05
	for <lists+netfilter-devel@lfdr.de>; Fri, 06 Feb 2026 16:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF9BB301F4B7
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Feb 2026 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFEA1DC1AB;
	Fri,  6 Feb 2026 15:31:00 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240B125A0;
	Fri,  6 Feb 2026 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391860; cv=none; b=uqWuIPSRsojPpyNBkUeCZhWmjNJo+5NqBAW1LPl3VZiiy14uVaK4Y3lty77fX9CNoi/vRnEYLPVo1RWG14oX+uC4LvWIUSKS56iW8r40KU/oY/A3k4CDcxEG0wtRGG3YYuxaaOpkWspAJ6nFd7vzffhzjVnDACrixYpUw+UaYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391860; c=relaxed/simple;
	bh=RjN4438puDtRLzc8SKUip/QTEtNvWbOl76UPOqfDivs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WE9/3A9uoKh5O0wvZoTf7DUZjdKN/xhUBjMgWUFyOB1zBSDo7iCu+N5GXqdIm91d6mkV2VLNWve7gSOOFGtw+dOoh38xDlB2yZZPn7i8fmwtyEVbk6WW1WOzNBG3+Ac3JCiHvfDEL1gs5gGcJDcBdANeUWoBeENr7rlyRYO3U98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CA3AB60345; Fri, 06 Feb 2026 16:30:57 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH v2 net-next 00/11] netfilter: updates for net-next
Date: Fri,  6 Feb 2026 16:30:37 +0100
Message-ID: <20260206153048.17570-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10694-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B5BEFFC05
X-Rspamd-Action: no action

The following patchset contains Netfilter updates for *net-next*:

1) Fix net-next-only use-after-free bug in nf_tables rbtree set:
   Expired elements cannot be released right away after unlink anymore
   because there is no guarantee that the binary-search blob is going to
   be updated.  Spotted by syzkaller.

2) Fix esoteric bug in nf_queue with udp fraglist gro, broken since
   6.11. Patch 3 adds extends the nfqueue selftest for this.

4) Use dedicated slab for flowtable entries, currently the -512 cache
   is used, which is wasteful.  From Qingfang Deng.

5) Recent net-next update extended existing test for ip6ip6 tunnels, add
   the required /config entry.  Test still passed by accident because the
   previous tests network setup gets re-used, so also update the test so
   it will fail in case the ip6ip6 tunnel interface cannot be added.

6) Fix 'nft get element mytable myset { 1.2.3.4 }' on big endian
   platforms, this was broken since code was added in v5.1.

7) Fix nf_tables counter reset support on 32bit platforms, where counter
   reset may cause huge values to appear due to wraparound.
   Broken since reset feature was added in v6.11.  From Anders Grahn.

8-11) update nf_tables rbtree set type to detect partial
   operlaps.  This will eventually speed up nftables userspace: at this
   time userspace does a netlink dump of the set content which slows down
   incremental updates on interval sets.  From Pablo Neira Ayuso.

Please, pull these changes from:
The following changes since commit 24cf78c738318f3d2b961a1ab4b3faf1eca860d7:

  net/mlx5e: SHAMPO, Switch to header memcpy (2026-02-05 18:36:06 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git tags/nf-next-26-02-06

for you to fetch changes up to 648946966a08e4cb1a71619e3d1b12bd7642de7b:

  netfilter: nft_set_rbtree: validate open interval overlap (2026-02-06 13:36:07 +0100)

----------------------------------------------------------------
netfilter pull request nf-next-26-02-06

----------------------------------------------------------------
Anders Grahn (1):
  netfilter: nft_counter: fix reset of counters on 32bit archs

Florian Westphal (5):
  netfilter: nft_set_rbtree: don't gc elements on insert
  netfilter: nfnetlink_queue: do shared-unconfirmed check before segmentation
  selftests: netfilter: nft_queue.sh: add udp fraglist gro test case
  selftests: netfilter: add IPV6_TUNNEL to config
  netfilter: nft_set_hash: fix get operation on big endian

Pablo Neira Ayuso (4):
  netfilter: nft_set_rbtree: fix bogus EEXIST with NLM_F_CREATE with null interval
  netfilter: nft_set_rbtree: check for partial overlaps in anonymous sets
  netfilter: nft_set_rbtree: validate element belonging to interval
  netfilter: nft_set_rbtree: validate open interval overlap

Qingfang Deng (1):
  netfilter: flowtable: dedicated slab for flow entry

 include/linux/u64_stats_sync.h                |  10 +
 include/net/netfilter/nf_queue.h              |   1 +
 include/net/netfilter/nf_tables.h             |   4 +
 net/netfilter/nf_flow_table_core.c            |  12 +-
 net/netfilter/nf_tables_api.c                 |  26 +-
 net/netfilter/nfnetlink_queue.c               | 123 +++---
 net/netfilter/nft_counter.c                   |   4 +-
 net/netfilter/nft_set_hash.c                  |   9 +-
 net/netfilter/nft_set_rbtree.c                | 377 ++++++++++++++----
 tools/testing/selftests/net/netfilter/config  |   1 +
 .../selftests/net/netfilter/nft_flowtable.sh  |  19 +-
 .../selftests/net/netfilter/nft_queue.sh      | 142 ++++++-
 12 files changed, 580 insertions(+), 148 deletions(-)

-- 
2.52.0

