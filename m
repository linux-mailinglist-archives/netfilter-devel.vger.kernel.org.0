Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA48362F472
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Nov 2022 13:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241541AbiKRMSu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Nov 2022 07:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241487AbiKRMSr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:18:47 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41ADF6154
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Nov 2022 04:18:47 -0800 (PST)
Date:   Fri, 18 Nov 2022 13:18:44 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2 0/4] xt: Implement dump and restore support
Message-ID: <Y3d4JEmztrNTbK99@salvia>
References: <20221117174546.21715-1-phil@nwl.cc>
 <20221117211347.GB15714@breakpoint.cc>
 <Y3dUxJZ6J4mg/KNh@orbyte.nwl.cc>
 <Y3daXmuU0Nsyeij6@salvia>
 <Y3dhhVpfoA73W3kA@orbyte.nwl.cc>
 <20221118114643.GD15714@breakpoint.cc>
 <Y3d2qqm2r8Z8Tbih@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3d2qqm2r8Z8Tbih@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Nov 18, 2022 at 01:12:26PM +0100, Phil Sutter wrote:
> On Fri, Nov 18, 2022 at 12:46:43PM +0100, Florian Westphal wrote:
> > Phil Sutter <phil@nwl.cc> wrote:
> > > On Fri, Nov 18, 2022 at 11:11:42AM +0100, Pablo Neira Ayuso wrote:
> > > > Merging threads.
> > > > 
> > > > On Fri, Nov 18, 2022 at 10:55:04AM +0100, Phil Sutter wrote:
> > > > [...]
> > > > > > I think this more or less a summary of what we discussed in the NFWS.
> > > > >
> > > > > Pablo, I think you're mixing up two things here:
> > > > >
> > > > > This "support dump and load of compat expression" feature is to sanitize
> > > > > the current situation with up to date iptables and nftables.
> > > > 
> > > > OK, then the problem we discuss is mixing iptables-nft and nftables.
> > > > 
> > > > On Fri, Nov 18, 2022 at 10:47:48AM +0100, Phil Sutter wrote:
> > > > [...]
> > > > > > At this time I'd rather like a time machine to prevent nft_compat.c from
> > > > > > getting merged :-(
> > > > >
> > > > > If you do, please convince Pablo to not push iptables commit 384958620a.
> > > > > I think it opened the can of worms we're trying to confine here.
> > > > 
> > > > It could be worst, if iptables-nft would not be in place, then old
> > > > iptables-legacy and new nftables rules would have no visibility each
> > > > other.
> > > > 
> > > > With iptables-nft we have a way to move forward:
> > > > 
> > > > - Replace nft_compat by native expressions from iptables-nft.
> > > > - Extend iptables-nft to understand more complex expressions, worst
> > > >   case dump a native representation.
> > > > 
> > > > Why don't we just move ahead this path instead of spinning around the
> > > > compat layer? This only requires userspace updates on iptables-nft.
> > > 
> > > Sure! I'm just picking low hanging fruits first. With even translation
> > > support being still incomplete, I fear it will take a while until the
> > > tools are fluent enough for this to not matter anymore. And then there's
> > > still nftables without libxtables support.
> > 
> > Then perhaps its better to do following path:
> > 1. Try ->xlate(), if that fails, then print a 'breaking' format?
> > 
> > As far as I understand the problem is the "# comment" - type syntax that
> > makes nft just skip the incomplete rule, so perhaps just use invalid
> > format?
> > 
> > Example:
> > 
> > counter packets 0 bytes 0 # name foo interval 250.0ms ewmalog 500.0ms
> > Instead make this something like
> > counter packets 0 bytes 0 nft_compat [ RATEEST name foo interval 250.0ms ewmalog 500.0ms ] # unsupported iptables-nft rule
> > 
> > ?
> > 
> > I'd like to avoid exposure in the frontend with compatible-restore-approach if possible.
> 
> Yes, that's fine with me. Now what about translated expressions? Can we
> apply my warning patch until at least the majority of them is understood
> by iptables?

Which one are you refering to?
