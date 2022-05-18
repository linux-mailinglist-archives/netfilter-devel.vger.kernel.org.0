Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A24652B825
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 May 2022 12:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbiERKvK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 May 2022 06:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiERKvJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 May 2022 06:51:09 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3CBB6
        for <netfilter-devel@vger.kernel.org>; Wed, 18 May 2022 03:51:04 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1nrHGe-0008Mt-Rd; Wed, 18 May 2022 12:51:00 +0200
Date:   Wed, 18 May 2022 12:51:00 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH] netfilter: nf_tables: restrict expression reduction to
 first expression
Message-ID: <YoTPlIBany/aRvtK@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, fw@strlen.de
References: <20220518100842.1950-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518100842.1950-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Wed, May 18, 2022 at 12:08:42PM +0200, Pablo Neira Ayuso wrote:
> Either userspace or kernelspace need to pre-fetch keys inconditionally
> before comparisons for this to work. Otherwise, register tracking data
> is misleading and it might result in reducing expressions which are not
> yet registers.
> 
> First expression is guaranteed to be evaluated always, therefore, keep
> tracking registers and restrict reduction to first expression.
> 
> Fixes: b2d306542ff9 ("netfilter: nf_tables: do not reduce read-only expressions")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
> @Phil, you mentioned about a way to simplify this patch, I don't see how,
> just let me know.

Not a big one. Instead of:

|	if (nft_expr_reduce(&track, expr)) {
|		if (reduce) {
|			reduce = false;
|			expr = track.cur;
|			continue;
|		}
|	} else if (reduce) {
|		reduce = false;
|	}

One could do:

|	if (nft_expr_reduce(&track, expr) && reduce) {
|		reduce = false;
|		expr = track.cur;
|		continue;
|	}
|	reduce = false;

Regarding later pre-fetching, one should distinguish between expressions
that (may) set verdict register and those that don't. There are pitfalls
though, e.g. error conditions handled that way.

Maybe introduce a new nft_expr_type field and set reduce like so:

| reduce = reduce && expr->ops->type->reduce;

Cheers, Phil
