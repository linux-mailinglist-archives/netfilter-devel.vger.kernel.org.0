Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5DB4FF66
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Jun 2019 04:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfFXC3z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 23 Jun 2019 22:29:55 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:50384 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727095AbfFXC3z (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:29:55 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hfBPj-0004tR-U5; Mon, 24 Jun 2019 00:56:48 +0200
Date:   Mon, 24 Jun 2019 00:56:47 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ander Juaristi <a@juaristi.eus>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] nft_meta: Introduce new conditions 'time', 'day' and
 'hour'
Message-ID: <20190623225647.2s6m74t4y5pkj5pk@breakpoint.cc>
References: <20190623160758.10925-1-a@juaristi.eus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190623160758.10925-1-a@juaristi.eus>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ander Juaristi <a@juaristi.eus> wrote:
> diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
> index 987d2d6ce624..a684abd00597 100644
> --- a/net/netfilter/nft_meta.c
> +++ b/net/netfilter/nft_meta.c
> @@ -50,6 +50,7 @@ void nft_meta_get_eval(const struct nft_expr *expr,
>  	const struct net_device *in = nft_in(pkt), *out = nft_out(pkt);
>  	struct sock *sk;
>  	u32 *dest = &regs->data[priv->dreg];
> +	s64 *d64;
>  #ifdef CONFIG_NF_TABLES_BRIDGE
>  	const struct net_bridge_port *p;
>  #endif
> @@ -254,6 +255,28 @@ void nft_meta_get_eval(const struct nft_expr *expr,
>  			goto err;
>  		strncpy((char *)dest, out->rtnl_link_ops->kind, IFNAMSIZ);
>  		break;
> +	case NFT_META_TIME:
> +		d64 = (s64 *) dest;
> +		*d64 = get_seconds();

Nit; why limit this to 1 second granularity and not use
ktime_get_real_ns()  here instead?

I don't mind, we could add NFT_META_TIME_NS if needed.

Otherwise, this looks good to me.
We could also split nft_meta_get_eval and add nft_meta_get_time_eval()
to avoid increasing size of that function but its not a huge deal
and could be done later anyway.
