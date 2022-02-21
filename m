Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163E04BDE50
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Feb 2022 18:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356538AbiBULjz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Feb 2022 06:39:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiBULjx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:39:53 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B41EA1ADA8
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Feb 2022 03:39:30 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id CF62060220;
        Mon, 21 Feb 2022 12:38:33 +0100 (CET)
Date:   Mon, 21 Feb 2022 12:39:27 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: Re: [PATCH v2 nf] netfilter: nf_tables: fix memory leak during
 stateful obj update
Message-ID: <YhN575l459m+oTtK@salvia>
References: <20220220111850.87378-1-fw@strlen.de>
 <YhNqmSBAt2IRbYx6@salvia>
 <20220221104635.GB18967@breakpoint.cc>
 <20220221105922.GC18967@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220221105922.GC18967@breakpoint.cc>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Feb 21, 2022 at 11:59:22AM +0100, Florian Westphal wrote:
> Florian Westphal <fw@strlen.de> wrote:
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > On Sun, Feb 20, 2022 at 12:18:50PM +0100, Florian Westphal wrote:
> > > > stateful objects can be updated from the control plane.
> > > > The transaction logic allocates a temporary object for this purpose.
> > > > 
> > > > This object has to be released via nft_obj_destroy, not kfree, since
> > > > the ->init function was called and it can have side effects beyond
> > > > memory allocation.
> > > > 
> > > > Unlike normal NEWOBJ path, the objects module refcount isn't
> > > > incremented, so add nft_newobj_destroy and use that.
> > > 
> > > Probably this? .udata and .key is NULL for the update path so kfree
> > > should be fine.
> > 
> > Yes, that works too.
> > 
> > We could also ...
> > 
> > > -	module_put(obj->ops->type->owner);
> > > +	/* nf_tables_updobj does not increment module refcount */
> > > +	if (!update)
> > > +		module_put(obj->ops->type->owner);
> > > +
> > 
> > Increment the refcount for update case as well to avoid the special
> > case?

Yes, I also though of this one. I prefer this approach indeed to
consolidate this path.

Would you test and submit v3?

Thanks!

> Untested:
> 
> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index 3081c4399f10..49060f281342 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -6553,10 +6553,13 @@ static int nf_tables_updobj(const struct nft_ctx *ctx,
>  	struct nft_trans *trans;
>  	int err;
>  
> +	if (!try_module_get(type->owner))
> +		return -ENOENT;
> +
>  	trans = nft_trans_alloc(ctx, NFT_MSG_NEWOBJ,
>  				sizeof(struct nft_trans_obj));
>  	if (!trans)
> -		return -ENOMEM;
> +		goto err_trans;
>  
>  	newobj = nft_obj_init(ctx, type, attr);
>  	if (IS_ERR(newobj)) {
> @@ -6573,6 +6576,8 @@ static int nf_tables_updobj(const struct nft_ctx *ctx,
>  
>  err_free_trans:
>  	kfree(trans);
> +err_trans:
> +	module_put(type->owner);
>  	return err;
>  }
>  
> @@ -8185,7 +8190,7 @@ static void nft_obj_commit_update(struct nft_trans *trans)
>  	if (obj->ops->update)
>  		obj->ops->update(obj, newobj);
>  
> -	kfree(newobj);
> +	nft_obj_destroy(&trans->ctx, newobj);
>  }
>  
>  static void nft_commit_release(struct nft_trans *trans)
> @@ -8976,7 +8981,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
>  			break;
>  		case NFT_MSG_NEWOBJ:
>  			if (nft_trans_obj_update(trans)) {
> -				kfree(nft_trans_obj_newobj(trans));
> +				nft_obj_destroy(&trans->ctx, nft_trans_obj_newobj(trans));
>  				nft_trans_destroy(trans);
>  			} else {
>  				trans->ctx.table->use--;
