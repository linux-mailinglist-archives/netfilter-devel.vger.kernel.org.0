Return-Path: <netfilter-devel+bounces-5287-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4892C9D45D7
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Nov 2024 03:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06D6B214BF
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Nov 2024 02:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22157F477;
	Thu, 21 Nov 2024 02:46:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745B61FCE
	for <netfilter-devel@vger.kernel.org>; Thu, 21 Nov 2024 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157189; cv=none; b=eOBLNvGi9ZqGUH8FMgK6R+4BnAJFeblWaCNFYqYwqOROdVZVrGuZDexvAaCtokvtyYR1GBFmqQq4NCBmKK9dHYUY0WpXC2BUJo6/wjjrBF4cfA4xWVmF2y9OAy26x3qXzumEGDIGTkD0qIzGPNmUgpFztrq+wJoaUxpfUFlzbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157189; c=relaxed/simple;
	bh=QIE3RsZU6Ofg43CF+68PquFTXyvarykYKBh/yCUbkyw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KkKVs0TsDQCJ5NxdQAvhUEMeA1enwLqASJrcfVON3dUm4JZn1KVN5j2NnoA7RlGU5V8342UIzF3O7F1BH3kiWjv9iP98BWz1NLawV8jSUXe1mF0NNwtxAS5DgboXgcgWIQ6p2weFiMqrBFikP5a2E5yCkbhK+O6ST3iGL2PZmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abf723da3so47828739f.3
        for <netfilter-devel@vger.kernel.org>; Wed, 20 Nov 2024 18:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157187; x=1732761987;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cWV0TB3RbAdwpZhe94gjfFz4YWvUifGVnrDyaH+TfM=;
        b=F1XNXGYky+CoVr8SiF3VQuFqm41H6yedvowFH12WlQkMoaKFcAoJod0/j5wp5Dy1bC
         8XoU1/tOxBcl00VSEgIliJ3eTYBsWIhT1hl3hOy0F3HsFY6G/gcFR2sIM5szp56MCX3j
         ZlvlXONW6Xt/RyfzxXfEZ+d3p88wl/qJnq+CnN+SVFxEXmTJAskx3sbtVC+9hz9MWFJ3
         VyL6rHPUAhJVlaz0EJAtKUX8wlPcb4t3/3t3QPw8+WgLxfx1H5c4kv+uYmPXmY2X9xnH
         H9ya2WsUH9jtIixTj14Es5M9TAfaAiUzbHma57laUJFG3PhCIg96HAoCnzQU7ygeLna6
         8vFA==
X-Forwarded-Encrypted: i=1; AJvYcCVs23C1oXZncTNiP/bOg6+MtLD5CT0evj5EjxiL0bnzODTBWZIN3q1L3ZTactOUsXOpPSQCCwUjcFm6oaAqyYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybcCVnZ1nLYR1XK62XEF/L/irlz4l3bsPd3lt+H+2Ql4wVJTCF
	CdM+TQHnKoa/Z1MWx3S4j8FSCc0fDdddfydsD97zgTORJSu3iHYVla0uqpGXEPCS7QnRsU8xGTE
	te5xt3DUwEaaheIxv6JyWSsIjxmzbjiTNgHkbOh+E4vcWWhNh8z86ShQ=
X-Google-Smtp-Source: AGHT+IFQGh1oVRrx1tklJQMMYS2fod8ToZ3fhlNnKer7zGFxS1mMCVmTap/8Hbu74PikTeQUfn/Ni7rfK3H56QI7b029QSCxTSu2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cf:b0:3a7:7558:a6ea with SMTP id
 e9e14a558f8ab-3a786486002mr65427875ab.10.1732157187082; Wed, 20 Nov 2024
 18:46:27 -0800 (PST)
Date: Wed, 20 Nov 2024 18:46:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673e9f03.050a0220.363a1b.0081.GAE@google.com>
Subject: [syzbot] [netfilter?] KASAN: slab-out-of-bounds Read in led_tg_check
From: syzbot <syzbot+6c8215822f35fdb35667@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	fw@strlen.de, horms@kernel.org, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    38f83a57aa8e Merge branch 'virtio-net-support-af_xdp-zero-..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13f19378580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6d63a300b6a84a4
dashboard link: https://syzkaller.appspot.com/bug?extid=6c8215822f35fdb35667
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169dd2c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130552e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a7abf65d2870/disk-38f83a57.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2958de0862bb/vmlinux-38f83a57.xz
kernel image: https://storage.googleapis.com/syzbot-assets/404efcb8d16f/bzImage-38f83a57.xz

The issue was bisected to:

commit 6001a930ce0378b62210d4f83583fc88a903d89d
Author: Pablo Neira Ayuso <pablo@netfilter.org>
Date:   Mon Feb 15 11:28:07 2021 +0000

    netfilter: nftables: introduce table ownership

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=172932e8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14a932e8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10a932e8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c8215822f35fdb35667@syzkaller.appspotmail.com
Fixes: 6001a930ce03 ("netfilter: nftables: introduce table ownership")

==================================================================
BUG: KASAN: slab-out-of-bounds in strlen+0x58/0x70 lib/string.c:402
Read of size 1 at addr ffff8881422aa1c8 by task syz-executor355/5842

CPU: 1 UID: 0 PID: 5842 Comm: syz-executor355 Not tainted 6.12.0-rc7-syzkaller-01681-g38f83a57aa8e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 strlen+0x58/0x70 lib/string.c:402
 kstrdup+0x20/0x80 mm/util.c:63
 led_tg_check+0x18b/0x3c0 net/netfilter/xt_LED.c:115
 xt_check_target+0x3b9/0xa40 net/netfilter/x_tables.c:1038
 nft_target_init+0x82d/0xc30 net/netfilter/nft_compat.c:267
 nf_tables_newexpr net/netfilter/nf_tables_api.c:3444 [inline]
 nf_tables_newrule+0x185e/0x2980 net/netfilter/nf_tables_api.c:4272
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:524 [inline]
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:647 [inline]
 nfnetlink_rcv+0x14e3/0x2ab0 net/netfilter/nfnetlink.c:665
 netlink_unicast_kernel net/netlink/af_netlink.c:1316 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1342
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1886
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2609
 ___sys_sendmsg net/socket.c:2663 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2692
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f56d8509729
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc32fd10f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffc32fd12c8 RCX: 00007f56d8509729
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007f56d857c610 R08: 0000000000000011 R09: 00007ffc32fd12c8
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc32fd12b8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5842:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 nf_tables_newrule+0x1609/0x2980 net/netfilter/nf_tables_api.c:4254
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:524 [inline]
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:647 [inline]
 nfnetlink_rcv+0x14e3/0x2ab0 net/netfilter/nfnetlink.c:665
 netlink_unicast_kernel net/netlink/af_netlink.c:1316 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1342
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1886
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2609
 ___sys_sendmsg net/socket.c:2663 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2692
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8881422aa180
 which belongs to the cache kmalloc-cg-96 of size 96
The buggy address is located 0 bytes to the right of
 allocated 72-byte region [ffff8881422aa180, ffff8881422aa1c8)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1422aa
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000000 ffff88801ac4d640 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 2682440014, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 __register_sysctl_table+0x65/0x1550 fs/proc/proc_sysctl.c:1368
 net_sysctl_init+0x20/0x90 net/sysctl_net.c:103
 sock_init+0x6b/0x1c0 net/socket.c:3293
 do_one_initcall+0x248/0x880 init/main.c:1269
 do_initcall_level+0x157/0x210 init/main.c:1331
 do_initcalls+0x3f/0x80 init/main.c:1347
 kernel_init_freeable+0x435/0x5d0 init/main.c:1580
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8881422aa080: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
 ffff8881422aa100: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
>ffff8881422aa180: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
                                              ^
 ffff8881422aa200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881422aa280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

