Return-Path: <netfilter-devel+bounces-11325-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNU/LLQzvWmI7QIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11325-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 12:47:00 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B76292D9CA2
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 12:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8CAD3008092
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D0D3009C7;
	Fri, 20 Mar 2026 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="bggIZ/nO"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A61A6800
	for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2026 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007214; cv=none; b=k9XTzKz0IVfRWqpswU/BeUyPP/RSwBGj9ZIk4yQ9Yg4RC9aDUJTX1zy/WSz4SOuy2+ZzzjOwjuBLVY2SUKbBSDzVMEwx/Zs7MkGYi8h7KLODy1+GhN8LfEn5oaiFRLaERjMZ+wNPFAGYRHvlBpMPG1MOosSR2FXEz9r7re6qB94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007214; c=relaxed/simple;
	bh=x7CAjI/ggsEfOdnWsbh25AQDFXcvbXBDgZm7AdTzht0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+jMDuK1HeCzz+P/S5HsYadPsQBPUCXew3LAGILhnRuptu+fjjd8tsBHWRaNVopB0kYgjUMz5/cor8l3Yku2a20r5Iw+G5qYT2fq16TVrtgquk0/YwkCA5IQ1lPjX1dEyEum4d7S5PS5bKHwdjiyX7GSODreN4W2UZcIIY4uV5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=bggIZ/nO; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 4FA4260181;
	Fri, 20 Mar 2026 12:46:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1774007209;
	bh=rA+QX3NxvZyXMTDgEGPJVWztoSEOuOXufKasry/j/DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bggIZ/nOnsbqkvJMVhg0WzoyX9gLDEly6GJUYTAcHWACKR4fAKbwtYHIZ0q33HN0p
	 WcMPlvwCWBNTNbQenAOQLQCueKRnK7LGzWjXz4xaemU4lH6Es7raD/COKO1j79xBF1
	 nFyAW1IlV/JfFimM7MtKCZLMTFgOQr67WlI98t31fJBnseul2nbEX+JEQpQpM1maKG
	 OiQ8ws2VzUBXaYzIa8f2mBtNvNciDPIbQRnJ1ks1Qvi3KEk0V6KPXP563OtpJGsOPw
	 7Z+XENv+lsFFaZyqpgw2Zv8iESjegI1MIZo0Y0J3HhtUycc4jBNHFYbFqjw+OAoi7T
	 vq+yrL0VrILWQ==
Date: Fri, 20 Mar 2026 12:46:46 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Phil Sutter <phil@nwl.cc>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH] netfilter: nfnetlink_hook: Dump nat type chains
Message-ID: <ab0zptb70prDy1fy@chamomile>
References: <20260313153220.19662-1-phil@nwl.cc>
 <abwegj2TijkaQVLz@strlen.de>
 <abwraHUuxizN4krg@orbyte.nwl.cc>
 <abwtAkSF8-SmH684@strlen.de>
 <abxlzn7lymOxWUFa@orbyte.nwl.cc>
 <abyTyJBv47f3v9gd@chamomile>
 <ab0enMtOAFiG0mSN@orbyte.nwl.cc>
 <ab0rbTfE7LWIk7f-@orbyte.nwl.cc>
 <ab0tB2o90FukwQxU@strlen.de>
 <ab0u4JS4Z7THrP6B@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab0u4JS4Z7THrP6B@orbyte.nwl.cc>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-11325-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B76292D9CA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:26:24PM +0100, Phil Sutter wrote:
> On Fri, Mar 20, 2026 at 12:18:31PM +0100, Florian Westphal wrote:
> > Phil Sutter <phil@nwl.cc> wrote:
> > > On Fri, Mar 20, 2026 at 11:17:00AM +0100, Phil Sutter wrote:
> > > [...]
> > > > A remark from a practical perspective: Florian's suggestion to dump the
> > > > nat-type chains in their order with the dispatcher's priority value is
> > > > super-easy to implement (just have to pass the priority value to
> > > > nfnl_hook_dump_one() via parameter) and does not require adjustments in
> > > > user space.
> > > 
> > > Famous last words. :(
> > 
> > diff --git a/src/mnl.c b/src/mnl.c
> > index 4893af8322ae..b9efd3cfd3ce 100644
> > --- a/src/mnl.c
> > +++ b/src/mnl.c
> > @@ -2520,7 +2520,7 @@ static void basehook_list_add_tail(struct basehook *b, struct list_head *head)
> >                         continue;
> >                 if (!basehook_eq(hook, b))
> >                         continue;
> > -               if (hook->prio < b->prio)
> > +               if (hook->prio <= b->prio)
> >                         continue;
> >  
> >                 list_add(&b->list, &hook->list);
> > 
> > ?
> 
> Sure, but <=nftables-1.1.6 will still get it wrong. Can we tolerate
> that?

I think this qualifies as a fix.

