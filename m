Return-Path: <netfilter-devel+bounces-12764-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPP3HU04EGoaVAYAu9opvQ
	(envelope-from <netfilter-devel+bounces-12764-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 13:04:45 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D3F5B2AF7
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 13:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AFB930B0458
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 10:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961B73CE0AF;
	Fri, 22 May 2026 10:43:36 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE9F3AE6E9;
	Fri, 22 May 2026 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446616; cv=none; b=URWGaxzGGcWCYWRAfAYo+kqMAiUwHISlVoKilN3+zPvjj4gwj/TB2PJ7oHL51KFRwIfMk+KmAJ4KTca/+5jI4oKD53EDOwcCwJ6rWx/35Q8kZWuVUyfG85IwopHzxM+gYbVB13yl4lr1xgpiWxwJq6gPX3liKYxi12BGsfPoQIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446616; c=relaxed/simple;
	bh=XgzkTC3vRLHX/YHjdeUQpNxgoMy1bH2aoalGUr1p3so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scdMmYUbwiQngXxeTJdxjqFXY3ka2MLb4nNFXlg0UYcu6tlnymzUuCyjPexGoNxmy5sdFzWTpvDYcmV85TwnFViH18o85k9n9BP0pxYuDjejqn3o+8DRrpYN6g0pCPMCK0cim73fBn69tx9qNGijBwD8JitbBQjh8ZoukPtj8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B1259602C8; Fri, 22 May 2026 12:43:33 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 07/10] netfilter: nft_fib_ipv6: walk fib6_siblings under RCU
Date: Fri, 22 May 2026 12:42:54 +0200
Message-ID: <20260522104257.2008-8-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522104257.2008-1-fw@strlen.de>
References: <20260522104257.2008-1-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12764-lists,netfilter-devel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 78D3F5B2AF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiayuan Chen <jiayuan.chen@linux.dev>

nft_fib6_info_nh_uses_dev() runs from nft_fib6_eval() in softirq under
rcu_read_lock().  fib6_siblings is modified by writers that hold
tb6_lock but do not wait for RCU readers, so the sibling walk should
use list_for_each_entry_rcu(): it adds READ_ONCE() on the ->next
pointer and lets CONFIG_PROVE_RCU_LIST validate the locking.

No functional change for non-debug builds.

Fixes: 1c32b24c234b ("netfilter: nft_fib_ipv6: switch to fib6_lookup")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv6/netfilter/nft_fib_ipv6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index 8b2dba88ee96..5e192a446ec8 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -170,7 +170,7 @@ static bool nft_fib6_info_nh_uses_dev(struct fib6_info *rt,
 	if (nft_fib6_info_nh_dev_match(nh_dev, dev))
 		return true;
 
-	list_for_each_entry(iter, &rt->fib6_siblings, fib6_siblings) {
+	list_for_each_entry_rcu(iter, &rt->fib6_siblings, fib6_siblings) {
 		nh_dev = fib6_info_nh_dev(iter);
 
 		if (nft_fib6_info_nh_dev_match(nh_dev, dev))
-- 
2.53.0


