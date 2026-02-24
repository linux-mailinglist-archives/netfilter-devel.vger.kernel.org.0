Return-Path: <netfilter-devel+bounces-10850-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP+hJzQPnmlBTQQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10850-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 21:51:00 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7D818C7C4
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 21:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD47330488D7
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 20:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FF233A9DD;
	Tue, 24 Feb 2026 20:50:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146D02DCF74;
	Tue, 24 Feb 2026 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771966256; cv=none; b=jqIfC1+Fe1qwzpmGoFNT30vcL7X9qQXbp4Ypfxo+TnUahT4pkmZcPNp1m/vCEGFIDwFRWiWWzUE2dJYPqQTmn22O43xeYczOGyH7QHU9Z480naGGG8Ll9UoXkaVViTKwrB0Ul92l4nNTR2Odz6pFaKz4rsXXzFuCFQ7/z9kkgEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771966256; c=relaxed/simple;
	bh=qvBNLGYNtqRgL4hDWAOErASAdX4jrQd28+zbJPnh5Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQHFbR9pvjmvi4+Nw5F0IMCVhhtU2ZyshJRDSaNJwbC0XCN9+e+L18c9VcXE6TMlTXpNy3p9oy9OILPO0rqaN7dLxK1MMXYgSfG3wPnRr7CzFlOXbdCK0i4uYrdRjvY6120RtWf7IdaaEx8qk1mKLIZn7UQbNWdVKu2z3A61Cvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D886160516; Tue, 24 Feb 2026 21:50:52 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 0/9] netfilter: updates for net-next
Date: Tue, 24 Feb 2026 21:50:39 +0100
Message-ID: <20260224205048.4718-1-fw@strlen.de>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10850-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F7D818C7C4
X-Rspamd-Action: no action

Hi,

The following patchset contains Netfilter fixes for *net-next*,
including IPVS updates from and via Julian Anastasov.

First updates for IPVS. From Julians cover-letter:

* Convert the global __ip_vs_mutex to per-net service_mutex and
  switch the service tables to be per-net, cowork by Jiejian Wu and
  Dust Li

* Convert some code that walks the service lists to use RCU instead of
  the service_mutex

* We used two tables for services (non-fwmark and fwmark), merge them
  into single svc_table

* The list for unavailable destinations (dest_trash) holds dsts and
  thus dev references causing extra work for the ip_vs_dst_event() dev
  notifier handler. Change this by dropping the reference when dest
  is removed and saved into dest_trash. The dest_trash will need more
  changes to make it light for lookups. TODO.

* On new connection we can do multiple lookups for services by trying
  different fallback options. Add more counters for service types, so
  that we can avoid unneeded lookups for services.

* The no_cport and dropentry counters can be per-net and also we can
  avoid extra conn lookups

Then, a few cleanups for nf_tables:

* keep BH enabled during nft_set_rbtree inserts, this is possible because the
  root lock is now only taken from control plane.
* toss a few EXPORT_SYMBOLs from nf_tables; these were historic
  leftovers from back in the day when e.g. set backends were still
  residing in their own modules.
* remove the register tracking infra from nftables.  It was disabled
  years ago in 5.18 and there are no plans to salvage this work; the
  idea was good (remove redundant register stores), but there is just
  one too many pitfalls, and better rule structuring (verdict maps)
  largely avoids the scenarios where this would have helped.

Florian Westphal (3):
  netfilter: nft_set_rbtree: don't disable bh when acquiring tree lock
  netfilter: nf_tables: drop obsolete EXPORT_SYMBOLs
  netfilter: nf_tables: remove register tracking infrastructure

Jiejian Wu (1):
  ipvs: make ip_vs_svc_table and ip_vs_svc_fwm_table per netns

Julian Anastasov (5):
  ipvs: some service readers can use RCU
  ipvs: use single svc table
  ipvs: do not keep dest_dst after dest is removed
  ipvs: use more counters to avoid service lookups
  ipvs: no_cport and dropentry counters can be per-net

 include/net/ip_vs.h                      |  39 ++-
 include/net/netfilter/nf_tables.h        |  32 --
 include/net/netfilter/nft_fib.h          |   2 -
 include/net/netfilter/nft_meta.h         |   3 -
 net/bridge/netfilter/nft_meta_bridge.c   |  20 --
 net/bridge/netfilter/nft_reject_bridge.c |   1 -
 net/ipv4/netfilter/nft_dup_ipv4.c        |   1 -
 net/ipv4/netfilter/nft_fib_ipv4.c        |   2 -
 net/ipv4/netfilter/nft_reject_ipv4.c     |   1 -
 net/ipv6/netfilter/nft_dup_ipv6.c        |   1 -
 net/ipv6/netfilter/nft_fib_ipv6.c        |   2 -
 net/ipv6/netfilter/nft_reject_ipv6.c     |   1 -
 net/netfilter/ipvs/ip_vs_conn.c          |  64 ++--
 net/netfilter/ipvs/ip_vs_core.c          |   2 +-
 net/netfilter/ipvs/ip_vs_ctl.c           | 368 ++++++++---------------
 net/netfilter/ipvs/ip_vs_est.c           |  18 +-
 net/netfilter/ipvs/ip_vs_xmit.c          |  12 +-
 net/netfilter/nf_tables_api.c            |  78 -----
 net/netfilter/nft_bitwise.c              | 104 -------
 net/netfilter/nft_byteorder.c            |  11 -
 net/netfilter/nft_cmp.c                  |   3 -
 net/netfilter/nft_compat.c               |  10 -
 net/netfilter/nft_connlimit.c            |   1 -
 net/netfilter/nft_counter.c              |   1 -
 net/netfilter/nft_ct.c                   |  46 ---
 net/netfilter/nft_dup_netdev.c           |   1 -
 net/netfilter/nft_dynset.c               |   1 -
 net/netfilter/nft_exthdr.c               |  34 ---
 net/netfilter/nft_fib.c                  |  42 ---
 net/netfilter/nft_fib_inet.c             |   1 -
 net/netfilter/nft_fib_netdev.c           |   1 -
 net/netfilter/nft_flow_offload.c         |   1 -
 net/netfilter/nft_fwd_netdev.c           |   2 -
 net/netfilter/nft_hash.c                 |  36 ---
 net/netfilter/nft_immediate.c            |  12 -
 net/netfilter/nft_last.c                 |   1 -
 net/netfilter/nft_limit.c                |   2 -
 net/netfilter/nft_log.c                  |   1 -
 net/netfilter/nft_lookup.c               |  12 -
 net/netfilter/nft_masq.c                 |   3 -
 net/netfilter/nft_meta.c                 |  45 ---
 net/netfilter/nft_nat.c                  |   2 -
 net/netfilter/nft_numgen.c               |  22 --
 net/netfilter/nft_objref.c               |   2 -
 net/netfilter/nft_osf.c                  |  25 --
 net/netfilter/nft_payload.c              |  47 ---
 net/netfilter/nft_queue.c                |   2 -
 net/netfilter/nft_quota.c                |   1 -
 net/netfilter/nft_range.c                |   1 -
 net/netfilter/nft_redir.c                |   3 -
 net/netfilter/nft_reject_inet.c          |   1 -
 net/netfilter/nft_reject_netdev.c        |   1 -
 net/netfilter/nft_rt.c                   |   1 -
 net/netfilter/nft_set_rbtree.c           |  23 +-
 net/netfilter/nft_socket.c               |  26 --
 net/netfilter/nft_synproxy.c             |   1 -
 net/netfilter/nft_tproxy.c               |   1 -
 net/netfilter/nft_tunnel.c               |  26 --
 net/netfilter/nft_xfrm.c                 |  27 --
 59 files changed, 221 insertions(+), 1009 deletions(-)

-- 
2.52.0

