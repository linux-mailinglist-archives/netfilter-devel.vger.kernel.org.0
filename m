Return-Path: <netfilter-devel+bounces-12217-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLdlJatZ72n5AQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12217-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 14:42:19 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CA3472A7F
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 14:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6B2130A1E63
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DF33B8BA5;
	Mon, 27 Apr 2026 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="rALDie6K"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109D83B637A
	for <netfilter-devel@vger.kernel.org>; Mon, 27 Apr 2026 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293427; cv=none; b=Z/6Pe8M4ahBbkrH4oSljKSwfgCqf7ZKtJuwUHt9aamOfBYq3LnyK8mcOyLAoFMFWP0hdde9YpRtLA4AMgFL96f/E4QrsDCKrGwy1nckmrx+nhRPBsOFTs2vOYq49GG6I754fHRmt1WQdnhESqgg8MubWeil6J9Uvdm03rDA/PVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293427; c=relaxed/simple;
	bh=YAHDj6OrMxAA7NeBV0yqj38YpnxdAl8VWbsE+s1EVEk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1EHyoWzEYo6V6DRhiTbNzZtXThzbGtBPVnUgVur3A3BBgoZ7xX4ChpJOfecCZCms7zDO5FDtPKRWUm3TtdOdistR5fnFdh6u4nIrAYyxpGVGzoqWFj6wEJPgIkEZjxnfujuUhmQWc7JNb5l595HJxrPfl1cpYCLr0xiFe9Yt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=rALDie6K; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 3C1FC60181
	for <netfilter-devel@vger.kernel.org>; Mon, 27 Apr 2026 14:36:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1777293419;
	bh=IYahGO1JvXj4O7AaxKnasc2U4IVAPVVPf90rIZQP5bA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rALDie6KzyPFYrA0+PlgKxxoq0Z0NKY44oE8kAjsfaGdxyNtuWmvtxDRUkcmNakGh
	 OiGUwvcOLjZuHpyMlr5YKp7X9BHRKjAuGMscjK8DXqQE72GnfRpOQzEnWMAESaLx6M
	 47Nbo8RYeTFkq03rJ6i3NZxfoBGchc+ZrlH5XygiCX6sDrzVhsRHjv0bnnLjkGQEZI
	 VvBJxzVJ3tch5U8gQShJXuu04Df1pxljJaHCd4qjIJgrBSr2KH3tii88rLJsdYtadc
	 DEWBdDuyJofaVDFLeNP5UjeOUh16VSfH5J2iqN1hHf1ZNGP0Ms639MXtYy8PWONXUH
	 ONg5LW2idbw6g==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v5 2/3] netfilter: nft_fwd_netdev: add device and headroom validate with neigh forwarding
Date: Mon, 27 Apr 2026 14:36:52 +0200
Message-ID: <20260427123653.9103-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427123653.9103-1-pablo@netfilter.org>
References: <20260427123653.9103-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 06CA3472A7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-12217-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The ttl field has been decremented already and evaluation of this rule
would proceed, just drop this packet instead if there is no destination
device to forwards this packet. This is exactly what nf_dup already does
in this case.

Moreover, use skb_cow_head() to ensure there is sufficient headroom when
forwarding this via neigh_xmit().

Fixes: d32de98ea70f ("netfilter: nft_fwd_netdev: allow to forward packets via neighbour layer")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v5: rewrite patch title and add skb_cow_head() call

 net/netfilter/nft_fwd_netdev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 2cc809303ce8..94d6397f10a8 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -153,8 +153,15 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 	}
 
 	dev = dev_get_by_index_rcu(nft_net(pkt), oif);
-	if (dev == NULL)
-		return;
+	if (dev == NULL) {
+		verdict = NF_DROP;
+		goto out;
+	}
+
+	if (skb_cow_head(skb, LL_RESERVED_SPACE(dev))) {
+		verdict = NF_DROP;
+		goto out;
+	}
 
 	skb->dev = dev;
 	skb_clear_tstamp(skb);
-- 
2.47.3


