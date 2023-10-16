Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F787CB36F
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Oct 2023 21:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjJPToA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Oct 2023 15:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjJPTn7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:43:59 -0400
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [IPv6:2001:738:5001::48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EB883
        for <netfilter-devel@vger.kernel.org>; Mon, 16 Oct 2023 12:43:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id AF42CCC02B7;
        Mon, 16 Oct 2023 21:43:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Mon, 16 Oct 2023 21:43:50 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id 76984CC011E;
        Mon, 16 Oct 2023 21:43:49 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id 698A93431A8; Mon, 16 Oct 2023 21:43:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by blackhole.kfki.hu (Postfix) with ESMTP id 67C51340D74;
        Mon, 16 Oct 2023 21:43:49 +0200 (CEST)
Date:   Mon, 16 Oct 2023 21:43:49 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
To:     xiaolinkui <xiaolinkui@gmail.com>
cc:     pablo@netfilter.org, fw@strlen.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        justinstitt@google.com, kuniyu@amazon.com,
        netfilter-devel@vger.kernel.org,
        Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH 1/2] netfilter: ipset: rename ref_netlink to
 ref_swapping
In-Reply-To: <20231016135204.27443-1-xiaolinkui@gmail.com>
Message-ID: <8bfa286f-d311-745a-495-f7fce859b7c3@netfilter.org>
References: <20231016135204.27443-1-xiaolinkui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello,

On Mon, 16 Oct 2023, xiaolinkui wrote:

> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> The ref_netlink appears to solve the swap race problem. In addition to the
> netlink events, there are other factors that trigger this race condition.
> The race condition in the ip_set_test will be fixed in the next patch.

Sorry, I do not accept this patch. It adds nothing to the code, it's just 
renaming. Additionally it renames a generic, netlink-centric object to a 
specific one which just confuses the reader of the code.

Best regards,
Jozsef
 
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  include/linux/netfilter/ipset/ip_set.h |  4 +--
>  net/netfilter/ipset/ip_set_core.c      | 34 +++++++++++++-------------
>  2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/netfilter/ipset/ip_set.h b/include/linux/netfilter/ipset/ip_set.h
> index e8c350a3ade1..32c56f1a43f2 100644
> --- a/include/linux/netfilter/ipset/ip_set.h
> +++ b/include/linux/netfilter/ipset/ip_set.h
> @@ -248,10 +248,10 @@ struct ip_set {
>  	spinlock_t lock;
>  	/* References to the set */
>  	u32 ref;
> -	/* References to the set for netlink events like dump,
> +	/* References to the set for netlink/test events,
>  	 * ref can be swapped out by ip_set_swap
>  	 */
> -	u32 ref_netlink;
> +	u32 ref_swapping;
>  	/* The core set type */
>  	struct ip_set_type *type;
>  	/* The type variant doing the real job */
> diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
> index 35d2f9c9ada0..e5d25df5c64c 100644
> --- a/net/netfilter/ipset/ip_set_core.c
> +++ b/net/netfilter/ipset/ip_set_core.c
> @@ -59,7 +59,7 @@ MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_IPSET);
>  		lockdep_is_held(&ip_set_ref_lock))
>  #define ip_set(inst, id)		\
>  	ip_set_dereference((inst)->ip_set_list)[id]
> -#define ip_set_ref_netlink(inst,id)	\
> +#define ip_set_ref_swapping(inst, id)	\
>  	rcu_dereference_raw((inst)->ip_set_list)[id]
>  
>  /* The set types are implemented in modules and registered set types
> @@ -683,19 +683,19 @@ __ip_set_put(struct ip_set *set)
>   * a separate reference counter
>   */
>  static void
> -__ip_set_get_netlink(struct ip_set *set)
> +__ip_set_get_swapping(struct ip_set *set)
>  {
>  	write_lock_bh(&ip_set_ref_lock);
> -	set->ref_netlink++;
> +	set->ref_swapping++;
>  	write_unlock_bh(&ip_set_ref_lock);
>  }
>  
>  static void
> -__ip_set_put_netlink(struct ip_set *set)
> +__ip_set_put_swapping(struct ip_set *set)
>  {
>  	write_lock_bh(&ip_set_ref_lock);
> -	BUG_ON(set->ref_netlink == 0);
> -	set->ref_netlink--;
> +	BUG_ON(set->ref_swapping == 0);
> +	set->ref_swapping--;
>  	write_unlock_bh(&ip_set_ref_lock);
>  }
>  
> @@ -1213,7 +1213,7 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
>  	if (!attr[IPSET_ATTR_SETNAME]) {
>  		for (i = 0; i < inst->ip_set_max; i++) {
>  			s = ip_set(inst, i);
> -			if (s && (s->ref || s->ref_netlink)) {
> +			if (s && (s->ref || s->ref_swapping)) {
>  				ret = -IPSET_ERR_BUSY;
>  				goto out;
>  			}
> @@ -1237,7 +1237,7 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
>  			if (!(flags & IPSET_FLAG_EXIST))
>  				ret = -ENOENT;
>  			goto out;
> -		} else if (s->ref || s->ref_netlink) {
> +		} else if (s->ref || s->ref_swapping) {
>  			ret = -IPSET_ERR_BUSY;
>  			goto out;
>  		}
> @@ -1321,7 +1321,7 @@ static int ip_set_rename(struct sk_buff *skb, const struct nfnl_info *info,
>  		return -ENOENT;
>  
>  	write_lock_bh(&ip_set_ref_lock);
> -	if (set->ref != 0 || set->ref_netlink != 0) {
> +	if (set->ref != 0 || set->ref_swapping != 0) {
>  		ret = -IPSET_ERR_REFERENCED;
>  		goto out;
>  	}
> @@ -1383,7 +1383,7 @@ static int ip_set_swap(struct sk_buff *skb, const struct nfnl_info *info,
>  
>  	write_lock_bh(&ip_set_ref_lock);
>  
> -	if (from->ref_netlink || to->ref_netlink) {
> +	if (from->ref_swapping || to->ref_swapping) {
>  		write_unlock_bh(&ip_set_ref_lock);
>  		return -EBUSY;
>  	}
> @@ -1441,12 +1441,12 @@ ip_set_dump_done(struct netlink_callback *cb)
>  		struct ip_set_net *inst =
>  			(struct ip_set_net *)cb->args[IPSET_CB_NET];
>  		ip_set_id_t index = (ip_set_id_t)cb->args[IPSET_CB_INDEX];
> -		struct ip_set *set = ip_set_ref_netlink(inst, index);
> +		struct ip_set *set = ip_set_ref_swapping(inst, index);
>  
>  		if (set->variant->uref)
>  			set->variant->uref(set, cb, false);
>  		pr_debug("release set %s\n", set->name);
> -		__ip_set_put_netlink(set);
> +		__ip_set_put_swapping(set);
>  	}
>  	return 0;
>  }
> @@ -1580,7 +1580,7 @@ ip_set_dump_do(struct sk_buff *skb, struct netlink_callback *cb)
>  		if (!cb->args[IPSET_CB_ARG0]) {
>  			/* Start listing: make sure set won't be destroyed */
>  			pr_debug("reference set\n");
> -			set->ref_netlink++;
> +			set->ref_swapping++;
>  		}
>  		write_unlock_bh(&ip_set_ref_lock);
>  		nlh = start_msg(skb, NETLINK_CB(cb->skb).portid,
> @@ -1646,11 +1646,11 @@ ip_set_dump_do(struct sk_buff *skb, struct netlink_callback *cb)
>  release_refcount:
>  	/* If there was an error or set is done, release set */
>  	if (ret || !cb->args[IPSET_CB_ARG0]) {
> -		set = ip_set_ref_netlink(inst, index);
> +		set = ip_set_ref_swapping(inst, index);
>  		if (set->variant->uref)
>  			set->variant->uref(set, cb, false);
>  		pr_debug("release set %s\n", set->name);
> -		__ip_set_put_netlink(set);
> +		__ip_set_put_swapping(set);
>  		cb->args[IPSET_CB_ARG0] = 0;
>  	}
>  out:
> @@ -1701,11 +1701,11 @@ call_ad(struct net *net, struct sock *ctnl, struct sk_buff *skb,
>  
>  	do {
>  		if (retried) {
> -			__ip_set_get_netlink(set);
> +			__ip_set_get_swapping(set);
>  			nfnl_unlock(NFNL_SUBSYS_IPSET);
>  			cond_resched();
>  			nfnl_lock(NFNL_SUBSYS_IPSET);
> -			__ip_set_put_netlink(set);
> +			__ip_set_put_swapping(set);
>  		}
>  
>  		ip_set_lock(set);
> -- 
> 2.17.1
> 
> 

-- 
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
