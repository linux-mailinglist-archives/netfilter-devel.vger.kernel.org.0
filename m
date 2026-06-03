Return-Path: <netfilter-devel+bounces-13014-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XHXjA7QSIGrzvQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13014-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 03 Jun 2026 13:40:36 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DF8637265
	for <lists+netfilter-devel@lfdr.de>; Wed, 03 Jun 2026 13:40:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13014-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13014-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41EBD3156398
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jun 2026 11:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD4943E9D8;
	Wed,  3 Jun 2026 11:25:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A029637418F
	for <netfilter-devel@vger.kernel.org>; Wed,  3 Jun 2026 11:25:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485927; cv=none; b=hGF4G4UeF7plTCrY+qx0KEqMpwJe9WcvyeqUHAR08Kqh2olHku0yayJ3a9H8gKhCknHIxWY4L/toiOXtohtpMEfyGZ1zIVg4l/Ji+TrLfToxwGotkzR+PTAOPhKzxXcWE0Yb+JHeYHWBfXAwK6eplbP+HyvVLUOcnJmNhKnecOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485927; c=relaxed/simple;
	bh=8p2N6iItROi9uB5nMBSUe/KuNteRpZ18WI+mw8orMj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5d1MuUiSrocPATGjekJlTM8n5R/2YKosdS+wPHYOTWbjecXijPMo9//0vCCF1xMQJ4Of/k3lE3fdcc6qlzK2rIXh6mxlYXc0az42Tpbx+6tTAwbIm9KOickKf8tVa0lM81CFtdcWCVXKjV9UAcT/JO/lIIS5fhBuDDhl0FOQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7F9C7602F8; Wed, 03 Jun 2026 13:25:23 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/3] netfilter: nf_conncount: misc bug fixes
Date: Wed,  3 Jun 2026 13:24:57 +0200
Message-ID: <20260603112513.2263-1-fw@strlen.de>
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
	TAGGED_FROM(0.00)[bounces-13014-lists,netfilter-devel=lfdr.de];
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
X-Rspamd-Queue-Id: 85DF8637265

This addresses a drive-by AI review of nf_conncount.  See patch 3 for
details.

1) Replace rb_root with a new container structure in nf_conncount to prepare
   for a per-tree sequence counter to detect concurrent modifications.

2) Split nf_conncount rbtree walk into a helper. Add find_tree_node() to
   fetch matching node so folluwp patch can reuse the function.

3) Fix tree_gc_worker wrap-around by updating gc_tree unconditionally. Add
   a sequence count to detect concurrent rbtree modifications. Add
   rcu_barrier before zapping the kmem cache during module exit.

Florian Westphal (3):
  netfilter: nf_conncount: prepare for per-tree seqcount
  netfilter: nf_conncount: split count_tree_node rbtree walk into helper
  netfilter: nf_conncount: gc and rcu fixes

 net/netfilter/nf_conncount.c | 171 ++++++++++++++++++++++++-----------
 1 file changed, 116 insertions(+), 55 deletions(-)

-- 
2.53.0


