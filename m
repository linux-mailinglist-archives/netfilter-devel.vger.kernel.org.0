Return-Path: <netfilter-devel+bounces-10890-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GYdOFqkoGk9lQQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10890-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Feb 2026 20:51:54 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5B21AEB4D
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Feb 2026 20:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14787300514D
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Feb 2026 19:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D0D43E9FB;
	Thu, 26 Feb 2026 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="jJM8+CJ2"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C694534B3;
	Thu, 26 Feb 2026 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772135511; cv=none; b=Wk53SysYGJJkLQL2IERv2kMq+ngb0JrQ05VkFOOZlKkEX2aOEvU/WbJR3VHexU0p9Q7/kAmkWY6LdETJ0OWSJvp7z5YAVF6R4PooVN2m9uduR5ltTP1dreqJcN/aE6uFEBLDBQRCVqJLWC9ev6G01a/mQy38KATpm8f5TX7dZeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772135511; c=relaxed/simple;
	bh=s5PhqnJFimQsw9Rcj8q/DWg+6hwepDmpJAGr4iOwvy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jvo4zF2aCcAzKTgee8WgmL3/lzyRloIosCHCK+dYSxc8KFvq/p6CDeAseADKR35bijA1Wwi1+jcww6OBUWqjLp7FBPzqeo0IutnascoX4CvMR498WKTrN6oibrVPoZrq1sz6DuvWLKVXsqvYim0NegPJxSF/Jjdmc2XvNQ3z6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=jJM8+CJ2; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 2AF8E21D50;
	Thu, 26 Feb 2026 21:51:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-transfer-encoding:date:from:from:message-id
	:mime-version:reply-to:subject:subject:to:to; s=ssi; bh=S8A0Bzn+
	at7+hIdap/hLbq6HxSEh4YiJXzh8G14FEok=; b=jJM8+CJ2fFhWd1b7a3hGvUmF
	q34NvncOkgIk7+KVukyGHHTot263+2LkP3uGfAuj2WSx+XuUDe1nUJ7/2sJBGuRY
	zwLw0iNT2QJrKIl3mg9rBrymLONpaVXXT2QNrnQtgVgaDhgSmGsTNnWsSteFw6Xz
	w+2dEu96A9NSWMeMXa+bfaA6xLrJ5YUyp30Y1eFmVThoTICo1IZrfDHwJnsMHBnN
	Ocw8loGgoWwZQ0SKJLltPqbSdyrxuQGZV8ia4o5VofAHKV009lu9isI7leECrtRz
	b4zhFlMTYSma/nJxTbw8G8AO91HOO7ICU3pfgdbGSlV/6TuCBx90Dn+bEaUTMQIa
	Hxlm1Cb3Ta7Li0rSggJaGltlxo0xm/zV8hpfLgBQ839zbBvFOBZzK9VEIx+2BJk7
	N/x+t7nVB+dG4fCBZ74MCx9OlgvY0Grd4TcknXQZYNELDp6TC1/XX8E93ZvQBP/M
	uFBNVSmKv3aGDaouIw6ToOZIX5LYNOvtjoa+LIVaOpAguWchlX43DfYWTg5ohmGu
	Q8J/R3qBUCy4P+AO1LngjD+CRhpc74JJ2N0QBDXgzMJW/ndk4pRO12Tem/5QCyOv
	S1paIfK11uY+4iGry9nTDfIEntEQU4vixFY7GxdDy1T4h5UumOs09e+X3fmLrv89
	btwSseZhzpdnd8b/Hzo=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Thu, 26 Feb 2026 21:51:46 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id D846B609BF;
	Thu, 26 Feb 2026 21:51:44 +0200 (EET)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.1/8.18.1) with ESMTP id 61QJphfn064974;
	Thu, 26 Feb 2026 21:51:43 +0200
Received: (from root@localhost)
	by ja.home.ssi.bg (8.18.1/8.18.1/Submit) id 61QJpeE1064971;
	Thu, 26 Feb 2026 21:51:40 +0200
From: Julian Anastasov <ja@ssi.bg>
To: Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, Dust Li <dust.li@linux.alibaba.com>,
        Jiejian Wu <jiejian@linux.alibaba.com>, rcu@vger.kernel.org
Subject: [PATCH nf-next 0/5] IPVS changes, part 3 of 4 - per-net tables
Date: Thu, 26 Feb 2026 21:50:16 +0200
Message-ID: <20260226195021.64943-1-ja@ssi.bg>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ssi.bg,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ssi.bg:s=ssi];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ssi.bg:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10890-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ssi.bg:mid,ssi.bg:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5C5B21AEB4D
X-Rspamd-Action: no action

        Hello,

        This patchset is part 3 of changes that accumulated in
recent time. It is for nf-next and should be applied when the patches
from part 1 and 2 are already applied. It contains changes that convert
the connection and service tables to be per-net and targets more netns
isolation when IPVS is used in large setups.

	First patch adds useful wrappers to rculist_bl.h, the
hlist_bl methods IPVS will use in the following patches. The other
patches are IPVS-specific.

        All patches here come from the work
"ipvs: per-net tables and optimizations" last posted
on 19 Oct 2025 as v6, with the following changes:

Patch 1 comes from v6/patch 1 without changes

Patch 2 comes from v6/patch 7 with added comments

Patch 3 comes from v6/patch 8 without changes

Patch 4 comes from v6/patch 9 with some changes due to the
  v6/patch 11 position change

Patch 5 comes from v6/patch 12 without changes

	As result, the following patches will:

* Add new wrappers into rculist_bl.h

* Add infrastructure for resizable hash tables based on hlist_bl
  which we will use for services and connections: hlists with
  per-bucket bit lock in the heads. The resizing delays RCU lookups
  on a bucket level with seqcounts which are protected with spin locks.
  The entries keep the table ID and the hash value which allows to
  filter the entries without touching many cache lines and to
  unlink the entries without lookup by keys.

* Change the 256-bucket service hash table to be resizable in the
  range of 4..20 bits depending on the added services and use jhash
  hashing to reduce the collisions.

* Change the global connection table to be per-net and resizable
  in the range of 256..ip_vs_conn_tab_size. As the connections are
  hashed by using remote addresses and ports, use siphash instead
  of jhash for better security.

* Make the connection hashing more secure for setups with multiple
  services. Hashing only by remote address and port (client info)
  is not enough. To reduce the possible hash collisions add the
  used virtual address/port (local info) into the hash and as a side
  effect the MASQ connections will be double hashed into the
  hash table to match the traffic from real servers:
    OLD:
    - all methods: c_list node: proto, caddr:cport
    NEW:
    - all methods: hn0 node (dir 0): proto, caddr:cport -> vaddr:vport
    - MASQ method: hn1 node (dir 1): proto, daddr:dport -> caddr:cport


Julian Anastasov (5):
  rculist_bl: add hlist_bl_for_each_entry_continue_rcu
  ipvs: add resizable hash tables
  ipvs: use resizable hash table for services
  ipvs: switch to per-net connection table
  ipvs: use more keys for connection hashing

 include/linux/rculist_bl.h        |  49 +-
 include/net/ip_vs.h               | 376 +++++++++--
 net/netfilter/ipvs/ip_vs_conn.c   | 992 ++++++++++++++++++++++--------
 net/netfilter/ipvs/ip_vs_core.c   | 179 ++++++
 net/netfilter/ipvs/ip_vs_ctl.c    | 691 +++++++++++++++++----
 net/netfilter/ipvs/ip_vs_pe_sip.c |   4 +-
 net/netfilter/ipvs/ip_vs_sync.c   |  23 +
 7 files changed, 1880 insertions(+), 434 deletions(-)

-- 
2.53.0



