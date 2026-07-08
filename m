Return-Path: <netfilter-devel+bounces-13756-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XrtOIfB0TmqJNAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13756-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 18:04:00 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64665728699
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 18:03:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BuL7Jx1L;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13756-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13756-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4751C3039616
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF1D34A78F;
	Wed,  8 Jul 2026 15:42:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C62EF64F;
	Wed,  8 Jul 2026 15:42:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525373; cv=none; b=o+RfKLDX1XHpFm/gNJy6NYGlNLzo8C1OeTk/fVCyKY+XdxtBtg0Bh7XKVK24+ScrM7jc7iwQBZ72QYjzw/xhXd11+qnWF7tv8bciNZZi/cxHBFEIy+Ai9V4dV5LkfWmJ+nmB/Sy4fVZUP4UnayGKGDPNKIROoZ9A2/netEahpGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525373; c=relaxed/simple;
	bh=n5q1N+F+EtpYBlqFVelOGH+V9eik0CiVbOF5G+JRUlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRX4niv+XfgWF2x5IDpOlwappKiyBRQYIgdudL/ktB85LlFWZl7FntNMQ4kypV3vPWk3pCDWWTTX59vtIHziaxf1OkLFFVHlZ1lYFMejMLHrN2qLQ7t+gkwEHWePdtq6RBUIoI0hvcdzJFLdDtlVaA2O3WMNR2/0VVa69li8sg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuL7Jx1L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD101F000E9;
	Wed,  8 Jul 2026 15:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783525372;
	bh=myM5TVBym+J7VoDATrItCwAsgA0Kf6ZymjUmGE93LlM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BuL7Jx1LxY/yiPjkgDR5OPXH+zWsx1gCpMmVvDa62XvKL3f/pa2LOUXUpzoCrRrM4
	 JfU1OapOnmLmQbIwJb56euDRGCCX0qi+Av9zT5xlOm0WAVYz46fMXkOaU5RU4dyigc
	 Ij8GZFAWl2LRefEMfBzPwq+XkdUWn20WAl9F80i5QKGIEZ7Neiph9yvXoR9HhpZfWl
	 7naZmxb/abWJQRFznl4PsCW5R+NwoA9UQn/yfZrzZDFdpSYHqp/YXd3qwESsg4VfHR
	 FkMTksjQNsarrGDTcgfwwtRpYgi+maKBGk6QcGxuQCF9blUyHwPcH6OqtlrlNxIwg2
	 YE60v2Ix4lAzQ==
Message-ID: <309e7b6b-c5a0-4404-97a9-72de45e507ff@kernel.org>
Date: Wed, 8 Jul 2026 09:42:51 -0600
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ipip: use tunnel parameters for
 fill_forward_path route lookup
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
References: <20260708-ipip-route-lookup-fill_forward_path-v1-1-b77df74822ed@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260708-ipip-route-lookup-fill_forward_path-v1-1-b77df74822ed@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13756-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64665728699

On 7/8/26 5:25 AM, Lorenzo Bianconi wrote:
> Pass source address, DSCP and output interface from the tunnel
> configuration to ip_route_output() in ipip_fill_forward_path(), aligning
> the route lookup with the slow path in ipip_tunnel_xmit().
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  net/ipv4/ipip.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
> index b643194f57d2..d1aa048a6099 100644
> --- a/net/ipv4/ipip.c
> +++ b/net/ipv4/ipip.c
> @@ -360,8 +360,9 @@ static int ipip_fill_forward_path(struct net_device_path_ctx *ctx,
>  	const struct iphdr *tiph = &tunnel->parms.iph;
>  	struct rtable *rt;
>  
> -	rt = ip_route_output(dev_net(ctx->dev), tiph->daddr, 0, 0, 0,
> -			     RT_SCOPE_UNIVERSE);
> +	rt = ip_route_output(dev_net(ctx->dev), tiph->daddr, tiph->saddr,
> +			     inet_dsfield_to_dscp(tiph->tos),
> +			     tunnel->parms.link, RT_SCOPE_UNIVERSE);
>  	if (IS_ERR(rt))
>  		return PTR_ERR(rt);
>  
> 
> ---
> base-commit: 155c68aef2397f8c5d72ef10acf48ae159bf1869
> change-id: 20260708-ipip-route-lookup-fill_forward_path-6a8a1f45084c
> 
> Best regards,

Reviewed-by: David Ahern <dsahern@kernel.org>


