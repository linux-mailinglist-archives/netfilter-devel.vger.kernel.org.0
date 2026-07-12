Return-Path: <netfilter-devel+bounces-13864-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qANpMnlLU2p6ZgMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13864-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 10:08:25 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7EE7441C5
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 10:08:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13864-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13864-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87C033006101
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 08:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B0936A03A;
	Sun, 12 Jul 2026 08:08:21 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8197A5474F
	for <netfilter-devel@vger.kernel.org>; Sun, 12 Jul 2026 08:08:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783843701; cv=none; b=qm9dBCE/ANd9KsViZmsKWTVnFDABegSQndYy1PmyI4bazVulPTIEgdmjQBRZPRTckd9Yllc7bBDZ6ePqUQubRaFSKk43fN4NXg2GLbEaTZTIkaGzMdT4sETZ86vCj9cM2RJV4IMHcrOquncghwjSksTE7uzOj9N/paq6MWZPR50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783843701; c=relaxed/simple;
	bh=wwz6LpEdl/gi7npHGsHFpQvj8XDH7dwVa2ol0JJMGFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBZ1GcliVy63pabI+qZ5XqkNjxOLZirzj1LtdbXc11hi3VxoHa4AasMMuat/CcBIMK6AWjf296AWu/35VRsHwkCZoZ2RXnpo3re+OBbI1LIZGQWIpAAQaJsMweEABRURcclu42E396gTPYm+DBp2Kmo01TLtiFqSthFK0fiXPBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 24A1B60388; Sun, 12 Jul 2026 10:08:17 +0200 (CEST)
Date: Sun, 12 Jul 2026 10:08:16 +0200
From: Florian Westphal <fw@strlen.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jaeyeong Lee <iostreampy@proton.me>, netfilter-devel@vger.kernel.org,
	pablo@netfilter.org, phil@nwl.cc
Subject: Re: [PATCH nf] netfilter: nf_nat: do not reuse an unexpected
 expectation on RTCP clash
Message-ID: <alNLcE1qJ5fwBO0N@strlen.de>
References: <aQrSf6maL27cH2V4V9ELFdSqdtCWQ-B5iZr8fjR2Wz7zAJ7L32oW50bdrePoTMnJ4CRjDrns-jNMNFHGWNUxYe3UcV91AK99Ilncjab2uDk=@proton.me>
 <2026071134-turkey-detonator-0d87@gregkh>
 <178377968720.33756.12204817361601593230@proton.me>
 <alJva5_-K55ouKGh@strlen.de>
 <2026071235-geometric-snowdrift-bb4c@gregkh>
 <alNE4AO9H0HGLc34@strlen.de>
 <2026071249-contented-gallantly-2927@gregkh>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026071249-contented-gallantly-2927@gregkh>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:iostreampy@proton.me,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:phil@nwl.cc,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-13864-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:from_mime,linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A7EE7441C5

Greg KH <gregkh@linuxfoundation.org> wrote:
> > This is no different than the WARNs on list corruption or refcount
> > under/overflows.
> 
> True, but adding new ones is not a good idea, and removing the existing
> ones is a good idea.

We're fucked, then.  Can we at least use DEBUG_NET_WARN or something
like that so at least fizzers can give us hints about bugs?!

> > Would you propose to remove those?  I hope not, they help catch bugs.
> 
> Bugs that userspace can trigger?  If so, then properly catch them by
> testing and handling the issue.

Aka "Don't write buggy code".  Should have thought of that.

> If userspace can never trigger it, then
> it's not really needed as the code is never going to trigger.

It causes memory corruption and evidently triggers.

With "silently catch error" and no WARN there will be rare,
intermittent connectivity issues.

We are NOT in a syscall, there is no process to return
a meaningful error code to.

With WARN at least there is some chance that someone will report
it so underlying root cause gets fixed.

EOD from my side, have iot your way, silent ignore it is.

