Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E2A2BC551
	for <lists+netfilter-devel@lfdr.de>; Sun, 22 Nov 2020 12:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgKVLVL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 22 Nov 2020 06:21:11 -0500
Received: from mg.ssi.bg ([178.16.128.9]:34182 "EHLO mg.ssi.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727373AbgKVLVL (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 22 Nov 2020 06:21:11 -0500
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id B30E92803D
        for <netfilter-devel@vger.kernel.org>; Sun, 22 Nov 2020 13:21:08 +0200 (EET)
Received: from ink.ssi.bg (ink.ssi.bg [178.16.128.7])
        by mg.ssi.bg (Proxmox) with ESMTP id 732BE28038
        for <netfilter-devel@vger.kernel.org>; Sun, 22 Nov 2020 13:21:07 +0200 (EET)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id D99823C0505;
        Sun, 22 Nov 2020 13:21:03 +0200 (EET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id 0AMBKxNw009931;
        Sun, 22 Nov 2020 13:21:01 +0200
Date:   Sun, 22 Nov 2020 13:20:59 +0200 (EET)
From:   Julian Anastasov <ja@ssi.bg>
To:     Wang Hai <wanghai38@huawei.com>
cc:     Simon Horman <horms@verge.net.au>, pablo@netfilter.org,
        christian@brauner.io, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net v2] ipvs: fix possible memory leak in
 ip_vs_control_net_init
In-Reply-To: <20201120082610.60917-1-wanghai38@huawei.com>
Message-ID: <21af4c92-8ca6-cce9-64bc-c4e88b6d1e8a@ssi.bg>
References: <20201120082610.60917-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


	Hello,

On Fri, 20 Nov 2020, Wang Hai wrote:

> kmemleak report a memory leak as follows:
> 
> BUG: memory leak
> unreferenced object 0xffff8880759ea000 (size 256):
> comm "syz-executor.3", pid 6484, jiffies 4297476946 (age 48.546s)
> hex dump (first 32 bytes):
> 00 00 00 00 01 00 00 00 08 a0 9e 75 80 88 ff ff ...........u....
> 08 a0 9e 75 80 88 ff ff 00 00 00 00 ad 4e ad de ...u.........N..
> backtrace:
> [<00000000c0bf2deb>] kmem_cache_zalloc include/linux/slab.h:656 [inline]
> [<00000000c0bf2deb>] __proc_create+0x23d/0x7d0 fs/proc/generic.c:421
> [<000000009d718d02>] proc_create_reg+0x8e/0x140 fs/proc/generic.c:535
> [<0000000097bbfc4f>] proc_create_net_data+0x8c/0x1b0 fs/proc/proc_net.c:126
> [<00000000652480fc>] ip_vs_control_net_init+0x308/0x13a0 net/netfilter/ipvs/ip_vs_ctl.c:4169
> [<000000004c927ebe>] __ip_vs_init+0x211/0x400 net/netfilter/ipvs/ip_vs_core.c:2429
> [<00000000aa6b72d9>] ops_init+0xa8/0x3c0 net/core/net_namespace.c:151
> [<00000000153fd114>] setup_net+0x2de/0x7e0 net/core/net_namespace.c:341
> [<00000000be4e4f07>] copy_net_ns+0x27d/0x530 net/core/net_namespace.c:482
> [<00000000f1c23ec9>] create_new_namespaces+0x382/0xa30 kernel/nsproxy.c:110
> [<00000000098a5757>] copy_namespaces+0x2e6/0x3b0 kernel/nsproxy.c:179
> [<0000000026ce39e9>] copy_process+0x220a/0x5f00 kernel/fork.c:2072
> [<00000000b71f4efe>] _do_fork+0xc7/0xda0 kernel/fork.c:2428
> [<000000002974ee96>] __do_sys_clone3+0x18a/0x280 kernel/fork.c:2703
> [<0000000062ac0a4d>] do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
> [<0000000093f1ce2c>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> In the error path of ip_vs_control_net_init(), remove_proc_entry() needs
> to be called to remove the added proc entry, otherwise a memory leak
> will occur.
> 
> Also, add some '#ifdef CONFIG_PROC_FS' because proc_create_net* return NULL
> when PROC is not used.
> 
> Fixes: b17fc9963f83 ("IPVS: netns, ip_vs_stats and its procfs")
> Fixes: 61b1ab4583e2 ("IPVS: netns, add basic init per netns.")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
> v1->v2: add some '#ifdef CONFIG_PROC_FS' and check the return value of proc_create_net*
>  net/netfilter/ipvs/ip_vs_ctl.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index e279ded4e306..c00394ba20db 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -4167,12 +4167,17 @@ int __net_init ip_vs_control_net_init(struct netns_ipvs *ipvs)
>  
>  	spin_lock_init(&ipvs->tot_stats.lock);
>  
> -	proc_create_net("ip_vs", 0, ipvs->net->proc_net, &ip_vs_info_seq_ops,
> -			sizeof(struct ip_vs_iter));
> -	proc_create_net_single("ip_vs_stats", 0, ipvs->net->proc_net,
> -			ip_vs_stats_show, NULL);
> -	proc_create_net_single("ip_vs_stats_percpu", 0, ipvs->net->proc_net,
> -			ip_vs_stats_percpu_show, NULL);
> +#ifdef CONFIG_PROC_FS
> +	if (!proc_create_net("ip_vs", 0, ipvs->net->proc_net, &ip_vs_info_seq_ops,
> +			sizeof(struct ip_vs_iter)))
> +		goto err_vs;
> +	if (!proc_create_net_single("ip_vs_stats", 0, ipvs->net->proc_net,
> +			ip_vs_stats_show, NULL))
> +		goto err_stats;
> +	if (!proc_create_net_single("ip_vs_stats_percpu", 0, ipvs->net->proc_net,
> +			ip_vs_stats_percpu_show, NULL))
> +		goto err_percpu;

	Make sure the parameters are properly aligned to function open 
parenthesis without exceeding 80 columns:

linux# scripts/checkpatch.pl --strict /tmp/file.patch

	It was true only for first call due to some
renames for the others two in commit 3617d9496cd9 :(

> +#endif
>  
>  	if (ip_vs_control_net_init_sysctl(ipvs))
>  		goto err;
> @@ -4180,6 +4185,14 @@ int __net_init ip_vs_control_net_init(struct netns_ipvs *ipvs)
>  	return 0;
>  
>  err:
> +#ifdef CONFIG_PROC_FS
> +	remove_proc_entry("ip_vs_stats_percpu", ipvs->net->proc_net);

	It should look better with an empty line before
the 3 new labels.

> +err_percpu:
> +	remove_proc_entry("ip_vs_stats", ipvs->net->proc_net);
> +err_stats:
> +	remove_proc_entry("ip_vs", ipvs->net->proc_net);
> +err_vs:
> +#endif
>  	free_percpu(ipvs->tot_stats.cpustats);
>  	return -ENOMEM;
>  }
> @@ -4188,9 +4201,11 @@ void __net_exit ip_vs_control_net_cleanup(struct netns_ipvs *ipvs)
>  {
>  	ip_vs_trash_cleanup(ipvs);
>  	ip_vs_control_net_cleanup_sysctl(ipvs);
> +#ifdef CONFIG_PROC_FS
>  	remove_proc_entry("ip_vs_stats_percpu", ipvs->net->proc_net);
>  	remove_proc_entry("ip_vs_stats", ipvs->net->proc_net);
>  	remove_proc_entry("ip_vs", ipvs->net->proc_net);
> +#endif
>  	free_percpu(ipvs->tot_stats.cpustats);
>  }
>  

Regards

--
Julian Anastasov <ja@ssi.bg>

