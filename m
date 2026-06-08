Return-Path: <netfilter-devel+bounces-13122-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OhqrAmD1JmomowIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13122-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 08 Jun 2026 19:01:20 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE3B659082
	for <lists+netfilter-devel@lfdr.de>; Mon, 08 Jun 2026 19:01:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13122-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13122-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED4F231E7C18
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jun 2026 15:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F173F9A1C;
	Mon,  8 Jun 2026 15:23:33 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529063CD8B8
	for <netfilter-devel@vger.kernel.org>; Mon,  8 Jun 2026 15:23:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932213; cv=none; b=OPL7R0/4IfWLXK5+k4I8gR2UxRM2BOXJj152uh4Z0BGEHiEObo84Ahwwc4KigG4UcrLqlek+AHAk8GjRwpv1HyTKQ1EykH0sTfaydWmT1aLQbTPCVstefU+cvvGgnyGlrYfnoFpWzPjaBdcvCLU5qKsh+Ns08CmycOnuNRSVWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932213; c=relaxed/simple;
	bh=NNZUII/aM5LYLedMd6G8rsaEm7NWYjrF+sHOZtpWXKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rv1hmF5kQ/zlQKeMsyChVF9vbIhx3jNNZLN+igL2HEWouWamL9UiftUgIKc07apindneyv/s6riGo8fINQ9YvStazlJTB27B/7WoTZAxhvM9Yowm5jcFbwyscZroEAVcNb74mzuhFgfDS+D5aJxR1A/VjZVOWp+uHdpGGKozJAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id E141D60491; Mon, 08 Jun 2026 17:23:29 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v2 0/3] netfilter: add restrictions/validations for packet rewrite
Date: Mon,  8 Jun 2026 17:23:15 +0200
Message-ID: <20260608152324.20700-1-fw@strlen.de>
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
	TAGGED_FROM(0.00)[bounces-13122-lists,netfilter-devel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EE3B659082

Changes since v1:
 - add patch 3.  Patches 1 and 2 are unchanged.

1) Restrict nfnetlink_queue writes to the network header. Validate IP/IPv6
   headers and disable IPv6 extension header changes. Ensure total length
   matches skb length.

2) Restrict nft_payload writes to linklayer and network header data. Prevent
   linklayer writes from spilling into network headers. Validate network
   header updates to protect IP version and length fields.

3) add restrictions to the checksum offset, without this patch 2 isn't
   sufficient because an invalid checksum offset can e.g. overwrite iph
   header length field.

This doesn't remove the userns restriction, yet.
I would like to wait a bit before re-enabling this to make sure there
are no other gaps (e.g. for encapsulated traffic).

Florian Westphal (3):
  netfilter: nfnetlink_queue: restrict writes to network header
  netfilter: nftables: restrict linklayer and network header writes
  netfilter: nftables: restrict checkum update offset

 net/netfilter/nfnetlink_queue.c | 192 +++++++++++++++++++++++
 net/netfilter/nft_payload.c     | 270 ++++++++++++++++++++++++++++++++
 2 files changed, 462 insertions(+)

-- 
2.53.0


