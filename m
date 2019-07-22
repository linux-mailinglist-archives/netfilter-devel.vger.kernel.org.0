Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3597470074
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jul 2019 15:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfGVNDC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Jul 2019 09:03:02 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45822 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbfGVNDC (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:03:02 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hpXxz-0002PB-2H; Mon, 22 Jul 2019 15:02:59 +0200
Date:   Mon, 22 Jul 2019 15:02:59 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] doc: fib: explain example in more detail
Message-ID: <20190722130259.GK22661@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190721104305.29594-1-fw@strlen.de>
 <20190721184212.2fxviqkcil27wzqp@salvia>
 <20190721185432.o2wke7wecfdbyzfr@breakpoint.cc>
 <20190722115756.GH22661@orbyte.nwl.cc>
 <20190722121747.32ve2o3e7luxtwnq@breakpoint.cc>
 <20190722125246.GJ22661@orbyte.nwl.cc>
 <20190722125633.7pgm3glloutr4esj@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722125633.7pgm3glloutr4esj@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jul 22, 2019 at 02:56:33PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > On Mon, Jul 22, 2019 at 02:17:47PM +0200, Florian Westphal wrote:
> > > Phil Sutter <phil@nwl.cc> wrote:
> > > > use for "no data available" situations. This whole attempt feels a bit
> > > > futile. Maybe we should introduce something to signal "no value" so that
> > > > cmp expression will never match for '==' and always for '!='? Not sure
> > > > how to realize this via registers. Also undecided about '<' and '>' ops.
> > > 
> > > Whats the point?
> > 
> > IIRC, Pablo's demand for not aborting in nft_meta in case of
> > insufficient data was to insert a value into dreg which will never
> > match. I think the idea was to avoid accidental matching in situations
> > where a match doesn't make sense.
> 
> I think the only contraint is that it must not overlap with a
> legitimate ifindex.
> 
> But 0 cannot occur, so 'meta iif 0' will only match in case no input
> interface existed -- I think thats fine and might even be desired.

OK, so we just drop my patch to reject ifindex 0 from userspace to keep
fib working?

[...]
> I would propose to go with '0' dreg for ifindex, "" for name and leave
> rest as-is.

My kernel patch also changes iftype to set ARPHRD_VOID and ifkind to set
an empty string as well.

For iftype, I also sent a userspace patch to disallow ARPHRD_VOID. Do
you think it should be dropped as well?

Thanks, Phil
