Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5677CAF3B
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Oct 2019 21:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbfJCT3V (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 3 Oct 2019 15:29:21 -0400
Received: from ja.ssi.bg ([178.16.129.10]:60950 "EHLO ja.ssi.bg"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726677AbfJCT3V (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:29:21 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id x93JSvNe005636;
        Thu, 3 Oct 2019 22:28:57 +0300
Date:   Thu, 3 Oct 2019 22:28:57 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Davide Caratti <dcaratti@redhat.com>
cc:     Wensong Zhang <wensong@linux-vs.org>,
        Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] ipvs: more robust refcounting when sync thread
 starts
In-Reply-To: <2bac83f117771cc5c5a59c2bf816039b0efa8239.1570010302.git.dcaratti@redhat.com>
Message-ID: <alpine.LFD.2.21.1910032111170.3862@ja.home.ssi.bg>
References: <2bac83f117771cc5c5a59c2bf816039b0efa8239.1570010302.git.dcaratti@redhat.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


	Hello,

On Wed, 2 Oct 2019, Davide Caratti wrote:

> if the IPVS module is removed while the sync daemon is starting, there is
> a small possibility for stop_sync_thread() to end successfully just after
> start_sync_thread() released sync_mutex, but before increasing the module
> refcount. When this race happens, the following warning is seen in dmesg:
> 
>  IPVS: stopping master sync thread 14134 ...
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 14133 at kernel/module.c:1137 module_put.part.44+0x167/0x2a0
>  Modules linked in: ip_vs(-) nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 sch_netem veth ip6table_filter ip6_tables iptable_filter binfmt_misc intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul ghash_clmulni_intel snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_hda_codec ext4 snd_hda_core snd_hwdep mbcache jbd2 snd_seq snd_seq_device snd_pcm aesni_intel crypto_simd cryptd glue_helper joydev snd_timer virtio_balloon pcspkr snd soundcore i2c_piix4 nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c ata_generic pata_acpi virtio_net virtio_console virtio_blk net_failover failover qxl drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm crc32c_intel serio_raw ata_piix virtio_pci drm virtio_ring virtio libata floppy dm_mirror dm_region_hash dm_log dm_mod [last unloaded: nf_defrag_ipv6]
>  CPU: 0 PID: 14133 Comm: modprobe Tainted: G        W         5.3.0-rc7.upstream+ #723
>  Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
>  RIP: 0010:module_put.part.44+0x167/0x2a0
>  Code: 48 83 c4 68 5b 5d 41 5c 41 5d 41 5e 41 5f c3 89 44 24 28 83 e8 01 89 c5 0f 89 57 ff ff ff 48 c7 c7 60 9c ed 86 e8 32 4c f5 ff <0f> 0b e9 6c ff ff ff 65 8b 1d 6b b2 e6 7a 89 db be 08 00 00 00 48
>  RSP: 0018:ffff88804f9b7c78 EFLAGS: 00010282
>  RAX: 0000000000000024 RBX: ffffffffc1609690 RCX: ffffffff85a82042
>  RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888053627bec
>  RBP: 00000000ffffffff R08: ffffed100a6c6181 R09: ffffed100a6c6181
>  R10: 0000000000000001 R11: ffffed100a6c6180 R12: 1ffff11009f36f90
>  R13: ffffffffc1609300 R14: ffff88804c0d5500 R15: ffff88804c0d5ea0
>  FS:  00007fa1c73f8740(0000) GS:ffff888053600000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f914f4d345f CR3: 000000004855a005 CR4: 00000000001606f0
>  Call Trace:
>   stop_sync_thread+0x3a3/0x7c0 [ip_vs]
>   ip_vs_sync_net_cleanup+0x13/0x50 [ip_vs]
>   ops_exit_list.isra.5+0x94/0x140
>   unregister_pernet_operations+0x29d/0x460
>   unregister_pernet_device+0x26/0x60
>   ip_vs_cleanup+0x11/0x38 [ip_vs]
>   do_syscall_64+0xa5/0x4f0
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>  RIP: 0033:0x7fa1c68c9027
>  Code: 73 01 c3 48 8b 0d 69 6e 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 6e 2c 00 f7 d8 64 89 01 48
>  RSP: 002b:00007ffe8b021cf8 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
>  RAX: ffffffffffffffda RBX: 0000000001528240 RCX: 00007fa1c68c9027
>  RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00000000015282a8
>  RBP: 0000000000000000 R08: 00007fa1c6b91060 R09: 00007fa1c693d1a0
>  R10: 00007ffe8b021760 R11: 0000000000000202 R12: 0000000000000000
>  R13: 0000000000000001 R14: 00000000015282a8 R15: 0000000000000000
> 
> Fix this ensuring that start_sync_thread() takes a refcount for the ip_vs
> module earlier, and eventually drop it in the error path.
> 
> Reported-by: Zhi Li <yieli@redhat.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  net/netfilter/ipvs/ip_vs_sync.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
> index a4a78c4b06de..7ac148182b61 100644
> --- a/net/netfilter/ipvs/ip_vs_sync.c
> +++ b/net/netfilter/ipvs/ip_vs_sync.c
> @@ -1758,6 +1758,9 @@ int start_sync_thread(struct netns_ipvs *ipvs, struct ipvs_sync_daemon_cfg *c,
>  	int result = -ENOMEM;
>  	u16 mtu, min_mtu;
>  
> +	/* increase the module use count */
> +	ip_vs_use_count_inc();
> +

	May be this is not early enough. When control hooks 
are the first thing to disconnect with ip_vs_unregister_nl_ioctl()
how start_sync_thread() is called concurrently? ip_vs_sockopts is 
protected with .owner field and ip_vs_genl_family with .module field
or more correctly with cb_lock rwsem in net/netlink/genetlink.c
which avoids doit() handlers after genl_unregister_family() is called.
So, both interfaces do not allow start_sync_thread() during module
removal and it is interesting how your fix works actually.

	Which interface calls start_sync_thread (sockopt/genl)? Note that
do_ip_vs_set_ctl() already has ip_vs_use_count_inc() before the
start_sync_thread() call. Also, the WARN in module_put warns
about refcnt underflow, so there is an extra ip_vs_use_count_dec() ?

	Another possibility is the missing checks for 
ip_vs_use_count_inc() result to cause underflow on ip_vs_use_count_dec().

	Are there any steps to reproduce?

>  	IP_VS_DBG(7, "%s(): pid %d\n", __func__, task_pid_nr(current));
>  	IP_VS_DBG(7, "Each ip_vs_sync_conn entry needs %zd bytes\n",
>  		  sizeof(struct ip_vs_sync_conn_v0));
> @@ -1892,9 +1895,6 @@ int start_sync_thread(struct netns_ipvs *ipvs, struct ipvs_sync_daemon_cfg *c,
>  	mutex_unlock(&ipvs->sync_mutex);
>  	rtnl_unlock();
>  
> -	/* increase the module use count */
> -	ip_vs_use_count_inc();
> -
>  	return 0;
>  
>  out:
> @@ -1924,11 +1924,16 @@ int start_sync_thread(struct netns_ipvs *ipvs, struct ipvs_sync_daemon_cfg *c,
>  		}
>  		kfree(ti);
>  	}
> +
> +	/* decrease the module use count */
> +	ip_vs_use_count_dec();
>  	return result;
>  
>  out_early:
>  	mutex_unlock(&ipvs->sync_mutex);
>  	rtnl_unlock();
> +	/* decrease the module use count */
> +	ip_vs_use_count_dec();
>  	return result;
>  }
>  
> -- 
> 2.21.0

Regards

--
Julian Anastasov <ja@ssi.bg>
