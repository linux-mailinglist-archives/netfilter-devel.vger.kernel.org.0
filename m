Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F52D64A12B
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Dec 2022 14:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiLLNgT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 12 Dec 2022 08:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiLLNfr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:35:47 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60B8A13F08
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Dec 2022 05:35:46 -0800 (PST)
Date:   Mon, 12 Dec 2022 14:35:43 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 2/3] netlink_linearize: fix timeout with map updates
Message-ID: <Y5cuL4og4dOOEEhY@salvia>
References: <20221212100436.84116-1-fw@strlen.de>
 <20221212100436.84116-3-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221212100436.84116-3-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Dec 12, 2022 at 11:04:35AM +0100, Florian Westphal wrote:
> Map updates can use timeouts, just like with sets, but the
> linearization step did not pass this info to the kernel.
> 
> meta l4proto tcp update @pinned { ip saddr . ct original proto-src : ip daddr . ct original proto-dst timeout 90s
> 
> Listing this won't show the "timeout 90s" because kernel never saw it to
> begin with.
> 
> NB: The above line attaches the timeout to the data element,
> but there are no separate timeouts for the key and the value.
> 
> An alternative is to reject "key : value timeout X" from the parser
> or evaluation step.

You mean, timeout is accepted both from key : value sides of the
mapping, right?

It makes more sense to restrict it to the key side, that would require
a follow up patch.

Thanks.
