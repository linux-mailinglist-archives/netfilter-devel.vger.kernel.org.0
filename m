Return-Path: <netfilter-devel+bounces-11946-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIkJIeM74Gk4dwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11946-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Apr 2026 03:31:15 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750640974C
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Apr 2026 03:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A4B6303E121
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Apr 2026 01:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6AD286AC;
	Thu, 16 Apr 2026 01:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="ihet1Z2Q"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9281D1C01;
	Thu, 16 Apr 2026 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776303070; cv=none; b=BmpH/CY7yNruN8ZImZx64aOtR3NruaW9/ucXeILxlChpmxdoeeesssq3o4CDcGst28qqeqTyO3Zm2TJdoHSVyxAdlkzWc513GzocHvtkSJR8vWjpT6GbH3LSDdfhNVy00l3eUnvqCG+t/AiTxdyl2Y/5PDMsFdXwxWm0qSAVy2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776303070; c=relaxed/simple;
	bh=W4J1g0SGdTYd55MVE62p7vJvZcT65hHbWjiLkYDBLeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A72t3iqamTiYhSM/AiJUjIujSGxUtq/D94dN1fS7XnJZJJbPzjnkoBGqtdAcsTVjnvp+bLo5dQDuphGz1GTinjf6IQXDLexw6buASKOUA9AblzeX4IPeIBZugL/1a4rtfkStpWhnnWN+x9FMeccy4/ltbh/WHe9ASLSdsnt9vak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=ihet1Z2Q; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id CEF686017D;
	Thu, 16 Apr 2026 03:31:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776303066;
	bh=kb1iEJJ1xJNOPhsWOO3F8fIgcWoAxwR1KMm4A/CB50k=;
	h=From:To:Cc:Subject:Date:From;
	b=ihet1Z2QcuM9GKWTKjxhk8sSzxE+U4wD0tD5/eMyJ+3nfQ2JVTQCbQopBSiI3P2oy
	 a48GgLmpStL7/cBu6+dJUUFxNj6IY35PgX3MC6bwAvFFkkXJdjtuw0ynkb1OfvMaK+
	 I8qRGr6UOw3QNNt+/4pkGMSt/AuwqMyW1Zcapvb5Q1vtdhuD2ieBzHauDeI20XSexS
	 zH2hF25RPHOPXP2GruVZUuMGggRmBmWl9cJKKRemFECdBB/7dfUaEKQexD4Kl5P5WS
	 gZ1ZBguBHoCdeiDjKbQc/snwLKMuGOfh+XXsHg9OhQF3ZoYCQ0TMaGaaC9fYCvZSF3
	 bs2tVg8WMe/ww==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 00/14] Netfilter/IPVS fixes for net
Date: Thu, 16 Apr 2026 03:30:47 +0200
Message-ID: <20260416013101.221555-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11946-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FROM_HAS_DN(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5750640974C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

The following patchset contains Netfilter/IPVS fixes for net: Mostly
addressing very old bugs in the SIP conntrack helper string parser,
unsafe arp_tables match support with legacy IEEE1394, restrict xt_realm
to IPv4 and incorrect use of RCU lists in nat core and nftables. This
batch also includes one IPVS MTU fix. The exception is a fix for a
recent issue related to broken double-tagged vlan in the flowtable.

1) Fix possible stack recursion in nft_fwd_netdev from egress path,
   from Weiming Shi.

2) Fix unsafe port parser in SIP helper, from Jenny Guanni Qu.

3) Fix arp_tables match with IEEE1394 ARP payload, allowing to
   reach bytes off the skb boundary, from Weiming Shi.

4) Reject unsafe nfnetlink_osf configurations from control plane,
   this is addressing a possible division by zero, from Xiang Mei.

5) nft_osf actually only supports IPv4, restrict it.

6) Fix double-tagged-vlan support (again) in the flowtable, from
   Eric Woudstra.

7) Remove unsafe use of sprintf to fix possible buffer overflow
   in the SIP NAT helper, from Florian Westphal.

8) Restrict xt_mac, xt_owner and xt_physdev to inet families only;
   xt_realm is only for ipv4, otherwise null-pointer-deref is possible.

9) Use kfree_rcu() in nat core to release hooks, this can be an issue
   once nfnetlink_hook gets support to dump NAT hook information,
   not currently a real issue but better fix it now.

10) Fix MTU checks in IPVS, from Yingnan Zhang.

11) Use list_del_rcu() in chain and flowtable hook unregistration,
    concurrent RCU reader could be walking over the hook list,
    from Florian Westphal.

12) Add list_splice_rcu(), this is required to fix unsafe
    splice to RCU protected hook list. Reviewed by Paul McKenney.

13) Use list_splice_rcu() to splice new chain and flowtable hooks.

14) Add shim nft_trans_hook object to track chain and flowtable
    hook deletions and flag them as removed, instead of unsafely
    moving around hooks in the RCU-protected hook list. This allows
    to restore the previous state from the abort path.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-26-04-16

Thanks.

----------------------------------------------------------------

The following changes since commit 2dddb34dd0d07b01fa770eca89480a4da4f13153:

  net: ethernet: mtk_eth_soc: initialize PPE per-tag-layer MTU registers (2026-04-12 15:22:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-26-04-16

for you to fetch changes up to e349f90da812aeddd22c3914a2cc639b51e4eb48:

  netfilter: nf_tables: add hook transactions for device deletions (2026-04-16 02:47:58 +0200)

----------------------------------------------------------------
netfilter pull request 26-04-16

----------------------------------------------------------------
Eric Woudstra (1):
      netfilter: nf_flow_table_ip: Introduce nf_flow_vlan_push()

Florian Westphal (2):
      netfilter: conntrack: remove sprintf usage
      netfilter: nf_tables: use list_del_rcu for netlink hooks

Jenny Guanni Qu (1):
      netfilter: nf_conntrack_sip: add bounds-checked port parsing helper

Pablo Neira Ayuso (6):
      netfilter: nft_osf: restrict it to ipv4
      netfilter: xtables: restrict several matches to inet family
      netfilter: nat: use kfree_rcu to release ops
      rculist: add list_splice_rcu() for private lists
      netfilter: nf_tables: join hook list via splice_list_rcu() in commit phase
      netfilter: nf_tables: add hook transactions for device deletions

Weiming Shi (2):
      netfilter: nft_fwd_netdev: use recursion counter in neigh egress path
      netfilter: arp_tables: fix IEEE1394 ARP payload parsing in arp_packet_match()

Xiang Mei (1):
      netfilter: nfnetlink_osf: fix divide-by-zero in OSF_WSS_MODULO

Yingnan Zhang (1):
      ipvs: fix MTU check for GSO packets in tunnel mode

 include/linux/rculist.h               |  29 ++++++
 include/net/netfilter/nf_dup_netdev.h |  13 +++
 include/net/netfilter/nf_tables.h     |  13 +++
 net/ipv4/netfilter/arp_tables.c       |  14 ++-
 net/ipv4/netfilter/iptable_nat.c      |   2 +-
 net/ipv6/netfilter/ip6table_nat.c     |   2 +-
 net/netfilter/ipvs/ip_vs_xmit.c       |  19 +++-
 net/netfilter/nf_conntrack_sip.c      |  80 +++++++++++-----
 net/netfilter/nf_dup_netdev.c         |  16 ----
 net/netfilter/nf_flow_table_ip.c      |  25 ++++-
 net/netfilter/nf_nat_amanda.c         |   2 +-
 net/netfilter/nf_nat_core.c           |  10 +-
 net/netfilter/nf_nat_sip.c            |  33 ++++---
 net/netfilter/nf_tables_api.c         | 168 ++++++++++++++++++++++++----------
 net/netfilter/nfnetlink_osf.c         |   4 +
 net/netfilter/nft_fwd_netdev.c        |   7 ++
 net/netfilter/nft_osf.c               |   6 +-
 net/netfilter/xt_mac.c                |  34 ++++---
 net/netfilter/xt_owner.c              |  37 +++++---
 net/netfilter/xt_physdev.c            |  29 ++++--
 net/netfilter/xt_realm.c              |   2 +-
 21 files changed, 393 insertions(+), 152 deletions(-)

