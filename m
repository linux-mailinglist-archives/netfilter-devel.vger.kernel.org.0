Return-Path: <netfilter-devel+bounces-12144-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLFJBwAV6WmtUAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12144-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Apr 2026 20:35:44 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0751C449C89
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Apr 2026 20:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89D8B307599D
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Apr 2026 18:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E762165EA;
	Wed, 22 Apr 2026 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="eKU6LRuX"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAA326ADC
	for <netfilter-devel@vger.kernel.org>; Wed, 22 Apr 2026 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776882885; cv=none; b=eRVWQ83ByLWE96jy9tXfKX5rHE0vn5FJ1YMLR0ug1kt0c8qD5lqSVH1tMqyMi80i+fJg1sh6lDTIIzyiI4EB121j2ZZXf7WANB4AjPG7Wo+90y4JGnZm3uj717raRn4vtz0KxTPchq6X1hzdbWabGArOG7sQdN5Vz+hvQ4YenHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776882885; c=relaxed/simple;
	bh=ux1b+vFFLE/ur8p+oYDT5SRjs0FwM4Idwa1Ak6jctZ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlYD6xkHw1V1zlIEy8VMPtBHcQ0BEYzy1W5iXpD7dpzhHYPr1k8cCp4k48lEDVQDk+NL5Iz19kyqH9kLTgXacm5VdcDMnjyCao1CI2F180YzMHwFkAbKhXZcGnaU3Y2+uyKWfNvX44/Gbx9ZQmxz+ofYDKMsTtwxdW+CGejgSSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=eKU6LRuX; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 617706027F
	for <netfilter-devel@vger.kernel.org>; Wed, 22 Apr 2026 20:34:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776882876;
	bh=8Yh7rFxbkvDvmTfnr2NnhKh+olOyGy/zuae+fZKBWe4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eKU6LRuXNv5VzubK3Kul5Lh3zfTRiCp+OpHfid0ojqvlZnjkgjRHcHWVR6y6wWXhO
	 f7XdfuqPSVfqwh1PVOWrfqtToYLIbvYR2ZCHXE04iW79fsM5I+SHefus8HKafPZfi1
	 GSS/Xa+J460kp88lDPfavXG1Zd5938/iV+2Qlhw/B7bteNg+NUbwl4IXvqfTy/v2UB
	 bj/UHF6RLPBkolb1vRFW5SsHsxAhVX5FzO2QYEHZ0Z25Tz7PEO9heSR5syTTV+0y1G
	 qRnzKQfSRok2g0T/3yMh1i3pRfgiJclFRl/ri5GOC/MlJ3RYwyVGinMFQJEOv+rwhf
	 QYSaG3rwbCaNA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v3 3/3] netfilter: nft_fwd_netdev: use recursion counter in neigh egress path
Date: Wed, 22 Apr 2026 20:34:29 +0200
Message-ID: <20260422183429.240452-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422183429.240452-1-pablo@netfilter.org>
References: <20260422183429.240452-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[netfilter.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12144-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[netfilter.org:s=2025];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_SPAM(0.00)[0.873];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,netfilter.org:dkim,netfilter.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: 0751C449C89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Weiming Shi <bestswngs@gmail.com>

nft_fwd_neigh can be used in egress chains (NF_NETDEV_EGRESS). When the
forwarding rule targets the same device or two devices forward to each
other, neigh_xmit() triggers dev_queue_xmit() which re-enters
nf_hook_egress(), causing infinite recursion and stack overflow.

Move the nf_get_nf_dup_skb_recursion() accessor and NF_RECURSION_LIMIT
to the shared header nf_dup_netdev.h as a static inline, so that
nft_fwd_netdev can use the recursion counter directly without exported
function call overhead. Guard neigh_xmit() with the same recursion
limit already used in nf_do_netdev_egress().

Fixes: f87b9464d152 ("netfilter: nft_fwd_netdev: Support egress hook")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: no changes

 include/net/netfilter/nf_dup_netdev.h | 13 +++++++++++++
 net/netfilter/nf_dup_netdev.c         | 16 ----------------
 net/netfilter/nft_fwd_netdev.c        |  7 +++++++
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/net/netfilter/nf_dup_netdev.h b/include/net/netfilter/nf_dup_netdev.h
index b175d271aec9..609bcf422a9b 100644
--- a/include/net/netfilter/nf_dup_netdev.h
+++ b/include/net/netfilter/nf_dup_netdev.h
@@ -3,10 +3,23 @@
 #define _NF_DUP_NETDEV_H_
 
 #include <net/netfilter/nf_tables.h>
+#include <linux/netdevice.h>
+#include <linux/sched.h>
 
 void nf_dup_netdev_egress(const struct nft_pktinfo *pkt, int oif);
 void nf_fwd_netdev_egress(const struct nft_pktinfo *pkt, int oif);
 
+#define NF_RECURSION_LIMIT	2
+
+static inline u8 *nf_get_nf_dup_skb_recursion(void)
+{
+#ifndef CONFIG_PREEMPT_RT
+	return this_cpu_ptr(&softnet_data.xmit.nf_dup_skb_recursion);
+#else
+	return &current->net_xmit.nf_dup_skb_recursion;
+#endif
+}
+
 struct nft_offload_ctx;
 struct nft_flow_rule;
 
diff --git a/net/netfilter/nf_dup_netdev.c b/net/netfilter/nf_dup_netdev.c
index e348fb90b8dc..3b0a70e154cd 100644
--- a/net/netfilter/nf_dup_netdev.c
+++ b/net/netfilter/nf_dup_netdev.c
@@ -13,22 +13,6 @@
 #include <net/netfilter/nf_tables_offload.h>
 #include <net/netfilter/nf_dup_netdev.h>
 
-#define NF_RECURSION_LIMIT	2
-
-#ifndef CONFIG_PREEMPT_RT
-static u8 *nf_get_nf_dup_skb_recursion(void)
-{
-	return this_cpu_ptr(&softnet_data.xmit.nf_dup_skb_recursion);
-}
-#else
-
-static u8 *nf_get_nf_dup_skb_recursion(void)
-{
-	return &current->net_xmit.nf_dup_skb_recursion;
-}
-
-#endif
-
 static void nf_do_netdev_egress(struct sk_buff *skb, struct net_device *dev,
 				enum nf_dev_hooks hook)
 {
diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 80416017a2d5..5fa1b3e45095 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -152,6 +152,11 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 		goto out;
 	}
 
+	if (*nf_get_nf_dup_skb_recursion() > NF_RECURSION_LIMIT) {
+		verdict = NF_DROP;
+		goto out;
+	}
+
 	dev = dev_get_by_index_rcu(nft_net(pkt), oif);
 	if (dev == NULL) {
 		verdict = NF_DROP;
@@ -160,7 +165,9 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 
 	skb->dev = dev;
 	skb_clear_tstamp(skb);
+	(*nf_get_nf_dup_skb_recursion())++;
 	neigh_xmit(neigh_table, dev, addr, skb);
+	(*nf_get_nf_dup_skb_recursion())--;
 out:
 	regs->verdict.code = verdict;
 }
-- 
2.47.3


