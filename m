Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B9333F4DC
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Mar 2021 17:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhCQQAa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Mar 2021 12:00:30 -0400
Received: from mail.netfilter.org ([217.70.188.207]:48194 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbhCQQAJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:00:09 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 35B2A6355C
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Mar 2021 16:16:43 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v2 2/6] netfilter: flowtable: move skb_try_make_writable() before NAT in IPv4
Date:   Wed, 17 Mar 2021 16:16:37 +0100
Message-Id: <20210317151641.19637-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210317151641.19637-1-pablo@netfilter.org>
References: <20210317151641.19637-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

For consistency with the IPv6 flowtable datapath and to make sure the
skbuff is writable right before the NAT header updates.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
new patch in this v2.

 net/netfilter/nf_flow_table_ip.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 2b8ee5dcef64..95adf74515ea 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -266,10 +266,6 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 
 	iph = ip_hdr(skb);
 	thoff = iph->ihl * 4;
-	if (skb_try_make_writable(skb, thoff + hdrsize))
-		return NF_DROP;
-
-	iph = ip_hdr(skb);
 	if (nf_flow_state_check(flow, iph->protocol, skb, thoff))
 		return NF_ACCEPT;
 
@@ -280,6 +276,10 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 		return NF_ACCEPT;
 	}
 
+	if (skb_try_make_writable(skb, thoff + hdrsize))
+		return NF_DROP;
+
+	iph = ip_hdr(skb);
 	if (nf_flow_nat_ip(flow, skb, thoff, dir, iph) < 0)
 		return NF_DROP;
 
-- 
2.20.1

