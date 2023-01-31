Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2567682ABE
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 Jan 2023 11:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjAaKmu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 31 Jan 2023 05:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjAaKmu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:42:50 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FBDF7EC1
        for <netfilter-devel@vger.kernel.org>; Tue, 31 Jan 2023 02:42:49 -0800 (PST)
Date:   Tue, 31 Jan 2023 11:42:43 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>,
        Wolfgang Nothdurft <wolfgang@linogate.de>
Subject: Re: [PATCH nf] netfilter: br_netfilter: disable sabotage_in hook
 after first suppression
Message-ID: <Y9jwoxBMqfs5FoZf@salvia>
References: <20230130103929.66551-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230130103929.66551-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:39:29AM +0100, Florian Westphal wrote:
> When using a xfrm interface in a bridged setup (the outgoing device is
> bridged), the incoming packets in the xfrm interface are only tracked
> in the outgoing direction.
> 
> $ brctl show
> bridge name     interfaces
> br_eth1         eth1
> 
> $ conntrack -L
> tcp 115 SYN_SENT src=192... dst=192... [UNREPLIED] ...
> 
> If br_netfilter is enabled, the first (encrypted) packet is received onR
> eth1, conntrack hooks are called from br_netfilter emulation which
> allocates nf_bridge info for this skb.
> 
> If the packet is for local machine, skb gets passed up the ip stack.
> The skb passes through ip prerouting a second time. br_netfilter
> ip_sabotage_in supresses the re-invocation of the hooks.
> 
> After this, skb gets decrypted in xfrm layer and appears in
> network stack a second time (after decyption).
> 
> Then, ip_sabotage_in is called again and suppresses netfilter
> hook invocation, even though the bridge layer never called them
> for the plaintext incarnation of the packet.
> 
> Free the bridge info after the first suppression to avoid this.

I'll add this tag (just one sufficiently old):

Fixes: c4b0e771f906 ("netfilter: avoid using skb->nf_bridge directly")

unless you prefer anything else.

Let me know, thanks.

> Reported-and-tested-by: Wolfgang Nothdurft <wolfgang@linogate.de>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  net/bridge/br_netfilter_hooks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
> index f20f4373ff40..9554abcfd5b4 100644
> --- a/net/bridge/br_netfilter_hooks.c
> +++ b/net/bridge/br_netfilter_hooks.c
> @@ -871,6 +871,7 @@ static unsigned int ip_sabotage_in(void *priv,
>  	if (nf_bridge && !nf_bridge->in_prerouting &&
>  	    !netif_is_l3_master(skb->dev) &&
>  	    !netif_is_l3_slave(skb->dev)) {
> +		nf_bridge_info_free(skb);
>  		state->okfn(state->net, state->sk, skb);
>  		return NF_STOLEN;
>  	}
> -- 
> 2.39.1
> 
