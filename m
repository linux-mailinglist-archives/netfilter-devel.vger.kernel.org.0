Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3343E4C5DF3
	for <lists+netfilter-devel@lfdr.de>; Sun, 27 Feb 2022 19:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiB0SCY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 27 Feb 2022 13:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiB0SCX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:02:23 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293F8546A4;
        Sun, 27 Feb 2022 10:01:46 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id u16so9038801pfg.12;
        Sun, 27 Feb 2022 10:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ltE+LaNI7DC6z4ymuZHjTW0wVEEUkY05Btu3tjIROyc=;
        b=X927rzdB3kWf7ST9YaoO6Hc49QkCPeIvcBOQcEY8EQyE15UA6eW3oH4CTieTVo+qXC
         psHsNsTLkTBGbFGm64HLfrHfiR681F/v0AF0OrRrusstwTxVYlcCjsy3PBZ4SFHzk9VI
         9xaOjpvqUtFguJCXop34+rdNU/xZg9PIyPNCIEpvzglN4vYfC68d5qMcybvyB9V2UR8H
         RqwKpmOLahfTjR4mIRQ8pHsnoyfGUBRsa2XBWPRO3i9zl+UbrRhUY56kzLYJ920eUR8/
         iloutUrAIZm3OsVuQMAm75TfujjnxVN5mOVCPIt62uMDBm40TK89ZbS0zf+cHL6+in8w
         6/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ltE+LaNI7DC6z4ymuZHjTW0wVEEUkY05Btu3tjIROyc=;
        b=O6OQh4qS6aqBftm9Awjsr4TPnQbK3aq/L7Junz1V7I/pt1lGeAwB9hwT//PA2+P45S
         GgDZIGd/ui7x9zxv347HRQHSrcKOrF7aAAGkwv1WaEg6u3g4W9y7pED841danLYBGrn2
         yWp6pJyFJrdpWnE0ttoLD1QAxuOAGqL2SWSvRBSGEoeJdVFw3UBsxP0j+Uw19W1KOemM
         4BKPAxnl4ncvOaNvAgq0Etn2MqsP7OeuBchzcZAmKYv+kcBXaKeqrSMPzEM05AA0LZ33
         gMvU0YdO6NQXc0tSiYyvglLfUzFm/Y+nJdZYJUGt4DZs72aTajI2cQ1V0Fn5HqKrbJgG
         S4Hg==
X-Gm-Message-State: AOAM531B/xnQd5xYT0b1SIbfh+fVNcU2WoG6vfCK7cfaXjXOrkVILHxr
        hMIlpS4YpvOFD20UOszZLGQ=
X-Google-Smtp-Source: ABdhPJyFXz5d9iehxgv14iNXABKHzQ1wdKFj4UCh205YVgefKQSj7RW/+mHa9Y6hh0IMzE5OmUHMNw==
X-Received: by 2002:a62:ee12:0:b0:4e1:2ec1:cba2 with SMTP id e18-20020a62ee12000000b004e12ec1cba2mr17637889pfi.71.1645984905511;
        Sun, 27 Feb 2022 10:01:45 -0800 (PST)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:1b7d:b94e:b77d:6960])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm10380778pfu.202.2022.02.27.10.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 10:01:44 -0800 (PST)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>
Subject: [PATCH nf] netfilter: fix use-after-free in __nf_register_net_hook()
Date:   Sun, 27 Feb 2022 10:01:41 -0800
Message-Id: <20220227180141.931857-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

We must not dereference @new_hooks after nf_hook_mutex has been released,
because other threads might have freed our allocated hooks already.

BUG: KASAN: use-after-free in nf_hook_entries_get_hook_ops include/linux/netfilter.h:130 [inline]
BUG: KASAN: use-after-free in hooks_validate net/netfilter/core.c:171 [inline]
BUG: KASAN: use-after-free in __nf_register_net_hook+0x77a/0x820 net/netfilter/core.c:438
Read of size 2 at addr ffff88801c1a8000 by task syz-executor237/4430

CPU: 1 PID: 4430 Comm: syz-executor237 Not tainted 5.17.0-rc5-syzkaller-00306-g2293be58d6a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x336 mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 nf_hook_entries_get_hook_ops include/linux/netfilter.h:130 [inline]
 hooks_validate net/netfilter/core.c:171 [inline]
 __nf_register_net_hook+0x77a/0x820 net/netfilter/core.c:438
 nf_register_net_hook+0x114/0x170 net/netfilter/core.c:571
 nf_register_net_hooks+0x59/0xc0 net/netfilter/core.c:587
 nf_synproxy_ipv6_init+0x85/0xe0 net/netfilter/nf_synproxy_core.c:1218
 synproxy_tg6_check+0x30d/0x560 net/ipv6/netfilter/ip6t_SYNPROXY.c:81
 xt_check_target+0x26c/0x9e0 net/netfilter/x_tables.c:1038
 check_target net/ipv6/netfilter/ip6_tables.c:530 [inline]
 find_check_entry.constprop.0+0x7f1/0x9e0 net/ipv6/netfilter/ip6_tables.c:573
 translate_table+0xc8b/0x1750 net/ipv6/netfilter/ip6_tables.c:735
 do_replace net/ipv6/netfilter/ip6_tables.c:1153 [inline]
 do_ip6t_set_ctl+0x56e/0xb90 net/ipv6/netfilter/ip6_tables.c:1639
 nf_setsockopt+0x83/0xe0 net/netfilter/nf_sockopt.c:101
 ipv6_setsockopt+0x122/0x180 net/ipv6/ipv6_sockglue.c:1024
 rawv6_setsockopt+0xd3/0x6a0 net/ipv6/raw.c:1084
 __sys_setsockopt+0x2db/0x610 net/socket.c:2180
 __do_sys_setsockopt net/socket.c:2191 [inline]
 __se_sys_setsockopt net/socket.c:2188 [inline]
 __x64_sys_setsockopt+0xba/0x150 net/socket.c:2188
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f65a1ace7d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f65a1a7f308 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f65a1ace7d9
RDX: 0000000000000040 RSI: 0000000000000029 RDI: 0000000000000003
RBP: 00007f65a1b574c8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000020000000 R11: 0000000000000246 R12: 00007f65a1b55130
R13: 00007f65a1b574c0 R14: 00007f65a1b24090 R15: 0000000000022000
 </TASK>

The buggy address belongs to the page:
page:ffffea0000706a00 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1c1a8
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001c1b108 ffffea000046dd08 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52dc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_ZERO), pid 4430, ts 1061781545818, free_ts 1061791488993
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4165
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5389
 __alloc_pages_node include/linux/gfp.h:572 [inline]
 alloc_pages_node include/linux/gfp.h:595 [inline]
 kmalloc_large_node+0x62/0x130 mm/slub.c:4438
 __kmalloc_node+0x35a/0x4a0 mm/slub.c:4454
 kmalloc_node include/linux/slab.h:604 [inline]
 kvmalloc_node+0x97/0x100 mm/util.c:580
 kvmalloc include/linux/slab.h:731 [inline]
 kvzalloc include/linux/slab.h:739 [inline]
 allocate_hook_entries_size net/netfilter/core.c:61 [inline]
 nf_hook_entries_grow+0x140/0x780 net/netfilter/core.c:128
 __nf_register_net_hook+0x144/0x820 net/netfilter/core.c:429
 nf_register_net_hook+0x114/0x170 net/netfilter/core.c:571
 nf_register_net_hooks+0x59/0xc0 net/netfilter/core.c:587
 nf_synproxy_ipv6_init+0x85/0xe0 net/netfilter/nf_synproxy_core.c:1218
 synproxy_tg6_check+0x30d/0x560 net/ipv6/netfilter/ip6t_SYNPROXY.c:81
 xt_check_target+0x26c/0x9e0 net/netfilter/x_tables.c:1038
 check_target net/ipv6/netfilter/ip6_tables.c:530 [inline]
 find_check_entry.constprop.0+0x7f1/0x9e0 net/ipv6/netfilter/ip6_tables.c:573
 translate_table+0xc8b/0x1750 net/ipv6/netfilter/ip6_tables.c:735
 do_replace net/ipv6/netfilter/ip6_tables.c:1153 [inline]
 do_ip6t_set_ctl+0x56e/0xb90 net/ipv6/netfilter/ip6_tables.c:1639
 nf_setsockopt+0x83/0xe0 net/netfilter/nf_sockopt.c:101
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1352 [inline]
 free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3325 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3404
 kvfree+0x42/0x50 mm/util.c:613
 rcu_do_batch kernel/rcu/tree.c:2527 [inline]
 rcu_core+0x7b1/0x1820 kernel/rcu/tree.c:2778
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558

Memory state around the buggy address:
 ffff88801c1a7f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88801c1a7f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88801c1a8000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88801c1a8080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88801c1a8100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Fixes: 2420b79f8c18 ("netfilter: debug: check for sorted array")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
---
 net/netfilter/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 354cb472f386797d77667b02e0790072b333f40e..8a77a3fd69bcaf7ced4a77e8bfee04905e56ef74 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -428,14 +428,15 @@ static int __nf_register_net_hook(struct net *net, int pf,
 	p = nf_entry_dereference(*pp);
 	new_hooks = nf_hook_entries_grow(p, reg);
 
-	if (!IS_ERR(new_hooks))
+	if (!IS_ERR(new_hooks)) {
+		hooks_validate(new_hooks);
 		rcu_assign_pointer(*pp, new_hooks);
+	}
 
 	mutex_unlock(&nf_hook_mutex);
 	if (IS_ERR(new_hooks))
 		return PTR_ERR(new_hooks);
 
-	hooks_validate(new_hooks);
 #ifdef CONFIG_NETFILTER_INGRESS
 	if (nf_ingress_hook(reg, pf))
 		net_inc_ingress_queue();
-- 
2.35.1.574.g5d30c73bfb-goog

