Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C3860650
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jul 2019 15:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfGENEe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 5 Jul 2019 09:04:34 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:51094 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfGENEe (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:04:34 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hjNtA-0003nM-Iu; Fri, 05 Jul 2019 15:04:32 +0200
Date:   Fri, 5 Jul 2019 15:04:32 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, anon.amish@gmail.com
Subject: Re: [nft PATCH v2] evaluate: Accept ranges of N-N
Message-ID: <20190705130432.GE1628@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, anon.amish@gmail.com
References: <20190705121505.26466-1-phil@nwl.cc>
 <20190705125847.toc2sba27pcqywpo@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705125847.toc2sba27pcqywpo@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 05, 2019 at 02:58:47PM +0200, Pablo Neira Ayuso wrote:
> On Fri, Jul 05, 2019 at 02:15:05PM +0200, Phil Sutter wrote:
> > Trying to add a range of size 1 was previously not allowed:
> > 
> > | # nft add element ip t s '{ 40-40 }'
> > | Error: Range has zero or negative size
> > | add element ip t s { 40-40 }
> > |                      ^^^^^
> > 
> > The error message is not correct: If a range 40-41 is of size 2 (it
> > contains elements 40 and 41), a range 40-40 must be of size 1.
> > 
> > Handling this is even supported already: If a single element is added to
> > an interval set, it is converted into just this range. The implication
> > is that on output, previous input of '40-40' is indistinguishable from
> > single element input '40'.
> 
> What kind of human is going to generate such range? :-)

According to the ticket, some scripts do. :)

> I think we can place this item in the "nft ruleset optimization"
> discussion during the NFWS.

Sure, I'll add a note to the proposal.

Thanks, Phil
