Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950D769F407
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Feb 2023 13:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjBVMIG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Feb 2023 07:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBVMIF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:08:05 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2AC3A853
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Feb 2023 04:07:19 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1pUntz-0001xK-MO; Wed, 22 Feb 2023 13:07:15 +0100
Date:   Wed, 22 Feb 2023 13:07:15 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Thomas Devoogdt <thomas@devoogdt.com>,
        netfilter-devel@vger.kernel.org,
        Thomas Devoogdt <thomas.devoogdt@barco.com>
Subject: Re: [PATCH] [iptables] extensions: libxt_LOG.c: fix
 linux/netfilter/xt_LOG.h include on Linux < 3.4
Message-ID: <Y/YFcwp/gyZY5Pmw@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Thomas Devoogdt <thomas@devoogdt.com>,
        netfilter-devel@vger.kernel.org,
        Thomas Devoogdt <thomas.devoogdt@barco.com>
References: <20230222072349.509917-1-thomas.devoogdt@barco.com>
 <Y/XouZlrtw/SN/C2@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/XouZlrtw/SN/C2@salvia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 22, 2023 at 11:04:41AM +0100, Pablo Neira Ayuso wrote:
> On Wed, Feb 22, 2023 at 08:23:49AM +0100, Thomas Devoogdt wrote:
> > libxt_LOG.c:6:10: fatal error: linux/netfilter/xt_LOG.h: No such file or directory
> > . #include <linux/netfilter/xt_LOG.h>
> >           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Linux < 3.4 defines are in include/linux/netfilter_ipv{4,6}/ipt_LOG.h,
> > but the naming is slightly different, so just define it here as the values are the same.
> > 
> > https://github.com/torvalds/linux/commit/6939c33a757bd006c5e0b8b5fd429fc587a4d0f4
> 
> Probably you could add xt_LOG.h to iptables/include/linux/netfilter/ ?
> 
> There are plenty of headers that are cached there to make sure
> userspace compile with minimal external dependencies.
> 
> xt_LOG.h is missing for some reason in that folder, but there are many
> of xt_*.h files there.

While being at it, how about caching all netfilter kernel headers we
include? The only downside I see is that we may have to update them from
time to time (in case new symbols land) but that's rare and the
alternative is accidental breakages like above.

WDYT? I'd volunteer to do it. :)

Cheers, Phil
