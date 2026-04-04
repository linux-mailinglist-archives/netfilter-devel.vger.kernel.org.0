Return-Path: <netfilter-devel+bounces-11629-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK7XAVfj0GmIBgcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11629-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 04 Apr 2026 12:09:27 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0839A39AB75
	for <lists+netfilter-devel@lfdr.de>; Sat, 04 Apr 2026 12:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E67333002D38
	for <lists+netfilter-devel@lfdr.de>; Sat,  4 Apr 2026 10:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA643A8748;
	Sat,  4 Apr 2026 10:09:20 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E633554B
	for <netfilter-devel@vger.kernel.org>; Sat,  4 Apr 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775297359; cv=none; b=fIadN3JwsKYGjvjZt3y2HOj1Djig7bf4p7Grie/CHeRdDDsItwEG/mL00JDnkNJK5szHHpe+TOP5FN3KZb7kEO338WdrmsdYyh4o3tYXlnWrtPotoNYGaSKM9uU+wnHcz12951mP3pxoA62V6f30Kv3Vd1ZiflZlsqCfvfIybu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775297359; c=relaxed/simple;
	bh=4RNuESg17tAqqEpID/6fI9k4pqlM8AXbSMyzfTSooYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVpqSOESgos25xA4l0+hw+exTM+YivxrxoKWV5/50Bo+65eCedidt8kbt/3hOUKmy7HQF299E81QJVHFYn6fyscXiDJHdKTI0QDiD4q70W/5DYBk5NBdEW+HRdbCJT95KX4O/qvuZWlk3ZN/e2eeAdi5MM/458eJKvEGZq27LJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D1D556079E; Sat, 04 Apr 2026 12:09:15 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v2] netfilter: nfnetlink: prefer skb_mac_header helpers
Date: Sat,  4 Apr 2026 12:09:05 +0200
Message-ID: <20260404100909.19412-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11629-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,strlen.de:email,strlen.de:mid]
X-Rspamd-Queue-Id: 0839A39AB75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This adds implicit DEBUG_WARN_ON_ONCE for debug configurations.
No other changes intended.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2: also convert nfnetlink_log (spotted by Pablo)

 net/netfilter/nfnetlink_log.c   | 19 ++++++++++---------
 net/netfilter/nfnetlink_queue.c | 25 ++++++++++++-------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 3e08e3212983..009e18b542aa 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -401,7 +401,7 @@ nfulnl_timer(struct timer_list *t)
 
 static u32 nfulnl_get_bridge_size(const struct sk_buff *skb)
 {
-	u32 size = 0;
+	u32 mac_len, size = 0;
 
 	if (!skb_mac_header_was_set(skb))
 		return 0;
@@ -412,14 +412,17 @@ static u32 nfulnl_get_bridge_size(const struct sk_buff *skb)
 		size += nla_total_size(sizeof(u16)); /* tag */
 	}
 
-	if (skb->network_header > skb->mac_header)
-		size += nla_total_size(skb->network_header - skb->mac_header);
+	mac_len = skb_mac_header_len(skb);
+	if (mac_len > 0)
+		size += nla_total_size(mac_len);
 
 	return size;
 }
 
 static int nfulnl_put_bridge(struct nfulnl_instance *inst, const struct sk_buff *skb)
 {
+	u32 mac_len;
+
 	if (!skb_mac_header_was_set(skb))
 		return 0;
 
@@ -437,12 +440,10 @@ static int nfulnl_put_bridge(struct nfulnl_instance *inst, const struct sk_buff
 		nla_nest_end(inst->skb, nest);
 	}
 
-	if (skb->mac_header < skb->network_header) {
-		int len = (int)(skb->network_header - skb->mac_header);
-
-		if (nla_put(inst->skb, NFULA_L2HDR, len, skb_mac_header(skb)))
-			goto nla_put_failure;
-	}
+	mac_len = skb_mac_header_len(skb);
+	if (mac_len > 0 &&
+	    nla_put(inst->skb, NFULA_L2HDR, mac_len, skb_mac_header(skb)))
+		goto nla_put_failure;
 
 	return 0;
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 4e579ddb7428..3fd1dfc0c105 100644
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
2.53.0


