Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82EB424DE7
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 May 2019 13:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfEULbS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 May 2019 07:31:18 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:35490 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbfEULbS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 May 2019 07:31:18 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hT2zE-0008Td-9I; Tue, 21 May 2019 13:31:16 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     marcmicalizzi@gmail.com, Florian Westphal <fw@strlen.de>
Subject: [PATCH nf 1/5] netfilter: nf_flow_table: ignore DF bit setting
Date:   Tue, 21 May 2019 13:24:30 +0200
Message-Id: <20190521112434.11767-2-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521112434.11767-1-fw@strlen.de>
References: <20190521112434.11767-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Its irrelevant if the DF bit is set or not, we must pass packet to
stack in either case.

If the DF bit is set, we must pass it to stack so the appropriate
ICMP error can be generated.

If the DF is not set, we must pass it to stack for fragmentation.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_flow_table_ip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 0d603e20b519..bfd44db9f214 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -243,8 +243,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 	rt = (struct rtable *)flow->tuplehash[dir].tuple.dst_cache;
 	outdev = rt->dst.dev;
 
-	if (unlikely(nf_flow_exceeds_mtu(skb, flow->tuplehash[dir].tuple.mtu)) &&
-	    (ip_hdr(skb)->frag_off & htons(IP_DF)) != 0)
+	if (unlikely(nf_flow_exceeds_mtu(skb, flow->tuplehash[dir].tuple.mtu)))
 		return NF_ACCEPT;
 
 	if (skb_try_make_writable(skb, sizeof(*iph)))
-- 
2.21.0

