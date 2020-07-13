Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A61D218C75
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2020 18:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgGHQAu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 8 Jul 2020 12:00:50 -0400
Received: from ja.ssi.bg ([178.16.129.10]:47994 "EHLO ja.ssi.bg"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730179AbgGHQAt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:00:49 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id 068G0XkV005054;
        Wed, 8 Jul 2020 19:00:35 +0300
Date:   Wed, 8 Jul 2020 19:00:33 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Andrew Sy Kim <kim.andrewsy@gmail.com>
cc:     Wensong Zhang <wensong@linux-vs.org>,
        Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net-next] netfilter/ipvs: queue delayed work to expire
 no destination connections if expire_nodest_conn=1
In-Reply-To: <20200708135854.28944-1-kim.andrewsy@gmail.com>
Message-ID: <alpine.LFD.2.23.451.2007081847310.3373@ja.home.ssi.bg>
References: <alpine.LFD.2.22.394.2007020728470.4089@ja.home.ssi.bg> <20200708135854.28944-1-kim.andrewsy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


	Hello,

On Wed, 8 Jul 2020, Andrew Sy Kim wrote:

> When expire_nodest_conn=1 and a destination is deleted, IPVS does not
> expire the existing connections until the next matching incoming packet.
> If there are many connection entries from a single client to a single
> destination, many packets may get dropped before all the connections are
> expired (more likely with lots of UDP traffic). An optimization can be
> made where upon deletion of a destination, IPVS queues up delayed work
> to immediately expire any connections with a deleted destination. This
> ensures any reused source ports from a client (within the IPVS timeouts)
> are scheduled to new real servers instead of silently dropped.
> 
> Signed-off-by: Andrew Sy Kim <kim.andrewsy@gmail.com>
> 

	Looks good to me, thanks!

	There is one empty line here that can be removed
before applying the patch. Also, post any future patches with
version tag, eg. PATCHv2 net-next, etc. For IPVS, "ipvs:"
prefix should be enough.

Signed-off-by: Julian Anastasov <ja@ssi.bg>

> ---
> This patch was applied on top of Julian's patch "ipvs: allow
> connection reuse for unconfirmed conntrack":
> https://marc.info/?l=netfilter-devel&m=159361668110823&w=2
> 
>  include/net/ip_vs.h             | 29 ++++++++++++++++++++
>  net/netfilter/ipvs/ip_vs_conn.c | 39 +++++++++++++++++++++++++++
>  net/netfilter/ipvs/ip_vs_core.c | 47 ++++++++++++++-------------------
>  net/netfilter/ipvs/ip_vs_ctl.c  | 22 +++++++++++++++
>  4 files changed, 110 insertions(+), 27 deletions(-)
> 
> diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
> index 011f407b76fe..91a9e1d590a6 100644
> --- a/include/net/ip_vs.h
> +++ b/include/net/ip_vs.h
> @@ -14,6 +14,7 @@
>  #include <linux/spinlock.h>             /* for struct rwlock_t */
>  #include <linux/atomic.h>               /* for struct atomic_t */
>  #include <linux/refcount.h>             /* for struct refcount_t */
> +#include <linux/workqueue.h>
>  
>  #include <linux/compiler.h>
>  #include <linux/timer.h>
> @@ -886,6 +887,8 @@ struct netns_ipvs {
>  	atomic_t		conn_out_counter;
>  
>  #ifdef CONFIG_SYSCTL
> +	/* delayed work for expiring no dest connections */
> +	struct delayed_work	expire_nodest_conn_work;
>  	/* 1/rate drop and drop-entry variables */
>  	struct delayed_work	defense_work;   /* Work handler */
>  	int			drop_rate;
> @@ -1051,6 +1054,11 @@ static inline int sysctl_conn_reuse_mode(struct netns_ipvs *ipvs)
>  	return ipvs->sysctl_conn_reuse_mode;
>  }
>  
> +static inline int sysctl_expire_nodest_conn(struct netns_ipvs *ipvs)
> +{
> +	return ipvs->sysctl_expire_nodest_conn;
> +}
> +
>  static inline int sysctl_schedule_icmp(struct netns_ipvs *ipvs)
>  {
>  	return ipvs->sysctl_schedule_icmp;
> @@ -1138,6 +1146,11 @@ static inline int sysctl_conn_reuse_mode(struct netns_ipvs *ipvs)
>  	return 1;
>  }
>  
> +static inline int sysctl_expire_nodest_conn(struct netns_ipvs *ipvs)
> +{
> +	return 0;
> +}
> +
>  static inline int sysctl_schedule_icmp(struct netns_ipvs *ipvs)
>  {
>  	return 0;
> @@ -1507,6 +1520,22 @@ static inline int ip_vs_todrop(struct netns_ipvs *ipvs)
>  static inline int ip_vs_todrop(struct netns_ipvs *ipvs) { return 0; }
>  #endif
>  
> +#ifdef CONFIG_SYSCTL
> +/* Enqueue delayed work for expiring no dest connections
> + * Only run when sysctl_expire_nodest=1
> + */
> +static inline void ip_vs_enqueue_expire_nodest_conns(struct netns_ipvs *ipvs)
> +{
> +	if (sysctl_expire_nodest_conn(ipvs))
> +		queue_delayed_work(system_long_wq,
> +				   &ipvs->expire_nodest_conn_work, 1);
> +}
> +
> +void ip_vs_expire_nodest_conn_flush(struct netns_ipvs *ipvs);
> +#else
> +static inline void ip_vs_enqueue_expire_nodest_conns(struct netns_ipvs) {}
> +#endif
> +
>  #define IP_VS_DFWD_METHOD(dest) (atomic_read(&(dest)->conn_flags) & \
>  				 IP_VS_CONN_F_FWD_MASK)
>  
> diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
> index b3921ae92740..a5e9b2d55e57 100644
> --- a/net/netfilter/ipvs/ip_vs_conn.c
> +++ b/net/netfilter/ipvs/ip_vs_conn.c
> @@ -1389,6 +1389,45 @@ static void ip_vs_conn_flush(struct netns_ipvs *ipvs)
>  		goto flush_again;
>  	}
>  }
> +
> +#ifdef CONFIG_SYSCTL
> +void ip_vs_expire_nodest_conn_flush(struct netns_ipvs *ipvs)
> +{
> +	int idx;
> +	struct ip_vs_conn *cp, *cp_c;
> +	struct ip_vs_dest *dest;
> +
> +	rcu_read_lock();
> +	for (idx = 0; idx < ip_vs_conn_tab_size; idx++) {
> +		hlist_for_each_entry_rcu(cp, &ip_vs_conn_tab[idx], c_list) {
> +			if (cp->ipvs != ipvs)
> +				continue;
> +
> +			dest = cp->dest;
> +			if (!dest || (dest->flags & IP_VS_DEST_F_AVAILABLE))
> +				continue;
> +
> +			if (atomic_read(&cp->n_control))
> +				continue;
> +
> +			cp_c = cp->control;
> +			IP_VS_DBG(4, "del connection\n");
> +			ip_vs_conn_del(cp);
> +			if (cp_c && !atomic_read(&cp_c->n_control)) {
> +				IP_VS_DBG(4, "del controlling connection\n");
> +				ip_vs_conn_del(cp_c);
> +			}
> +		}
> +		cond_resched_rcu();
> +
> +		/* netns clean up started, abort delayed work */
> +		if (!ipvs->enable)
> +			return;
> +	}
> +	rcu_read_unlock();
> +}
> +#endif
> +
>  /*
>   * per netns init and exit
>   */
> diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
> index b4a6b7662f3f..e3668a6e54e4 100644
> --- a/net/netfilter/ipvs/ip_vs_core.c
> +++ b/net/netfilter/ipvs/ip_vs_core.c
> @@ -694,16 +694,10 @@ static int sysctl_nat_icmp_send(struct netns_ipvs *ipvs)
>  	return ipvs->sysctl_nat_icmp_send;
>  }
>  
> -static int sysctl_expire_nodest_conn(struct netns_ipvs *ipvs)
> -{
> -	return ipvs->sysctl_expire_nodest_conn;
> -}
> -
>  #else
>  
>  static int sysctl_snat_reroute(struct netns_ipvs *ipvs) { return 0; }
>  static int sysctl_nat_icmp_send(struct netns_ipvs *ipvs) { return 0; }
> -static int sysctl_expire_nodest_conn(struct netns_ipvs *ipvs) { return 0; }
>  
>  #endif
>  
> @@ -2097,36 +2091,35 @@ ip_vs_in(struct netns_ipvs *ipvs, unsigned int hooknum, struct sk_buff *skb, int
>  		}
>  	}
>  
> -	if (unlikely(!cp)) {
> -		int v;
> -
> -		if (!ip_vs_try_to_schedule(ipvs, af, skb, pd, &v, &cp, &iph))
> -			return v;
> -	}
> -
> -	IP_VS_DBG_PKT(11, af, pp, skb, iph.off, "Incoming packet");
> -
>  	/* Check the server status */
> -	if (cp->dest && !(cp->dest->flags & IP_VS_DEST_F_AVAILABLE)) {
> +	if (cp && cp->dest && !(cp->dest->flags & IP_VS_DEST_F_AVAILABLE)) {
>  		/* the destination server is not available */
> +		if (sysctl_expire_nodest_conn(ipvs)) {
> +			bool old_ct = ip_vs_conn_uses_old_conntrack(cp, skb);
>  
> -		__u32 flags = cp->flags;
> -
> -		/* when timer already started, silently drop the packet.*/
> -		if (timer_pending(&cp->timer))
> -			__ip_vs_conn_put(cp);
> -		else
> -			ip_vs_conn_put(cp);
> +			if (!old_ct)
> +				cp->flags &= ~IP_VS_CONN_F_NFCT;
>  
> -		if (sysctl_expire_nodest_conn(ipvs) &&
> -		    !(flags & IP_VS_CONN_F_ONE_PACKET)) {
> -			/* try to expire the connection immediately */
>  			ip_vs_conn_expire_now(cp);
> +			__ip_vs_conn_put(cp);
> +			if (old_ct)
> +				return NF_DROP;
> +			cp = NULL;
> +		} else {
> +			__ip_vs_conn_put(cp);
> +			return NF_DROP;
>  		}
> +	}
>  
> -		return NF_DROP;
> +	if (unlikely(!cp)) {
> +		int v;
> +
> +		if (!ip_vs_try_to_schedule(ipvs, af, skb, pd, &v, &cp, &iph))
> +			return v;
>  	}
>  
> +	IP_VS_DBG_PKT(11, af, pp, skb, iph.off, "Incoming packet");
> +
>  	ip_vs_in_stats(cp, skb);
>  	ip_vs_set_state(cp, IP_VS_DIR_INPUT, skb, pd);
>  	if (cp->packet_xmit)
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 4af83f466dfc..f984d2c881ff 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -210,6 +210,17 @@ static void update_defense_level(struct netns_ipvs *ipvs)
>  	local_bh_enable();
>  }
>  
> +/* Handler for delayed work for expiring no
> + * destination connections
> + */
> +static void expire_nodest_conn_handler(struct work_struct *work)
> +{
> +	struct netns_ipvs *ipvs;
> +
> +	ipvs = container_of(work, struct netns_ipvs,
> +			    expire_nodest_conn_work.work);
> +	ip_vs_expire_nodest_conn_flush(ipvs);
> +}
>  
>  /*
>   *	Timer for checking the defense
> @@ -1164,6 +1175,12 @@ static void __ip_vs_del_dest(struct netns_ipvs *ipvs, struct ip_vs_dest *dest,
>  	list_add(&dest->t_list, &ipvs->dest_trash);
>  	dest->idle_start = 0;
>  	spin_unlock_bh(&ipvs->dest_trash_lock);
> +
> +	/* Queue up delayed work to expire all no destination connections.
> +	 * No-op when CONFIG_SYSCTL is disabled.
> +	 */
> +	if (!cleanup)
> +		ip_vs_enqueue_expire_nodest_conns(ipvs);
>  }
>  
>  
> @@ -4086,6 +4103,10 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
>  	queue_delayed_work(system_long_wq, &ipvs->defense_work,
>  			   DEFENSE_TIMER_PERIOD);
>  
> +	/* Init delayed work for expiring no dest conn */
> +	INIT_DELAYED_WORK(&ipvs->expire_nodest_conn_work,
> +			  expire_nodest_conn_handler);
> +
>  	return 0;
>  }
>  
> @@ -4093,6 +4114,7 @@ static void __net_exit ip_vs_control_net_cleanup_sysctl(struct netns_ipvs *ipvs)
>  {
>  	struct net *net = ipvs->net;
>  
> +	cancel_delayed_work_sync(&ipvs->expire_nodest_conn_work);
>  	cancel_delayed_work_sync(&ipvs->defense_work);
>  	cancel_work_sync(&ipvs->defense_work.work);
>  	unregister_net_sysctl_table(ipvs->sysctl_hdr);
> -- 
> 2.20.1

Regards

--
Julian Anastasov <ja@ssi.bg>
