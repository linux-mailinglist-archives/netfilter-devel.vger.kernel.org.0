Return-Path: <netfilter-devel+bounces-10439-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIdNAFI8eWkmwAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10439-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 23:29:38 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DFD9B0D3
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 23:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74262301E979
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 22:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC4B361657;
	Tue, 27 Jan 2026 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="Xmk2wumd"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4044A35CB94
	for <netfilter-devel@vger.kernel.org>; Tue, 27 Jan 2026 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769552965; cv=none; b=tb4NHmVNhL3yh9lG6NRjOFjmg8opi1ydDhRIPvtj8kGfEcu9GyydtgGEh4sRbiHbasBftf0EElMaBMwXW45bPlGBDFZJr2BjobiazwxYp5apnupnWRtkVRANRf2DPt0PPa/yrEeneP6na+Xpa3xHsB463eC5Exug1mawjZlgl3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769552965; c=relaxed/simple;
	bh=VGaqo+N4k0HSTLG2+sUlkURDZdqwWrdqwfTmTCiUzKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GhX3dCjmmWTmOvCfEvs6PM4RwCHha8TWk0fl9w2akrb4U9/S6Kj+8dMX0WfsYoQc6Y/OHbSaZDXQ6kRPsOFU23xsDNwPbH2BVx9gDbGSUCayZH0/JwFKJJyMl8X2VxuQpPv+Is5xjEvlQ34EepIMz6tgVQclMQxq5RQcATz2sk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=Xmk2wumd; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=w6G2hxVlECxQlv4m/y8w/Dm6LXkY1Gzaeh5BypSmCwQ=; b=Xmk2wumdu+wb93gBWWZOf+PeVx
	yiMSYC0P87dicNSg62o8t5D9iItWqE4+Pe31mnciSknpFf5SC2YqvOF3Kb28CGIg9JK6PrykqLJRQ
	HX633igVQ26a6jye8wUVIllEj2LwTNiz8C3z5bRwILzPQTeJbOU48vMpDLHT3dcXhxWRL+ESnbhIF
	Y8hOk5odgopCeLVYH4WX1sZgO8x1pbWoUMMqIn19TdIWaMK6iBiyFz0EIhJYo41lr4BgDNuQ0X+W6
	s+GClzAjZJJudhfu6rL5mTeuFsHcUVsIymmL9HglsAEaZfIjXNrGkt1+tsRvjQ3vP/eLufd/yeoZ6
	hAdg5Exg==;
Authentication-Results: mail.nwl.cc;
	iprev=pass (localhost) smtp.remote-ip=::1
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vkrYo-000000002lc-20rc;
	Tue, 27 Jan 2026 23:29:22 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: [nft PATCH 0/4] Inspect and improve test suite code coverage
Date: Tue, 27 Jan 2026 23:29:12 +0100
Message-ID: <20260127222916.31806-1-phil@nwl.cc>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10439-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makefile.am:url,nwl.cc:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89DFD9B0D3
X-Rspamd-Action: no action

While inspecting the test suites' code coverage using --coverage gcc
option and gcov(r) for analysis, I noticed that 'nft monitor' processes
did not influence the stats at all. It appears that a process receiving
SIGTERM or SIGINT (via kill or ctrl-c) does not dump profiling data at
exit. Installing a signal handler for those signals which calls exit()
resolves this, so patch 1 of this series implements --enable-profiling
into configure which also conditionally enables said signal handler.

Patches 2 and 4 fix for zero test coverage of src/nftrace.c and
src/xt.c, bumping stats to ~90% for both.

Patch 3 fixes for ignored comment matches in translated iptables-nft
rules. This is required for patch 4 which uses a comment match to check
whether nft is built with translation support.

Phil Sutter (4):
  configure: Implement --enable-profiling option
  tests: shell: Add a simple test for nftrace
  xt: Print comment match data as well
  tests: shell: Add a basic test for src/xt.c

 .gitignore                                 |   5 +
 Makefile.am                                |  16 +++
 configure.ac                               |   7 ++
 src/main.c                                 |  30 +++++
 src/xt.c                                   |   6 +-
 tests/shell/features/xtables_xlate.sh      |  21 ++++
 tests/shell/testcases/parsing/compat_xlate | 135 +++++++++++++++++++++
 tests/shell/testcases/trace/0001simple     |  85 +++++++++++++
 8 files changed, 304 insertions(+), 1 deletion(-)
 create mode 100755 tests/shell/features/xtables_xlate.sh
 create mode 100755 tests/shell/testcases/parsing/compat_xlate
 create mode 100755 tests/shell/testcases/trace/0001simple

-- 
2.51.0


