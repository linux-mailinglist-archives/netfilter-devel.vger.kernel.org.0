Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3AEE5187C
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Jun 2019 18:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfFXQYJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Jun 2019 12:24:09 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:51378 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfFXQYJ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:24:09 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hfRlG-0002vh-Vb; Mon, 24 Jun 2019 18:24:07 +0200
Date:   Mon, 24 Jun 2019 18:24:06 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] files: Move netdev-ingress.nft to /etc/nftables as
 well
Message-ID: <20190624162406.GB9218@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190624151238.4869-1-phil@nwl.cc>
 <20190624151446.2umdf4bzem4h7yqj@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624151446.2umdf4bzem4h7yqj@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Florian,

On Mon, Jun 24, 2019 at 05:14:46PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > Commit 13535a3b40b62 ("files: restore base table skeletons") moved
> > config skeletons back from examples/ to /etc/nftables/ directory, but
> > ignored the fact that commit 6c9230e79339c ("nftables: rearrange files
> > and examples") added a new file 'netdev-ingress.nft' which is referenced
> > from 'all-in-one.nft' as well.
> 
> Right.  Do you think we should also add in inet-nat.nft example,
> or even replace the ipvX- ones?

Having an inet family nat example would be wonderful! Can inet NAT
replace IPvX-ones completely or are there any limitations as to what is
possible in rules?

Cheers, Phil
