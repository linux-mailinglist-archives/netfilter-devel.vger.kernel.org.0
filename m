Return-Path: <netfilter-devel+bounces-13859-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /ScgLlAsU2paYQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13859-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 07:55:28 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EADB8743F6C
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 07:55:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=LmR6witP;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13859-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13859-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8852F3011F36
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 05:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ACC2D7814;
	Sun, 12 Jul 2026 05:55:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7A25B090
	for <netfilter-devel@vger.kernel.org>; Sun, 12 Jul 2026 05:55:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783835725; cv=none; b=WI0UtmpnntyV8MZxk3v/DKKfn432BnjqYlDTKico0Clujtof4vLugxmDl7ptZUmFDrQ7GIQ1bY1ZLlbLNUTR33GELXpEVs6ng9XfwDovvu4FaEK58lCNNamv8uDD1FhQUAjSLGR1kxAtqz6mHioHhUMBWc6hWXGiO+H+0r8utcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783835725; c=relaxed/simple;
	bh=FHIqMzZe0AXToo6ubAtAolb75BO/wYxos9q5qax0qAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxDoiCMnGUDQr3UdLie9UabbBxwFHG9FDJSN+WGTv3Gn/UayIm0pY4FNzwm7eg3ZWj9N0NBLQaHMYG74LjzBlQBsVP85JOkdYZ3AS2UQVJt7x94wrire0r4aMKXdeKRYQDN/prhNpY7wDj8VsC1UkOUCrTVuvno9nx+jDun/en8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LmR6witP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8013E1F000E9;
	Sun, 12 Jul 2026 05:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783835724;
	bh=GlMEjvpkD3e4x+OXZj7W0SoGpxx/Z1MxVDlKF7QM3c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LmR6witPUgxBN+uFGy32vUrjbgadJSzdIQ0UzjsPxsjoQM0zpcC38pc3oW2qVCmJW
	 4Pgz9PWNnsYGpvG+IX4gE6SP9mRDtaZN5EODY3DHhjVi/T11jbj5fLfQ9Dk5oEL9Tz
	 capVpRcZClGdIijdZlqm5j8MJNRtV6w6WwrD/AMo=
Date: Sun, 12 Jul 2026 07:54:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Florian Westphal <fw@strlen.de>
Cc: Jaeyeong Lee <iostreampy@proton.me>, netfilter-devel@vger.kernel.org,
	pablo@netfilter.org, phil@nwl.cc
Subject: Re: [PATCH nf] netfilter: nf_nat: do not reuse an unexpected
 expectation on RTCP clash
Message-ID: <2026071235-geometric-snowdrift-bb4c@gregkh>
References: <aQrSf6maL27cH2V4V9ELFdSqdtCWQ-B5iZr8fjR2Wz7zAJ7L32oW50bdrePoTMnJ4CRjDrns-jNMNFHGWNUxYe3UcV91AK99Ilncjab2uDk=@proton.me>
 <2026071134-turkey-detonator-0d87@gregkh>
 <178377968720.33756.12204817361601593230@proton.me>
 <alJva5_-K55ouKGh@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alJva5_-K55ouKGh@strlen.de>
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
	TAGGED_FROM(0.00)[bounces-13859-lists,netfilter-devel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,proton.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EADB8743F6C

On Sat, Jul 11, 2026 at 06:29:31PM +0200, Florian Westphal wrote:
> Jaeyeong Lee <iostreampy@proton.me> wrote:
> > Since commit b8b09dc2bf35 ("netfilter: nf_conntrack_expect: use conntrack
> > GC to reap expectations") nf_ct_unexpect_related() no longer unlinks the
> > expectation from the global hash and from the per-master list. It only
> > marks it with NF_CT_EXPECT_DEAD and defers the unlink to the conntrack GC
> 
> [..]
> 
> > and then continues the loop, reusing the very same rtp_exp object:
> > 
> > 	ret = nf_ct_expect_related(rtcp_exp, ...);
> > 	...
> 
> I think this function should WARN_ON_ONCE when one tries to reinsert a
> dead expectation (and return -EINVAL or another appropriate error).
> 
> (This is indenpendent of the real fix).

If you do that, then the machine will reboot, loosing everything.  Are
you sure you want that to happen?  Why not just properly handle the
issue if it possibly could happen?

thanks,

greg k-h

