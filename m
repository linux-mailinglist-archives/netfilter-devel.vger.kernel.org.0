Return-Path: <netfilter-devel+bounces-13198-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R1xqLHKTKWrBZwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13198-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 18:40:18 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1873366B942
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 18:40:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=OIsTubbR;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13198-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13198-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED48233B5D38
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965792D8378;
	Wed, 10 Jun 2026 16:16:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E526233929;
	Wed, 10 Jun 2026 16:16:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108197; cv=none; b=XFyTILgU5wPpo1qKnhw/slGdUpZ09bntBK1YvL+um3oN/kSdfkepI/2yAFpbpNEY+oHNGF3YC2rQyytuQFrT8wXKJ/dn1OUgb0ezPTjov3BHIr1qxmuZ2gp6RHdlB01bcVjvKioqdQIFhzpSzIPExS/ruEHV24rAaiqoFSI7CsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108197; c=relaxed/simple;
	bh=hUM8jKlphMPt/PACxiOeB5cnIxEskPEFQjhk8b+quXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCe2NAiotg4/FlcTCY9gX26ul9e5PcJIfdiyXqySlVHoUgRTX/+05q1oWciUwCwA1uV+6HsZifG1HDbcWcyLkvLBKOFhK/zWFtFnjFcAXVg0HhmkE9o0mQ4Nl9kOaFAtrysGv8KEOuKLgmloymYY09zUrQwJbpcQmpOJsWgQZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=OIsTubbR; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id C63DD601A5;
	Wed, 10 Jun 2026 18:16:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781108193;
	bh=lUtNxWEhERt4m2r/xPglTQKdZUAIuGh+eAOkPsujlHM=;
	h=From:To:Cc:Subject:Date:From;
	b=OIsTubbRCILYF0x+amYAgZkjFsMm2sbkJDRqkRFe1CtD/Fvs2kIUHzWpF5SnAqRUy
	 rnbe6pR9f2wSD4/roC7q8BZ4dQj3xKlWlfBL6M9aO7DDQL8nIV1DzlFX20DhW1ALbj
	 +UkPpXS0Du73unHDZt2ckoUM3G68jJYTwFcWfjp7sirhFAfjaOZ5wkT0Fb9QZSeQYE
	 CqJVtRYFpusytM+Sram5UVqbwXy7+wsXH0KQD+Jbcu643KdEhpr+tmS6cexJHFcqzQ
	 fWoCqaRypr+Mox34v7qlINruo78O88EqMdRxbPVwx6m8ZPNV4Vt4nKcPetOOsbt3ot
	 UUiXfbLSjnvlg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 0/8] Netfilter fixes for net
Date: Wed, 10 Jun 2026 18:16:20 +0200
Message-ID: <20260610161629.214092-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13198-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netfilter.org:dkim,netfilter.org:mid,netfilter.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1873366B942

Hi,

The following patchset contains Netfilter fixes for net:

1) Revalidate bridge ports, add missing NULL checks to fetch the bridge
   device by the port. From Florian Westphal.

2) Fix netdevice refcount leak in the error path of nft_fwd hardware
   offload function, also from Florian.

3) Unregister helper expectfn callback on conntrack helper module
   removal, otherwise dangling pointer remains in place,
   from Weiming Shi.

4) Fix possible pointer infoleak in getsockopt() IPT_SO_GET_ENTRIES,
   From Kyle Zeng.

5) Validate that device MAC header is present before nf_syslog
   accesses it. From Xiang Mei.

6-8) Three patches to address a possible infoleak of stale stack
     data in three nf_tables expressions, due to mismatch in the
     _init() and _eval() function which is possible since 14fb07130c7d.
     From Davide Ornaghi and Florian Westphal.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-26-06-10

Thanks.

----------------------------------------------------------------

The following changes since commit 4aacf509e537a711fa71bca9f234e5eb6968850e:

  net: mv643xx: fix OF node refcount (2026-06-04 18:40:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-26-06-10

for you to fetch changes up to c7d573551f9286100a055ef696cde6af54549677:

  netfilter: nft_meta_bridge: fix stale stack leak via IIFHWADDR register (2026-06-10 18:00:32 +0200)

----------------------------------------------------------------
netfilter pull request 26-06-10

----------------------------------------------------------------
Davide Ornaghi (2):
      netfilter: nft_fib: fix stale stack leak via the OIFNAME register
      netfilter: nft_meta_bridge: fix stale stack leak via IIFHWADDR register

Florian Westphal (3):
      netfilter: revalidate bridge ports
      netfilter: nf_tables_offload: drop device refcount on error
      netfilter: nft_exthdr: fix register tracking for F_PRESENT flag

Kyle Zeng (1):
      netfilter: x_tables: avoid leaking percpu counter pointers

Weiming Shi (1):
      netfilter: nf_conntrack: destroy stale expectfn expectations on unregister

Xiang Mei (1):
      netfilter: nf_log: validate MAC header was set before dumping it

 include/net/netfilter/nf_conntrack_helper.h |  1 +
 net/bridge/netfilter/ebt_dnat.c             |  4 +-
 net/bridge/netfilter/ebt_redirect.c         | 16 +++++---
 net/bridge/netfilter/nft_meta_bridge.c      |  2 +
 net/ipv4/netfilter/arp_tables.c             | 15 +++----
 net/ipv4/netfilter/ip_tables.c              | 15 +++----
 net/ipv4/netfilter/nf_nat_h323.c            |  2 +
 net/ipv4/netfilter/nft_fib_ipv4.c           |  2 +-
 net/ipv6/netfilter/ip6_tables.c             | 15 +++----
 net/ipv6/netfilter/nft_fib_ipv6.c           |  2 +-
 net/netfilter/nf_conntrack_helper.c         | 19 +++++++++
 net/netfilter/nf_dup_netdev.c               |  6 ++-
 net/netfilter/nf_log_syslog.c               |  4 +-
 net/netfilter/nf_nat_core.c                 |  2 +
 net/netfilter/nf_nat_sip.c                  |  1 +
 net/netfilter/nfnetlink_log.c               | 23 +++++++++--
 net/netfilter/nfnetlink_queue.c             | 64 +++++++++++++++++++++++++----
 net/netfilter/nft_exthdr.c                  |  3 ++
 net/netfilter/nft_fib.c                     |  6 +++
 19 files changed, 151 insertions(+), 51 deletions(-)

