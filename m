Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B10D89F308
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Aug 2019 21:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfH0TPj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 27 Aug 2019 15:15:39 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:40086 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728972AbfH0TPi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:15:38 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1i2gwK-0005Q5-Ro; Tue, 27 Aug 2019 21:15:36 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: nf_flow_table: clear skb tstamp before xmit
Date:   Tue, 27 Aug 2019 21:23:45 +0200
Message-Id: <20190827192345.12661-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If 'fq' qdisc is used and a program has requested timestamps,
skb->tstamp needs to be cleared, else fq will treat these as
'transmit time'.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_flow_table_ip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index d68c801dd614..b9e7dd6e60ce 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -228,7 +228,6 @@ static unsigned int nf_flow_xmit_xfrm(struct sk_buff *skb,
 {
 	skb_orphan(skb);
 	skb_dst_set_noref(skb, dst);
-	skb->tstamp = 0;
 	dst_output(state->net, state->sk, skb);
 	return NF_STOLEN;
 }
@@ -284,6 +283,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 	flow->timeout = (u32)jiffies + NF_FLOW_TIMEOUT;
 	iph = ip_hdr(skb);
 	ip_decrease_ttl(iph);
+	skb->tstamp = 0;
 
 	if (unlikely(dst_xfrm(&rt->dst))) {
 		memset(skb->cb, 0, sizeof(struct inet_skb_parm));
@@ -512,6 +512,7 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 	flow->timeout = (u32)jiffies + NF_FLOW_TIMEOUT;
 	ip6h = ipv6_hdr(skb);
 	ip6h->hop_limit--;
+	skb->tstamp = 0;
 
 	if (unlikely(dst_xfrm(&rt->dst))) {
 		memset(skb->cb, 0, sizeof(struct inet6_skb_parm));
-- 
2.21.0

