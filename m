Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2919859F37A
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Aug 2022 08:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiHXGLy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Aug 2022 02:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbiHXGLv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:11:51 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63A3E2CE14
        for <netfilter-devel@vger.kernel.org>; Tue, 23 Aug 2022 23:11:50 -0700 (PDT)
Date:   Wed, 24 Aug 2022 08:11:47 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Harsh Modi <harshmodi@google.com>
Cc:     netfilter-devel@vger.kernel.org, sdf@google.com,
        kadlec@netfilter.org, fw@strlen.de
Subject: Re: [PATCH] br_netfilter: Drop dst references before setting.
Message-ID: <YwXBIz3RyZvshuXi@salvia>
References: <20220823023814.1666916-1-harshmodi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220823023814.1666916-1-harshmodi@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Mon, Aug 22, 2022 at 07:38:14PM -0700, Harsh Modi wrote:
> It is possible that there is already a dst allocated.

This is bridge path, do you know what might have already set up the
dst to the skbuff? Is this a theoretical issue or you are observing a
dst leak there?

> If it is not released, it will be leaked. This is similar to what is
> done in bpf_set_tunnel_key().
> 
> Signed-off-by: Harsh Modi <harshmodi@google.com>
> ---
>  net/bridge/br_netfilter_hooks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
> index ff4779036649..f20f4373ff40 100644
> --- a/net/bridge/br_netfilter_hooks.c
> +++ b/net/bridge/br_netfilter_hooks.c
> @@ -384,6 +384,7 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
>  				/* - Bridged-and-DNAT'ed traffic doesn't
>  				 *   require ip_forwarding. */
>  				if (rt->dst.dev == dev) {
> +					skb_dst_drop(skb);
>  					skb_dst_set(skb, &rt->dst);
>  					goto bridged_dnat;
>  				}
> @@ -413,6 +414,7 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
>  			kfree_skb(skb);
>  			return 0;
>  		}
> +		skb_dst_drop(skb);
>  		skb_dst_set_noref(skb, &rt->dst);
>  	}
>  
> -- 
> 2.37.1.595.g718a3a8f04-goog
> 
