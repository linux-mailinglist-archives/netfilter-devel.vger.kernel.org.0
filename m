Return-Path: <netfilter-devel+bounces-12147-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFXyGZ/I6WnAkAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12147-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Apr 2026 09:22:07 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEE844DEBB
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Apr 2026 09:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F409300AC80
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Apr 2026 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADDD29BD91;
	Thu, 23 Apr 2026 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="uRByGwLi"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332EE282F36
	for <netfilter-devel@vger.kernel.org>; Thu, 23 Apr 2026 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928924; cv=none; b=mRn0NP4HcAfldX5GspWYsjFc5GFt62KpIYFWbGP7nPmj5KIPM0qZGFgFKd6tQ+lkf768VsnM7f9s3MwVCRJpI/9RMlgZQLKWJ8XRokW+uPy8t6iYXt5v5hZ2zrZhyStUBEDbVZ/DsRsyY53a7k/yqey9rtbIS3YTOHHfz6JKL0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928924; c=relaxed/simple;
	bh=Te3jANmpVz14O2tVMH6PtSvH4FX0C/uEhZ6nQ0zep/Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KVvCZLurYg8vLlwatbHzZ2xRPJoCBhEetypdjDadyVTWYP5a55W/vP3TATTIwbuyBI2bVCxxsHeOGeiBirR6ajZ/jJLJFOk0OjqUSK7i4XV92fv9FUkjoePMtRmb1Z8KHmFTBrnrn1cpAW0Ac/ceunKQXDIDixPLUFe3BAxVJbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=uRByGwLi; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 454DE602C1
	for <netfilter-devel@vger.kernel.org>; Thu, 23 Apr 2026 09:21:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776928919;
	bh=DtpZ4Lk1uPMnmsW+kOGn+BFCEyG0rIb9b6XR0vUIqHo=;
	h=From:To:Subject:Date:From;
	b=uRByGwLi4xYrIVzVRqrV2JCGwvWUbt4T0+RqDpMyNaSsNnmUblPdPWO2Kj4EMUuyY
	 Rz82QLnJiinLolwSUd0AeyXDoX372fQeyAPpDwngsVcK93HVgHeXByoX52T8ne0JfZ
	 YlWyeaQnpPY7jYCuT58Fc2i9np6NG8bxuIfbnxm/S9J50+JtKqR2wvaXbiYdrExIOd
	 cq3u3Ugw6WwHb4rjNmc0uTUFREzuK+3TMNa7w9K3b+L1Z/FQHzVErZdWC7dJleXjDV
	 orFV8GYJsK4xO+rD4j9SkmvhCR5X5hJvqiJauFxu0UPTiq8AOSay+xlf7s1pVB6+I/
	 jfRbetT7o4ZFg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v4 1/3] netfilter: replace skb_try_make_writable() by skb_ensure_writable()
Date: Thu, 23 Apr 2026 09:21:53 +0200
Message-ID: <20260423072155.352333-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-12147-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EEE844DEBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
v4: no changes.

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


