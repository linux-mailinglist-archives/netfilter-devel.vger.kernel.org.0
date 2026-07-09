Return-Path: <netfilter-devel+bounces-13803-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hJDqNTv7T2rlrQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13803-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 21:49:15 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE027352D8
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 21:49:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=JNHMjOFN;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13803-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13803-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BF8D301E956
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 19:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832FB2E92BA;
	Thu,  9 Jul 2026 19:46:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20B1459FA
	for <netfilter-devel@vger.kernel.org>; Thu,  9 Jul 2026 19:46:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626388; cv=none; b=PTHOFz6XzGRcNAsposKANkTqHM7xaSQAAp1Ukp76hVeqYPPuIOnW4/SUKDwy5ZxuFuFnwhmPLjqouFsh8FV/9jwPnIQF2O6Xwxb/VZdVBKjX9doDRvyT86dJY8FZ1pwi2soz2kXrFWRd9xUPok7U03v8TKzf5uy+wdRI5s0yVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626388; c=relaxed/simple;
	bh=oKgFxt2mIkdrMgHeyAEe8iLpRy+8wQySaHRO8TbonOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=refZ2VlkrY0lLVYuZaNVc5qESjbcyJ2GN2sRGp3NwqIrGmu/VIn7E7xfmmkRg9OJ38VOyYW7ONneCcExcMRJ3ILVrfsLzf8E/laW3s2ST/j3PPUah5LC/yOdIS/tMtAHV1JnFcmYilXZWSqxUKKbxDip+9YvCLpK6Ma6jYNgNJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=JNHMjOFN; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OAOKyJPXfyhzrw0nANA4NaAvAG1NpQNfXcYMwSZ3PE4=; b=JNHMjOFN5PeTtTR/58JDEK4FzQ
	exH2mrBjbfOqkIvg/o+p3PONx5KULQWafFx6Wj8u2KDQ+ZMUsYDCnZ22JS6X1hj8LfWokY80w+lcy
	YkhKymzF2xePFXZAA/A+51ASOWc/toYQMmu5E8JlrOh7dtApG8zxslBYGru7qfelnT74zAdXCxENH
	wygjkvqjbnts0zeRuUeZN7v/9VHKwqidpirGEIPMDFQWADF5TQuteHPs5aM1oTOlKQn5RFxxbC+aR
	293w6uz+QaXv8wHiCECxVvNMjH623ISeEk2RccDcfMdEZ1vlYlRoHYGgHGdLiWJVC+bbshva9MaxM
	qhK73bGA==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1whuhO-000000002j4-3Otg;
	Thu, 09 Jul 2026 21:46:18 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: [nf-next PATCH v2 0/5] Address Sashiko review of NAT hook dump code
Date: Thu,  9 Jul 2026 21:46:07 +0200
Message-ID: <20260709194612.1995795-1-phil@nwl.cc>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13803-lists,netfilter-devel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nwl.cc:mid,nwl.cc:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EE027352D8

Changes since v1:
- New patch 1
- Fixed three aspects of patch 3
- Fixed two issues of patch 5

Patch 1 fixes a bug (actually, two) in old code. Latter patches benefit
from the fix it implements.

Patch 2 is mere preparation to add the missing case handling to
nfnl_hook_dump_nat().

Patch 3 fixes for missing READ_ONCE() calls when addressing hook ops
array elements.

Patch 4 adds missing multipart dump support to nfnl_hook_dump_nat.

Patch 5 adds code to detect and mitigate concurrent hook updates while
amidst a multipart dump to nfnl_hook_dump_nat.

Link: https://sashiko.dev/#/patchset/20260702105003.13550-2-fw%40strlen.de

Phil Sutter (5):
  netfilter: nfnetlink_hook: Fix for EINTR due to index too large
  netfilter: nfnetlink_hook: Pass cb object to nfnl_hook_dump_nat()
  netfilter: nfnetlink_hook: Address hook ops using READ_ONCE()
  netfilter: nfnetlink_hook: Handle multipart NAT hook dumps
  netfilter: nfnetlink_hook: Fix for concurrent NAT hooks dump and
    change

 net/netfilter/nfnetlink_hook.c | 75 +++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 23 deletions(-)

-- 
2.54.0


