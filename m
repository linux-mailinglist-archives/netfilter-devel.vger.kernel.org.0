Return-Path: <netfilter-devel+bounces-13753-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ciaMFZFzTmoaNAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13753-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 17:58:09 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7C772858F
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 17:58:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SelAoIa0;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13753-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13753-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D79DF30A6972
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 15:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9AA3F12CA;
	Wed,  8 Jul 2026 15:34:54 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC7439332;
	Wed,  8 Jul 2026 15:34:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524894; cv=none; b=cIQC/cTvNTCw8iP63OglzMXiRTd2XpKzWWQLvXW8V22naBypYBZB2UQ6OvEudQ7aRFl9XwPhGzzgjK4YUZLyYXGBvqPW6c6jGaeYo696tboEYPZOqD5/nL6dsfsjvNg7Lru+qUGtpcL1HiSx6KYJZStjsXWAjAcLTRhbxoDGuNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524894; c=relaxed/simple;
	bh=fiiDCkdeHEVyQp/NivSGEkljms8CGLjmX8nWxuSH/qU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oazj7a9fvVzBDlfA52EtzKlnEiqOxREeiXnZcXaexpaa4HNDS+9eVaENzSHf+HpK6DZdKXdNCToOY+/3n/S5c+1zblw198b4mfISBBtCV12a9lpk8hsMEygV3tBlSbpw+0o+v9BXzow8X2Dre62Vrtk9nWPBLxeL1tExnC9fKpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SelAoIa0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141AA1F000E9;
	Wed,  8 Jul 2026 15:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783524893;
	bh=cPJ3ox2J2V9tWzeIEmBv3cvTg3mnsIHbhfsUkgXj79I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SelAoIa002HqBRNDPBVDd2ZCTnP7aZm/LbNPS0Xu4sA7QuD+45wMLrjyGHkjIWYRg
	 yjeheRdeHpilZjAk4KOgRae3psIivqyfNeJR9Pu+KChEwElVN7t4D1VDpREaNiD9Ta
	 pBMAl+5DRq87sfkKj2ZbVwGfn6dnzZ+mEandbESTufoKd/+PCqHUNGHC08EcwWj+qQ
	 KmT9nbRO/xocXxCQjnJqnt1h0eBlyJR7eyUoSPoYBLMtKuNSxWN25/ylco8DpQS1sA
	 oyaNbTSHlLZ4vKLNSZechi2n1OW/Inzu2HI9mbrxGGW3hsH9INT7HYz0W87wHCAFwH
	 dECLtBGBOJIaA==
Message-ID: <9badfd3b-f9f7-49b8-9c34-980b17c22794@kernel.org>
Date: Wed, 8 Jul 2026 09:34:52 -0600
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13753-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF7C772858F

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

This and the ipv6 version seem correct to me. Please add test cases for
both.

