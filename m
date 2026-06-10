Return-Path: <netfilter-devel+bounces-13207-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8ChBBjWmKWqEbQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13207-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 20:00:21 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD3066C1BA
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 20:00:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13207-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13207-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1137330BDD0F
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCC73537F5;
	Wed, 10 Jun 2026 17:59:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D429A9FE;
	Wed, 10 Jun 2026 17:59:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114367; cv=none; b=WFlXVkyGwctEO8r9GRf/UFosrq3syRDWvktN7+SXa6tiKI/+T7S+wqvIltgmSuFScYoLGCLrlv03RH/6BdO6uyGnkBnjLuKSN3lxqjHqbIdp2ubxFx0dUdO5V9BjHtUMWFQRBPof+pCs0nUGYSR3+vtPMcetvCa0DC5HZ9nbnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114367; c=relaxed/simple;
	bh=RJ3Jm7s1KPIJN4x4zj5ARLMufArVvTkTOOpe4fGptaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eV7yEZURG1SyeOmiAmbsvOrfb6StjzsVI/ch03hJwBtLFBVBEGS8d1ZWHhy03hq8bApo/pBw3kDeSHqkVRU98dVL/D0YDZEDFgwZqrtDN1+caLNS1K3DcbzH66mrIf52Fxds+47k88f4tkEms7zBq6apeexKgxU5w/bECiZu8co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C39DD607E1; Wed, 10 Jun 2026 19:59:17 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net-next 0/2] netdevsim: add fake FT/CLS_FLOWER offload
Date: Wed, 10 Jun 2026 19:58:42 +0200
Message-ID: <20260610175906.1767-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13207-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AD3066C1BA

1) Enable nf_tables offload control plane testing in netdevsim. Tag
   existing offload fn to allow error injection for testing rollback and abort
   logic.

2) Add nft_offload selftest to exercise the control plane and error
   unwind via fault injection.

Florian Westphal (2):
  netdevsim: tc: allow to test nf_tables offload control plane code
  selftests: netfilter: add phony nft_offload test

 drivers/net/netdevsim/tc.c                    |  18 ++-
 .../testing/selftests/net/netfilter/Makefile  |   1 +
 tools/testing/selftests/net/netfilter/config  |   6 +
 .../selftests/net/netfilter/nft_offload.sh    | 132 ++++++++++++++++++
 4 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/netfilter/nft_offload.sh

-- 
2.53.0


