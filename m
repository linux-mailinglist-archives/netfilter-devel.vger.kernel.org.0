Return-Path: <netfilter-devel+bounces-11162-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOb9CzcLs2nURwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11162-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 19:51:35 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D562775B1
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 19:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AFA530068C9
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 18:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A3F3932E9;
	Thu, 12 Mar 2026 18:51:31 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAD226C3BD
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Mar 2026 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341491; cv=none; b=UB/uvhC5EFIS/lC7AsBA2OxnXH2g5twZonWRAlh5XwCUlh8X4RiIpEGjl4HTw0Ok89op2CDaA+WRPGTnq8/O3rqwaLX75ZHFS5vGg8VsVHX9kd+hW1jBPsFqlu7KrSRGUK48QK+XgQ4yzyYte1XtW0KNC+7Tv8sCV2nZGgsArQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341491; c=relaxed/simple;
	bh=hWb+2SIrwYqOJd2TrUcCHHvsTAsP/cemwYxCs1jOD3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCk+tYkMPOI1bwqtPAGKEqdsWeES2VjArp3r1/MuDdb+C3ScS7+Ws+zJTsCXCykAv6qAYJHuaC8s0G+L8qfzyKFvLTv9UUt5EIj6V4R09VRF3hNL38iUWefvRVluPwTAdW1FdlvLPkQBPXcd+Ia/0NPIiYiEbp886R6fmtPU164=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8C37960345; Thu, 12 Mar 2026 19:51:28 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: nfnetlink_queue: prefer skb_mac_header helpers
Date: Thu, 12 Mar 2026 19:51:15 +0100
Message-ID: <20260312185122.26017-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11162-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: A1D562775B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This adds implicit DEBUG_WARN_ON_ONCE for debug configurations.
No other changes intended.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nfnetlink_queue.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 5379d8ff39c0..c2906706c82a 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -602,6 +602,7 @@ static u32 nfqnl_get_bridge_size(struct nf_queue_entry *entry)
 {
 	struct sk_buff *entskb = entry->skb;
 	u32 nlalen = 0;
+	u32 mac_len;
 
 	if (entry->state.pf != PF_BRIDGE || !skb_mac_header_was_set(entskb))
 		return 0;
@@ -610,9 +611,9 @@ static u32 nfqnl_get_bridge_size(struct nf_queue_entry *entry)
 		nlalen += nla_total_size(nla_total_size(sizeof(__be16)) +
 					 nla_total_size(sizeof(__be16)));
 
-	if (entskb->network_header > entskb->mac_header)
-		nlalen += nla_total_size((entskb->network_header -
-					  entskb->mac_header));
+	mac_len = skb_mac_header_len(entskb);
+	if (mac_len > 0)
+		nlalen += nla_total_size(mac_len);
 
 	return nlalen;
 }
@@ -620,6 +621,7 @@ static u32 nfqnl_get_bridge_size(struct nf_queue_entry *entry)
 static int nfqnl_put_bridge(struct nf_queue_entry *entry, struct sk_buff *skb)
 {
 	struct sk_buff *entskb = entry->skb;
+	u32 mac_len;
 
 	if (entry->state.pf != PF_BRIDGE || !skb_mac_header_was_set(entskb))
 		return 0;
@@ -638,12 +640,10 @@ static int nfqnl_put_bridge(struct nf_queue_entry *entry, struct sk_buff *skb)
 		nla_nest_end(skb, nest);
 	}
 
-	if (entskb->mac_header < entskb->network_header) {
-		int len = (int)(entskb->network_header - entskb->mac_header);
-
-		if (nla_put(skb, NFQA_L2HDR, len, skb_mac_header(entskb)))
-			goto nla_put_failure;
-	}
+	mac_len = skb_mac_header_len(entskb);
+	if (mac_len > 0 &&
+	    nla_put(skb, NFQA_L2HDR, mac_len, skb_mac_header(entskb)))
+		goto nla_put_failure;
 
 	return 0;
 
@@ -1027,13 +1027,13 @@ nf_queue_entry_dup(struct nf_queue_entry *e)
 static void nf_bridge_adjust_skb_data(struct sk_buff *skb)
 {
 	if (nf_bridge_info_get(skb))
-		__skb_push(skb, skb->network_header - skb->mac_header);
+		__skb_push(skb, skb_mac_header_len(skb));
 }
 
 static void nf_bridge_adjust_segmented_data(struct sk_buff *skb)
 {
 	if (nf_bridge_info_get(skb))
-		__skb_pull(skb, skb->network_header - skb->mac_header);
+		__skb_pull(skb, skb_mac_header_len(skb));
 }
 #else
 #define nf_bridge_adjust_skb_data(s) do {} while (0)
@@ -1492,8 +1492,7 @@ static int nfqa_parse_bridge(struct nf_queue_entry *entry,
 	}
 
 	if (nfqa[NFQA_L2HDR]) {
-		int mac_header_len = entry->skb->network_header -
-			entry->skb->mac_header;
+		u32 mac_header_len = skb_mac_header_len(entry->skb);
 
 		if (mac_header_len != nla_len(nfqa[NFQA_L2HDR]))
 			return -EINVAL;
-- 
2.52.0


