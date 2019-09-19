Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91858B7712
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Sep 2019 12:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389008AbfISKDb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 Sep 2019 06:03:31 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:46466 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388905AbfISKDb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:03:31 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iAtHd-00045Y-92; Thu, 19 Sep 2019 12:03:29 +0200
Date:   Thu, 19 Sep 2019 12:03:29 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, Laura Garcia <nevola@gmail.com>,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: What is 'dynamic' set flag supposed to mean?
Message-ID: <20190919100329.GP6961@breakpoint.cc>
References: <20190918115325.GM6961@breakpoint.cc>
 <CAF90-WifdkWm5xu0utZqjoAtW9SW4JyFrVqyxf5EbD9vUZJucw@mail.gmail.com>
 <20190918144235.GN6961@breakpoint.cc>
 <20190919084321.2g2hzrcrtz4r6nex@salvia>
 <20190919092442.GO6961@breakpoint.cc>
 <20190919094055.4b2nd6aarjxi2bt6@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919094055.4b2nd6aarjxi2bt6@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > I can't remove the if () because that would make it possible to lookup
> > for meter-type sets.
> 
> Why is this a problem?

I was worried about this exposing expr pointers in the nft registers but
that won't happen (lookup expr doesn't care, only dynset will check for
attached expression coming from set).

I will send a patch to zap this check.
However, that still is a problem because that means "dynamic" can't
be used in kernels < 5.4 .

> I think we can just check instead from nft_lookup if there is an
> extension in this then, instead of checking for the NFT_SET_EVAL flag
> to fix this. Hence, you can make lookups on dynamic sets, but not on
> dynamic sets with extensions.

What do you mean?
