Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C46EC194EDE
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Mar 2020 03:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgC0CZL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 26 Mar 2020 22:25:11 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:41652 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbgC0CZK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:25:10 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1jHegG-00068x-UQ; Fri, 27 Mar 2020 03:25:09 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 3/4] netfilter: nf_queue: do not release refcouts until nf_reinject is done
Date:   Fri, 27 Mar 2020 03:24:48 +0100
Message-Id: <20200327022449.7411-4-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200327022449.7411-1-fw@strlen.de>
References: <20200327022449.7411-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nf_queue is problematic when another NF_QUEUE invocation happens
from nf_reinject().

1. nf_queue is invoked, increments state->sk refcount.
2. skb is queued, waiting for verdict.
3. sk is closed/released.
3. verdict comes back, nf_reinject is called.
4. nf_reinject drops the reference -- refcount can now drop to 0

Instead of get_ref/release_ref pattern, we need to nest the get_ref calls:
    get_ref
       get_ref
       release_ref
     release_ref

So that when we invoke the next processing stage (another netfilter
or the okfn()), we hold at least one reference count on the
devices/socket.

After previous patch, it is now safe to put the entry even after okfn()
has potentially free'd the skb.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_queue.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index 96eb72908467..aadccdd117f0 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -303,12 +303,10 @@ void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 
 	hooks = nf_hook_entries_head(net, pf, entry->state.hook);
 
-	nf_queue_entry_release_refs(entry);
-
 	i = entry->hook_index;
 	if (WARN_ON_ONCE(!hooks || i >= hooks->num_hook_entries)) {
 		kfree_skb(skb);
-		kfree(entry);
+		nf_queue_entry_free(entry);
 		return;
 	}
 
@@ -347,6 +345,6 @@ void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 		kfree_skb(skb);
 	}
 
-	kfree(entry);
+	nf_queue_entry_free(entry);
 }
 EXPORT_SYMBOL(nf_reinject);
-- 
2.24.1

