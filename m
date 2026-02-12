Return-Path: <netfilter-devel+bounces-10746-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GRgH93GjWnT6gAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10746-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 13:26:05 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 143BC12D730
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 13:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D0073051FF7
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 12:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88992357A37;
	Thu, 12 Feb 2026 12:25:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB52FF150
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Feb 2026 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770899156; cv=none; b=qledrBD0CyEFAgK9YZX9ZndhUSVB5B1SP/03UZrBaJf1iEI4aJ/RDfARlYWe2vPaxiaDHl1POppCcz/Ln7jmHmVEUxcYD8Ud00FmtDjY8ZMbEN3qDzlp2zukUUv7+9RaAHWUa9VnQS9jmmobozlSXCGxru+As1EDZc165ZyKLm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770899156; c=relaxed/simple;
	bh=RGIgWOZYgCxgNimn1XzhG0mjgUy6sbIBP8vdWX/N97c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gAtsst2afgJYtfbpqCOoT7g95w0dPusGN8DWJctgUceYEEfbfp84p2mgygmzY8GBYiv74J7qY9I0v20lpFgOYtDGrT8pbjJhp+1UQ9caXzLHlkRDi9Iyk+Q45dBsY9pah7w9N3ezmHbce0UdGmey3R8MGILL4/dft1OqMxoJr2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C50366063D; Thu, 12 Feb 2026 13:25:52 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/2] netfilter: nft_fib_ipv6: switch to fib6_lookup
Date: Thu, 12 Feb 2026 13:25:07 +0100
Message-ID: <20260212122547.10437-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10746-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 143BC12D730
X-Rspamd-Action: no action

First patch is necessary to make this work with CONFIG_IPV6=m,
I'll pass the patch to netdev@ once net-next reopens.

Second patch provides ~12% ipv6 match speedup for the fib
expression by avoiding dst allocation+refcounts.

I'll place both patches in nf-next:testing until net-next reopens.

Florian Westphal (2):
  ipv6: export fib6_lookup for nft_fib_ipv6
  netfilter: nft_fib_ipv6: switch to fib6_lookup

 net/ipv6/fib6_rules.c             |  3 ++
 net/ipv6/netfilter/nft_fib_ipv6.c | 79 +++++++++++++++++++------------
 2 files changed, 52 insertions(+), 30 deletions(-)

-- 
2.52.0


