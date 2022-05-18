Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811C852BB2B
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 May 2022 14:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbiERMWF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 May 2022 08:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbiERMWD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 May 2022 08:22:03 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E980850059
        for <netfilter-devel@vger.kernel.org>; Wed, 18 May 2022 05:22:00 -0700 (PDT)
Date:   Wed, 18 May 2022 14:21:57 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        fw@strlen.de
Subject: Re: [PATCH] netfilter: nf_tables: restrict expression reduction to
 first expression
Message-ID: <YoTk5VKX98itwUQo@salvia>
References: <20220518100842.1950-1-pablo@netfilter.org>
 <YoTPlIBany/aRvtK@orbyte.nwl.cc>
 <YoTSHls/on1S+/4N@salvia>
 <YoTbJTDxuQ131EDG@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoTbJTDxuQ131EDG@orbyte.nwl.cc>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 18, 2022 at 01:40:21PM +0200, Phil Sutter wrote:
> On Wed, May 18, 2022 at 01:01:50PM +0200, Pablo Neira Ayuso wrote:
> > On Wed, May 18, 2022 at 12:51:00PM +0200, Phil Sutter wrote:
> > > Hi,
> > > 
> > > On Wed, May 18, 2022 at 12:08:42PM +0200, Pablo Neira Ayuso wrote:
> > > > Either userspace or kernelspace need to pre-fetch keys inconditionally
> > > > before comparisons for this to work. Otherwise, register tracking data
> > > > is misleading and it might result in reducing expressions which are not
> > > > yet registers.
> > > > 
> > > > First expression is guaranteed to be evaluated always, therefore, keep
> > > > tracking registers and restrict reduction to first expression.
> > > > 
> > > > Fixes: b2d306542ff9 ("netfilter: nf_tables: do not reduce read-only expressions")
> > > > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > > > ---
> > > > @Phil, you mentioned about a way to simplify this patch, I don't see how,
> > > > just let me know.
> > > 
> > > Not a big one. Instead of:
> > > 
> > > |	if (nft_expr_reduce(&track, expr)) {
> > > |		if (reduce) {
> > > |			reduce = false;
> > > |			expr = track.cur;
> > > |			continue;
> > > |		}
> > > |	} else if (reduce) {
> > > |		reduce = false;
> > > |	}
> > > 
> > > One could do:
> > > 
> > > |	if (nft_expr_reduce(&track, expr) && reduce) {
> > > |		reduce = false;
> > > |		expr = track.cur;
> > > |		continue;
> > > |	}
> > > |	reduce = false;
> > 
> > I'll send v2 using this idiom.
> > 
> > > Regarding later pre-fetching, one should distinguish between expressions
> > > that (may) set verdict register and those that don't. There are pitfalls
> > > though, e.g. error conditions handled that way.
> > > 
> > > Maybe introduce a new nft_expr_type field and set reduce like so:
> > > 
> > > | reduce = reduce && expr->ops->type->reduce;
> > 
> > Could you elaborate?
> 
> Well, an expression which may set verdict register to NFT_BREAK should
> prevent reduction of later expressions in same rule as it may stop rule
> evaluation at run-time. This is obvious for nft_cmp, but nft_meta is
> also a candidate: NFT_META_IFTYPE causes NFT_BREAK if pkt->skb->dev is
> NULL. The optimizer must not assume later expressions are evaluated.

How many other expression are breaking when fetching the key?

> A first step might be said nft_expr_type field indicating a given
> expression might stop expression evaluation. Therefore:
> 
> | reduce = reduce && expr->ops->type->reduce;
> 
> would continue expression reduction if not already stopped and the
> current expression doesn't end it.
> 
> Taking nft_meta as example again:
> 
> * Behaviour changes based on nft_expr_type::select_ops result
> * Some keys are guaranteed to not stop expression evaluation:
>   NFT_META_LEN for instance will always just fetch skb->len. So
>   introduce a callback instead:
>
> | bool nft_expr_ops::may_break(const struct nft_expr *expr);
>
> Then "ask" the expression whether it may change verdict register:
> 
> | reduce = reduce && expr->ops->may_break(expr);
> 
> With nft_meta_get_ops, we'd have:
> 
> | bool nft_meta_get_may_break(const struct nft_expr *expr)
> | {
> | 	switch (nft_expr_priv(expr)->key) {
> | 	case NFT_META_LEN:
> | 	case NFT_META_PROTOCOL::
> | 	[...]
> | 		return false;
> | 	case NFT_META_IFTYPE:
> | 	[...]
> | 		return true;
> | 	}
> | }

And simply remove that NFT_BREAK and set a value that will not ever
match via nft_cmp?

> Another thing about your proposed patch: Expressions may update
> registers even if not reduced. Could that upset later reduction
> decision? E.g.:
> 
> | ip saddr 1.0.0.1 ip daddr 2.0.0.2 accept
> | ip daddr 3.0.0.3 accept
> 
> Code no longer allows the first rule's 'ip daddr' expression to be
> reduced (no matter what's in registers already), but it's existence
> causes reduction of the second rule's 'ip daddr' expression, right?

We cannot make assumptions on ip daddr because there is a cmp right
before (to test for ip saddr 1.0.0.1), unless keys are inconditionally
prefetched.
