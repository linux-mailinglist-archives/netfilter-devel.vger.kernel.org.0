Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A906F3B1EC7
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Jun 2021 18:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFWQj0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Jun 2021 12:39:26 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:35474 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhFWQjZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:39:25 -0400
Received: by mail-io1-f69.google.com with SMTP id y14-20020a6bc80e0000b02904dc72726661so2350803iof.2
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Jun 2021 09:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xHV6uhXhnhn6QjEbydDXH/eLfRqTV4+vbi61GlVRn/M=;
        b=Fhz630cgtcLxxD5lOuxRcyEiL+YOTjc5FIw0sjNT9O6Y0DeQUOHD2MwxoZf/7Z7QnG
         8cbRudqV2AHnxO511q2PUVBhnLSpyaeO8/hDjuIo2szBDovQKc8fVQcXblNzTRfcWZZ0
         t2qjmf6gzHEGpM/XHMRYKe0FIvqZZkD//Lk74Ql4+g8IbvW8Q6i4s/9YxeE8SccImABt
         +XOP1zf2kKmB5MnKJgIZ+LOTSaUU3Ce9wrC4BBOq2lkt2k7wuwtlv+L9OPw88Uq9kkZU
         /2wqLe6R+1S9jXSDywtkgRnugt/N6Y7wj9MP11IQwKGvkgERBshPO0mrsYfBlq6+0gOG
         PkrA==
X-Gm-Message-State: AOAM533Ap8HPOT0/JKHNQWXpjSF4h/YoqLOqYrcCBzD8QgyGnlDUlclV
        Cvq/ZP/w+K+ke99lISJ0Qiksa2wPdCZ2hHoUJsFM4sbe3vFI
X-Google-Smtp-Source: ABdhPJwtNRjbWMUnfGPMDKqBsHaMpz+FPFNkC+ZTbQWCve0Zl2osvtyp66UxDFxr0RTK3o/rjb2IoH3ArMWEw/7ai+dnt2iCvt7V
MIME-Version: 1.0
X-Received: by 2002:a92:c566:: with SMTP id b6mr239270ilj.84.1624466227680;
 Wed, 23 Jun 2021 09:37:07 -0700 (PDT)
Date:   Wed, 23 Jun 2021 09:37:07 -0700
In-Reply-To: <20210623191928.69d279d1@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000735a3b05c571846d@google.com>
Subject: Re: [syzbot] WARNING: zero-size vmalloc in corrupted
From:   syzbot <syzbot+c2f6f09fe907a838effb@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, coreteam@netfilter.org,
        davem@davemloft.net, dsahern@kernel.org, fw@strlen.de,
        kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, paskripkin@gmail.com,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in lock_sock_nested

BUG: sleeping function called from invalid context at net/core/sock.c:3064
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 8843, name: syz-executor.2
1 lock held by syz-executor.2/8843:
 #0: ffffffff8d0c43c0 (hci_sk_list.lock){++++}-{2:2}, at: hci_sock_dev_event+0x3db/0x660 net/bluetooth/hci_sock.c:763
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 8843 Comm: syz-executor.2 Not tainted 5.13.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:8337
 lock_sock_nested+0x25/0x120 net/core/sock.c:3064
 lock_sock include/net/sock.h:1610 [inline]
 hci_sock_dev_event+0x465/0x660 net/bluetooth/hci_sock.c:765
 hci_unregister_dev+0x2fd/0x1130 net/bluetooth/hci_core.c:4013
 vhci_release+0x70/0xe0 drivers/bluetooth/hci_vhci.c:340
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xbfc/0x2a60 kernel/exit.c:826
 do_group_exit+0x125/0x310 kernel/exit.c:923
 __do_sys_exit_group kernel/exit.c:934 [inline]
 __se_sys_exit_group kernel/exit.c:932 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:932
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: Unable to access opcode bytes at RIP 0x4665af.
RSP: 002b:00007fff82506ba8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fff82507368 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000043
RBP: 0000000000000000 R08: 0000000000000025 R09: 00007fff82507368
R10: 00000000ffffffff R11: 0000000000000246 R12: 00000000004bef54
R13: 0000000000000010 R14: 0000000000000000 R15: 0000000000400538

======================================================


Tested on:

commit:         0c18f29a module: limit enabling module.sig_enforce
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ae9658300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3932cedd2c2d4a69
dashboard link: https://syzkaller.appspot.com/bug?extid=c2f6f09fe907a838effb
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fc8400300000

