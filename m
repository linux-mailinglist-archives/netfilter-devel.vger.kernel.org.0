Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E8B5670E
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jun 2019 12:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfFZKm5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Jun 2019 06:42:57 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:40012 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbfFZKm5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:42:57 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hg5OA-0001J5-TA; Wed, 26 Jun 2019 12:42:54 +0200
Date:   Wed, 26 Jun 2019 12:42:54 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
Subject: Re: Use of oifname in input chains
Message-ID: <20190626104254.cfhkfpagequp6kuv@breakpoint.cc>
References: <20190625122954.GC9218@orbyte.nwl.cc>
 <20190625194321.e2siqh7jfhldwzgw@salvia>
 <20190626103230.b7eqh2i3ibpkfv52@breakpoint.cc>
 <20190626103746.ag26jczoq7ggkh5b@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626103746.ag26jczoq7ggkh5b@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > new chain C
> > meta oifname bla added to C
> > jump added from output to C
> > jump added from input to C   # should this fail? why?
> > 
> > new chain C
> > jump added from input to C
> > meta oifname added to C	     # same q: why should this fail?
> 
> There's tracking infrastructure for this already in place, right? It's
> just a matter to check for this from nft_meta_get_validate().

But what semantics would you add?
It seems it would 100% break existing rulesets.

new chain C
jump added from ouput to C
meta oifname added to C	   	# allowed? jump from output exists
jump added from input to C	# disallow this? Why?

..
delete jump from output		# disallow?

This seems rather suicidal to me.
