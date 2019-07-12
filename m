Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4AD671A6
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jul 2019 16:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfGLOtc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 12 Jul 2019 10:49:32 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:42342 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbfGLOtc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:49:32 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hlwra-0006Ao-Hw; Fri, 12 Jul 2019 16:49:30 +0200
Date:   Fri, 12 Jul 2019 16:49:30 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] src/ct: provide fixed data lengh sizes for ip/ip6
 keys
Message-ID: <20190712144930.ttfbadccvedfvhau@breakpoint.cc>
References: <20190712103503.22825-1-fw@strlen.de>
 <20190712104224.fodcfgcivxst46jj@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712104224.fodcfgcivxst46jj@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Fri, Jul 12, 2019 at 12:35:03PM +0200, Florian Westphal wrote:
> > nft can load but not list this:
> > 
> > table inet filter {
> >  chain input {
> >   ct original ip daddr {1.2.3.4} accept
> >  }
> > }
> > 
> > Problem is that the ct template length is 0, so we believe the right hand
> > side is a concatenation because left->len < set->key->len is true.
> > nft then calls abort() during concatenation parsing.
> > 
> > Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1222
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Please, add new entry to tests/py before pushing this out.

Will do.
