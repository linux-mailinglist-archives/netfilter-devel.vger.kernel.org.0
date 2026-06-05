Return-Path: <netfilter-devel+bounces-13067-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KuXsJLbMImpLdwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13067-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 05 Jun 2026 15:18:46 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2E364874F
	for <lists+netfilter-devel@lfdr.de>; Fri, 05 Jun 2026 15:18:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13067-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13067-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 009C2301A1F0
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jun 2026 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEC53F4857;
	Fri,  5 Jun 2026 13:11:34 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB93F4841
	for <netfilter-devel@vger.kernel.org>; Fri,  5 Jun 2026 13:11:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665094; cv=none; b=hhUaRjCDPD0dJczh62DP7nUnugToRnKrTCOYTqvdXmKTHIMOJGCmp7sxcIG5UcTiNmeS+j6XwBpk4VnewD615rM/0J4yBjSSPghFwE089MTRxoNOCqojhv6kxd4UKUEwNkizveeq6ejjieFf50cHU15+bzqtZBt9P6zrKaPyLd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665094; c=relaxed/simple;
	bh=irtgDx6semsLwai5PglCFEbzAWWpVyHHsX17tk/MRZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=phFV+yBQ5ITNv/j8yO+bbWpFUi6Qj79zrsbClFeXohpH4nZnBYY+dc7RhthyY+EGJttIESZHq377pF7aim4FyUUIrv1RrN0T2GwA3ArDXFomctrWAarn0ekTA+8tRlsmWSOHvMigIDpZSsP0BkC72rksodhSmvnnzphrb+w9qkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B0E9460425; Fri, 05 Jun 2026 15:11:30 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v4 0/5] netfilter: nf_conncount: fix gc and rbtree bugs
Date: Fri,  5 Jun 2026 15:11:18 +0200
Message-ID: <20260605131123.19435-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13067-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:from_mime,strlen.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C2E364874F

v4: address even more drive by findings:
    - must switch to kzalloc, atm initial bitmap is random at start
      (which is harmless but wrong)
    - PREEMPT_RT needs seqcnt <-> spinlock association so preemption
      is disabled

1) Extend RCU read lock scope in ovs, conncount API requires this.
   rcu_dereference_raw should not have been used here.
   Note this adds new sparse warnings, but those are the lesser
   evil; lockdep support is more desirable wrt. rcu access correctness
   than sparse.

2) Replace rb_root with a new container structure in nf_conncount. Assign
   dedicated locks to each tree instead of a shared lock array. Use kvzalloc
   to ensure zero-initialized memory.

3) Split the count_tree_node rbtree walk into a helper. Add find_tree_node()
   to fetch matching rbtree nodes.

4) Add sequence counter to nf_conncount to detect tree modifications. Re-do
   lookups under lock if the counter changes. Prevent unsafe lockless
   iteration.

5) Fix tree_gc_worker wrap-around and protect rbtree iteration with a
   spinlock. Use disable_work_sync() and add rcu_barrier() to module exit.

Florian Westphal (5):
  netfilter: nf_conncount: callers must hold rcu read lock
  netfilter: nf_conncount: use per nf_conncount_data spinlocks
  netfilter: nf_conncount: split count_tree_node rbtree walk into helper
  netfilter: nf_conncount: add sequence counter to detect tree modifications
  netfilter: nf_conncount: gc and rcu fixes

 net/netfilter/nf_conncount.c | 230 ++++++++++++++++++++++-------------
 net/openvswitch/conntrack.c  |   2 +-
 2 files changed, 144 insertions(+), 88 deletions(-)

-- 
2.53.0


