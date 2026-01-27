Return-Path: <netfilter-devel+bounces-10443-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDVKH2s+eWkmwAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10443-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 23:38:35 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E853D9B232
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 23:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A134830158B0
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 22:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569912D94AC;
	Tue, 27 Jan 2026 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="i1Ke59/O"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A39139579
	for <netfilter-devel@vger.kernel.org>; Tue, 27 Jan 2026 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553511; cv=none; b=tIPKrve5hb6r/R/gxwY8RHd+CJ0nEGZYKPdtsndInjq3mU6c8eHjK04Zuzy3eNvowhBCMukCDR6QpgjnFMlaXljFtK60t0Lkpa0OJwL1BfWeyEWlRIYKzCxMWk3XyzVgVuumxJN9QGNa2Vr6agMvEUBlVIpLswK16tO2/CfknXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553511; c=relaxed/simple;
	bh=jtPlfeMWiUsencaayZfNPQaUCs0DoK1MYVhyt5aagtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GO9ixSShfbUDQtHvKTpNjkwIlhzd7n61W8b3kEVYPR5XQnG/zhSFFNhjXlgNusWXhW/MLrG1GURnszl8WNoPitDx+QYcOR6RY4xKeo+Iw6+k6TQptyrPFubiWwBpqvh5wunZM2gZZdBCynWrIVh1vTkwVzocco2/7WgrAQSmkFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=i1Ke59/O; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=N6Nst88R8uM+fQwd5nPiZOFPNpDNPLJYw4X5WcQYTdo=; b=i1Ke59/OxqEgvj1aFJwwHzAM5q
	qu/WlCh4bFfgRVCV7YfTNJ9ym2MrIDo2OV3SR7yF8xvSzOLxP+YNm30etwc/drxlHmD3k908XehqT
	sBXdz3bDZtTt3Sb3dgmqOCMf3p/CrgGrgFEI3+NsdWEmaPYKS8H4cIN8XDeM4E/YJHNm948M3JOPY
	+yG5mkW0r5iyu8svodpt0ynnHnvf+2AIHdVvkW5lMUrVepWc9XpTS+Su6zoEVgtViirI5M6AwFOkB
	gj8df7ZLtt38RlzfKhIr5LQx9WjzudM81ULxF5IOf53eygb9XU54hlF4nc1dAnpWTEoSTAgj0GH9+
	2VtDEZqg==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vkrhc-000000002zE-0rgl;
	Tue, 27 Jan 2026 23:38:28 +0100
Date: Tue, 27 Jan 2026 23:38:28 +0100
From: Phil Sutter <phil@nwl.cc>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] doc: nft.8: Describe iface_type data type
Message-ID: <aXk-ZPRpYwj_KZ5e@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20260127221252.27440-1-phil@nwl.cc>
 <aXk5l4AQ4XHvyBrx@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXk5l4AQ4XHvyBrx@strlen.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10443-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nwl.cc:email,orbyte.nwl.cc:mid]
X-Rspamd-Queue-Id: E853D9B232
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:17:59PM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > An entry in data-types.txt offers space for a name-value table. Even if
> > one would refer to ARPHRD_*, some names are not derived from the
> > respective macro name and thus not intuitive.
> > 
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > ---
> >  doc/data-types.txt         | 27 +++++++++++++++++++++++++++
> >  doc/primary-expression.txt |  2 --
> >  2 files changed, 27 insertions(+), 2 deletions(-)
> > 
> > diff --git a/doc/data-types.txt b/doc/data-types.txt
> > index e44308b5322cb..0b350effbea68 100644
> > --- a/doc/data-types.txt
> > +++ b/doc/data-types.txt
> > @@ -83,6 +83,33 @@ filter input iifname eth0
> >  filter input iifname "(eth0)"
> >  ----------------------------
> >  
> > +INTERFACE TYPE TYPE
> > +~~~~~~~~~~~~~~~~~~~
> 
> TYPE TYPE?

Yes, sadly. ;)

We also have "ICMP TYPE TYPE" and "ICMPV6 TYPE TYPE" - the types
themselves are called "icmp_type", "icmpv6_type" and "iface_type". So
section titles formed like "<type> type" end up this way. It seems
wrong, but "INTERFACE TYPE" is misleading as the type is not called
"interface" but "interface type".

Maybe we should include the underscores in the title?

Cheers, Phil

