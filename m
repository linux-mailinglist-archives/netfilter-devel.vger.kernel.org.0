Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E843E319F21
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Feb 2021 13:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhBLMur (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 12 Feb 2021 07:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhBLMtd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:49:33 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA186C061756;
        Fri, 12 Feb 2021 04:48:48 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1lAXsM-0005YH-5z; Fri, 12 Feb 2021 13:48:46 +0100
Date:   Fri, 12 Feb 2021 13:48:46 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Martin Gignac <martin.gignac@gmail.com>, netfilter@vger.kernel.org,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: Unable to create a chain called "trace"
Message-ID: <20210212124846.GB3158@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Martin Gignac <martin.gignac@gmail.com>, netfilter@vger.kernel.org,
        netfilter-devel <netfilter-devel@vger.kernel.org>
References: <CANf9dFMJN5ZsihtygUnEWB_9T=WLbEHrZY1a5mTqLgN7J39D5w@mail.gmail.com>
 <20210208154915.GF16570@breakpoint.cc>
 <20210208164750.GM3158@orbyte.nwl.cc>
 <20210212122923.GF2766@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212122923.GF2766@breakpoint.cc>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 12, 2021 at 01:29:23PM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > > grammar bug.
> > > 
> > > Pablo, Phil, others, can you remind me why we never did:
> > 
> > Because this would be followed up by:
> > 
> > | Subject: Unable to create a table called "trace"
> > 
> > Jokes aside:
> > 
> > I think Pablo didn't like the obvious consequence of having to quote
> > *all* string types which are user-defined in output. He played with
> > keeping the quotes as part of the name, so they are sent to kernel and
> > in listing they would automatically appear quoted. I don't quite
> > remember why this was problematic, though.
> >
> > In general, shells eating the quotes is problematic and users may not be
> > aware of it. This includes scripts that mangle ruleset dumps by
> > accident, etc. (Not sure if it is really a problem as we quote some
> > strings already).
> 
> Ok, but what if we just allow use of quotes in input?
> That would at least allow to use nft to delete/add to chains created
> by other tools.

IIRC, this was deemed to make things worse as people may more easily
create rulesets which break with 'nft list ruleset | nft -f -'. But that
point won't hold anymore now, I guess. :D

Extracting the changes to parser_bison.y from my patch in
| Message-Id: <20190116184613.31698-1-phil@nwl.cc>
might suffice already.

Cheers, Phil
