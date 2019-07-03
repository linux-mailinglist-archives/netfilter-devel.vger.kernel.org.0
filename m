Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97445E261
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jul 2019 12:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfGCK4D (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Jul 2019 06:56:03 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45812 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfGCK4D (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Jul 2019 06:56:03 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hicvg-0005vw-3e; Wed, 03 Jul 2019 12:56:00 +0200
Date:   Wed, 3 Jul 2019 12:56:00 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] files: Move netdev-ingress.nft to /etc/nftables as
 well
Message-ID: <20190703105600.GB31548@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20190624151238.4869-1-phil@nwl.cc>
 <20190624151446.2umdf4bzem4h7yqj@breakpoint.cc>
 <20190624162406.GB9218@orbyte.nwl.cc>
 <20190624164941.dhcm57r35km3azbg@breakpoint.cc>
 <20190625002404.63o7novb2ett2yoo@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625002404.63o7novb2ett2yoo@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 25, 2019 at 02:24:04AM +0200, Pablo Neira Ayuso wrote:
> On Mon, Jun 24, 2019 at 06:49:41PM +0200, Florian Westphal wrote:
> > Phil Sutter <phil@nwl.cc> wrote:
> > > > Right.  Do you think we should also add in inet-nat.nft example,
> > > > or even replace the ipvX- ones?
> > > 
> > > Having an inet family nat example would be wonderful! Can inet NAT
> > > replace IPvX-ones completely or are there any limitations as to what is
> > > possible in rules?
> > 
> > I'm not aware of any limitations.
> 
> Only limitation is that older kernels do not support NAT for the inet
> family.

OK, so maybe add inet NAT example but not delete ip/ip6 ones?

What is the status regarding my patch, please? I think fixing
netdev-ingress.nft location is unrelated to this discussion, right?

Cheers, Phil
