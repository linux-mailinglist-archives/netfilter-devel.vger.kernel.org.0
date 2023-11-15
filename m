Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB297EBEE2
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Nov 2023 09:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjKOIw6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Nov 2023 03:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343555AbjKOIw4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Nov 2023 03:52:56 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6442A12F
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Nov 2023 00:52:50 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1r3Bdg-0005pu-H4; Wed, 15 Nov 2023 09:52:48 +0100
Date:   Wed, 15 Nov 2023 09:52:48 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Thomas Haller <thaller@redhat.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 1/2] utils: add memory_allocation_check() helper
Message-ID: <20231115085248.GD14621@breakpoint.cc>
References: <20231108182431.4005745-1-thaller@redhat.com>
 <ZUz5mWjHQjXkU6If@calendula>
 <2c3a28999adc1fa22b9b822bdae5ab79817957fa.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c3a28999adc1fa22b9b822bdae5ab79817957fa.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Thomas Haller <thaller@redhat.com> wrote:
> static inline void *__memory_allocation_check(const char *file, unsigned line, const void *ptr) {
>     if (!ptr)
>         __memory_allocation_error(file, line);
>     return (void*) ptr;
> }
> 
> #define memory_allocation_check(cmd) \
>    ((typeof(cmd) __memory_allocation_check(__FILE__, __LINE__, (cmd))
> 
> Doesn't seem to make a difference either way.

We seem to be moving in circles.

I suspect your agenda is to avoid repeating the existing

x = alloc()
if (!x)
  barf()

pattern when adding userhandle support?

If so I think its best to just add a specific ubuf alloc wrapper that
can't fail (i.e. like the 'xmalloc' wrappers).

Like Pablo said, I don't see any added value in providing FILE/LINE
errors on stderr here.  It could be as simple as exit().

