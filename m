Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F940636111
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Nov 2022 15:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbiKWOFZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Nov 2022 09:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbiKWOFB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:05:01 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243C65A6EA
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Nov 2022 06:01:01 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1oxqJ9-0002Km-Hk; Wed, 23 Nov 2022 15:00:59 +0100
Date:   Wed, 23 Nov 2022 15:00:59 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptables-nft] iptables-nft: exit nonzero when
 iptables-save cannot decode all expressions
Message-ID: <Y34nm0mdezcnTAKT@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20221123134929.4700-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123134929.4700-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 23, 2022 at 02:49:29PM +0100, Florian Westphal wrote:
> We always return 0, even if we printed some error message half-way.
> Increment an error counter whenever an error message was printed so that
> the chain-loop can exit with an error if this counter is nonzero.
> 
> Another effect is that iptables-restore won't have a chance to print the
                                  ~~~~~~~
*save?

[...]
> diff --git a/iptables/nft.c b/iptables/nft.c
> index 4c0110bb8040..67c5877ce9cc 100644
> --- a/iptables/nft.c
> +++ b/iptables/nft.c
[...]
> @@ -1919,6 +1927,9 @@ int nft_rule_save(struct nft_handle *h, const char *table, unsigned int format)
>  
>  	ret = nft_chain_foreach(h, table, nft_rule_save_cb, &d);
>  
> +	if (ret == 0 && d.errors)
> +		xtables_error(VERSION_PROBLEM, "Cannot decode all rules provided by kernel");

*by the kernel?

My English is certainly worse than yours, though. :D

Apart from that,

Acked-by: Phil Sutter <phil@nwl.cc>

Thanks!
