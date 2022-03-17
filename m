Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B234DC68D
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Mar 2022 13:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiCQMzA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Mar 2022 08:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbiCQMyb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:54:31 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4254B1EC6D
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Mar 2022 05:53:15 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nUpcv-0005Rd-Dq; Thu, 17 Mar 2022 13:53:13 +0100
Date:   Thu, 17 Mar 2022 13:53:13 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf 1/2] netfilter: nf_tables: registers should not go
 over NFT_REG32_NUM
Message-ID: <20220317125313.GB9722@breakpoint.cc>
References: <20220317123937.21345-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317123937.21345-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Bail out in case userspace uses registers over maximum number of register.
> 
> Fixes: 49499c3e6e18 ("netfilter: nf_tables: switch registers to 32 bit addressing")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  net/netfilter/nf_tables_api.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index d71a33ae39b3..829ecd310ae6 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -9275,17 +9275,24 @@ int nft_parse_u32_check(const struct nlattr *attr, int max, u32 *dest)
>  }
>  EXPORT_SYMBOL_GPL(nft_parse_u32_check);
>  
> -static unsigned int nft_parse_register(const struct nlattr *attr)
> +static unsigned int nft_parse_register(const struct nlattr *attr, u32 *preg)
>  {
>  	unsigned int reg;
>  
>  	reg = ntohl(nla_get_be32(attr));
> +	if (reg >= NFT_REG32_NUM)
> +		return -ERANGE;
> +

This breaks userspace.

NFT_REG32_00 is 8, so this makes NFT_REG32_13, 14 and 15 invalid.
