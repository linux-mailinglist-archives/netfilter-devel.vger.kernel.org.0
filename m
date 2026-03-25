Return-Path: <netfilter-devel+bounces-11420-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH//JL1hxGlmywQAu9opvQ
	(envelope-from <netfilter-devel+bounces-11420-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Mar 2026 23:29:17 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBBB32CFDB
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Mar 2026 23:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BD2E3030E96
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Mar 2026 22:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FCD3502A3;
	Wed, 25 Mar 2026 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="YNKOJTHR"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C021351C29;
	Wed, 25 Mar 2026 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774477594; cv=none; b=LK4+qT3r402EQl6P85zLOR2M1NEX89OH0ZnD0hzwKyGqul2g2aP/vMqy1UqU+YAyL0FJkg3UGJwpaky0TOUwbh9CL5J5iYSkOV3tBLA7WDuGD3bhkQfC6aEHWAoWWLOV+Vv1x83xjlGvmbEOG45DUtA5oxkoPFLvLHOzvS65WsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774477594; c=relaxed/simple;
	bh=pg794jaVPX8QzPqN7UckjYCBK8loy+hFCf2qk6G8d98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgE8i0P8Z6S/+k5TERAZ1VpOL9q+z5D8ZqbuYbm+1nz+7uSmeYu6hSdNEyHEK3EFMVv1jOMTRnSqVUuK8Wp8ElKo8oI+AH6oCxcVRn+zehRyoMsK5J6XXOObDwx1xWsMy09+fwAy+JPPMBaDo2qVwz2/yPoBgAPnAi3xitOvyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=YNKOJTHR; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id E3F9D600B5;
	Wed, 25 Mar 2026 23:26:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1774477583;
	bh=1xdP0sMLn1d6eA4OzBuO1xsEpVaIUqNUAmwsyF/O6i8=;
	h=From:To:Cc:Subject:Date:From;
	b=YNKOJTHR5mxbGkIG7sAfweToPuwZTqqHcosoQ41iAurRqXpiOuyv30u2DO8bSuSb4
	 s1iRCCV/q1BRyVbL3Vmj40mvGPCWkifcf7SuHAlwXoafSs0Vx1QkyywMzzr6v4eEup
	 rcuECOSUCUfCNWIaDgpQ5dc0bP4mKB3SCAYzYghy3gnt9xyh54khyoySopwshcl138
	 JAWY6Czi+ckpxFCc537Uo/qsVaHzxgWJsbv4hiQG3fDXBFgEKa+LLAkzbONFYIIpxo
	 LgYme/ZByq+BvVnLWsBb4R0CGXRdth8eA9pDOuBi3TLTDcfOMVkGx7+8HAwWwekwOw
	 BiSF04H7vuIeQ==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net,v2 00/14] Netfilter fixes for net
Date: Wed, 25 Mar 2026 23:26:01 +0100
Message-ID: <20260325222615.637793-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11420-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:dkim,netfilter.org:mid]
X-Rspamd-Queue-Id: 0DBBB32CFDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is v2, fixing an issue in patch 8/12, this PR is work from
Florian, I am pickup from his previous PR. Apologies for this late PR.
Thanks for considering this submission.

-o-

Hi,
 
The following patchset contains Netfilter fixes for *net*.

Note that most bugs fixed here stem from 2.6 days, the large PR is not
due to an increase in regressions.
 
1) Fix incorrect reject of set updates with nf_tables pipapo set
   avx2 backend.  This comes with a regression test in patch 2.
   From Florian Westphal.
 
3) Fix a syzkaller reported data race in ipset, from Jozsef Kadlecsik.
 
4) nfnetlink_log needs to zero padding to prevent infoleak to userspace,
   from Weiming Shi.
 
5) pay more attention to xtables hook masks + NFPROTO_UNSPEC.
   UNSPEC+hook_mask is only valid for ipv4, ipv6 and bridge families.
   This can cause a crash because arp family has different meaning for
   hook constants. We need to reject rule adds when we have a match that
   sets both a hook mask and proto_unspec, unless the requesting family
   is one of ip/ip6/bridge. Also from Weiming Shi.
 
6) xtables ip6t_rt module never validated that addrnr length is within the
   allowed array boundary. Reject bogus values.  From Ren Wei.
 
7) Fix high memory usage in rbtree set backend that was unwanted side-effect
   of the recently added binary search blob. From Pablo Neira Ayuso.
 
Patches 8 to 12, also from Pablo, address long-standing RCU safety bugs
in conntracks handling of expectations: We can never safely defer
a conntrack extension area without holding a reference. Yet expectation
handling does so in multiple places.  Fix this by avoiding the need to
look into the master conntrack to begin with and by extending locked
sections in a few places.

13) Fix use of uninitialized rtp_addr in the sip conntrack helper,
    also from Weiming Shi.
 
14) Add stricter netlink policy checks in ctnetlink, from David Carlier.
    This avoids undefined behaviour when userspace provides huge wscale
    value.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-26-03-25

Thanks.

----------------------------------------------------------------

The following changes since commit c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f:

  net: mana: fix use-after-free in add_adev() error path (2026-03-24 21:07:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-26-03-25

for you to fetch changes up to 09ea20890536f84d121d0ab2b007dc3f808513d7:

  netfilter: ctnetlink: use netlink policy range checks (2026-03-25 22:44:33 +0100)

----------------------------------------------------------------
netfilter pull request 26-03-25

----------------------------------------------------------------
David Carlier (1):
      netfilter: ctnetlink: use netlink policy range checks

Florian Westphal (2):
      netfilter: nft_set_pipapo_avx2: don't return non-matching entry on expiry
      selftests: netfilter: nft_concat_range.sh: add check for flush+reload bug

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix data race between add and list header in all hash types

Pablo Neira Ayuso (6):
      netfilter: nft_set_rbtree: revisit array resize logic
      netfilter: nf_conntrack_expect: honor expectation helper field
      netfilter: nf_conntrack_expect: use expect->helper
      netfilter: ctnetlink: ensure safe access to master conntrack
      netfilter: nf_conntrack_expect: store netns and zone in expectation
      netfilter: nf_conntrack_expect: skip expectations in other netns via proc

Ren Wei (1):
      netfilter: ip6t_rt: reject oversized addrnr in rt_mt6_check()

Weiming Shi (3):
      netfilter: nfnetlink_log: fix uninitialized padding leak in NFULA_PAYLOAD
      netfilter: x_tables: reject unsupported families in xt_check_match/xt_check_target
      netfilter: nf_conntrack_sip: fix use of uninitialized rtp_addr in process_sdp

 include/net/netfilter/nf_conntrack_core.h          |  5 ++
 include/net/netfilter/nf_conntrack_expect.h        | 20 ++++-
 include/uapi/linux/netfilter/nf_conntrack_common.h |  4 +
 net/ipv6/netfilter/ip6t_rt.c                       |  4 +
 net/netfilter/ipset/ip_set_core.c                  |  4 +-
 net/netfilter/nf_conntrack_broadcast.c             |  2 +-
 net/netfilter/nf_conntrack_ecache.c                |  2 +
 net/netfilter/nf_conntrack_expect.c                | 37 +++++++--
 net/netfilter/nf_conntrack_h323_main.c             | 12 +--
 net/netfilter/nf_conntrack_helper.c                | 11 +--
 net/netfilter/nf_conntrack_netlink.c               | 73 +++++++++--------
 net/netfilter/nf_conntrack_proto_tcp.c             | 10 +--
 net/netfilter/nf_conntrack_sip.c                   | 18 +++--
 net/netfilter/nfnetlink_log.c                      |  8 +-
 net/netfilter/nft_set_pipapo_avx2.c                | 20 ++---
 net/netfilter/nft_set_rbtree.c                     | 92 ++++++++++++++++++----
 net/netfilter/x_tables.c                           | 36 +++++++++
 net/netfilter/xt_devgroup.c                        |  5 ++
 .../selftests/net/netfilter/nft_concat_range.sh    | 70 +++++++++++++++-
 19 files changed, 330 insertions(+), 103 deletions(-)

