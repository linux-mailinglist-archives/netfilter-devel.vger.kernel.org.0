Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E464147868C
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Dec 2021 09:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhLQIxP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 Dec 2021 03:53:15 -0500
Received: from mail.netfilter.org ([217.70.188.207]:60488 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhLQIxO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 Dec 2021 03:53:14 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id A78CC607E0;
        Fri, 17 Dec 2021 09:50:42 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH net 1/3] netfilter: nf_tables: fix use-after-free in nft_set_catchall_destroy()
Date:   Fri, 17 Dec 2021 09:53:01 +0100
Message-Id: <20211217085303.363401-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211217085303.363401-1-pablo@netfilter.org>
References: <20211217085303.363401-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

We need to use list_for_each_entry_safe() iterator
because we can not access @catchall after kfree_rcu() call.

syzbot reported:

BUG: KASAN: use-after-free in nft_set_catchall_destroy net/netfilter/nf_tables_api.c:4486 [inline]
BUG: KASAN: use-after-free in nft_set_destroy net/netfilter/nf_tables_api.c:4504 [inline]
BUG: KASAN: use-after-free in nft_set_destroy+0x3fd/0x4f0 net/netfilter/nf_tables_api.c:4493
Read of size 8 at addr ffff8880716e5b80 by task syz-executor.3/8871

CPU: 1 PID: 8871 Comm: syz-executor.3 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x2ed mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
 nft_set_catchall_destroy net/netfilter/nf_tables_api.c:4486 [inline]
 nft_set_destroy net/netfilter/nf_tables_api.c:4504 [inline]
 nft_set_destroy+0x3fd/0x4f0 net/netfilter/nf_tables_api.c:4493
 __nft_release_table+0x79f/0xcd0 net/netfilter/nf_tables_api.c:9626
 nft_rcv_nl_event+0x4f8/0x670 net/netfilter/nf_tables_api.c:9688
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 blocking_notifier_call_chain kernel/notifier.c:318 [inline]
 blocking_notifier_call_chain+0x67/0x90 kernel/notifier.c:306
 netlink_release+0xcb6/0x1dd0 net/netlink/af_netlink.c:788
 __sock_release+0xcd/0x280 net/socket.c:649
 sock_close+0x18/0x20 net/socket.c:1314
 __fput+0x286/0x9f0 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f75fbf28adb
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffd8da7ec10 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007f75fbf28adb
RDX: 00007f75fc08e828 RSI: ffffffffffffffff RDI: 0000000000000003
RBP: 00007f75fc08a960 R08: 0000000000000000 R09: 00007f75fc08e830
R10: 00007ffd8da7ed10 R11: 0000000000000293 R12: 00000000002067c3
R13: 00007ffd8da7ed10 R14: 00007f75fc088f60 R15: 0000000000000032
 </TASK>

Allocated by task 8886:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0xa6/0xd0 mm/kasan/common.c:522
 kasan_kmalloc include/linux/kasan.h:269 [inline]
 kmem_cache_alloc_trace+0x1ea/0x4a0 mm/slab.c:3575
 kmalloc include/linux/slab.h:590 [inline]
 nft_setelem_catchall_insert net/netfilter/nf_tables_api.c:5544 [inline]
 nft_setelem_insert net/netfilter/nf_tables_api.c:5562 [inline]
 nft_add_set_elem+0x232e/0x2f40 net/netfilter/nf_tables_api.c:5936
 nf_tables_newsetelem+0x6ff/0xbb0 net/netfilter/nf_tables_api.c:6032
 nfnetlink_rcv_batch+0x1710/0x25f0 net/netfilter/nfnetlink.c:513
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:634 [inline]
 nfnetlink_rcv+0x3af/0x420 net/netfilter/nfnetlink.c:652
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x904/0xdf0 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:724
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2409
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2463
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2492
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 15335:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xd1/0x110 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:235 [inline]
 __cache_free mm/slab.c:3445 [inline]
 kmem_cache_free_bulk+0x67/0x1e0 mm/slab.c:3766
 kfree_bulk include/linux/slab.h:446 [inline]
 kfree_rcu_work+0x51c/0xa10 kernel/rcu/tree.c:3273
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Last potentially related work creation:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xb5/0xe0 mm/kasan/generic.c:348
 kvfree_call_rcu+0x74/0x990 kernel/rcu/tree.c:3550
 nft_set_catchall_destroy net/netfilter/nf_tables_api.c:4489 [inline]
 nft_set_destroy net/netfilter/nf_tables_api.c:4504 [inline]
 nft_set_destroy+0x34a/0x4f0 net/netfilter/nf_tables_api.c:4493
 __nft_release_table+0x79f/0xcd0 net/netfilter/nf_tables_api.c:9626
 nft_rcv_nl_event+0x4f8/0x670 net/netfilter/nf_tables_api.c:9688
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 blocking_notifier_call_chain kernel/notifier.c:318 [inline]
 blocking_notifier_call_chain+0x67/0x90 kernel/notifier.c:306
 netlink_release+0xcb6/0x1dd0 net/netlink/af_netlink.c:788
 __sock_release+0xcd/0x280 net/socket.c:649
 sock_close+0x18/0x20 net/socket.c:1314
 __fput+0x286/0x9f0 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff8880716e5b80
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes inside of
 64-byte region [ffff8880716e5b80, ffff8880716e5bc0)
The buggy address belongs to the page:
page:ffffea0001c5b940 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880716e5c00 pfn:0x716e5
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0000911848 ffffea00007c4d48 ffff888010c40200
raw: ffff8880716e5c00 ffff8880716e5000 000000010000001e 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x242040(__GFP_IO|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 3638, ts 211086074437, free_ts 211031029429
 prep_new_page mm/page_alloc.c:2418 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4149
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5369
 __alloc_pages_node include/linux/gfp.h:570 [inline]
 kmem_getpages mm/slab.c:1377 [inline]
 cache_grow_begin+0x75/0x470 mm/slab.c:2593
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2965
 ____cache_alloc mm/slab.c:3048 [inline]
 ____cache_alloc mm/slab.c:3031 [inline]
 __do_cache_alloc mm/slab.c:3275 [inline]
 slab_alloc mm/slab.c:3316 [inline]
 __do_kmalloc mm/slab.c:3700 [inline]
 __kmalloc+0x3b3/0x4d0 mm/slab.c:3711
 kmalloc include/linux/slab.h:595 [inline]
 kzalloc include/linux/slab.h:724 [inline]
 tomoyo_get_name+0x234/0x480 security/tomoyo/memory.c:173
 tomoyo_parse_name_union+0xbc/0x160 security/tomoyo/util.c:260
 tomoyo_update_path_number_acl security/tomoyo/file.c:687 [inline]
 tomoyo_write_file+0x629/0x7f0 security/tomoyo/file.c:1034
 tomoyo_write_domain2+0x116/0x1d0 security/tomoyo/common.c:1152
 tomoyo_add_entry security/tomoyo/common.c:2042 [inline]
 tomoyo_supervisor+0xbc7/0xf00 security/tomoyo/common.c:2103
 tomoyo_audit_path_number_log security/tomoyo/file.c:235 [inline]
 tomoyo_path_number_perm+0x419/0x590 security/tomoyo/file.c:734
 security_file_ioctl+0x50/0xb0 security/security.c:1541
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0xb3/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3309 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3388
 slab_destroy mm/slab.c:1627 [inline]
 slabs_destroy+0x89/0xc0 mm/slab.c:1647
 cache_flusharray mm/slab.c:3418 [inline]
 ___cache_free+0x4cc/0x610 mm/slab.c:3480
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x4e/0x110 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0x97/0xb0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:259 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slab.c:3261 [inline]
 kmem_cache_alloc_node+0x2ea/0x590 mm/slab.c:3599
 __alloc_skb+0x215/0x340 net/core/skbuff.c:414
 alloc_skb include/linux/skbuff.h:1126 [inline]
 nlmsg_new include/net/netlink.h:953 [inline]
 rtmsg_ifinfo_build_skb+0x72/0x1a0 net/core/rtnetlink.c:3808
 rtmsg_ifinfo_event net/core/rtnetlink.c:3844 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:3835 [inline]
 rtmsg_ifinfo+0x83/0x120 net/core/rtnetlink.c:3853
 netdev_state_change net/core/dev.c:1395 [inline]
 netdev_state_change+0x114/0x130 net/core/dev.c:1386
 linkwatch_do_dev+0x10e/0x150 net/core/link_watch.c:167
 __linkwatch_run_queue+0x233/0x6a0 net/core/link_watch.c:213
 linkwatch_event+0x4a/0x60 net/core/link_watch.c:252
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298

Memory state around the buggy address:
 ffff8880716e5a80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880716e5b00: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>ffff8880716e5b80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                   ^
 ffff8880716e5c00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880716e5c80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc

Fixes: aaa31047a6d2 ("netfilter: nftables: add catch-all set element support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c0851fec11d4..c20772822637 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4481,9 +4481,9 @@ struct nft_set_elem_catchall {
 static void nft_set_catchall_destroy(const struct nft_ctx *ctx,
 				     struct nft_set *set)
 {
-	struct nft_set_elem_catchall *catchall;
+	struct nft_set_elem_catchall *next, *catchall;
 
-	list_for_each_entry_rcu(catchall, &set->catchall_list, list) {
+	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
 		list_del_rcu(&catchall->list);
 		nft_set_elem_destroy(set, catchall->elem, true);
 		kfree_rcu(catchall);
-- 
2.30.2

