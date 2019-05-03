Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E86D12B5E
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 May 2019 12:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfECKTy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 May 2019 06:19:54 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:50402 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbfECKTy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 May 2019 06:19:54 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hMVIF-0002hV-Hy; Fri, 03 May 2019 12:19:51 +0200
Date:   Fri, 3 May 2019 12:19:51 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Cc:     fw@strlen.de, pablo@netfilter.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_conntrack_h323: Remove deprecated
 config check
Message-ID: <20190503101951.6ep6uroxtvyrfz4f@breakpoint.cc>
References: <1556853737-14697-1-git-send-email-subashab@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556853737-14697-1-git-send-email-subashab@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Subash Abhinov Kasiviswanathan <subashab@codeaurora.org> wrote:
> CONFIG_NF_CONNTRACK_IPV6 has been deprecated so replace it with
> a check for IPV6 instead.

Right, I missed this part somehow.

> Fixes: a0ae2562c6c4b2 ("netfilter: conntrack: remove l3proto abstraction")
> Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
> ---
>  include/linux/netfilter_ipv6.h         | 2 +-
>  net/netfilter/nf_conntrack_h323_main.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/netfilter_ipv6.h b/include/linux/netfilter_ipv6.h
> index 12113e5..61f7ac9 100644
> --- a/include/linux/netfilter_ipv6.h
> +++ b/include/linux/netfilter_ipv6.h
> @@ -25,7 +25,7 @@ struct ip6_rt_info {
>   * if IPv6 is a module.
>   */
>  struct nf_ipv6_ops {
> -#if IS_MODULE(CONFIG_IPV6)
> +#if IS_ENABLED(CONFIG_IPV6)

I would prefer if we could keep this as IS_ENABLED().

> diff --git a/net/netfilter/nf_conntrack_h323_main.c b/net/netfilter/nf_conntrack_h323_main.c
> index 005589c..1c6769b 100644
> --- a/net/netfilter/nf_conntrack_h323_main.c
> +++ b/net/netfilter/nf_conntrack_h323_main.c
> @@ -748,7 +748,7 @@ static int callforward_do_filter(struct net *net,
>  		}
>  		break;
>  	}
> -#if IS_ENABLED(CONFIG_NF_CONNTRACK_IPV6)
> +#if IS_ENABLED(CONFIG_IPV6)
>  	case AF_INET6: {
>  		const struct nf_ipv6_ops *v6ops;
>  		struct rt6_info *rt1, *rt2;

This branch should use nf_ip6_route() instead of v6ops->route().
