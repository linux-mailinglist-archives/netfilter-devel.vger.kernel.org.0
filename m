Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B334952BB08
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 May 2022 14:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiERM0I (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 May 2022 08:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiERM0H (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 May 2022 08:26:07 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C600B11837
        for <netfilter-devel@vger.kernel.org>; Wed, 18 May 2022 05:26:05 -0700 (PDT)
Date:   Wed, 18 May 2022 14:26:02 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: nf_tables: restrict expression reduction to
 first expression
Message-ID: <YoTl2oM6xiRg2/N8@salvia>
References: <20220518100842.1950-1-pablo@netfilter.org>
 <YoTPlIBany/aRvtK@orbyte.nwl.cc>
 <YoTSHls/on1S+/4N@salvia>
 <YoTbJTDxuQ131EDG@orbyte.nwl.cc>
 <20220518114807.GE4316@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220518114807.GE4316@breakpoint.cc>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 18, 2022 at 01:48:07PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > > > | reduce = reduce && expr->ops->type->reduce;
> > > 
> > > Could you elaborate?
> > 
> > Well, an expression which may set verdict register to NFT_BREAK should
> > prevent reduction of later expressions in same rule as it may stop rule
> > evaluation at run-time. This is obvious for nft_cmp, but nft_meta is
> > also a candidate: NFT_META_IFTYPE causes NFT_BREAK if pkt->skb->dev is
> > NULL. The optimizer must not assume later expressions are evaluated.
> 
> This all seems fragile to me, with huge potential to add subtle bugs
> that will be hard to track down.

We can expose flags to indicate that an expression is reduced and
expressions that are prefetched.

New test infrastructure will help to catch bugs, more selftests and
userspace validation of bytecode through exposed flags.

It would be good not to re-fetch data into register that is already
there.
