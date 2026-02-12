Return-Path: <netfilter-devel+bounces-10747-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAXzK9vGjWnT6gAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10747-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 13:26:03 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD5812D728
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 13:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A4B13010B67
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Feb 2026 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D032FF150;
	Thu, 12 Feb 2026 12:26:00 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAAB770FE
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Feb 2026 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770899160; cv=none; b=axLbYvd7zx/GcYXRcI8tJYp7+HlfWHPhSZM8ydb+cDkvAN4A4rn5KHoR2IK/tJuE/Q9bLAiTA1971iCko4b2coK3HYwvlEh40IPRjZ2zV5/P8VDEVT+jDBvfvCp8LTtnZyYNFYoOC6DGk4hcwvjPpz4XpEBkB9O/Hsr16mktn/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770899160; c=relaxed/simple;
	bh=b1/kmZXqfvxCOxzyBd8JGL4l2YmQRfIbLtDvDM053Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RA7Ko1tEzoPItxiT7h/gEx1JGNwYEMmP6exSAzPFIifB0GgcfFKXQFK5yblysmj0ifLPkrp1ow/jezlo8QL5U5hWVMpuf4VeMXml6db0+Wh6mzTn9PuVrHVMGjwvXh55g1B2PoEwmKHx8glncLns4bxQ7wnHuLA85I5UhbQgIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 269A76063D; Thu, 12 Feb 2026 13:25:57 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 1/2] ipv6: export fib6_lookup for nft_fib_ipv6
Date: Thu, 12 Feb 2026 13:25:08 +0100
Message-ID: <20260212122547.10437-2-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212122547.10437-1-fw@strlen.de>
References: <20260212122547.10437-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10747-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CD5812D728
X-Rspamd-Action: no action

Next patch will call fib6_lookup from nft_fib_ipv6.

Alternative is to use an indirect call via ipv6_stub->fib6_lookup(), but
thats more expensive than a direct call.

Also, nft_fib_ipv6 cannot be builtin if ipv6 is a module.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv6/fib6_rules.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index fd5f7112a51f..e1b2b4fa6e18 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -92,6 +92,9 @@ int fib6_lookup(struct net *net, int oif, struct flowi6 *fl6,
 
 	return err;
 }
+#if IS_MODULE(CONFIG_NFT_FIB_IPV6)
+EXPORT_SYMBOL_GPL(fib6_lookup);
+#endif
 
 struct dst_entry *fib6_rule_lookup(struct net *net, struct flowi6 *fl6,
 				   const struct sk_buff *skb,
-- 
2.52.0


