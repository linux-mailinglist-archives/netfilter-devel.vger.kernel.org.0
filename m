Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA9853189A
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 May 2022 22:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbiEWR2Y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 23 May 2022 13:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240691AbiEWRZ3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 23 May 2022 13:25:29 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2E778217E
        for <netfilter-devel@vger.kernel.org>; Mon, 23 May 2022 10:20:56 -0700 (PDT)
Date:   Mon, 23 May 2022 19:19:08 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
Subject: Re: [nft PATCH v4 09/32] netlink_delinearize: add postprocessing for
 payload binops
Message-ID: <YovCDObeM32n8uvT@salvia>
References: <20220404121410.188509-1-jeremy@azazel.net>
 <20220404121410.188509-10-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220404121410.188509-10-jeremy@azazel.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Apr 04, 2022 at 01:13:47PM +0100, Jeremy Sowden wrote:
> If a user uses a payload expression as a statement argument:
> 
>   nft add rule t c meta mark set ip dscp lshift 2 or 0x10
> 
> we may need to undo munging during delinearization.
> 
> Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
> ---
>  src/netlink_delinearize.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
> index 733977bc526d..12624db4c3a5 100644
> --- a/src/netlink_delinearize.c
> +++ b/src/netlink_delinearize.c
> @@ -2454,6 +2454,42 @@ static void relational_binop_postprocess(struct rule_pp_ctx *ctx,
>  	}
>  }
>  
> +static bool payload_binop_postprocess(struct rule_pp_ctx *ctx,
> +				      struct expr **exprp)
> +{
> +	struct expr *expr = *exprp;
> +
> +	if (expr->op != OP_RSHIFT)
> +		return false;
> +
> +	if (expr->left->etype == EXPR_UNARY) {
> +		/*
> +		 * If the payload value was originally in a different byte-order
> +		 * from the payload expression, there will be a byte-order
> +		 * conversion to remove.
> +		 */

The comment assumes this is a payload expression, the unary is
stripped off here...

> +		struct expr *left = expr_get(expr->left->arg);
> +		expr_free(expr->left);
> +		expr->left = left;
> +	}
> +
> +	if (expr->left->etype != EXPR_BINOP || expr->left->op != OP_AND)
> +		return false;
> +
> +	if (expr->left->left->etype != EXPR_PAYLOAD)

... but the check for payload is coming here.

I assume this postprocessing is to undo the switch from network
byteorder to host byteorder for the ip dscp of the example above?

Could you describe an example expression tree to depict this
delinearize scenario?

> +		return false;
> +
> +	expr_set_type(expr->right, &integer_type,
> +		      BYTEORDER_HOST_ENDIAN);
> +	expr_postprocess(ctx, &expr->right);
> +
> +	binop_postprocess(ctx, expr, &expr->left);
> +	*exprp = expr_get(expr->left);
> +	expr_free(expr);
> +
> +	return true;
> +}
> +
>  static struct expr *string_wildcard_expr_alloc(struct location *loc,
>  					       const struct expr *mask,
>  					       const struct expr *expr)
> @@ -2566,6 +2602,9 @@ static void expr_postprocess(struct rule_pp_ctx *ctx, struct expr **exprp)
>  		expr_set_type(expr, expr->arg->dtype, !expr->arg->byteorder);
>  		break;
>  	case EXPR_BINOP:
> +		if (payload_binop_postprocess(ctx, exprp))
> +			break;
> +
>  		expr_postprocess(ctx, &expr->left);
>  		switch (expr->op) {
>  		case OP_LSHIFT:
> -- 
> 2.35.1
> 
