Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A047CB486
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Oct 2023 22:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjJPUVD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Oct 2023 16:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJPUVD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:21:03 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1BA83
        for <netfilter-devel@vger.kernel.org>; Mon, 16 Oct 2023 13:20:59 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qsU5B-0002mU-ER; Mon, 16 Oct 2023 22:20:57 +0200
Date:   Mon, 16 Oct 2023 22:20:57 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 1/3] tests/shell: skip "table_onoff" test if kernel
 patch is missing
Message-ID: <ZS2bKZVAN5d5dax-@strlen.de>
References: <20231016131209.1127298-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016131209.1127298-1-thaller@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Thomas Haller <thaller@redhat.com> wrote:
> Passing the test suite must not require latest kernel patches.  If test
> "table_onoff" appears to not work due to a missing kernel patch, skip
> it.
> 
> If you run a special kernel and expect that all test pass, set
> NFT_TEST_FAIL_ON_SKIP=y to catch unexpected skips.

This makes the test suite and all feature probing moot for my use cases.
If I see SKIP, I assume that the feature is missing.

This is a bug, and it tells me that I might have to do something
about it.

If you absolutely cannot have a failure because of this, then
please add another error state for this, so that I can see that
something is wrong.

This is NOT the same as a skip because some distro kernel lacks
anonymous chain support.

That said, I would STRONLGY perfer failure here.
Distros will ship updates that eventually also include this bug fix.

This fix is included in 6.5.6 for example.
