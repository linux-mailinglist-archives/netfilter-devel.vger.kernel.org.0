Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0C8435EAC
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Oct 2021 12:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhJUKKp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Oct 2021 06:10:45 -0400
Received: from mail.netfilter.org ([217.70.188.207]:33822 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbhJUKKo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:10:44 -0400
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 5D5DA63F3A;
        Thu, 21 Oct 2021 12:06:44 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH net 1/8] netfilter: xt_IDLETIMER: fix panic that occurs when timer_type has garbage value
Date:   Thu, 21 Oct 2021 12:08:14 +0200
Message-Id: <20211021100821.964677-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021100821.964677-1-pablo@netfilter.org>
References: <20211021100821.964677-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Juhee Kang <claudiajkang@gmail.com>

Currently, when the rule related to IDLETIMER is added, idletimer_tg timer
structure is initialized by kmalloc on executing idletimer_tg_create
function. However, in this process timer->timer_type is not defined to
a specific value. Thus, timer->timer_type has garbage value and it occurs
kernel panic. So, this commit fixes the panic by initializing
timer->timer_type using kzalloc instead of kmalloc.

Test commands:
    # iptables -A OUTPUT -j IDLETIMER --timeout 1 --label test
    $ cat /sys/class/xt_idletimer/timers/test
      Killed

Splat looks like:
    BUG: KASAN: user-memory-access in alarm_expires_remaining+0x49/0x70
    Read of size 8 at addr 0000002e8c7bc4c8 by task cat/917
    CPU: 12 PID: 917 Comm: cat Not tainted 5.14.0+ #3 79940a339f71eb14fc81aee1757a20d5bf13eb0e
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
    Call Trace:
     dump_stack_lvl+0x6e/0x9c
     kasan_report.cold+0x112/0x117
     ? alarm_expires_remaining+0x49/0x70
     __asan_load8+0x86/0xb0
     alarm_expires_remaining+0x49/0x70
     idletimer_tg_show+0xe5/0x19b [xt_IDLETIMER 11219304af9316a21bee5ba9d58f76a6b9bccc6d]
     dev_attr_show+0x3c/0x60
     sysfs_kf_seq_show+0x11d/0x1f0
     ? device_remove_bin_file+0x20/0x20
     kernfs_seq_show+0xa4/0xb0
     seq_read_iter+0x29c/0x750
     kernfs_fop_read_iter+0x25a/0x2c0
     ? __fsnotify_parent+0x3d1/0x570
     ? iov_iter_init+0x70/0x90
     new_sync_read+0x2a7/0x3d0
     ? __x64_sys_llseek+0x230/0x230
     ? rw_verify_area+0x81/0x150
     vfs_read+0x17b/0x240
     ksys_read+0xd9/0x180
     ? vfs_write+0x460/0x460
     ? do_syscall_64+0x16/0xc0
     ? lockdep_hardirqs_on+0x79/0x120
     __x64_sys_read+0x43/0x50
     do_syscall_64+0x3b/0xc0
     entry_SYSCALL_64_after_hwframe+0x44/0xae
    RIP: 0033:0x7f0cdc819142
    Code: c0 e9 c2 fe ff ff 50 48 8d 3d 3a ca 0a 00 e8 f5 19 02 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
    RSP: 002b:00007fff28eee5b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
    RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f0cdc819142
    RDX: 0000000000020000 RSI: 00007f0cdc032000 RDI: 0000000000000003
    RBP: 00007f0cdc032000 R08: 00007f0cdc031010 R09: 0000000000000000
    R10: 0000000000000022 R11: 0000000000000246 R12: 00005607e9ee31f0
    R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000

Fixes: 68983a354a65 ("netfilter: xtables: Add snapshot of hardidletimer target")
Signed-off-by: Juhee Kang <claudiajkang@gmail.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/xt_IDLETIMER.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_IDLETIMER.c b/net/netfilter/xt_IDLETIMER.c
index 7b2f359bfce4..2f7cf5ecebf4 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -137,7 +137,7 @@ static int idletimer_tg_create(struct idletimer_tg_info *info)
 {
 	int ret;
 
-	info->timer = kmalloc(sizeof(*info->timer), GFP_KERNEL);
+	info->timer = kzalloc(sizeof(*info->timer), GFP_KERNEL);
 	if (!info->timer) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.30.2

