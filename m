Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80DE8DAB12
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2019 13:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405226AbfJQLVk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Oct 2019 07:21:40 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:41442 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbfJQLVk (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:21:40 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iL3qd-00046Y-53; Thu, 17 Oct 2019 13:21:39 +0200
Date:   Thu, 17 Oct 2019 13:21:39 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v4 0/8] Improve iptables-nft performance with
 large rulesets
Message-ID: <20191017112139.GI12661@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191015114152.25254-1-phil@nwl.cc>
 <20191017090332.erwubv7pzxbbowjg@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017090332.erwubv7pzxbbowjg@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Thu, Oct 17, 2019 at 11:03:32AM +0200, Pablo Neira Ayuso wrote:
> On Tue, Oct 15, 2019 at 01:41:44PM +0200, Phil Sutter wrote:
> > Fourth try at caching optimizations implementation.
> > 
> > Changes since v3:
> > 
> > * Rebase onto current master after pushing the accepted initial three
> >   patches.
> > * Avoid cache inconsistency in __nft_build_cache() if kernel ruleset
> >   changed since last call.
> 
> I still hesitate with this cache approach.
> 
> Can this deal with this scenario? Say you have a ruleset composed on N
> rules.
> 
> * Rule 1..M starts using generation X for the evaluation, they pass
>   OK.
> 
> * Generation is bumped.
> 
> * Rule M..N is evaluated with a diferent cache.
> 
> So the ruleset evaluation is inconsistent itself since it is based on
> different caches for each rule in the batch.

Yes, that is possible. In a discussion with Florian back when he fixed
for concurrent xtables-restore calls, consensus was: If you use
--noflush and concurrent ruleset updates happen, you're screwed anyway.
(Meaning, results are not predictable and we can't do anything about
it.)

In comparison with current code which just fetches full cache upon
invocation of 'xtables-restore --noflush', problems might not be
detected during evaluation but only later when kernel rejects the
commands.

Eventually, commands have to apply to the ruleset as it is after opening
the transaction. If you cache everything first, you don't detect
incompatible ruleset changes at all. If you cache multiple times, you
may detect the incompatible changes while evaluating but the result is
the same, just with different error messages. :)

Cheers, Phil
