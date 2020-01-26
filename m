Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C96149C66
	for <lists+netfilter-devel@lfdr.de>; Sun, 26 Jan 2020 19:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAZS5M (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 26 Jan 2020 13:57:12 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:45769 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAZS5L (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 26 Jan 2020 13:57:11 -0500
Received: by mail-il1-f199.google.com with SMTP id w6so5994170ill.12
        for <netfilter-devel@vger.kernel.org>; Sun, 26 Jan 2020 10:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4ZP9aA+zIEpB3uIuHSmth1jADn5k/uQ+B1Zpr7nQv70=;
        b=olXGk2MR1RAnFyR7KIS+6KY6aUBVCUwEjvN68xw/uW/r2nmYKMDIWfG2A9LbgEl2D6
         6JT0nV35R7wWh9zNAkzEcWPAzlZmXFaIhtx1VQ98J0RfIDBoEWWdnVo/uvq+viWB6RJD
         tJz5/FebWNqVWTnJ1nF2ypOGMEIYDHcE5B2cAvowdIzoYSS+jVBuc4acnOr/Ri1xbaq5
         97r2q5apb/kOBEW52FOz64MO72eacuztREzq9GNsaTfzNiiT5kCPFZlxC3q3HTi1jvHa
         L9KVk0sWwjV5JNnJaEmz058k710DAKRJt7tue5nLTeEB7/Emg9N0U/LRiqHqMenXDLGc
         eatw==
X-Gm-Message-State: APjAAAX++fvJ1aOmPfjknmibwzIM4k3St8qAPDuoaIZ2LK6biUiaOWen
        bUhLB2zO4foa1ftoPIVBHcGiyk9VRqnjmXO94vAlPUyXQ6sU
X-Google-Smtp-Source: APXvYqyhTQI5JmG+C2CBt0HtVr+q//jXnYkZKUeUwJrs4rMHlctKas/u39x6bOc/pyKNSABZ9eXHUsAfhmVHhh2iGMwipBXb5Um0
MIME-Version: 1.0
X-Received: by 2002:a92:d84c:: with SMTP id h12mr5048206ilq.127.1580065031160;
 Sun, 26 Jan 2020 10:57:11 -0800 (PST)
Date:   Sun, 26 Jan 2020 10:57:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e78d8a059d0f8eba@google.com>
Subject: general protection fault in ip_set_comment_free
From:   syzbot <syzbot+6a86565c74ebe30aea18@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net,
        florent.fourcot@wifirst.fr, fw@strlen.de, jeremy@azazel.net,
        johannes.berg@intel.com, kadlec@blackhole.kfki.hu,
        kadlec@netfilter.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d5d359b0 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1366c611e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf8e288883e40aba
dashboard link: https://syzkaller.appspot.com/bug?extid=6a86565c74ebe30aea18
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12df0376e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d225c9e00000

The bug was bisected to:

commit 23c42a403a9cfdbad6004a556c927be7dd61a8ee
Author: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Date:   Sat Oct 27 13:07:40 2018 +0000

    netfilter: ipset: Introduction of new commands and protocol version 7

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12508376e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11508376e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16508376e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6a86565c74ebe30aea18@syzkaller.appspotmail.com
Fixes: 23c42a403a9c ("netfilter: ipset: Introduction of new commands and protocol version 7")

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9800 Comm: syz-executor125 Not tainted 5.5.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:strlen+0x1f/0xa0 lib/string.c:527
Code: 00 66 2e 0f 1f 84 00 00 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48 89 fa 48 89 e5 48 c1 ea 03 41 54 49 89 fc 53 48 83 ec 08 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 4d 41 80 3c 24
RSP: 0018:ffffc90001fa6e90 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: ffff88808f875f18 RCX: 1ffffffff14f6ffe
RDX: 0000000000000042 RSI: ffffffff8673d9a1 RDI: 0000000000000214
RBP: ffffc90001fa6ea8 R08: ffff8880870de500 R09: ffffed1011f0ebe3
R10: ffffed1011f0ebe2 R11: ffff88808f875f17 R12: 0000000000000214
R13: 0000000000000204 R14: ffff8880a5508200 R15: ffff88808f875f00
FS:  00000000014a2880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000000a9778000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 strlen include/linux/string.h:302 [inline]
 ip_set_comment_free+0x69/0xe0 net/netfilter/ipset/ip_set_core.c:402
 ip_set_ext_destroy include/linux/netfilter/ipset/ip_set.h:275 [inline]
 ip_set_ext_destroy include/linux/netfilter/ipset/ip_set.h:267 [inline]
 hash_net4_add+0x1b9a/0x2200 net/netfilter/ipset/ip_set_hash_gen.h:766
 hash_net4_uadt+0x596/0x940 net/netfilter/ipset/ip_set_hash_net.c:195
 call_ad+0x1a0/0x5a0 net/netfilter/ipset/ip_set_core.c:1716
 ip_set_ad.isra.0+0x572/0xb20 net/netfilter/ipset/ip_set_core.c:1804
 ip_set_uadd+0x37/0x50 net/netfilter/ipset/ip_set_core.c:1829
 nfnetlink_rcv_msg+0xcf2/0xfb0 net/netfilter/nfnetlink.c:229
 netlink_rcv_skb+0x177/0x450 net/netlink/af_netlink.c:2477
 nfnetlink_rcv+0x1ba/0x460 net/netfilter/nfnetlink.c:563
 netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
 netlink_unicast+0x58c/0x7d0 net/netlink/af_netlink.c:1328
 netlink_sendmsg+0x91c/0xea0 net/netlink/af_netlink.c:1917
 sock_sendmsg_nosec net/socket.c:639 [inline]
 sock_sendmsg+0xd7/0x130 net/socket.c:659
 ____sys_sendmsg+0x753/0x880 net/socket.c:2330
 ___sys_sendmsg+0x100/0x170 net/socket.c:2384
 __sys_sendmsg+0x105/0x1d0 net/socket.c:2417
 __do_sys_sendmsg net/socket.c:2426 [inline]
 __se_sys_sendmsg net/socket.c:2424 [inline]
 __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2424
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440379
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcfb990398 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440379
RDX: 0000000000000000 RSI: 0000000020000d00 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000401c00
R13: 0000000000401c90 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace a6760a9ec122842d ]---
RIP: 0010:strlen+0x1f/0xa0 lib/string.c:527
Code: 00 66 2e 0f 1f 84 00 00 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48 89 fa 48 89 e5 48 c1 ea 03 41 54 49 89 fc 53 48 83 ec 08 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 4d 41 80 3c 24
RSP: 0018:ffffc90001fa6e90 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: ffff88808f875f18 RCX: 1ffffffff14f6ffe
RDX: 0000000000000042 RSI: ffffffff8673d9a1 RDI: 0000000000000214
RBP: ffffc90001fa6ea8 R08: ffff8880870de500 R09: ffffed1011f0ebe3
R10: ffffed1011f0ebe2 R11: ffff88808f875f17 R12: 0000000000000214
R13: 0000000000000204 R14: ffff8880a5508200 R15: ffff88808f875f00
FS:  00000000014a2880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000000a9778000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
