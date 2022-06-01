Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E8C53A5EF
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jun 2022 15:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbiFAN1f (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Jun 2022 09:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245537AbiFAN1f (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:27:35 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACA8D1116
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Jun 2022 06:27:31 -0700 (PDT)
Date:   Wed, 1 Jun 2022 15:27:26 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nf PATCH] netfilter: nft_nat: Fix inet l4-only NAT
Message-ID: <YpdpPliovU+oqi+6@salvia>
References: <20220601131914.13322-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601131914.13322-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 01, 2022 at 03:19:14PM +0200, Phil Sutter wrote:
> If nat expression does not specify an address, its family value is
> NFPROTO_INET. Disable the check against the packet's family in that
> case.
> 
> Fixes: a33f387ecd5aa ("netfilter: nft_nat: allow to specify layer 4 protocol NAT only")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Florian posted this:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20220601084735.79090-1-fw@strlen.de/

> ---
>  net/netfilter/nft_nat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nft_nat.c b/net/netfilter/nft_nat.c
> index 4394df4bc99b4..4ee690bdbf392 100644
> --- a/net/netfilter/nft_nat.c
> +++ b/net/netfilter/nft_nat.c
> @@ -335,7 +335,7 @@ static void nft_nat_inet_eval(const struct nft_expr *expr,
>  {
>  	const struct nft_nat *priv = nft_expr_priv(expr);
>  
> -	if (priv->family == nft_pf(pkt))
> +	if (priv->family == NFPROTO_INET || priv->family == nft_pf(pkt))
>  		nft_nat_eval(expr, regs, pkt);
>  }
>  
> -- 
> 2.34.1
> 
