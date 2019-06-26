Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 381AC56742
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jun 2019 12:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfFZK6P (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Jun 2019 06:58:15 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:40074 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbfFZK6P (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:58:15 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hg5cy-0001Ng-Eq; Wed, 26 Jun 2019 12:58:12 +0200
Date:   Wed, 26 Jun 2019 12:58:12 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
Subject: Re: Use of oifname in input chains
Message-ID: <20190626105812.kkq6bfdcoihmphrd@breakpoint.cc>
References: <20190625122954.GC9218@orbyte.nwl.cc>
 <20190625194321.e2siqh7jfhldwzgw@salvia>
 <20190626103230.b7eqh2i3ibpkfv52@breakpoint.cc>
 <20190626103746.ag26jczoq7ggkh5b@salvia>
 <20190626104254.cfhkfpagequp6kuv@breakpoint.cc>
 <20190626104740.vw7xzrkoqd2lwzqh@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626104740.vw7xzrkoqd2lwzqh@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > delete jump from output		# disallow?
> > 
> > This seems rather suicidal to me.
> 
> OK, you think there may be people using oifname from the C chain, but
> how so? To skip rules that are specific to the output path?

Maybe, or just to consolidate rules, e.g.

chain C {
	[ some common rules ]
	meta oifname bla ...
	[ other common rules ]
}

After the proposed change, kernel refuses ruleset as soon as C is
or becomes reachable from a prerouting/input basechain.

(Alternatively, we could reject if not reachable from output/forward,
 but that seems even more crazy because we'd have to refuse ruleset
 that has unreachable chain with 'oifname' in it ...).
