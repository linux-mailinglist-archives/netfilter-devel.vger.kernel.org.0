Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CB0647AF1
	for <lists+netfilter-devel@lfdr.de>; Fri,  9 Dec 2022 01:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLIAsM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Dec 2022 19:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLIAsL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:48:11 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26509A4338
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Dec 2022 16:48:10 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1p3RYc-0003Cb-26; Fri, 09 Dec 2022 01:48:06 +0100
Date:   Fri, 9 Dec 2022 01:48:06 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Jan Engelhardt <jengelh@inai.de>
Subject: Re: [libmnl PATCH] Makefile: Create LZMA-compressed dist-files
Message-ID: <Y5KFxjpByL+lwVtN@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Jan Engelhardt <jengelh@inai.de>
References: <20221208001339.21578-1-phil@nwl.cc>
 <Y5JJFyZSW9OhYuUl@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5JJFyZSW9OhYuUl@salvia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Dec 08, 2022 at 09:29:11PM +0100, Pablo Neira Ayuso wrote:
> Hi Phil
> 
> On Thu, Dec 08, 2022 at 01:13:39AM +0100, Phil Sutter wrote:
> > Use a more modern alternative to bzip2.
> 
> I tested this one for libmnl specifically and it works fine with `make
> distcheck`. I can quickly update the release script here to refer to
> tar.xz instead of tar.bz2.
> 
> I have seen other projects offering both .tar.bz2 and .tar.xz, the
> reason for this for me is unknown, I guess using .tar.xz should be
> fine for everyone?

Maybe cruft from a time when LZMA support in tar was new. Maybe also
people whining about failing distfile downloads.

Just for the record, one may easily configure automake to create
multiple archives with different compressions from the same 'make dist'
command.

> Please go ahead push out these patches, thanks.

Will do, thanks!

Cheers, Phil
