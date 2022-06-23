Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16755893A
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Jun 2022 21:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiFWTjd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Jun 2022 15:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiFWTjK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:39:10 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09CFB2DFC
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Jun 2022 12:27:37 -0700 (PDT)
Date:   Thu, 23 Jun 2022 21:27:33 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Mikhail Sennikovsky <mikhail.sennikovskii@ionos.com>
Cc:     netfilter-devel@vger.kernel.org, mikhail.sennikovsky@gmail.com
Subject: Re: [PATCH 6/6] conntrack: fix -o save dump for unknown protocols
Message-ID: <YrS+pfx7yxkuzXAH@salvia>
References: <20220623175000.49259-1-mikhail.sennikovskii@ionos.com>
 <20220623175000.49259-7-mikhail.sennikovskii@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220623175000.49259-7-mikhail.sennikovskii@ionos.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jun 23, 2022 at 07:50:00PM +0200, Mikhail Sennikovsky wrote:
> Make sure the protocol (-p) option is included in the -o save
> ct entry dumps for L4 protocols unknown to the conntrack tool
> 
> Signed-off-by: Mikhail Sennikovsky <mikhail.sennikovskii@ionos.com>
> ---
>  src/conntrack.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/src/conntrack.c b/src/conntrack.c
> index dca7da6..f8a228f 100644
> --- a/src/conntrack.c
> +++ b/src/conntrack.c
> @@ -870,9 +870,18 @@ static int ct_save_snprintf(char *buf, size_t len,
>  
>  		ret = ct_snprintf_opts(buf + offset, len, ct, cur->print_opts);
>  		BUFFER_SIZE(ret, size, len, offset);
> -		break;
> +		goto done_proto4;

I'd suggest:

                l4proto_set = true;

so you can remove this goto.

>  	}
>  
> +	/**
> +	 * Do not use getprotobynumber here to ensure
> +	 * "-o save" data incompatibility between hosts having
> +	 * different /etc/protocols contents
> +	 */

No need for this comment, explain this in the commit message, git
annotate will help to find the reason for this.

> +	ret = snprintf(buf + offset, len, "-p %d ", l4proto);
> +	BUFFER_SIZE(ret, size, len, offset);

        if (!l4proto_set) {
                ret = snprintf(buf + offset, len, "-p %d ", l4proto);
                BUFFER_SIZE(ret, size, len, offset);
        }

> +
> +done_proto4:
>  	/* skip trailing space, if any */
>  	for (; size && buf[size-1] == ' '; --size)
>  		buf[size-1] = '\0';
> -- 
> 2.25.1
> 
