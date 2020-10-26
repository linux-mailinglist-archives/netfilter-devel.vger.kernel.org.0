Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A56299273
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Oct 2020 17:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785996AbgJZQbE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Oct 2020 12:31:04 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:57856 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1738342AbgJZQbE (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:31:04 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1kX5Og-00070Z-Ij; Mon, 26 Oct 2020 17:31:02 +0100
Date:   Mon, 26 Oct 2020 17:31:02 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH 3/3] nft: Fix for concurrent noflush restore
 calls
Message-ID: <20201026163102.GB5098@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <20201005144858.11578-1-phil@nwl.cc>
 <20201005144858.11578-4-phil@nwl.cc>
 <20201012125450.GA26934@salvia>
 <20201013100803.GW13016@orbyte.nwl.cc>
 <20201013101502.GA29142@salvia>
 <20201014094640.GA13016@orbyte.nwl.cc>
 <20201016152850.GA1416@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016152850.GA1416@salvia>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 16, 2020 at 05:28:50PM +0200, Pablo Neira Ayuso wrote:
[...]
> Makes sense. Thanks a lot for explaining. Probably you can include
> this in the commit description for the record.
> 
> > I realize the test case is not quite effective, ruleset should be
> > emptied upon each iteration of concurrent restore job startup.
> 
> Please, update the test and revamp.

I pushed the commit already when you wrote "LGTM" in your first reply,
sorry. Yet to cover for the above, I just submitted a patch which adds a
bit of documentation to the test case (apart from improving its
effectiveness).

Cheers, Phil
