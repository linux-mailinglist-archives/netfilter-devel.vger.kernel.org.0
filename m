Return-Path: <netfilter-devel+bounces-7001-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F65AA7C0B
	for <lists+netfilter-devel@lfdr.de>; Sat,  3 May 2025 00:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94B6189B6BE
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 May 2025 22:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378971F9413;
	Fri,  2 May 2025 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="R4zxtSeA"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3620F09B;
	Fri,  2 May 2025 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746223709; cv=none; b=jGwmusOdpTOSU5jHIf0QYGE8apmJBmHMSOrgwzeIV5OXjUqSENtKhszOiirpxOMt32bRLN1NYhKMzhTZZkh/cg7iJXoxlymRzPnW1UtEXvdDeBCmPmARXTA9XNfd7+TIfKp0qK+PhSpHEE535FY2BIbhFNXrvcGigZBrQEHZ0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746223709; c=relaxed/simple;
	bh=sB5/xC6PXig5ggt0SSNdEOC7kdxxldWcomBoY9cq7mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJpX0kg6BgzMEdCK1ulWqavWbwtxFaQRySw5rt5Fa3m71YMj3nsH8sObmwSuOpdJm+N1QIl2yXt7xzlYIqD7bUtW0KfjBOCSNsx5IM/7VzB2ctIoThkkXa11LTRz6zJkWPRvEF7xB5pZpOJmoWXyKQjHbobL4PAqntVWmrIhvJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=R4zxtSeA; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 5C75120196;
	Sat,  3 May 2025 01:02:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-transfer-encoding:date:from:from:message-id
	:mime-version:reply-to:subject:subject:to:to; s=ssi; bh=780m3Mkc
	t4pSYYLLNlh/JcYOiMVHwXKQ2vN2AhU9TPM=; b=R4zxtSeAX90KMkTwTeCFemBb
	XHZ1YH68h9tZ3kpnW2/96k/JFsAoEliDLbnqaDK/X3F9+qXbUxqijQuwh62HHqH+
	thz2YEwu59I01jKB4qBsmRuz/HVkx7ePByejRwsIiRSntAQTDUS8aZZ9KFPkMGd+
	UvgMhvYuSHzm6YueQkLLFxn9VmHw2AqLJsI9UFgJVgLDwI2XOcys9akhS0MYypyK
	m3ZVATuZEAKZz9orkBP2IkJRDmPBcgA46+7UcWxSQq/Gm8PFvLTPYyQ6fidSKIMS
	MA4jXJoY0p5JSdPLhi9XC73BVU78upYQ4LRmDwcevFmS+dBezN2SIPLZ07rbVrPS
	ni3s4slX0nf/KaQUIaF3HUO4e2pQ/TPa73W/yVsQKP/QMuEx6/R85YNeN94OhhVp
	WQeRbttoschvIPKBaEkb4NC9EeMliWfnuW8343R01nB5cMgKDVL6Vq165qMGIBt0
	dozrKCLIj00ZOQfQyqqd5/GQ2QURHtLEuSpWiJdQFAMoedQX1To2Mxl2aOOkLlPf
	3wmlELK3+XOt020aeJkDcuRMPqq230+/6//chmJNWppbrP8MO4bbBK/0h7Phi+tX
	bDuh0qm9SbCiqoSTwmVePrXhV0KY2kbSwf7lqNSQGFKHUW6w+MdvXfaHdhg1k56l
	aQQv8GnHcuafU7fXt+Q=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Sat,  3 May 2025 01:02:29 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id C5FF361BC1;
	Sat,  3 May 2025 01:02:28 +0300 (EEST)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.1/8.17.1) with ESMTP id 542M2R8C068287;
	Sat, 3 May 2025 01:02:27 +0300
Received: (from root@localhost)
	by ja.home.ssi.bg (8.18.1/8.18.1/Submit) id 542M2LMb068281;
	Sat, 3 May 2025 01:02:21 +0300
From: Julian Anastasov <ja@ssi.bg>
To: Simon Horman <horms@verge.net.au>
Cc: lvs-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: [PATCH nf] ipvs: fix uninit-value for saddr in do_output_route4
Date: Sat,  3 May 2025 01:01:18 +0300
Message-ID: <20250502220118.68234-1-ja@ssi.bg>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports for uninit-value for the saddr argument [1].
commit 4754957f04f5 ("ipvs: do not use random local source address for
tunnels") already implies that the input value of saddr
should be ignored but the code is still reading it which can prevent
to connect the route. Fix it by changing the argument to ret_saddr.

[1]
BUG: KMSAN: uninit-value in do_output_route4+0x42c/0x4d0 net/netfilter/ipvs/ip_vs_xmit.c:147
 do_output_route4+0x42c/0x4d0 net/netfilter/ipvs/ip_vs_xmit.c:147
 __ip_vs_get_out_rt+0x403/0x21d0 net/netfilter/ipvs/ip_vs_xmit.c:330
 ip_vs_tunnel_xmit+0x205/0x2380 net/netfilter/ipvs/ip_vs_xmit.c:1136
 ip_vs_in_hook+0x1aa5/0x35b0 net/netfilter/ipvs/ip_vs_core.c:2063
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xf7/0x400 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 __ip_local_out+0x758/0x7e0 net/ipv4/ip_output.c:118
 ip_local_out net/ipv4/ip_output.c:127 [inline]
 ip_send_skb+0x6a/0x3c0 net/ipv4/ip_output.c:1501
 udp_send_skb+0xfda/0x1b70 net/ipv4/udp.c:1195
 udp_sendmsg+0x2fe3/0x33c0 net/ipv4/udp.c:1483
 inet_sendmsg+0x1fc/0x280 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x267/0x380 net/socket.c:727
 ____sys_sendmsg+0x91b/0xda0 net/socket.c:2566
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2620
 __sys_sendmmsg+0x41d/0x880 net/socket.c:2702
 __compat_sys_sendmmsg net/compat.c:360 [inline]
 __do_compat_sys_sendmmsg net/compat.c:367 [inline]
 __se_compat_sys_sendmmsg net/compat.c:364 [inline]
 __ia32_compat_sys_sendmmsg+0xc8/0x140 net/compat.c:364
 ia32_sys_call+0x3ffa/0x41f0 arch/x86/include/generated/asm/syscalls_32.h:346
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4167 [inline]
 slab_alloc_node mm/slub.c:4210 [inline]
 __kmalloc_cache_noprof+0x8fa/0xe00 mm/slub.c:4367
 kmalloc_noprof include/linux/slab.h:905 [inline]
 ip_vs_dest_dst_alloc net/netfilter/ipvs/ip_vs_xmit.c:61 [inline]
 __ip_vs_get_out_rt+0x35d/0x21d0 net/netfilter/ipvs/ip_vs_xmit.c:323
 ip_vs_tunnel_xmit+0x205/0x2380 net/netfilter/ipvs/ip_vs_xmit.c:1136
 ip_vs_in_hook+0x1aa5/0x35b0 net/netfilter/ipvs/ip_vs_core.c:2063
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xf7/0x400 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 __ip_local_out+0x758/0x7e0 net/ipv4/ip_output.c:118
 ip_local_out net/ipv4/ip_output.c:127 [inline]
 ip_send_skb+0x6a/0x3c0 net/ipv4/ip_output.c:1501
 udp_send_skb+0xfda/0x1b70 net/ipv4/udp.c:1195
 udp_sendmsg+0x2fe3/0x33c0 net/ipv4/udp.c:1483
 inet_sendmsg+0x1fc/0x280 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x267/0x380 net/socket.c:727
 ____sys_sendmsg+0x91b/0xda0 net/socket.c:2566
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2620
 __sys_sendmmsg+0x41d/0x880 net/socket.c:2702
 __compat_sys_sendmmsg net/compat.c:360 [inline]
 __do_compat_sys_sendmmsg net/compat.c:367 [inline]
 __se_compat_sys_sendmmsg net/compat.c:364 [inline]
 __ia32_compat_sys_sendmmsg+0xc8/0x140 net/compat.c:364
 ia32_sys_call+0x3ffa/0x41f0 arch/x86/include/generated/asm/syscalls_32.h:346
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 0 UID: 0 PID: 22408 Comm: syz.4.5165 Not tainted 6.15.0-rc3-syzkaller-00019-gbc3372351d0c #0 PREEMPT(undef)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025

Reported-by: syzbot+04b9a82855c8aed20860@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68138dfa.050a0220.14dd7d.0017.GAE@google.com/
Fixes: 4754957f04f5 ("ipvs: do not use random local source address for tunnels")
Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 net/netfilter/ipvs/ip_vs_xmit.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 3313bceb6cc9..014f07740369 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -119,13 +119,12 @@ __mtu_check_toobig_v6(const struct sk_buff *skb, u32 mtu)
 	return false;
 }
 
-/* Get route to daddr, update *saddr, optionally bind route to saddr */
+/* Get route to daddr, optionally bind route to saddr */
 static struct rtable *do_output_route4(struct net *net, __be32 daddr,
-				       int rt_mode, __be32 *saddr)
+				       int rt_mode, __be32 *ret_saddr)
 {
 	struct flowi4 fl4;
 	struct rtable *rt;
-	bool loop = false;
 
 	memset(&fl4, 0, sizeof(fl4));
 	fl4.daddr = daddr;
@@ -135,23 +134,17 @@ static struct rtable *do_output_route4(struct net *net, __be32 daddr,
 retry:
 	rt = ip_route_output_key(net, &fl4);
 	if (IS_ERR(rt)) {
-		/* Invalid saddr ? */
-		if (PTR_ERR(rt) == -EINVAL && *saddr &&
-		    rt_mode & IP_VS_RT_MODE_CONNECT && !loop) {
-			*saddr = 0;
-			flowi4_update_output(&fl4, 0, daddr, 0);
-			goto retry;
-		}
 		IP_VS_DBG_RL("ip_route_output error, dest: %pI4\n", &daddr);
 		return NULL;
-	} else if (!*saddr && rt_mode & IP_VS_RT_MODE_CONNECT && fl4.saddr) {
+	}
+	if (rt_mode & IP_VS_RT_MODE_CONNECT && fl4.saddr) {
 		ip_rt_put(rt);
-		*saddr = fl4.saddr;
 		flowi4_update_output(&fl4, 0, daddr, fl4.saddr);
-		loop = true;
+		rt_mode = 0;
 		goto retry;
 	}
-	*saddr = fl4.saddr;
+	if (ret_saddr)
+		*ret_saddr = fl4.saddr;
 	return rt;
 }
 
@@ -344,19 +337,15 @@ __ip_vs_get_out_rt(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 		if (ret_saddr)
 			*ret_saddr = dest_dst->dst_saddr.ip;
 	} else {
-		__be32 saddr = htonl(INADDR_ANY);
-
 		noref = 0;
 
 		/* For such unconfigured boxes avoid many route lookups
 		 * for performance reasons because we do not remember saddr
 		 */
 		rt_mode &= ~IP_VS_RT_MODE_CONNECT;
-		rt = do_output_route4(net, daddr, rt_mode, &saddr);
+		rt = do_output_route4(net, daddr, rt_mode, ret_saddr);
 		if (!rt)
 			goto err_unreach;
-		if (ret_saddr)
-			*ret_saddr = saddr;
 	}
 
 	local = (rt->rt_flags & RTCF_LOCAL) ? 1 : 0;
-- 
2.49.0



