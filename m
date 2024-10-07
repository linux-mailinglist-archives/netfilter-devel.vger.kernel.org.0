Return-Path: <netfilter-devel+bounces-4274-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3883B992700
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Oct 2024 10:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722E91C222D9
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Oct 2024 08:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2084018B47A;
	Mon,  7 Oct 2024 08:30:17 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658218B498
	for <netfilter-devel@vger.kernel.org>; Mon,  7 Oct 2024 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289817; cv=none; b=T+uvUXC88sbBXRAnjA02NwQEJZBMYY0iWQVFwPABmjcB1bsQwIQYBDeSPeGqd6WDboUI3mPMQihDf5LPMtqByDfwNJ9h4s4AALDk468mVwhgjzVJ8U/ebwowUJYGJbOKuUSP7ez26Qa5NI7qwpkO8eW18TpB6MhNb+LKGEayVh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289817; c=relaxed/simple;
	bh=ZEJzQFGKq9+7C6xZLjNeTRiSv+c8wxHQuHa0S6N7VLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPkWFbWYH55K4fRlvaSrJ1mpf+pyErMNHH4OX5DMN+81TUoPCF0pw0jIxBeqKRlZFLr5Z+37jGZC/uJwDGFeuoTEA365D0eZoTSpe7cW1vtRTSHMrT+NUbrzp9eoYI5z9Ofdk7Tu3Vi48QF9uoCGK7vbazPumV0W/6Z5ItPpN2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=34428 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sxj7w-005Su5-Vv; Mon, 07 Oct 2024 10:30:03 +0200
Date: Mon, 7 Oct 2024 10:30:00 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Antonio Ojea <antonio.ojea.garcia@gmail.com>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nfnetlink_queue: reroute reinjected
 packets from postrouting
Message-ID: <ZwOcCOEADH7bDT3b@calendula>
References: <20240912185832.11962-1-pablo@netfilter.org>
 <CABhP=tY2ceRAiZd3UCN3LqU8ZSO1G1W236XW+2rC6QhpeA9dsw@mail.gmail.com>
 <CABhP=taUnE6nxQ1ZPradgk7iNt3M_LCcFoM251OhpEJsasCoSw@mail.gmail.com>
 <Zus9trdyfiTNk2NI@calendula>
 <CABhP=tbVrpr1MuYSubw4LKUNP=_PFap3CN9bc3M_mzo6yxeqpw@mail.gmail.com>
 <ZuwSwAqKgCB2a51-@calendula>
 <CABhP=tbA+m+xnDp8kQUMZE61zNwLekdnzP_5HJB7gaPzvC1OFg@mail.gmail.com>
 <CABhP=tYLGfwmAvfU=d78trfxFqgfC05mFEkz=xOv9a8VUkfNDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABhP=tYLGfwmAvfU=d78trfxFqgfC05mFEkz=xOv9a8VUkfNDQ@mail.gmail.com>
X-Spam-Score: -1.9 (-)

On Mon, Oct 07, 2024 at 09:14:41AM +0100, Antonio Ojea wrote:
> On Sun, 6 Oct 2024 at 15:44, Antonio Ojea <antonio.ojea.garcia@gmail.com> wrote:
> >
> > >
> > > It could be different scenario. I was expecting consistency in UDP packet
> > > distribution is a requirement, but I understood goal at this stage is
> > > to ensure packets are not dropped while dealing with clash resolution.
> > >
> > > I have applied Florian's patch to nf.git, thanks.
> >
> > Is there a workaround I can apply in the meantime? kernels fixes take
> > a long time to be on users' distros and I have continuous reports
> > about this problem.
> >
> > I was thinking that I can track the tuples in userspace and hold the
> > duplicate for some time, but I'm not sure this will completely solve
> > the problem and I want to consider this as a last resort.
> > Is there any feature in nftables that can help? any ideas/suggestions
> > I can explore?
> 
> answering myself and for reference in case someone hits the same
> problem, I just special cased the DNS traffic to be processed only in
> the PREROUTING hook after DNAT and skip it in POSTROUTING, this does
> not seem to trigger the race problem.

I am going to request inclusion of this patch to -stable so you don't
have to carry this workaround in the near future.

