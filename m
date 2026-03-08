Return-Path: <netfilter-devel+bounces-11042-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIXxFthTrWn01QEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11042-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 08 Mar 2026 11:47:52 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EB222F5E0
	for <lists+netfilter-devel@lfdr.de>; Sun, 08 Mar 2026 11:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89A393012EB8
	for <lists+netfilter-devel@lfdr.de>; Sun,  8 Mar 2026 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A735333442;
	Sun,  8 Mar 2026 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="YaFHS8P3"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD72920C477
	for <netfilter-devel@vger.kernel.org>; Sun,  8 Mar 2026 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772966865; cv=none; b=ZVQWRsbiotL6OPLJGGvrHlUQiai6+7jnepksxUUdeya+pO2wKY/ZMYpPRATu/KfOJt7vVDWJ0ny59CcWZllH1o5JunR4OvTwMnYQKaE5GVYr3TYm1pTtTmZ1wxPPtwfIMsuwc9cyG5vavZtFJKVZtm437xBR71ne00jGlG7Y8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772966865; c=relaxed/simple;
	bh=kgsTaYLtskc3RjN4/4fFVCMTg6zh0mv1WVW84Zwmvdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNogSYrvD/ZwKsNKHsPN/+tE3Db45oOOHqmB1vwF0l0bVskmcIjdmlWP6sIXi6NQ1xDoYm0+hFtaRoNWYlm5SWsIkAUP92KeO0mKRohrayg5TzNNmhBR7ZDN/9r8zmh9QizwGPc7b58ppZq6IQIT4d07NxvKXYcuG4mXjOTrTY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=YaFHS8P3; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 68FDB6057B;
	Sun,  8 Mar 2026 11:47:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1772966863;
	bh=e5ht53GAAgqdkQvws78dRucLAUVG7cFlgCFjtlcOCLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YaFHS8P3DkjFob/pLwNWCEMKFS04r0ggx4Hh21eo8aDwnVuzRJu7UzT1jMHe9JXcu
	 N8xi1n7WogJvj+lM849V2dsBoIg4myWFIgF+mEnwi2r8IY2PInypsefzw8vPcQb7if
	 hx19VilbPSYBsJzCLDvlwIC0qzTPhBk5RNOS8h2VZ1ZhfXRs5tc1f95M7brD3J4tpt
	 FHTYX/ZtJL5NuEpgoTi82y8dcL1BNVxg2t7o0V9+tdgbJG+dGfhZ3dk7DPV6fwiFft
	 3vj2isQfHk2vV6+VgTzKhDgvu71YpLsxJ9up56kuZCRM3JuN6OMg7Y9TVsKNz38i/E
	 KWP8LiLxGM0PQ==
Date: Sun, 8 Mar 2026 11:47:41 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, carges@cloudflare.com
Subject: Re: [PATCH nf,v2] netfilter: nft_set_rbtree: allocate same array
 size on updates
Message-ID: <aa1TzYNasBJPzY1h@chamomile>
References: <20260307001124.2897063-1-pablo@netfilter.org>
 <aavqwA_H032EaiRg@strlen.de>
 <aawhRH5SLVzNTots@chamomile>
 <aawiz8SnS4HwV97z@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aawiz8SnS4HwV97z@strlen.de>
X-Rspamd-Queue-Id: D7EB222F5E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-11042-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.966];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,netfilter.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 02:06:23PM +0100, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > There is also set->ndeact that provides a hint on deactivated
> > elements.
> 
> Oh, right, I fogot about that.
> 
> So we even have an estimate of how many elements will disappear.
>
> > So yes, there are smarter things that can be done here, but as for
> > this patch, my initial approach in this fix series was intentionally
> > simple.
> 
> Sure, its better to use a simple patch for nf, rest can be expiremented
> with in nf-next, I did not want to hold up this patch and I intend to
> pick it up for nf.

I promise take a look into this in nf-next patch.

