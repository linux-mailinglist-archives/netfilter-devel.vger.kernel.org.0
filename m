Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D988678B402
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Aug 2023 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjH1PI2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Aug 2023 11:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjH1PIO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:08:14 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF4DD9
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Aug 2023 08:08:11 -0700 (PDT)
Received: from [78.30.34.192] (port=39400 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qadqZ-00AJVh-EC; Mon, 28 Aug 2023 17:08:10 +0200
Date:   Mon, 28 Aug 2023 17:08:06 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 8/8] datatype: suppress "-Wformat-nonliteral" warning
 in integer_type_print()
Message-ID: <ZOy4VvjT/vxpR5iR@calendula>
References: <20230828144441.3303222-1-thaller@redhat.com>
 <20230828144441.3303222-9-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828144441.3303222-9-thaller@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Aug 28, 2023 at 04:43:58PM +0200, Thomas Haller wrote:
>     datatype.c:455:22: error: format string is not a string literal [-Werror,-Wformat-nonliteral]
>             nft_gmp_print(octx, fmt, expr->value);
>                                 ^~~
> 
> Signed-off-by: Thomas Haller <thaller@redhat.com>
> ---
>  src/datatype.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/datatype.c b/src/datatype.c
> index 4d0e44eeb500..12fe7141709d 100644
> --- a/src/datatype.c
> +++ b/src/datatype.c
> @@ -452,7 +452,9 @@ static void integer_type_print(const struct expr *expr, struct output_ctx *octx)
>  		}
>  	} while ((dtype = dtype->basetype));
>  
> +	_NFT_PRAGMA_WARNING_DISABLE("-Wformat-nonliteral")

Maybe simply -Wno-format-nonliteral turn off in Clang so there is no
need for this PRAGMA in order to simplify things.

>  	nft_gmp_print(octx, fmt, expr->value);
> +	_NFT_PRAGMA_WARNING_REENABLE
>  }
>  
>  static struct error_record *integer_type_parse(struct parse_ctx *ctx,
> -- 
> 2.41.0
> 
