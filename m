Return-Path: <netfilter-devel+bounces-12030-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN89IVG65GlMYwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12030-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Apr 2026 13:19:45 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EAA423C82
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Apr 2026 13:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31756300B110
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Apr 2026 11:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900772EACF2;
	Sun, 19 Apr 2026 11:19:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE1282F23
	for <netfilter-devel@vger.kernel.org>; Sun, 19 Apr 2026 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776597582; cv=none; b=YKRuHxABIz9SBaLiGhbtopRn32tbgoP/Z8VZjmXoY8EKIIxufhH+oRXQLglTFoC5uaiFXTNa2pAEEgAJF/KwaDM3bPx/vs4FGDmdyFHz/567jcgd97yR1KLNL4hrP9LgufGGfipKYy+lASBUViHcccGvw4pc+DkxxXXHo5w/hkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776597582; c=relaxed/simple;
	bh=Zry8i5jSf1AdlXFh/eoB9JzPvcwj9J388W2PSzuaR5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4aTQf7QIL1cXvUTS5yU4r5wNBAA5OmyIyn8y19g0J0z8J9QTPeeKgYrv8i/+pkCOFhsWhfCD5pX7mP//X/PlKTVCUo7fnaNz7fFWxeH96N9bBTnZ7LHuL7iCXCGijQ/JXs6wQthTBCyO67OXYnPuHUIAGdc76FKsVXCTWpURl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id E827160681; Sun, 19 Apr 2026 13:19:38 +0200 (CEST)
Date: Sun, 19 Apr 2026 13:19:38 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: Re: [PATCH nf] netfilter: x_tables: add late validate callback for
 nft_compat sake
Message-ID: <aeS6ShOT2gAnijPo@strlen.de>
References: <20260419104509.42196-1-fw@strlen.de>
 <aeSzcx9YmM3usuez@chamomile>
 <aeS1iwP8ra-yU_Qu@strlen.de>
 <aeS3G7h1fX8uot3B@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeS3G7h1fX8uot3B@chamomile>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-12030-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C1EAA423C82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Sun, Apr 19, 2026 at 12:59:23PM +0200, Florian Westphal wrote:
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > On Sun, Apr 19, 2026 at 12:45:05PM +0200, Florian Westphal wrote:
> > > > x_tables and nftables are fundamentally different.
> > > > In x_tables, one gets the full ruleset graph via setsockopt().
> > > > ->checkentry() gets called at ruleset validation time.
> > > > 
> > > > In nf_tables, you get a transactional request (rule add in this case)
> > > > in netlink format.  At this time, it is not yet knowm from which
> > > > basechain(s) the new expression is reachable.
> > > >
> > > > In nf_tables, there is one final hook validation pass right before the
> > > > point-of-no-return when the new state is fully known.
> > > >
> > > > However, nft_compat calls the x_tables checkentry functions way too
> > > > early, at expression instantiation time, when we have the netlink
> > > > info available but not the base chain info (not yet known).
> > > 
> > > There used to be full validation of the table in each transaction in
> > > nf_tables.
> > > 
> > > What happened?
> > 
> > As far as I can see this never worked correctly.
> > 
> > A few matches/targets perform hook_mask checks in ->checkentry(), but
> > nft_compat calls ->checkentry() at expression init stage, which is too
> > early and only catches problems if the target/match is called from
> > basechain.
> 
> There is nft_{match,target}_validate() which check against
> {match,target}->hooks and select_ops sets ops->validate accordingly.

This problem is not related to target->hooks, which is 0 for xt_TCPMSS.

Have a look at tcpmss_tg6_check().  I don't think this ever worked
for nft_compat.

 367         ret = nft_chain_validate_hooks(ctx->chain,
 368                                        (1 << NF_INET_PRE_ROUTING) |
 369                                        (1 << NF_INET_LOCAL_IN) |
 370                                        (1 << NF_INET_FORWARD) |
 371                                        (1 << NF_INET_LOCAL_OUT) |
 372                                        (1 << NF_INET_POST_ROUTING));
 373         if (ret)
 374                 return ret;
 375

I don't see what this validates.  Can probable be axed?
(but unrelated).

 376         if (nft_is_base_chain(ctx->chain)) {
 377                 const struct nft_base_chain *basechain =
 378                                                 nft_base_chain(ctx->chain);
 379                 const struct nf_hook_ops *ops = &basechain->ops;
 380 
 381                 hook_mask = 1 << ops->hooknum;
 382                 if (target->hooks && !(hook_mask & target->hooks))
 383                         return -EINVAL;

target->hooks is 0, so nothing is validated.
xt_FOO that set .hooks to a nonzero value are handled correctly, even
before this patch.

