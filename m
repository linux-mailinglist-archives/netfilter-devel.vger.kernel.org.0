Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2673F399A
	for <lists+netfilter-devel@lfdr.de>; Sat, 21 Aug 2021 10:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhHUIvj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 21 Aug 2021 04:51:39 -0400
Received: from mg.ssi.bg ([178.16.128.9]:51108 "EHLO mg.ssi.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232802AbhHUIvi (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 21 Aug 2021 04:51:38 -0400
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Aug 2021 04:51:38 EDT
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 9F1D23412F;
        Sat, 21 Aug 2021 11:42:05 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [178.16.128.7])
        by mg.ssi.bg (Proxmox) with ESMTP id BAECF34129;
        Sat, 21 Aug 2021 11:42:01 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 5261F3C09C4;
        Sat, 21 Aug 2021 11:41:58 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.16.1/8.16.1) with ESMTP id 17L8foVI010943;
        Sat, 21 Aug 2021 11:41:53 +0300
Date:   Sat, 21 Aug 2021 11:41:50 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Dust Li <dust.li@linux.alibaba.com>
cc:     Simon Horman <horms@verge.net.au>,
        Wensong Zhang <wensong@linux-vs.org>,
        lvs-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
        yunhong-cgl jiang <xintian1976@gmail.com>
Subject: Re: [PATCH net-next v4] net: ipvs: add sysctl_run_estimation to
 support disable estimation
In-Reply-To: <20210820053752.11508-1-dust.li@linux.alibaba.com>
Message-ID: <5f590b6-4668-19fe-b768-15125f48df1e@ssi.bg>
References: <20210820053752.11508-1-dust.li@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


	Hello,

On Fri, 20 Aug 2021, Dust Li wrote:

> estimation_timer will iterate the est_list to do estimation
> for each ipvs stats. When there are lots of services, the
> list can be very large.
> We found that estimation_timer() run for more then 200ms on a
> machine with 104 CPU and 50K services.
> 
> yunhong-cgl jiang report the same phenomenon before:
> https://www.spinics.net/lists/lvs-devel/msg05426.html
> 
> In some cases(for example a large K8S cluster with many ipvs services),
> ipvs estimation may not be needed. So adding a sysctl blob to allow
> users to disable this completely.
> 
> Default is: 1 (enable)
> 
> Cc: yunhong-cgl jiang <xintian1976@gmail.com>
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>

	Looks good to me, thanks!

Acked-by: Julian Anastasov <ja@ssi.bg>

> ---
> v2: Use common sysctl facilities
> v3: Fix sysctl_run_estimation() redefine when CONFIG_SYSCTL not enabled
> v4: Some typo and minor fixes
> 
>  Documentation/networking/ipvs-sysctl.rst | 11 +++++++++++
>  include/net/ip_vs.h                      | 11 +++++++++++
>  net/netfilter/ipvs/ip_vs_ctl.c           |  8 ++++++++
>  net/netfilter/ipvs/ip_vs_est.c           |  5 +++++
>  4 files changed, 35 insertions(+)
> 
> diff --git a/Documentation/networking/ipvs-sysctl.rst b/Documentation/networking/ipvs-sysctl.rst
> index 2afccc63856e..95ef56d62077 100644
> --- a/Documentation/networking/ipvs-sysctl.rst
> +++ b/Documentation/networking/ipvs-sysctl.rst
> @@ -300,3 +300,14 @@ sync_version - INTEGER
>  
>  	Kernels with this sync_version entry are able to receive messages
>  	of both version 1 and version 2 of the synchronisation protocol.
> +
> +run_estimation - BOOLEAN
> +	0 - disabled
> +	not 0 - enabled (default)
> +
> +	If disabled, the estimation will be stop, and you can't see
> +	any update on speed estimation data.
> +
> +	You can always re-enable estimation by setting this value to 1.
> +	But be careful, the first estimation after re-enable is not
> +	accurate.
> diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
> index 7cb5a1aace40..ff1804a0c469 100644
> --- a/include/net/ip_vs.h
> +++ b/include/net/ip_vs.h
> @@ -931,6 +931,7 @@ struct netns_ipvs {
>  	int			sysctl_conn_reuse_mode;
>  	int			sysctl_schedule_icmp;
>  	int			sysctl_ignore_tunneled;
> +	int			sysctl_run_estimation;
>  
>  	/* ip_vs_lblc */
>  	int			sysctl_lblc_expiration;
> @@ -1071,6 +1072,11 @@ static inline int sysctl_cache_bypass(struct netns_ipvs *ipvs)
>  	return ipvs->sysctl_cache_bypass;
>  }
>  
> +static inline int sysctl_run_estimation(struct netns_ipvs *ipvs)
> +{
> +	return ipvs->sysctl_run_estimation;
> +}
> +
>  #else
>  
>  static inline int sysctl_sync_threshold(struct netns_ipvs *ipvs)
> @@ -1163,6 +1169,11 @@ static inline int sysctl_cache_bypass(struct netns_ipvs *ipvs)
>  	return 0;
>  }
>  
> +static inline int sysctl_run_estimation(struct netns_ipvs *ipvs)
> +{
> +	return 1;
> +}
> +
>  #endif
>  
>  /* IPVS core functions
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index c25097092a06..cbea5a68afb5 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -2017,6 +2017,12 @@ static struct ctl_table vs_vars[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> +	{
> +		.procname	= "run_estimation",
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
>  #ifdef CONFIG_IP_VS_DEBUG
>  	{
>  		.procname	= "debug_level",
> @@ -4090,6 +4096,8 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
>  	tbl[idx++].data = &ipvs->sysctl_conn_reuse_mode;
>  	tbl[idx++].data = &ipvs->sysctl_schedule_icmp;
>  	tbl[idx++].data = &ipvs->sysctl_ignore_tunneled;
> +	ipvs->sysctl_run_estimation = 1;
> +	tbl[idx++].data = &ipvs->sysctl_run_estimation;
>  
>  	ipvs->sysctl_hdr = register_net_sysctl(net, "net/ipv4/vs", tbl);
>  	if (ipvs->sysctl_hdr == NULL) {
> diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
> index 05b8112ffb37..9a1a7af6a186 100644
> --- a/net/netfilter/ipvs/ip_vs_est.c
> +++ b/net/netfilter/ipvs/ip_vs_est.c
> @@ -100,6 +100,9 @@ static void estimation_timer(struct timer_list *t)
>  	u64 rate;
>  	struct netns_ipvs *ipvs = from_timer(ipvs, t, est_timer);
>  
> +	if (!sysctl_run_estimation(ipvs))
> +		goto skip;
> +
>  	spin_lock(&ipvs->est_lock);
>  	list_for_each_entry(e, &ipvs->est_list, list) {
>  		s = container_of(e, struct ip_vs_stats, est);
> @@ -131,6 +134,8 @@ static void estimation_timer(struct timer_list *t)
>  		spin_unlock(&s->lock);
>  	}
>  	spin_unlock(&ipvs->est_lock);
> +
> +skip:
>  	mod_timer(&ipvs->est_timer, jiffies + 2*HZ);
>  }
>  
> -- 
> 2.19.1.3.ge56e4f7
> 
> 
> 

Regards

--
Julian Anastasov <ja@ssi.bg>

