Return-Path: <netfilter-devel+bounces-11057-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAmLCoE3r2kPQQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11057-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 09 Mar 2026 22:11:29 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 886F82416F3
	for <lists+netfilter-devel@lfdr.de>; Mon, 09 Mar 2026 22:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF2CA310F881
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Mar 2026 21:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CEA413227;
	Mon,  9 Mar 2026 21:08:54 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA841C0D6;
	Mon,  9 Mar 2026 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090534; cv=none; b=gInsFePxG3eUddmBJLFPbhX2tNw5CsXZSJqMNQiYUG/m1fbuCyqZCdlMaERlPL5uv2ZemgR2ceQ+Goirjgu8AL4JV67gxylTEEOArsrSOT536Mjj1H+4+SnH2pxs4Ugt065FRQGTONVMeiMS92OTObzlMMXVgiOKIzBFwYxWBvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090534; c=relaxed/simple;
	bh=3mUNslYFdO+m+1W2BzjORrkvq4Fe6bwLyUt25LRjKok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eapqB0GQpkaC+I0Mn+Lz9T0Svrs8bLwZWtIc0pxPVkdE7CjbiCiVwpNKZNAyfkazCaiZJBVNjEqZmKFnZKAwlB977+W35ovea76elYWskCpFZ7rBuKzWdoIVmd1KUc3Ls2vBSKZiz8kx+6Z5j0z/qFDbOhdZDUMiRXmxHXPangA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id DA0746047A; Mon, 09 Mar 2026 22:08:49 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 00/10] netfilter: updates for net
Date: Mon,  9 Mar 2026 22:08:35 +0100
Message-ID: <20260309210845.15657-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 886F82416F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11057-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Action: no action

Hi,

The following patchset contains Netfilter fixes for *net*:

Due to a large influx of bug fixes on netfilter-devel@ I am sending
an earlier PR to have more time to go through the remaining patches
without getting a 20+ patch PR.

1) syzbot managed to add/remove devices to a flowtable, due to a bug in
   the flowtable netdevice notifier this gets us a double-add and
   eventually UaF when device is removed again (we only expect one
   entry, duplicate remains past net_device end-of-life).
   From Phil Sutter, bug added in 6.16.

2) Yiming Qian reports another nf_tables transaction handling bug:
   in some cases error unwind misses to undo certain set elements,
   resulting in refcount underflow and use-after-free, bug added in 6.4.

3) Jenny Guanni Qu found out-of-bounds read in pipapo set type.
   While the value is never used, it still rightfully triggers KASAN
   splats.  Bug exists since this set type was added in 5.6.

4) a few x_tables modules contain copypastry tcp option parsing code which
    can read 1 byte past the option area.  This bug is ancient, fix from
    David Dull.

5) nfnetlink_queue leaks kernel memory if userspace provides bad
   NFQA_VLAN/NFQA_L2HDR attributes.  From Hyunwoo Kim, bug stems from
   from 4.7 days.

6) nfnetlink_cthelper has incorrect loop restart logic which may result
   in reading one pointer past end of array. From 3.6 days, fix also from
   Hyunwoo Kim.

7-9) fix access bugs in the ctnetlink expectation handling.
     Problem is that while RCU prevents the referenced nf_conn entry
     from going way, nf_conn entries have an extension area that can
     only be safely accessed if the cpu holds a reference to the
     conntrack.  Else the extension area can be free'd at any time.
     Fix is to grab references before the accesses happen.
     These bugs are old, v3.10 resp. even pre-git days.
     All fixes from Hyunwoo Kim.

10) xt_IDLETIMER v0 extension must reject working with timers added
    by revision v1, else we get list corruption. Bug added in v5.7.
    From Yifan Wu, Juefei Pu and Yuan Tan via Xin Lu.

Please, pull these changes from:
The following changes since commit c113d5e32678c8de40694b738000a4a2143e2f81:

  Merge branch 'net-spacemit-a-few-error-handling-fixes' (2026-03-06 18:58:36 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-26-03-09

for you to fetch changes up to a29b6cda03c1a4175468953c87a6c7db8766df7e:

  netfilter: xt_IDLETIMER: reject rev0 reuse of ALARM timer labels (2026-03-09 14:40:00 +0100)

----------------------------------------------------------------
netfilter pull request nf-26-03-09

----------------------------------------------------------------
David Dull (1):
  netfilter: x_tables: guard option walkers against 1-byte tail reads

Florian Westphal (1):
  netfilter: nf_tables: always walk all pending catchall elements

Hyunwoo Kim (5):
  netfilter: nfnetlink_queue: fix entry leak in bridge verdict error path
  netfilter: nfnetlink_cthelper: fix OOB read in nfnl_cthelper_dump_table()
  netfilter: ctnetlink: fix use-after-free in ctnetlink_dump_exp_ct()
  netfilter: ctnetlink: fix use-after-free of exp->master in single expectation GET
  netfilter: ctnetlink: fix use-after-free of exp->master in expectation dump

Jenny Guanni Qu (1):
  netfilter: nft_set_pipapo: fix stack out-of-bounds read in pipapo_drop()

Phil Sutter (1):
  netfilter: nf_tables: Fix for duplicate device in netdev hooks

Yuan Tan (1):
  netfilter: xt_IDLETIMER: reject rev0 reuse of ALARM timer labels

 net/netfilter/nf_conntrack_netlink.c | 52 ++++++++++++++++++++++++++--
 net/netfilter/nf_tables_api.c        |  4 +--
 net/netfilter/nfnetlink_cthelper.c   |  8 ++---
 net/netfilter/nfnetlink_queue.c      |  4 ++-
 net/netfilter/nft_chain_filter.c     |  2 +-
 net/netfilter/nft_set_pipapo.c       |  3 +-
 net/netfilter/xt_IDLETIMER.c         |  6 ++++
 net/netfilter/xt_dccp.c              |  4 +--
 net/netfilter/xt_tcpudp.c            |  6 ++--
 9 files changed, 72 insertions(+), 17 deletions(-)

-- 
2.52.0

