Return-Path: <netfilter-devel+bounces-13506-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KRkwA+9tQmrb6wkAu9opvQ
	(envelope-from <netfilter-devel+bounces-13506-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jun 2026 15:06:55 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F986DAC0A
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jun 2026 15:06:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13506-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13506-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D64AB302FE95
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jun 2026 12:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB59401A3C;
	Mon, 29 Jun 2026 12:58:34 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D63D3FE363
	for <netfilter-devel@vger.kernel.org>; Mon, 29 Jun 2026 12:58:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737914; cv=none; b=ZtHyTJQTn8wEpji756Grt2BVI0wPr+q8SrEiLvVv7v1fHm8rfyeF6H254MZolO+VMlXTxc/PC+/m0s2zn+cihru7ufMvjo9t9A1VEvEUOTPegALIW+szGUJxj2ZVKLf99VaIbfk9lqBzr+lX8tt+oQlw6UNQYYU11BL7N1J16T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737914; c=relaxed/simple;
	bh=G14ViOcAZ00AYAgNoUKDC/nmF0ePGHQuWObxlIw4t68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PTnNCS2FsbRIepsUANqTiQVEWixlZjQ/F3ampu4k+D6LylDQQTeDBJspFnm7C2kDbEA/0OIIe7p4cdDuSswYwRsu0/rBumkP6Pb+s+a+Tu1OX4bE+Pzpd/5VMitTUZUquyyzV/16NllyGmn+ESveWAD8z0EObrfLk0luPQytxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 428096032C; Mon, 29 Jun 2026 14:58:31 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v2 0/3] netfilter: conntrack: remove obsolete module parameters
Date: Mon, 29 Jun 2026 14:58:20 +0200
Message-ID: <20260629125823.1749-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13506-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5F986DAC0A

v2: build breakage fix in 2/3.

1) Switch nf_conntrack_helper hashing from full tuple to name and L4
   protocol. Prepares for tuple removal.

2) Remove tuple from conntrack helper definitions and eliminate redundant
   protocol registrations. Add netlink policy validation to prevent protocol
   number truncation.

3) Remove obsolete conntrack module parameters.

Florian Westphal (4):
  netfilter: nf_conntrack_helper: do not hash by tuple
  netfilter: conntrack: get rid of tuple in helper definitions
  netfilter: conntrack: remove obsolete module parameters
  netfilter: nft_ct: support expectation creation for natted flows

 include/linux/netfilter/nf_conntrack_h323.h |  2 -
 include/linux/netfilter/nf_conntrack_pptp.h |  2 -
 include/linux/netfilter/nf_conntrack_sane.h |  2 -
 include/linux/netfilter/nf_conntrack_tftp.h |  2 -
 include/net/netfilter/nf_conntrack_helper.h | 10 ++-
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c |  2 +-
 net/netfilter/nf_conntrack_amanda.c         |  4 +-
 net/netfilter/nf_conntrack_broadcast.c      |  2 -
 net/netfilter/nf_conntrack_ftp.c            | 32 +++------
 net/netfilter/nf_conntrack_h323_main.c      | 10 +--
 net/netfilter/nf_conntrack_helper.c         | 77 +++++++++------------
 net/netfilter/nf_conntrack_irc.c            | 27 +++-----
 net/netfilter/nf_conntrack_netbios_ns.c     |  2 -
 net/netfilter/nf_conntrack_ovs.c            |  6 +-
 net/netfilter/nf_conntrack_pptp.c           |  2 +-
 net/netfilter/nf_conntrack_sane.c           | 34 +++------
 net/netfilter/nf_conntrack_sip.c            | 45 ++++--------
 net/netfilter/nf_conntrack_snmp.c           |  4 +-
 net/netfilter/nf_conntrack_tftp.c           | 33 +++------
 net/netfilter/nfnetlink_cthelper.c          | 21 +++---
 net/netfilter/nft_ct.c                      | 15 ++++
 net/sched/act_ct.c                          |  4 +-
 22 files changed, 125 insertions(+), 213 deletions(-)

-- 
2.53.0


