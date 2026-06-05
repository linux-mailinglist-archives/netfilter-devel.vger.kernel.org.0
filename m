Return-Path: <netfilter-devel+bounces-13075-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eaZzFVnjImpgewEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13075-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 05 Jun 2026 16:55:21 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1E6490B1
	for <lists+netfilter-devel@lfdr.de>; Fri, 05 Jun 2026 16:55:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13075-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13075-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F27530EB776
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jun 2026 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F5E3CFF7A;
	Fri,  5 Jun 2026 14:44:20 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793163DD84E
	for <netfilter-devel@vger.kernel.org>; Fri,  5 Jun 2026 14:44:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670660; cv=none; b=gM4kRT/H6naLskLVEis4efjOBiKyKBvLX6TvAFDoOikjUlhl1ISfpP1H7QNCVfXAEpMq01JQbJGnCdkYrI0JDe9KawoDvNGL4pKvtiSQfBO9qP5g2/V7csAOpauftQgl9Z10m4cx4upfrHLxJBAdAdXRCATH+P3de482eBON9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670660; c=relaxed/simple;
	bh=Rbdq2yIjEMb2EQ6jgMfojByqUy4+ZJB56W1L/pOZPLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZfV0lKz0pvt0JgPOCgYSPE+0vQaqOJLez9qqP5VDqBiYirDL7my5DPiwKKKvQgvnX0FzN95UZDz3yfSz+pcXybWTc0WhhHG0WuCjROEckaq1CszFVtZsEQ4iJBi2E9BV0Nxhj2PBTnS05bY76/9dqbNCXcc4vlaO8VTn9tdCYxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id BD89660425; Fri, 05 Jun 2026 16:44:12 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/2] netfilter: add restrictions/validations for packet rewrite
Date: Fri,  5 Jun 2026 16:44:03 +0200
Message-ID: <20260605144405.13010-1-fw@strlen.de>
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
	TAGGED_FROM(0.00)[bounces-13075-lists,netfilter-devel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,strlen.de:from_mime,strlen.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFC1E6490B1

Changes since RFC:
 - nfqueue: allow ipv6 extension headers, but do not allow add/removal.
   This would need more work.
 - nfqueue: remove PRE_ROUTING exception, always validate ipoptions.
   Else we'd have to start changing skb transport header offset too.

 - nft_payload: allow setting a 0 ttl

1) Restrict nfnetlink_queue writes to the network header. Validate IP/IPv6
   headers and disable IPv6 extension header changes. Ensure total length
   matches skb length.

2) Restrict nft_payload writes to linklayer and network header data. Prevent
   linklayer writes from spilling into network headers. Validate network
   header updates to protect IP version and length fields.

This doesn't remove the userns restriction, yet.
I would like to wait a bit before re-enabling this to make sure there
are no other gaps (e.g. for encapsulated traffic).

Florian Westphal (2):
  netfilter: nfnetlink_queue: restrict writes to network header
  netfilter: nftables: restrict linklayer and network header writes

 net/netfilter/nfnetlink_queue.c | 193 ++++++++++++++++++++++++++++++++
 net/netfilter/nft_payload.c     | 170 ++++++++++++++++++++++++++++
 2 files changed, 363 insertions(+)

-- 
2.53.0


