Return-Path: <netfilter-devel+bounces-12107-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JGaOCph52nF7QEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12107-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2026 13:36:10 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 418CB43A268
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2026 13:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6A2D302F581
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2026 11:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352A11A9B46;
	Tue, 21 Apr 2026 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="V+4IexVD"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3CD13C9C4
	for <netfilter-devel@vger.kernel.org>; Tue, 21 Apr 2026 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771247; cv=none; b=PS+Ex/1uPGPH9q7KH/V3vvkDpymjIZgn/hxunPR901anA5exyPFvzOyRbnkfzfODrkkW0pFfN0RnFGQIIIgux/Bz934ozbFl0f+WD2+6bnbyKSBR8F2BUB1RPOCh6tJn+VcnnuOeATzotLJCPz8oUHiIhckgyeUv3C5jtxukOls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771247; c=relaxed/simple;
	bh=R//aD4JBCG5/CKzF3i1JWr9u5wRZptYgd0gUB6/t3bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ez+BAlww1D4YL2qXAYrQd5LG2txPiHVNgtEW0Hdgb7PotLT/p1UV+AfQPcaKS+VX1YZ1zjZpMtB4H5yeMi/o8IXOyHYmzpIp1ty2Q4uaUXdYw2PjeRBltr2RfIuq2mfpskZ/I9OwiQSaIgIrNwfo1TeSW4xy4ppsTur+790brmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=V+4IexVD; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 861AF600B5;
	Tue, 21 Apr 2026 13:34:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776771241;
	bh=Y/pAISxyUlnDvCdm5ugVNJQaLaiPtH5iFEXRITf6oyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+4IexVDcHLCXaMfHRnoKno3QDYpu3tMm/mYyDhtgUc03hX5edNq9BFbqCLpzFrD4
	 cgiZiUia61taPgLxdmTf8bagxRdDpiyquRtKb72aC6e3Pz8R0yGolrLmIjIbLph2M1
	 5itOhCVBueid+utWvfI9Cc6Nt0gfyjUx19cjdIwptJ34jdut7HOFBbiMzZ9dFcW1wa
	 esMBnqyF5D81WPmo2Z74Tx7f/DdszchOfOg+dmMdrTGzqD9NJJ5jH5EcTiZp5PdITY
	 OF0V/M1C/778MIwFnti+On1GRxVYS96ut4eKccJB6DWxBsdNVVSk4BLM/G6gNA6MN+
	 rbOPFjE+d0Zfg==
Date: Tue, 21 Apr 2026 13:33:59 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	ecklm94@gmail.com, phil@nwl.cc, fw@strlen.de
Subject: Re: [PATCH 1/3 nf v3] netfilter: nf_socket: skip socket lookup for
 non-first fragments
Message-ID: <aedgp7Zx_b1xrnYC@chamomile>
References: <20260421104409.5452-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260421104409.5452-1-fmancera@suse.de>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12107-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com,nwl.cc,strlen.de];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:dkim]
X-Rspamd-Queue-Id: 418CB43A268
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Fernando,

This series LGTM, it is addressing the issues we have discussed.

On Tue, Apr 21, 2026 at 12:44:07PM +0200, Fernando Fernandez Mancera wrote:
> Both nft_socket and xt_socket relies on L4 headers to perform socket
> lookup in the slow path. For fragmented packets, while the IP protocol
> remains constant across all fragments, only the first fragment contains
> the actual L4 header.
> 
> As the expression/match could be attached to a chain with a priority
> lower than -400, it could bypass defragmentation.
> 
> Add a check for fragmentation in the lookup functions directly so the
> problem is handled for both nft_socket and xt_socket at the same time.
> In addition, future users of the functions would not need to care about
> this.
> 
> Fixes: 902d6a4c2a4f ("netfilter: nf_defrag: Skip defrag if NOTRACK is set")
> Fixes: 554ced0a6e29 ("netfilter: nf_tables: add support for native socket matching")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v3: added this patch to the series, I splitted this as the fix is
> generic for both nft_socket and xt_socket
> ---
>  net/ipv4/netfilter/nf_socket_ipv4.c | 3 +++
>  net/ipv6/netfilter/nf_socket_ipv6.c | 5 +++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/netfilter/nf_socket_ipv4.c b/net/ipv4/netfilter/nf_socket_ipv4.c
> index 5080fa5fbf6a..f9c6755f5ec5 100644
> --- a/net/ipv4/netfilter/nf_socket_ipv4.c
> +++ b/net/ipv4/netfilter/nf_socket_ipv4.c
> @@ -94,6 +94,9 @@ struct sock *nf_sk_lookup_slow_v4(struct net *net, const struct sk_buff *skb,
>  #endif
>  	int doff = 0;
>  
> +	if (ntohs(iph->frag_off) & IP_OFFSET)
> +		return NULL;
> +
>  	if (iph->protocol == IPPROTO_UDP || iph->protocol == IPPROTO_TCP) {
>  		struct tcphdr _hdr;
>  		struct udphdr *hp;
> diff --git a/net/ipv6/netfilter/nf_socket_ipv6.c b/net/ipv6/netfilter/nf_socket_ipv6.c
> index ced8bd44828e..893f2aeb4711 100644
> --- a/net/ipv6/netfilter/nf_socket_ipv6.c
> +++ b/net/ipv6/netfilter/nf_socket_ipv6.c
> @@ -100,6 +100,7 @@ struct sock *nf_sk_lookup_slow_v6(struct net *net, const struct sk_buff *skb,
>  	const struct in6_addr *daddr = NULL, *saddr = NULL;
>  	struct ipv6hdr *iph = ipv6_hdr(skb), ipv6_var;
>  	struct sk_buff *data_skb = NULL;
> +	unsigned short fragoff = 0;
>  	int doff = 0;
>  	int thoff = 0, tproto;
>  #if IS_ENABLED(CONFIG_NF_CONNTRACK)
> @@ -107,8 +108,8 @@ struct sock *nf_sk_lookup_slow_v6(struct net *net, const struct sk_buff *skb,
>  	struct nf_conn const *ct;
>  #endif
>  
> -	tproto = ipv6_find_hdr(skb, &thoff, -1, NULL, NULL);
> -	if (tproto < 0) {
> +	tproto = ipv6_find_hdr(skb, &thoff, -1, &fragoff, NULL);
> +	if (tproto < 0 || fragoff) {
>  		pr_debug("unable to find transport header in IPv6 packet, dropping\n");
>  		return NULL;
>  	}
> -- 
> 2.53.0
> 

