Return-Path: <netfilter-devel+bounces-13458-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pmmQN89YPGoQnAgAu9opvQ
	(envelope-from <netfilter-devel+bounces-13458-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jun 2026 00:23:11 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3239A6C1BBA
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jun 2026 00:23:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=BQLgSzPH;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13458-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13458-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F33833036EF5
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 22:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48603261B9B;
	Wed, 24 Jun 2026 22:23:09 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9DC286415
	for <netfilter-devel@vger.kernel.org>; Wed, 24 Jun 2026 22:23:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339789; cv=none; b=keCSyD5SaEWj3NSYCJnUCsD1F+VF8AcSsaAz678AxHMxM3Xo4Oa8RYxzreyCDy9Pi9BMs/EbX++1gaEL9eZo+8GW/YCGwtjVKS4vzzqP/wPG0vCYOGuh5tSgloSfNfPMLJvojgLVJcA8rOvvT6jrSD46DtivaWsxkiuwb8QCmGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339789; c=relaxed/simple;
	bh=VNKI7pdd8jLzyzKwkhtp1EcvPSOEDkU3Y3PBeHMsOH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKDdq5v7TCCyPXDiurd5respHFfTC1T99xcdHPs6qDUeMvGN+LS5+lBI/7bBGtod5ufkOYcyY4JSFAWBIixPoL1JJm94lUdehTawCmjo3alblXk1hdkpfPBWkLYxJq3EAZAu7kNOqeTL2Q+WVCPJDogwyBldQQqBF0RuQeseQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=BQLgSzPH; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id B2F8860586;
	Thu, 25 Jun 2026 00:23:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782339783;
	bh=oN2jZF1afD8kNxKGFobqb1u8vUit9Hc+sdOqOWTDpSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQLgSzPHdQKN6v3zQ1XkwL7KsnKjHVYD6UMGIKHt/zksAGgnLYtTcy2nCYi0TZRky
	 QLdZohZ0yIgd5QCZdxwk6/PDPbda54/TSaeJRuXWJfSnpVMrGnhzRKjnXD5vmNVArs
	 299k76w1VYfpDXZww1tRZTcqGdQ4fZqqhaKzRxaTkFT38H8R6nltsLLELEgJlESCec
	 v+qg3xjURx0sA8dtBJEJsdw77SEbBeusRklE/olemRTlJWQzbMVjaGp/kCHNzMeBYM
	 LrXQ9G0X0SKCnNfgBof7CnBHhNIw6DgZxDo0ZUJbEcOulQg+Ukbtf0thy6TpprJPiO
	 dQfsgcj0U8Ywg==
Date: Thu, 25 Jun 2026 00:23:01 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Theodor Arsenij Larionov-Trichkine <theodorlarionov@gmail.com>,
	Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [BUG] netfilter: nft_fib: NULL-ptr-deref (GPF) in nft_fib6_eval
 on netdev egress hook
Message-ID: <ajxYxVLUjknoL2fg@chamomile>
References: <CAEZyMPC0BQ=FO80mi3BVZaL4=T9y6=MYVL32St=Ck4w53hASqg@mail.gmail.com>
 <ajw7y1y7E8yyasOy@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajw7y1y7E8yyasOy@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:theodorlarionov@gmail.com,m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13458-lists,netfilter-devel=lfdr.de];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,nwl.cc,vger.kernel.org,netfilter.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3239A6C1BBA

On Wed, Jun 24, 2026 at 10:19:23PM +0200, Florian Westphal wrote:
> Theodor Arsenij Larionov-Trichkine <theodorlarionov@gmail.com> wrote:
> > A `fib' expression in a netdev `egress' base chain dereferences the input
> > device nft_in(pkt), which is NULL on the transmit path, so any IPv6 packet
> > leaving the chain's device hits a GPF / KASAN NULL-ptr-deref. An unprivileged
> > user can set this up in a user+net namespace.
> 
> Please just send a patch to disable fib on egress.

I'd suggest nft_fib_netdev needs a nft_fib_netdev_validate().

And nft_fib_validate() need to be restricted to NFPROTO_IPV4, _IPV6
and _INET from ctx->family PoV.

