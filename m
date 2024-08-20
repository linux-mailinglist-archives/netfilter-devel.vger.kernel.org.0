Return-Path: <netfilter-devel+bounces-3391-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35FA9585CE
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Aug 2024 13:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EDB8B2679B
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Aug 2024 11:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9658418E04E;
	Tue, 20 Aug 2024 11:28:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08D618E04F
	for <netfilter-devel@vger.kernel.org>; Tue, 20 Aug 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153310; cv=none; b=AJ3qPHuamMVnc/xjWkb5gce8DqNGlMl1NZoJFBwRYfmLUwbi+SUsdWgqMtBEF8VBOfSyTF5+7HYYW3kq7AvLgq2lei6VC7p00O0l7jT2U99bQZPoGHxNW+hGZP4dT5XmxQaIIvh2bbTztKzJRLOWv1V8hhmsJJRqMpe4K41wa10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153310; c=relaxed/simple;
	bh=ITdfgHGExveAtJ083BO4VEbJq97+Y97EQOC+69NxxY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7nWa+8JIFG66GLxsp36esrw6r9sLdgyv04YMECMj3oXhKc9CsbzDVvlzvvmqcMn54zrLgK4RkoA879J7lKhtf4ZE8Pu0qUuKmFiwYAufbuB7hvXKHZlt3Pa/aZLPPfGMh4hnKdVIN0L1fqBdAMpD8CNfRZregl9Ga2/BeIVB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=60838 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sgN2F-006l0F-GW; Tue, 20 Aug 2024 13:28:25 +0200
Date: Tue, 20 Aug 2024 13:28:22 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Joshua Lant <joshualant@googlemail.com>
Cc: netfilter-devel@vger.kernel.org, Joshua Lant <joshualant@gmail.com>
Subject: Re: [PATCH] xtables: Fix compilation error with musl-libc
Message-ID: <ZsR91p8Vf8_QxCvP@calendula>
References: <20240709130545.882519-1-joshualant@gmail.com>
 <ZsN_trJvTSw05f5W@calendula>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsN_trJvTSw05f5W@calendula>
X-Spam-Score: -1.9 (-)

On Mon, Aug 19, 2024 at 07:24:06PM +0200, Pablo Neira Ayuso wrote:
> On Tue, Jul 09, 2024 at 01:05:45PM +0000, Joshua Lant wrote:
> > Error compiling with musl-libc:
> > The commit hash 810f8568f44f5863c2350a39f4f5c8d60f762958 introduces the
> > netinet/ether.h header into xtables.h, which causes an error due to the
> > redefinition of the ethhdr struct, defined in linux/if_ether.h and
> > netinet/ether.h.
> > 
> > This is is a known issue with musl-libc, with kernel headers providing
> > guards against this happening when glibc is used:
> > https://wiki.musl-libc.org/faq (Q: Why am I getting “error: redefinition
> > of struct ethhdr/tcphdr/etc”?)
> > 
> > The only value used from netinet/ether.h is ETH_ALEN, which is already set
> > manually in libxtables/xtables.c. Move this definition to the header and
> > eliminate the inclusion of netinet/if_ether.h.
> 
> Any chance that musl headers are being used so this can be autodetected?
> Then, no option to pass -D__UAPI_DEF_ETHHDR=0 is required.

To clarify, what I mean is if it is possible to autodetect that musl
headers are used, then add this definition.

I'd prefer no new --option as you propose is required to handle this.

