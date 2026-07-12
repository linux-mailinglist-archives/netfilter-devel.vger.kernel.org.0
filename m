Return-Path: <netfilter-devel+bounces-13866-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nXIpFxlTU2pPZwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13866-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 10:40:57 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9903A7442C8
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 10:40:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13866-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13866-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69ADC300F124
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 08:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3B8381EB9;
	Sun, 12 Jul 2026 08:40:54 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E723806C4
	for <netfilter-devel@vger.kernel.org>; Sun, 12 Jul 2026 08:40:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783845654; cv=none; b=XsfRcauzRF0rXWYc/d8F1i2p4pHEOLyB6B04Mb3sQW00a15YuRMOTEsVEO+NIVSJfZ9yXrR56JyVXcPnROTbFAkWoi5TOElT8QG2TyD8wzqIRU8sS0oirz/pst1EA85D26Sxzk8ioba0Y+DZSk0nT513ObtPx4ocJTST5ZbYOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783845654; c=relaxed/simple;
	bh=Z31Ftg0Pmc/qZmgzofFaoCkIVc+T6kMM3xqLcclhg4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4EfqrlgZEveb594o2VFNLdl5Z5AFHqwVTJxIEY+AmbMZAqlqvRavTgJIrlz79liR90+oqGDhXUM8EYN9FmA0nIfXGQNO0eImDm37QNPIuaRlGrdTLqdrdsqgWAMJPej3SvF/FcYcgtp86ZMvmoKi4wf1UXVz8gI/8bMmOzHmsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C0B5560225; Sun, 12 Jul 2026 10:40:47 +0200 (CEST)
Date: Sun, 12 Jul 2026 10:40:47 +0200
From: Florian Westphal <fw@strlen.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netfilter-devel@vger.kernel.org
Subject: panic_on_warn and lack of lesser-WARN  (was: Re: [PATCH nf]
 netfilter: nf_nat: do not reuse an unexpected expectation on RTCP clash)
Message-ID: <alNTD-kTq6svigxI@strlen.de>
References: <aQrSf6maL27cH2V4V9ELFdSqdtCWQ-B5iZr8fjR2Wz7zAJ7L32oW50bdrePoTMnJ4CRjDrns-jNMNFHGWNUxYe3UcV91AK99Ilncjab2uDk=@proton.me>
 <2026071134-turkey-detonator-0d87@gregkh>
 <178377968720.33756.12204817361601593230@proton.me>
 <alJva5_-K55ouKGh@strlen.de>
 <2026071235-geometric-snowdrift-bb4c@gregkh>
 <alNE4AO9H0HGLc34@strlen.de>
 <2026071249-contented-gallantly-2927@gregkh>
 <alNLcE1qJ5fwBO0N@strlen.de>
 <2026071210-grid-runaround-4318@gregkh>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026071210-grid-runaround-4318@gregkh>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13866-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9903A7442C8

Greg KH <gregkh@linuxfoundation.org> wrote:
> > > True, but adding new ones is not a good idea, and removing the existing
> > > ones is a good idea.
> > 
> > We're fucked, then.  Can we at least use DEBUG_NET_WARN or something
> > like that so at least fizzers can give us hints about bugs?!
> 
> That's up to you.  If panic_on_warn wasn't an option, about half of the
> kernel CVEs would disappear tomorrow.

That explains your WARN() allergy, I can relate to that.

Its a shame there is nothing like WARN_BENIGN() or similar that doesn't
panic even with panic_on_warn=1.

I get some people really want s/WARN/BUG at run time for things
like "this list is corrupted" or "you tried refcount_inc() on a 0
refcount".  But even for "this refcount is saturated" I don't get
why you want to crash the system right away.

Feels a bit like setting your car on fire because the side window was
slightly dirty :-)

