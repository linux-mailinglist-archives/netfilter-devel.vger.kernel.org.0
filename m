Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEFD6CB93F
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Mar 2023 10:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjC1IWF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Mar 2023 04:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjC1IWD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:22:03 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABBAC49F8
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Mar 2023 01:21:27 -0700 (PDT)
Date:   Tue, 28 Mar 2023 10:21:19 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     jeremy@azazel.net, fw@strlen.de
Subject: Re: [PATCH nft,v3 05/12] evaluate: set up integer type to shift
 expression
Message-ID: <ZCKjfyuhlMx/bSOF@salvia>
References: <20230323165855.559837-1-pablo@netfilter.org>
 <20230323165855.559837-6-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230323165855.559837-6-pablo@netfilter.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:58:48PM +0100, Pablo Neira Ayuso wrote:
> Otherwise expr_evaluate_value() fails with invalid datatype:
> 
>  # nft --debug=netlink add rule ip x y 'ct mark set ip dscp & 0x0f << 1'
>  BUG: invalid basetype invalid
>  nft: evaluate.c:440: expr_evaluate_value: Assertion `0' failed.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  src/evaluate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/evaluate.c b/src/evaluate.c
> index 33b1aad72f66..1ee9bdc5aa47 100644
> --- a/src/evaluate.c
> +++ b/src/evaluate.c
> @@ -1308,6 +1308,7 @@ static int expr_evaluate_shift(struct eval_ctx *ctx, struct expr **expr)
>  	if (byteorder_conversion(ctx, &op->right, BYTEORDER_HOST_ENDIAN) < 0)
>  		return -1;
>  
> +	op->dtype     = &integer_type;

I have updated this patch to use:

        datatype_set(op, &integer_type);

before pushing out this batch.

otherwise, datatype leak is possible.

>  	op->byteorder = BYTEORDER_HOST_ENDIAN;
>  	op->len	      = max_shift_len;
>  
> -- 
> 2.30.2
> 
