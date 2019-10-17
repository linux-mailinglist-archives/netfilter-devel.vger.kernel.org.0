Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E3FDB2F9
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2019 19:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436624AbfJQRG3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Oct 2019 13:06:29 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:42024 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436550AbfJQRG3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:06:29 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iL9EK-00085Z-2w; Thu, 17 Oct 2019 19:06:28 +0200
Date:   Thu, 17 Oct 2019 19:06:28 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v4 0/8] Improve iptables-nft performance with
 large rulesets
Message-ID: <20191017170628.GN12661@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191015114152.25254-1-phil@nwl.cc>
 <20191017090332.erwubv7pzxbbowjg@salvia>
 <20191017100816.plzn3tugcu2j2rpl@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017100816.plzn3tugcu2j2rpl@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 17, 2019 at 12:08:16PM +0200, Pablo Neira Ayuso wrote:
> On Thu, Oct 17, 2019 at 11:03:32AM +0200, Pablo Neira Ayuso wrote:
> > On Tue, Oct 15, 2019 at 01:41:44PM +0200, Phil Sutter wrote:
> > > Fourth try at caching optimizations implementation.
> > > 
> > > Changes since v3:
> > > 
> > > * Rebase onto current master after pushing the accepted initial three
> > >   patches.
> > > * Avoid cache inconsistency in __nft_build_cache() if kernel ruleset
> > >   changed since last call.
> > 
> > I still hesitate with this cache approach.
> > 
> > Can this deal with this scenario? Say you have a ruleset composed on N
> > rules.
> > 
> > * Rule 1..M starts using generation X for the evaluation, they pass
> >   OK.
> > 
> > * Generation is bumped.
> > 
> > * Rule M..N is evaluated with a diferent cache.
> > 
> > So the ruleset evaluation is inconsistent itself since it is based on
> > different caches for each rule in the batch.
> 
> It might be that rule M fails because a user-defined chain is not
> found anymore, error reporting will not be consistent on races, and
> who knows what else.
> 
> Anyway, if you want to go for this approach, merge it upstream and
> let's test how it goes... this batch looks much better indeed than v1,
> so push it out.

Yes, let's please give it a try. Fingers crossed, but if it blows up
I'll either fix it or revert it myself. :)

Pushed the whole series with your ACKs added.

Thanks, Phil
