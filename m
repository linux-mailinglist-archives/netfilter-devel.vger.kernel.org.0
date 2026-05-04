Return-Path: <netfilter-devel+bounces-12408-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC2nGxzk+Gkt2wIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12408-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 04 May 2026 20:23:24 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E434A4C265A
	for <lists+netfilter-devel@lfdr.de>; Mon, 04 May 2026 20:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E22FA301BA72
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 May 2026 18:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E103E3C62;
	Mon,  4 May 2026 18:23:21 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5972737E2EB
	for <netfilter-devel@vger.kernel.org>; Mon,  4 May 2026 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919001; cv=none; b=RjgI81HkHAYjnqnOfRTdq34yKeUXF2Nmnnrwzx1448Rlz2Vu1gKtvrYIM5CSlnooopKylk0UfN06Qxq3RXSwFcQ81VbwzYaFW0Qa2DY8mv3JOFgSHANn/uwGJZgzTyMx+58mWXp3oyq9XWiVim0oOqqloe4xVtOIcU3q20BUUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919001; c=relaxed/simple;
	bh=BUXigQIHohFdHI/Xqe2Oc2K96QJbOARLCQQFO4hM9kY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hnGW2ybX90veg6Qv0K0ZVbRwBXTUO2WcRdKCaRbGnL67qepGtTxeuRW4q9GMjgKHOz8iA+w+7XZS2YrW30q9CW156cr5omm20E4JiWFCwASRCLusiCKWfsuxeTl5N9qcX71Ooo6b8K7aT7iHMvkmU0wfWwtREah43eGYEiXgQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 615A46079C; Mon, 04 May 2026 20:23:17 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v2 nf 0/8] netfilter: xtables: fix module load and teardown races
Date: Mon,  4 May 2026 20:22:12 +0200
Message-ID: <20260504182310.1916-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E434A4C265A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-12408-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.838];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid]

v2:
sashiko hints that load part is also broken.  Templates must be removed
first (exit) and added last (init).  Patch 8 (new in this version) does
this.  Patch 7 has been amended to fix ebtables init and exit handlers.

1) Allow initial x_tables table replacement without emitting an audit log
message. Delay the register message until after hooks are wired up to
avoid unnecessary unregister logs during error unwinding.

2) Fix a NULL dereference by allocating hook ops before adding the table to
the per-netns list. Use `synchronize_rcu()` during error unwinding to
ensure the table stops processing packets before teardown. Defer audit log
register message until all operations succeed.

3) Refactor xtables to use a single `xt_unregister_table_pre_exit` function.
Eliminate code duplication by centralizing table unregistration logic
within the xtables core. ebtables cannot be changed due to incompatibility.

4) Unregister xtables templates before module removal. This prevents
a race condition where userspace instantiates a new table after the pernet
unreg removed the current table.

5) Add `xtables_unregister_table_exit` to fully unregister netfilter tables
during module removal. Unlink the table from dying lists, then free hook
operations.

6) Implement a two-stage removal scheme for ebtables following the x_tables
pattern. Assign table->ops while holding the ebt mutex to prevent exposing
partially-filled structures.

7) Fix ebtables module initialization race. Register the template last in
table initialization functions. Prevent table instantiation before pernet
operations are available.

8) Fix a race condition in x_tables module initialization. Ensure pernet ops
are fully set up before exposing the table to userspace.

Florian Westphal (8):
  netfilter: x_tables: allow initial table replace without emitting
    audit log message
  netfilter: xtables: allocate hook ops while under mutex
  netfilter: x_tables: add and use xt_unregister_table_pre_exit
  netfilter: x_tables: unregister the templates first
  netfilter: x_tables: add and use xtables_unregister_table_exit
  netfilter: ebtables: move to two-stage removal scheme
  netfilter: ebtables: close dangling table module init race
  netfilter: x_tables: close dangling table module init race

 include/linux/netfilter/x_tables.h        |   4 +-
 include/linux/netfilter_arp/arp_tables.h  |   1 -
 include/linux/netfilter_ipv4/ip_tables.h  |   1 -
 include/linux/netfilter_ipv6/ip6_tables.h |   1 -
 net/bridge/netfilter/ebtable_broute.c     |  14 +-
 net/bridge/netfilter/ebtable_filter.c     |  12 +-
 net/bridge/netfilter/ebtable_nat.c        |  12 +-
 net/bridge/netfilter/ebtables.c           |  60 +++++---
 net/ipv4/netfilter/arp_tables.c           |  53 +------
 net/ipv4/netfilter/arptable_filter.c      |  27 ++--
 net/ipv4/netfilter/ip_tables.c            |  59 +-------
 net/ipv4/netfilter/iptable_filter.c       |  27 ++--
 net/ipv4/netfilter/iptable_mangle.c       |  29 ++--
 net/ipv4/netfilter/iptable_nat.c          |   6 +-
 net/ipv4/netfilter/iptable_raw.c          |  26 ++--
 net/ipv4/netfilter/iptable_security.c     |  23 +--
 net/ipv6/netfilter/ip6_tables.c           |  56 +------
 net/ipv6/netfilter/ip6table_filter.c      |  26 ++--
 net/ipv6/netfilter/ip6table_mangle.c      |  27 ++--
 net/ipv6/netfilter/ip6table_nat.c         |   6 +-
 net/ipv6/netfilter/ip6table_raw.c         |  24 +--
 net/ipv6/netfilter/ip6table_security.c    |  27 ++--
 net/netfilter/x_tables.c                  | 177 ++++++++++++++++++----
 23 files changed, 359 insertions(+), 339 deletions(-)

-- 
2.53.0


