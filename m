Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70CD5314D9
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 May 2022 18:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiEWO7g (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 23 May 2022 10:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiEWO7g (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 23 May 2022 10:59:36 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 762B25B8A0
        for <netfilter-devel@vger.kernel.org>; Mon, 23 May 2022 07:59:34 -0700 (PDT)
Date:   Mon, 23 May 2022 16:59:30 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] nft_set_rbtree: Move clauses for expired nodes, last
 active node as leaf
Message-ID: <YouhUq09zfcflOnz@salvia>
References: <20220512183421.712556-1-sbrivio@redhat.com>
 <YoKVFRR1gggECpiZ@salvia>
 <20220517145709.08694803@elisabeth>
 <20220520174524.439b5fa2@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220520174524.439b5fa2@elisabeth>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, May 20, 2022 at 05:45:24PM +0200, Stefano Brivio wrote:
> On Tue, 17 May 2022 14:57:09 +0200
> Stefano Brivio <sbrivio@redhat.com> wrote:
> 
> > On Mon, 16 May 2022 20:16:53 +0200
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > 
> > > Hi Stefano,
> > > 
> > > On Thu, May 12, 2022 at 08:34:21PM +0200, Stefano Brivio wrote:  
> > > > In the overlap detection performed as part of the insertion operation,
> > > > we have to skip nodes that are not active in the current generation or
> > > > expired. This was done by adding several conditions in overlap decision
> > > > clauses, which made it hard to check for correctness, and debug the
> > > > actual issue this patch is fixing.
> > > > 
> > > > Consolidate these conditions into a single clause, so that we can
> > > > proceed with debugging and fixing the following issue.
> > > > 
> > > > Case b3. described in comments covers the insertion of a start
> > > > element after an existing end, as a leaf. If all the descendants of
> > > > a given element are inactive, functionally, for the purposes of
> > > > overlap detection, we still have to treat this as a leaf, but we don't.
> > > > 
> > > > If, in the same transaction, we remove a start element to the right,
> > > > remove an end element to the left, and add a start element to the right
> > > > of an existing, active end element, we don't hit case b3. For example:
> > > > 
> > > > - existing intervals: 1-2, 3-5, 6-7
> > > > - transaction: delete 3-5, insert 4-5
> > > > 
> > > > node traversal might happen as follows:
> > > > - 2 (active end)
> > > > - 5 (inactive end)
> > > > - 3 (inactive start)
> > > > 
> > > > when we add 4 as start element, we should simply consider 2 as
> > > > preceding end, and consider it as a leaf, because interval 3-5 has been
> > > > deleted. If we don't, we'll report an overlap because we forgot about
> > > > this.
> > > > 
> > > > Add an additional flag which is set as we find an active end, and reset
> > > > it if we find an active start (to the left). If we finish the traversal
> > > > with this flag set, it means we need to functionally consider the
> > > > previous active end as a leaf, and allow insertion instead of reporting
> > > > overlap.    
> > > 
> > > I can still trigger EEXIST with deletion of existing interval. It
> > > became harder to reproduce after this patch.
> > > 
> > > After hitting EEXIST, if I do:
> > > 
> > >         echo "flush ruleset" > test.nft
> > >         nft list ruleset >> test.nft
> > > 
> > > to dump the existing ruleset, then I run the delete element command
> > > again to remove the interval and it works. Before this patch I could
> > > reproduce it by reloading an existing ruleset dump.
> > > 
> > > I'm running the script that I'm attaching manually, just one manual
> > > invocation after another.  
> > 
> > Ouch, sorry for that.
> > 
> > It looks like there's another case where inactive elements still affect
> > overlap detection in an unexpected way... at least with the structure
> > of this patch it should be easier to find, I'm looking into that now.
> 
> ...what a mess. I could figure that part out (it was a case symmetric
> to what this patch fixed, in this case resolving to case b5.) but
> there's then another case (found by triggering a specific tree topology
> with 0044interval_overlap_1) where we first add a start element, then
> fail to add the end element because the start element is completely
> "hidden" in the tree by inactive nodes.
> 
> I tried to solve that with some backtracking, but that looks also
> fragile. If I clean up the tree before insertion, instead, that will
> only deal with expired nodes, not inactive nodes -- I can't erase
> non-expired, inactive nodes because the API expects to find them at
> some later point and call nft_rbtree_remove() on them.
> 
> Now I'm trying another approach that looks more robust: instead of
> descending the tree to find overlaps, just going through it in the same
> way nft_rbtree_gc() does (linearly, node by node), marking the
> value-wise closest points from left and right _valid_ nodes, and
> applying the same reasoning. I need a bit more time for this, but it
> looks way simpler. Insertion itself would keep working as it does now.
> 
> In hindsight, it looks like it was a terrible idea to try to fix this
> implementation. I really underestimated how bad this is. Functionally
> speaking, it's not a red-black tree because:
> 
> - we can't use it as a sorted binary tree, given that some elements
>   "don't matter" for some operations, or have another colour. We might
>   try to think of it as some other structure and rebuild from there
>   useful properties of sorted binary trees, but I'm not sure a
>   "red-brown-black" tree would have any other use making it worth of
>   any further research
> 
> - end elements being represented as their value plus one also break
>   assumptions of sorted trees (this is the issue I'm actually facing
>   with backtracking)
> 
> - left subtrees store keys greater than right subtrees, but this
>   looks consistent so it's just added fun and could be fixed
>   trivially (it's all reversed)
> 
> By the way, I think we _should_ have similar issues in the lookup
> function. Given that it's possible to build a tree with a subtree of at
> least three levels with entirely non-valid nodes, I guess we can hide a
> valid interval from the lookup too. It's just harder to test.

Thanks for the detailed report.

Another possibility? Maintain two trees, one for the existing
generation (this is read-only) and another for the next generation
(insertion/removals are performed on it), then swap them when commit
happens? pipapo has similar requirements, currently it is relying on a
workqueue to make some postprocess after the commit phase. At the
expense of consuming more memory.

> In the perspective of getting rid of it, I think we need:
> 
> 1. some "introductory" documentation for nft_set_pipapo -- I just
>    got back to it (drawing some diagrams first...)
> 
> 2. to understand if the performance gap in the few (maybe not
>    reasonable) cases where nft_set_rbtree matches faster than
>    nft_set_pipapo is acceptable. Summary:
>      https://lore.kernel.org/netfilter-devel/be7d4e51603633e7b88e4b0dde54b25a3e5a018b.1583598508.git.sbrivio@redhat.com/

IIRC pipapo was not too far behind from rbtree for a few scenarios.

> 3. a solution for https://bugzilla.netfilter.org/show_bug.cgi?id=1583,
>    it's an atomicity issue which has little to do with nft_set_pipapo
>    structures themselves, but I couldn't figure out the exact issue
>    yet. I'm struggling to find the time for it, so if somebody wants to
>    give it a try, I'd be more than happy to reassign it...

OK, a different problem, related to pipapo.

> Anyway, I'll post a different patch for nft_set_rbtree soon.

Thanks.
