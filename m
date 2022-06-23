Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB8558946
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Jun 2022 21:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiFWTky (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Jun 2022 15:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiFWTki (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:40:38 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1E187FD09
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Jun 2022 12:30:22 -0700 (PDT)
Date:   Thu, 23 Jun 2022 21:30:18 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Mikhail Sennikovsky <mikhail.sennikovskii@ionos.com>
Cc:     netfilter-devel@vger.kernel.org, mikhail.sennikovsky@gmail.com
Subject: Re: [PATCH 2/6] conntrack: set reply l4 proto for unknown protocol
Message-ID: <YrS/SrqYVS5NPMRO@salvia>
References: <20220623175000.49259-1-mikhail.sennikovskii@ionos.com>
 <20220623175000.49259-3-mikhail.sennikovskii@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220623175000.49259-3-mikhail.sennikovskii@ionos.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jun 23, 2022 at 07:49:56PM +0200, Mikhail Sennikovsky wrote:
> Withouth reply l4 protocol being set consistently the mnl_cb_run
> (in fact the kernel) would return EINVAL.
> 
> Make sure the reply l4 protocol is set properly for unknown
> protocols.
> 
> Signed-off-by: Mikhail Sennikovsky <mikhail.sennikovskii@ionos.com>
> ---
>  extensions/libct_proto_unknown.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/extensions/libct_proto_unknown.c b/extensions/libct_proto_unknown.c
> index 2a47704..992b1ed 100644
> --- a/extensions/libct_proto_unknown.c
> +++ b/extensions/libct_proto_unknown.c
> @@ -21,10 +21,21 @@ static void help(void)
>  	fprintf(stdout, "  no options (unsupported)\n");
>  }
>  
> +static void final_check(unsigned int flags,
> +		        unsigned int cmd,
> +		        struct nf_conntrack *ct)
> +{
> +	if (nfct_attr_is_set(ct, ATTR_REPL_L3PROTO) &&
> +	    nfct_attr_is_set(ct, ATTR_L4PROTO) &&
> +	    !nfct_attr_is_set(ct, ATTR_REPL_L4PROTO))
> +		nfct_set_attr_u8(ct, ATTR_REPL_L4PROTO, nfct_get_attr_u8(ct, ATTR_L4PROTO));
> +}
> +
>  struct ctproto_handler ct_proto_unknown = {
>  	.name 		= "unknown",
>  	.help		= help,
>  	.opts		= opts,
> +	.final_check = final_check,

missing indent to align it with other C99 initializers (coding style nitpick)

	.final_check    = final_check,

>  	.version	= VERSION,
>  };
>  
> -- 
> 2.25.1
> 
