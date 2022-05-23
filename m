Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB17531AD7
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 May 2022 22:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbiEWR3k (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 23 May 2022 13:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242016AbiEWR1X (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 23 May 2022 13:27:23 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32BD67A80A
        for <netfilter-devel@vger.kernel.org>; Mon, 23 May 2022 10:22:33 -0700 (PDT)
Date:   Mon, 23 May 2022 19:22:02 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
Subject: Re: [nft PATCH v4 11/32] netlink_delinearize: correct length of
 right bitwise operand
Message-ID: <YovCuuA/egTL+TvL@salvia>
References: <20220404121410.188509-1-jeremy@azazel.net>
 <20220404121410.188509-12-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220404121410.188509-12-jeremy@azazel.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Apr 04, 2022 at 01:13:49PM +0100, Jeremy Sowden wrote:
> Set it to match the length of the left operand.
> 
> Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
> ---
>  src/netlink_delinearize.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
> index 8b010fe4d168..cf5359bf269e 100644
> --- a/src/netlink_delinearize.c
> +++ b/src/netlink_delinearize.c
> @@ -2613,6 +2613,7 @@ static void expr_postprocess(struct rule_pp_ctx *ctx, struct expr **exprp)
>  				      BYTEORDER_HOST_ENDIAN);
>  			break;
>  		default:
> +			expr->right->len = expr->left->len;

This seems to be required for EXPR_BINOP (exclusing left/right shift)

I am assuming here expr->right is the value of the bitmask.

Was expr->right->len unset?

>  			expr_set_type(expr->right, expr->left->dtype,
>  				      expr->left->byteorder);
>  		}
> -- 
> 2.35.1
> 
