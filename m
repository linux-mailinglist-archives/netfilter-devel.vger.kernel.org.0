Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50644917E
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Jun 2019 22:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfFQUhm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Jun 2019 16:37:42 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:33930 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfFQUhl (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:37:41 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hcyNo-0005GJ-1e; Mon, 17 Jun 2019 22:37:40 +0200
Date:   Mon, 17 Jun 2019 22:37:40 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH nft 3/5] src: add cache level flags
Message-ID: <20190617203739.GY31548@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, fw@strlen.de
References: <20190617122518.10486-1-pablo@netfilter.org>
 <20190617122518.10486-3-pablo@netfilter.org>
 <20190617161104.GT31548@orbyte.nwl.cc>
 <20190617162840.pqeyndnjwh4amzwx@salvia>
 <20190617164559.GV31548@orbyte.nwl.cc>
 <20190617172433.4bbyykwagxblwn4k@salvia>
 <20190617172831.GX31548@orbyte.nwl.cc>
 <20190617173329.7ztc4ksvovj5cagu@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617173329.7ztc4ksvovj5cagu@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 17, 2019 at 07:33:29PM +0200, Pablo Neira Ayuso wrote:
> On Mon, Jun 17, 2019 at 07:28:31PM +0200, Phil Sutter wrote:
> > On Mon, Jun 17, 2019 at 07:24:33PM +0200, Pablo Neira Ayuso wrote:
> > > On Mon, Jun 17, 2019 at 06:45:59PM +0200, Phil Sutter wrote:
> > > > On Mon, Jun 17, 2019 at 06:28:40PM +0200, Pablo Neira Ayuso wrote:
> > > > > On Mon, Jun 17, 2019 at 06:11:04PM +0200, Phil Sutter wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On Mon, Jun 17, 2019 at 02:25:16PM +0200, Pablo Neira Ayuso wrote:
> > > [...]
> > > > > 
> > > > > We need these for references to sets, eg.
> > > > > 
> > > > >         add rule x y ip saddr @x
> > > > > 
> > > > > same for other flowtable and object.
> > > > 
> > > > Oh, right. I got that wrong - old code is always fetching the above
> > > > items unless there's no ruleset in kernel (i.e., returned genid is 0).
> > > > 
> > > > I confused that with fetching rules which at some point started to
> > > > happen by accident with my changes.
> > > > 
> > > > > We should not use NFT_CACHE_RULE in this case, if this is what you
> > > > > suggest.
> > > > 
> > > > No, quite the opposite: I thought we could get by without fetching
> > > > anything from kernel at all.
> > > > 
> > > > Yet now I wonder why the handle guessing stops working, because the
> > > > above can't be the cause of it.
> > > 
> > > I think we should partial revert the changes that are doing the
> > > handle guessing, would you submit a patch for this?
> > 
> > There are no explicit changes allowing for it. The reason it works is
> > because user space doesn't care to check the given handle for existence
> > and in kernel space it is valid already.
> 
> OK, but this test just works because we are being lucky in
> guessing, right? I don't think we should not have a test for handles
> from the batch, for an unexisting rule in the kernel.

Yes, that's right. The test in question was added back in 2016 to make
sure the separate commands syntax works with 'nft -f'. I guess it was
simply convenient to add all the different commands to the same
transaction.

Cheers, Phil
