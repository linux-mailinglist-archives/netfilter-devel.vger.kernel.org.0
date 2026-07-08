Return-Path: <netfilter-devel+bounces-13755-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LW8oH9d2TmocNQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13755-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 18:12:07 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCDC7287FE
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 18:12:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gn6rvqAL;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13755-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13755-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E7F6315497E
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1DB33E35B;
	Wed,  8 Jul 2026 15:42:48 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5CD21D00A;
	Wed,  8 Jul 2026 15:42:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525368; cv=none; b=d0QZbf2WNFsoutV0xups5Hg/Pv6IxHV7+ltNvAvg6+sOOC6MRBPc1L5upPjUWrGXIVffsblEUw97ExZjsGzi/rSWbWoDdivvzqRCif6KJIJfoGltx5OdWVLyoGCWTN+G5bInjc9nZHjxkudGbN95R+wIwWdkz1YFM7TVTl0BoBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525368; c=relaxed/simple;
	bh=3Rgz5aSdLjcn9P9NJ5ycATjcGC4fqPlnAnuRQ6mZ7lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImGuOkcZCIjloDfisArzKECcWlUd21Az1goOMPV2fvt83H5wnGW5hmpabFySqYcnaR9Y7GCc0bm5AmLMhIX6csMJ+uI7hrFUwQ6fZeBGGOeNA2s/FWmp3XdEl9YhMdNlLn4MziR8C64HLuFvGS1Keq9Fgnt6DmZ+DPmOPviIOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn6rvqAL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B081F000E9;
	Wed,  8 Jul 2026 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783525367;
	bh=z8G4ySDxrBxiw7vE5zCZNQMuZH1PKOgcqPuxK0wO9ho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gn6rvqALBpAAHyIFjjhkCZJJgwTDtO+5mSmMjp5t1xA8vxr64X++w7zdYpti6YHDw
	 i0SwL5wsReAjwxx5pFUu4cJh26y7dS5iNYLf/JarbugsXHrDhIuqr/TAMkQXF2gOwE
	 0g4Qmi0SIdmbTmTXbuyHWoVWleP7JARWwi5mhHsa8dLQtwUeKnns9kllpOrxZ9uF24
	 ryP9fPyRMdJ+tkHpLCPMmZyX88JdkzB1WLm9rpm3aCmQRB0w/x9jSzPU5Rwr9THPYd
	 l8isRZ89brdHuXySb3udACcYtlqjEbHFbXp6W3Q2GBgmulX41eYvXugjzaPVH57Jtd
	 Brgwd2e8YBniQ==
Message-ID: <7ced7e02-ab6e-4ba9-bb7c-ab158895780e@kernel.org>
Date: Wed, 8 Jul 2026 09:42:46 -0600
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ip6_tunnel: use tunnel parameters for
 fill_forward_path route lookup
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
References: <20260708-ip6ip6-route-lookup-fill_forward_path-v1-1-863b9647102e@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260708-ip6ip6-route-lookup-fill_forward_path-v1-1-863b9647102e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13755-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CCDC7287FE

On 7/8/26 6:48 AM, Lorenzo Bianconi wrote:
> Pass source address, output interface and flowlabel (carrying TClass
> and flow label) from the tunnel configuration to the flowi6 struct in
> ip6_tnl_fill_forward_path(), aligning the route lookup with the slow
> path in ipxip6_tnl_xmit().
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  net/ipv6/ip6_tunnel.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index bf8e40af60b0..557d8637ac57 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -1847,6 +1847,10 @@ static int ip6_tnl_fill_forward_path(struct net_device_path_ctx *ctx,
>  	struct ip6_tnl *t = netdev_priv(ctx->dev);
>  	struct flowi6 fl6 = {
>  		.daddr = t->parms.raddr,
> +		.saddr = t->parms.laddr,
> +		.flowi6_oif = t->parms.link,
> +		.flowlabel = t->parms.flowinfo &
> +			     (IPV6_TCLASS_MASK | IPV6_FLOWLABEL_MASK),
>  	};
>  	struct dst_entry *dst;
>  	int err;
> 
> ---
> base-commit: 08030ddb87b4c6c6a2c03c82731b5e188f02f5b9
> change-id: 20260708-ip6ip6-route-lookup-fill_forward_path-9fc45a9118e9
> 
> Best regards,

Reviewed-by: David Ahern <dsahern@kernel.org>


