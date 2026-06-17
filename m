Return-Path: <netfilter-devel+bounces-13297-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RNYrOgdWMmoqywUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13297-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2026 10:08:39 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 501C06976FA
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2026 10:08:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13297-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13297-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 286E130DB2F4
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2026 08:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36813CCA02;
	Wed, 17 Jun 2026 08:02:33 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2F23CB2D2
	for <netfilter-devel@vger.kernel.org>; Wed, 17 Jun 2026 08:02:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683353; cv=none; b=MEjGCPEB4+S2lf3IaZMc3N5cuwxCDa74kNC5CNoRIjkEQTARHYd/QfhJDY6eWMqdmnWM1fvsziicJJ63p6l+lMZ3lrTSylvUbvtoMJFf44mmMxDRoTFYR4oocPvzeoXYF4h3hsS2rQIZ5mCxKLVIbMdRyfI4kSkPRU94q2O3eHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683353; c=relaxed/simple;
	bh=5hibnmy70TK0tZft022sAHe6duAUfAXHBjvYKucqqxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqDNJNCoTRNBRICJt+CR/c4Ok3B916cs9CmL3bc+1ZWDP42h+khZovCZ90O2f0zu653XNzJBBDQRHqhLFAupO6AWeYVfE4VD0afS+TB7bZrAs+f5HBj8Q05y+ebs9NiiwJgC5pT3zxpF+LXhU433JTSVJfNaZ3nhLcJ4tD6a5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 95CDD602C8; Wed, 17 Jun 2026 10:02:26 +0200 (CEST)
Date: Wed, 17 Jun 2026 10:02:26 +0200
From: Florian Westphal <fw@strlen.de>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: netfilter-devel@vger.kernel.org, Seesee <cjc000013@gmail.com>
Subject: Re: [PATCH nf] netfilter: nft_set_pipapo: don't leak bad clone into
 future transaction
Message-ID: <ajJUklUUmvafRVi9@strlen.de>
References: <20260616191938.2875-1-fw@strlen.de>
 <20260617075123.7a62e22c@elisabeth>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617075123.7a62e22c@elisabeth>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13297-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sbrivio@redhat.com,m:netfilter-devel@vger.kernel.org,m:cjc000013@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 501C06976FA

Stefano Brivio <sbrivio@redhat.com> wrote:
> On Tue, 16 Jun 2026 21:19:34 +0200
> Florian Westphal <fw@strlen.de> wrote:
> 
> > On memory allocation failure the cloned nft_pipapo_match can enter a bad
> > state:
> >  - some fields can have their lookup tables resized while others did
> >    not
> >  - bits might have been toggled
> >  - scratch map can be undersized which also means m->bsize_max can be
> >    lower than what is required
> 
> If I understand it correctly, this is about pipapo_realloc_scratch()
> failing to allocate memory for per-CPU scratch maps but
> pipapo_maybe_clone() succeeding, right?

Yes.

> I don't see anything wrong with this approach, but I guess there might
> be a more obvious alternative, even though I didn't really think this
> through: undo what we did in nft_pipapo_insert() up to that point
> (perhaps calling nft_pipapo_delete() with a particular argument).

Yes, that is the laternative, return the cloned copy to a state where it
is identical to the state it had at function start.

> I can try to get to this in the next few days (I would have some ideas
> about testing, see below), but I suppose we want a fix quickly if that's
> really the case so I'm actually fine with this, with one nit, also
> reported below.

I don't mind, this can wait if you prefer to undo the state.

