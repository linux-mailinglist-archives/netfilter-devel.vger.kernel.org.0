Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 078F2194EDC
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Mar 2020 03:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgC0CZB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 26 Mar 2020 22:25:01 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:41644 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727456AbgC0CZB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:25:01 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1jHeg8-00068J-Gl; Fri, 27 Mar 2020 03:25:00 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 1/4] netfilter: nf_queue: make nf_queue_entry_release_refs static
Date:   Fri, 27 Mar 2020 03:24:46 +0100
Message-Id: <20200327022449.7411-2-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200327022449.7411-1-fw@strlen.de>
References: <20200327022449.7411-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is a preparation patch, no logical changes.
Move free_entry into core and rename it to something more sensible.

Will ease followup patches which will complicate the refcount handling.

Signed-off-by: Florian Westphal <fw@strlen.de>
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
2.24.1

