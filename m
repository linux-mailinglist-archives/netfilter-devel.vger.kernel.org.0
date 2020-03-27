Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8033D194EDF
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Mar 2020 03:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgC0CZO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 26 Mar 2020 22:25:14 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:41656 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbgC0CZO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:25:14 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1jHegL-000698-64; Fri, 27 Mar 2020 03:25:13 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 4/4] netfilter: nf_queue: prefer nf_queue_entry_free
Date:   Fri, 27 Mar 2020 03:24:49 +0100
Message-Id: <20200327022449.7411-5-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200327022449.7411-1-fw@strlen.de>
References: <20200327022449.7411-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Instead of dropping refs+kfree, use the helper added in previous patch.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_queue.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index aadccdd117f0..bbd1209694b8 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -155,18 +155,16 @@ static void nf_ip6_saveroute(const struct sk_buff *skb,
 static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 		      unsigned int index, unsigned int queuenum)
 {
-	int status = -ENOENT;
 	struct nf_queue_entry *entry = NULL;
 	const struct nf_queue_handler *qh;
 	struct net *net = state->net;
 	unsigned int route_key_size;
+	int status;
 
 	/* QUEUE == DROP if no one is waiting, to be safe. */
 	qh = rcu_dereference(net->nf.queue_handler);
-	if (!qh) {
-		status = -ESRCH;
-		goto err;
-	}
+	if (!qh)
+		return -ESRCH;
 
 	switch (state->pf) {
 	case AF_INET:
@@ -181,14 +179,12 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 	}
 
 	entry = kmalloc(sizeof(*entry) + route_key_size, GFP_ATOMIC);
-	if (!entry) {
-		status = -ENOMEM;
-		goto err;
-	}
+	if (!entry)
+		return -ENOMEM;
 
 	if (skb_dst(skb) && !skb_dst_force(skb)) {
-		status = -ENETDOWN;
-		goto err;
+		kfree(entry);
+		return -ENETDOWN;
 	}
 
 	*entry = (struct nf_queue_entry) {
@@ -212,17 +208,12 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 	}
 
 	status = qh->outfn(entry, queuenum);
-
 	if (status < 0) {
-		nf_queue_entry_release_refs(entry);
-		goto err;
+		nf_queue_entry_free(entry);
+		return status;
 	}
 
 	return 0;
-
-err:
-	kfree(entry);
-	return status;
 }
 
 /* Packets leaving via this function must come back through nf_reinject(). */
-- 
2.24.1

