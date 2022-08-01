Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABBA586735
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Aug 2022 12:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiHAKBK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Aug 2022 06:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiHAKBJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:01:09 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 800B92C66B
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Aug 2022 03:01:08 -0700 (PDT)
Date:   Mon, 1 Aug 2022 12:01:02 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 2/7] netlink_delinearize: postprocess binary ands in
 set expressions
Message-ID: <YuekXoqvZkGdQJRJ@salvia>
References: <20220727112003.26022-1-fw@strlen.de>
 <20220727112003.26022-3-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220727112003.26022-3-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Florian,

On Wed, Jul 27, 2022 at 01:19:58PM +0200, Florian Westphal wrote:
[..]
> diff --git a/include/netlink.h b/include/netlink.h
> index e8e0f68ae1a4..2d5532387c0c 100644
> --- a/include/netlink.h
> +++ b/include/netlink.h
[...]
> @@ -2569,6 +2582,24 @@ static void expr_postprocess(struct rule_pp_ctx *ctx, struct expr **exprp)
>  			expr_set_type(expr->right, &integer_type,
>  				      BYTEORDER_HOST_ENDIAN);
>  			break;
> +		case OP_AND:
> +			expr_set_type(expr->right, expr->left->dtype,
> +				      expr->left->byteorder);
> +
> +			/* Only process OP_AND if we are inside a concatenation.
> +			 *
> +			 * Else, we remove it too early, for normal contect OP_AND
> +			 * removal needs to be performed as part of the relational
> +			 * operation because the RHS constant might need to be adjusted
> +			 * (shifted).
> +			 */
> +			if ((ctx->flags & RULE_PP_IN_CONCATENATION) &&
> +			    expr->left->etype == EXPR_PAYLOAD &&
> +			    expr->right->etype == EXPR_VALUE) {
> +				__binop_postprocess(ctx, expr, expr->left, expr->right, exprp);
> +				return;
> +			}
> +			break;

Not sure this flag is enough. If I load this ruleset

 table netdev nt {
       set macset {
               typeof vlan id
               size 1024
               flags dynamic,timeout
       }
        chain y {
        }
 }
 add rule netdev nt y update @macset { vlan id timeout 5s }

listing still shows the raw expression:

 table netdev nt {
        set macset {
                typeof vlan id
                size 1024
                flags dynamic,timeout
        }

        chain y {
                update @macset { @ll,112,16 & 0xfff timeout 5s }
        }
 }

looks like the problem is related to expressions in set statements?

Remaining patches in this series LGTM.
