Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81AF7E06F7
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Nov 2023 17:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjKCQrI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Nov 2023 12:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjKCQrI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:47:08 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEA3FB
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Nov 2023 09:47:04 -0700 (PDT)
Received: from [78.30.35.151] (port=35928 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qyxK0-00FuHp-F8; Fri, 03 Nov 2023 17:47:02 +0100
Date:   Fri, 3 Nov 2023 17:46:59 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft v3 2/2] json: drop warning on stderr for missing
 json() hook in stmt_print_json()
Message-ID: <ZUUkA43oAM7XO7LU@calendula>
References: <20231103162937.3352069-1-thaller@redhat.com>
 <20231103162937.3352069-3-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231103162937.3352069-3-thaller@redhat.com>
X-Spam-Score: -1.8 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Nov 03, 2023 at 05:25:14PM +0100, Thomas Haller wrote:
> diff --git a/src/statement.c b/src/statement.c
> index f5176e6d87f9..d52b01b9099a 100644
> --- a/src/statement.c
> +++ b/src/statement.c
> @@ -141,6 +141,7 @@ static const struct stmt_ops chain_stmt_ops = {
>  	.type		= STMT_CHAIN,
>  	.name		= "chain",
>  	.print		= chain_stmt_print,
> +	.json		= NULL, /* BUG: must be implemented! */

This is a bit starting the house from the roof.

Better fix this first, so this ugly patch does not need to be applied.
