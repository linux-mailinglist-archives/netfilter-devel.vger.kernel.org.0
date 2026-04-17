Return-Path: <netfilter-devel+bounces-12001-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IkVAmIz4mkZ3QAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12001-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 15:19:30 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C524B41B8EA
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 15:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B7C7301F3D5
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B895374E4E;
	Fri, 17 Apr 2026 13:19:24 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB7B39D6E5
	for <netfilter-devel@vger.kernel.org>; Fri, 17 Apr 2026 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431964; cv=none; b=XeqxvFsUx1c01Q1InhBXykSEKmIE299TeSo9XXT18NTWPGwVQXmQ7avRTDcWG8ztyUmFWlTxsFG5bWw2CGEA/diAceU6/uQ4gs467VKmwn6yK3AHt1ufE1n0ofTxoN1TI7x8yFSdMNeBr4EAuXbeHsAOcO/pQr7p8/MwSa945+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431964; c=relaxed/simple;
	bh=NXsNJmjEDNJ1ab2syQQd0ymCfmmePOx4N7AbtgrxcYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltmvJW36kyLpLzvVfshVXXXJc3gOsJY7h1fcLOVSSChjj62Y7K1gwl1jzf9za8zk3EdfzSdiBqkZB5Gkc5u1eoGlMpXNBcLuQa5yGAq3sj+mUB0UeemNUTQ1GutXqW2QM60ubymVgE4s+Kh64S5rpr2sDYQmYQPiLMKV1650Hd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 478A860301; Fri, 17 Apr 2026 15:19:15 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: arp_tables: fix IEEE1394 ARP payload mangling
Date: Fri, 17 Apr 2026 15:19:05 +0200
Message-ID: <20260417131910.17932-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
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
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12001-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.925];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,strlen.de:mid,strlen.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C524B41B8EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sashiko.dev noticed that similar bug pattern exists in arpt_mangle:
  "IEEE1394 ARP payloads omit the target hardware address, advancing
  arpptr by hln after the source IP address skips over the actual target
  IP address."

Apply similar fix: check dev->type.  If we're asked to mangle what
doesn't exist, drop the packet.

Fixes: 6752c8db8e0c ("firewire net, ipv4 arp: Extend hardware address and remove driver-level packet inspection.")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Collides with a inflight patch.
 I'll rebase or discard depending on what netdev@ does.

 net/ipv4/netfilter/arpt_mangle.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/netfilter/arpt_mangle.c b/net/ipv4/netfilter/arpt_mangle.c
index a4e07e5e9c11..5a3560e1b59b 100644
--- a/net/ipv4/netfilter/arpt_mangle.c
+++ b/net/ipv4/netfilter/arpt_mangle.c
@@ -13,6 +13,7 @@ static unsigned int
 target(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	const struct arpt_mangle *mangle = par->targinfo;
+	bool has_tgt_devaddr = true;
 	const struct arphdr *arp;
 	unsigned char *arpptr;
 	int pln, hln;
@@ -39,13 +40,33 @@ target(struct sk_buff *skb, const struct xt_action_param *par)
 		memcpy(arpptr, &mangle->u_s.src_ip, pln);
 	}
 	arpptr += pln;
+
+	if (IS_ENABLED(CONFIG_FIREWIRE_NET)) {
+		const struct net_device *dev = skb->dev;
+
+		if (!dev) {
+			/* can't munge without arphrd type. */
+			if (mangle->flags & (ARPT_MANGLE_TDEV|ARPT_MANGLE_TIP))
+				return NF_DROP;
+			return mangle->target;
+		}
+
+		if (dev->type == ARPHRD_IEEE1394)
+			has_tgt_devaddr = false;
+	}
+
 	if (mangle->flags & ARPT_MANGLE_TDEV) {
+		if (!has_tgt_devaddr)
+			return NF_DROP;
+
 		if (ARPT_DEV_ADDR_LEN_MAX < hln ||
 		   (arpptr + hln > skb_tail_pointer(skb)))
 			return NF_DROP;
 		memcpy(arpptr, mangle->tgt_devaddr, hln);
 	}
-	arpptr += hln;
+	if (has_tgt_devaddr)
+		arpptr += hln;
+
 	if (mangle->flags & ARPT_MANGLE_TIP) {
 		if (ARPT_MANGLE_ADDR_LEN_MAX < pln ||
 		   (arpptr + pln > skb_tail_pointer(skb)))
-- 
2.52.0


