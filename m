Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C037720282D
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jun 2020 05:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgFUDer (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 20 Jun 2020 23:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbgFUDer (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 20 Jun 2020 23:34:47 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5A3C061794
        for <netfilter-devel@vger.kernel.org>; Sat, 20 Jun 2020 20:34:47 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jmqkn-0003tp-Nz; Sun, 21 Jun 2020 05:34:45 +0200
Date:   Sun, 21 Jun 2020 05:34:45 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Rob Gill <rrobgill@protonmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] netfilter: Add MODULE_DESCRIPTION entries to kernel
 modules
Message-ID: <20200621033445.GI26990@breakpoint.cc>
References: <20200621002114.16509-1-rrobgill@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621002114.16509-1-rrobgill@protonmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Rob Gill <rrobgill@protonmail.com> wrote:
> The user tool modinfo is used to get information on kernel modules, including a
> description where it is available.
> 
> This patch adds a brief MODULE_DESCRIPTION to netfilter kernel modules
> (descriptions taken from Kconfig file or code comments)

> +++ b/net/bridge/netfilter/nft_meta_bridge.c
> +MODULE_DESCRIPTION("Netfilter nf_table bridge meta support");
[..]

> --- a/net/bridge/netfilter/nft_reject_bridge.c
> +MODULE_DESCRIPTION("Netfilter nf_tables bridge reject support");
[..]

> diff --git a/net/ipv4/netfilter/ipt_SYNPROXY.c b/net/ipv4/netfilter/ipt_SYNPROXY.c
> +MODULE_DESCRIPTION("SYNPROXY target support");

These three modules are called nft_meta_bridge.ko, nft_reject_bridge.ko
and ipt_SYNPROXY.ko.

I don't think the above adds anything meaningful to this.

Maybe describe what these are for instead?  E.g.

'reject packets from bridge via nftables' or something similar.

> --- a/net/ipv4/netfilter/nft_dup_ipv4.c
> +++ b/net/ipv4/netfilter/nft_dup_ipv4.c
> @@ -107,3 +107,4 @@ module_exit(nft_dup_ipv4_module_exit);
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Pablo Neira Ayuso <pablo@netfilter.org>");
>  MODULE_ALIAS_NFT_AF_EXPR(AF_INET, "dup");
> +MODULE_DESCRIPTION("IPv4 nf_tables packet duplication support");

This seens better, although i'd use nftables (no "_").

> +MODULE_DESCRIPTION("nf_tables fib / ip route lookup support");

This too.

> +MODULE_DESCRIPTION("Netfilter nf_tables passive OS fingerprint support");

This is also ok, but perhaps just 'nftables passive OS fingerprint
support" is enough.
