Return-Path: <netfilter-devel+bounces-4815-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE799B7849
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2024 11:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28A8287A3E
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2024 10:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44FC19B3CB;
	Thu, 31 Oct 2024 10:01:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BF8199391;
	Thu, 31 Oct 2024 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368888; cv=none; b=hR2DzqvYE1qTK0WFd+4dtEY8jakxDZPmEeHg/3gkcXiH4N99C5TSaP9ilvqFnc5mj1BhraezY5YE79OTXdNeesJWRf0jF1wLtihT1ZZ2osd9Nky4byvT3HFMGByVUXKymJsvgSgVM3IVo1I0AqXWz0lRTPJ3qFmhwYpbGuzK3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368888; c=relaxed/simple;
	bh=Hfg8B0RXbZ6STkQ5uJVqvG/Ap2uEcGhV6WG6rrqJI0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOyiIacu309CUl8ew/YC76Xdv71iTB6gdbhFqJ9+r6PBBKCFRivpUXB1N7wd5rtCXT+1Jn1vO+3mOzuSJChN3OV+fxirY3FHIecrwIU95CrlVk6l2O74op+s1a8IHvu520YuC98Y0av1ufbtcypNkuqpkn9vAmXWN/2XaIegwZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 3/4] netfilter: nf_reject_ipv6: fix potential crash in nf_send_reset6()
Date: Thu, 31 Oct 2024 11:01:16 +0100
Message-Id: <20241031100117.152995-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241031100117.152995-1-pablo@netfilter.org>
References: <20241031100117.152995-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

I got a syzbot report without a repro [1] crashing in nf_send_reset6()

I think the issue is that dev->hard_header_len is zero, and we attempt
later to push an Ethernet header.

Use LL_MAX_HEADER, as other functions in net/ipv6/netfilter/nf_reject_ipv6.c.

[1]

skbuff: skb_under_panic: text:ffffffff89b1d008 len:74 put:14 head:ffff88803123aa00 data:ffff88803123a9f2 tail:0x3c end:0x140 dev:syz_tun
 kernel BUG at net/core/skbuff.c:206 !
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 7373 Comm: syz.1.568 Not tainted 6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
 RIP: 0010:skb_panic net/core/skbuff.c:206 [inline]
 RIP: 0010:skb_under_panic+0x14b/0x150 net/core/skbuff.c:216
Code: 0d 8d 48 c7 c6 60 a6 29 8e 48 8b 54 24 08 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 41 54 41 57 41 56 e8 ba 30 38 02 48 83 c4 20 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc900045269b0 EFLAGS: 00010282
RAX: 0000000000000088 RBX: dffffc0000000000 RCX: cd66dacdc5d8e800
RDX: 0000000000000000 RSI: 0000000000000200 RDI: 0000000000000000
RBP: ffff88802d39a3d0 R08: ffffffff8174afec R09: 1ffff920008a4ccc
R10: dffffc0000000000 R11: fffff520008a4ccd R12: 0000000000000140
R13: ffff88803123aa00 R14: ffff88803123a9f2 R15: 000000000000003c
FS:  00007fdbee5ff6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000005d322000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  skb_push+0xe5/0x100 net/core/skbuff.c:2636
  eth_header+0x38/0x1f0 net/ethernet/eth.c:83
  dev_hard_header include/linux/netdevice.h:3208 [inline]
  nf_send_reset6+0xce6/0x1270 net/ipv6/netfilter/nf_reject_ipv6.c:358
  nft_reject_inet_eval+0x3b9/0x690 net/netfilter/nft_reject_inet.c:48
  expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
  nft_do_chain+0x4ad/0x1da0 net/netfilter/nf_tables_core.c:288
  nft_do_chain_inet+0x418/0x6b0 net/netfilter/nft_chain_filter.c:161
  nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
  nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
  nf_hook include/linux/netfilter.h:269 [inline]
  NF_HOOK include/linux/netfilter.h:312 [inline]
  br_nf_pre_routing_ipv6+0x63e/0x770 net/bridge/br_netfilter_ipv6.c:184
  nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
  nf_hook_bridge_pre net/bridge/br_input.c:277 [inline]
  br_handle_frame+0x9fd/0x1530 net/bridge/br_input.c:424
  __netif_receive_skb_core+0x13e8/0x4570 net/core/dev.c:5562
  __netif_receive_skb_one_core net/core/dev.c:5666 [inline]
  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5781
  netif_receive_skb_internal net/core/dev.c:5867 [inline]
  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5926
  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
  tun_get_user+0x3056/0x47e0 drivers/net/tun.c:2007
  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
  new_sync_write fs/read_write.c:590 [inline]
  vfs_write+0xa6d/0xc90 fs/read_write.c:683
  ksys_write+0x183/0x2b0 fs/read_write.c:736
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdbeeb7d1ff
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 c9 8d 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 1c 8e 02 00 48
RSP: 002b:00007fdbee5ff000 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fdbeed36058 RCX: 00007fdbeeb7d1ff
RDX: 000000000000008e RSI: 0000000020000040 RDI: 00000000000000c8
RBP: 00007fdbeebf12be R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000008e R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fdbeed36058 R15: 00007ffc38de06e8
 </TASK>

Fixes: c8d7b98bec43 ("netfilter: move nf_send_resetX() code to nf_reject_ipvX modules")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/ipv6/netfilter/nf_reject_ipv6.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 7db0437140bf..9ae2b2725bf9 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -268,12 +268,12 @@ static int nf_reject6_fill_skb_dst(struct sk_buff *skb_in)
 void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		    int hook)
 {
-	struct sk_buff *nskb;
-	struct tcphdr _otcph;
-	const struct tcphdr *otcph;
-	unsigned int otcplen, hh_len;
 	const struct ipv6hdr *oip6h = ipv6_hdr(oldskb);
 	struct dst_entry *dst = NULL;
+	const struct tcphdr *otcph;
+	struct sk_buff *nskb;
+	struct tcphdr _otcph;
+	unsigned int otcplen;
 	struct flowi6 fl6;
 
 	if ((!(ipv6_addr_type(&oip6h->saddr) & IPV6_ADDR_UNICAST)) ||
@@ -312,9 +312,8 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	if (IS_ERR(dst))
 		return;
 
-	hh_len = (dst->dev->hard_header_len + 15)&~15;
-	nskb = alloc_skb(hh_len + 15 + dst->header_len + sizeof(struct ipv6hdr)
-			 + sizeof(struct tcphdr) + dst->trailer_len,
+	nskb = alloc_skb(LL_MAX_HEADER + sizeof(struct ipv6hdr) +
+			 sizeof(struct tcphdr) + dst->trailer_len,
 			 GFP_ATOMIC);
 
 	if (!nskb) {
@@ -327,7 +326,7 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 
 	nskb->mark = fl6.flowi6_mark;
 
-	skb_reserve(nskb, hh_len + dst->header_len);
+	skb_reserve(nskb, LL_MAX_HEADER);
 	nf_reject_ip6hdr_put(nskb, oldskb, IPPROTO_TCP, ip6_dst_hoplimit(dst));
 	nf_reject_ip6_tcphdr_put(nskb, oldskb, otcph, otcplen);
 
-- 
2.30.2


