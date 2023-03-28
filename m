Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2436CB943
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Mar 2023 10:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjC1IWu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Mar 2023 04:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjC1IWr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:22:47 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 508B54C0B
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Mar 2023 01:22:42 -0700 (PDT)
Date:   Tue, 28 Mar 2023 10:22:39 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     jeremy@azazel.net, fw@strlen.de
Subject: Re: [PATCH nft,v3 07/12] evaluate: honor statement length in bitwise
 evaluation
Message-ID: <ZCKjzwzLJydBrnok@salvia>
References: <20230323165855.559837-1-pablo@netfilter.org>
 <20230323165855.559837-8-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230323165855.559837-8-pablo@netfilter.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:58:50PM +0100, Pablo Neira Ayuso wrote:
> @@ -1326,13 +1326,32 @@ static int expr_evaluate_shift(struct eval_ctx *ctx, struct expr **expr)
>  static int expr_evaluate_bitwise(struct eval_ctx *ctx, struct expr **expr)
>  {
>  	struct expr *op = *expr, *left = op->left;
> +	const struct datatype *dtype;
> +	unsigned int max_len;
> +	int byteorder;
> +
> +	if (ctx->stmt_len > left->len) {
> +		max_len = ctx->stmt_len;
> +		byteorder = BYTEORDER_HOST_ENDIAN;
> +		dtype = &integer_type;
> +
> +		/* Both sides need to be in host byte order */
> +		if (byteorder_conversion(ctx, &op->left, BYTEORDER_HOST_ENDIAN) < 0)
> +			return -1;
> +
> +		left = op->left;
> +	} else {
> +		max_len = left->len;
> +		byteorder = left->byteorder;
> +		dtype = left->dtype;
> +	}
>  
> -	if (byteorder_conversion(ctx, &op->right, left->byteorder) < 0)
> +	if (byteorder_conversion(ctx, &op->right, byteorder) < 0)
>  		return -1;
>  
> -	op->dtype     = left->dtype;
> -	op->byteorder = left->byteorder;
> -	op->len	      = left->len;
> +	op->dtype     = dtype;

As in patch 5, this now uses too:

        datatype_set(op, dtype);

> +	op->byteorder = byteorder;
> +	op->len	      = max_len;
>  
>  	if (expr_is_constant(left))
>  		return constant_binop_simplify(ctx, expr);
> -- 
> 2.30.2
> 
