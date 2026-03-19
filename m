Return-Path: <netfilter-devel+bounces-11292-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIS3ADjEu2n1ngIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11292-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 10:39:04 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 975FE2C8D02
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 10:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1EF8302B1A1
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2026 09:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C8A39E6FD;
	Thu, 19 Mar 2026 09:38:49 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5895737BE96;
	Thu, 19 Mar 2026 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913129; cv=none; b=OtQDQcqna4XuBugZoFR8IaGzEUMxgwxoobftoL12jSOryBPjjDEXQGPz5z0jsWDgaAEiKLvVO2G+SD4uTvVTSk8v9Wx+f/RmlWiS3TOnQlqBBDG+UXazWH08ofOO8DZaFdoCLIJRWXopmAyLMIRUeXALD8OHDTGmbxxgM6HVix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913129; c=relaxed/simple;
	bh=pwXh1TlQ/lz1pUnL3QCwayjAB6cgKGK96VVbkaewFz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbhwM/bjm11LiY1QAfhP7gtivNOK9q2s5pAqqfqH1W+lGpVN9lCpHMrklc6tniAS51QYx9THi3khbhr8FXzxLSE8XDSCUSPEHaY0eioT5dOIx70R+lN/Ff5crK7vh+elDSTUrBK6DQp+qaicS3wCrJSpNhy6tJ+9/dtUGkv0vBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D15F5606E1; Thu, 19 Mar 2026 10:38:46 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 2/3] netfilter: nf_tables: release flowtable after rcu grace period on error
Date: Thu, 19 Mar 2026 10:38:33 +0100
Message-ID: <20260319093834.19933-3-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260319093834.19933-1-fw@strlen.de>
References: <20260319093834.19933-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11292-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.346];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,strlen.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 975FE2C8D02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pablo Neira Ayuso <pablo@netfilter.org>

Call synchronize_rcu() after unregistering the hooks from error path,
since a hook that already refers to this flowtable can be already
registered, exposing this flowtable to packet path and nfnetlink_hook
control plane.

This error path is rare, it should only happen by reaching the maximum
number hooks or by failing to set up to hardware offload, just call
synchronize_rcu().

There is a check for already used device hooks by different flowtable
that could result in EEXIST at this late stage. The hook parser can be
updated to perform this check earlier to this error path really becomes
rarely exercised.

Uncovered by KASAN reported as use-after-free from nfnetlink_hook path
when dumping hooks.

Fixes: 3b49e2e94e6e ("netfilter: nf_tables: add flow table netlink frontend")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 9b1c8d0a35fb..3922cff1bb3d 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9203,6 +9203,7 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 	return 0;
 
 err_flowtable_hooks:
+	synchronize_rcu();
 	nft_trans_destroy(trans);
 err_flowtable_trans:
 	nft_hooks_destroy(&flowtable->hook_list);
-- 
2.52.0


