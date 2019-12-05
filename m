Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D104114904
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Dec 2019 23:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfLEWEK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Dec 2019 17:04:10 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:33560 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfLEWEK (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Dec 2019 17:04:10 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iczEG-0002Ax-GY; Thu, 05 Dec 2019 23:04:08 +0100
Date:   Thu, 5 Dec 2019 23:04:08 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_set_rbtree: bogus lookup/get on
 consecutive elements in named sets
Message-ID: <20191205220408.GG14469@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191205180706.134232-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205180706.134232-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Thu, Dec 05, 2019 at 07:07:06PM +0100, Pablo Neira Ayuso wrote:
> The existing rbtree implementation might store consecutive elements
> where the closing element and the opening element might overlap, eg.
> 
> 	[ a, a+1) [ a+1, a+2)
> 
> This patch removes the optimization for non-anonymous sets in the exact
> matching case, where it is assumed to stop searching in case that the
> closing element is found. Instead, invalidate candidate interval and
> keep looking further in the tree.
> 
> This patch fixes the lookup and get operations.

I didn't get what the actual problem is?

[...]
> diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
> index 57123259452f..510169e28065 100644
> --- a/net/netfilter/nft_set_rbtree.c
> +++ b/net/netfilter/nft_set_rbtree.c
[...]
> @@ -141,6 +146,8 @@ static bool __nft_rbtree_get(const struct net *net, const struct nft_set *set,
>  		} else {
>  			if (!nft_set_elem_active(&rbe->ext, genmask))
>  				parent = rcu_dereference_raw(parent->rb_left);
> +				continue;
> +			}
>  
>  			if (!nft_set_ext_exists(&rbe->ext, NFT_SET_EXT_FLAGS) ||
>  			    (*nft_set_ext_flags(&rbe->ext) & NFT_SET_ELEM_INTERVAL_END) ==

Are you sure about that chunk? It adds a closing brace without a
matching opening one. Either this patch ignores whitespace change or
there's something fishy. :)

Cheers, Phil
