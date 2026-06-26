Return-Path: <netfilter-devel+bounces-13484-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YxYxADVxPmrAGAkAu9opvQ
	(envelope-from <netfilter-devel+bounces-13484-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jun 2026 14:31:49 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CABA6CD023
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jun 2026 14:31:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13484-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13484-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CABE4300381A
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 Jun 2026 12:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9455B27AC4C;
	Fri, 26 Jun 2026 12:31:45 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE925B08C
	for <netfilter-devel@vger.kernel.org>; Fri, 26 Jun 2026 12:31:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782477105; cv=none; b=iX92SVeGoqfq+KjAwKYf1dqZRwpHHyCJNmthDvBJvDl6T9N4OTZSAR7YduKIrQ/8WzKvgSy9I+/IFUtiHraVhRc5hkUa2O1gujzeyyU3/us1GXbccBv15MVn/ryTMKvNpKuLS2pF+KKIQcMsKGExXSB0alhCn+qgKn8oga6hqEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782477105; c=relaxed/simple;
	bh=Kif0EMg7VDB8uLMvyEDgRLoaifq+Ali9xExMJVQfe5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMTimTdCz/1qzrKMUx/+PBUqh+09eNDi8SrPP7//gvGsflRfrnb/+TvIBdeiro0nDJMPHhwgKKpLPfuGdxHCHq28lvrdfKHdXm7N6gz/3jNW7wCgHaPHjwHiVML3SsRN6xChP3TGap9x2Va6i/szo3nbijHGEwgF8qEPUyTf/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A9098602A3; Fri, 26 Jun 2026 14:31:41 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/3] netfilter: conntrack: remove obsolete module parameters
Date: Fri, 26 Jun 2026 14:31:28 +0200
Message-ID: <20260626123131.23096-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13484-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CABA6CD023

1) Switch nf_conntrack_helper hashing from full tuple to name and L4
   protocol. Prepares for tuple removal.

2) Remove tuple from conntrack helper definitions and eliminate redundant
   protocol registrations. Add netlink policy validation to prevent protocol
   number truncation.

3) Remove obsolete conntrack module parameters.

Florian Westphal (3):
 netfilter: nf_conntrack_helper: do not hash by tuple
 netfilter: conntrack: get rid of tuple in helper definitions
 netfilter: conntrack: remove obsolete module parameters

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
 20 files changed, 108 insertions(+), 211 deletions(-)
-- 
2.53.0


