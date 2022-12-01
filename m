Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA97663F003
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Dec 2022 12:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiLAL6a (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Dec 2022 06:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiLAL6a (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:58:30 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A99AA1C0A
        for <netfilter-devel@vger.kernel.org>; Thu,  1 Dec 2022 03:58:27 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1p0iCv-0000KF-T1; Thu, 01 Dec 2022 12:58:25 +0100
Date:   Thu, 1 Dec 2022 12:58:25 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptables-nft] extensions: add xt_statistics random mode
 translation
Message-ID: <Y4iW4R1tusL9PecX@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20221201101317.16818-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201101317.16818-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:13:17AM +0100, Florian Westphal wrote:
> Use meta random and bitops to replicate what xt_statistics
> is doing.

I didn't know about 'meta random', even though it's a bit older than
numgen. What's the difference to 'numgen random'? I'm asking because I
once tried to fix the same issue using the latter[1], it was never
applied, though.

Maybe you could reuse gcd_div() from my patch to reduce nominal values?

Cheers, Phil

[1] https://patchwork.ozlabs.org/project/netfilter-devel/patch/20170313160153.21120-1-phil@nwl.cc/
