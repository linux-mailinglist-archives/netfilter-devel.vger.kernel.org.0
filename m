Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7395639F3B
	for <lists+netfilter-devel@lfdr.de>; Sat,  8 Jun 2019 13:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfFHLkJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 8 Jun 2019 07:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbfFHLkJ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:40:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3EF0214C6;
        Sat,  8 Jun 2019 11:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994008;
        bh=JXrhQNhjrDdbb4oqxmpIeeXL/JLVBMnK2x4IvI4wPZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wntV4+6U2YhgG2r3cbScRaXwJ6rcM1ZFLtubW5aaq63iBK+PSzSZsEYYJK8QtccwL
         2Gv0y/1zp9Mr8JiFoHWcymqEWOcfg4FluJi/PRy9N3f4wBX7YKaynXzoaeKJ7xXjQ0
         yMEp+F2sEc38qApfBHGkWXL3VRBPQksuUqA6dDa0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Julian Anastasov <ja@ssi.bg>,
        Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org
Subject: [PATCH AUTOSEL 5.1 13/70] ipvs: Fix use-after-free in ip_vs_in
Date:   Sat,  8 Jun 2019 07:38:52 -0400
Message-Id: <20190608113950.8033-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608113950.8033-1-sashal@kernel.org>
References: <20190608113950.8033-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 719c7d563c17b150877cee03a4b812a424989dfa ]

BUG: KASAN: use-after-free in ip_vs_in.part.29+0xe8/0xd20 [ip_vs]
Read of size 4 at addr ffff8881e9b26e2c by task sshd/5603

CPU: 0 PID: 5603 Comm: sshd Not tainted 4.19.39+ #30
Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
Call Trace:
 dump_stack+0x71/0xab
 print_address_description+0x6a/0x270
 kasan_report+0x179/0x2c0
 ip_vs_in.part.29+0xe8/0xd20 [ip_vs]
 ip_vs_in+0xd8/0x170 [ip_vs]
 nf_hook_slow+0x5f/0xe0
 __ip_local_out+0x1d5/0x250
 ip_local_out+0x19/0x60
 __tcp_transmit_skb+0xba1/0x14f0
 tcp_write_xmit+0x41f/0x1ed0
 ? _copy_from_iter_full+0xca/0x340
 __tcp_push_pending_frames+0x52/0x140
 tcp_sendmsg_locked+0x787/0x1600
 ? tcp_sendpage+0x60/0x60
 ? inet_sk_set_state+0xb0/0xb0
 tcp_sendmsg+0x27/0x40
 sock_sendmsg+0x6d/0x80
 sock_write_iter+0x121/0x1c0
 ? sock_sendmsg+0x80/0x80
 __vfs_write+0x23e/0x370
 vfs_write+0xe7/0x230
 ksys_write+0xa1/0x120
 ? __ia32_sys_read+0x50/0x50
 ? __audit_syscall_exit+0x3ce/0x450
 do_syscall_64+0x73/0x200
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7ff6f6147c60
Code: 73 01 c3 48 8b 0d 28 12 2d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 5d 73 2d 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83
RSP: 002b:00007ffd772ead18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000034 RCX: 00007ff6f6147c60
RDX: 0000000000000034 RSI: 000055df30a31270 RDI: 0000000000000003
RBP: 000055df30a31270 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffd772ead70 R11: 0000000000000246 R12: 00007ffd772ead74
R13: 00007ffd772eae20 R14: 00007ffd772eae24 R15: 000055df2f12ddc0

Allocated by task 6052:
 kasan_kmalloc+0xa0/0xd0
 __kmalloc+0x10a/0x220
 ops_init+0x97/0x190
 register_pernet_operations+0x1ac/0x360
 register_pernet_subsys+0x24/0x40
 0xffffffffc0ea016d
 do_one_initcall+0x8b/0x253
 do_init_module+0xe3/0x335
 load_module+0x2fc0/0x3890
 __do_sys_finit_module+0x192/0x1c0
 do_syscall_64+0x73/0x200
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 6067:
 __kasan_slab_free+0x130/0x180
 kfree+0x90/0x1a0
 ops_free_list.part.7+0xa6/0xc0
 unregister_pernet_operations+0x18b/0x1f0
 unregister_pernet_subsys+0x1d/0x30
 ip_vs_cleanup+0x1d/0xd2f [ip_vs]
 __x64_sys_delete_module+0x20c/0x300
 do_syscall_64+0x73/0x200
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8881e9b26600 which belongs to the cache kmalloc-4096 of size 4096
The buggy address is located 2092 bytes inside of 4096-byte region [ffff8881e9b26600, ffff8881e9b27600)
The buggy address belongs to the page:
page:ffffea0007a6c800 count:1 mapcount:0 mapping:ffff888107c0e600 index:0x0 compound_mapcount: 0
flags: 0x17ffffc0008100(slab|head)
raw: 0017ffffc0008100 dead000000000100 dead000000000200 ffff888107c0e600
raw: 0000000000000000 0000000080070007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

while unregistering ipvs module, ops_free_list calls
__ip_vs_cleanup, then nf_unregister_net_hooks be called to
do remove nf hook entries. It need a RCU period to finish,
however net->ipvs is set to NULL immediately, which will
trigger NULL pointer dereference when a packet is hooked
and handled by ip_vs_in where net->ipvs is dereferenced.

Another scene is ops_free_list call ops_free to free the
net_generic directly while __ip_vs_cleanup finished, then
calling ip_vs_in will triggers use-after-free.

This patch moves nf_unregister_net_hooks from __ip_vs_cleanup()
to __ip_vs_dev_cleanup(),  where rcu_barrier() is called by
unregister_pernet_device -> unregister_pernet_operations,
that will do the needed grace period.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: efe41606184e ("ipvs: convert to use pernet nf_hook api")
Suggested-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/ip_vs_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index 14457551bcb4..8ebf21149ec3 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -2312,7 +2312,6 @@ static void __net_exit __ip_vs_cleanup(struct net *net)
 {
 	struct netns_ipvs *ipvs = net_ipvs(net);
 
-	nf_unregister_net_hooks(net, ip_vs_ops, ARRAY_SIZE(ip_vs_ops));
 	ip_vs_service_net_cleanup(ipvs);	/* ip_vs_flush() with locks */
 	ip_vs_conn_net_cleanup(ipvs);
 	ip_vs_app_net_cleanup(ipvs);
@@ -2327,6 +2326,7 @@ static void __net_exit __ip_vs_dev_cleanup(struct net *net)
 {
 	struct netns_ipvs *ipvs = net_ipvs(net);
 	EnterFunction(2);
+	nf_unregister_net_hooks(net, ip_vs_ops, ARRAY_SIZE(ip_vs_ops));
 	ipvs->enable = 0;	/* Disable packet reception */
 	smp_wmb();
 	ip_vs_sync_net_cleanup(ipvs);
-- 
2.20.1

