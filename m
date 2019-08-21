Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E508F976AF
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 12:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfHUKJI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Aug 2019 06:09:08 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:39624 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726389AbfHUKJI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:09:08 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1i0NY9-0003CD-Gu; Wed, 21 Aug 2019 12:09:05 +0200
Date:   Wed, 21 Aug 2019 12:09:05 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 1/2 nf-next] netfilter: nf_tables: Introduce stateful
 object update operation
Message-ID: <20190821100905.GX2588@breakpoint.cc>
References: <20190821094420.866-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821094420.866-1-ffmancera@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
> This patch adds the infrastructure needed for the stateful object update
> support.
> 
> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> ---
>  include/net/netfilter/nf_tables.h |  6 +++
>  net/netfilter/nf_tables_api.c     | 71 ++++++++++++++++++++++++++++---
>  2 files changed, 70 insertions(+), 7 deletions(-)
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

maybe adda 'bool commit' argument here.

> +	err = obj->ops->update(ctx, (const struct nlattr * const *)tb, obj);

Then, set it to 'false' here.
You would have to keep 'tb' allocated and place it on the 'trans'
object.

> +	nft_trans_obj_update(trans) = true;

	nft_trans_obj_update_tb(trans) = tb;

> -			nft_clear(net, nft_trans_obj(trans));
> -			nf_tables_obj_notify(&trans->ctx, nft_trans_obj(trans),
> -					     NFT_MSG_NEWOBJ);
> -			nft_trans_destroy(trans);
> +			if (nft_trans_obj_update(trans)) {

				nft_trans_obj(trans)->ops->update(&trans->ctx,
					      nft_trans_obj_update_tb(trans),
					      nft_trans_obj(trans),
					      true);

				kfree(nft_trans_obj_update_tb(trans));


Because otherwise we will update objects while we're not yet sure that
we can process/handle the entire batch.

I think we should, if possible, only update once we've made it to
the commit phase.
