Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DCB6477DD
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Dec 2022 22:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLHVVn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Dec 2022 16:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLHVVm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:21:42 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 590937285C
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Dec 2022 13:21:41 -0800 (PST)
Date:   Thu, 8 Dec 2022 22:21:37 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Eric Garver <eric@garver.life>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 2/2,v2] netlink: swap byteorder of value component in
 concatenation of intervals
Message-ID: <Y5JVYeGYBQPlvoph@salvia>
References: <20221208004028.420544-1-pablo@netfilter.org>
 <Y5FGRE4J+AOcgMvM@wsfd-netdev-vmhost.ntdv.lab.eng.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5FGRE4J+AOcgMvM@wsfd-netdev-vmhost.ntdv.lab.eng.bos.redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Dec 07, 2022 at 09:04:52PM -0500, Eric Garver wrote:
> On Thu, Dec 08, 2022 at 01:40:28AM +0100, Pablo Neira Ayuso wrote:
> > Commit 1017d323cafa ("src: support for selectors with different byteorder with
> > interval concatenations") was incomplete.
> > 
> > Switch byteorder of singleton values in a set that contains
> > concatenation of intervals. This singleton value is actually represented
> > as a range in the kernel.
> > 
> > After this patch, if the set represents a concatenation of intervals:
> > 
> > - EXPR_F_INTERVAL denotes the lhs of the interval.
> > - EXPR_F_INTERVAL_END denotes the rhs of the interval (this flag was
> >   already used in this way before this patch).
> > 
> > If none of these flags are set on, then the set contains concatenation
> > of singleton values (no interval flag is set on), in such case, no
> > byteorder swap is required.
> > 
> > Update tests/shell and tests/py to cover the use-case breakage reported
> > by Eric.
> > 
> > Reported-by: Eric Garver <eric@garver.life>
> > Fixes: 1017d323cafa ("src: support for selectors with different byteorder with interval concatenations")
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> 
> Thanks Pablo!
> 
> Tested-by: Eric Garver <eric@garver.life>

Thanks, I have pushed out this with a few more patches.
