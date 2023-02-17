Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4905969B285
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Feb 2023 19:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBQSsz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 Feb 2023 13:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBQSsy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:48:54 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8141C54D64
        for <netfilter-devel@vger.kernel.org>; Fri, 17 Feb 2023 10:48:52 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1pT5ms-0005dU-VA
        for netfilter-devel@vger.kernel.org; Fri, 17 Feb 2023 19:48:50 +0100
Date:   Fri, 17 Feb 2023 19:48:50 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 1/3] nft-shared: Lookup matches in
 iptables_command_state
Message-ID: <Y+/MElxbQcrX3cU+@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
References: <20230217134600.14433-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217134600.14433-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 17, 2023 at 02:45:58PM +0100, Phil Sutter wrote:
> Some matches may turn into multiple nft statements (naturally or via
> translation). Such statements must parse into a single extension again
> in order to rebuild the rule as it was.
> 
> Introduce nft_find_match_in_cs() to iterate through the lists and drop
> tcp/udp port match caching in struct nft_xt_ctx which is not needed
> anymore.
> 
> Note: Match reuse is not enabled unconditionally for all matches,
> because iptables supports having multiple instances of the same
> extension.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Series applied.
