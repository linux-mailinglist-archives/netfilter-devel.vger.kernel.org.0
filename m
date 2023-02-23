Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024956A0473
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Feb 2023 10:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjBWJG3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Feb 2023 04:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBWJG2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:06:28 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FE041EFF2
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Feb 2023 01:06:28 -0800 (PST)
Date:   Thu, 23 Feb 2023 10:06:25 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
        netfilter-devel@vger.kernel.org
Subject: Re: [RFC nf-next PATCH] netfilter: nft: introduce broute chain type
Message-ID: <Y/cskVbQI6GQ5XEq@salvia>
References: <20230222110337.15951-1-sriram.yagnaraman@est.tech>
 <20230222113731.GE12484@breakpoint.cc>
 <20230222114901.GF12484@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230222114901.GF12484@breakpoint.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 22, 2023 at 12:49:01PM +0100, Florian Westphal wrote:
> Florian Westphal <fw@strlen.de> wrote:
> > The br_netfilter_broute flag is required, but I don't like a new chain
> > type for this, nor keeping the drop/accept override.
> > 
> > I'd add a new "broute" expression that sets the flag in the skb cb
> > and sets NF_ACCEPT, useable in bridge family -- I think that this would
> > be much more readable.
> 
> Or, even simpler, extend nft_meta_bridge.c and extend nft userspace to
> support:
> 
>   nft ... meta broute set 1 accept
> 
> We also support nftrace this way, so there is precedence for it.

Sriram, this would be better than the new chain. I prefer Florian's proposal.
