Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C888488E6
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Jun 2019 18:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfFQQ3W (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Jun 2019 12:29:22 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:33470 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbfFQQ3W (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:29:22 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hcuVU-00022r-CU; Mon, 17 Jun 2019 18:29:20 +0200
Date:   Mon, 17 Jun 2019 18:29:20 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH nft 2/5] tests: shell: cannot use handle for non-existing
 rule in kernel
Message-ID: <20190617162920.GU31548@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, fw@strlen.de
References: <20190617122518.10486-1-pablo@netfilter.org>
 <20190617122518.10486-2-pablo@netfilter.org>
 <20190617160030.GS31548@orbyte.nwl.cc>
 <20190617160657.qrl2vx5dn5zomk6l@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617160657.qrl2vx5dn5zomk6l@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Mon, Jun 17, 2019 at 06:06:57PM +0200, Pablo Neira Ayuso wrote:
> On Mon, Jun 17, 2019 at 06:00:30PM +0200, Phil Sutter wrote:
[...]
> > My initial implementation of intra-transaction rule references made
> > this handle guessing impossible, but your single point cache
> > fetching still allowed for it (hence why I dropped my patch with a
> > similar change).
> 
> Hm. I think we should not guess the handle that the kernel assigns.
> 
> In a batch, handles do not exist. We could expose the
> intra-transaction index if needed to the user. But I don't see a
> use-case for this.
> 
> I think we should leave the handle as a reference to already existing
> rules in the kernel.

Yes, it's an ugly hack that should never have worked in the first place,
I fully agree. Yet that it stops working indicates user space starts
doing more than it has to - IMHO relying upon the kernel verifier is
desirable. At least it allows for much better handling of large
rulesets.

Cheers, Phil
