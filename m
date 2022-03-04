Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E9B4CD2D1
	for <lists+netfilter-devel@lfdr.de>; Fri,  4 Mar 2022 11:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbiCDKza (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 4 Mar 2022 05:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiCDKza (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:55:30 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF1E11AEEC6
        for <netfilter-devel@vger.kernel.org>; Fri,  4 Mar 2022 02:54:42 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 0E8EB62FE6;
        Fri,  4 Mar 2022 11:53:05 +0100 (CET)
Date:   Fri, 4 Mar 2022 11:54:39 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] evaluate: init cmd pointer for new on-stack context
Message-ID: <YiHv70Oqotbs5YCx@salvia>
References: <20220304103634.13160-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220304103634.13160-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:36:34AM +0100, Florian Westphal wrote:
> else, this will segfault when trying to print the
> "table 'x' doesn't exist" error message.

LGTM, thanks. One nitpick below:

> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  src/evaluate.c                                   | 1 +
>  tests/shell/testcases/chains/0041chain_binding_0 | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/src/evaluate.c b/src/evaluate.c
> index 2732f5f49e06..07a4b0ad19b0 100644
> --- a/src/evaluate.c
> +++ b/src/evaluate.c
> @@ -3425,6 +3425,7 @@ static int stmt_evaluate_chain(struct eval_ctx *ctx, struct stmt *stmt)
>  			struct eval_ctx rule_ctx = {
>  				.nft	= ctx->nft,
>  				.msgs	= ctx->msgs,
> +				.cmd	= ctx->cmd,
>  			};
>  			struct handle h2 = {};
>  
> diff --git a/tests/shell/testcases/chains/0041chain_binding_0 b/tests/shell/testcases/chains/0041chain_binding_0
> index 59bdbe9f0ba9..806c17535002 100755
> --- a/tests/shell/testcases/chains/0041chain_binding_0
> +++ b/tests/shell/testcases/chains/0041chain_binding_0
> @@ -1,5 +1,11 @@
>  #!/bin/bash
>  
> +# no table z, caused segfault in earlier nft releases

this is no table x?

> +$NFT insert rule inet x y handle 107 'goto { log prefix "MOO! "; }'
> +if [ $? -ne 1 ]; then
> +	exit 1
> +fi
> +
>  set -e
>  
>  EXPECTED="table inet x {
> -- 
> 2.34.1
> 
