Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230EA5BD83B
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Sep 2022 01:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiISX1n (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Sep 2022 19:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiISX1m (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:27:42 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519F84E844
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Sep 2022 16:27:39 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id h205-20020a6bb7d6000000b006a1e6bef9c7so518019iof.17
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Sep 2022 16:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=QcDADadZBFn2stVq46mmrKDcyHCKkZFC4s8yQUc8C/I=;
        b=f4zBOYHxz46AzxPG0533e4O/FZ4g7ul7f2YPmRq1NSlksoHKOYgM2L4ihIbFIxrQhz
         FEKNn/ELJMTFny3wlmbOHWr3085Y7Mrz/HmTEB1w22+Xkch3qb8wrD1rQH4obpbLuGKD
         BECClOY/HHIJucUdDGWuOq4rWhiF6+Mm+C/URFh4T7bmcT3YEj4Zf54KB3Sqr3WHc1ff
         uzGClFUpJR1aiJqPj/CU09A6hE5ZojbqHwC3KqSiG8Go+RxqA+2Ap/weeHXAAT5FvAN0
         oBKn+OJSupWOHRjxzd8+yN9rBgFNL8biQEMMSAUj045PhTNkqqSmVvUxqG6TeCfxgPpL
         6g+Q==
X-Gm-Message-State: ACrzQf3CXpdg3qS4vR0xNmWnq/V90TzrfvnMCQEinrZBOyrRIDKU2wvu
        7NlWZdYoByezyH+z/kqoqeevXuppDK/WS5TidaYmkHqeLfiW
X-Google-Smtp-Source: AMsMyM7PZX8XNoVmOsMUB4zWdDvfVHmxf5heips0o6pfeb/pk5VnKxrKYxlVA0hTE6CeIhPMImoiFa665BtAybSm9ylUDI5LaRsv
MIME-Version: 1.0
X-Received: by 2002:a05:6602:490:b0:678:d781:446d with SMTP id
 y16-20020a056602049000b00678d781446dmr8343778iov.115.1663630058719; Mon, 19
 Sep 2022 16:27:38 -0700 (PDT)
Date:   Mon, 19 Sep 2022 16:27:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b010bd05e9100e11@google.com>
Subject: [syzbot] memory leak in do_replace
From:   syzbot <syzbot+a24c5252f3e3ab733464@syzkaller.appspotmail.com>
To:     bridge@lists.linux-foundation.org, coreteam@netfilter.org,
        davem@davemloft.net, edumazet@google.com, fw@strlen.de,
        kadlec@netfilter.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pabeni@redhat.com,
        pablo@netfilter.org, razor@blackwall.org, roopa@nvidia.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3245cb65fd91 Merge tag 'devicetree-fixes-for-6.0-2' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a88ef7080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4afe4efcad47dde
dashboard link: https://syzkaller.appspot.com/bug?extid=a24c5252f3e3ab733464
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b0e87f080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1100f1d8880000

Downloadable assets:
disk image: https://storage.googleapis.com/2d6c9d59c55a/disk-3245cb65.raw.xz
vmlinux: https://storage.googleapis.com/0f52632026ad/vmlinux-3245cb65.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a24c5252f3e3ab733464@syzkaller.appspotmail.com

executing program
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffffc90000ded000 (size 4096):
  comm "syz-executor317", pid 3615, jiffies 4294946120 (age 22.550s)
  hex dump (first 32 bytes):
    90 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8153105f>] __vmalloc_node_range+0xb3f/0xbd0 mm/vmalloc.c:3224
    [<ffffffff81531239>] __vmalloc_node mm/vmalloc.c:3261 [inline]
    [<ffffffff81531239>] __vmalloc+0x49/0x50 mm/vmalloc.c:3275
    [<ffffffff83e28027>] do_replace+0x197/0x340 net/bridge/netfilter/ebtables.c:1131
    [<ffffffff83e2880c>] do_ebt_set_ctl+0x22c/0x310 net/bridge/netfilter/ebtables.c:2520
    [<ffffffff83a3fb68>] nf_setsockopt+0x68/0xa0 net/netfilter/nf_sockopt.c:101
    [<ffffffff83bb5d69>] ip_setsockopt+0x259/0x2040 net/ipv4/ip_sockglue.c:1444
    [<ffffffff83bcbe10>] tcp_setsockopt+0x70/0x1430 net/ipv4/tcp.c:3789
    [<ffffffff8425d1d8>] smc_setsockopt+0xd8/0x5c0 net/smc/af_smc.c:2941
    [<ffffffff8386dd2b>] __sys_setsockopt+0x1ab/0x380 net/socket.c:2252
    [<ffffffff8386df22>] __do_sys_setsockopt net/socket.c:2263 [inline]
    [<ffffffff8386df22>] __se_sys_setsockopt net/socket.c:2260 [inline]
    [<ffffffff8386df22>] __x64_sys_setsockopt+0x22/0x30 net/socket.c:2260
    [<ffffffff845eab35>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845eab35>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffffc90000df5000 (size 4096):
  comm "syz-executor317", pid 3615, jiffies 4294946120 (age 22.550s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8153105f>] __vmalloc_node_range+0xb3f/0xbd0 mm/vmalloc.c:3224
    [<ffffffff81531239>] __vmalloc_node mm/vmalloc.c:3261 [inline]
    [<ffffffff81531239>] __vmalloc+0x49/0x50 mm/vmalloc.c:3275
    [<ffffffff83e28071>] do_replace+0x1e1/0x340 net/bridge/netfilter/ebtables.c:1138
    [<ffffffff83e2880c>] do_ebt_set_ctl+0x22c/0x310 net/bridge/netfilter/ebtables.c:2520
    [<ffffffff83a3fb68>] nf_setsockopt+0x68/0xa0 net/netfilter/nf_sockopt.c:101
    [<ffffffff83bb5d69>] ip_setsockopt+0x259/0x2040 net/ipv4/ip_sockglue.c:1444
    [<ffffffff83bcbe10>] tcp_setsockopt+0x70/0x1430 net/ipv4/tcp.c:3789
    [<ffffffff8425d1d8>] smc_setsockopt+0xd8/0x5c0 net/smc/af_smc.c:2941
    [<ffffffff8386dd2b>] __sys_setsockopt+0x1ab/0x380 net/socket.c:2252
    [<ffffffff8386df22>] __do_sys_setsockopt net/socket.c:2263 [inline]
    [<ffffffff8386df22>] __se_sys_setsockopt net/socket.c:2260 [inline]
    [<ffffffff8386df22>] __x64_sys_setsockopt+0x22/0x30 net/socket.c:2260
    [<ffffffff845eab35>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845eab35>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
