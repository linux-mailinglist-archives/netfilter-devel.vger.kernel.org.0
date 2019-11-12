Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F0DF9BEC
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Nov 2019 22:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfKLVT7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Nov 2019 16:19:59 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:48746 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKLVT7 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:19:59 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iUdZt-0001gt-MF; Tue, 12 Nov 2019 22:19:57 +0100
Date:   Tue, 12 Nov 2019 22:19:57 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, a@juaristi.eus
Subject: Re: [PATCH nft 3/4] tests: add meta time test cases
Message-ID: <20191112211957.GC11663@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
        a@juaristi.eus
References: <20190829140904.3858-1-fw@strlen.de>
 <20190829140904.3858-4-fw@strlen.de>
 <20191112184439.GB11663@orbyte.nwl.cc>
 <20191112193557.GG19558@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112193557.GG19558@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Nov 12, 2019 at 08:35:57PM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > Hi,
> > 
> > On Thu, Aug 29, 2019 at 04:09:03PM +0200, Florian Westphal wrote:
> > [...]
> > > diff --git a/tests/py/any/meta.t.payload b/tests/py/any/meta.t.payload
> > > index 1d8426de9632..402caae5cad8 100644
> > > --- a/tests/py/any/meta.t.payload
> > > +++ b/tests/py/any/meta.t.payload
> > [...]
> > > +# meta hour "17:00" drop
> > > +ip test-ip4 input
> > > +  [ meta load hour => reg 1 ]
> > > +  [ cmp eq reg 1 0x0000d2f0 ]
> > > +  [ immediate reg 0 drop ]
> > 
> > Does this pass for you? I'm getting such warnings:
> > 
> > | 7: WARNING: line 3: 'add rule ip test-ip4 input meta hour "17:00" drop':
> > | '[ cmp eq reg 1 0x0000d2f0 ]' mismatches '[ cmp eq reg 1 0x0000e100 ]'
> > 
> > On my system, "17:00" consistently translates into 0xe100.
> 
> Argh, DST :-(
> 
> We will need to add change the test so nft-test.py runs with a fixed
> time zone.

Isn't this thing translating to UTC before submitting to kernel? I would
assume netlink debug output to be consistent between different
timezones.

Cheers, Phil
