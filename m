Return-Path: <netfilter-devel+bounces-13054-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H8vXBoyZIWqsJgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13054-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 17:28:12 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CB66416BC
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 17:28:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13054-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13054-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F36D9300690B
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Jun 2026 15:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E49231E83E;
	Thu,  4 Jun 2026 15:10:08 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF22DA759
	for <netfilter-devel@vger.kernel.org>; Thu,  4 Jun 2026 15:10:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585807; cv=none; b=fOyK1/tt4G3I5L2/O1RhPqbu4ltRIHizalqfu0MLMxm3CNem7rh7TgB62RSPWC6U9HvtdB13suUUwE9I3g9XzLQ0fmf8vvEdp+Me01LKZmwLzvM1csP0UuHHbwIPF+/Z/0jqpwj49fnBslikdFiK/dQDh2a8Qswx+zZfzMvZFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585807; c=relaxed/simple;
	bh=DKxgu0u1hviH3ZJocQ8DucuGjyx50qIkF8m3phC33II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MvjlvNaMOmyNgTjWbqZkIFHgPD2iP2PV9djrkfoZlviv9Vae5i6/sadyMTh7htZ46M/JxOcsm97orSjauF5iUQsBEuoDUbasU9B+KaMfEuEEmG22XFBSL9j/ypGl4/BLQakT2ZEdlOW7eiOucO2FmcXr28UzSpDg6UJ0dOO2drQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 6F88360337; Thu, 04 Jun 2026 17:10:04 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v3 nf-next 0/5] netfilter: nf_conncount: fix gc and rbtree bugs
Date: Thu,  4 Jun 2026 17:03:33 +0200
Message-ID: <20260604150338.163592-1-fw@strlen.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13054-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,strlen.de:from_mime,strlen.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14CB66416BC

This addresses a drive-by AI review of nf_conncount.  See patch 5 for
details.

v3: add patch 1, openvswitch breakage was not raised before.
    in patch 4, check seqcount before returning -ENOENT.
    No other changes.

1) conncount API assumes rcu read lock is held, openvswitch doesn't do
   that.  Fix this.

2) Replace rb_root with a new container structure in nf_conncount to prepare
   for a per-tree sequence counter to detect concurrent modifications.

3) Split nf_conncount rbtree walk into a helper. Add find_tree_node() to
   fetch matching node so folluwp patch can reuse the function.

4) Add a sequence count to detect concurrent rbtree modifications.

5) Move rbtree iteration under spinlock, lockless iteration is not safe.
   Do lock-break + resched + restart to not hold spinlock for too long.
   Add rcu_barrier before zapping the kmem cache during module exit.

Florian Westphal (5):
  netfilter: nf_conncount: callers must hold rcu read lock
  netfilter: nf_conncount: prepare for per-tree seqcount
  netfilter: nf_conncount: split count_tree_node rbtree walk into helper
  netfilter: nf_conncount: add sequence counter to detect tree
    modifications
  netfilter: nf_conncount: gc and rcu fixes

 net/netfilter/nf_conncount.c | 208 ++++++++++++++++++++++-------------
 net/openvswitch/conntrack.c  |   2 +-
 2 files changed, 135 insertions(+), 75 deletions(-)

-- 
2.54.0

