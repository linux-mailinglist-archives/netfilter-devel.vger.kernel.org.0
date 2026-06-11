Return-Path: <netfilter-devel+bounces-13216-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hhW9JAKGKmrhrgMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13216-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 11:55:14 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 129806709C3
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 11:55:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=V8Wwlqmg;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13216-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13216-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87B623381C29
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 09:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC4D3C4B79;
	Thu, 11 Jun 2026 09:49:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF6E3C4552;
	Thu, 11 Jun 2026 09:49:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171377; cv=none; b=FEGN7yrWGRuGGclXhjT7p03TFHJMbOOs105UmzlJqTsHILSL1tRKX4yG6/s2Fdw3TWXfXgluisk2A+FPz3mYyJNf+0VLp5hcQnZxVYciTR0N0qCDDuU9l2lmom39xks5CbwmFljwjApo+nwhzRkqeIgJN8mG+FcnfGtKlAdYVQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171377; c=relaxed/simple;
	bh=8PwBJNKvCWu7D867umcy85vVVL6UUfHlUGn4wj1H8hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaAYRIUZhDfp+Y8SpYVh7KtwIztbj00RAiyARaSJOCo515l20hk3Cb+LRF1cQDVdt11X95fZdNBdIkV2koMvHO1TzJAZU+eQfIOsdfiPwMX1iL4+itHl/UH4oJauQMqunblvPCX7a6iuqnJJEbkC7/bQBaevj1q7Gmjpwlrex8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=V8Wwlqmg; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 60AF16017E;
	Thu, 11 Jun 2026 11:49:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781171371;
	bh=IAx6z5nKjv31pKJhfY/EOEB8pHgNNHKKE/M2NRERuZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8Wwlqmg58ES6cZkrdbuntKZ6YhgWamCuAIe1zUEzp/qXJb368x5sYZuAjQoiMUjd
	 0lcfzG+uLwXc6UYe2VJyGHIEOpzntFvNZ1BN8qEPJXsiQI9YLaDSft/Y8zXGYvN3Bw
	 ItfkUf7YeliI+usVyNzGHMIosQo5GrZKP+cq8W7KZb5L4YOn0E4igUuhSXXKGeQJwD
	 4C+zbFIQ8u4t5VlbJBufvyHKiBbva9L11393KbgglRIGWms+p8qqQw4luEJ4y7QU82
	 QDD+Ca5LZpUmyX9kR/oI+7cIFUJcdgaG3kdg9qqg5R0txHwn3zPoX0mHAoL6gxdaUP
	 iLeLk3d02NmGA==
Date: Thu, 11 Jun 2026 11:49:28 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: fw@strlen.de, netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	phil@nwl.cc, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	ffmancera@riseup.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net] netfilter: nft_synproxy: stop bypassing the
 priv->info snapshot
Message-ID: <aiqEqH9GsBV4t_GU@chamomile>
References: <20260611042120.1462249-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611042120.1462249-1-runyu.xiao@seu.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ffmancera@riseup.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DMARC_NA(0.00)[netfilter.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13216-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,seu.edu.cn:email,netfilter.org:dkim,netfilter.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 129806709C3

Hi,

On Thu, Jun 11, 2026 at 12:21:20PM +0800, Runyu Xiao wrote:
> nft_synproxy_eval_v4() and nft_synproxy_eval_v6() already take a
> whole-object READ_ONCE() snapshot of the shared priv->info state before
> building the SYNACK reply, but nft_synproxy_tcp_options() still masks
> opts->options with priv->info.options from the live shared object.
> 
> When a named synproxy object is updated concurrently with SYN traffic,
> the eval path can then mix mss and timestamp handling from the local
> snapshot with an options mask taken from a newer configuration, so one
> SYNACK no longer reflects a coherent synproxy configuration.
> 
> Use info->options so nft_synproxy_tcp_options() stays on the same local
> snapshot that the eval path already copied from priv->info.

I'll incorporate this to nf-next, this is good for correctness, but no
crash is associated.

> Fixes: ee394f96ad75 ("netfilter: nft_synproxy: add synproxy stateful object support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  net/netfilter/nft_synproxy.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
> index 7641f249614c..9ed288c9d168 100644
> --- a/net/netfilter/nft_synproxy.c
> +++ b/net/netfilter/nft_synproxy.c
> @@ -24,14 +24,13 @@ static const struct nla_policy nft_synproxy_policy[NFTA_SYNPROXY_MAX + 1] = {
>  static void nft_synproxy_tcp_options(struct synproxy_options *opts,
>  				     const struct tcphdr *tcp,
>  				     struct synproxy_net *snet,
> -				     struct nf_synproxy_info *info,
> -				     const struct nft_synproxy *priv)
> +				     struct nf_synproxy_info *info)
>  {
>  	this_cpu_inc(snet->stats->syn_received);
>  	if (tcp->ece && tcp->cwr)
>  		opts->options |= NF_SYNPROXY_OPT_ECN;
>  
> -	opts->options &= priv->info.options;
> +	opts->options &= info->options;
>  	opts->mss_encode = opts->mss_option;
>  	opts->mss_option = info->mss;
>  	if (opts->options & NF_SYNPROXY_OPT_TIMESTAMP)
> @@ -56,7 +55,7 @@ static void nft_synproxy_eval_v4(const struct nft_synproxy *priv,
>  
>  	if (tcp->syn) {
>  		/* Initial SYN from client */
> -		nft_synproxy_tcp_options(opts, tcp, snet, &info, priv);
> +		nft_synproxy_tcp_options(opts, tcp, snet, &info);
>  		synproxy_send_client_synack(net, skb, tcp, opts);
>  		consume_skb(skb);
>  		regs->verdict.code = NF_STOLEN;
> @@ -87,7 +86,7 @@ static void nft_synproxy_eval_v6(const struct nft_synproxy *priv,
>  
>  	if (tcp->syn) {
>  		/* Initial SYN from client */
> -		nft_synproxy_tcp_options(opts, tcp, snet, &info, priv);
> +		nft_synproxy_tcp_options(opts, tcp, snet, &info);
>  		synproxy_send_client_synack_ipv6(net, skb, tcp, opts);
>  		consume_skb(skb);
>  		regs->verdict.code = NF_STOLEN;
> -- 
> 2.34.1

