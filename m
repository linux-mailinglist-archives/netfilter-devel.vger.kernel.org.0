Return-Path: <netfilter-devel+bounces-13151-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gP7FFvD/J2rm6wIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13151-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 13:58:40 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD58965FC0D
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 13:58:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13151-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13151-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D877B3044F0A
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jun 2026 11:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88642403E97;
	Tue,  9 Jun 2026 11:52:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE3403150
	for <netfilter-devel@vger.kernel.org>; Tue,  9 Jun 2026 11:52:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005930; cv=none; b=J8NTyG7s36vhv3c78fOl7aej58X39LCl0jAOagfrqDjpmDjRX2wYHRXH5RnFcVEAinAQwWuziqy49boEx/Vdso8600SWvdSoKhmSypuToPykMaTbCF/goAsPocc9pZLPnMBC1y77jFJXhqDZP1Yyfl67lRLd0KVxkTG+orQOX20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005930; c=relaxed/simple;
	bh=D4DETkj5WF4HGieA6/01XgKkupR7dp6vRFrOTon2b+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PnEZ0vfAW54UdAKD+M4nJEYBGjsHhi9MjaAec8IggZQKvLM95ekFq1UV3o3KSHQaKDVAHDC6mDdjCXootfdK+pEZO3yyCrMGYuTYnT5IYeLLZaLXjNBk8uRhR6wiP8MWIE9jAwOzZLP64Bok1+dSo4pHE51t75wEtvIvOUoKUUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D9A3B605BD; Tue, 09 Jun 2026 13:52:06 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v3 nf-next 0/3] netfilter: add restrictions/validations for packet rewrite
Date: Tue,  9 Jun 2026 13:51:52 +0200
Message-ID: <20260609115201.2563-1-fw@strlen.de>
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
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-13151-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD58965FC0D

Changes since v2:
 - In patch 1, disable write for NF_BRIDGE. Remove ARP handling.
 ARP is not supported and NF_BRIDGE doesn't appear to be useful as-is
 given userspace gets L3 headers only and needs to use NFQA_L2HDR nl
 attr to alter mac header.

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

 net/netfilter/nfnetlink_queue.c | 170 ++++++++++++++++++++
 net/netfilter/nft_payload.c     | 270 ++++++++++++++++++++++++++++++++
 2 files changed, 440 insertions(+)

-- 
2.53.0


