Return-Path: <netfilter-devel+bounces-4713-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE0F9B001A
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Oct 2024 12:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADF61F223E4
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Oct 2024 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E503A1E00BF;
	Fri, 25 Oct 2024 10:26:55 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9DC18BC1C
	for <netfilter-devel@vger.kernel.org>; Fri, 25 Oct 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852015; cv=none; b=LOdMDrQ4PhPPbhr1N+5B9yvMPcxUDMwO1ydQRCuo36U7gVu4/Geo5YweIdMPzECl503fUBlQXuOPSikCB1xNUfHTozFq6VxwyDdtH8H47QDwF0iYMpEaWwRl2uF0uwYHgTcSqn84NEUtQIarf/8VzhTi+pWGE8HmQkV/fQvonlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852015; c=relaxed/simple;
	bh=wVrFjVrn/x/atj01oCFmkK9JuMNBrOt9u038a9RovP8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOdDHSw0bpUT2TETezFV2m+MUt1dudh973mUmzEziDfQ0ATa9amLaJLenRI1UetwAFLo5BOXCtLiuTIiYg9LBPAUyug+QsPTUHris2v4L4sMHNBQhirbMQ4yJfEQrbNfnIKoJA4Ik7AzZuI5Wzfzrr7me082d4PEdpKSRoWSuGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=34136 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1t4HWq-007LOV-NP; Fri, 25 Oct 2024 12:26:50 +0200
Date: Fri, 25 Oct 2024 12:26:47 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
	Matthieu Baerts <matttbe@kernel.org>,
	netfilter-devel@vger.kernel.org,
	Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org
Subject: Re: Netfilter: suspicious RCU usage in __nft_rule_lookup
Message-ID: <ZxtyZ8-jVGuGCU2K@calendula>
References: <da27f17f-3145-47af-ad0f-7fd2a823623e@kernel.org>
 <ZxqKkVCnyOqHjFq-@calendula>
 <ZxqQAIlQx8C1E6FK@calendula>
 <20241024232230.GA23717@breakpoint.cc>
 <40d071e1-4c13-49c9-8cac-14c1377eaf86@kernel.org>
 <20241025092356.GA11843@breakpoint.cc>
 <Zxto-TvgUAa1p9N9@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zxto-TvgUAa1p9N9@orbyte.nwl.cc>
X-Spam-Score: -1.9 (-)

On Fri, Oct 25, 2024 at 11:46:33AM +0200, Phil Sutter wrote:
> On Fri, Oct 25, 2024 at 11:23:56AM +0200, Florian Westphal wrote:
> > Matthieu Baerts <matttbe@kernel.org> wrote:
> > > While at it, I had a question related to the rules' list: in
> > > __nft_release_basechain() from the same nf_tables_api.c file, list's
> > > entries are not removed with the _rcu variant → is it OK to do that
> > > because this function is only called last at the cleanup time, when no
> > > other readers can iterate over the list? So similar to what is done in
> > > __nft_release_table()?
> > 
> > Looks like __nft_release_basechain() is broken from start, I don't see
> > how it can work, it doesn't call synchronize_rcu or anything like that
> > afaics.
> > 
> > No idea what to do here.
> 
> It will vanish with my name-based netdev hooks series (the second part).
> I could prepare a patch for nf/stable which merely kills that function -
> dropping netdev-family chains upon removal of last interface is
> inconsistent wrt. flowtables which remain in place.

I like the idea of keeping the basechain in place. With chain update
support, it makes sense to add a basechain then update it with the
devices to hook in.

But chain device updates are only recently supported:

b9703ed44ffbfba85c103b9de01886a225e14b38
Author: Pablo Neira Ayuso <pablo@netfilter.org>
Date:   Fri Apr 21 00:34:31 2023 +0200

    netfilter: nf_tables: support for adding new devices to an existing netdev chain

that is, in older kernels, this chain would remain unused because
updates are not be possible.

> Another alternative might be to call synchronize_rcu() in there, but it
> slows down interface teardown AIUI.

Else unregister objects from lists under mutex then call_rcu() to
release them.

Then, take you patch so new kernel don't remove the basechain.

