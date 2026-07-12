Return-Path: <netfilter-devel+bounces-13865-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gkDqHVhOU2rWZgMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13865-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 10:20:40 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC5074425A
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 10:20:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=kMGJpbW+;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13865-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13865-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D498B300D6B8
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 08:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E64371860;
	Sun, 12 Jul 2026 08:20:38 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9A830568B
	for <netfilter-devel@vger.kernel.org>; Sun, 12 Jul 2026 08:20:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783844438; cv=none; b=SYrFwRpO4MoyTkJD1UhwtAwMAmBeyRytRzE/kh632BEsYhAkPibh3thAaPYVEQ8TosybKI62E69QLKlQboyI2lZCvLMGtt/s+xbiZE/fPQMcURiIs+HZlBsX91hF6XAY/slxQpL37vpZWSuhy4YCYcXKWt+mvQ8UHYbL8siQUZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783844438; c=relaxed/simple;
	bh=tPc35THmP7NmgNO+Kh4JNYVBkG1ttXD/6LRhPMG1HUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rj2qjV8+6to0UyXpML2aJfaanwYppq62S0H5WNqR9UjQTVfdl3XqvMnz/236ny3Ck5MVvg7SgjmjoRqI3fKUiU3bmD+6QhZhW6yIpkniUaSVkDLuF4dSDOI1DE5BYQtI0KhZoJ/+iR4Xo0XXtpGqVl7IWdQvG5Z//VYZStsUzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kMGJpbW+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234961F000E9;
	Sun, 12 Jul 2026 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783844436;
	bh=myy6sY1pUrVSwQ+PXw9iLk6LIlY+AC5U4EajyhzaVeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kMGJpbW+3Vu8QB84ljm68aA4smlWYMDagbDSQaPr2l9QDWU1FvuTRwSRrNTKqnhgQ
	 os3KFP1qKR8M46joTKqpY5o1TQ+CXJr/Ddx0b84gORO8pnPnMwKk0JTKV37gM/3htD
	 Ra6tpYMUTUBHbSVMdnzuIrZrI5/xvergpfbL7n48=
Date: Sun, 12 Jul 2026 10:20:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Westphal <fw@strlen.de>
Cc: Jaeyeong Lee <iostreampy@proton.me>, netfilter-devel@vger.kernel.org,
	pablo@netfilter.org, phil@nwl.cc
Subject: Re: [PATCH nf] netfilter: nf_nat: do not reuse an unexpected
 expectation on RTCP clash
Message-ID: <2026071210-grid-runaround-4318@gregkh>
References: <aQrSf6maL27cH2V4V9ELFdSqdtCWQ-B5iZr8fjR2Wz7zAJ7L32oW50bdrePoTMnJ4CRjDrns-jNMNFHGWNUxYe3UcV91AK99Ilncjab2uDk=@proton.me>
 <2026071134-turkey-detonator-0d87@gregkh>
 <178377968720.33756.12204817361601593230@proton.me>
 <alJva5_-K55ouKGh@strlen.de>
 <2026071235-geometric-snowdrift-bb4c@gregkh>
 <alNE4AO9H0HGLc34@strlen.de>
 <2026071249-contented-gallantly-2927@gregkh>
 <alNLcE1qJ5fwBO0N@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alNLcE1qJ5fwBO0N@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:iostreampy@proton.me,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:phil@nwl.cc,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13865-lists,netfilter-devel=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:email,linuxfoundation.org:dkim,vger.kernel.org:from_smtp,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDC5074425A

On Sun, Jul 12, 2026 at 10:08:16AM +0200, Florian Westphal wrote:
> Greg KH <gregkh@linuxfoundation.org> wrote:
> > > This is no different than the WARNs on list corruption or refcount
> > > under/overflows.
> > 
> > True, but adding new ones is not a good idea, and removing the existing
> > ones is a good idea.
> 
> We're fucked, then.  Can we at least use DEBUG_NET_WARN or something
> like that so at least fizzers can give us hints about bugs?!

That's up to you.  If panic_on_warn wasn't an option, about half of the
kernel CVEs would disappear tomorrow.

> > > Would you propose to remove those?  I hope not, they help catch bugs.
> > 
> > Bugs that userspace can trigger?  If so, then properly catch them by
> > testing and handling the issue.
> 
> Aka "Don't write buggy code".  Should have thought of that.

No, I'm not saying that, I'm saying that if this is something that could
possibly happen, then let's catch that with a real check.

> > If userspace can never trigger it, then
> > it's not really needed as the code is never going to trigger.
> 
> It causes memory corruption and evidently triggers.
> 
> With "silently catch error" and no WARN there will be rare,
> intermittent connectivity issues.
> 
> We are NOT in a syscall, there is no process to return
> a meaningful error code to.

It's up to you, if you really want WARN_ON(), that's fine, but realize
that if it can be triggered, it will require a round of fixing as it can
take down systems.

thanks,

greg k-h

