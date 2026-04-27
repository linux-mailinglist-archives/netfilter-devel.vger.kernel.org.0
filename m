Return-Path: <netfilter-devel+bounces-12216-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB1VEnZY72n5AQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12216-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 14:37:10 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E341447296C
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 14:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBE5830058F1
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Apr 2026 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D403AA1B5;
	Mon, 27 Apr 2026 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="uNx+0bjz"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1793B95E9
	for <netfilter-devel@vger.kernel.org>; Mon, 27 Apr 2026 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293427; cv=none; b=gBC0NlGNLsGTHCohtWlWERaxgdoPvmnaebxN9B6kAPwRXBs1Rp197pgP2J+5SRPWFP4CyAx63VPqsfY9bUxmCDDh7D2W8NPGgmrJQwJ0UJaJH/tLqHewRZAohuMgHS/ifyY9oY8IzIIcjzxx9oXhGHhHkFnb2OXr6v+QOOlTCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293427; c=relaxed/simple;
	bh=Tt+Xt1t1RuZ+3o09ttPFrf1YfKb/s9pIJyjK/3mOxUY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BLRnWLmAWZCwkxU65Ka5tVG25Br87J5BI6axGESFfEDjdfKiP0sxdtmjrpsV6+KXt5W5CP44vdd4bsd0jHOzAEalHaIidtt9sBmSHDFuoRaHP7BWigfYT1dQsi/T4rFii8HB0ZUalpUnKw+feyiAFQ1BcQfsL/bCzbztWSEVXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=uNx+0bjz; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 02EAB6017D
	for <netfilter-devel@vger.kernel.org>; Mon, 27 Apr 2026 14:36:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1777293417;
	bh=PzWJWJqTQju2F307osBi9NgoCltIXMSM13ktWnoYJ+4=;
	h=From:To:Subject:Date:From;
	b=uNx+0bjzH8+GuAMHtKqNoYTXCMR62GluIJ7ub2etErwal+SVaZ7LwatrG9dvE9KzF
	 NpEeqyRGBSRKc4URywVVuQ/LiS1D1Elm60wU03XD67k/5J5Cgrrk+DrRT4BWK69Gj1
	 bAbaMZEtrHNfURRelyfbcfqo/cZSUXZB60Wn5tj7EGM0ZmV36qhLQxmzKd0cItFkp/
	 pRQz6tg5N5LRsO+JFQCmCd6VSoOFlVWGYTY8tBnG8nY+twmOdIL9vszGSZay6YQfnR
	 uuDrd4rbwjBo3GmnY9FHozvQy77xofRmBlmECpZlEG4UbP/fVhBoJ/CyzgODzuCr1p
	 /gyiKmAzdEO3g==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v5 1/3] netfilter: replace skb_try_make_writable() by skb_ensure_writable()
Date: Mon, 27 Apr 2026 14:36:51 +0200
Message-ID: <20260427123653.9103-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E341447296C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-12216-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

skb_try_make_writable() only works on clones and uncloned packets might
have their network header in paged fragments.

nft_fwd needs to work for the ingress and egress hooks, but the egress
hook where skb->data points to the mac header, use skb_network_offset()
to include the mac header. The flowtable is fine since it already uses
the transport offset.

Fixes: d32de98ea70f ("netfilter: nft_fwd_netdev: allow to forward packets via neighbour layer")
Fixes: 7d2086871762 ("netfilter: nf_flow_table: move ipv4 offload hook code to nf_flow_table")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v5: no changes

 net/netfilter/nf_flow_table_ip.c | 4 ++--
 net/netfilter/nft_fwd_netdev.c   | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index fd56d663cb5b..dbd7644fdbeb 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -524,7 +524,7 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 		return 0;
 	}
 
-	if (skb_try_make_writable(skb, thoff + ctx->hdrsize))
+	if (skb_ensure_writable(skb, thoff + ctx->hdrsize))
 		return -1;
 
 	flow_offload_refresh(flow_table, flow, false);
@@ -1037,7 +1037,7 @@ static int nf_flow_offload_ipv6_forward(struct nf_flowtable_ctx *ctx,
 		return 0;
 	}
 
-	if (skb_try_make_writable(skb, thoff + ctx->hdrsize))
+	if (skb_ensure_writable(skb, thoff + ctx->hdrsize))
 		return -1;
 
 	flow_offload_refresh(flow_table, flow, false);
diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 4bce36c3a6a0..2cc809303ce8 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -100,6 +100,7 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 	int oif = regs->data[priv->sreg_dev];
 	unsigned int verdict = NF_STOLEN;
 	struct sk_buff *skb = pkt->skb;
+	int nhoff = skb_network_offset(skb);
 	struct net_device *dev;
 	int neigh_table;
 
@@ -111,7 +112,7 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 			verdict = NFT_BREAK;
 			goto out;
 		}
-		if (skb_try_make_writable(skb, sizeof(*iph))) {
+		if (skb_ensure_writable(skb, nhoff + sizeof(*iph))) {
 			verdict = NF_DROP;
 			goto out;
 		}
@@ -132,7 +133,7 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 			verdict = NFT_BREAK;
 			goto out;
 		}
-		if (skb_try_make_writable(skb, sizeof(*ip6h))) {
+		if (skb_ensure_writable(skb, nhoff + sizeof(*ip6h))) {
 			verdict = NF_DROP;
 			goto out;
 		}
-- 
2.47.3


