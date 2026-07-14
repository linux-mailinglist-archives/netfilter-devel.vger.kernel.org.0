Return-Path: <netfilter-devel+bounces-13942-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id edTzOT86VmpE1wAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13942-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 15:31:43 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2E175527A
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 15:31:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13942-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13942-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F9AB308945B
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCD130DEDC;
	Tue, 14 Jul 2026 13:26:43 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED88729D270
	for <netfilter-devel@vger.kernel.org>; Tue, 14 Jul 2026 13:26:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035603; cv=none; b=FEZZ+VuyW72Avz9tt1tjKi3QvcdM8MfO3f+zggT0asxLQfFmHZzO3gR4JYFsjEAjSkeiG+St1qHkKvNPD8NOROJtUGJUcnXGtyG4wHSWt4gVrI5NUWx+apARmxhUGo5YO9/xtvw4InyG5IVkFfM/pEKBTcO4Nt+oZkLXGHs4xeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035603; c=relaxed/simple;
	bh=kUBTtWjkrtBgG8YUGq+GrnwYimrCAahrT2FwiVzqS3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3P9k88WOSw5dghFgPLanHJKOv9v8jynFEzeC31CahWlBcstiBDmwyknulggFE3edyk5TTLznG0izAH7WCD9IGgCrL0WtHIKl1B7qN4VXvq2A1hBI27Td8gOy8O/9wpX7CAcxW9wi23uYotzbMNxOOCNkJieKpiW+fok8SGbxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CB62160288; Tue, 14 Jul 2026 15:18:40 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: kadlec@netfilter.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH RFC nf-next 00/12] netfilter: ipset: convert to rhashtable
Date: Tue, 14 Jul 2026 15:18:16 +0200
Message-ID: <20260714131828.10685-1-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13942-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:kadlec@netfilter.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:from_mime,strlen.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A2E175527A

Hi,

This is an initial RFC patchset to convert the hash types to rhashtable.
Main conversion is in patch 8.  First patches contain small drive-by
fixes, patches after 8 contain further simplifications/cleanups.
Last patch adds back the FORCEADD support dropped in the conversion
commit (diff was getting too large...).

The next step is to go through the ipset test failures and figure out
which ones hint at actual bugs and which ones are just harmless cosmetic
issues (that could be suppressed by tinkering with diff.sh in ipset tests).

Notable likely valid remaining bugs:
 - iphash: IP: Compare sorted save and restore: [..] FAILED
 - hash:net,iface.t: Check 10.0.1.1 with eth0:
 Failed test: ../src/ipset [..] 10.0.1.1,eth0
 Warning: 10.0.1.1,eth0 is in set test.

I'd like to eventually get rid of more set->lock places, remove all
usage of rcu_dereference_protected(.. , 1), but thats not too urgent
atm.

1) Rework ipset CIDR bookkeeping.  I had to remove this one from the last
nf batch at the last minute because of a buildbot report. See next patch.

2) Fix a few nits in patch 1), to be squash-merged.

3) Add small wrappers for hash and bucket sizes to reduce noise in the
actual conversion patch.

4) add and use tmtype_del_cidr_all helper to simplify the upcoming
rewrite.

5) Use ip_set_init_comment_slow to prevent race conditions in hash ipset
types. Add lockdep annotations.

6) Same as 5, but for remove: adds ip_set_ext_destroy_slow.

7) Add rhashtable boilerplate stubs to ipset. Initialize and destroy the
rhashtable without ever adding elements.

8) Replace ipset's internal hash table with rhashtable.  FORCEADD is
removed here, and added back in last patch.

9) Use plain rcu_read_lock, not _bh variants.

10) Better lockdep annotations in ipset_dereference. Add assertions to
more places.

11) Remove the last region lock usage in ipset. Move lock responsibility to
kadt, uadt, and flush callbacks.

12) Re-add forceadd support for rhashtable in ipset. Implement
mtype_remove_random() to evict elements when the set is full.

Florian Westphal (11):
  netfilter: ipset: rework cidr bookkeeping fixups
  netfilter: ipset: add small wrappers for hash and bucket sizes
  netfilter: ipset: add and use mtype_del_cidr_all helper
  netfilter: ipset: add and use ip_set_init_comment_slow
  netfilter: ipset: add and use ip_set_ext_destroy_slow
  netfilter: ipset: add rhashtable boilerplate stubs
  netfilter: ipset: replace internal hash table with rhashtable
  netfilter: ipset: use plain rcu_read_lock
  netfilter: ipset: use correct lockdep annotation in ipset_dereference
  netfilter: ipset: remove last region lock usage
  netfilter: ipset: re-add forceadd support for rhashtable

Jozsef Kadlecsik (1):
  netfilter: ipset: rework cidr bookkeeping

 include/linux/netfilter/ipset/ip_set.h       |   44 +-
 net/netfilter/ipset/ip_set_bitmap_gen.h      |    6 +
 net/netfilter/ipset/ip_set_bitmap_ip.c       |   11 +-
 net/netfilter/ipset/ip_set_bitmap_ipmac.c    |    9 +-
 net/netfilter/ipset/ip_set_bitmap_port.c     |   11 +-
 net/netfilter/ipset/ip_set_core.c            |   35 +-
 net/netfilter/ipset/ip_set_hash_gen.h        | 1552 ++++++------------
 net/netfilter/ipset/ip_set_hash_ipportnet.c  |    4 +-
 net/netfilter/ipset/ip_set_hash_net.c        |    4 +-
 net/netfilter/ipset/ip_set_hash_netiface.c   |    4 +-
 net/netfilter/ipset/ip_set_hash_netnet.c     |   12 +-
 net/netfilter/ipset/ip_set_hash_netport.c    |    4 +-
 net/netfilter/ipset/ip_set_hash_netportnet.c |   12 +-
 net/netfilter/ipset/ip_set_list_set.c        |   13 +
 14 files changed, 629 insertions(+), 1092 deletions(-)

-- 
2.54.0

