Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3D37B1EA6
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Sep 2023 15:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjI1NiX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 Sep 2023 09:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjI1NiV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:38:21 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C4919B
        for <netfilter-devel@vger.kernel.org>; Thu, 28 Sep 2023 06:38:19 -0700 (PDT)
Received: from [78.30.34.192] (port=35912 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qlrDZ-0028fs-5Q; Thu, 28 Sep 2023 15:38:15 +0200
Date:   Thu, 28 Sep 2023 15:38:12 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_tables: nft_set_rbtree: fix spurious
 insertion failure
Message-ID: <ZRWBxJBxQ4z7QYVo@calendula>
References: <20230928131247.3391-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928131247.3391-1-fw@strlen.de>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Sep 28, 2023 at 03:12:44PM +0200, Florian Westphal wrote:
> nft_rbtree_gc_elem() walks back and removes the end interval element that
> comes before the expired element.
> 
> There is a small chance that we've cached this element as 'rbe_ge'.
> If this happens, we hold and test a pointer that has been queued for
> freeing.
> 
> It also causes spurious insertion failures:
> 
> $ cat nft-test.20230921-143934.826.dMBwHt/test-testcases-sets-0044interval_overlap_0.1/testout.log
> Error: Could not process rule: File exists
> add element t s {  0 -  2 }
>                    ^^^^^^
> Failed to insert  0 -  2 given:
> table ip t {
>         set s {
>                 type inet_service
>                 flags interval,timeout
>                 timeout 2s
>                 gc-interval 2s
>         }
> }
> 
> The set (rbtree) is empty. The 'failure' doesn't happen on next attempt.
> 
> Reason is that when we try to insert, the tree may hold an expired
> element that collides with the range we're adding.
> While we do evict/erase this element, we can trip over this check:
> 
> if (rbe_ge && nft_rbtree_interval_end(rbe_ge) && nft_rbtree_interval_end(new))
>       return -ENOTEMPTY;
> 
> rbe_ge was erased by the synchronous gc, we should not have done this
> check.  Next attempt won't find it, so retry results in successful
> insertion.
> 
> Restart in-kernel to avoid such spurious errors.
> 
> Such restart are rare, unless userspace intentionally adds very large
> numbers of elements with very short timeouts while setting a huge
> gc interval.
> 
> Even in this case, this cannot loop forever, on each retry an existing
> element has been removed.
> 
> As the caller is holding the transaction mutex, its impossible
> for a second entity to add more expiring elements to the tree.
> 
> After this it also becomes feasible to remove the async gc worker
> and perform all garbage collection from the commit path.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  Changes since v1:
>   - restart entire insertion process in case we remove
>   element that we held as lesser/greater overlap detection
>   edge candidate.

Thanks, I am still looking at finding a way to move this to .commit,
if no better solution, then let's get this in for the next round.

>  net/netfilter/nft_set_rbtree.c | 46 +++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
> index 487572dcd614..2660ceab3759 100644
> --- a/net/netfilter/nft_set_rbtree.c
> +++ b/net/netfilter/nft_set_rbtree.c
> @@ -233,10 +233,9 @@ static void nft_rbtree_gc_remove(struct net *net, struct nft_set *set,
>  	rb_erase(&rbe->node, &priv->root);
>  }
>  
> -static int nft_rbtree_gc_elem(const struct nft_set *__set,
> -			      struct nft_rbtree *priv,
> -			      struct nft_rbtree_elem *rbe,
> -			      u8 genmask)
> +static const struct nft_rbtree_elem *
> +nft_rbtree_gc_elem(const struct nft_set *__set, struct nft_rbtree *priv,
> +		   struct nft_rbtree_elem *rbe, u8 genmask)
>  {
>  	struct nft_set *set = (struct nft_set *)__set;
>  	struct rb_node *prev = rb_prev(&rbe->node);
> @@ -246,7 +245,7 @@ static int nft_rbtree_gc_elem(const struct nft_set *__set,
>  
>  	gc = nft_trans_gc_alloc(set, 0, GFP_ATOMIC);
>  	if (!gc)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	/* search for end interval coming before this element.
>  	 * end intervals don't carry a timeout extension, they
> @@ -261,6 +260,7 @@ static int nft_rbtree_gc_elem(const struct nft_set *__set,
>  		prev = rb_prev(prev);
>  	}
>  
> +	rbe_prev = NULL;
>  	if (prev) {
>  		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
>  		nft_rbtree_gc_remove(net, set, priv, rbe_prev);
> @@ -272,7 +272,7 @@ static int nft_rbtree_gc_elem(const struct nft_set *__set,
>  		 */
>  		gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
>  		if (WARN_ON_ONCE(!gc))
> -			return -ENOMEM;
> +			return ERR_PTR(-ENOMEM);
>  
>  		nft_trans_gc_elem_add(gc, rbe_prev);
>  	}
> @@ -280,13 +280,13 @@ static int nft_rbtree_gc_elem(const struct nft_set *__set,
>  	nft_rbtree_gc_remove(net, set, priv, rbe);
>  	gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
>  	if (WARN_ON_ONCE(!gc))
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	nft_trans_gc_elem_add(gc, rbe);
>  
>  	nft_trans_gc_queue_sync_done(gc);
>  
> -	return 0;
> +	return rbe_prev;
>  }
>  
>  static bool nft_rbtree_update_first(const struct nft_set *set,
> @@ -314,7 +314,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
>  	struct nft_rbtree *priv = nft_set_priv(set);
>  	u8 cur_genmask = nft_genmask_cur(net);
>  	u8 genmask = nft_genmask_next(net);
> -	int d, err;
> +	int d;
>  
>  	/* Descend the tree to search for an existing element greater than the
>  	 * key value to insert that is greater than the new element. This is the
> @@ -363,9 +363,14 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
>  		 */
>  		if (nft_set_elem_expired(&rbe->ext) &&
>  		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
> -			err = nft_rbtree_gc_elem(set, priv, rbe, genmask);
> -			if (err < 0)
> -				return err;
> +			const struct nft_rbtree_elem *removed_end;
> +
> +			removed_end = nft_rbtree_gc_elem(set, priv, rbe, genmask);
> +			if (IS_ERR(removed_end))
> +				return PTR_ERR(removed_end);
> +
> +			if (removed_end == rbe_le || removed_end == rbe_ge)
> +				return -EAGAIN;
>  
>  			continue;
>  		}
> @@ -486,11 +491,18 @@ static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
>  	struct nft_rbtree_elem *rbe = elem->priv;
>  	int err;
>  
> -	write_lock_bh(&priv->lock);
> -	write_seqcount_begin(&priv->count);
> -	err = __nft_rbtree_insert(net, set, rbe, ext);
> -	write_seqcount_end(&priv->count);
> -	write_unlock_bh(&priv->lock);
> +	do {
> +		if (fatal_signal_pending(current))
> +			return -EINTR;
> +
> +		cond_resched();
> +
> +		write_lock_bh(&priv->lock);
> +		write_seqcount_begin(&priv->count);
> +		err = __nft_rbtree_insert(net, set, rbe, ext);
> +		write_seqcount_end(&priv->count);
> +		write_unlock_bh(&priv->lock);
> +	} while (err == -EAGAIN);
>  
>  	return err;
>  }
> -- 
> 2.41.0
> 
