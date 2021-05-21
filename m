Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FE338C310
	for <lists+netfilter-devel@lfdr.de>; Fri, 21 May 2021 11:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhEUJ3g (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 21 May 2021 05:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbhEUJ3e (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 21 May 2021 05:29:34 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46668C0613ED
        for <netfilter-devel@vger.kernel.org>; Fri, 21 May 2021 02:28:11 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lk1Rx-0004ed-CI; Fri, 21 May 2021 11:28:09 +0200
Date:   Fri, 21 May 2021 11:28:09 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
        dvyukov@google.com
Subject: Re: [PATCH nf,v2] netfilter: nftables: accept all dummy chain when
 table is dormant
Message-ID: <20210521092809.GC3559@breakpoint.cc>
References: <20210519101402.45141-1-pablo@netfilter.org>
 <20210519121533.GC8317@breakpoint.cc>
 <20210519155633.GA3182@salvia>
 <20210519183404.GG8317@breakpoint.cc>
 <20210520225054.GA31069@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520225054.GA31069@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Wed, May 19, 2021 at 08:34:04PM +0200, Florian Westphal wrote:
> > ... but that is doable in the sense that unregister can't fail.
> 
> Right, but adding "unregister hooks" to the abort path breaks a
> different scenario. This might unregister a hook that, because of a later
> wake-up action, needs to stay there, because you cannot call register
> a hook from the abort path, it's a bit of a whac-a-mole game.

Argh, indeed.  We'd have to re-scan the transaction log during
preparation phase for each dormant on/off and chain add/delete to
see if the action un-does an earlier pending one, then remove both
if they cancel each other.

> > I guess dormat tables are an exception and not the norm, so maybe
> > unfounded concern.
> 
> You are right that this approach incurs in the hook evaluation penalty
> from the packet path. But I don't think there's a need to optimize
> this feature at this stage

Ok, I dislike optimizing too early as well.

> So I'm just inclined to keep it simple while making sure that any
> possible (silly) robot-generated sequence with this toggle works fine.

Ok, lets use your approach then.
