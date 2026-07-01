Return-Path: <netfilter-devel+bounces-13572-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9pzwGk4SRWrU6QoAu9opvQ
	(envelope-from <netfilter-devel+bounces-13572-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 15:12:46 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDD76EDE6A
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 15:12:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ssi.bg header.s=ssi header.b=BFriuHLn;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13572-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13572-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=ssi.bg;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCD8B30055B0
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jul 2026 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D4D4A2E07;
	Wed,  1 Jul 2026 12:58:33 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E92495527;
	Wed,  1 Jul 2026 12:58:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910713; cv=none; b=lfD61Waoyk21lTdpj8vM8EEUQ5LADbTcFv9RfRBHqkZ6v64JputuXhhu4Xsis8ZE/kfjaZxCdQMTPherPfEySij/iOhiizi5UBU7r9CgEhJzOzzJUfciTUUFEXgNZmpTEhRq2nP/Q5Ls0NL2+d2WA2Zg8mG5yS4Fc/5JSs594ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910713; c=relaxed/simple;
	bh=MNnNF6aqKKWPoGFSYiIOGC6pM3ndilJbEB5mQda/JZs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CkvvQ/Jmft70DQ9DlrECP9UgnunYhH8fAn0uunLMvopl7WlsMIme7WwdwPrLsKiuafMlVm+8priRuyfycjUiXDEnPpr8GZIPnWh9/byaFq8jDyepkBqqJOj1/0LeHAzjiSSwWSdSzmMw/Ais2Mqj7P8U1ukYwQFwOpYwZ3Aa5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=BFriuHLn; arc=none smtp.client-ip=193.238.174.39
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id A484E229E5;
	Wed, 01 Jul 2026 15:58:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=FbsxZDGlGm1ZDRal0BJRWSKMr6tW8cq7eQhkh5ZB/bg=; b=BFriuHLng6oy
	qKXUSdOnPdpHPo2L31yeS6RBfGxcc9VRXnReZ7qxGvgLF6/uhydUnNrYgsOr7mCV
	ehrp98XrrimPPDvRYahzKE7jjIal+4edNl3SMDmLSrA8SUON0PDJm/VVVeg3KiX8
	8TRxkX9B/IEDV/W9rBU1E6aab8fFmJP3oQN4e6VQ8hwKMBxjpl0mh8WP2v1DD/C+
	FINxoxS7M9J/fSNNmLOpF4uf0FKJ576Jdk9FmolvkD3vwxFEFV10CncZLcx2CUON
	pL0zk9cVp/IosG7afeHCLDP0aXSt2A/aqgd+Vo8sJ67MtQ27+4r2htxkGTGi7j70
	ungiNsZptnAto9n2sm4N1NR4v9+muzaXlicoY9I2rsuLL0d9MpKZZKKK30uDx7Yy
	4O6ltRbKUPN6j32nZk4GlLR7J5rpqWPOKG58U3WAew/de4AErY5EIvrzApFejpja
	Tkq/3D4QdnlESoNC/ZRF+T+DoDQOM4xxT0Q65iGtpJOlRQpP7ZDgr5cuuEwq86N7
	84G81l8jlvIj0nt+iVpYb9Rl2gnk7bXLD7ZHUQLliZs0qJ/lBhMlZHwx7BWRAuD6
	aaMDFo1511h2rAVj5YX4BqV1EgBnPAYbVME44R1jRnnc+IvGQD47XAxmAmfXvS/X
	gUzQumO7NlsqjU3ic1difK+U7rximZc=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Wed, 01 Jul 2026 15:58:23 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 0FCC460672;
	Wed,  1 Jul 2026 15:58:18 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.2/8.18.2) with ESMTP id 661Cw6mQ044569;
	Wed, 1 Jul 2026 15:58:07 +0300
Date: Wed, 1 Jul 2026 15:58:06 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
cc: netdev@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
        Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
        Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH net] ipvs: fix PMTU for GUE/GRE tunnel ICMP errors
In-Reply-To: <20260701065941.46249-1-zhaoyz24@mails.tsinghua.edu.cn>
Message-ID: <b9ebd0cb-9aea-7b57-5ae4-bf379860171f@ssi.bg>
References: <20260701065941.46249-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ssi.bg,reject];
	R_DKIM_ALLOW(-0.20)[ssi.bg:s=ssi];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13572-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,verge.net.au,netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,seu.edu.cn:email];
	FORGED_SENDER(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:horms@verge.net.au,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lvs-devel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ssi.bg:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BEDD76EDE6A


	Hello,

On Wed, 1 Jul 2026, Yizhou Zhao wrote:

> When an ICMP Fragmentation Needed error is received for a tunneled IPVS
> connection, ip_vs_in_icmp() recomputes the MTU that the original packet
> can use by subtracting the tunnel overhead from the reported next-hop
> MTU.
> 
> The current code always subtracts sizeof(struct iphdr), which is only
> the IPIP overhead. For GUE and GRE tunnels, ipvs_udp_decap() and
> ipvs_gre_decap() already compute the additional tunnel header length,
> but that value is scoped to the decapsulation block and is lost before
> the ICMP_FRAG_NEEDED handling. As a result, the ICMP error sent back to
> the client advertises an MTU that is too large, so PMTUD can fail to
> converge for GUE/GRE-tunneled real servers.
> 
> With a reported next-hop MTU of 1400, a GUE tunnel currently returns
> 1380 to the client. The correct value is 1368:
> 
>   1400 - sizeof(struct iphdr) - sizeof(struct udphdr) -
>   sizeof(struct guehdr)
> 
> Hoist the tunnel header length into the main ip_vs_in_icmp() scope and
> subtract sizeof(struct iphdr) + ulen in the Fragmentation Needed path.
> The IPIP path keeps ulen as 0, so its existing 1400 - 20 = 1380 result
> is unchanged.
> 
> Fixes: 508f744c0de3 ("ipvs: strip udp tunnel headers from icmp errors")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: Claude Code:GLM-5.2
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> ---
>  net/netfilter/ipvs/ip_vs_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
> index d40b404c1bf62..74c5bd8b5f48 100644
> --- a/net/netfilter/ipvs/ip_vs_core.c
> +++ b/net/netfilter/ipvs/ip_vs_core.c
> @@ -1765,8 +1765,9 @@ ip_vs_in_icmp(struct netns_ipvs *ipvs, struct sk_buff *skb, int *related,
>  	struct ip_vs_proto_data *pd;
>  	unsigned int offset, offset2, ihl, verdict;
>  	bool tunnel, new_cp = false;
>  	union nf_inet_addr *raddr;
>  	char *outer_proto = "IPIP";
> +	int ulen = 0;
>  
>  	*related = 1;
>  

	The change look correct but there is something to fix:

1. first hunk is bad, does not apply to the nf tree (-8+9 vs -6+7
lines):

# patch -p1 --dry-run < /tmp/file.patch
checking file net/netfilter/ipvs/ip_vs_core.c
Hunk #1 succeeded at 1765 with fuzz 2.

2. the first two words in Assisted-by line should not contain
white spaces:

# scripts/checkpatch.pl --strict /tmp/file.patch

WARNING: Assisted-by expects 'AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]' format
#40: Assisted-by: Claude Code:GLM-5.2

	Please send v2 after solving the above problems. Thanks!

> @@ -1831,7 +1832,6 @@ ip_vs_in_icmp(struct netns_ipvs *ipvs, struct sk_buff *skb, int *related,
>  		   /* Error for our tunnel must arrive at LOCAL_IN */
>  		   (skb_rtable(skb)->rt_flags & RTCF_LOCAL)) {
>  		__u8 iproto;
> -		int ulen;
>  
>  		/* Non-first fragment has no UDP/GRE header */
>  		if (unlikely(cih->frag_off & htons(IP_OFFSET)))
> @@ -1936,8 +1936,8 @@ ip_vs_in_icmp(struct netns_ipvs *ipvs, struct sk_buff *skb, int *related,
>  				if (dest_dst)
>  					mtu = dst_mtu(dest_dst->dst_cache);
>  			}
> -			if (mtu > 68 + sizeof(struct iphdr))
> -				mtu -= sizeof(struct iphdr);
> +			if (mtu > 68 + sizeof(struct iphdr) + ulen)
> +				mtu -= sizeof(struct iphdr) + ulen;
>  			info = htonl(mtu);
>  		}
>  		/* Strip outer IP, ICMP and IPIP/UDP/GRE, go to IP header of

Regards

--
Julian Anastasov <ja@ssi.bg>


