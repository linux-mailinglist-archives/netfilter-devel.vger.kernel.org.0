Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB120198436
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Mar 2020 21:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgC3TWl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Mar 2020 15:22:41 -0400
Received: from correo.us.es ([193.147.175.20]:48566 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbgC3TWF (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:22:05 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E750B103286
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Mar 2020 21:22:03 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C2782100A48
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Mar 2020 21:22:03 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 052B910219B; Mon, 30 Mar 2020 21:21:47 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EEC3522011;
        Mon, 30 Mar 2020 21:21:44 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 30 Mar 2020 21:21:44 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id C647942EF4E1;
        Mon, 30 Mar 2020 21:21:44 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org
Subject: [PATCH 17/28] netfilter: nf_queue: make nf_queue_entry_release_refs static
Date:   Mon, 30 Mar 2020 21:21:25 +0200
Message-Id: <20200330192136.230459-18-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200330192136.230459-1-pablo@netfilter.org>
References: <20200330192136.230459-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

This is a preparation patch, no logical changes.
Move free_entry into core and rename it to something more sensible.

Will ease followup patches which will complicate the refcount handling.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_queue.h |  2 +-
 net/netfilter/nf_queue.c         | 10 ++++++++--
 net/netfilter/nfnetlink_queue.c  | 10 ++--------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index 47088083667b..cdbd98730852 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -35,7 +35,7 @@ void nf_unregister_queue_handler(struct net *net);
 void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict);
 
 void nf_queue_entry_get_refs(struct nf_queue_entry *entry);
-void nf_queue_entry_release_refs(struct nf_queue_entry *entry);
+void nf_queue_entry_free(struct nf_queue_entry *entry);
 
 static inline void init_hashrandom(u32 *jhash_initval)
 {
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index f8f52ff99cfb..4da5776a9904 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -64,7 +64,7 @@ static void nf_queue_entry_release_br_nf_refs(struct sk_buff *skb)
 #endif
 }
 
-void nf_queue_entry_release_refs(struct nf_queue_entry *entry)
+static void nf_queue_entry_release_refs(struct nf_queue_entry *entry)
 {
 	struct nf_hook_state *state = &entry->state;
 
@@ -78,7 +78,13 @@ void nf_queue_entry_release_refs(struct nf_queue_entry *entry)
 
 	nf_queue_entry_release_br_nf_refs(entry->skb);
 }
-EXPORT_SYMBOL_GPL(nf_queue_entry_release_refs);
+
+void nf_queue_entry_free(struct nf_queue_entry *entry)
+{
+	nf_queue_entry_release_refs(entry);
+	kfree(entry);
+}
+EXPORT_SYMBOL_GPL(nf_queue_entry_free);
 
 static void nf_queue_entry_get_br_nf_refs(struct sk_buff *skb)
 {
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 76535fd9278c..3243a31f6e82 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -737,12 +737,6 @@ static void nf_bridge_adjust_segmented_data(struct sk_buff *skb)
 #define nf_bridge_adjust_segmented_data(s) do {} while (0)
 #endif
 
-static void free_entry(struct nf_queue_entry *entry)
-{
-	nf_queue_entry_release_refs(entry);
-	kfree(entry);
-}
-
 static int
 __nfqnl_enqueue_packet_gso(struct net *net, struct nfqnl_instance *queue,
 			   struct sk_buff *skb, struct nf_queue_entry *entry)
@@ -768,7 +762,7 @@ __nfqnl_enqueue_packet_gso(struct net *net, struct nfqnl_instance *queue,
 		entry_seg->skb = skb;
 		ret = __nfqnl_enqueue_packet(net, queue, entry_seg);
 		if (ret)
-			free_entry(entry_seg);
+			nf_queue_entry_free(entry_seg);
 	}
 	return ret;
 }
@@ -827,7 +821,7 @@ nfqnl_enqueue_packet(struct nf_queue_entry *entry, unsigned int queuenum)
 
 	if (queued) {
 		if (err) /* some segments are already queued */
-			free_entry(entry);
+			nf_queue_entry_free(entry);
 		kfree_skb(skb);
 		return 0;
 	}
-- 
2.11.0

