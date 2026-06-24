Return-Path: <netfilter-devel+bounces-13459-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 33WiLJVsPGqfnwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-13459-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jun 2026 01:47:33 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3476C1EA2
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jun 2026 01:47:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13459-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13459-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE38F301DCEB
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 23:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7F325495;
	Wed, 24 Jun 2026 23:47:31 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A222DC789
	for <netfilter-devel@vger.kernel.org>; Wed, 24 Jun 2026 23:47:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782344851; cv=none; b=BOvefTpy9i64L1kPdQ69oBfOAeUU21NIOa5imftSoB3CL9355JXNiWLs1hdTzHxbc+R5RQlhQFNHDKgBr+6HhliZgMtIdMAfSWh5IGmIgCwpkt4N6foDUcxTVkeirquYUmjq0uJ/GxXTrp3KGRSQN5TV+8hcsptiKgOkUMs45FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782344851; c=relaxed/simple;
	bh=Eg7w81MrscIE2wR7eJmlF6Dj9c8Uo1RO1HEegjZC5GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwqxLHfr0xvCqtcpRWKTdxS7TVVHDj6XjwbIwRVX12FolXtwmUIuwF33mcvaJ4tym2ac100lnpptHvjYbi/PXdoOPSvFl8M9+rlCOCqGykYT7oiDc5yMkCyRFU6kHaz8s8BBSsTaHYdqWU7hZBGIRl1mADq8f/HgUmmJAsVStjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 9789F602A9; Thu, 25 Jun 2026 01:47:26 +0200 (CEST)
Date: Thu, 25 Jun 2026 01:47:25 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Theodor Arsenij Larionov-Trichkine <theodorlarionov@gmail.com>,
	Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [BUG] netfilter: nft_fib: NULL-ptr-deref (GPF) in nft_fib6_eval
 on netdev egress hook
Message-ID: <ajxsjcDOnwllMfoR@strlen.de>
References: <CAEZyMPC0BQ=FO80mi3BVZaL4=T9y6=MYVL32St=Ck4w53hASqg@mail.gmail.com>
 <ajw7y1y7E8yyasOy@strlen.de>
 <ajxYxVLUjknoL2fg@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajxYxVLUjknoL2fg@chamomile>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:theodorlarionov@gmail.com,m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-13459-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,nwl.cc,vger.kernel.org,netfilter.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netfilter.org:email,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E3476C1EA2

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Wed, Jun 24, 2026 at 10:19:23PM +0200, Florian Westphal wrote:
> > Theodor Arsenij Larionov-Trichkine <theodorlarionov@gmail.com> wrote:
> > > A `fib' expression in a netdev `egress' base chain dereferences the input
> > > device nft_in(pkt), which is NULL on the transmit path, so any IPv6 packet
> > > leaving the chain's device hits a GPF / KASAN NULL-ptr-deref. An unprivileged
> > > user can set this up in a user+net namespace.
> > 
> > Please just send a patch to disable fib on egress.
> 
> I'd suggest nft_fib_netdev needs a nft_fib_netdev_validate().
> 
> And nft_fib_validate() need to be restricted to NFPROTO_IPV4, _IPV6
> and _INET from ctx->family PoV.

Makes sense. Theodor, would you make a patch?

