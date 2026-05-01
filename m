Return-Path: <netfilter-devel+bounces-12373-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLV/ED+b9Gl1CwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12373-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 01 May 2026 14:23:27 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B98E4AC547
	for <lists+netfilter-devel@lfdr.de>; Fri, 01 May 2026 14:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B57CE3024151
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 May 2026 12:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4164F3A254D;
	Fri,  1 May 2026 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="dEmt2CjU"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8FB18DB01;
	Fri,  1 May 2026 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777638168; cv=none; b=suDiSR7avSZ/RenFmg6iGIqEdzqR5hsqoN5f0DJ/CUKOKk/1u4dFZMC3DS1wVtzp76RZOSgNgZRGgNY2Y+YWlTv+CG84Dk3a+UoFXT/qoOnhMQaVRuTuLmQs0ra370GvUIeVFflLmC6Jca0DGoeTVWSiovP60ozW6qRaXoiXHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777638168; c=relaxed/simple;
	bh=zoAbIRrdAKFpOVTrxKdkyEu/qfxQtjayieagMLT+Nh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C72T8mLYK/85PmL6rvnzL9sdIkVexl1FMMaZrtbxp4bXWOYeVRsOBJVmEEOmDXmwcCybUySEmTWKPIkjLCYGB5TpF4wxElMepBQsVmuTj3CGCB749o/EooQgxhGT8EOBKP+j7v/1qs+egA07ekrFHs6SntC0aI7mDUJ93o9DzUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=dEmt2CjU; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 6C9BD6024E;
	Fri,  1 May 2026 14:22:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1777638164;
	bh=EQCBMVFfc2pT8teCqSidZbSDdheBUZC2P5L7/mhKd7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dEmt2CjUZbsTC4qjYb7dd/G/zdHh1OwrxFGFkjnuXF9DnWFK9Bqrf7fqaNB4v/Eh8
	 9Q+pb/GqAaupQeLUvjNH7O0Mac19ndpbbMejzSs9emamHTwL/aUuSoSJC6PP7gMXc4
	 bM3nDhbY/r9dJWaOnMd9MEKQJvsU77IArhaRt9uHFN1wohxrxcAxwCf/v4iCjB2ZxY
	 /Gq9ELT6jlVOOUtVOd8NoNgpMf3CdCkHQ2qN/NKSyaxsOfkS5/9Byhc+H513UZRS/w
	 3P6ycorRxbad+SZUzJylnLzaPUcrRvwSJqb9GObIlHAzX1noW2njvf3kJvJi8YS+mF
	 pr83zoWYIm0bA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 02/14] netfilter: nft_fwd_netdev: add device and headroom validate with neigh forwarding
Date: Fri,  1 May 2026 14:22:25 +0200
Message-ID: <20260501122237.296262-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501122237.296262-1-pablo@netfilter.org>
References: <20260501122237.296262-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8B98E4AC547
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12373-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,netfilter.org:dkim,netfilter.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The ttl field has been decremented already and evaluation of this rule
would proceed, just drop this packet instead if there is no destination
device to forwards this packet. This is exactly what nf_dup already does
in this case.

Moreover, check for headroom and call skb_expand_head() like in the IP
output path to ensure there is sufficient headroom when forwarding this
via neigh_xmit().

Fixes: d32de98ea70f ("netfilter: nft_fwd_netdev: allow to forward packets via neighbour layer")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_fwd_netdev.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 2cc809303ce8..605b1d42abce 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -102,6 +102,7 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 	struct sk_buff *skb = pkt->skb;
 	int nhoff = skb_network_offset(skb);
 	struct net_device *dev;
+	unsigned int hh_len;
 	int neigh_table;
 
 	switch (priv->nfproto) {
@@ -153,8 +154,19 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 	}
 
 	dev = dev_get_by_index_rcu(nft_net(pkt), oif);
-	if (dev == NULL)
-		return;
+	if (dev == NULL) {
+		verdict = NF_DROP;
+		goto out;
+	}
+
+	hh_len = LL_RESERVED_SPACE(dev);
+	if (unlikely(skb_headroom(skb) < hh_len && dev->header_ops)) {
+		skb = skb_expand_head(skb, hh_len);
+		if (!skb) {
+			verdict = NF_STOLEN;
+			goto out;
+		}
+	}
 
 	skb->dev = dev;
 	skb_clear_tstamp(skb);
-- 
2.47.3


