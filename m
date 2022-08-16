Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD275964D1
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Aug 2022 23:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbiHPVkm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 Aug 2022 17:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbiHPVkl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:40:41 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AE527A50A
        for <netfilter-devel@vger.kernel.org>; Tue, 16 Aug 2022 14:40:40 -0700 (PDT)
Date:   Tue, 16 Aug 2022 23:40:33 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Quentin Armitage <quentin@armitage.org.uk>
Cc:     netfilter-devel@vger.kernel.org,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Subject: Re: [PATCH] ipset-translate: allow invoking with a path name
Message-ID: <YvwO0SAEtDRLkBH6@salvia>
References: <20220811165218.59854-1-quentin@armitage.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220811165218.59854-1-quentin@armitage.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Applied, thanks.

On Thu, Aug 11, 2022 at 05:52:18PM +0100, Quentin Armitage wrote:
> Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>
> ---
>  src/ipset.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/ipset.c b/src/ipset.c
> index 6d42b60..e53ffb1 100644
> --- a/src/ipset.c
> +++ b/src/ipset.c
> @@ -6,6 +6,8 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> +#define _GNU_SOURCE
> +
>  #include <assert.h>			/* assert */
>  #include <stdio.h>			/* fprintf */
>  #include <stdlib.h>			/* exit */
> @@ -31,7 +33,7 @@ main(int argc, char *argv[])
>  		exit(1);
>  	}
>  
> -	if (!strcmp(argv[0], "ipset-translate")) {
> +	if (!strcmp(basename(argv[0]), "ipset-translate")) {
>  		ret = ipset_xlate_argv(ipset, argc, argv);
>  	} else {
>  		ret = ipset_parse_argv(ipset, argc, argv);
> -- 
> 2.34.3
> 
