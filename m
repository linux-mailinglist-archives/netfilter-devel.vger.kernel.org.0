Return-Path: <netfilter-devel+bounces-12963-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHlULpFcHWoBZwkAu9opvQ
	(envelope-from <netfilter-devel+bounces-12963-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 01 Jun 2026 12:18:57 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2176E61D361
	for <lists+netfilter-devel@lfdr.de>; Mon, 01 Jun 2026 12:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B95D308AAD5
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Jun 2026 09:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87433B2D14;
	Mon,  1 Jun 2026 09:50:26 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E3439DBF9
	for <netfilter-devel@vger.kernel.org>; Mon,  1 Jun 2026 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307426; cv=none; b=rkLaN/FshyDnHmQKRVqSkx9neK3nvwFO62jiXflrKi2J43GqrjkyHd1kdOY6qCSRTNSfCwnKFvr+kaZbggZ12hMMd44EUFdiZdzuTdU0ZN+wRgp01aQ39CDY3uLgDvpccQfM6vGVgjP4cY5Ga523JLOpQZ2idOkLeoMAXJct1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307426; c=relaxed/simple;
	bh=kFflRUGqmcmH0XOCMdxDF9qHXy9Fpt4Rlsuj2e3P4rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlRhmJpnX8Hm2Qx1CNPWoUQsHAf+Jk2aEbiCiSm3vb4Lg/nkZG7z2YfwzG3CAqr/JcLtbp8AWWGTXo9rEY6aUZmEqPNHoMWylpJKfuDBVKfmkunBUO7+GfEiueuO9wa2YDuJWdhqfaojAPkDjVbws3md9Rq9a8wuHMw9/iyDwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 4BE0D604DC; Mon, 01 Jun 2026 11:50:11 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Hacking <eilaimemedsnaimel@gmail.com>
Subject: [PATCH nf] netfilter: bridge: ebt_redirect: don't assume bridge port exists
Date: Mon,  1 Jun 2026 11:50:00 +0200
Message-ID: <20260601095000.595383-1-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[strlen.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-12963-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.897];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2176E61D361
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ebt_redirect_tg() dereferences br_port_get_rcu() return without a
NULL check, causing a kernel panic when the bridge port has been
removed between the original hook invocation and an NFQUEUE
reinject.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Hacking <eilaimemedsnaimel@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/bridge/netfilter/ebt_redirect.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/bridge/netfilter/ebt_redirect.c b/net/bridge/netfilter/ebt_redirect.c
index 307790562b49..379662961aeb 100644
--- a/net/bridge/netfilter/ebt_redirect.c
+++ b/net/bridge/netfilter/ebt_redirect.c
@@ -20,16 +20,25 @@ static unsigned int
 ebt_redirect_tg(struct sk_buff *skb, const struct xt_action_param *par)
 {
 	const struct ebt_redirect_info *info = par->targinfo;
+	const unsigned char *dev_addr;
 
 	if (skb_ensure_writable(skb, 0))
 		return EBT_DROP;
 
-	if (xt_hooknum(par) != NF_BR_BROUTING)
-		/* rcu_read_lock()ed by nf_hook_thresh */
-		ether_addr_copy(eth_hdr(skb)->h_dest,
-				br_port_get_rcu(xt_in(par))->br->dev->dev_addr);
-	else
-		ether_addr_copy(eth_hdr(skb)->h_dest, xt_in(par)->dev_addr);
+	if (xt_hooknum(par) != NF_BR_BROUTING) {
+		const struct net_bridge_port *port;
+
+		port = br_port_get_rcu(xt_in(par));
+		if (!port)
+			return EBT_DROP;
+
+		dev_addr = port->br->dev->dev_addr;
+	} else {
+		dev_addr = xt_in(par)->dev_addr;
+	}
+
+	ether_addr_copy(eth_hdr(skb)->h_dest, dev_addr);
+
 	skb->pkt_type = PACKET_HOST;
 	return info->target;
 }
-- 
2.54.0


