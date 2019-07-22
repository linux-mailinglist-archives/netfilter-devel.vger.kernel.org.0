Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 388BA6FF59
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jul 2019 14:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfGVMQh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Jul 2019 08:16:37 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:53074 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbfGVMQh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:16:37 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hpXF5-0002Tt-EE; Mon, 22 Jul 2019 14:16:35 +0200
Date:   Mon, 22 Jul 2019 14:16:35 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
        phil@nwl.cc
Subject: Re: [PATCH nft] doc: fib: explain example in more detail
Message-ID: <20190722121635.m2jbh7rx34mvxrgg@breakpoint.cc>
References: <20190721104305.29594-1-fw@strlen.de>
 <20190721184212.2fxviqkcil27wzqp@salvia>
 <20190721185432.o2wke7wecfdbyzfr@breakpoint.cc>
 <20190722115803.a6vjrirc3gxgqc2d@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722115803.a6vjrirc3gxgqc2d@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Sun, Jul 21, 2019 at 08:54:32PM +0200, Florian Westphal wrote:
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > Cc'ing Phil.
> > > 
> > > On Sun, Jul 21, 2019 at 12:43:05PM +0200, Florian Westphal wrote:
> > > > As noted by Felix Dreissig, fib documentation is quite terse, so explain
> > > > the 'saddr . iif' example with a few more words.
> > > 
> > > There are patches to disallow ifindex 0 from Phil
> > 
> > WHich ones?
> 
> https://patchwork.ozlabs.org/patch/1133521/

This is insane. "nft meta iif 0 counter" seems totally fine to me.

I think we should never try to be clever here.
