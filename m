Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4184D4C39BB
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Feb 2022 00:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbiBXXic (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Feb 2022 18:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiBXXic (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:38:32 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67CA618E3EE
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Feb 2022 15:38:01 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 6C73A6433D;
        Fri, 25 Feb 2022 00:36:51 +0100 (CET)
Date:   Fri, 25 Feb 2022 00:37:58 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Sam James <sam@gentoo.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 1/2] libnftables.map: export new
 nft_ctx_{get,set}_optimize API
Message-ID: <YhgW1h1+TMhWsul4@salvia>
References: <20220224194543.59581-1-sam@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224194543.59581-1-sam@gentoo.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Feb 24, 2022 at 07:45:42PM +0000, Sam James wrote:
> Without this, we're not explicitly saying this is part of the public
> API.
> 
> This new API was added in 1.0.2 and is used by e.g. the main
> nft binary. Noticed when fixing the version-script option
> (separate patch) which picked up this problem when .map
> was missing symbols (related to when symbol visibility
> options get set).

Applied.

> Signed-off-by: Sam James <sam@gentoo.org>
> ---
>  src/libnftables.map | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/libnftables.map b/src/libnftables.map
> index a511dd78..f8cf05dc 100644
> --- a/src/libnftables.map
> +++ b/src/libnftables.map
> @@ -32,4 +32,6 @@ LIBNFTABLES_2 {
>  LIBNFTABLES_3 {
>    nft_set_optimize;
>    nft_get_optimize;

Removed the incorrect symbol name (missing _ctx_ infix)

> +  nft_ctx_set_optimize;
> +  nft_ctx_get_optimize;
>  } LIBNFTABLES_2;
> -- 
> 2.35.1
> 
