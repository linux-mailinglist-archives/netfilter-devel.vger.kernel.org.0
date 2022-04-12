Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D474FEAEC
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Apr 2022 01:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiDLXpV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Apr 2022 19:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiDLXpO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:45:14 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EB813E86
        for <netfilter-devel@vger.kernel.org>; Tue, 12 Apr 2022 16:30:27 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nePxn-0003FP-BT; Wed, 13 Apr 2022 01:30:24 +0200
Date:   Wed, 13 Apr 2022 01:30:23 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables 0/9] nftables: add support for wildcard string
 as set keys
Message-ID: <20220412233023.GF10279@breakpoint.cc>
References: <20220409135832.17401-1-fw@strlen.de>
 <YlX6gfgq4SFPTU+B@salvia>
 <20220412224335.GB10279@breakpoint.cc>
 <YlYGXSrxnspdBzr5@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlYGXSrxnspdBzr5@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > Yes, but its like this also before my patch, there are several
> > test failures on s390 with nft master.
> 
> Why is the listing being reordered?

No idea, I only saw that this reordering happens, i did not have time to
investigate so far.

> > I will have a look, so far I only checked that my patch
> > series does not cause any additional test failures, and the only
> > reason why the new test fails is the output reorder on s390.
> 
> This is also related to the set description patchset that Phil posted,
> correct?

No, I don't even know what patchset you are talking about.
Is it because of failing pything tests because the debug output has
endianess issues?  If so, not related.

> If you consider that adding remaining features is feasible,
> incrementally should be fine.

Hmm, if there is a technical reason as to why it does not work,
do you think we should hold it back?

It lookes like filter on "{ eth0, ppp* }" works fine as-is.

I thought that something like "eth0-eth42" would also be doable,
by treating both as 128bit bit-string.

Don't see what prevents "ppp* . 80" from working from a technical pov.

So, I *think* its fine to add the pure ifname set support now and
add the rest incrementally.
