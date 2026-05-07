Return-Path: <netfilter-devel+bounces-12489-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK55AkUk/Wn6YAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12489-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 08 May 2026 01:46:13 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3A14F03C2
	for <lists+netfilter-devel@lfdr.de>; Fri, 08 May 2026 01:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D5AA3041AAB
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 May 2026 23:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04BE3612EC;
	Thu,  7 May 2026 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="uDCXudwa"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270ED330305;
	Thu,  7 May 2026 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197525; cv=none; b=ao33TJpIzZ3wqHWkMxzznH4fJq7btVULrZxZURP9xj9P+lRr60W6OjmrT88jYUEoM4DxudRA1EDRyQpFAUqfyo25iDiqTzJigTLrbPKInTYmQnhrhf9GzFaIiM93D7pTNrCQG1/brGUPDFPZdhHIJ/2b65pEY11b5y7KcqoN4v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197525; c=relaxed/simple;
	bh=6313JbgSj3366JDYAEs+/R0pd26r81Du1o4AG3y+t3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5OkA0NZMTQtRJn/gv3OtQjm5DdxaCILAaAXotqUbDwSsvI2Qdv6p+lfatBa8/4oa4syd3P8t9y872i7Gv6FzR80FsbWioopcxrV2MwlJILihnAJIhfnnzMV1D2RVI0+aLQp6ZeWz60LXVtaHnas6Zj6VnE+HDmv0kYw3NXnXGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=uDCXudwa; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id E8F20600BA;
	Fri,  8 May 2026 01:45:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1778197513;
	bh=c6PnoKMOyQUzQrF9GqgROkXZMQlV3PBzK7Uphy7GUZU=;
	h=From:To:Cc:Subject:Date:From;
	b=uDCXudwa09Cf1NNYYzxSZF0R8tQvC7JwQmASyr/NNek2WkY4wvYZsjpxNUrMT8cSh
	 6PMi6B7UHMKkPHmQ4N4K0L4JEqmBEfU2cUHR+NfABhSxfpl1L3cRCrnF+0HGM262ie
	 p0sJxB9FoaJEU9pVSKW72jzLw/0X1kPwcHFvO+zGoXgjLLIHODYOIdyI92BGMJTplI
	 SHxUA0j/A03emUq1BvieJcDG2RL3St1fxk7o8vpix6C2LQk3oxuApQvVpxSr8q9Yb6
	 GiK7mOhxcIGeF4pJ3a+93+B7vbGpM6uiSXWAo+/5orXjXdQw/eWgBX4aiXVI7KQcdO
	 /I5LMG7waLqLg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 00/13] Netfilter fixes for net
Date: Fri,  8 May 2026 01:44:56 +0200
Message-ID: <20260507234509.603182-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9B3A14F03C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12489-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:mid,netfilter.org:dkim]
X-Rspamd-Action: no action

Hi,

The following batch contains Netfilter fixes for net:

1) Allow initial x_tables table replacement without emitting an audit
   log message. Delay the register message until after hooks are wired up
   to avoid unnecessary unregister logs during error unwinding.
 
2) Fix a NULL dereference by allocating hook ops before adding the
   table to the per-netns list. Use `synchronize_rcu()` during error
   unwinding to ensure the table stops processing packets before
   teardown. Defer audit log register message until all operations 
   succeed.
 
3) Refactor xtables to use a single `xt_unregister_table_pre_exit`
   function. Eliminate code duplication by centralizing table
   unregistration logic within the xtables core. ebtables cannot be
   changed due to incompatibility.
 
4) Unregister xtables templates before module removal. This prevents
   a race condition where userspace instantiates a new table after the
   pernet unreg removed the current table.
 
5) Add `xtables_unregister_table_exit` to fully unregister netfilter
   tables during module removal. Unlink the table from dying lists,
   then free hook operations.
 
6) Implement a two-stage removal scheme for ebtables following the
   x_tables pattern. Assign table->ops while holding the ebt mutex to
   prevent exposing partially-filled structures.
 
7) Fix ebtables module initialization race. Register the template last
   in table initialization functions. Prevent table instantiation before
   pernet operations are available.
 
8) Fix a race condition in x_tables module initialization. Ensure
   pernet ops are fully set up before exposing the table to userspace.

9) Fix a race condition in ebtables module initialization, similar to
   previous patch.

10) Restore propagation of helper to expected connection, this is a
    fix-for-recent-fix.

11) Validate that the expectation tuple and mask netlink attributes are
    present when adding expectation via nfqueue, this fixes a possible
    null-ptr-deref.

12) Fix possible rare memleak in the SIP helper in case helper has been
    detached from conntrack entry, from Li Xiasong.

13) Fix refcount leak in nft_ct when creating custom expectation, also
    from Li Xiason.

Patches 1-9 from Florian Westphal.

10) Restore propagation of helper to expected connection, this is a
    fix-for-recent-fix.

11) Check that tuple and mask netlink attributes are set when creating an
    expectation via nfqueue.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-26-05-08

Thanks.

----------------------------------------------------------------

The following changes since commit fcee7d82f27d6a8b1ddc5bbefda59b4e441e9bc0:

  Merge tag 'net-7.1-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-05-07 10:32:03 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-26-05-08

for you to fetch changes up to 19f94b6fee75b3ef7fbc06f3745b9a771a8a19a4:

  netfilter: nft_ct: fix missing expect put in obj eval (2026-05-08 01:30:17 +0200)

----------------------------------------------------------------
netfilter pull request 26-05-08

----------------------------------------------------------------
Florian Westphal (9):
      netfilter: x_tables: allow initial table replace without emitting audit log message
      netfilter: x_tables: allocate hook ops while under mutex
      netfilter: x_tables: add and use xt_unregister_table_pre_exit
      netfilter: x_tables: unregister the templates first
      netfilter: x_tables: add and use xtables_unregister_table_exit
      netfilter: ebtables: move to two-stage removal scheme
      netfilter: ebtables: close dangling table module init race
      netfilter: x_tables: close dangling table module init race
      netfilter: bridge: eb_tables: close module init race

Li Xiasong (2):
      netfilter: nf_conntrack_sip: get helper before allocating expectation
      netfilter: nft_ct: fix missing expect put in obj eval

Pablo Neira Ayuso (2):
      netfilter: nf_conntrack_expect: restore helper propagation via expectation
      netfilter: ctnetlink: check tuple and mask in expectations created via nfqueue

 include/linux/netfilter/x_tables.h          |   4 +-
 include/linux/netfilter_arp/arp_tables.h    |   1 -
 include/linux/netfilter_ipv4/ip_tables.h    |   1 -
 include/linux/netfilter_ipv6/ip6_tables.h   |   1 -
 include/net/netfilter/nf_conntrack_expect.h |   5 +-
 net/bridge/netfilter/ebtable_broute.c       |  14 +--
 net/bridge/netfilter/ebtable_filter.c       |  14 +--
 net/bridge/netfilter/ebtable_nat.c          |  12 +-
 net/bridge/netfilter/ebtables.c             |  71 ++++++-----
 net/ipv4/netfilter/arp_tables.c             |  53 ++-------
 net/ipv4/netfilter/arptable_filter.c        |  27 +++--
 net/ipv4/netfilter/ip_tables.c              |  59 ++--------
 net/ipv4/netfilter/iptable_filter.c         |  27 +++--
 net/ipv4/netfilter/iptable_mangle.c         |  29 ++---
 net/ipv4/netfilter/iptable_nat.c            |   6 +-
 net/ipv4/netfilter/iptable_raw.c            |  26 ++--
 net/ipv4/netfilter/iptable_security.c       |  27 +++--
 net/ipv6/netfilter/ip6_tables.c             |  56 ++-------
 net/ipv6/netfilter/ip6table_filter.c        |  26 ++--
 net/ipv6/netfilter/ip6table_mangle.c        |  27 +++--
 net/ipv6/netfilter/ip6table_nat.c           |   6 +-
 net/ipv6/netfilter/ip6table_raw.c           |  24 ++--
 net/ipv6/netfilter/ip6table_security.c      |  27 +++--
 net/netfilter/nf_conntrack_broadcast.c      |   1 +
 net/netfilter/nf_conntrack_core.c           |   7 +-
 net/netfilter/nf_conntrack_expect.c         |   1 +
 net/netfilter/nf_conntrack_h323_main.c      |  12 +-
 net/netfilter/nf_conntrack_helper.c         |   5 +
 net/netfilter/nf_conntrack_netlink.c        |  21 +++-
 net/netfilter/nf_conntrack_sip.c            |  10 +-
 net/netfilter/nft_ct.c                      |   2 +
 net/netfilter/x_tables.c                    | 177 +++++++++++++++++++++++-----
 32 files changed, 415 insertions(+), 364 deletions(-)

