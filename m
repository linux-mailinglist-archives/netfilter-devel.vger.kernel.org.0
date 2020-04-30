Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBABD1C00D5
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2020 17:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgD3PwI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Apr 2020 11:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725844AbgD3PwI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:52:08 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D229C035494
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Apr 2020 08:52:08 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1jUBTr-0000SC-0f; Thu, 30 Apr 2020 17:52:07 +0200
Date:   Thu, 30 Apr 2020 17:52:06 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 00/18] iptables: introduce cache evaluation
 phase
Message-ID: <20200430155206.GQ15009@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20200428121013.24507-1-phil@nwl.cc>
 <20200429213609.GA24368@salvia>
 <20200430135300.GK15009@orbyte.nwl.cc>
 <20200430150831.GA2267@salvia>
 <20200430152606.GM15009@orbyte.nwl.cc>
 <20200430154440.GA3999@salvia>
 <20200430154834.GA4180@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430154834.GA4180@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Apr 30, 2020 at 05:48:34PM +0200, Pablo Neira Ayuso wrote:
> On Thu, Apr 30, 2020 at 05:44:40PM +0200, Pablo Neira Ayuso wrote:
> > On Thu, Apr 30, 2020 at 05:26:07PM +0200, Phil Sutter wrote:
> > [...]
> > > > BTW, this cache consistency check
> > > > 
> > > > commit 200bc399651499f502ac0de45f4d4aa4c9d37ab6
> > > > Author: Phil Sutter <phil@nwl.cc>
> > > > Date:   Fri Mar 13 13:02:12 2020 +0100
> > > > 
> > > >     nft: cache: Fix iptables-save segfault under stress
> > > > 
> > > > is already restored in this series, right?
> > > 
> > > Yes, IIRC this was the reason why I got a merge conflict upon rebase.
> > > But the problem shouldn't exist with the new logic: We fetch cache just
> > > once, so there is no cache update (and potential cache free) happening
> > > while iterating through chain lists or anything.
> > 
> > Still another process might be competing to update the ruleset, right?
> 
> I mean this case:
> 
> -       mnl_genid_get(h, &genid_stop);
> -       if (genid_start != genid_stop) {
> -               flush_chain_cache(h, NULL);
> -               goto retry;
> -       }
> 
> if the cache is inconsistent (another process stepped in and updated
> the ruleset), the discard this cache and fetch it again.

Ah, I understand your point now. Let me try to reenable this so
__nft_build_cache() returns a cache in which all entries "match"
regarding genid. I think this shouldn't cause problems anymore, even if
cache is freed in between attempts.

Thanks, Phil
