Return-Path: <netfilter-devel+bounces-13036-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MmdUK3qzIGqI6wAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13036-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 01:06:34 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A38963BBC6
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 01:06:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13036-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13036-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D55F300B447
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jun 2026 23:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434874C0433;
	Wed,  3 Jun 2026 23:06:31 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA345325495
	for <netfilter-devel@vger.kernel.org>; Wed,  3 Jun 2026 23:06:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527991; cv=none; b=Ux/moDzdjq7B1cQ9PW/IMsEatac8Pgds+JmZt8gLw5rqDKYnyDGlZOcDNaWd11fTPyRNQCXkwOYx7yafMAJi4g0rDwFzQg/HSo3AyB1sQlJ7q9SBEGXW768DE/Uris6PMc72wuIf3hnNeoEEZZz3241wX655pcJnnGMoSvGty6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527991; c=relaxed/simple;
	bh=YDtfG9zM0B5jQNwH/k9VWIB1IrPGXA/eiIwifdkap60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDzx7l+o31nWtjSmIvl0/D48SHCFGCIWQpiDtxn9jOy07JqBfzwU6UDApphYXwGlH7yj37iseVVU9pz+xm65G1+NJrWTfMArByr0pNl3abpQwdGbPjJuq512E9lpbQ1Uj2hfXkOGKmlGnOzeGZZgUfVeGNL3fhH4NRqRxn1E5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5607F6079B; Thu, 04 Jun 2026 01:06:28 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH v2 nf-next 2/4] netfilter: nf_conncount: split count_tree_node rbtree walk into helper
Date: Thu,  4 Jun 2026 01:06:01 +0200
Message-ID: <20260603230610.7900-3-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603230610.7900-1-fw@strlen.de>
References: <20260603230610.7900-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13036-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,strlen.de:mid,strlen.de:from_mime,strlen.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A38963BBC6

Add find_tree_node() helper that fetches a matching rbtree node.

This is used by followup patch to optionally search the tree again while
preventing concurrent updates via tree lock.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2: no changes.
 net/netfilter/nf_conncount.c | 96 ++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 38 deletions(-)

diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index d3866393b4f5..8d9c24b69dc9 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -488,23 +488,15 @@ insert_tree(struct net *net,
 	return count;
 }
 
-static unsigned int
-count_tree(struct net *net,
-	   const struct sk_buff *skb,
-	   u16 l3num,
-	   struct nf_conncount_data *data,
-	   const u32 *key)
+static struct nf_conncount_rb *
+find_tree_node(struct nf_conncount_root *root, struct nf_conncount_data *data,
+	       const u32 *key)
 {
-	struct nf_conncount_root *root;
 	struct rb_node *parent;
-	struct nf_conncount_rb *rbconn;
-	unsigned int hash;
-
-	hash = jhash2(key, data->keylen, data->initval) % CONNCOUNT_SLOTS;
-	root = &data->root[hash];
 
 	parent = rcu_dereference_raw(root->root.rb_node);
 	while (parent) {
+		struct nf_conncount_rb *rbconn;
 		int diff;
 
 		rbconn = rb_entry(parent, struct nf_conncount_rb, node);
@@ -515,40 +507,68 @@ count_tree(struct net *net,
 		} else if (diff > 0) {
 			parent = rcu_dereference_raw(parent->rb_right);
 		} else {
-			int ret;
+			return rbconn;
+		}
+	}
 
-			if (!skb) {
-				nf_conncount_gc_list(net, &rbconn->list);
-				return rbconn->list.count;
-			}
+	return ERR_PTR(-ENOENT);
+}
 
-			spin_lock_bh(&rbconn->list.list_lock);
-			/* Node might be about to be free'd.
-			 * We need to defer to insert_tree() in this case.
-			 */
-			if (rbconn->list.count == 0) {
-				spin_unlock_bh(&rbconn->list.list_lock);
-				break;
-			}
+static unsigned int
+count_tree(struct net *net,
+	   const struct sk_buff *skb,
+	   u16 l3num,
+	   struct nf_conncount_data *data,
+	   const u32 *key)
+{
+	struct nf_conncount_root *root;
+	struct nf_conncount_rb *rbconn;
+	unsigned int hash;
+	int ret;
 
-			/* same source network -> be counted! */
-			ret = __nf_conncount_add(net, skb, l3num, &rbconn->list);
-			spin_unlock_bh(&rbconn->list.list_lock);
-			if (ret && ret != -EEXIST) {
-				return 0; /* hotdrop */
-			} else {
-				/* -EEXIST means add was skipped, update the list */
-				if (ret == -EEXIST)
-					nf_conncount_gc_list(net, &rbconn->list);
-				return rbconn->list.count;
-			}
+	hash = jhash2(key, data->keylen, data->initval) % CONNCOUNT_SLOTS;
+	root = &data->root[hash];
+
+	rbconn = find_tree_node(root, data, key);
+	if (IS_ERR(rbconn)) {
+		if (PTR_ERR(rbconn) == -ENOENT) {
+			if (!skb)
+				return 0;
+
+			return insert_tree(net, skb, l3num, data, hash, key);
 		}
+		DEBUG_NET_WARN_ON_ONCE(IS_ERR(rbconn));
 	}
 
-	if (!skb)
+	DEBUG_NET_WARN_ON_ONCE(IS_ERR_OR_NULL(rbconn));
+	if (IS_ERR_OR_NULL(rbconn))
 		return 0;
 
-	return insert_tree(net, skb, l3num, data, hash, key);
+	if (!skb) {
+		nf_conncount_gc_list(net, &rbconn->list);
+		return rbconn->list.count;
+	}
+
+	spin_lock_bh(&rbconn->list.list_lock);
+	/* Node might be about to be free'd.
+	 * We need to defer to insert_tree() in this case.
+	 */
+	if (rbconn->list.count == 0) {
+		spin_unlock_bh(&rbconn->list.list_lock);
+		return insert_tree(net, skb, l3num, data, hash, key);
+	}
+
+	/* same source network -> be counted! */
+	ret = __nf_conncount_add(net, skb, l3num, &rbconn->list);
+	spin_unlock_bh(&rbconn->list.list_lock);
+
+	if (ret && ret != -EEXIST)
+		return 0; /* hotdrop */
+	/* -EEXIST means add was skipped, update the list */
+	if (ret == -EEXIST)
+		nf_conncount_gc_list(net, &rbconn->list);
+
+	return rbconn->list.count;
 }
 
 static void tree_gc_worker(struct work_struct *work)
-- 
2.54.0


