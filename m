Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF06C7B311A
	for <lists+netfilter-devel@lfdr.de>; Fri, 29 Sep 2023 13:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjI2LMk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 29 Sep 2023 07:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjI2LMe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:12:34 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471BAB7
        for <netfilter-devel@vger.kernel.org>; Fri, 29 Sep 2023 04:12:32 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qmBQ6-0007yK-Ai; Fri, 29 Sep 2023 13:12:30 +0200
Date:   Fri, 29 Sep 2023 13:12:30 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [nf PATCH v2 7/8] netfilter: nf_tables: Pass reset bit in
 nft_set_dump_ctx
Message-ID: <ZRaxHlrhNsBBrLC6@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20230928165244.7168-1-phil@nwl.cc>
 <20230928165244.7168-8-phil@nwl.cc>
 <ZRXLlwkeCBWgXqGZ@calendula>
 <ZRaiEjg2g6UuLPpS@orbyte.nwl.cc>
 <ZRajtFQ1dtMokDUM@calendula>
 <ZRakdAbR39fS3thz@orbyte.nwl.cc>
 <ZRatT4q729r7MPBO@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRatT4q729r7MPBO@calendula>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:56:15PM +0200, Pablo Neira Ayuso wrote:
> On Fri, Sep 29, 2023 at 12:18:28PM +0200, Phil Sutter wrote:
> > On Fri, Sep 29, 2023 at 12:15:16PM +0200, Pablo Neira Ayuso wrote:
> > > On Fri, Sep 29, 2023 at 12:08:18PM +0200, Phil Sutter wrote:
> > > > On Thu, Sep 28, 2023 at 08:53:11PM +0200, Pablo Neira Ayuso wrote:
> > > > > On Thu, Sep 28, 2023 at 06:52:43PM +0200, Phil Sutter wrote:
> > > > > > Relieve the dump callback from having to check nlmsg_type upon each
> > > > > > call. Prep work for set element reset locking.
> > > > > 
> > > > > Maybe add this as a preparation patch first place in this series,
> > > > > rather making this cleanup at this late stage of the batch.
> > > > 
> > > > Sure, no problem. I extracted it from v1 of patch 8 and so they are
> > > > closely related.
> > > > 
> > > > Maybe I should split the series up in per-callback ones? I'd start with
> > > > the getsetelem_reset one as that is most cumbersome it seems.
> > > 
> > > Thanks.
> > > 
> > > Side note: I also read a comment from Florian regarding the use of
> > > ctx.table. You have to be very careful with what you cache in the dump
> > > context area, since such pointer might just go away.
> > > 
> > > So far this code caches was "careful" to cache only to check if the
> > > table was still there, but iterating over the table list again
> > > (another safer approach could be to use the table handle which is
> > > unique).
> > > 
> > > All this is also related to the chunked nature of netlink dumps
> > > (in other words, userspace retrieves part of it in every
> > > netlink_recvmsg() call).
> > 
> > Good point. I think we may reduce all this to 'strdup(table->name)' and
> > not care what happens in other CPUs. The only requirement is to cache
> > table->family for audit logging also (IIRC). I'll give this a try.
> 
> table handle is u64 and you don't need to clone, right? Handle
> allocation is monotonic.

The intention was to use it for audit logging as well which requires the
name (and family). Pulling anything that accesses the cached data into
the critical section is probably more straightforward.
