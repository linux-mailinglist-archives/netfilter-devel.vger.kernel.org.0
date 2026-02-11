Return-Path: <netfilter-devel+bounces-10727-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIH1A32zjGlLsQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10727-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 17:51:09 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63161126535
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 17:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E133300DD5E
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391662DB7AD;
	Wed, 11 Feb 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="mbzXSjqF"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4173D2D6E5C
	for <netfilter-devel@vger.kernel.org>; Wed, 11 Feb 2026 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828665; cv=none; b=JA7SzWibEzAg9TijC51/NFAUYH+scd9NUWHHesx6vJgKx0AWIu80Ln1YtgGVteGrzUHNd/4CGNvaa2Zey36/0vISXtWTnEiyG9QJ04/Gm9IxNDV9nO6s5Tt8Lk78nKNqnDnzdZ6ApUdXmDc0sAypfz2ato000oVGsaZrgyjOv/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828665; c=relaxed/simple;
	bh=IhUI4bXROJ7yTKZamIMYLnreJMHt0rKA27vTlfDSOJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ3Hb8F8zWwrYut/sMeXkWnn5nxxoAcRYxGWATfoTN7Qww9XQO9NtnyUHVsdAAZ/k43IFZIF29QcAIMBa58/DSWedzwAvHarRhi56YDT7W9jAcZOH6abpV71rdlBMMnZb0w7H4D8KUTZWxh9E/72cPZAEz94QefLoYTIKe6Zc8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=mbzXSjqF; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1smUeRuu95uDx8u9X+8WVuqdX2mAlpwMiaMofZ5KhiU=; b=mbzXSjqFNKh+0cH61uYM/4WjWP
	lAQOKJnIIjrQOPdTtJPZeOeAcZ4Br4vztoRmOXwVZ0haeLrDfeKRye0bUxvR7xrSXC9Q33m5aw+5B
	lPRbw+u97+j1ESrNF0urqEJM8PveC86sV8JrSL+LfAeaCh7K+3EwcpIzfv1Sh2cheLdXpOTKutdsO
	0vQmaRywD+FKElu85hk6eUg+AkXFNFDjHJ6HHB59bJJmG23jeNvjZ8nKHetIEKfOU03O5lRXTf5c8
	f21ICILbKlh3Gjc6NNKznrfmA0NgIT1J8bQ8Oqzi2Ju6/5/KzuogXxKeZoHI5e9WGOzBJuS12WDWR
	g6gtPEog==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vqDQU-000000004ob-1ZFc;
	Wed, 11 Feb 2026 17:50:54 +0100
Date: Wed, 11 Feb 2026 17:50:54 +0100
From: Phil Sutter <phil@nwl.cc>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2] configure: Implement --enable-profiling option
Message-ID: <aYyzbpzkDJ_WzVIp@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
References: <20260205151839.5321-1-phil@nwl.cc>
 <aYx-NR-4YctzvJBf@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYx-NR-4YctzvJBf@strlen.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10727-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nwl.cc:email]
X-Rspamd-Queue-Id: 63161126535
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 02:03:49PM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > This will set compiler flag --coverage so code coverage may be inspected
> > using gcov.
> > 
> > In order to successfully profile processes which are killed or
> > interrupted as well, add a signal handler for those cases which calls
> > exit(). This is relevant for test cases invoking nft monitor.
> >
> > index 022608627908a..5756f873f61a7 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -156,6 +156,13 @@ AC_ARG_ENABLE([distcheck],
> >  	      [enable_distcheck=yes], [])
> >  AM_CONDITIONAL([BUILD_DISTCHECK], [test "x$enable_distcheck" = "xyes"])
> >  
> > +AC_ARG_ENABLE([profiling],
> > +	      AS_HELP_STRING([--enable-profiling], [build for use of gcov/gprof]),
> > +	      [enable_profiling="$enableval"], [enable_profiling="no"])
> > +AM_CONDITIONAL([BUILD_PROFILING], [test "x$enable_profiling" = xyes])
> > +AM_COND_IF([BUILD_PROFILING],
> > +	   [AC_DEFINE([BUILD_PROFILING], [1], [Define for profiling])])
> > +
> >  AC_CONFIG_FILES([					\
> >  		Makefile				\
> >  		libnftables.pc				\
> 
> I think this should show up in:
> 
> nft configuration:
>   cli support:                  readline
>   enable debugging symbols:     yes
>   use mini-gmp:                 no
>   enable man page:              yes
>   libxtables support:           no
>   json output support:          yes
>   systemd unit:                 no

ACK, I'll prepare a v3.

Thanks, Phil

