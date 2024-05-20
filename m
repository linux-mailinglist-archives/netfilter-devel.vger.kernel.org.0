Return-Path: <netfilter-devel+bounces-2254-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960588C9E3A
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2024 15:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDE8287E7C
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2024 13:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE555472A;
	Mon, 20 May 2024 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYqmsz2v"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FCB2AE7C
	for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2024 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716212018; cv=none; b=up8QcOF8QuwTT0ZRHcLr/nuFDBtrZjv+0HahOXDk4/cuMDwuojL+lI7nQDK5dSxuul8JDMA+GC30pj7cKkPG1s2xiIrhzxRfZCyL8KE2VIJX+djAE+HoIgvgh0H/wcO2qqb7IQygsLanX3lpYluLuWiwYdSk91kCOP5vLnU11VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716212018; c=relaxed/simple;
	bh=ueHtDwmwPNsj1xjF6ABPHdOTd0uUjPkSVgEf/i28dys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKPskwl5oAXkwe7n0VNl+oXnqcMnUkB2dSxRhTABn/wnpNmHSThUMcIDVoy1fTUEGFPDmaaAh7uflBvt+m5xCQuuJ9rzTWFt83OppLEknZCaA/gUWGVMBEeNKzjE8VyVkVPkFWorQKwmU0v8619XB+/1RiKFrN7em1a7TZFG15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garver.life; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYqmsz2v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garver.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716212015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IiGhjEoNiOSjha1Yg820JK18IMMfBHLNUo5i/NFFr5Y=;
	b=EYqmsz2vo2aI0OgMom7ZRht12zP3hf1t+alO3ytJixRNBS+q9GhLAWHDbVajwg0eSuTfNp
	JQ19At86IdpmuvqnN6aEoJFPMxdYW74AESGu+APd79VuxS07xnJR4bWuHHiBSODGDrvzeH
	Hv7v8C+qrijXsj53y4M1RXubR8obI+g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-2qNPH98bNh-5y9yg9r4AWw-1; Mon,
 20 May 2024 09:33:32 -0400
X-MC-Unique: 2qNPH98bNh-5y9yg9r4AWw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E3841C02145;
	Mon, 20 May 2024 13:33:31 +0000 (UTC)
Received: from localhost (unknown [10.22.9.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 13A3940004D;
	Mon, 20 May 2024 13:33:30 +0000 (UTC)
Date: Mon, 20 May 2024 09:33:29 -0400
From: Eric Garver <eric@garver.life>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net-next] netfilter: nft_fib: allow from forward/input
 without iif selector
Message-ID: <ZktRKa-PLwnyMXJ-@egarver-mac>
Mail-Followup-To: Eric Garver <eric@garver.life>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <20240517153807.90267-1-eric@garver.life>
 <ZksZo2vYHEmxMZZN@calendula>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZksZo2vYHEmxMZZN@calendula>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Mon, May 20, 2024 at 11:36:35AM +0200, Pablo Neira Ayuso wrote:
> BTW, one more comment below.
> 
> On Fri, May 17, 2024 at 11:38:06AM -0400, Eric Garver wrote:
> > This removes the restriction of needing iif selector in the
> > forward/input hooks for fib lookups when requested result is
> > oif/oifname.
> > 
> > Removing this restriction allows "loose" lookups from the forward hooks.
> > 
> > Signed-off-by: Eric Garver <eric@garver.life>
> > ---
> >  net/ipv4/netfilter/nft_fib_ipv4.c | 3 +--
> >  net/ipv6/netfilter/nft_fib_ipv6.c | 3 +--
> >  net/netfilter/nft_fib.c           | 8 +++-----
> >  3 files changed, 5 insertions(+), 9 deletions(-)
> > 
> > diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib_ipv4.c
> > index 9eee535c64dd..975a4a809058 100644
> > --- a/net/ipv4/netfilter/nft_fib_ipv4.c
> > +++ b/net/ipv4/netfilter/nft_fib_ipv4.c
> > @@ -116,8 +116,7 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
> >  		fl4.daddr = iph->daddr;
> >  		fl4.saddr = get_saddr(iph->saddr);
> >  	} else {
> > -		if (nft_hook(pkt) == NF_INET_FORWARD &&
> > -		    priv->flags & NFTA_FIB_F_IIF)
> > +		if (nft_hook(pkt) == NF_INET_FORWARD)
> >  			fl4.flowi4_iif = nft_out(pkt)->ifindex;
> 
> is it intentional to remove for the priv->flags & NFTA_FIB_F_IIF here?
> 
> Maybe only the last chunk below is required?
> 
> >  		fl4.daddr = iph->saddr;
> > diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
> > index 36dc14b34388..f95e39e235d3 100644
> > --- a/net/ipv6/netfilter/nft_fib_ipv6.c
> > +++ b/net/ipv6/netfilter/nft_fib_ipv6.c
> > @@ -30,8 +30,7 @@ static int nft_fib6_flowi_init(struct flowi6 *fl6, const struct nft_fib *priv,
> >  		fl6->daddr = iph->daddr;
> >  		fl6->saddr = iph->saddr;
> >  	} else {
> > -		if (nft_hook(pkt) == NF_INET_FORWARD &&
> > -		    priv->flags & NFTA_FIB_F_IIF)
> > +		if (nft_hook(pkt) == NF_INET_FORWARD)
> >  			fl6->flowi6_iif = nft_out(pkt)->ifindex;
> >  
> >  		fl6->daddr = iph->saddr;
> > diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
> > index 37cfe6dd712d..b58f62195ff3 100644
> > --- a/net/netfilter/nft_fib.c
> > +++ b/net/netfilter/nft_fib.c
> > @@ -35,11 +35,9 @@ int nft_fib_validate(const struct nft_ctx *ctx, const struct nft_expr *expr,
> >  	switch (priv->result) {
> >  	case NFT_FIB_RESULT_OIF:
> >  	case NFT_FIB_RESULT_OIFNAME:
> > -		hooks = (1 << NF_INET_PRE_ROUTING);
> > -		if (priv->flags & NFTA_FIB_F_IIF) {
> > -			hooks |= (1 << NF_INET_LOCAL_IN) |
> > -				 (1 << NF_INET_FORWARD);
> > -		}
> > +		hooks = (1 << NF_INET_PRE_ROUTING) |
> > +			(1 << NF_INET_LOCAL_IN) |
> > +			(1 << NF_INET_FORWARD);
> 
> I mean: This chunk alone to remove the hook restriction should be good?

ACK. I'll retest and post a v2.


