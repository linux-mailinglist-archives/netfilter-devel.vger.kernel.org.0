Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BADCD7B5A
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Oct 2019 18:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfJOQ0A (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Oct 2019 12:26:00 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:37150 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfJOQ0A (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:26:00 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iKPe3-00089h-9q; Tue, 15 Oct 2019 18:25:59 +0200
Date:   Tue, 15 Oct 2019 18:25:59 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH 3/6] set_elem: Validate nftnl_set_elem_set()
 parameters
Message-ID: <20191015162559.GA12661@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191015141658.11325-1-phil@nwl.cc>
 <20191015141658.11325-4-phil@nwl.cc>
 <20191015155244.int6uix23brc4iug@salvia>
 <20191015160255.GX12661@orbyte.nwl.cc>
 <20191015160913.cgmyhosz64yu7kfr@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015160913.cgmyhosz64yu7kfr@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Tue, Oct 15, 2019 at 06:09:13PM +0200, Pablo Neira Ayuso wrote:
> On Tue, Oct 15, 2019 at 06:02:55PM +0200, Phil Sutter wrote:
> > On Tue, Oct 15, 2019 at 05:52:44PM +0200, Pablo Neira Ayuso wrote:
> > > On Tue, Oct 15, 2019 at 04:16:55PM +0200, Phil Sutter wrote:
> > [...]
> > > > diff --git a/src/set_elem.c b/src/set_elem.c
> > > > index 3794f12594079..4225a96ee5a0a 100644
> > > > --- a/src/set_elem.c
> > > > +++ b/src/set_elem.c
> > > > @@ -96,10 +96,20 @@ void nftnl_set_elem_unset(struct nftnl_set_elem *s, uint16_t attr)
> > > >  	s->flags &= ~(1 << attr);
> > > >  }
> > > >  
> > > > +static uint32_t nftnl_set_elem_validate[NFTNL_SET_ELEM_MAX + 1] = {
> > > > +	[NFTNL_SET_ELEM_FLAGS]		= sizeof(uint32_t),
> > > > +	[NFTNL_SET_ELEM_VERDICT]	= sizeof(int), /* FIXME: data.verdict is int?! */
> > > 
> > > This is uint32_t, update this before pushing out this.
> > 
> > Oh, sorry. I missed this note to myself.
> > 
> > So, should we change union nftnl_data_reg accordingly then?
> 
> I'm seeing this is being used from nftables.git as...
> 
>         nftnl_set_elem_set_u32(nlse, NFTNL_SET_ELEM_VERDICT, ...

Well, there's no nftnl_set_elem_set_int() so it naturally uses that. My
question was whether 'verdict' field in union nftnl_data_reg should be
changed to uint32_t type as well. Currently it is just int, which
doesn't make a difference unless one tries to run nftables on a 16bit
machine. :)

Cheers, Phil
