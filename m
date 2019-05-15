Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B20ED1FB7F
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 May 2019 22:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfEOUbw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 May 2019 16:31:52 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:51562 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfEOUbw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 May 2019 16:31:52 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hR0Z3-0008Hm-G3; Wed, 15 May 2019 22:31:49 +0200
Date:   Wed, 15 May 2019 22:31:49 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 2/2 nft] jump: Allow goto and jump to a variable using
 nft input files
Message-ID: <20190515203149.GD4851@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190514211340.913-1-ffmancera@riseup.net>
 <20190514211340.913-2-ffmancera@riseup.net>
 <20190515105850.GA4851@orbyte.nwl.cc>
 <347917dc-086b-998c-dd2f-b5e4a87b38b1@riseup.net>
 <20190515111232.lu3ifr72mlhfriqc@salvia>
 <20190515114617.GB4851@orbyte.nwl.cc>
 <20190515152132.267ryecqod3xenyj@salvia>
 <20190515192600.GC4851@orbyte.nwl.cc>
 <902d698b-a25c-0567-1338-b2d8c0bd91cb@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <902d698b-a25c-0567-1338-b2d8c0bd91cb@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Wed, May 15, 2019 at 09:56:11PM +0200, Fernando Fernandez Mancera wrote:
> Hi Phil,
> 
> On 5/15/19 9:26 PM, Phil Sutter wrote:
> > Hi Pablo,
> > 
> > On Wed, May 15, 2019 at 05:21:32PM +0200, Pablo Neira Ayuso wrote:
> >> On Wed, May 15, 2019 at 01:46:17PM +0200, Phil Sutter wrote>> [...]
> >> '@<something>' is currently allowed, as any arbitrary string can be
> >> placed in between strings - although in some way this is taking us
> >> back to the quote debate that needs to be addressed. If we want to
> >> disallow something enclosed in quotes then we'll have to apply this
> >> function everywhere we allow variables.
> > 
> > Oh, sorry. I put those ticks in there just to quote the value, not as
> > part of the value. The intention was to point out that something like:
> > 
> > | define foo = @set1
> > | add rule ip t c jump $foo
> > 
> > Might pass evaluation stage and since there is a special case for things
> > starting with '@' in symbol_expr, the added rule would turn into
> > 
> > | add rule ip t c jump set1
> > 
> > We could detect this situation by checking expr->symtype.
> > 
> 
> I agree about that. We could check if the symbol type is SYMBOL_VALUE.
> But I am not sure about where should we do it, maybe in the parser?
> 
> > On the other hand, can we maybe check if given string points to an
> > *existing* chain in verdict_type_parse()? Or will that happen later
> > anyway?
> > 
> 
> It happens later, right now if the given string does not point to an
> existing chain it returns the usual error for this situation. e.g

I just played around a bit and could provoke some segfaults:

* define foo = @set1 (a set named 'set1' must exist)
* define foo = { 1024 }
* define foo = *

I didn't check how we could avoid those. Maybe this is even follow-up
work, but we should definitely try to address those eventually.

Cheers, Phil
