Return-Path: <netfilter-devel+bounces-684-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFDD830A4B
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jan 2024 17:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DE61C21C7E
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jan 2024 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6CF23752;
	Wed, 17 Jan 2024 16:00:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640BC2230A;
	Wed, 17 Jan 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705507253; cv=none; b=J2buaU0YO2wdpbzEGIV6oBJl99T9FsvG4U+AevsN9fP90Ct97Va85aMrEX5dwrTpGb/6jjKJxJVfFt/yF4n1qZ6OTK4+4qAhJfHcAaPrjsFA1bOzecojLqa7d5Jy21ovjjeCSVYZad5UMMK4XTGxqJSz0sFHMmMamk0uqMzdwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705507253; c=relaxed/simple;
	bh=i+g1c9MzBrdk6gCX13L1vqVGvEmrX/fbeR/nfR4gh10=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding; b=egEhKwdGluUWHNlJZYrALR2Qn/YUI/1D240z4sUKVuhOKe2xm9rw2xbhps2ZyTT1mG7W9tKd/SSqCFwUF4mwqwiZnEfVquw+7s7TNlxvDX8vWjQY36sW8INxOcKDTvNwGd7q8iPJgcnnUepgXhLGmJBew4JnWuA0RS+Yccu+smQ=
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
Subject: [PATCH net 13/14] ipvs: avoid stat macros calls from preemptible context
Date: Wed, 17 Jan 2024 17:00:29 +0100
Message-Id: <20240117160030.140264-14-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240117160030.140264-1-pablo@netfilter.org>
References: <20240117160030.140264-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fedor Pchelkin <pchelkin@ispras.ru>

Inside decrement_ttl() upon discovering that the packet ttl has exceeded,
__IP_INC_STATS and __IP6_INC_STATS macros can be called from preemptible
context having the following backtrace:

check_preemption_disabled: 48 callbacks suppressed
BUG: using __this_cpu_add() in preemptible [00000000] code: curl/1177
caller is decrement_ttl+0x217/0x830
CPU: 5 PID: 1177 Comm: curl Not tainted 6.7.0+ #34
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xbd/0xe0
 check_preemption_disabled+0xd1/0xe0
 decrement_ttl+0x217/0x830
 __ip_vs_get_out_rt+0x4e0/0x1ef0
 ip_vs_nat_xmit+0x205/0xcd0
 ip_vs_in_hook+0x9b1/0x26a0
 nf_hook_slow+0xc2/0x210
 nf_hook+0x1fb/0x770
 __ip_local_out+0x33b/0x640
 ip_local_out+0x2a/0x490
 __ip_queue_xmit+0x990/0x1d10
 __tcp_transmit_skb+0x288b/0x3d10
 tcp_connect+0x3466/0x5180
 tcp_v4_connect+0x1535/0x1bb0
 __inet_stream_connect+0x40d/0x1040
 inet_stream_connect+0x57/0xa0
 __sys_connect_file+0x162/0x1a0
 __sys_connect+0x137/0x160
 __x64_sys_connect+0x72/0xb0
 do_syscall_64+0x6f/0x140
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x7fe6dbbc34e0

Use the corresponding preemption-aware variants: IP_INC_STATS and
IP6_INC_STATS.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 8d8e20e2d7bb ("ipvs: Decrement ttl")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Julian Anastasov <ja@ssi.bg>
Acked-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/ipvs/ip_vs_xmit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 9193e109e6b3..65e0259178da 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -271,7 +271,7 @@ static inline bool decrement_ttl(struct netns_ipvs *ipvs,
 			skb->dev = dst->dev;
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
 				    ICMPV6_EXC_HOPLIMIT, 0);
-			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
+			IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 
 			return false;
 		}
@@ -286,7 +286,7 @@ static inline bool decrement_ttl(struct netns_ipvs *ipvs,
 	{
 		if (ip_hdr(skb)->ttl <= 1) {
 			/* Tell the sender its packet died... */
-			__IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
+			IP_INC_STATS(net, IPSTATS_MIB_INHDRERRORS);
 			icmp_send(skb, ICMP_TIME_EXCEEDED, ICMP_EXC_TTL, 0);
 			return false;
 		}
-- 
2.30.2


