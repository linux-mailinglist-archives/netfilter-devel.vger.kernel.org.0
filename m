Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE653380C3A
	for <lists+netfilter-devel@lfdr.de>; Fri, 14 May 2021 16:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhENOuc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 14 May 2021 10:50:32 -0400
Received: from mail.netfilter.org ([217.70.188.207]:35230 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhENOuc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 14 May 2021 10:50:32 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 93C4B64174;
        Fri, 14 May 2021 16:48:28 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH nf 2/2] netfilter: nft_set_pipapo_avx2: Add irq_fpu_usable() check, fallback to non-AVX2 version
Date:   Fri, 14 May 2021 16:49:12 +0200
Message-Id: <20210514144912.4519-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210514144912.4519-1-pablo@netfilter.org>
References: <20210514144912.4519-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Stefano Brivio <sbrivio@redhat.com>

Arturo reported this backtrace:

[709732.358791] WARNING: CPU: 3 PID: 456 at arch/x86/kernel/fpu/core.c:128 =
kernel_fpu_begin_mask+0xae/0xe0
[709732.358793] Modules linked in: binfmt_misc nft_nat nft_chain_nat nf_nat=
 nft_counter nft_ct nf_tables nf_conntrack_netlink nfnetlink 8021q garp stp=
 mrp llc vrf intel_rapl_msr intel_rapl_common skx_edac nfit libnvdimm ipmi_=
ssif x86_pkg_temp_thermal intel_powerclamp coretemp crc32_pclmul mgag200 gh=
ash_clmulni_intel drm_kms_helper cec aesni_intel drm libaes crypto_simd cry=
ptd glue_helper mei_me dell_smbios iTCO_wdt evdev intel_pmc_bxt iTCO_vendor=
_support dcdbas pcspkr rapl dell_wmi_descriptor wmi_bmof sg i2c_algo_bit wa=
tchdog mei acpi_ipmi ipmi_si button nf_conntrack nf_defrag_ipv6 nf_defrag_i=
pv4 ipmi_devintf ipmi_msghandler ip_tables x_tables autofs4 ext4 crc16 mbca=
che jbd2 dm_mod raid10 raid456 async_raid6_recov async_memcpy async_pq asyn=
c_xor async_tx xor sd_mod t10_pi crc_t10dif crct10dif_generic raid6_pq libc=
rc32c crc32c_generic raid1 raid0 multipath linear md_mod ahci libahci tg3 l=
ibata xhci_pci libphy xhci_hcd ptp usbcore crct10dif_pclmul crct10dif_commo=
n bnxt_en crc32c_intel scsi_mod
[709732.358941]  pps_core i2c_i801 lpc_ich i2c_smbus wmi usb_common
[709732.358957] CPU: 3 PID: 456 Comm: jbd2/dm-0-8 Not tainted 5.10.0-0.bpo.=
5-amd64 #1 Debian 5.10.24-1~bpo10+1
[709732.358959] Hardware name: Dell Inc. PowerEdge R440/04JN2K, BIOS 2.9.3 =
09/23/2020
[709732.358964] RIP: 0010:kernel_fpu_begin_mask+0xae/0xe0
[709732.358969] Code: ae 54 24 04 83 e3 01 75 38 48 8b 44 24 08 65 48 33 04=
 25 28 00 00 00 75 33 48 83 c4 10 5b c3 65 8a 05 5e 21 5e 76 84 c0 74 92 <0=
f> 0b eb 8e f0 80 4f 01 40 48 81 c7 00 14 00 00 e8 dd fb ff ff eb
[709732.358972] RSP: 0018:ffffbb9700304740 EFLAGS: 00010202
[709732.358976] RAX: 0000000000000001 RBX: 0000000000000003 RCX: 0000000000=
000001
[709732.358979] RDX: ffffbb9700304970 RSI: ffff922fe1952e00 RDI: 0000000000=
000003
[709732.358981] RBP: ffffbb9700304970 R08: ffff922fc868a600 R09: ffff922fc7=
11e462
[709732.358984] R10: 000000000000005f R11: ffff922ff0b27180 R12: ffffbb9700=
304960
[709732.358987] R13: ffffbb9700304b08 R14: ffff922fc664b6c8 R15: ffff922fc6=
64b660
[709732.358990] FS:  0000000000000000(0000) GS:ffff92371fec0000(0000) knlGS=
:0000000000000000
[709732.358993] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[709732.358996] CR2: 0000557a6655bdd0 CR3: 000000026020a001 CR4: 0000000000=
7706e0
[709732.358999] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000=
000000
[709732.359001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000=
000400
[709732.359003] PKRU: 55555554
[709732.359005] Call Trace:
[709732.359009]  <IRQ>
[709732.359035]  nft_pipapo_avx2_lookup+0x4c/0x1cba [nf_tables]
[709732.359046]  ? sched_clock+0x5/0x10
[709732.359054]  ? sched_clock_cpu+0xc/0xb0
[709732.359061]  ? record_times+0x16/0x80
[709732.359068]  ? plist_add+0xc1/0x100
[709732.359073]  ? psi_group_change+0x47/0x230
[709732.359079]  ? skb_clone+0x4d/0xb0
[709732.359085]  ? enqueue_task_rt+0x22b/0x310
[709732.359098]  ? bnxt_start_xmit+0x1e8/0xaf0 [bnxt_en]
[709732.359102]  ? packet_rcv+0x40/0x4a0
[709732.359121]  nft_lookup_eval+0x59/0x160 [nf_tables]
[709732.359133]  nft_do_chain+0x350/0x500 [nf_tables]
[709732.359152]  ? nft_lookup_eval+0x59/0x160 [nf_tables]
[709732.359163]  ? nft_do_chain+0x364/0x500 [nf_tables]
[709732.359172]  ? fib4_rule_action+0x6d/0x80
[709732.359178]  ? fib_rules_lookup+0x107/0x250
[709732.359184]  nft_nat_do_chain+0x8a/0xf2 [nft_chain_nat]
[709732.359193]  nf_nat_inet_fn+0xea/0x210 [nf_nat]
[709732.359202]  nf_nat_ipv4_out+0x14/0xa0 [nf_nat]
[709732.359207]  nf_hook_slow+0x44/0xc0
[709732.359214]  ip_output+0xd2/0x100
[709732.359221]  ? __ip_finish_output+0x210/0x210
[709732.359226]  ip_forward+0x37d/0x4a0
[709732.359232]  ? ip4_key_hashfn+0xb0/0xb0
[709732.359238]  ip_sublist_rcv_finish+0x4f/0x60
[709732.359243]  ip_sublist_rcv+0x196/0x220
[709732.359250]  ? ip_rcv_finish_core.isra.22+0x400/0x400
[709732.359255]  ip_list_rcv+0x137/0x160
[709732.359264]  __netif_receive_skb_list_core+0x29b/0x2c0
[709732.359272]  netif_receive_skb_list_internal+0x1a6/0x2d0
[709732.359280]  gro_normal_list.part.156+0x19/0x40
[709732.359286]  napi_complete_done+0x67/0x170
[709732.359298]  bnxt_poll+0x105/0x190 [bnxt_en]
[709732.359304]  ? irqentry_exit+0x29/0x30
[709732.359309]  ? asm_common_interrupt+0x1e/0x40
[709732.359315]  net_rx_action+0x144/0x3c0
[709732.359322]  __do_softirq+0xd5/0x29c
[709732.359329]  asm_call_irq_on_stack+0xf/0x20
[709732.359332]  </IRQ>
[709732.359339]  do_softirq_own_stack+0x37/0x40
[709732.359346]  irq_exit_rcu+0x9d/0xa0
[709732.359353]  common_interrupt+0x78/0x130
[709732.359358]  asm_common_interrupt+0x1e/0x40
[709732.359366] RIP: 0010:crc_41+0x0/0x1e [crc32c_intel]
[709732.359370] Code: ff ff f2 4d 0f 38 f1 93 a8 fe ff ff f2 4c 0f 38 f1 81=
 b0 fe ff ff f2 4c 0f 38 f1 8a b0 fe ff ff f2 4d 0f 38 f1 93 b0 fe ff ff <f=
2> 4c 0f 38 f1 81 b8 fe ff ff f2 4c 0f 38 f1 8a b8 fe ff ff f2 4d
[709732.359373] RSP: 0018:ffffbb97008dfcd0 EFLAGS: 00000246
[709732.359377] RAX: 000000000000002a RBX: 0000000000000400 RCX: ffff922fc5=
91dd50
[709732.359379] RDX: ffff922fc591dea0 RSI: 0000000000000a14 RDI: ffffffffc0=
0dddc0
[709732.359382] RBP: 0000000000001000 R08: 000000000342d8c3 R09: 0000000000=
000000
[709732.359384] R10: 0000000000000000 R11: ffff922fc591dff0 R12: ffffbb9700=
8dfe58
[709732.359386] R13: 000000000000000a R14: ffff922fd2b91e80 R15: ffff922fef=
83fe38
[709732.359395]  ? crc_43+0x1e/0x1e [crc32c_intel]
[709732.359403]  ? crc32c_pcl_intel_update+0x97/0xb0 [crc32c_intel]
[709732.359419]  ? jbd2_journal_commit_transaction+0xaec/0x1a30 [jbd2]
[709732.359425]  ? irq_exit_rcu+0x3e/0xa0
[709732.359447]  ? kjournald2+0xbd/0x270 [jbd2]
[709732.359454]  ? finish_wait+0x80/0x80
[709732.359470]  ? commit_timeout+0x10/0x10 [jbd2]
[709732.359476]  ? kthread+0x116/0x130
[709732.359481]  ? kthread_park+0x80/0x80
[709732.359488]  ? ret_from_fork+0x1f/0x30
[709732.359494] ---[ end trace 081a19978e5f09f5 ]---

that is, nft_pipapo_avx2_lookup() uses the FPU running from a softirq
that interrupted a kthread, also using the FPU.

That's exactly the reason why irq_fpu_usable() is there: use it, and
if we can't use the FPU, fall back to the non-AVX2 version of the
lookup operation, i.e. nft_pipapo_lookup().

Reported-by: Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc: <stable@vger.kernel.org> # 5.6.x
Fixes: 7400b063969b ("nft_set_pipapo: Introduce AVX2-based lookup implement=
ation")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_pipapo.c      | 4 ++--
 net/netfilter/nft_set_pipapo.h      | 2 ++
 net/netfilter/nft_set_pipapo_avx2.c | 3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 528a2d7ca991..dce866d93fee 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -408,8 +408,8 @@ int pipapo_refill(unsigned long *map, int len, int rule=
s, unsigned long *dst,
  *
  * Return: true on match, false otherwise.
  */
-static bool nft_pipapo_lookup(const struct net *net, const struct nft_set =
*set,
-			      const u32 *key, const struct nft_set_ext **ext)
+bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
+		       const u32 *key, const struct nft_set_ext **ext)
 {
 	struct nft_pipapo *priv =3D nft_set_priv(set);
 	unsigned long *res_map, *fill_map;
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index 25a75591583e..d84afb8fa79a 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -178,6 +178,8 @@ struct nft_pipapo_elem {
=20
 int pipapo_refill(unsigned long *map, int len, int rules, unsigned long *d=
st,
 		  union nft_pipapo_map_bucket *mt, bool match_only);
+bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
+		       const u32 *key, const struct nft_set_ext **ext);
=20
 /**
  * pipapo_and_field_buckets_4bit() - Intersect 4-bit buckets
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pi=
papo_avx2.c
index d65ae0e23028..eabdb8d552ee 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1131,6 +1131,9 @@ bool nft_pipapo_avx2_lookup(const struct net *net, co=
nst struct nft_set *set,
 	bool map_index;
 	int i, ret =3D 0;
=20
+	if (unlikely(!irq_fpu_usable()))
+		return nft_pipapo_lookup(net, set, key, ext);
+
 	m =3D rcu_dereference(priv->match);
=20
 	/* This also protects access to all data related to scratch maps */
--=20
2.20.1

