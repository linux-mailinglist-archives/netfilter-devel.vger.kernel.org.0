Return-Path: <netfilter-devel+bounces-1455-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489198816FA
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Mar 2024 19:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2152281862
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Mar 2024 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1F16A34D;
	Wed, 20 Mar 2024 18:00:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464D16A03F
	for <netfilter-devel@vger.kernel.org>; Wed, 20 Mar 2024 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957657; cv=none; b=clX1DFrPevWUcn9RtY4Eut147fMfhfIp1NNTuWbNU/dA3iL35b8ydkCI6Xa9DPb3JFRPfpbGeWD3hsIX90wR1uAho3vsgUNmG8CBMgHozvbjH4xtSHKeibfGx2RJy5TWUUPoUf0Ni8bLzlPtIUTX+aJ5EMW2fJhlvnSgwFyw5lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957657; c=relaxed/simple;
	bh=btyW7UrrXjXT/fV6eQBA13JB1r0lqqHOeo1zEkgiups=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH1JdSeITtLvqEA6rBtt+b7UQaB2OdYGBKor8cYlL2AGPZeoFe/bdqo63Dc2Rgm/JACxLBBaX7BDH7T2oDE7p7feOGiCXLbqA0TJXWJe5LIixDv64oVe9nCVmOftp8sKstW4W8XKl+aPj2/nVbvtYiEDvvwCDnQblUgElDK7KSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Wed, 20 Mar 2024 19:00:49 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] netlink_delinearize: reverse cross-day meta hour
 range
Message-ID: <ZfskQp25Lrthbpmo@calendula>
References: <20240319192609.218891-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319192609.218891-1-pablo@netfilter.org>

On Tue, Mar 19, 2024 at 08:26:09PM +0100, Pablo Neira Ayuso wrote:
> f8f32deda31d ("meta: Introduce new conditions 'time', 'day' and 'hour'")
> reverses the hour range in case that a cross-day range is used, eg.
> 
>   meta hour "03:01"-"08:00" counter accept

This example is not correct, this should be:

    meta hour "03:00"-"14:00" counter accept

> which results in (Sidney, Australia AEDT time):
> 
>   meta hour != "14:00"-"03:00" counter accept

which results in this awkward reversed range.

Amended and pushed it out.

> from the list ruleset path, which not very intuitive to the reader.
> 
> Complete netlink delinearize path to reverse the cross-day meta range.
> 
> Note that kernel handles time in UTC, therefore, cross-day range may
> not be look according to local time.
> 
> Update manpage to recommend to use a range expression when matching meta
> hour range.
> 
> While at it, update manpage to recommend to use a range with meta time
> and meta day too.
> 
> Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1737
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  doc/primary-expression.txt | 12 +++++++++---
>  include/expression.h       |  1 +
>  include/meta.h             |  2 ++
>  src/evaluate.c             |  8 ++++----
>  src/netlink_delinearize.c  | 22 ++++++++++++++++++++++
>  5 files changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/doc/primary-expression.txt b/doc/primary-expression.txt
> index e13970cfb650..782494bda6f3 100644
> --- a/doc/primary-expression.txt
> +++ b/doc/primary-expression.txt
> @@ -168,15 +168,18 @@ Either an integer or a date in ISO format. For example: "2019-06-06 17:00".
>  Hour and seconds are optional and can be omitted if desired. If omitted,
>  midnight will be assumed.
>  The following three would be equivalent: "2019-06-06", "2019-06-06 00:00"
> -and "2019-06-06 00:00:00".
> +and "2019-06-06 00:00:00". Use a range expression such as
> +"2019-06-06 10:00"-"2019-06-10 14:00" for matching a time range.
>  When an integer is given, it is assumed to be a UNIX timestamp.
>  |day|
>  Either a day of week ("Monday", "Tuesday", etc.), or an integer between 0 and 6.
>  Strings are matched case-insensitively, and a full match is not expected (e.g. "Mon" would match "Monday").
> -When an integer is given, 0 is Sunday and 6 is Saturday.
> +When an integer is given, 0 is Sunday and 6 is Saturday. Use a range expression
> +such as "Monday"-"Wednesday" for matching a week day range.
>  |hour|
>  A string representing an hour in 24-hour format. Seconds can optionally be specified.
> -For example, 17:00 and 17:00:00 would be equivalent.
> +For example, 17:00 and 17:00:00 would be equivalent. Use a range expression such
> +as "17:00"-"19:00" for matching a time range.
>  |=============================
>  
>  .Using meta expressions
> @@ -190,6 +193,9 @@ filter output oif eth0
>  
>  # incoming packet was subject to ipsec processing
>  raw prerouting meta ipsec exists accept
> +
> +# match incoming packet from 03:00 to 14:00 local time
> +raw prerouting meta hour "03:00"-"14:00" counter accept
>  -----------------------
>  
>  SOCKET EXPRESSION
> diff --git a/include/expression.h b/include/expression.h
> index f5d7e160a9aa..01b45b7c83b9 100644
> --- a/include/expression.h
> +++ b/include/expression.h
> @@ -530,5 +530,6 @@ struct expr *flagcmp_expr_alloc(const struct location *loc, enum ops op,
>  
>  extern void range_expr_value_low(mpz_t rop, const struct expr *expr);
>  extern void range_expr_value_high(mpz_t rop, const struct expr *expr);
> +void range_expr_swap_values(struct expr *range);
>  
>  #endif /* NFTABLES_EXPRESSION_H */
> diff --git a/include/meta.h b/include/meta.h
> index 1478902ed141..af2d772bb6a0 100644
> --- a/include/meta.h
> +++ b/include/meta.h
> @@ -45,4 +45,6 @@ extern const struct datatype date_type;
>  extern const struct datatype hour_type;
>  extern const struct datatype day_type;
>  
> +bool lhs_is_meta_hour(const struct expr *meta);
> +
>  #endif /* NFTABLES_META_H */
> diff --git a/src/evaluate.c b/src/evaluate.c
> index 5b585714180d..e3ead3329636 100644
> --- a/src/evaluate.c
> +++ b/src/evaluate.c
> @@ -2470,7 +2470,7 @@ static int binop_transfer(struct eval_ctx *ctx, struct expr **expr)
>  	return 0;
>  }
>  
> -static bool lhs_is_meta_hour(const struct expr *meta)
> +bool lhs_is_meta_hour(const struct expr *meta)
>  {
>  	if (meta->etype != EXPR_META)
>  		return false;
> @@ -2479,7 +2479,7 @@ static bool lhs_is_meta_hour(const struct expr *meta)
>  	       meta->meta.key == NFT_META_TIME_DAY;
>  }
>  
> -static void swap_values(struct expr *range)
> +void range_expr_swap_values(struct expr *range)
>  {
>  	struct expr *left_tmp;
>  
> @@ -2561,10 +2561,10 @@ static int expr_evaluate_relational(struct eval_ctx *ctx, struct expr **expr)
>  					  "Inverting range values for cross-day hour matching\n\n");
>  
>  			if (rel->op == OP_EQ || rel->op == OP_IMPLICIT) {
> -				swap_values(range);
> +				range_expr_swap_values(range);
>  				rel->op = OP_NEQ;
>  			} else if (rel->op == OP_NEQ) {
> -				swap_values(range);
> +				range_expr_swap_values(range);
>  				rel->op = OP_EQ;
>  			}
>  		}
> diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
> index 405a065bc98f..5a4cf1b88110 100644
> --- a/src/netlink_delinearize.c
> +++ b/src/netlink_delinearize.c
> @@ -2847,6 +2847,28 @@ static void expr_postprocess(struct rule_pp_ctx *ctx, struct expr **exprp)
>  			expr_postprocess(ctx, &expr->left);
>  			ctx->set = NULL;
>  			break;
> +		case EXPR_UNARY:
> +			if (lhs_is_meta_hour(expr->left->arg) &&
> +			    expr->right->etype == EXPR_RANGE) {
> +				struct expr *range = expr->right;
> +
> +				/* Cross-day range needs to be reversed.
> +				 * Kernel handles time in UTC. Therefore,
> +				 * 03:00-14:00 AEDT (Sidney, Australia) time
> +				 * is a cross-day range.
> +				 */
> +				if (mpz_cmp(range->left->value,
> +					    range->right->value) <= 0) {
> +					if (expr->op == OP_NEQ) {
> +		                                range_expr_swap_values(range);
> +		                                expr->op = OP_IMPLICIT;
> +					} else if (expr->op == OP_IMPLICIT) {
> +		                                range_expr_swap_values(range);
> +					        expr->op = OP_NEG;
> +					}
> +				}
> +			}
> +			/* fallthrough */
>  		default:
>  			expr_postprocess(ctx, &expr->left);
>  			break;
> -- 
> 2.30.2
> 
> 

