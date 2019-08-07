Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056F185689
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Aug 2019 01:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbfHGXhu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 7 Aug 2019 19:37:50 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:56872 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389507AbfHGXht (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:37:49 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hvVV6-0004pM-Eg; Thu, 08 Aug 2019 01:37:48 +0200
Date:   Thu, 8 Aug 2019 01:37:48 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH RFC nft] src: avoid re-initing core library when a second
 context struct is allocated
Message-ID: <20190807233748.qeajgrl3iokeywkx@breakpoint.cc>
References: <20190805214917.13747-1-fw@strlen.de>
 <20190807224125.ysj5qyw3xxgdouc4@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807224125.ysj5qyw3xxgdouc4@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Mon, Aug 05, 2019 at 11:49:17PM +0200, Florian Westphal wrote:
> > Calling nft_ctx_new() a second time leaks memory, and calling
> > nft_ctx_free a second time -- on a different context -- causes
> > double-free.
> > 
> > This patch won't work in case we assume libnftables should be
> > thread-safe, in such case we either need a mutex or move all resources
> > under nft_ctx scope.
> 
> These two should avoid the memleak / double free I think:
> 
> https://patchwork.ozlabs.org/patch/1143742/
> https://patchwork.ozlabs.org/patch/1143743/

Thanks, I will give them a try.

> Not thread-safe yet, there is a bunch global variables still in place.

I don't need thread-safety at the moment, I just found this double-free
crash when creating another nft_ctx inside nftables (don't ask why, its
fugly...)
