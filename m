Return-Path: <netfilter-devel+bounces-12028-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FEkxG5S15GlbYgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12028-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Apr 2026 12:59:32 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B4423BFE
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Apr 2026 12:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5BA0300E277
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Apr 2026 10:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA221F4C8E;
	Sun, 19 Apr 2026 10:59:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF53328FC
	for <netfilter-devel@vger.kernel.org>; Sun, 19 Apr 2026 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776596369; cv=none; b=KN87ieCSrIsFBiICzkOWIZDFgDZXBVUf85uNnY4ccNeA6bynHVJmT7XVmgQDaHsuPuppxASVQP/v5fbSwBd0vVzEMLVdFu9+Ur28eTWUy6LNluDshGYXG+KChRUHLyazbcaSfQh8i4hXbI8qQmp3nvX+YsvOiD0oEKsxML+Hu64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776596369; c=relaxed/simple;
	bh=kjmg2X8k5T1v8Sp19mlf+ywjZVd3bL4CPMVOi0Ad9xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CY4ciqVaND/jqG3K9HKIdYfnQ4al2XpuD+UxjAUo+yQ8CoQc2NnnUAgbt2uEeeHy9BFDs5fG4pqBYshxOSAidMoI0lrIsuCjQeyGXgYrNtmo1rAZEiJBhRUHHkZZCi1qI67NkFOCf9xM/rrxlhB6mP611rb2ucgNm6Gy4ZG9jco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CB6B660681; Sun, 19 Apr 2026 12:59:23 +0200 (CEST)
Date: Sun, 19 Apr 2026 12:59:23 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: Re: [PATCH nf] netfilter: x_tables: add late validate callback for
 nft_compat sake
Message-ID: <aeS1iwP8ra-yU_Qu@strlen.de>
References: <20260419104509.42196-1-fw@strlen.de>
 <aeSzcx9YmM3usuez@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeSzcx9YmM3usuez@chamomile>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-12028-lists,netfilter-devel=lfdr.de];
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
X-Rspamd-Queue-Id: 881B4423BFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Sun, Apr 19, 2026 at 12:45:05PM +0200, Florian Westphal wrote:
> > x_tables and nftables are fundamentally different.
> > In x_tables, one gets the full ruleset graph via setsockopt().
> > ->checkentry() gets called at ruleset validation time.
> > 
> > In nf_tables, you get a transactional request (rule add in this case)
> > in netlink format.  At this time, it is not yet knowm from which
> > basechain(s) the new expression is reachable.
> >
> > In nf_tables, there is one final hook validation pass right before the
> > point-of-no-return when the new state is fully known.
> >
> > However, nft_compat calls the x_tables checkentry functions way too
> > early, at expression instantiation time, when we have the netlink
> > info available but not the base chain info (not yet known).
> 
> There used to be full validation of the table in each transaction in
> nf_tables.
> 
> What happened?

As far as I can see this never worked correctly.

A few matches/targets perform hook_mask checks in ->checkentry(), but
nft_compat calls ->checkentry() at expression init stage, which is too
early and only catches problems if the target/match is called from
basechain.

iptables-nft -t raw -A PREROUTING -p tcp -j TCPMSS --clamp-mss-to-pmtu
-> rejected at expression init time from ->checkentry()

iptables-nft -t raw -N FOO
iptables-nft -t raw -A FOO -p tcp -j TCPMSS --clamp-mss-to-pmtu
-> works, non-basechain
iptables-nft -t raw -A PREROUTING -j FOO
-> works before this patch: ->checkentry not called again
(and we can't call it twice either as these functions are allowed
 to have side effects such as proc file creation, kmalloc etc).

I don't see another practicable solution for this problem except
this hack.

