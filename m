Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262EE20F821
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2020 17:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389258AbgF3PT2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Jun 2020 11:19:28 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:53786 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbgF3PT2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:19:28 -0400
Received: from madeliefje.horms.nl (unknown [83.161.246.101])
        by kirsty.vergenet.net (Postfix) with ESMTPA id A560825B73E;
        Wed,  1 Jul 2020 01:19:25 +1000 (AEST)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
        id 0E4DD2E4F; Tue, 30 Jun 2020 17:19:23 +0200 (CEST)
Date:   Tue, 30 Jun 2020 17:19:23 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     lvs-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org,
        Andrew Sy Kim <kim.andrewsy@gmail.com>
Subject: Re: [PATCH net-next] ipvs: avoid expiring many connections from timer
Message-ID: <20200630151922.GA12560@vergenet.net>
References: <20200620100355.4364-1-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620100355.4364-1-ja@ssi.bg>
Organisation: Horms Solutions BV
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Julian,

sorry for not noticing this earlier.

On Sat, Jun 20, 2020 at 01:03:55PM +0300, Julian Anastasov wrote:
> Add new functions ip_vs_conn_del() and ip_vs_conn_del_put()
> to release many IPVS connections in process context.
> They are suitable for connections found in table
> when we do not want to overload the timers.
> 
> Currently, the change is useful for the dropentry delayed
> work but it will be used also in following patch
> when flushing connections to failed destinations.
> 
> Signed-off-by: Julian Anastasov <ja@ssi.bg>
> ---
>  net/netfilter/ipvs/ip_vs_conn.c | 53 +++++++++++++++++++++++----------
>  net/netfilter/ipvs/ip_vs_ctl.c  |  6 ++--
>  2 files changed, 42 insertions(+), 17 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
> index 02f2f636798d..b3921ae92740 100644
> --- a/net/netfilter/ipvs/ip_vs_conn.c
> +++ b/net/netfilter/ipvs/ip_vs_conn.c
> @@ -807,6 +807,31 @@ static void ip_vs_conn_rcu_free(struct rcu_head *head)
>  	kmem_cache_free(ip_vs_conn_cachep, cp);
>  }
>  
> +/* Try to delete connection while not holding reference */
> +static void ip_vs_conn_del(struct ip_vs_conn *cp)
> +{
> +	if (del_timer(&cp->timer)) {
> +		/* Drop cp->control chain too */
> +		if (cp->control)
> +			cp->timeout = 0;
> +		ip_vs_conn_expire(&cp->timer);
> +	}
> +}
> +
> +/* Try to delete connection while holding reference */
> +static void ip_vs_conn_del_put(struct ip_vs_conn *cp)
> +{
> +	if (del_timer(&cp->timer)) {
> +		/* Drop cp->control chain too */
> +		if (cp->control)
> +			cp->timeout = 0;
> +		__ip_vs_conn_put(cp);
> +		ip_vs_conn_expire(&cp->timer);
> +	} else {
> +		__ip_vs_conn_put(cp);
> +	}
> +}
> +
>  static void ip_vs_conn_expire(struct timer_list *t)
>  {
>  	struct ip_vs_conn *cp = from_timer(cp, t, timer);
> @@ -827,14 +852,17 @@ static void ip_vs_conn_expire(struct timer_list *t)
>  
>  		/* does anybody control me? */
>  		if (ct) {
> +			bool has_ref = !cp->timeout && __ip_vs_conn_get(ct);
> +
>  			ip_vs_control_del(cp);
>  			/* Drop CTL or non-assured TPL if not used anymore */
> -			if (!cp->timeout && !atomic_read(&ct->n_control) &&
> +			if (has_ref && !atomic_read(&ct->n_control) &&
>  			    (!(ct->flags & IP_VS_CONN_F_TEMPLATE) ||
>  			     !(ct->state & IP_VS_CTPL_S_ASSURED))) {
>  				IP_VS_DBG(4, "drop controlling connection\n");
> -				ct->timeout = 0;
> -				ip_vs_conn_expire_now(ct);
> +				ip_vs_conn_del_put(ct);

Previously this code did not put the ct, now it does.
Is that intentional.

> +			} else if (has_ref) {
> +				__ip_vs_conn_put(ct);
>  			}
>  		}
>  
> @@ -1317,8 +1345,7 @@ void ip_vs_random_dropentry(struct netns_ipvs *ipvs)
>  
>  drop:
>  			IP_VS_DBG(4, "drop connection\n");
> -			cp->timeout = 0;
> -			ip_vs_conn_expire_now(cp);
> +			ip_vs_conn_del(cp);
>  		}
>  		cond_resched_rcu();
>  	}
> @@ -1341,19 +1368,15 @@ static void ip_vs_conn_flush(struct netns_ipvs *ipvs)
>  		hlist_for_each_entry_rcu(cp, &ip_vs_conn_tab[idx], c_list) {
>  			if (cp->ipvs != ipvs)
>  				continue;
> -			/* As timers are expired in LIFO order, restart
> -			 * the timer of controlling connection first, so
> -			 * that it is expired after us.
> -			 */
> +			if (atomic_read(&cp->n_control))
> +				continue;
>  			cp_c = cp->control;
> -			/* cp->control is valid only with reference to cp */
> -			if (cp_c && __ip_vs_conn_get(cp)) {
> +			IP_VS_DBG(4, "del connection\n");
> +			ip_vs_conn_del(cp);
> +			if (cp_c && !atomic_read(&cp_c->n_control)) {
>  				IP_VS_DBG(4, "del controlling connection\n");
> -				ip_vs_conn_expire_now(cp_c);
> -				__ip_vs_conn_put(cp);
> +				ip_vs_conn_del(cp_c);

Conversely, previously this code put the ct, now it doesn't.
Is that also intentional?

>  			}
> -			IP_VS_DBG(4, "del connection\n");
> -			ip_vs_conn_expire_now(cp);
>  		}
>  		cond_resched_rcu();
>  	}
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 412656c34f20..1a231f518e3f 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -224,7 +224,8 @@ static void defense_work_handler(struct work_struct *work)
>  	update_defense_level(ipvs);
>  	if (atomic_read(&ipvs->dropentry))
>  		ip_vs_random_dropentry(ipvs);
> -	schedule_delayed_work(&ipvs->defense_work, DEFENSE_TIMER_PERIOD);
> +	queue_delayed_work(system_long_wq, &ipvs->defense_work,
> +			   DEFENSE_TIMER_PERIOD);
>  }
>  #endif
>  
> @@ -4063,7 +4064,8 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
>  	ipvs->sysctl_tbl = tbl;
>  	/* Schedule defense work */
>  	INIT_DELAYED_WORK(&ipvs->defense_work, defense_work_handler);
> -	schedule_delayed_work(&ipvs->defense_work, DEFENSE_TIMER_PERIOD);
> +	queue_delayed_work(system_long_wq, &ipvs->defense_work,
> +			   DEFENSE_TIMER_PERIOD);
>  
>  	return 0;
>  }
> -- 
> 2.26.2
> 
