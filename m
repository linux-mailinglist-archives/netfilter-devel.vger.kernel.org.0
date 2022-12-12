Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F5664A535
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Dec 2022 17:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiLLQpM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 12 Dec 2022 11:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiLLQoi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:44:38 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA75114D15
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Dec 2022 08:42:26 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1p4lsn-0002xS-1s; Mon, 12 Dec 2022 17:42:25 +0100
Date:   Mon, 12 Dec 2022 17:42:25 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 0/3] fix map update with concatenation and timeouts
Message-ID: <20221212164225.GB3457@breakpoint.cc>
References: <20221212100436.84116-1-fw@strlen.de>
 <Y5cuyyDLt6SD0QXk@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5cuyyDLt6SD0QXk@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Mon, Dec 12, 2022 at 11:04:33AM +0100, Florian Westphal wrote:
> > When "update" is used with a map, nft will ignore a given timeout.
> > Futhermore, listing is broken, only the first data expression
> > gets decoded:
> > 
> > in:
> >  meta l4proto tcp update @pinned { ip saddr . ct original proto-src : ip daddr . ct original proto-dst timeout 90s }
> > out:
> >  meta l4proto tcp update @pinned { ip saddr . ct original proto-src : ip daddr }
> > 
> > Missing timeout is input bug (never passed to kernel), mussing
> > "proto-dst" is output bug.
> > 
> > Also add a test case.
> 
> Series LGTM, thanks.
> 
> I might follow up to restrict the timeout to the key side unless you
> would like to look into this.

I've pushed this series out; I fixed the typo in patch 1 and I
mangled patch 2 to reject data-element timeouts from the eval phase.
