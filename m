Return-Path: <netfilter-devel+bounces-13703-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EA5vCgVZTWrZygEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13703-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 21:52:37 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F67271F6A6
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 21:52:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=carlosgrillet.me header.s=zmail header.b="B3AP22/A";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13703-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13703-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8802B300D720
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Jul 2026 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001523B994A;
	Tue,  7 Jul 2026 19:52:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE023BE644;
	Tue,  7 Jul 2026 19:52:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453948; cv=pass; b=R2nSUy4AhrG9zjwAyoKo5qtjKvPGb1K1K3g1z0NCrrQuJ9FEzgPtedUw2ocum8s2LP5kSeIdqniUqPSS2TUowXJyQcVoOry/qaJH4rm7Nh1P8S5DQ0cdWbpJ6mdawSuwTFWGu7mC+X2+hz6KH8lghpdzNdcLoYQ8xRJ32iFdTgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453948; c=relaxed/simple;
	bh=mQwXGZluo0e/rOz6em/H3KPFLAzljDc4xuigN/YjoWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZD6u84doNbiRr9EjibsomyPzAVNzR3u4Bhrxy9jVE0hnTVzkTHNIsdVhDHaaNhvFyhiwgi8EEXeJYJ9lucJuMjgDuwy1wHKjedvOFnIHLPpeEqxwB540TTyZiiWPWaYmvwWy1o+Rvr7KI6ErlwpRU8Kbk0zs+kFGm/EFvClFKKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carlosgrillet.me; spf=pass smtp.mailfrom=carlosgrillet.me; dkim=pass (1024-bit key) header.d=carlosgrillet.me header.i=carlos@carlosgrillet.me header.b=B3AP22/A; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1783453886; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=IjjF0DTdO5cT/dT4SLrpDA5Ha/QFyV6hnjlStruEB7YvmxcVMD4BtjdmfYK4nYFM+TR9GjBYZU55CJYFBoIZz+1YjpkCSQhuDcGusl6Oe0mFau9pakYkKC1dVtjJ9ToMmHyNkvVpufxpqXKWf4ePGaMdvGY/k8guTIf0eD6LOyM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783453886; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=STRIjG+QS7Hua/lM7GQwd7GhTYTw8rS7AqdX4cPkG5c=; 
	b=PIATY/mDGl5RLpR1f8XcNe+M3m7esmNdRG81VOpTs1y1hV4WupWwkXAqqKOSVbw12T8MCdShtgvZ1j0sNtn/MBxOBEqT3aVNHgfyFJA2/inXyEBTgWpFrgjEHJ+rxcd0y3TlRqgkF5KRIzpm9+w9q6qrMxUm6KQy4TA7Jvkm6i8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=carlosgrillet.me;
	spf=pass  smtp.mailfrom=carlos@carlosgrillet.me;
	dmarc=pass header.from=<carlos@carlosgrillet.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783453886;
	s=zmail; d=carlosgrillet.me; i=carlos@carlosgrillet.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=STRIjG+QS7Hua/lM7GQwd7GhTYTw8rS7AqdX4cPkG5c=;
	b=B3AP22/AFfWxaHJ0cB1oVTAJPcduG315s9f4zWFILYkkwyJFVZkKJDGvH6T2DEku
	Smoi8UWvP8wneB2SPhODmXCqVI6fogHQjq1b0fYBf5RxaeB127tVn55CjJZwP+k2Z1k
	Z7PQnrqEvyMZ2CKRaPeIXkNzG+zjwDbvc+T1KfK4=
Received: by mx.zoho.eu with SMTPS id 1783453883610391.61290214611824;
	Tue, 7 Jul 2026 21:51:23 +0200 (CEST)
From: Carlos Grillet <carlos@carlosgrillet.me>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org
Subject: [PATCH nf-next 0/4] netfilter: replace u_int*_t with kernel int types (batch 3)
Date: Tue,  7 Jul 2026 21:51:05 +0200
Message-ID: <20260707195111.34899-1-carlos@carlosgrillet.me>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[carlosgrillet.me:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:horms@verge.net.au,m:ja@ssi.bg,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:lvs-devel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[carlosgrillet.me];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13703-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[carlosgrillet.me:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,carlosgrillet.me:from_mime,carlosgrillet.me:dkim,carlosgrillet.me:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F67271F6A6

This patch series replaces POSIX u_int8_t/u_int16_t/u_int32_t with the
preferred kernel types u8/u16/u32 across several netfilter files and
updates the corresponding header definition.

This continues the work started in:
https://lore.kernel.org/all/20260616182948.96865-1-carlos@carlosgrillet.me

No functional changes.

Carlos Grillet (4):
  netfilter: ip_vs_core: replace u_int32_t with u32
  netfilter: nf_conntrack_sip: replace u_int16_t with u16
  netfilter: nf_nat_amanda: replace u_int16_t with u16
  netfilter: nfnetlink_osf: replace u_int8_t with u8

 include/linux/netfilter/nfnetlink_osf.h | 2 +-
 net/netfilter/ipvs/ip_vs_core.c         | 2 +-
 net/netfilter/nf_conntrack_sip.c        | 2 +-
 net/netfilter/nf_nat_amanda.c           | 2 +-
 net/netfilter/nfnetlink_osf.c           | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.55.0


