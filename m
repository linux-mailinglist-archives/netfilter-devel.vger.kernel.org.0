Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3EEF922D4
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Aug 2019 13:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfHSLz3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Aug 2019 07:55:29 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:56090 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbfHSLz3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:55:29 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1hzgFz-0004Ue-0u; Mon, 19 Aug 2019 13:55:27 +0200
Date:   Mon, 19 Aug 2019 13:55:27 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH WIP nf-next] netfilter: nf_tables: Introduce stateful
 object update operation
Message-ID: <20190819115527.GH2588@breakpoint.cc>
References: <20190819111914.10514-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819111914.10514-1-ffmancera@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
> This is a WIP patch version. I still having some issues in userspace but I
> would like to get feedback about the kernel-side patch. Thanks!
> 
> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> ---
>  include/net/netfilter/nf_tables.h |  6 +++
>  net/netfilter/nf_tables_api.c     | 73 ++++++++++++++++++++++++++++---
>  2 files changed, 72 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
> index dc301e3d6739..dc4e32040ea9 100644
> --- a/include/net/netfilter/nf_tables.h
> +++ b/include/net/netfilter/nf_tables.h
> @@ -1123,6 +1123,9 @@ struct nft_object_ops {
>  	int				(*dump)(struct sk_buff *skb,
>  						struct nft_object *obj,
>  						bool reset);
> +	int				(*update)(const struct nft_ctx *ctx,
> +						  const struct nlattr *const tb[],
> +						  struct nft_object *obj);
>  	const struct nft_object_type	*type;
>  };
>  
> @@ -1405,10 +1408,13 @@ struct nft_trans_elem {
>  
>  struct nft_trans_obj {
>  	struct nft_object		*obj;
> +	bool				update;
>  };
>  
>  #define nft_trans_obj(trans)	\
>  	(((struct nft_trans_obj *)trans->data)->obj)
> +#define nft_trans_obj_update(trans)	\
> +	(((struct nft_trans_obj *)trans->data)->update)
>  
>  struct nft_trans_flowtable {
>  	struct nft_flowtable		*flowtable;
> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index fe3b7b0c6c66..d7b94904599c 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -5122,6 +5122,48 @@ nft_obj_type_get(struct net *net, u32 objtype)
>  	return ERR_PTR(-ENOENT);
>  }
>  
> +static int nf_tables_updobj(const struct nft_ctx *ctx,
> +			    const struct nft_object_type *type,
> +			    const struct nlattr *attr,
> +			    struct nft_object *obj)
> +{
> +	struct nft_trans *trans;
> +	struct nlattr **tb;
> +	int err = -ENOMEM;
> +
> +	trans = nft_trans_alloc(ctx, NFT_MSG_NEWOBJ,
> +				sizeof(struct nft_trans_obj));
> +	if (!trans)
> +		return -ENOMEM;
> +
> +	tb = kmalloc_array(type->maxattr + 1, sizeof(*tb), GFP_KERNEL);

You can use kcalloc here and then remove the memset().

> +	err = obj->ops->update(ctx, (const struct nlattr * const *)tb, obj);
> +	if (err < 0)
> +		goto err;

This looks wrong, see below.

> @@ -5161,7 +5203,13 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
>  			NL_SET_BAD_ATTR(extack, nla[NFTA_OBJ_NAME]);
>  			return -EEXIST;
>  		}
> -		return 0;
> +		if (nlh->nlmsg_flags & NLM_F_REPLACE)
> +			return -EOPNOTSUPP;
> +
> +		type = nft_obj_type_get(net, objtype);
> +		nft_ctx_init(&ctx, net, skb, nlh, family, table, NULL, nla);
> +
> +		return nf_tables_updobj(&ctx, type, nla[NFTA_OBJ_DATA], obj);
>  	}
>  
>  		case NFT_MSG_NEWOBJ:
> -			nft_clear(net, nft_trans_obj(trans));
> -			nf_tables_obj_notify(&trans->ctx, nft_trans_obj(trans),
> -					     NFT_MSG_NEWOBJ);
> -			nft_trans_destroy(trans);
> +			if (nft_trans_obj_update(trans)) {
> +				nf_tables_obj_notify(&trans->ctx,
> +						     nft_trans_obj(trans),
> +						     NFT_MSG_NEWOBJ);

I would have expected the ->update() here, when committing the batch.
Under what conditions can an update() fail?
