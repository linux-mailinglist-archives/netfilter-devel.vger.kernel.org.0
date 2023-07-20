Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E3675B932
	for <lists+netfilter-devel@lfdr.de>; Thu, 20 Jul 2023 23:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjGTVE7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 20 Jul 2023 17:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGTVE6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:04:58 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717942123
        for <netfilter-devel@vger.kernel.org>; Thu, 20 Jul 2023 14:04:57 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qMapT-0002fz-6n; Thu, 20 Jul 2023 23:04:55 +0200
Date:   Thu, 20 Jul 2023 23:04:55 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_tables: skip immediate deactivate in
 _PREPARE_ERROR and _COMMIT
Message-ID: <ZLmhd4g85Jk8oGRR@strlen.de>
References: <20230720070725.13602-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720070725.13602-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On error when building the rule, the immediate expression unbinds the
> chain, hence objects can be deactivated by the transaction records.
> Similarly, commit path also does not require deactivate because this is
> already done from _PREPARE.
>
> Otherwise, it is possible to trigger the following warning:
> 
>  WARNING: CPU: 3 PID: 915 at net/netfilter/nf_tables_api.c:2013 nf_tables_chain_destroy+0x1f7/0x210 [nf_tables]
>  CPU: 3 PID: 915 Comm: chain-bind-err- Not tainted 6.1.39 #1
>  RIP: 0010:nf_tables_chain_destroy+0x1f7/0x210 [nf_tables]
> 
> Reported-by: Kevin Rich <kevinrich1337@gmail.com>
> Fixes: 4bedf9eee016 ("netfilter: nf_tables: fix chain binding transaction logic")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  net/netfilter/nft_immediate.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
> index 407d7197f75b..a46f872a31cd 100644
> --- a/net/netfilter/nft_immediate.c
> +++ b/net/netfilter/nft_immediate.c
> @@ -125,15 +125,27 @@ static void nft_immediate_activate(const struct nft_ctx *ctx,
>  	return nft_data_hold(&priv->data, nft_dreg_to_type(priv->dreg));
>  }
>  
> +static void nft_immediate_chain_deactivate(const struct nft_ctx *ctx,
> +					   struct nft_chain *chain,
> +					   enum nft_trans_phase phase)
> +{
> +	struct nft_ctx chain_ctx;
> +	struct nft_rule *rule;
> +
> +	chain_ctx = *ctx;
> +	chain_ctx.chain = chain;
> +
> +	list_for_each_entry(rule, &chain->rules, list)
> +		nft_rule_expr_deactivate(&chain_ctx, rule, phase);
> +}
> +
>  static void nft_immediate_deactivate(const struct nft_ctx *ctx,
>  				     const struct nft_expr *expr,
>  				     enum nft_trans_phase phase)
>  {
>  	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
>  	const struct nft_data *data = &priv->data;
> -	struct nft_ctx chain_ctx;
>  	struct nft_chain *chain;
> -	struct nft_rule *rule;
>  
>  	if (priv->dreg == NFT_REG_VERDICT) {
>  		switch (data->verdict.code) {
> @@ -143,19 +155,19 @@ static void nft_immediate_deactivate(const struct nft_ctx *ctx,
>  			if (!nft_chain_binding(chain))
>  				break;
>  
> -			chain_ctx = *ctx;
> -			chain_ctx.chain = chain;
> -
> -			list_for_each_entry(rule, &chain->rules, list)
> -				nft_rule_expr_deactivate(&chain_ctx, rule, phase);
> -
>  			switch (phase) {
>  			case NFT_TRANS_PREPARE_ERROR:
>  				nf_tables_unbind_chain(ctx, chain);
> -				fallthrough;
> +				nft_deactivate_next(ctx->net, chain);
> +				break;
>  			case NFT_TRANS_PREPARE:
> +				nft_immediate_chain_deactivate(ctx, chain, phase);
>  				nft_deactivate_next(ctx->net, chain);
>  				break;

So far so good, don't do deactivate from PREPARE_ERROR.
> +			case NFT_TRANS_ABORT:
> +			case NFT_TRANS_RELEASE:
> +				nft_immediate_chain_deactivate(ctx, chain, phase);
> +				fallthrough;
>  			default:
>  				nft_chain_del(chain);

But this one I don't understand, this introduces a memory leak.

After this, COMMIT no longer calls deactivate which means
nft_lookup ->deactivate won't call nf_tables_deactivate_set()
which then won't call into nf_tables_unbind_set().

I've removed the entire hunk above to do:

>  			case NFT_TRANS_PREPARE:
> +				nft_immediate_chain_deactivate(ctx, chain, phase);
>  				nft_deactivate_next(ctx->net, chain);
>  				break;
>  			default:
> +				nft_immediate_chain_deactivate(ctx, chain, phase);
>  				nft_chain_del(chain);

Which means nft_immediate_chain_deactivate() is always called except
for PREPARE_ERROR. Does that make sense to you?
