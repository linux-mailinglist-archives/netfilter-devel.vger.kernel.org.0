Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F976629F1D
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Nov 2022 17:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKOQeC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Nov 2022 11:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiKOQeB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:34:01 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4877DB7F4
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Nov 2022 08:33:58 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1ouysl-0001ZS-Q7
        for netfilter-devel@vger.kernel.org; Tue, 15 Nov 2022 17:33:55 +0100
Date:   Tue, 15 Nov 2022 17:33:55 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 0/7] De-duplicate code here and there
Message-ID: <Y3O/c2ynclNc98Gx@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
References: <20221112002056.31917-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112002056.31917-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Nov 12, 2022 at 01:20:49AM +0100, Phil Sutter wrote:
> A series of unrelated patches reducing code size in different ways:
> 
> Patch 1 is a typical "move function to xshared.c for common use", patch
> 2 eliminates some c'n'p programming in nft-shared.c, patch 3 merges
> libipt_LOG.c and libip6t_LOG.c, patch 4 removes code from libebt_ip.c by
> including the right header, patch 5 drops some local IP address parsers
> in favor of the respective libxtables function and patches 6 and 7 move
> duplicate definitions and code into a header shared by multiple
> extensions.
> 
> Phil Sutter (7):
>   xshared: Share make_delete_mask() between ip{,6}tables
>   nft-shared: Introduce port_match_single_to_range()
>   extensions: libip*t_LOG: Merge extensions
>   extensions: libebt_ip: Include kernel header
>   extensions: libebt_arp, libebt_ip: Use xtables_ipparse_any()
>   extensions: Collate ICMP types/codes in libxt_icmp.h
>   extensions: Unify ICMP parser into libxt_icmp.h

Series applied.
