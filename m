Return-Path: <netfilter-devel+bounces-13522-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5XeNOr9LQ2qSWgoAu9opvQ
	(envelope-from <netfilter-devel+bounces-13522-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 06:53:19 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 465CB6E056C
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 06:53:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13522-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13522-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A2CC302A2E1
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 04:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7113E16B0;
	Tue, 30 Jun 2026 04:53:17 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD133E168B;
	Tue, 30 Jun 2026 04:53:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795197; cv=none; b=E4O15FO1EZ/GyRvseKD918xnZ6rlzXEE2chmmcRw1E9iG4Hp9gMysFVsqelzYsasuvq45HPR/2fQqYq22NRFxeDo7lJ3p8ixwucNZ0fQfyH0AXoWIWm7veOG3QgFwN2xWWigrwJfa0W7i0It2rUSW/wO/GUaEj2ttpMdeO1365M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795197; c=relaxed/simple;
	bh=5UnfadnHLJtCaYlOWYkcFQ2OpmmxJREZEKnWJotc7TE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALQ3CgeTM4T1Tr7xCwhO2+DzjwV0KIZLJd3RZrG5eqWl07vgk8Fp9u8QfuGp4c6WfEwHvTYhAEU04nkKOXfoA8DvZjHcGcUA6IsZtICEWKb2lOy+N7E8xXPxzMCqpMOfbfBVWrF/Zb0MukYZaONQtADgujCHScqjiJ3VG4rqIMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 0BCF86032C; Tue, 30 Jun 2026 06:53:13 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 0/9] netfilter: updates for net
Date: Tue, 30 Jun 2026 06:52:34 +0200
Message-ID: <20260630045243.2657-1-fw@strlen.de>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13522-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 465CB6E056C

Hi,

The following patchset contains Netfilter fixes for *net*.
Due to bug volume the plan is to make a second *net* pull request
this Friday.

1) Zero nf_conntrack_expect at allocation to prevent uninitialized data
leaks to userspace. Add missing exp->dir initialization.

2) Prevent out-of-bounds writes in nft_set_pipapo caused by inconsistent
clones during allocation failures.  Fail operations if the clone enters an
error state.  This was a day-0 bug.

3) Fix use-after-free race between ipset dump and array resizing. Protect
array pointer access with rcu_read_lock().  From Xiang Mei. Bug existed
since v4.20.

4) Validate skb_dst() exists before access in nf_conntrack_sip.
This Prevent crash when called from tc ingress or openvswitch.
From Pablo Neira Ayuso.  Bug added in 4.3 when ovs gained support
for conntrack helpers.

5) Cap the maximum number of expectations to NF_CT_EXPECT_MAX_CNT during
userspace helper policy updates.  Also from Pablo.

6) Prevent NULL pointer dereference in nft_fib on netdev egress hooks. Add
nft_fib_netdev_validate() to restrict fib expressions to appropriate
netdev hooks. Restrict nft_fib_validate() to IPv4, IPv6, and INET
protocols.  From Theodor Arsenij Larionov-Trichkine.
Bug was exposed in v5.16 when egress hooks got added.

7) Restrict nfnetlink_queue writes to network headers. Validate IP/IPv6
header length and disable extension headers or IP option modifications.
Disable bridge modification for now, its unlikely anyone is using this.

8) Restrict arbitrary writes to link-layer and network headers in nftables.
Prevent link-layer modifications from spilling into network headers.
Prevent writes to IP version and length fields.

9) Restrict L3 checksum update offset to IPv4. Else csum offset can be
used to munge arbitrary header offsets, rendering the previous change moot.

These three patches are follow-ups to a 7.1 change that disabled
header rewrite ability in unprivileged network namespaces.
unprivileged netns support is not yet enabled again here.

Please, pull these changes from:
The following changes since commit 1398b1014909618f65ff6bcebcb2ee5ccd44fdc0:

  MAINTAINERS: Update Jason Wang's email address (2026-06-29 19:09:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-26-06-30

for you to fetch changes up to e2c4a0c805f7be21c8288e8562145a6691e11559:

  netfilter: nftables: restrict checkum update offset (2026-06-30 06:37:12 +0200)

----------------------------------------------------------------
netfilter pull request nf-26-06-30
----------------------------------------------------------------

Florian Westphal (5):
  netfilter: nf_conntrack_expect: zero at allocation time
  netfilter: nft_set_pipapo: don't leak bad clone into future transaction
  netfilter: nfnetlink_queue: restrict writes to network header
  netfilter: nftables: restrict linklayer and network header writes
  netfilter: nftables: restrict checkum update offset

Pablo Neira Ayuso (2):
  netfilter: nf_conntrack_sip: validate skb_dst() before accessing it
  netfilter: nfnetlink_cthelper: cap to maximum number of expectation per master

Theodor Arsenij Larionov-Trichkine (1):
  netfilter: nft_fib: reject fib expression on the netdev egress hook

Xiang Mei (1):
  netfilter: ipset: fix race between dump and ip_set_list resize

 net/netfilter/ipset/ip_set_core.c    |   8 +-
 net/netfilter/nf_conntrack_expect.c  |   3 +-
 net/netfilter/nf_conntrack_netlink.c |  11 +-
 net/netfilter/nf_conntrack_sip.c     |   7 +-
 net/netfilter/nfnetlink_cthelper.c   |   2 +
 net/netfilter/nfnetlink_queue.c      | 170 +++++++++++++++++
 net/netfilter/nft_fib.c              |   9 +
 net/netfilter/nft_fib_netdev.c       |  29 ++-
 net/netfilter/nft_payload.c          | 270 +++++++++++++++++++++++++++
 net/netfilter/nft_set_pipapo.c       |  34 +++-
 net/netfilter/nft_set_pipapo.h       |   8 +
 11 files changed, 531 insertions(+), 20 deletions(-)

-- 
2.53.0

