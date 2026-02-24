Return-Path: <netfilter-devel+bounces-10848-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCgPMT/4nWlzSwQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10848-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 20:13:03 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2349318BB82
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 20:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D434C3014139
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 19:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9162F1FFC;
	Tue, 24 Feb 2026 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="DhCRIy1j"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D71A2C21F4
	for <netfilter-devel@vger.kernel.org>; Tue, 24 Feb 2026 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960301; cv=none; b=oAAz2V5Dw0uwKNZLWdzXjv5Q6KFWDDYamNrYzHofXvg31ecoFOb+rbLJWEKU3MyEeLv2EkDVlEujR9qK1GUOMRaxFguD0P0CeVX8/dLGNl6qAYX35/PnP58FaE16DSRNiPlkiv+op6tMg+vhtnvYnCIE7TUUH8FWO362jYGfBAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960301; c=relaxed/simple;
	bh=NB/8msfxu6XotgHoOdBdtK+wbTOec6kEnFIaO+k3hhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BErlSFXsAFF8vVvsmtypMd5zPD7YY2d2iyz0OliUVBVrA3mr4RYzGL26AXWr7q6fNDiG4zLBltHMsOOzgHcp3scl1m3zHtpC9dwRgRjKWN1valiTrJyZqtQFXPNYcKmK22AIMydWlcVTzeIo1VL7CzADjY3XIshxmbq5GfLpuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=DhCRIy1j; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 6DF06603BD;
	Tue, 24 Feb 2026 20:11:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1771960291;
	bh=+jdzRV2SNbRIco9Jou6U2JkhCeDAqH5roUSNaBP4PZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DhCRIy1jJaYNFTZJ5IVNANu9kSuCJ82AjvB289MVtTk1Fk7vrjy4+aGtrHOZDUk5D
	 lcU9gWOyqvlFAzTZGTcf5vxnatbur6ZRXn/Ao7Rqoykb6rR636As3M3c/5UsCczLcr
	 6k23tBZD3omO6W6dBXJHau3iA7xLfgCBSmZlzopogaT+5NdjEt2PSj8U0c94pc622V
	 GyAsaNsvDHW3GW0WGLdOFuf50CljU5y98l3OUOZ66x42Wyk3lfBsieJ/tQwrafW79F
	 cTZ4aipISITJdFmiQ4d6F5zwNp3Ws921Ixck45sOuLL3qocWtsbhqeCji8L5wOHsnu
	 HmHzz2S2xM63w==
Date: Tue, 24 Feb 2026 20:11:28 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_tables: inconditionally bump
 set->nelems before insertion
Message-ID: <aZ334G68nwX2GXNi@chamomile>
References: <20260224182247.2343607-1-pablo@netfilter.org>
 <aZ30HscJe0XroBtg@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZ30HscJe0XroBtg@strlen.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10848-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2349318BB82
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 07:55:26PM +0100, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > In case that the set is full, a new element gets published then removed
> > without waiting for the RCU grace period, while RCU reader can be
> > walking over it already.
> > 
> > To address this issue, add the element transaction even if set is full,
> > but toggle the set_full flag to report -ENFILE so the abort path safely
> > unwinds the set to its previous state.
> > 
> > As for element updates, decrement set->nelems to restore it.
> 
> While I think this patch is correct and fixes the bug, I would
> prefer the one-liner from Inseo An, it will be easier to backport it.
>
> I propose we do this:
> 
> I do a nf pull request now, with Inseos version.
> 
> Then, after that has been merged back into nf-next, rebase this patch
> on top of it and apply it.
> 
> Then, in 2nd step, also rework 71e99ee20fc3 ("netfilter: nf_tables: fix use-after-free in nf_tables_addchain()")
> to follow same pattern as in your patch, i.e. defer the release to the
> abort path instead.  This way we have easier to backport fixes while we
> establish this new pattern of adding to-be-aborted transaction objects to
> the list.
> 
> Makes sense to you?

My concern is that this slows down a scenario that is possible, ie.
adding an element to a full set.

... compared to 71e99ee20fc3, where it is almost *impossible* to reach
that synchronize_rcu() in a real use-case since you have to register
1024 basechains.

