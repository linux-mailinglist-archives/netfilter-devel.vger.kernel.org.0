Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FAD1F20A4
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jun 2020 22:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgFHUYl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Jun 2020 16:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgFHUYk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:24:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521EDC08C5C3
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Jun 2020 13:24:39 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k11so19834390ejr.9
        for <netfilter-devel@vger.kernel.org>; Mon, 08 Jun 2020 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=D4qGvLe577wRMyKX8Il9uFlWWRAddrmvxH1A7dCBQsw=;
        b=MaotrjsVZvq1yXvO7ir7G5vs/chiJmh5eEyqotto6pXK+xHrkc8rskAwMXR5B0EXrK
         s8oO8jE06ctbfAoGx8+OYNX5xaN3JX8mdnRVFJPGbS3UoIEY/2loQgQPeRyO8Z5HVw3g
         m0MayjFIqzWRycvwYzz1hwhZ60JTtaTG97dQnOpWi2j/iIvJ+A1SgIOCOzQodpCiZKha
         I+U2F5XvvxFppmjHhpJdqZRWplH5rpAQlUrns/QCJSy3q5hB5x2BAWK2yvFMTn2aZwIY
         pYypL/gb2NkJW28HGV+XzgoR7R7nzQDvNNR8Uu98Ua/kFrNdm8bQ4Hlo05yopGRLB5jI
         Cf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=D4qGvLe577wRMyKX8Il9uFlWWRAddrmvxH1A7dCBQsw=;
        b=hRZ2Pzc8YYCusmT6CmJzsm8bvjuzjJIGZktfX2AJRwne/8GRggZDw+1qXGq1VwIGEJ
         UKPd2ztAw2BJD1ZxM6sK1t1R8sCFvCogT82RSW2Fld13VaoxnXpO//9HLJzVAznUCpzh
         /p6671yAlUekhhWo+R0NtJ/Kr6LX6LWHLQVL3bioTsF0XPxIIJQkhdIk8ufePCwFoVsa
         0cWU77OlsOwyoMwZ+9B4a1a5zQeR4c2Euq7WJuhFJ3nSGXXudsz7fYNn4wNKqwlAJLAk
         VIbLKxp7O7jsDd2+rWKYMpdDVXumAPjOtwY1CfdiiD3r4T0bYuDmrgNjbtMc9MNGPpZ3
         2Kew==
X-Gm-Message-State: AOAM531pir7AWGhX/jvSMRfgZh/PIONAhwrjrPy/VqqQvd9PmaPFAaIF
        pdoUKA1+kPvwaYhLmp8KYd1jptBoTWT6rsR6kRI=
X-Received: by 2002:a17:906:2ec6:: with SMTP id s6mt21207644eji.532.1591647877277;
 Mon, 08 Jun 2020 13:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200608173413.13870-1-kim.andrewsy@gmail.com> <20200608202024.28369-1-kim.andrewsy@gmail.com>
In-Reply-To: <20200608202024.28369-1-kim.andrewsy@gmail.com>
From:   Andrew Kim <kim.andrewsy@gmail.com>
Date:   Mon, 8 Jun 2020 16:24:25 -0400
Message-ID: <CABc050EAYQuNUhi9zwWer_O9VduYO62ZmF7GtL93GyZeXSqVyw@mail.gmail.com>
Subject: Re: [PATCH] netfilter/ipvs: queue delayed work to expire no
 destination connections if expire_nodest_conn=1
Cc:     Julian Anastasov <ja@ssi.bg>, Wensong Zhang <wensong@linux-vs.org>,
        Simon Horman <horms@verge.net.au>,
        "open list:IPVS" <lvs-devel@vger.kernel.org>,
        "open list:NETFILTER" <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Last patch just fixes some styling issues.

On Mon, Jun 8, 2020 at 4:20 PM Andrew Sy Kim <kim.andrewsy@gmail.com> wrote:
>
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
> ---
>  include/net/ip_vs.h             | 29 +++++++++++++++++++++
>  net/netfilter/ipvs/ip_vs_conn.c | 43 +++++++++++++++++++++++++++++++
>  net/netfilter/ipvs/ip_vs_core.c | 45 +++++++++++++--------------------
>  net/netfilter/ipvs/ip_vs_ctl.c  | 22 ++++++++++++++++
>  4 files changed, 112 insertions(+), 27 deletions(-)
>
> diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
> index 83be2d93b407..49ca61765298 100644
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
> @@ -885,6 +886,8 @@ struct netns_ipvs {
>         atomic_t                conn_out_counter;
>
>  #ifdef CONFIG_SYSCTL
> +       /* delayed work for expiring no dest connections */
> +       struct delayed_work     expire_nodest_conn_work;
>         /* 1/rate drop and drop-entry variables */
>         struct delayed_work     defense_work;   /* Work handler */
>         int                     drop_rate;
> @@ -1049,6 +1052,11 @@ static inline int sysctl_conn_reuse_mode(struct netns_ipvs *ipvs)
>         return ipvs->sysctl_conn_reuse_mode;
>  }
>
> +static inline int sysctl_expire_nodest_conn(struct netns_ipvs *ipvs)
> +{
> +       return ipvs->sysctl_expire_nodest_conn;
> +}
> +
>  static inline int sysctl_schedule_icmp(struct netns_ipvs *ipvs)
>  {
>         return ipvs->sysctl_schedule_icmp;
> @@ -1136,6 +1144,11 @@ static inline int sysctl_conn_reuse_mode(struct netns_ipvs *ipvs)
>         return 1;
>  }
>
> +static inline int sysctl_expire_nodest_conn(struct netns_ipvs *ipvs)
> +{
> +       return 0;
> +}
> +
>  static inline int sysctl_schedule_icmp(struct netns_ipvs *ipvs)
>  {
>         return 0;
> @@ -1505,6 +1518,22 @@ static inline int ip_vs_todrop(struct netns_ipvs *ipvs)
>  static inline int ip_vs_todrop(struct netns_ipvs *ipvs) { return 0; }
>  #endif
>
> +#ifdef CONFIG_SYSCTL
> +/* Enqueue delayed work for expiring no dest connections
> + * Only run when sysctl_expire_nodest=1
> + */
> +static inline void ip_vs_enqueue_expire_nodest_conns(struct netns_ipvs *ipvs)
> +{
> +       if (sysctl_expire_nodest_conn(ipvs))
> +               queue_delayed_work(system_long_wq,
> +                                  &ipvs->expire_nodest_conn_work, 1);
> +}
> +
> +void ip_vs_expire_nodest_conn_flush(struct netns_ipvs *ipvs);
> +#else
> +static inline void ip_vs_enqueue_expire_nodest_conns(struct netns_ipvs) {}
> +#endif
> +
>  #define IP_VS_DFWD_METHOD(dest) (atomic_read(&(dest)->conn_flags) & \
>                                  IP_VS_CONN_F_FWD_MASK)
>
> diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
> index 02f2f636798d..f0d744e8c716 100644
> --- a/net/netfilter/ipvs/ip_vs_conn.c
> +++ b/net/netfilter/ipvs/ip_vs_conn.c
> @@ -1366,6 +1366,49 @@ static void ip_vs_conn_flush(struct netns_ipvs *ipvs)
>                 goto flush_again;
>         }
>  }
> +
> +#ifdef CONFIG_SYSCTL
> +void ip_vs_expire_nodest_conn_flush(struct netns_ipvs *ipvs)
> +{
> +       int idx;
> +       struct ip_vs_conn *cp, *cp_c;
> +       struct ip_vs_dest *dest;
> +
> +       rcu_read_lock();
> +       for (idx = 0; idx < ip_vs_conn_tab_size; idx++) {
> +               hlist_for_each_entry_rcu(cp, &ip_vs_conn_tab[idx], c_list) {
> +                       if (cp->ipvs != ipvs)
> +                               continue;
> +
> +                       dest = cp->dest;
> +                       if (!dest || (dest->flags & IP_VS_DEST_F_AVAILABLE))
> +                               continue;
> +
> +                       /* As timers are expired in LIFO order, restart
> +                        * the timer of controlling connection first, so
> +                        * that it is expired after us.
> +                        */
> +                       cp_c = cp->control;
> +                       /* cp->control is valid only with reference to cp */
> +                       if (cp_c && __ip_vs_conn_get(cp)) {
> +                               IP_VS_DBG(4, "del controlling connection\n");
> +                               ip_vs_conn_expire_now(cp_c);
> +                               __ip_vs_conn_put(cp);
> +                       }
> +
> +                       IP_VS_DBG(4, "del connection\n");
> +                       ip_vs_conn_expire_now(cp);
> +               }
> +               cond_resched_rcu();
> +
> +               /* netns clean up started, abort delayed work */
> +               if (!ipvs->enable)
> +                       return;
> +       }
> +       rcu_read_unlock();
> +}
> +#endif
> +
>  /*
>   * per netns init and exit
>   */
> diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
> index aa6a603a2425..2508a9caeae8 100644
> --- a/net/netfilter/ipvs/ip_vs_core.c
> +++ b/net/netfilter/ipvs/ip_vs_core.c
> @@ -694,16 +694,10 @@ static int sysctl_nat_icmp_send(struct netns_ipvs *ipvs)
>         return ipvs->sysctl_nat_icmp_send;
>  }
>
> -static int sysctl_expire_nodest_conn(struct netns_ipvs *ipvs)
> -{
> -       return ipvs->sysctl_expire_nodest_conn;
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
> @@ -2095,36 +2089,33 @@ ip_vs_in(struct netns_ipvs *ipvs, unsigned int hooknum, struct sk_buff *skb, int
>                 }
>         }
>
> -       if (unlikely(!cp)) {
> -               int v;
> -
> -               if (!ip_vs_try_to_schedule(ipvs, af, skb, pd, &v, &cp, &iph))
> -                       return v;
> -       }
> -
> -       IP_VS_DBG_PKT(11, af, pp, skb, iph.off, "Incoming packet");
> -
>         /* Check the server status */
> -       if (cp->dest && !(cp->dest->flags & IP_VS_DEST_F_AVAILABLE)) {
> +       if (cp && cp->dest && !(cp->dest->flags & IP_VS_DEST_F_AVAILABLE)) {
>                 /* the destination server is not available */
>
> -               __u32 flags = cp->flags;
> -
> -               /* when timer already started, silently drop the packet.*/
> -               if (timer_pending(&cp->timer))
> -                       __ip_vs_conn_put(cp);
> -               else
> -                       ip_vs_conn_put(cp);
> +               if (sysctl_expire_nodest_conn(ipvs)) {
> +                       bool uses_ct = ip_vs_conn_uses_conntrack(cp, skb);
>
> -               if (sysctl_expire_nodest_conn(ipvs) &&
> -                   !(flags & IP_VS_CONN_F_ONE_PACKET)) {
> -                       /* try to expire the connection immediately */
>                         ip_vs_conn_expire_now(cp);
> +                       __ip_vs_conn_put(cp);
> +                       if (uses_ct)
> +                               return NF_DROP;
> +                       cp = NULL;
> +               } else {
> +                       __ip_vs_conn_put(cp);
> +                       return NF_DROP;
>                 }
> +       }
>
> -               return NF_DROP;
> +       if (unlikely(!cp)) {
> +               int v;
> +
> +               if (!ip_vs_try_to_schedule(ipvs, af, skb, pd, &v, &cp, &iph))
> +                       return v;
>         }
>
> +       IP_VS_DBG_PKT(11, af, pp, skb, iph.off, "Incoming packet");
> +
>         ip_vs_in_stats(cp, skb);
>         ip_vs_set_state(cp, IP_VS_DIR_INPUT, skb, pd);
>         if (cp->packet_xmit)
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 8d14a1acbc37..9e53f517f138 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -210,6 +210,17 @@ static void update_defense_level(struct netns_ipvs *ipvs)
>         local_bh_enable();
>  }
>
> +/* Handler for delayed work for expiring no
> + * destination connections
> + */
> +static void expire_nodest_conn_handler(struct work_struct *work)
> +{
> +       struct netns_ipvs *ipvs;
> +
> +       ipvs = container_of(work, struct netns_ipvs,
> +                           expire_nodest_conn_work.work);
> +       ip_vs_expire_nodest_conn_flush(ipvs);
> +}
>
>  /*
>   *     Timer for checking the defense
> @@ -1163,6 +1174,12 @@ static void __ip_vs_del_dest(struct netns_ipvs *ipvs, struct ip_vs_dest *dest,
>         list_add(&dest->t_list, &ipvs->dest_trash);
>         dest->idle_start = 0;
>         spin_unlock_bh(&ipvs->dest_trash_lock);
> +
> +       /* Queue up delayed work to expire all no estination connections.
> +        * No-op when CONFIG_SYSCTL is disabled.
> +        */
> +       if (!cleanup)
> +               ip_vs_enqueue_expire_nodest_conns(ipvs);
>  }
>
>
> @@ -4065,6 +4082,10 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
>         INIT_DELAYED_WORK(&ipvs->defense_work, defense_work_handler);
>         schedule_delayed_work(&ipvs->defense_work, DEFENSE_TIMER_PERIOD);
>
> +       /* Init delayed work for expiring no dest conn */
> +       INIT_DELAYED_WORK(&ipvs->expire_nodest_conn_work,
> +                         expire_nodest_conn_handler);
> +
>         return 0;
>  }
>
> @@ -4072,6 +4093,7 @@ static void __net_exit ip_vs_control_net_cleanup_sysctl(struct netns_ipvs *ipvs)
>  {
>         struct net *net = ipvs->net;
>
> +       cancel_delayed_work_sync(&ipvs->expire_nodest_conn_work);
>         cancel_delayed_work_sync(&ipvs->defense_work);
>         cancel_work_sync(&ipvs->defense_work.work);
>         unregister_net_sysctl_table(ipvs->sysctl_hdr);
> --
> 2.20.1
>
