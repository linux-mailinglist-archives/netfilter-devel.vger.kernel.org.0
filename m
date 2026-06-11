Return-Path: <netfilter-devel+bounces-13212-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id espYBAU5KmqAkgMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13212-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 06:26:45 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5858C66E2D7
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 06:26:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=be2mucMg;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13212-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13212-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF7B5307B5B6
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 04:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5E344DA4;
	Thu, 11 Jun 2026 04:26:41 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1C306746;
	Thu, 11 Jun 2026 04:26:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781152001; cv=none; b=i2rD4BZAT/ATDfrtfo6qu94VGUqB6IjCxmP1E+zp7pBmVh7v0P0xDHzHFlHWw4NgzQ1enMkkNFDVvvoDLV3u44OxcrZvMNCqSaQmEpoDX/MUh3tNlWNfIWedhmi9T1hYaAYv3gzkQb+lnAFEcgZWtdJXAXUg0VOZALwNcV7h7SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781152001; c=relaxed/simple;
	bh=szHRWS2Mlnm8qzQKXuB6uB+0YBd25h8XvYNfiiqquyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oy75tBHVhtweuUxe6XjmYoxeSItPeNFN+aOJADyzupFMVA0Ag5czG0W2Pc+HumtODTb5vjcxlHxZquODODU5clDnhFLRLjQym7j8pLDE36vqwGEhZP/sYidqhGn18YVPaoP8EdwqQ1xlzNMsRJd9WXOslAaxmFvKj7i555dG1LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=be2mucMg; arc=none smtp.client-ip=45.254.49.198
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 41f1897fd;
	Thu, 11 Jun 2026 12:21:24 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: pablo@netfilter.org,
	fw@strlen.de,
	netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ffmancera@riseup.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Runyu Xiao <runyu.xiao@seu.edu.cn>
Subject: [PATCH net] netfilter: nft_synproxy: stop bypassing the priv->info snapshot
Date: Thu, 11 Jun 2026 12:21:20 +0800
Message-Id: <20260611042120.1462249-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eb4e9d80103a1kunmb15b1b9d14e93b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGk5KVk5CGE5DSU0aSk4YSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=be2mucMgzuAycLZdEYR6ajjRi2xUN+JfOupILhLKHZ7+Ermtwoia+LN7yX1vQYCa4DHElmpoXd5EcuLd33PfJaiTTtmrC+GaDv0UDGR9VtfBtjXOMfROmYxc9BjvO4ousgNMZ/tOC3kJG+2xGYpwAre3IvnFESmtB9GkULKUI8c=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=OJZReDrJ7Jk/KMJdjtPdewiDjGjg7NfWU/MrhvshEeI=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ffmancera@riseup.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13212-lists,netfilter-devel=lfdr.de];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5858C66E2D7

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
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
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
2.34.1

