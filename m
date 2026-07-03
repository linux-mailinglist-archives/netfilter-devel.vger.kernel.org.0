Return-Path: <netfilter-devel+bounces-13617-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IPvtBMWZR2rQbwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13617-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 13:15:17 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A5B701B4E
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 13:15:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=tk2iVxUb;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13617-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13617-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF9C030445A6
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Jul 2026 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6712833B951;
	Fri,  3 Jul 2026 11:07:55 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F496370AD7
	for <netfilter-devel@vger.kernel.org>; Fri,  3 Jul 2026 11:07:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076875; cv=none; b=CDmOwxju7L4u3jErx+duq8RuL8K5ZpyFYySunm4IP+v0iN3rZG0a1QwPNWc33rNxucNDX9u+LNQAKbuk/CppYrNlpkfiyBLh0xEFCzJT9N549C7Uf0e5cmGF5FO2XorExov8arfTRpQ6jo1dVtnxrxHguPX8b3XyBPqXzEADd1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076875; c=relaxed/simple;
	bh=3+dmOCwAwSq/L1HG5HjviSd25oGKbeJ9PGzY0up6CoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njrH6zIrWtVDURR2kGi60Opb4s5uNQFwAMzlNZWPb5Tu3UY+w3JIkHRBFyQysi2jTzIkiLC8FtAFseJKHdd5L9L4h58BkwZLGL3Ga2tmJRDkv4GFnIJtc08ZS22IwdCf/ch+d4xs4+xUCZc02JS2N8OSoZQuU/keuoGfHA63FvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=tk2iVxUb; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id C1D0260177;
	Fri,  3 Jul 2026 13:07:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783076870;
	bh=f0UpdHi2pNOrgdlmMgaMs2n7uzNbvlXerNbh92zldpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tk2iVxUbw/5B4up1KjNDK5kJ9PEMHhswBsZXbjeCACa0jsM7v/ESGKmj/W/Gp3gz1
	 K6WjYPN0+knOcB8iCDmwBPHy9Dyhzw29ibACexiAWVPJoAIeGawcOnEyDE5uHyAFIr
	 lYOF4e28ps6UEXERddn1ASNzsLqbA5+hZynZ1sIx3TNB4qwKVzR1jBrSrz8dvstzMX
	 g6mOcLopQI2UfQJ5mXM3nF9oNVfV+E+2kGzCzKxl0ihqKLzqjK9BumxQayNtWCWzi3
	 YupS080y7KL4G8mR2cbT2oBW80HQy0UTX8yDbz015AnWqVqniq18kj1J8la0elFigj
	 mAS4wGH2DTNvA==
Date: Fri, 3 Jul 2026 13:07:47 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Phil Sutter <phil@nwl.cc>
Cc: Florian Westphal <fw@strlen.de>, Ren Wei <enjou1224z@gmail.com>,
	netfilter-devel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	yuantan098@gmail.com, dstsmallbird@foxmail.com,
	chzhengyang2023@lzu.edu.cn
Subject: Re: [PATCH nf 1/1] netfilter: xt_time: reject pre-epoch calendar
 matching
Message-ID: <akeYAxWNWVhQz1wB@chamomile>
References: <cover.1782879547.git.chzhengyang2023@lzu.edu.cn>
 <779d223ad31c493cbfc3c483293e435dca89cf90.1782879547.git.chzhengyang2023@lzu.edu.cn>
 <akd6KZo1lwQ719d0@orbyte.nwl.cc>
 <akeKGXmzONKkGqOl@strlen.de>
 <akeLxWXP7Y-5I8BQ@orbyte.nwl.cc>
 <akeO-v0H9QP1psep@strlen.de>
 <akeXD_GwEFarWAuK@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akeXD_GwEFarWAuK@orbyte.nwl.cc>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-13617-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:phil@nwl.cc,m:fw@strlen.de,m:enjou1224z@gmail.com,m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:yuantan098@gmail.com,m:dstsmallbird@foxmail.com,m:chzhengyang2023@lzu.edu.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[strlen.de,gmail.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,foxmail.com,lzu.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nwl.cc:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,netfilter.org:from_mime,netfilter.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98A5B701B4E

On Fri, Jul 03, 2026 at 01:03:43PM +0200, Phil Sutter wrote:
> On Fri, Jul 03, 2026 at 12:29:14PM +0200, Florian Westphal wrote:
> > Phil Sutter <phil@nwl.cc> wrote:
> > > > This is silly.  I'm not sure this is even a bug.
> > > > We're in 2026 not 1970.  I really don't see why this patch is required.
> > > 
> > > I imagined a system with broken BIOS clock which boots at epoch until
> > > NTP has fixed it. Then stamp will be close to zero, no?
> > 
> > So what?  Rule won't match either way.  I wish we could get somehow
> > get rid of xt_time and nft_meta time matching, this was a very bad
> > idea from the start.
> 
> Sure, time-based packet matching won't work on a system with wrong time,
> but AIUI the patch is merely trying to prevent the unexpectedly large
> lshift. It seems harmless, though:
> - current_time.weekday can't exceed 7, it is assigned the result of a
>   modulo operation
> - current_time.monthday is type u8, so worst case the kernel will
>   compute '1U << 255'

Maybe it can be added as hardening for nf-next, just for correctness.
Remove Fixes: tag. I don't see this as a bug either.

