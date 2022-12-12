Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1461164A2AA
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Dec 2022 14:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiLLN5M (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 12 Dec 2022 08:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiLLN46 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:56:58 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFACC71
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Dec 2022 05:56:55 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1p4jIb-0002Af-2N; Mon, 12 Dec 2022 14:56:53 +0100
Date:   Mon, 12 Dec 2022 14:56:53 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 2/3] netlink_linearize: fix timeout with map updates
Message-ID: <20221212135653.GA3457@breakpoint.cc>
References: <20221212100436.84116-1-fw@strlen.de>
 <20221212100436.84116-3-fw@strlen.de>
 <Y5cuL4og4dOOEEhY@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5cuL4og4dOOEEhY@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Mon, Dec 12, 2022 at 11:04:35AM +0100, Florian Westphal wrote:
> > Map updates can use timeouts, just like with sets, but the
> > linearization step did not pass this info to the kernel.
> > 
> > meta l4proto tcp update @pinned { ip saddr . ct original proto-src : ip daddr . ct original proto-dst timeout 90s
> > 
> > Listing this won't show the "timeout 90s" because kernel never saw it to
> > begin with.
> > 
> > NB: The above line attaches the timeout to the data element,
> > but there are no separate timeouts for the key and the value.
> > 
> > An alternative is to reject "key : value timeout X" from the parser
> > or evaluation step.
> 
> You mean, timeout is accepted both from key : value sides of the
> mapping, right?

Yes, exactly, you can even to

ip saddr timeout 1m : 0x42 timeout 1s

> It makes more sense to restrict it to the key side, that would require
> a follow up patch.

Ok, works for me, should be easy to do.
