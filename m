Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DCC69F58F
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Feb 2023 14:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjBVNdG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Feb 2023 08:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjBVNdF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:33:05 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C72C938EB4
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Feb 2023 05:32:13 -0800 (PST)
Date:   Wed, 22 Feb 2023 14:30:51 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, Thomas Devoogdt <thomas@devoogdt.com>,
        netfilter-devel@vger.kernel.org,
        Thomas Devoogdt <thomas.devoogdt@barco.com>
Subject: Re: [PATCH] [iptables] extensions: libxt_LOG.c: fix
 linux/netfilter/xt_LOG.h include on Linux < 3.4
Message-ID: <Y/YZC1Feu9gOCdWF@salvia>
References: <20230222072349.509917-1-thomas.devoogdt@barco.com>
 <Y/XouZlrtw/SN/C2@salvia>
 <Y/YFcwp/gyZY5Pmw@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/YFcwp/gyZY5Pmw@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 22, 2023 at 01:07:15PM +0100, Phil Sutter wrote:
> On Wed, Feb 22, 2023 at 11:04:41AM +0100, Pablo Neira Ayuso wrote:
> > On Wed, Feb 22, 2023 at 08:23:49AM +0100, Thomas Devoogdt wrote:
> > > libxt_LOG.c:6:10: fatal error: linux/netfilter/xt_LOG.h: No such file or directory
> > > . #include <linux/netfilter/xt_LOG.h>
> > >           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > Linux < 3.4 defines are in include/linux/netfilter_ipv{4,6}/ipt_LOG.h,
> > > but the naming is slightly different, so just define it here as the values are the same.
> > > 
> > > https://github.com/torvalds/linux/commit/6939c33a757bd006c5e0b8b5fd429fc587a4d0f4
> > 
> > Probably you could add xt_LOG.h to iptables/include/linux/netfilter/ ?
> > 
> > There are plenty of headers that are cached there to make sure
> > userspace compile with minimal external dependencies.
> > 
> > xt_LOG.h is missing for some reason in that folder, but there are many
> > of xt_*.h files there.
> 
> While being at it, how about caching all netfilter kernel headers we
> include? The only downside I see is that we may have to update them from
> time to time (in case new symbols land) but that's rare and the
> alternative is accidental breakages like above.

Caching _all_ dependencies is going to be hard, because it might pull
in lots of header files. The idea so far has been to find a reasonable
tradeoff, ensuring that iptables compilation is self-contained in a
best effort approach.

> WDYT? I'd volunteer to do it. :)

iptables already caches a lot of header files, as I said I don't
remember why this one has never been cached before.
