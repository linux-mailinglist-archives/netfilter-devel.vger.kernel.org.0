Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D73E9CCCA
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Aug 2019 11:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfHZJtk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Aug 2019 05:49:40 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:47753 "EHLO
        ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbfHZJtj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:49:39 -0400
Received: from [31.4.213.210] (helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <pablo@gnumonks.org>)
        id 1i2Bcx-0004VD-Qv; Mon, 26 Aug 2019 11:49:38 +0200
Date:   Mon, 26 Aug 2019 11:49:27 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Arturo Borrero Gonzalez <arturo@netfilter.org>
Subject: Re: [PATCH nftables 0/8] add typeof keyword
Message-ID: <20190826094927.ivroycb6u7cjchyi@salvia>
References: <20190816144241.11469-1-fw@strlen.de>
 <20190817102351.x2s2vj5hgvsi5vak@salvia>
 <20190817205554.iq7rfmvwzcugfmzc@breakpoint.cc>
 <8d3401fd-8855-2b2a-6d02-b3331984acbb@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d3401fd-8855-2b2a-6d02-b3331984acbb@netfilter.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Score: -2.7 (--)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Florian,

On Sun, Aug 18, 2019 at 04:33:15PM +0200, Arturo Borrero Gonzalez wrote:
> On 8/17/19 10:55 PM, Florian Westphal wrote:
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> >> I know I sent a RFC using typeof(), I wonder if you could just use the
> >> selector instead, it's a bit of a lot of type typeof() . typeof()
> >> probably.
> >>
> >> So this is left as this:
> >>
> >>         type osf name
> >>
> >> in concatenations, like this:
> >>
> >>         nft add set ip filter allowed "{ type ip daddr . tcp dport; }"
> >>
> >> Probably I would ask my sysadmin friends what they think.
> > 
> > Yes, please do, it would be good to get a non-developer perspective.
> > 
> > I'm very used to things like sizeof(), so typeof() felt natural to me.
> > 
> > Might be very un-intuitive for non-developers though, so it would be
> > good to get outside perspective.
> 
> From my point of view, this is a rather advanced operation. As long as it is
> properly documented, I don't see any problem with `typeof()`.
> 
> Also, just `typeof` would work of course. Up to you.

My suggestion is:

        typeof ip saddr . tcp dport . meta mark

but, not to allow the use of the existing datatypes with typeof.

So either the user picks:

        type ipv4_addr . inet_service . mark

or this:

        typeof ip saddr . tcp dport . meta mark

Then, for the notation:

        integer,bits

I would suggest this one can only be used from 'type'.

Goal is basically:

* Avoiding repetitive typeof() that looks a bit like C programming.
* Mixing datatype with inferred datatypes looks a bit sloppy to me
  from syntax consistency point of view.

This approach is flexible enough to cover all use cases this patchset
is dealing with I think.

If you like this approach, I would suggest you just update the
patchset to support this and then push this out, I'll catch up later
on to revisit this before the next release, in case I can propose you
some refinement for your review.

Let me know, thanks.
