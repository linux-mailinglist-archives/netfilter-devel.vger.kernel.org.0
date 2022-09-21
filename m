Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63D55E547B
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Sep 2022 22:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiIUU1E (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Sep 2022 16:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiIUU1D (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:27:03 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8A3792EE
        for <netfilter-devel@vger.kernel.org>; Wed, 21 Sep 2022 13:27:01 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ob6J9-0001HQ-4x; Wed, 21 Sep 2022 22:26:59 +0200
Date:   Wed, 21 Sep 2022 22:26:59 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Florian Westphal <fw@strlen.de>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 2/2] segtree: fix decomposition of unclosed intervals
 containing address prefixes
Message-ID: <20220921202659.GA30050@breakpoint.cc>
References: <20220918172212.3681553-1-jeremy@azazel.net>
 <20220918172212.3681553-3-jeremy@azazel.net>
 <Yyr6C+IKMrCM0hQJ@strlen.de>
 <YytqB90MypDn7gHr@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YytqB90MypDn7gHr@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jeremy Sowden <jeremy@azazel.net> wrote:
> > __interceptor_malloc libsanitizer/asan/asan_malloc_linux.cpp:145
> > xmalloc src/utils.c:36
> > xzalloc src/utils.c:75
> > expr_alloc src/expression.c:46
> > constant_expr_alloc src/expression.c:420
> > interval_map_decompose src/segtree.c:619
> 
> I did try running the new shell test under valgrind: lots of noise, not
> a lot of signal. :)

Yes.  You can use -fsanitize=leak as alternative, that has a much better
signal/noise ratio.

> > Before, 'i' was assigned to the compund expr, but thats no longer the
> > case.
> 
> > Does this look good to you?
> 
> Yes, LTGM.

Applied, thanks!
