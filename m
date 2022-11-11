Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D2E6260F3
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Nov 2022 19:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiKKSQY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Nov 2022 13:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiKKSQX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:16:23 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5DF532D8
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Nov 2022 10:16:22 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1otYZg-0006gQ-HF
        for netfilter-devel@vger.kernel.org; Fri, 11 Nov 2022 19:16:20 +0100
Date:   Fri, 11 Nov 2022 19:16:20 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 0/6] Merge NAT extensions
Message-ID: <Y26RdEvuSi6w/Bod@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
References: <20221103014113.10851-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103014113.10851-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 03, 2022 at 02:41:07AM +0100, Phil Sutter wrote:
> Besides the three different data structures in use to store different
> revisions' extensions data, the actual code is pretty similar in all the
> different NAT "flavors".
> 
> Patch 1 fixes a minor bug introduced by a previous commit. Patch 2
> eliminates some needless checks and some that seem not necessary.
> Patches 3 to 5 prepare DNAT extension code for the actual merge
> happening in patch 6.
> 
> Phil Sutter (6):
>   extensions: DNAT: Fix bad IP address error reporting
>   extensions: *NAT: Drop NF_NAT_RANGE_PROTO_RANDOM* flag checks
>   extensions: DNAT: Use __DNAT_xlate for REDIRECT, too
>   extensions: DNAT: Generate print, save and xlate callbacks
>   extensions: DNAT: Rename some symbols
>   extensions: Merge SNAT, DNAT, REDIRECT and MASQUERADE

Series applied.
