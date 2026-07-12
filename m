Return-Path: <netfilter-devel+bounces-13863-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h36NL0FIU2omZgMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13863-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 09:54:41 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09633744196
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 09:54:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=vDFK3Kg8;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13863-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13863-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9962E300C5BF
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 07:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86079374E41;
	Sun, 12 Jul 2026 07:54:38 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E74C33A716
	for <netfilter-devel@vger.kernel.org>; Sun, 12 Jul 2026 07:54:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783842878; cv=none; b=dRjR1jeyR2wD3VBlqX5ahK0Asu4XtpdplBtAxaBJ862amHCTnUizIrAOKI+uwHk6/1ftXYdUxgjdqqg2Ub/XMixDqZ/fCJ+R3ECCAKxy6uOtFzbbe7VCMKBFtSgdTNymc2ZDQ0ypLrG3Tm6zzwUtkGBJ9cpwDaL3fVNz2nWL1NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783842878; c=relaxed/simple;
	bh=l6mZuQCYdM+r/1Z+5nNp5GeJfPrWrT/Psz2qd3ZX+i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgltJ0Yv1D3bvIoBQ8sPmc15TZtFDhNK03Q/10l5g7HMUzkcNDBtTdak07/978BEfLexMb2qDPskLRiH1ebRqxkIOwQo2ff4udUftRdCvNDSUkzABv8d7eDxSL5YLHsQLFUNIEbM8PUNHhGZhZAYyg14v8V8z2vIY6N33ouR/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vDFK3Kg8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11FE1F000E9;
	Sun, 12 Jul 2026 07:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783842875;
	bh=rtwRhKcWugeGWfVrEfzJe21k8ollWkghkI1bz4gJD3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vDFK3Kg8dycpSHPMHhVhuM5Gv0CsPwcMgTX70CCqeGFTzegMwouMDI1q55Y1jE/RB
	 WFkcJYVZC2R/1L3/ibTt41hErAluSDHo0MUFfzJ1FES9jAuPwuT/Fhhi8OiqDP6Dcj
	 37qII+aZrjF8ZdiRu7fQ2hfO585ASxpvFSdn7lmM=
Date: Sun, 12 Jul 2026 09:54:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Westphal <fw@strlen.de>
Cc: Jaeyeong Lee <iostreampy@proton.me>, netfilter-devel@vger.kernel.org,
	pablo@netfilter.org, phil@nwl.cc
Subject: Re: [PATCH nf] netfilter: nf_nat: do not reuse an unexpected
 expectation on RTCP clash
Message-ID: <2026071249-contented-gallantly-2927@gregkh>
References: <aQrSf6maL27cH2V4V9ELFdSqdtCWQ-B5iZr8fjR2Wz7zAJ7L32oW50bdrePoTMnJ4CRjDrns-jNMNFHGWNUxYe3UcV91AK99Ilncjab2uDk=@proton.me>
 <2026071134-turkey-detonator-0d87@gregkh>
 <178377968720.33756.12204817361601593230@proton.me>
 <alJva5_-K55ouKGh@strlen.de>
 <2026071235-geometric-snowdrift-bb4c@gregkh>
 <alNE4AO9H0HGLc34@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alNE4AO9H0HGLc34@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13863-lists,netfilter-devel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:iostreampy@proton.me,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:phil@nwl.cc,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09633744196

On Sun, Jul 12, 2026 at 09:40:16AM +0200, Florian Westphal wrote:
> Greg KH <gregkh@linuxfoundation.org> wrote:
> > > I think this function should WARN_ON_ONCE when one tries to reinsert a
> > > dead expectation (and return -EINVAL or another appropriate error).
> > > 
> > > (This is indenpendent of the real fix).
> > 
> > If you do that, then the machine will reboot, loosing everything.
> > Are you sure you want that to happen?
> 
> Of course not, i never set panic_on_warn.

You don't, but a few billion Linux installs do :)

> > Why not just properly handle the
> > issue if it possibly could happen?
> 
> This is no different than the WARNs on list corruption or refcount
> under/overflows.

True, but adding new ones is not a good idea, and removing the existing
ones is a good idea.

> Would you propose to remove those?  I hope not, they help catch bugs.

Bugs that userspace can trigger?  If so, then properly catch them by
testing and handling the issue.  If userspace can never trigger it, then
it's not really needed as the code is never going to trigger.

thanks,

greg k-h

