Return-Path: <netfilter-devel+bounces-1079-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6985985ED9A
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Feb 2024 01:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A9ECB23020
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Feb 2024 00:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DCFB662;
	Thu, 22 Feb 2024 00:08:54 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2B71854;
	Thu, 22 Feb 2024 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560534; cv=none; b=Pdfn8ybTus1vCPzcx7DK6yMlbHUhObFgBZBrEguIaOSVyj1BFpM7MfQSgP9tGlwp7l/ujhU+55ongECEN0/aEBNZNDB2LpFT3AdD6P9FErG05EIWKUcJR/lI4LIqWrn5PzbnZ8rlj5MPTsjBxeCmL3no8QSW8j9c17AxHwzu2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560534; c=relaxed/simple;
	bh=67o+Olb7r4rb0pPOqWTqglQuDVu3a9JoHfjJzKIGCXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TG+jHSY4RZHs2j8t0hlarMSuW+OS0Mwmr30gjeEcR2C7wBrmcjTIusYHEbLXnshJC++bRIP7ZeYjXWnaqkM03CqUkUqs45iUWb/BS8yccaL/K8ZtGptzoS0yOXu9s3Ue9KCAyDK8XGpcEiVlxFkf80boriveipXLHf6c2U+KJoU=
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
Subject: [PATCH net 3/5] netfilter: nft_flow_offload: release dst in case direct xmit path is used
Date: Thu, 22 Feb 2024 01:08:41 +0100
Message-Id: <20240222000843.146665-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240222000843.146665-1-pablo@netfilter.org>
References: <20240222000843.146665-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Direct xmit does not use it since it calls dev_queue_xmit() to send
packets, hence it calls dst_release().

kmemleak reports:

unreferenced object 0xffff88814f440900 (size 184):
  comm "softirq", pid 0, jiffies 4294951896
  hex dump (first 32 bytes):
    00 60 5b 04 81 88 ff ff 00 e6 e8 82 ff ff ff ff  .`[.............
    21 0b 50 82 ff ff ff ff 00 00 00 00 00 00 00 00  !.P.............
  backtrace (crc cb2bf5d6):
    [<000000003ee17107>] kmem_cache_alloc+0x286/0x340
    [<0000000021a5de2c>] dst_alloc+0x43/0xb0
    [<00000000f0671159>] rt_dst_alloc+0x2e/0x190
    [<00000000fe5092c9>] __mkroute_output+0x244/0x980
    [<000000005fb96fb0>] ip_route_output_flow+0xc0/0x160
    [<0000000045367433>] nf_ip_route+0xf/0x30
    [<0000000085da1d8e>] nf_route+0x2d/0x60
    [<00000000d1ecd1cb>] nft_flow_route+0x171/0x6a0 [nft_flow_offload]
    [<00000000d9b2fb60>] nft_flow_offload_eval+0x4e8/0x700 [nft_flow_offload]
    [<000000009f447dbb>] expr_call_ops_eval+0x53/0x330 [nf_tables]
    [<00000000072e1be6>] nft_do_chain+0x17c/0x840 [nf_tables]
    [<00000000d0551029>] nft_do_chain_inet+0xa1/0x210 [nf_tables]
    [<0000000097c9d5c6>] nf_hook_slow+0x5b/0x160
    [<0000000005eccab1>] ip_forward+0x8b6/0x9b0
    [<00000000553a269b>] ip_rcv+0x221/0x230
    [<00000000412872e5>] __netif_receive_skb_one_core+0xfe/0x110

Fixes: fa502c865666 ("netfilter: flowtable: simplify route logic")
Reported-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_flow_table_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 7502d6d73a60..a0571339239c 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -132,6 +132,7 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 		       ETH_ALEN);
 		flow_tuple->out.ifidx = route->tuple[dir].out.ifindex;
 		flow_tuple->out.hw_ifidx = route->tuple[dir].out.hw_ifindex;
+		dst_release(dst);
 		break;
 	case FLOW_OFFLOAD_XMIT_XFRM:
 	case FLOW_OFFLOAD_XMIT_NEIGH:
-- 
2.30.2


