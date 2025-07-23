Return-Path: <netfilter-devel+bounces-8000-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99380B0E690
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Jul 2025 00:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704D21C8787F
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Jul 2025 22:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E1E28727A;
	Tue, 22 Jul 2025 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DpUEnoGh"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5274C27E1D0
	for <netfilter-devel@vger.kernel.org>; Tue, 22 Jul 2025 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224045; cv=none; b=gVoIuc9ekYwIgsocpAQuJW8NAsenVemPbA22QX12KOn0KqiRKnE0kD0cp+4CZu1bWQdaLVTaLSRyPKC4k87x2gFfh+FQszCIg+gj9Qhv7wfIvuW4P9a8+qnADtsUjPb8+1/WaAJevumaOZ9auU1zMG3453MVcCVvdJS5FySP23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224045; c=relaxed/simple;
	bh=+42H/9YBeHAzHaoQNt10QggjJXigV7J/rguSjxxDZz4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nNkYPVw7i+brDm5YDP/6WojXrQ2FvrH2jldUcyz8NtskL1Dg8hORz2fUVIV5xd40zJT94ABG0s4rDoJ3hr0/Vg52dJyG1Uf4Rerqbo+aseJ/rHFB7xaru2nZ2KxQm6Z47+3uIq0TyDAQv56sC/H/iTWUURaPsd064s7XrbFIGug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DpUEnoGh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2382607509fso40787715ad.3
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Jul 2025 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753224044; x=1753828844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wKtcXMxj2OGpCwkPzjUbbWqW4CzJw89SXcZLChO/bm8=;
        b=DpUEnoGh19srQpsjZhckH4lz+AU4VtYQSxZWBaQ60fXG+D0Ri4vmmKGEM+3f9ut1fn
         qcC4gyXR4JnoV2XM+R27K2saP8AR9HagXtD19zEtlhdBzNCvD9M2W5QXImwBWq9RCE8E
         zObYJ380WfClBgmpBZGDT32cxmBAO5SRkoo6PqSzaYYstOOeSQICrHfxyWhvJ8P2J6d4
         EKwo1vQe6Uwn0HrnbBOp5A3nxPkkuUhI30lFUbRU0O/+6A//9M1HfQFFuC0HBgT0sG3N
         t+fAgc48oenuE+GFE6hM/nHdMqgpH5pk7bC5ZpP4FVn/fNB/kpAFiSxBwBVIh+ObTp3i
         9sHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753224044; x=1753828844;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKtcXMxj2OGpCwkPzjUbbWqW4CzJw89SXcZLChO/bm8=;
        b=t4a0oAep/nnIpybWkjIki821N4oFzAT6ljar8OUctb7rtF+gRtgL2j9PCIZbzlzTqQ
         O3sO63ghHlSfABO8zsGHMz061HBZ1nzVy5QqFmNtdVajMXwSDaalbDkDQ50ibZ2G1ycK
         jULLpJ79MGbb/HX4cZ/nnid6UMwDX733Z7hENHJbYtcxVUac5GCneK8LvAEhvnSao963
         KiDBTYTYMsS5f7u3q9WRUWHdVeop/lcAeWkZ7AHpkYdZ1c315JrVgB/M0ilIcOI186aM
         ekVJ2ctYmw8sLlaM77H90TuP7+lwVBq8Q5/erlobhRGS4vs79B/iRwZZtYoQ106hBv81
         AiLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/K64tqHlnI043tzX5T5G0YeP89DsKB9CE6m9jmGsLWTlQSAGjl5ONlL1Gb6rjaPB/ZR2EerKOeviter3vkxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuGlwmAomeav10CuGhPjaSrykrYO9r3rpnzcs0ZDPmoBogrygv
	Ek3VlVAVD9VP/fzADKd28nXQ3PVWitW5ruuvOItvjekV+SSavyN0AUzBMMxYegXWhET4MNWKg9G
	H770jIQ==
X-Google-Smtp-Source: AGHT+IEsypI3rYx6n4459N9W8IgNPRYtXYo2OzxtHcUkEBKajYj3FwY/w6yphT5g1epzz0g3C/aE4kYcOtA=
X-Received: from plbjj13.prod.google.com ([2002:a17:903:48d:b0:234:2261:8333])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1245:b0:234:a139:11fb
 with SMTP id d9443c01a7336-23f981bb968mr8242035ad.27.1753224043640; Tue, 22
 Jul 2025 15:40:43 -0700 (PDT)
Date: Tue, 22 Jul 2025 22:40:37 +0000
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722224041.112292-1-kuniyu@google.com>
Subject: [PATCH v2 bpf] bpf: Disable migration in nf_hook_run_bpf().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported that the netfilter bpf prog can be called without
migration disabled in xmit path.

Then the assertion in __bpf_prog_run() fails, triggering the splat
below. [0]

Let's use bpf_prog_run_pin_on_cpu() in nf_hook_run_bpf().

[0]:
BUG: assuming non migratable context at ./include/linux/filter.h:703
in_atomic(): 0, irqs_disabled(): 0, migration_disabled() 0 pid: 5829, name: sshd-session
3 locks held by sshd-session/5829:
 #0: ffff88807b4e4218 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1667 [inline]
 #0: ffff88807b4e4218 (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_sendmsg+0x20/0x50 net/ipv4/tcp.c:1395
 #1: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: __ip_queue_xmit+0x69/0x26c0 net/ipv4/ip_output.c:470
 #2: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #2: ffffffff8e5c4e00 (rcu_read_lock){....}-{1:3}, at: nf_hook+0xb2/0x680 include/linux/netfilter.h:241
CPU: 0 UID: 0 PID: 5829 Comm: sshd-session Not tainted 6.16.0-rc6-syzkaller-00002-g155a3c003e55 #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 __cant_migrate kernel/sched/core.c:8860 [inline]
 __cant_migrate+0x1c7/0x250 kernel/sched/core.c:8834
 __bpf_prog_run include/linux/filter.h:703 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 nf_hook_run_bpf+0x83/0x1e0 net/netfilter/nf_bpf_link.c:20
 nf_hook_entry_hookfn include/linux/netfilter.h:157 [inline]
 nf_hook_slow+0xbb/0x200 net/netfilter/core.c:623
 nf_hook+0x370/0x680 include/linux/netfilter.h:272
 NF_HOOK_COND include/linux/netfilter.h:305 [inline]
 ip_output+0x1bc/0x2a0 net/ipv4/ip_output.c:433
 dst_output include/net/dst.h:459 [inline]
 ip_local_out net/ipv4/ip_output.c:129 [inline]
 __ip_queue_xmit+0x1d7d/0x26c0 net/ipv4/ip_output.c:527
 __tcp_transmit_skb+0x2686/0x3e90 net/ipv4/tcp_output.c:1479
 tcp_transmit_skb net/ipv4/tcp_output.c:1497 [inline]
 tcp_write_xmit+0x1274/0x84e0 net/ipv4/tcp_output.c:2838
 __tcp_push_pending_frames+0xaf/0x390 net/ipv4/tcp_output.c:3021
 tcp_push+0x225/0x700 net/ipv4/tcp.c:759
 tcp_sendmsg_locked+0x1870/0x42b0 net/ipv4/tcp.c:1359
 tcp_sendmsg+0x2e/0x50 net/ipv4/tcp.c:1396
 inet_sendmsg+0xb9/0x140 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 sock_write_iter+0x4aa/0x5b0 net/socket.c:1131
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x6c7/0x1150 fs/read_write.c:686
 ksys_write+0x1f8/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe7d365d407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP:

Fixes: fd9c663b9ad67 ("bpf: minimal support for programs hooked into netfilter framework")
Reported-by: syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6879466d.a00a0220.3af5df.0022.GAE@google.com/
Tested-by: syzbot+40f772d37250b6d10efc@syzkaller.appspotmail.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Use bpf_prog_run_pin_on_cpu()
  * Correct Fixes: tag

v1: https://lore.kernel.org/bpf/20250717185837.1073456-1-kuniyu@google.com/
---
 net/netfilter/nf_bpf_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 06b0848447003..25bbac8986c22 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -17,7 +17,7 @@ static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *skb,
 		.skb = skb,
 	};
 
-	return bpf_prog_run(prog, &ctx);
+	return bpf_prog_run_pin_on_cpu(prog, &ctx);
 }
 
 struct bpf_nf_link {
-- 
2.50.0.727.gbf7dc18ff4-goog


