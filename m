Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64AA737123
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jun 2023 18:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjFTQEl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Jun 2023 12:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjFTQEk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:04:40 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBF8B10F1
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Jun 2023 09:04:36 -0700 (PDT)
Date:   Tue, 20 Jun 2023 18:04:33 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] cli: Make valgrind happy
Message-ID: <ZJHOEff+hNaj6g8e@calendula>
References: <20230620140352.21633-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230620140352.21633-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 20, 2023 at 04:03:52PM +0200, Phil Sutter wrote:
> Missing call to nft_ctx_free() upsets valgrind enough to suspect
> possible losses, add them where sensible. This fixes reports with
> readline-lined builds at least. The same code is shared for libedit
> though, and there's an obvious spot for linenoise.

Maybe call nft_ctx_free() from cli_exit() ?

> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  src/cli.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/src/cli.c b/src/cli.c
> index 11fc85abeaa2b..bc7f64ef0b762 100644
> --- a/src/cli.c
> +++ b/src/cli.c
> @@ -126,6 +126,7 @@ static void cli_complete(char *line)
>  	if (line == NULL) {
>  		printf("\n");
>  		cli_exit();
> +		nft_ctx_free(cli_nft);
>  		exit(0);
>  	}
>  
> @@ -141,6 +142,7 @@ static void cli_complete(char *line)
>  
>  	if (!strcmp(line, CMDLINE_QUIT)) {
>  		cli_exit();
> +		nft_ctx_free(cli_nft);
>  		exit(0);
>  	}
>  
> @@ -244,6 +246,7 @@ int cli_init(struct nft_ctx *nft)
>  		linenoiseFree(line);
>  	}
>  	cli_exit();
> +	nft_ctx_free(nft);
>  	exit(0);
>  }
>  
> -- 
> 2.40.0
> 
