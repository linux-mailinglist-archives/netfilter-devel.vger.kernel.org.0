Return-Path: <netfilter-devel+bounces-5822-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205CBA140BD
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Jan 2025 18:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180503ABC90
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Jan 2025 17:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EAB2419E2;
	Thu, 16 Jan 2025 17:19:33 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (unknown [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8CD2361CE;
	Thu, 16 Jan 2025 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047973; cv=none; b=gVSYze1ya4bWYfiG6wh8qAiaa+95IUuhMW91peh9edTDXPokLEdyIafzGBAb0Kk8496DbWH8nkz4tn1BhAt85HqWeO1YQrvvN3Nx4QOd3o1X9yA+Ue+CdOtXPOzXFqlw4a6etGvMbj1wbM5qEWZTJaMNwS9dqjus7AsqAWKy6rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047973; c=relaxed/simple;
	bh=6OS/a7grl6gGo/eIMQF3exeLDzIEFYUlqzHlYfkjBQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oxj7jobN3En+3b7vGCesEQk33NNiyjCCMYRYPshETGspugjiMLcEjnOhkB6SW5BNY4LKhti9niYDA+3W3gH68rQIHUyVuYaLybTSegFF4svaPx411JTVuFOjduGlVdpK1n1mWquvuPt+0DX7AjsalQhnO90Jn6wOGYgsFjYXo78=
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
Subject: [PATCH net-next 11/14] netfilter: conntrack: remove skb argument from nf_ct_refresh
Date: Thu, 16 Jan 2025 18:18:59 +0100
Message-Id: <20250116171902.1783620-12-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250116171902.1783620-1-pablo@netfilter.org>
References: <20250116171902.1783620-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

Its not used (and could be NULL), so remove it.
This allows to use nf_ct_refresh in places where we don't have
an skb without having to double-check that skb == NULL would be safe.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_conntrack.h   | 8 +++-----
 net/netfilter/nf_conntrack_amanda.c    | 2 +-
 net/netfilter/nf_conntrack_broadcast.c | 2 +-
 net/netfilter/nf_conntrack_core.c      | 7 +++----
 net/netfilter/nf_conntrack_h323_main.c | 4 ++--
 net/netfilter/nf_conntrack_sip.c       | 4 ++--
 net/netfilter/nft_ct.c                 | 2 +-
 7 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index cba3ccf03fcc..3cbf29dd0b71 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -204,8 +204,7 @@ bool nf_ct_get_tuplepr(const struct sk_buff *skb, unsigned int nhoff,
 		       struct nf_conntrack_tuple *tuple);
 
 void __nf_ct_refresh_acct(struct nf_conn *ct, enum ip_conntrack_info ctinfo,
-			  const struct sk_buff *skb,
-			  u32 extra_jiffies, bool do_acct);
+			  u32 extra_jiffies, unsigned int bytes);
 
 /* Refresh conntrack for this many jiffies and do accounting */
 static inline void nf_ct_refresh_acct(struct nf_conn *ct,
@@ -213,15 +212,14 @@ static inline void nf_ct_refresh_acct(struct nf_conn *ct,
 				      const struct sk_buff *skb,
 				      u32 extra_jiffies)
 {
-	__nf_ct_refresh_acct(ct, ctinfo, skb, extra_jiffies, true);
+	__nf_ct_refresh_acct(ct, ctinfo, extra_jiffies, skb->len);
 }
 
 /* Refresh conntrack for this many jiffies */
 static inline void nf_ct_refresh(struct nf_conn *ct,
-				 const struct sk_buff *skb,
 				 u32 extra_jiffies)
 {
-	__nf_ct_refresh_acct(ct, 0, skb, extra_jiffies, false);
+	__nf_ct_refresh_acct(ct, 0, extra_jiffies, 0);
 }
 
 /* kill conntrack and do accounting */
diff --git a/net/netfilter/nf_conntrack_amanda.c b/net/netfilter/nf_conntrack_amanda.c
index d011d2eb0848..7be4c35e4795 100644
--- a/net/netfilter/nf_conntrack_amanda.c
+++ b/net/netfilter/nf_conntrack_amanda.c
@@ -106,7 +106,7 @@ static int amanda_help(struct sk_buff *skb,
 
 	/* increase the UDP timeout of the master connection as replies from
 	 * Amanda clients to the server can be quite delayed */
-	nf_ct_refresh(ct, skb, master_timeout * HZ);
+	nf_ct_refresh(ct, master_timeout * HZ);
 
 	/* No data? */
 	dataoff = protoff + sizeof(struct udphdr);
diff --git a/net/netfilter/nf_conntrack_broadcast.c b/net/netfilter/nf_conntrack_broadcast.c
index cfa0fe0356de..a7552a46d6ac 100644
--- a/net/netfilter/nf_conntrack_broadcast.c
+++ b/net/netfilter/nf_conntrack_broadcast.c
@@ -75,7 +75,7 @@ int nf_conntrack_broadcast_help(struct sk_buff *skb,
 	nf_ct_expect_related(exp, 0);
 	nf_ct_expect_put(exp);
 
-	nf_ct_refresh(ct, skb, timeout * HZ);
+	nf_ct_refresh(ct, timeout * HZ);
 out:
 	return NF_ACCEPT;
 }
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 456446d7af20..0149d482adaa 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2089,9 +2089,8 @@ EXPORT_SYMBOL_GPL(nf_conntrack_in);
 /* Refresh conntrack for this many jiffies and do accounting if do_acct is 1 */
 void __nf_ct_refresh_acct(struct nf_conn *ct,
 			  enum ip_conntrack_info ctinfo,
-			  const struct sk_buff *skb,
 			  u32 extra_jiffies,
-			  bool do_acct)
+			  unsigned int bytes)
 {
 	/* Only update if this is not a fixed timeout */
 	if (test_bit(IPS_FIXED_TIMEOUT_BIT, &ct->status))
@@ -2104,8 +2103,8 @@ void __nf_ct_refresh_acct(struct nf_conn *ct,
 	if (READ_ONCE(ct->timeout) != extra_jiffies)
 		WRITE_ONCE(ct->timeout, extra_jiffies);
 acct:
-	if (do_acct)
-		nf_ct_acct_update(ct, CTINFO2DIR(ctinfo), skb->len);
+	if (bytes)
+		nf_ct_acct_update(ct, CTINFO2DIR(ctinfo), bytes);
 }
 EXPORT_SYMBOL_GPL(__nf_ct_refresh_acct);
 
diff --git a/net/netfilter/nf_conntrack_h323_main.c b/net/netfilter/nf_conntrack_h323_main.c
index 5a9bce24f3c3..14f73872f647 100644
--- a/net/netfilter/nf_conntrack_h323_main.c
+++ b/net/netfilter/nf_conntrack_h323_main.c
@@ -1385,7 +1385,7 @@ static int process_rcf(struct sk_buff *skb, struct nf_conn *ct,
 	if (info->timeout > 0) {
 		pr_debug("nf_ct_ras: set RAS connection timeout to "
 			 "%u seconds\n", info->timeout);
-		nf_ct_refresh(ct, skb, info->timeout * HZ);
+		nf_ct_refresh(ct, info->timeout * HZ);
 
 		/* Set expect timeout */
 		spin_lock_bh(&nf_conntrack_expect_lock);
@@ -1433,7 +1433,7 @@ static int process_urq(struct sk_buff *skb, struct nf_conn *ct,
 	info->sig_port[!dir] = 0;
 
 	/* Give it 30 seconds for UCF or URJ */
-	nf_ct_refresh(ct, skb, 30 * HZ);
+	nf_ct_refresh(ct, 30 * HZ);
 
 	return 0;
 }
diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index d0eac27f6ba0..ca748f8dbff1 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -1553,7 +1553,7 @@ static int sip_help_tcp(struct sk_buff *skb, unsigned int protoff,
 	if (dataoff >= skb->len)
 		return NF_ACCEPT;
 
-	nf_ct_refresh(ct, skb, sip_timeout * HZ);
+	nf_ct_refresh(ct, sip_timeout * HZ);
 
 	if (unlikely(skb_linearize(skb)))
 		return NF_DROP;
@@ -1624,7 +1624,7 @@ static int sip_help_udp(struct sk_buff *skb, unsigned int protoff,
 	if (dataoff >= skb->len)
 		return NF_ACCEPT;
 
-	nf_ct_refresh(ct, skb, sip_timeout * HZ);
+	nf_ct_refresh(ct, sip_timeout * HZ);
 
 	if (unlikely(skb_linearize(skb)))
 		return NF_DROP;
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 67a41cd2baaf..2e59aba681a1 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -929,7 +929,7 @@ static void nft_ct_timeout_obj_eval(struct nft_object *obj,
 	 */
 	values = nf_ct_timeout_data(timeout);
 	if (values)
-		nf_ct_refresh(ct, pkt->skb, values[0]);
+		nf_ct_refresh(ct, values[0]);
 }
 
 static int nft_ct_timeout_obj_init(const struct nft_ctx *ctx,
-- 
2.30.2


