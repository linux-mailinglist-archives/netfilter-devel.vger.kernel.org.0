Return-Path: <netfilter-devel+bounces-13854-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q6ayHXlvUmoqPwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13854-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Jul 2026 18:29:45 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B08B77422D6
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Jul 2026 18:29:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13854-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13854-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58E743011119
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Jul 2026 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02BC1D7E41;
	Sat, 11 Jul 2026 16:29:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A3D2D617
	for <netfilter-devel@vger.kernel.org>; Sat, 11 Jul 2026 16:29:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783787382; cv=none; b=SmGQ/gsiK9yTCguzRMWqy3U3Ewbj5eIqXzaDUfWM7RZn4LclEQ4xV25BMXIJEwRCrFI9tW7moojQBynU2e3a+AFzp8zfA1ooTM03aXNHNgRu3T4R11hSIKKJDTTr7tLWYoXROS4a1FHcCRmSsSCfF9UK2q1MM+sQGDrvAu6yTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783787382; c=relaxed/simple;
	bh=VmKANdKs2g/+rLXnpDJf9SfHvcPu/wvFjlaOw8eY5OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alwKHqXim087OikEdzfIO6iyOWlAv3R7ijxLyH64j2vZ8BIiNlsc8gg89avnEZzmI2EmMRmg1e5u25q1uAt63HSRvrRv9Q48RxmH6OvykkIHcR8XNZrcVnfCmR6JmzCXfgp304xw16SVtYP2BEq59z3F6pkrcIlgHB2iTjlJFJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 10C4E60225; Sat, 11 Jul 2026 18:29:32 +0200 (CEST)
Date: Sat, 11 Jul 2026 18:29:31 +0200
From: Florian Westphal <fw@strlen.de>
To: Jaeyeong Lee <iostreampy@proton.me>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org, phil@nwl.cc,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH nf] netfilter: nf_nat: do not reuse an unexpected
 expectation on RTCP clash
Message-ID: <alJva5_-K55ouKGh@strlen.de>
References: <aQrSf6maL27cH2V4V9ELFdSqdtCWQ-B5iZr8fjR2Wz7zAJ7L32oW50bdrePoTMnJ4CRjDrns-jNMNFHGWNUxYe3UcV91AK99Ilncjab2uDk=@proton.me>
 <2026071134-turkey-detonator-0d87@gregkh>
 <178377968720.33756.12204817361601593230@proton.me>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178377968720.33756.12204817361601593230@proton.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:iostreampy@proton.me,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:phil@nwl.cc,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-13854-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proton.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B08B77422D6

Jaeyeong Lee <iostreampy@proton.me> wrote:
> Since commit b8b09dc2bf35 ("netfilter: nf_conntrack_expect: use conntrack
> GC to reap expectations") nf_ct_unexpect_related() no longer unlinks the
> expectation from the global hash and from the per-master list. It only
> marks it with NF_CT_EXPECT_DEAD and defers the unlink to the conntrack GC

[..]

> and then continues the loop, reusing the very same rtp_exp object:
> 
> 	ret = nf_ct_expect_related(rtcp_exp, ...);
> 	...

I think this function should WARN_ON_ONCE when one tries to reinsert a
dead expectation (and return -EINVAL or another appropriate error).

(This is indenpendent of the real fix).

