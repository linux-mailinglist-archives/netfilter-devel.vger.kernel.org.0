Return-Path: <netfilter-devel+bounces-12089-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FqzMoWQ5mlWyQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12089-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 22:45:57 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0EA433CB9
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 22:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDE35301D979
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Apr 2026 20:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637533876CF;
	Mon, 20 Apr 2026 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="XBfxHrvV"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A872BE05F
	for <netfilter-devel@vger.kernel.org>; Mon, 20 Apr 2026 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776717945; cv=none; b=QZQknYGVFMS99d7l1BhFWqWdx6+DKqOfZcLEEnXZo/vbyKKdLw2rag7BaTlRSbWcl8u/nZQjHa6o83TJQjsBoVk4WbStcOQ+X4rbmAUKLXeFt3l+VLk5Hs+mQR1jnFtj3u3rucnx9T7+Q/37/EWX8zkzlaOmgC3J9e3pFffMZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776717945; c=relaxed/simple;
	bh=XeMXk7xZwpuFSjfvqdbGGUf+kjIDDUvn3EBK1rTg5xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWcEUCL8/ECM/CudJIlHeVDNbxehyywzcg1unaJ4dwcj/HOb4YY8h+4ImA9xdRmYlgHnWm0e2vOduZknazKoi93KNNndDoP4uiNmS3R4taQ1hIguw7jdycESt+UMQ+ltsozSRAcRHjEcVDGFNcmvrz739p7NJEZ5Z2dWCT5h5eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=XBfxHrvV; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id B60816017E;
	Mon, 20 Apr 2026 22:45:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776717940;
	bh=HHHynewhlJ13L/2gc3sq4KfyAUmPJibOpDYAi0VLqII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBfxHrvVRaOC9yL+QGCnM2EskedTpo55Ma9hJuQSI1TrAe0mbiOSQrEjS7+liiZuW
	 QDyX2cDuj7HIc5gToo4Vssn+vwCffPCFEFnw0QmURHR/ym43N6DCPJ1zeMgwyDyNJh
	 toUovBNttJxvSA8NnnczZquhbRCtEUvt064fvOHcuHMvlnR2ACI75wEMExESSXvWZa
	 X0M0aG3iZqf+5DAmx3xWb9hXbngqv3U/pcrdS6qsI+DdprkgA2MO925sg1r7PDvM4n
	 e+2JZTY6Z9LYEBS4dQEp73BAm0JFUUjA0DpMEXWQJqFSDfeMulfcV2ByUvytyKG9L7
	 TGnYUdFNLSdhA==
Date: Mon, 20 Apr 2026 22:45:38 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	ecklm94@gmail.com, phil@nwl.cc, fw@strlen.de
Subject: Re: [PATCH 2/2 nf v2] netfilter: xtables: fix L4 header parsing for
 non-first fragments
Message-ID: <aeaQcrEMN-IYE7xI@chamomile>
References: <20260420104745.10338-1-fmancera@suse.de>
 <20260420104745.10338-2-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420104745.10338-2-fmancera@suse.de>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-12089-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com,nwl.cc,strlen.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 3D0EA433CB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Fernando,

On Mon, Apr 20, 2026 at 12:47:45PM +0200, Fernando Fernandez Mancera wrote:
> diff --git a/net/netfilter/xt_socket.c b/net/netfilter/xt_socket.c
> index 76e01f292aaf..d366e294f1aa 100644
> --- a/net/netfilter/xt_socket.c
> +++ b/net/netfilter/xt_socket.c
> @@ -55,8 +55,11 @@ socket_match(const struct sk_buff *skb, struct xt_action_param *par,
>  	if (sk && !net_eq(xt_net(par), sock_net(sk)))
>  		sk = NULL;
>  
> -	if (!sk)
> +	if (!sk) {
> +		if (par->fragoff)
> +			return false;
>  		sk = nf_sk_lookup_slow_v4(xt_net(par), skb, xt_in(par));
> +	}
>  
>  	if (sk) {
>  		bool wildcard;
> @@ -116,8 +119,11 @@ socket_mt6_v1_v2_v3(const struct sk_buff *skb, struct xt_action_param *par)
>  	if (sk && !net_eq(xt_net(par), sock_net(sk)))
>  		sk = NULL;
>  
> -	if (!sk)
> +	if (!sk) {
> +		if (par->fragoff)
> +			return false;

Your patch will work as intented in iptables over nf_tables, because
it always sets on fragoff regardless user policy.

But, if ipv6_find_hdr() finds no layer 4 protocol, then fragoff
remains zero, and pkt->flags does not set on NFT_PKTINFO_L4PROTO.
There, in nftables, par->fragoff but itself is not reliable because
maybe the layer 4 was not found.

Then, there is ip6_tables legacy which does not behave like ip_tables
for fragments.

ip6t_do_table() only sets fragoff if IP6T_F_PROTO (-p in userspace) is
used, unlike nftables which always sets on fragoff.

So par->fragoff is unreliable in ip6_tables legacy, and
ipv6_find_hdr() is called over and over again ip6_packet_match() loop
for each rule.

One way would be to call ipv6_find_hdr() inconditionally from
ip6_tables legacy, but that belongs to a different patch and that
would be touch core ip6_tables legacy.

Rewinding a bit, coming to back to the original issue: osf only
supports ipv4 :-)

>  		sk = nf_sk_lookup_slow_v6(xt_net(par), skb, xt_in(par));
> +	}
>  
>  	if (sk) {
>  		bool wildcard;
> diff --git a/net/netfilter/xt_tcpmss.c b/net/netfilter/xt_tcpmss.c
> index 0d32d4841cb3..69844cc8dbb8 100644
> --- a/net/netfilter/xt_tcpmss.c
> +++ b/net/netfilter/xt_tcpmss.c
> @@ -32,6 +32,9 @@ tcpmss_mt(const struct sk_buff *skb, struct xt_action_param *par)
>  	u8 _opt[15 * 4 - sizeof(_tcph)];
>  	unsigned int i, optlen;
>  
> +	if (par->fragoff)
> +		return false;
> +
>  	/* If we don't have the whole header, drop packet. */
>  	th = skb_header_pointer(skb, par->thoff, sizeof(_tcph), &_tcph);
>  	if (th == NULL)
> -- 
> 2.53.0
> 

