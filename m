Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113CB74914B
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Jul 2023 01:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGEXEW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Jul 2023 19:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjGEXEV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:04:21 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0CC6122;
        Wed,  5 Jul 2023 16:04:19 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Subject: [PATCH net 6/6] netfilter: nf_tables: prevent OOB access in nft_byteorder_eval
Date:   Thu,  6 Jul 2023 01:04:06 +0200
Message-Id: <20230705230406.52201-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230705230406.52201-1-pablo@netfilter.org>
References: <20230705230406.52201-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

When evaluating byteorder expressions with size 2, a union with 32-bit and
16-bit members is used. Since the 16-bit members are aligned to 32-bit,
the array accesses will be out-of-bounds.

It may lead to a stack-out-of-bounds access like the one below:

[   23.095215] ==================================================================
[   23.095625] BUG: KASAN: stack-out-of-bounds in nft_byteorder_eval+0x13c/0x320
[   23.096020] Read of size 2 at addr ffffc90000007948 by task ping/115
[   23.096358]
[   23.096456] CPU: 0 PID: 115 Comm: ping Not tainted 6.4.0+ #413
[   23.096770] Call Trace:
[   23.096910]  <IRQ>
[   23.097030]  dump_stack_lvl+0x60/0xc0
[   23.097218]  print_report+0xcf/0x630
[   23.097388]  ? nft_byteorder_eval+0x13c/0x320
[   23.097577]  ? kasan_addr_to_slab+0xd/0xc0
[   23.097760]  ? nft_byteorder_eval+0x13c/0x320
[   23.097949]  kasan_report+0xc9/0x110
[   23.098106]  ? nft_byteorder_eval+0x13c/0x320
[   23.098298]  __asan_load2+0x83/0xd0
[   23.098453]  nft_byteorder_eval+0x13c/0x320
[   23.098659]  nft_do_chain+0x1c8/0xc50
[   23.098852]  ? __pfx_nft_do_chain+0x10/0x10
[   23.099078]  ? __kasan_check_read+0x11/0x20
[   23.099295]  ? __pfx___lock_acquire+0x10/0x10
[   23.099535]  ? __pfx___lock_acquire+0x10/0x10
[   23.099745]  ? __kasan_check_read+0x11/0x20
[   23.099929]  nft_do_chain_ipv4+0xfe/0x140
[   23.100105]  ? __pfx_nft_do_chain_ipv4+0x10/0x10
[   23.100327]  ? lock_release+0x204/0x400
[   23.100515]  ? nf_hook.constprop.0+0x340/0x550
[   23.100779]  nf_hook_slow+0x6c/0x100
[   23.100977]  ? __pfx_nft_do_chain_ipv4+0x10/0x10
[   23.101223]  nf_hook.constprop.0+0x334/0x550
[   23.101443]  ? __pfx_ip_local_deliver_finish+0x10/0x10
[   23.101677]  ? __pfx_nf_hook.constprop.0+0x10/0x10
[   23.101882]  ? __pfx_ip_rcv_finish+0x10/0x10
[   23.102071]  ? __pfx_ip_local_deliver_finish+0x10/0x10
[   23.102291]  ? rcu_read_lock_held+0x4b/0x70
[   23.102481]  ip_local_deliver+0xbb/0x110
[   23.102665]  ? __pfx_ip_rcv+0x10/0x10
[   23.102839]  ip_rcv+0x199/0x2a0
[   23.102980]  ? __pfx_ip_rcv+0x10/0x10
[   23.103140]  __netif_receive_skb_one_core+0x13e/0x150
[   23.103362]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[   23.103647]  ? mark_held_locks+0x48/0xa0
[   23.103819]  ? process_backlog+0x36c/0x380
[   23.103999]  __netif_receive_skb+0x23/0xc0
[   23.104179]  process_backlog+0x91/0x380
[   23.104350]  __napi_poll.constprop.0+0x66/0x360
[   23.104589]  ? net_rx_action+0x1cb/0x610
[   23.104811]  net_rx_action+0x33e/0x610
[   23.105024]  ? _raw_spin_unlock+0x23/0x50
[   23.105257]  ? __pfx_net_rx_action+0x10/0x10
[   23.105485]  ? mark_held_locks+0x48/0xa0
[   23.105741]  __do_softirq+0xfa/0x5ab
[   23.105956]  ? __dev_queue_xmit+0x765/0x1c00
[   23.106193]  do_softirq.part.0+0x49/0xc0
[   23.106423]  </IRQ>
[   23.106547]  <TASK>
[   23.106670]  __local_bh_enable_ip+0xf5/0x120
[   23.106903]  __dev_queue_xmit+0x789/0x1c00
[   23.107131]  ? __pfx___dev_queue_xmit+0x10/0x10
[   23.107381]  ? find_held_lock+0x8e/0xb0
[   23.107585]  ? lock_release+0x204/0x400
[   23.107798]  ? neigh_resolve_output+0x185/0x350
[   23.108049]  ? mark_held_locks+0x48/0xa0
[   23.108265]  ? neigh_resolve_output+0x185/0x350
[   23.108514]  neigh_resolve_output+0x246/0x350
[   23.108753]  ? neigh_resolve_output+0x246/0x350
[   23.109003]  ip_finish_output2+0x3c3/0x10b0
[   23.109250]  ? __pfx_ip_finish_output2+0x10/0x10
[   23.109510]  ? __pfx_nf_hook+0x10/0x10
[   23.109732]  __ip_finish_output+0x217/0x390
[   23.109978]  ip_finish_output+0x2f/0x130
[   23.110207]  ip_output+0xc9/0x170
[   23.110404]  ip_push_pending_frames+0x1a0/0x240
[   23.110652]  raw_sendmsg+0x102e/0x19e0
[   23.110871]  ? __pfx_raw_sendmsg+0x10/0x10
[   23.111093]  ? lock_release+0x204/0x400
[   23.111304]  ? __mod_lruvec_page_state+0x148/0x330
[   23.111567]  ? find_held_lock+0x8e/0xb0
[   23.111777]  ? find_held_lock+0x8e/0xb0
[   23.111993]  ? __rcu_read_unlock+0x7c/0x2f0
[   23.112225]  ? aa_sk_perm+0x18a/0x550
[   23.112431]  ? filemap_map_pages+0x4f1/0x900
[   23.112665]  ? __pfx_aa_sk_perm+0x10/0x10
[   23.112880]  ? find_held_lock+0x8e/0xb0
[   23.113098]  inet_sendmsg+0xa0/0xb0
[   23.113297]  ? inet_sendmsg+0xa0/0xb0
[   23.113500]  ? __pfx_inet_sendmsg+0x10/0x10
[   23.113727]  sock_sendmsg+0xf4/0x100
[   23.113924]  ? move_addr_to_kernel.part.0+0x4f/0xa0
[   23.114190]  __sys_sendto+0x1d4/0x290
[   23.114391]  ? __pfx___sys_sendto+0x10/0x10
[   23.114621]  ? __pfx_mark_lock.part.0+0x10/0x10
[   23.114869]  ? lock_release+0x204/0x400
[   23.115076]  ? find_held_lock+0x8e/0xb0
[   23.115287]  ? rcu_is_watching+0x23/0x60
[   23.115503]  ? __rseq_handle_notify_resume+0x6e2/0x860
[   23.115778]  ? __kasan_check_write+0x14/0x30
[   23.116008]  ? blkcg_maybe_throttle_current+0x8d/0x770
[   23.116285]  ? mark_held_locks+0x28/0xa0
[   23.116503]  ? do_syscall_64+0x37/0x90
[   23.116713]  __x64_sys_sendto+0x7f/0xb0
[   23.116924]  do_syscall_64+0x59/0x90
[   23.117123]  ? irqentry_exit_to_user_mode+0x25/0x30
[   23.117387]  ? irqentry_exit+0x77/0xb0
[   23.117593]  ? exc_page_fault+0x92/0x140
[   23.117806]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   23.118081] RIP: 0033:0x7f744aee2bba
[   23.118282] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
[   23.119237] RSP: 002b:00007ffd04a7c9f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[   23.119644] RAX: ffffffffffffffda RBX: 00007ffd04a7e0a0 RCX: 00007f744aee2bba
[   23.120023] RDX: 0000000000000040 RSI: 000056488e9e6300 RDI: 0000000000000003
[   23.120413] RBP: 000056488e9e6300 R08: 00007ffd04a80320 R09: 0000000000000010
[   23.120809] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000040
[   23.121219] R13: 00007ffd04a7dc38 R14: 00007ffd04a7ca00 R15: 00007ffd04a7e0a0
[   23.121617]  </TASK>
[   23.121749]
[   23.121845] The buggy address belongs to the virtual mapping at
[   23.121845]  [ffffc90000000000, ffffc90000009000) created by:
[   23.121845]  irq_init_percpu_irqstack+0x1cf/0x270
[   23.122707]
[   23.122803] The buggy address belongs to the physical page:
[   23.123104] page:0000000072ac19f0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x24a09
[   23.123609] flags: 0xfffffc0001000(reserved|node=0|zone=1|lastcpupid=0x1fffff)
[   23.123998] page_type: 0xffffffff()
[   23.124194] raw: 000fffffc0001000 ffffea0000928248 ffffea0000928248 0000000000000000
[   23.124610] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[   23.125023] page dumped because: kasan: bad access detected
[   23.125326]
[   23.125421] Memory state around the buggy address:
[   23.125682]  ffffc90000007800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   23.126072]  ffffc90000007880: 00 00 00 00 00 f1 f1 f1 f1 f1 f1 00 00 f2 f2 00
[   23.126455] >ffffc90000007900: 00 00 00 00 00 00 00 00 00 f2 f2 f2 f2 00 00 00
[   23.126840]                                               ^
[   23.127138]  ffffc90000007980: 00 00 00 00 00 00 00 00 00 00 00 00 00 f3 f3 f3
[   23.127522]  ffffc90000007a00: f3 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
[   23.127906] ==================================================================
[   23.128324] Disabling lock debugging due to kernel taint

Using simple s16 pointers for the 16-bit accesses fixes the problem. For
the 32-bit accesses, src and dst can be used directly.

Fixes: 96518518cc41 ("netfilter: add nftables")
Cc: stable@vger.kernel.org
Reported-by: Tanguy DUBROCA (@SidewayRE) from @Synacktiv working with ZDI
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_byteorder.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 9a85e797ed58..e596d1a842f7 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -30,11 +30,11 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 	const struct nft_byteorder *priv = nft_expr_priv(expr);
 	u32 *src = &regs->data[priv->sreg];
 	u32 *dst = &regs->data[priv->dreg];
-	union { u32 u32; u16 u16; } *s, *d;
+	u16 *s16, *d16;
 	unsigned int i;
 
-	s = (void *)src;
-	d = (void *)dst;
+	s16 = (void *)src;
+	d16 = (void *)dst;
 
 	switch (priv->size) {
 	case 8: {
@@ -62,11 +62,11 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i = 0; i < priv->len / 4; i++)
-				d[i].u32 = ntohl((__force __be32)s[i].u32);
+				dst[i] = ntohl((__force __be32)src[i]);
 			break;
 		case NFT_BYTEORDER_HTON:
 			for (i = 0; i < priv->len / 4; i++)
-				d[i].u32 = (__force __u32)htonl(s[i].u32);
+				dst[i] = (__force __u32)htonl(src[i]);
 			break;
 		}
 		break;
@@ -74,11 +74,11 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i = 0; i < priv->len / 2; i++)
-				d[i].u16 = ntohs((__force __be16)s[i].u16);
+				d16[i] = ntohs((__force __be16)s16[i]);
 			break;
 		case NFT_BYTEORDER_HTON:
 			for (i = 0; i < priv->len / 2; i++)
-				d[i].u16 = (__force __u16)htons(s[i].u16);
+				d16[i] = (__force __u16)htons(s16[i]);
 			break;
 		}
 		break;
-- 
2.30.2

