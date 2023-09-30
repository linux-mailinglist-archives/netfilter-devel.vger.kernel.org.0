Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C2F7B3C93
	for <lists+netfilter-devel@lfdr.de>; Sat, 30 Sep 2023 00:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjI2WZV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 29 Sep 2023 18:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2WZV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 29 Sep 2023 18:25:21 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA0D139
        for <netfilter-devel@vger.kernel.org>; Fri, 29 Sep 2023 15:25:18 -0700 (PDT)
Received: from [78.30.34.192] (port=35708 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qmLv5-00CP9r-8a; Sat, 30 Sep 2023 00:25:13 +0200
Date:   Sat, 30 Sep 2023 00:25:10 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: Re: [PATCH nf 1/2] netfilter: nft_set_rbtree: move sync GC from
 insert path to set->ops->commit
Message-ID: <ZRdOxs+i1EuC+zoS@calendula>
References: <20230929164404.172081-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230929164404.172081-1-pablo@netfilter.org>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Fri, Sep 29, 2023 at 06:44:03PM +0200, Pablo Neira Ayuso wrote:
> According to 2ee52ae94baa ("netfilter: nft_set_rbtree: skip sync GC for
> new elements in this transaction"), new elements in this transaction
> might expire before such transaction ends. Skip sync GC is needed for
> such elements otherwise commit path might walk over an already released
> object.
> 
> However, Florian found that while iterating the tree from the insert
> path for sync GC, it is possible that stale references could still
> happen for elements in the less-equal and great-than boundaries to
> narrow down the tree descend to speed up overlap detection, this
> triggers bogus overlap errors.
> 
> This patch skips expired elements in the overlap detection routine which
> iterates on the reversed ordered list of elements that represent the
> intervals. Since end elements provide no expiration extension, check for
> the next non-end element in this interval, hence, skip both elements in
> the iteration if the interval has expired.
> 
> Moreover, move GC sync to the set->ops->commit interface to collect
> expired interval. The GC run needs to ignore the gc_interval because the
> tree cannot store duplicated expired elements, otherwise bogus
> mismatches might occur.

I should have tagged this as RFC, this is partially cooked:

- read spin lock is required for the sync GC to make sure this does
  not zap entries that are being used from the datapath.

- the full GC batch could be used to amortize the memory allocation
  (not only two slots as it happens now, I am recycling an existing
   function).

- ENOMEM on GC sync commit path could be an issue. It is too late to
  fail. The tree would start collecting expired elements that might
  duplicate existing, triggering bogus mismatches. In this path the
  commit_mutex is held, and this set backend does not support for
  lockless read, so it might be possible to simply grab the spinlock
  in write mode and release entries inmediately, without requiring the
  sync GC batch infrastructure that pipapo is using.

> Fixes: f6c383b8c31a ("netfilter: nf_tables: adapt set backend to use GC transaction API")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
> Hi Florian,
> 
> I picked up on issue, this proposed as an alternative to:
> https://patchwork.ozlabs.org/project/netfilter-devel/patch/20230928131247.3391-1-fw@strlen.de/
> 
> Note this ignores the specified gc_interval. For this to work, a copy of the
> tree would need to be maintained, similar to what pipapo does.
> 
> This approach should clear the path to support for set element timeout
> update/refresh.
> 
> I still spinning over this one and running test to see if I see any failure
> with sets/0044_interval_overlap_{0,1}.
> 
>  net/netfilter/nft_set_rbtree.c | 57 +++++++++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 14 deletions(-)
> 
> diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
> index 487572dcd614..de6d812fc790 100644
> --- a/net/netfilter/nft_set_rbtree.c
> +++ b/net/netfilter/nft_set_rbtree.c
> @@ -235,8 +235,7 @@ static void nft_rbtree_gc_remove(struct net *net, struct nft_set *set,
>  
>  static int nft_rbtree_gc_elem(const struct nft_set *__set,
>  			      struct nft_rbtree *priv,
> -			      struct nft_rbtree_elem *rbe,
> -			      u8 genmask)
> +			      struct nft_rbtree_elem *rbe)
>  {
>  	struct nft_set *set = (struct nft_set *)__set;
>  	struct rb_node *prev = rb_prev(&rbe->node);
> @@ -254,8 +253,7 @@ static int nft_rbtree_gc_elem(const struct nft_set *__set,
>  	 */
>  	while (prev) {
>  		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
> -		if (nft_rbtree_interval_end(rbe_prev) &&
> -		    nft_set_elem_active(&rbe_prev->ext, genmask))
> +		if (nft_rbtree_interval_end(rbe_prev))
>  			break;
>  
>  		prev = rb_prev(prev);
> @@ -289,6 +287,34 @@ static int nft_rbtree_gc_elem(const struct nft_set *__set,
>  	return 0;
>  }
>  
> +static void nft_rbtree_commit(const struct nft_set *set)
> +{
> +	struct nft_rbtree *priv = nft_set_priv(set);
> +	struct rb_node *node, *next, *first;
> +	struct nft_rbtree_elem *rbe;
> +
> +	if (!(set->flags & NFT_SET_TIMEOUT))
> +		return;
> +
> +	/* ignore GC interval here, unless two copies of the tree are
> +	 * maintained, it is not possible to postpone removal of expired
> +	 * elements.
> +	 */
> +
> +	first = rb_first(&priv->root);
> +
> +	for (node = first; node != NULL; node = next) {
> +		next = rb_next(node);
> +
> +		rbe = rb_entry(node, struct nft_rbtree_elem, node);
> +
> +		if (!nft_set_elem_expired(&rbe->ext))
> +			continue;
> +
> +		nft_rbtree_gc_elem(set, priv, rbe);
> +	}
> +}
> +
>  static bool nft_rbtree_update_first(const struct nft_set *set,
>  				    struct nft_rbtree_elem *rbe,
>  				    struct rb_node *first)
> @@ -312,9 +338,8 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
>  	struct nft_rbtree_elem *rbe, *rbe_le = NULL, *rbe_ge = NULL;
>  	struct rb_node *node, *next, *parent, **p, *first = NULL;
>  	struct nft_rbtree *priv = nft_set_priv(set);
> -	u8 cur_genmask = nft_genmask_cur(net);
>  	u8 genmask = nft_genmask_next(net);
> -	int d, err;
> +	int d;
>  
>  	/* Descend the tree to search for an existing element greater than the
>  	 * key value to insert that is greater than the new element. This is the
> @@ -358,16 +383,19 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
>  		if (!nft_set_elem_active(&rbe->ext, genmask))
>  			continue;
>  
> -		/* perform garbage collection to avoid bogus overlap reports
> -		 * but skip new elements in this transaction.
> +		/* skip expired intervals to avoid bogus overlap reports:
> +		 * end element has no expiration, check next start element.
>  		 */
> -		if (nft_set_elem_expired(&rbe->ext) &&
> -		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
> -			err = nft_rbtree_gc_elem(set, priv, rbe, genmask);
> -			if (err < 0)
> -				return err;
> +		if (nft_rbtree_interval_end(rbe) && next) {
> +			struct nft_rbtree_elem *rbe_next;
>  
> -			continue;
> +			rbe_next = rb_entry(next, struct nft_rbtree_elem, node);
> +
> +			if (nft_set_elem_expired(&rbe_next->ext)) {
> +				/* skip expired next start element. */
> +				next = rb_next(next);
> +				continue;
> +			}
>  		}
>  
>  		d = nft_rbtree_cmp(set, rbe, new);
> @@ -755,5 +783,6 @@ const struct nft_set_type nft_set_rbtree_type = {
>  		.lookup		= nft_rbtree_lookup,
>  		.walk		= nft_rbtree_walk,
>  		.get		= nft_rbtree_get,
> +		.commit		= nft_rbtree_commit,
>  	},
>  };
> -- 
> 2.30.2
> 
