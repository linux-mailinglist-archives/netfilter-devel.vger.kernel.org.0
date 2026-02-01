Return-Path: <netfilter-devel+bounces-10553-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EJbODGvf2mIvwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10553-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 01 Feb 2026 20:53:21 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEEEC71BD
	for <lists+netfilter-devel@lfdr.de>; Sun, 01 Feb 2026 20:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB3853000FD7
	for <lists+netfilter-devel@lfdr.de>; Sun,  1 Feb 2026 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CFD2253EE;
	Sun,  1 Feb 2026 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailfence.com header.i=brianwitte@mailfence.com header.b="UFjgak2J"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F43126C02
	for <netfilter-devel@vger.kernel.org>; Sun,  1 Feb 2026 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769975598; cv=none; b=mA/cj/EZ+F1YG+20jSgxfhv7sOa7AYMyzQa9POOrLL/StSGAH32C/5kmeu4jjKPuQhOllv3rw+96dc1e3QJ/ebgQ3elayLMD88VtQhk5ned3DsJIgQMoooZDhU9NFHLj1MXV83TKSx+q2S/c0c6ISDXqy8RXbCbApCqETHIcv7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769975598; c=relaxed/simple;
	bh=qlFc2U8FISKa5N2pP1v7Cw5vxsn+qWnvX80kEnjEXGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nv+PKv02mlBMnKYEFLWwZ0fYy/TSKrIoEec2LjvXVPjKK+yWgfNVROGPUHYk5zZCmVyXOITBpz88SGIga+qViUwNH1JIKPv5gFP/vm4Q2DOq2YQ/U6C7J8xl+lvUYotP0ZZUXgGUjJ6EVz+C9HfRwPqQu+CM7YMiA4E/ngdaaOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com; spf=pass smtp.mailfrom=mailfence.com; dkim=pass (2048-bit key) header.d=mailfence.com header.i=brianwitte@mailfence.com header.b=UFjgak2J; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailfence.com
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 2388613D5;
	Sun,  1 Feb 2026 20:53:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769975593;
	s=20240605-akrp; d=mailfence.com; i=brianwitte@mailfence.com;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=Dt0dDgkQjig39QpXYVdMPNvks0pi294GapvttxoukH8=;
	b=UFjgak2JJ2VGfVWd4ezVWBvBv+iYMf3wYr2ANDon8r1NNWZZDpbX02seQOlXucfj
	r7gSO3PXZbrnhZm+qvc+Q/MLqAiIXxwxebC9PQ5TnVRTsTUFTRoZclna5EvLrvp/dL4
	Nv3v6sJYzvgfsZ5hTX326+YND5zDvgpu20Y45oORMMzxfoZ1rrlaAbuo9xxCay01Z+n
	FeuhoQk7vK8C+przhczzcm0EkartIeNxZnQEOX07va0Be2XA9U27o1U6+96v4euWefL
	8IEuk6F4M+X9tebPZCovZ8vltkNkiajt/NXwBol9qxPDXqbKvW9Z0e6U0rpGktxZmli
	t9w4RM7Q0Q==
Received: by smtp.mailfence.com with ESMTPSA ; Sun, 1 Feb 2026 20:53:10 +0100 (CET)
From: Brian Witte <brianwitte@mailfence.com>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	kadlec@blackhole.kfki.hu,
	syzbot+ff16b505ec9152e5f448@syzkaller.appspotmail.com,
	Brian Witte <brianwitte@mailfence.com>
Subject: [PATCH v3 0/2] netfilter: nf_tables: fix reset request deadlock
Date: Sun,  1 Feb 2026 13:52:53 -0600
Message-ID: <20260201195255.532559-1-brianwitte@mailfence.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ContactOffice-Account: com:441463380
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailfence.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mailfence.com:s=20240605-akrp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:server fail,mailfence.com:server fail];
	TAGGED_FROM(0.00)[bounces-10553-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brianwitte@mailfence.com,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailfence.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netfilter-devel,ff16b505ec9152e5f448];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mailfence.com:mid,mailfence.com:dkim]
X-Rspamd-Queue-Id: 8EEEEC71BD
X-Rspamd-Action: no action

syzbot reported a circular lock dependency when nft reset, ipset list,
and iptables-nft with set match run concurrently:

  CPU0 (nft reset):        nlk_cb_mutex -> commit_mutex
  CPU1 (ipset list):       nfnl_subsys_ipset -> nlk_cb_mutex
  CPU2 (iptables -m set):  commit_mutex -> nfnl_subsys_ipset

The bug was introduced by commits that added commit_mutex locking to
serialize reset requests.

v3:
  - Restructured as 2-patch series per Florian's suggestion:
    1. Revert the 3 commits that added commit_mutex locking
    2. Add spinlock-based serialization for reset requests

v2:
  - Switched to a spinlock in nft_pernet instead of mutex
  - Spinlock doesn't sleep, so we stay in RCU read-side critical section
  - Removes the try_module_get/module_put and rcu_read_unlock/lock dance
  Link: https://lore.kernel.org/netfilter-devel/20260201062517.263087-1-brianwitte@mailfence.com/

v1:
  - Proposed using a dedicated reset_mutex instead of commit_mutex
  Link: https://lore.kernel.org/netfilter-devel/20260127030604.39982-1-brianwitte@mailfence.com/

Brian Witte (2):
  Revert nf_tables commit_mutex in reset path
  netfilter: nf_tables: use spinlock for reset serialization

 include/net/netfilter/nf_tables.h |   1 +
 net/netfilter/nf_tables_api.c     | 279 +++++++++---------------------
 2 files changed, 78 insertions(+), 202 deletions(-)

--
2.47.3


