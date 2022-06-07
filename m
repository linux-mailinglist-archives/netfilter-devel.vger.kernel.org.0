Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE5753C05F
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Jun 2022 23:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiFBVaw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 2 Jun 2022 17:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiFBVav (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:30:51 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0A60218D
        for <netfilter-devel@vger.kernel.org>; Thu,  2 Jun 2022 14:30:49 -0700 (PDT)
Date:   Thu, 2 Jun 2022 23:30:45 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf 2/3] netfilter: nf_tables: memleak in nft_expr_init()
 path
Message-ID: <YpksBa5REObpeu8k@salvia>
References: <20220602074357.332409-1-pablo@netfilter.org>
 <20220602074357.332409-2-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220602074357.332409-2-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jun 02, 2022 at 09:43:56AM +0200, Pablo Neira Ayuso wrote:
> Since ed0a0c60f0e5 ("netfilter: nft_quota: move stateful fields out of
> expression data"), stateful expressions allocate stateful area via
> kmalloc().
> 
> Call ->ops->destroy() to release expression stateful information before
> releasing the expression.
> 
> ->ops->deactivate() is also called for safety reasons, no stateful
> expressions support for this function.
> 
> Fixes: 6cafaf4764a3 ("netfilter: nf_tables: fix memory leak if expr init fails")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  net/netfilter/nf_tables_api.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index 5ee4e7b28b61..017b77067852 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -2904,6 +2904,11 @@ static struct nft_expr *nft_expr_init(const struct nft_ctx *ctx,
>  
>  	return expr;
>  err_expr_new:
> +	if (expr->ops->deactivate)
> +		expr->ops->deactivate(ctx, expr, NFT_TRANS_RELEASE);
> +	if (expr_info.ops->destroy)
> +		expr_info.ops->destroy(ctx, expr);

Scratch this patch. Not correct.

nf_tables_newexpr() calls ->init() which if it fails, then it did not
allocate anything.

> +
>  	kfree(expr);
>  err_expr_stateful:
>  	owner = expr_info.ops->type->owner;
> -- 
> 2.30.2
> 
