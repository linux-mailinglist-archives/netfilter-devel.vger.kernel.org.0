Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13CCFDC1C4
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Oct 2019 11:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442342AbfJRJu4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Oct 2019 05:50:56 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:43742 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442295AbfJRJuz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:50:55 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iLOuM-0002Ra-GC; Fri, 18 Oct 2019 11:50:54 +0200
Date:   Fri, 18 Oct 2019 11:50:54 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 3/8] xtables-restore: Introduce rule counter
 tokenizer function
Message-ID: <20191018095054.GC26123@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191017224836.8261-1-phil@nwl.cc>
 <20191017224836.8261-4-phil@nwl.cc>
 <20191018081124.obynzh3xbpo5k4gf@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018081124.obynzh3xbpo5k4gf@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Fri, Oct 18, 2019 at 10:11:24AM +0200, Pablo Neira Ayuso wrote:
> On Fri, Oct 18, 2019 at 12:48:31AM +0200, Phil Sutter wrote:
> > The same piece of code appears three times, introduce a function to take
> > care of tokenizing and error reporting.
> > 
> > Pass buffer pointer via reference so it can be updated to point to after
> > the counters (if found).
> > 
> > While being at it, drop pointless casting when passing pcnt/bcnt to
> > add_argv().
> > 
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> 
> Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> If you get to consolidate more common code between xml and native
> parsers, probably you can add a xtables-restore.c file to store all
> these functions are common, just an idea for the future.

I get the point, but we have xtables-restore.c already. Though it
contains *tables-nft-restore code. I would add to xshared.c until we
decide it's large enough to split (currently ~750 lines). AFAICT, this
is the only source file included in both xtables-*-multi binaries. Other
than that, I could extend libxtables to really share code but it's
probably not worth it.

Cheers, Phil
