Return-Path: <netfilter-devel+bounces-10971-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CABlKRBsqGn9uQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10971-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 18:29:52 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7B8205285
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 18:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98F19300D1E1
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Mar 2026 17:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2A2371D0E;
	Wed,  4 Mar 2026 17:29:47 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719934BA3A;
	Wed,  4 Mar 2026 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645386; cv=none; b=eIzWWEECUKf4KWYzHjBK37bZVeI96G/MwY5OZkV9LUzle442im+qi94Vf54NNqca/ER0IAf1VOZjCrnRrYWMoAvAEHHQ7/zgibr4+5pQBjar8bUvA8eLnOGAUIGoyASh37iderLH+vlrXaR72LbMmdAUZq9i4Vgi5jeNFHUIlvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645386; c=relaxed/simple;
	bh=5vvd0n+GMaKMqFV1dmwHju63XvMWI7WSFBu7LkZqBNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9hdZkjeeze2H+RtrzconzyK9ocHuQB6X6YJYKSwkuzrqbxspU7s9cFnB1UdMgUwqdDNrzDDSd6STgSHPNr46JEWnwsgOGxupoxAaWBHSLn16DJkggSuJv5hhX3J5G03dRIQmSTVks5nmc7cVFfqTrFNH4n5Mo0LI/A/DAx6W0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 71D1D6024F; Wed, 04 Mar 2026 18:29:43 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 0/4] netfilter: updates for net
Date: Wed,  4 Mar 2026 18:29:36 +0100
Message-ID: <20260304172940.24948-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C7B8205285
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10971-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

The following patchset contains Netfilter fixes for *net*:

1) Fix a bug with vlan headers in the flowtable infrastructure.
   Existing code uses skb_vlan_push() helper, but that helper
   requires skb->data to point to the MAC header, which isn't the
   case for flowtables.  Switch to a new helper, modeled on the
   existing PPPoE helper. From Eric Woudstra. This bug was added
   in v6.19-rc1.

2) Inseo An reported a bug with the set element handling in nf_tables:
   When set cannot accept more elements, we unlink and immediately free
   an element that was inserted into a public data structure, freeing it
   without waiting for RCU grace period.  Fix this by doing the
   increment earlier and by deferring possible unlink-and-free to the
   existing abort path, which performs the needed synchronize_rcu before
   free.  From Pablo Neira Ayuso. This is an ancient bug, dating back to
   kernel 4.10.

3) syzbot reported WARN_ON() splat in nf_tables that occurs on memory
   allocation failure.  Fix this by a new iterator annotation:
   The affected walker does not need to clone the data structure and
   can just use the live version if no clone exists yet.
   Also from Pablo.  This bug existed since 6.10 days.

4) Ancient forever bug in nft_pipapo data structure:
   The garbage collection logic to remove expired elements is broken.
   We must unlink from data structure and can only hand the freeing
   to call_rcu after the clone/live pointers of the data structures
   have been swapped.  Else, readers can observe the free'd element.
   Reported by Yiming Qian.

Please, pull these changes from:
The following changes since commit fbdfa8da05b6ae44114fc4f9b3e83e1736fd411c:

  selftests: tc-testing: fix list_categories() crash on list type (2026-03-04 05:42:57 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-26-03-04

for you to fetch changes up to 41c5c0124bd9528c32c9ebd5f8b8f8eb800e77c3:

  netfilter: nft_set_pipapo: split gc into unlink and reclaim phase (2026-03-04 15:39:33 +0100)

----------------------------------------------------------------
netfilter pull request nf-26-03-04

----------------------------------------------------------------
Eric Woudstra (1):
  netfilter: nf_flow_table_ip: Introduce nf_flow_vlan_push()

Florian Westphal (1):
      netfilter: nft_set_pipapo: split gc into unlink and reclaim phase

Pablo Neira Ayuso (2):
  netfilter: nf_tables: unconditionally bump set->nelems before insertion
  netfilter: nf_tables: clone set on flush only

 include/net/netfilter/nf_tables.h |  7 ++++
 net/netfilter/nf_flow_table_ip.c  | 25 ++++++++++++-
 net/netfilter/nf_tables_api.c     | 45 ++++++++++++----------
 net/netfilter/nft_set_hash.c      |  1 +
 net/netfilter/nft_set_pipapo.c    | 62 ++++++++++++++++++++++++++-----
 net/netfilter/nft_set_pipapo.h    |  2 +
 net/netfilter/nft_set_rbtree.c    |  8 ++--
 7 files changed, 115 insertions(+), 35 deletions(-)

-- 
2.52.0


