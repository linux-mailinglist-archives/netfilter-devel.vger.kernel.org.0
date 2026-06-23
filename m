Return-Path: <netfilter-devel+bounces-13425-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UlkQGRIGO2oGOwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-13425-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 00:17:54 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0550A6BA61A
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 00:17:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=lnxH+VaU;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13425-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13425-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AA69309918C
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 22:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98173C2B80;
	Tue, 23 Jun 2026 22:16:04 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C1B3C4161;
	Tue, 23 Jun 2026 22:16:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252964; cv=none; b=gZdsfT7uvP9nXCS2WoiCUKPJAqlim1pPEys8m++N/BSl95BsHK79OdVZWFLsQNX3TixvdhOUT5buZfKvF3GrAJBVvjc4MKyZG5OSqFixX0h5xP7F5mGU+t9Nnojs+ueDuVtRPaxv0AY7xktf/D9v04j3NMppDDWv+4kesilV3tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252964; c=relaxed/simple;
	bh=kkdBNEJleQ+EwIARmcpo3tE5v85znoksQjLuW+D8jlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3H0zGwbKGq2gznuHYLiuQmPUL3pKCt9lDu3Pp2OQGNe0f3zoVI475T7l+dPaD+3hW5i6slKybJ/Cg3NE3rGq1VXiBFKK7n59N7kHpjU/dxKwMM5XkqaXFBmq/fR52RYZH2rHrvT5nda1kSyq5MkER/cT+oDVXXB4spsu9rrWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=lnxH+VaU; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 283966057B;
	Wed, 24 Jun 2026 00:15:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782252959;
	bh=71QmhRBsKjYPgcwSQ/V44nlkTJN0AjYuPmOrQoHzd54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lnxH+VaU6dXtOQvhCmpPMi/m1yQmQOLNee6yjRkPNRpaUaaftwHj6ZZBXWs/6jFlw
	 wS1xv+Z2LCz3puryCwjgKSEgFIMeTiFoo1h+sw36MZP56/HtQ7xrySkKmPJbUnuaV4
	 QIOI71QUQ4sTzxGbYYO/vedggKnGta0GsoE/Os1IHmykyC1M1WcGoOF9EvYC1Jl6jB
	 r+rcHPKBfUwsfjKTSw0PjCwD6wDwoUKsOr15pUSsdIqg2aW2fAkknke3fq7ILF1xXn
	 lPkdJncXwVBGPJrCSE/66Jh24KkvEic9SdUGC7TXQG4CtYnkptpLKAE22MNeHAHmUD
	 8Fcj2kr6EMkeA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 05/14] netfilter: nft_synproxy: stop bypassing the priv->info snapshot
Date: Wed, 24 Jun 2026 00:15:38 +0200
Message-ID: <20260623221548.701545-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623221548.701545-1-pablo@netfilter.org>
References: <20260623221548.701545-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13425-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,seu.edu.cn:email,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0550A6BA61A

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

nft_synproxy_eval_v4() and nft_synproxy_eval_v6() already take a
whole-object READ_ONCE() snapshot of the shared priv->info state before
building the SYNACK reply, but nft_synproxy_tcp_options() still masks
opts->options with priv->info.options from the live shared object.

When a named synproxy object is updated concurrently with SYN traffic,
the eval path can then mix mss and timestamp handling from the local
snapshot with an options mask taken from a newer configuration, so one
SYNACK no longer reflects a coherent synproxy configuration.

Use info->options so nft_synproxy_tcp_options() stays on the same local
snapshot that the eval path already copied from priv->info.

Fixes: ee394f96ad75 ("netfilter: nft_synproxy: add synproxy stateful object support")
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_synproxy.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
index 7641f249614c..9ed288c9d168 100644
--- a/net/netfilter/nft_synproxy.c
+++ b/net/netfilter/nft_synproxy.c
@@ -24,14 +24,13 @@ static const struct nla_policy nft_synproxy_policy[NFTA_SYNPROXY_MAX + 1] = {
 static void nft_synproxy_tcp_options(struct synproxy_options *opts,
 				     const struct tcphdr *tcp,
 				     struct synproxy_net *snet,
-				     struct nf_synproxy_info *info,
-				     const struct nft_synproxy *priv)
+				     struct nf_synproxy_info *info)
 {
 	this_cpu_inc(snet->stats->syn_received);
 	if (tcp->ece && tcp->cwr)
 		opts->options |= NF_SYNPROXY_OPT_ECN;
 
-	opts->options &= priv->info.options;
+	opts->options &= info->options;
 	opts->mss_encode = opts->mss_option;
 	opts->mss_option = info->mss;
 	if (opts->options & NF_SYNPROXY_OPT_TIMESTAMP)
@@ -56,7 +55,7 @@ static void nft_synproxy_eval_v4(const struct nft_synproxy *priv,
 
 	if (tcp->syn) {
 		/* Initial SYN from client */
-		nft_synproxy_tcp_options(opts, tcp, snet, &info, priv);
+		nft_synproxy_tcp_options(opts, tcp, snet, &info);
 		synproxy_send_client_synack(net, skb, tcp, opts);
 		consume_skb(skb);
 		regs->verdict.code = NF_STOLEN;
@@ -87,7 +86,7 @@ static void nft_synproxy_eval_v6(const struct nft_synproxy *priv,
 
 	if (tcp->syn) {
 		/* Initial SYN from client */
-		nft_synproxy_tcp_options(opts, tcp, snet, &info, priv);
+		nft_synproxy_tcp_options(opts, tcp, snet, &info);
 		synproxy_send_client_synack_ipv6(net, skb, tcp, opts);
 		consume_skb(skb);
 		regs->verdict.code = NF_STOLEN;
-- 
2.47.3


