Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDFDDAB54
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2019 13:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439727AbfJQLh7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Oct 2019 07:37:59 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:41480 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406040AbfJQLh6 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:37:58 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iL46P-0004Sy-GM; Thu, 17 Oct 2019 13:37:57 +0200
Date:   Thu, 17 Oct 2019 13:37:57 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 2/4] Revert "monitor: fix double cache update with
 --echo"
Message-ID: <20191017113757.GL12661@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191016230322.24432-1-phil@nwl.cc>
 <20191016230322.24432-3-phil@nwl.cc>
 <20191017085549.zm4jcz23q6vceful@salvia>
 <20191017090738.2wey6j4mfzelgse2@salvia>
 <20191017103649.GH12661@orbyte.nwl.cc>
 <20191017112917.6oartfhrj73y5sy5@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017112917.6oartfhrj73y5sy5@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 17, 2019 at 01:29:17PM +0200, Pablo Neira Ayuso wrote:
> On Thu, Oct 17, 2019 at 12:36:49PM +0200, Phil Sutter wrote:
> > Hi Pablo,
> > 
> > On Thu, Oct 17, 2019 at 11:07:38AM +0200, Pablo Neira Ayuso wrote:
> > > On Thu, Oct 17, 2019 at 10:55:49AM +0200, Pablo Neira Ayuso wrote:
> > > > On Thu, Oct 17, 2019 at 01:03:20AM +0200, Phil Sutter wrote:
> > > > > This reverts commit 9b032cd6477b847f48dc8454f0e73935e9f48754.
> > > > >
> > > > > While it is true that a cache exists, we still need to capture new sets
> > > > > and their elements if they are anonymous. This is because the name
> > > > > changes and rules will refer to them by name.
> > > 
> > > Please, tell me how I can reproduce this here with a simple snippet
> > > and I will have a look. Thanks!
> > 
> > Just run tests/monitor testsuite, echo testing simple.t will fail.
> > Alternatively, add a rule with anonymous set like so:
> > | # nft --echo add rule inet t c tcp dport '{ 22, 80 }'
> > 
> > > > > Given that there is no easy way to identify the anonymous set in cache
> > > > > (kernel doesn't (and shouldn't) dump SET_ID value) to update its name,
> > > > > just go with cache updates. Assuming that echo option is typically used
> > > > > for single commands, there is not much cache updating happening anyway.
> > > > 
> > > > This was fixing a real bug, if this is breaking anything, then I think
> > > > we are not getting to the root cause.
> > > > 
> > > > But reverting it does not make things any better.
> > 
> > With all respect, this wasn't obvious. There is no test case covering
> > it, commit message reads like it is an optimization (apart from the
> > subject containing 'fix').
> 
> After reverting:
> 
> # ./run-tests.sh testcases/sets/0036add_set_element_expiration_0
> I: using nft binary ./../../src/nft
> 
> W: [FAILED]     testcases/sets/0036add_set_element_expiration_0: got 139
> 
> I: results: [OK] 0 [FAILED] 1 [TOTAL] 1
> 
> so I made the test for this fix.
> 
> commit 44348edfb9fa414152d53bcf705db882899ddc4e
> Author: Pablo Neira Ayuso <pablo@netfilter.org>
> Date:   Mon Jul 1 18:34:42 2019 +0200
> 
>     tests: shell: restore element expiration
> 
>     This patch adds a test for 24f33c710e8c ("src: enable set expiration
>     date for set elements").
> 
>     This is also implicitly testing for a cache corruption bug that is fixed
>     by 9b032cd6477b ("monitor: fix double cache update with --echo").

Ah, thanks for the pointer! I'll check what's going wrong there.

Cheers, Phil
