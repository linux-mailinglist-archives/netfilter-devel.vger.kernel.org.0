Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5F319E71
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Feb 2021 13:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhBLMaL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 12 Feb 2021 07:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhBLMaF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:30:05 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4A9C061574;
        Fri, 12 Feb 2021 04:29:24 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lAXZb-0000g1-9H; Fri, 12 Feb 2021 13:29:23 +0100
Date:   Fri, 12 Feb 2021 13:29:23 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        Martin Gignac <martin.gignac@gmail.com>,
        netfilter@vger.kernel.org,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: Unable to create a chain called "trace"
Message-ID: <20210212122923.GF2766@breakpoint.cc>
References: <CANf9dFMJN5ZsihtygUnEWB_9T=WLbEHrZY1a5mTqLgN7J39D5w@mail.gmail.com>
 <20210208154915.GF16570@breakpoint.cc>
 <20210208164750.GM3158@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208164750.GM3158@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> > grammar bug.
> > 
> > Pablo, Phil, others, can you remind me why we never did:
> 
> Because this would be followed up by:
> 
> | Subject: Unable to create a table called "trace"
> 
> Jokes aside:
> 
> I think Pablo didn't like the obvious consequence of having to quote
> *all* string types which are user-defined in output. He played with
> keeping the quotes as part of the name, so they are sent to kernel and
> in listing they would automatically appear quoted. I don't quite
> remember why this was problematic, though.
>
> In general, shells eating the quotes is problematic and users may not be
> aware of it. This includes scripts that mangle ruleset dumps by
> accident, etc. (Not sure if it is really a problem as we quote some
> strings already).

Ok, but what if we just allow use of quotes in input?
That would at least allow to use nft to delete/add to chains created
by other tools.
