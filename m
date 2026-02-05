Return-Path: <netfilter-devel+bounces-10656-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDryMH1KhGk/2QMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10656-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 08:45:01 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4871BEF8B7
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 08:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3255B3002F5C
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Feb 2026 07:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6DB35DD0D;
	Thu,  5 Feb 2026 07:44:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62435CBA4;
	Thu,  5 Feb 2026 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277497; cv=none; b=a2HjYUPcueOa7t52Y/LFKKER6fzJqLifIghwOfXYwfjukjoS5aAxqm1Db1s4YsloM9T/nTp2HRWqdpxeyMvy8oLj/9s6xk2kfmgSdzN2l0st2g9jKAljsdtRNwV2S5xVepylOvnFASD+YH2sXFzB+FZUrbCQTCEEfu+kiEe/qhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277497; c=relaxed/simple;
	bh=/jkTfzwZ+od9lrq9+34U6g6JorKGDzIX2mk1SC6qlIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3DTHVHYTQeSlB2yEb+wcG/+bRtsLbTWhJ2OBWkL3anI5wjuF6EbBYyasbQuVdfcEEYfq4DQO09z5fpcJJkLpOUJzCOrpG2ykE9L92qN5WVOYjlO/purZPiX4Gb6Ofm+WVdLmAKa0TYamM3Lf/ppShovIKQcxbkiSFq/imnUmDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A8C5E6033F; Thu, 05 Feb 2026 08:44:54 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 0/1] netfilter: update for net
Date: Thu,  5 Feb 2026 08:44:49 +0100
Message-ID: <20260205074450.3187-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10656-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4871BEF8B7
X-Rspamd-Action: no action

Hi,

This is one last-minute crash fix for nf_tables, from Andrew Fasano:

Logical check is inverted, this makes kernel fail to correctly undo
the transaction, leading to a use-after-free.

Please, pull this change from:
The following changes since commit 7d6ba706ae5ef7d3d00b67140d2873ae1da6d41f:

  Merge tag 'wireless-2026-02-04' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2026-02-04 20:29:53 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-26-02-05

for you to fetch changes up to f41c5d151078c5348271ffaf8e7410d96f2d82f8:

  netfilter: nf_tables: fix inverted genmask check in nft_map_catchall_activate() (2026-02-05 08:36:59 +0100)

----------------------------------------------------------------
netfilter pull request nf-26-02-05

----------------------------------------------------------------

Andrew Fasano (1):
  netfilter: nf_tables: fix inverted genmask check in
    nft_map_catchall_activate()

 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.52.0

