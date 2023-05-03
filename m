Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E0C6F5E77
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 May 2023 20:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjECSsC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 May 2023 14:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjECSru (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 May 2023 14:47:50 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26B583F6
        for <netfilter-devel@vger.kernel.org>; Wed,  3 May 2023 11:47:13 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1puHVM-0000Zc-8m; Wed, 03 May 2023 20:47:08 +0200
Date:   Wed, 3 May 2023 20:47:08 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Boris Sukholitko <boris.sukholitko@broadcom.com>
Cc:     netfilter-devel@vger.kernel.org,
        Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: Re: [PATCH nf-next 01/19] selftest: netfilter: use /proc for pid
 checking
Message-ID: <20230503184708.GC28036@breakpoint.cc>
References: <20230503125552.41113-1-boris.sukholitko@broadcom.com>
 <20230503125552.41113-2-boris.sukholitko@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503125552.41113-2-boris.sukholitko@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Boris Sukholitko <boris.sukholitko@broadcom.com> wrote:
> Some ps commands (e.g. busybox derived) have no -p option. Use /proc for
> pid existence check.
> 
> Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
> ---
>  tools/testing/selftests/netfilter/nft_flowtable.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/netfilter/nft_flowtable.sh b/tools/testing/selftests/netfilter/nft_flowtable.sh
> index 7060bae04ec8..4d8bc51b7a7b 100755
> --- a/tools/testing/selftests/netfilter/nft_flowtable.sh
> +++ b/tools/testing/selftests/netfilter/nft_flowtable.sh
> @@ -288,11 +288,11 @@ test_tcp_forwarding_ip()
>  
>  	sleep 3
>  
> -	if ps -p $lpid > /dev/null;then
> +	if test -d /proc/"$lpid"/; then
>  		kill $lpid

I'd shorten both to

kill $lpid 2>/dev/null
