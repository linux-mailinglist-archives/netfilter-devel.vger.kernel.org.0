Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28C73E11B0
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Aug 2021 11:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbhHEJzU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Aug 2021 05:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbhHEJzT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:55:19 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6A2C061765
        for <netfilter-devel@vger.kernel.org>; Thu,  5 Aug 2021 02:55:05 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1mBa5f-0002U6-Jy; Thu, 05 Aug 2021 11:55:03 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: nf_queue: move hookfn registration out of struct net
Date:   Thu,  5 Aug 2021 11:54:58 +0200
Message-Id: <20210805095458.16754-1-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This was done to detect when the pernet->init() function was not called
yet, by checking if net->nf.queue_handler is NULL.

Once the nfnetlink_queue module is active, all struct net pointers contain
the same address.  So place this back in nf_queue.c.

Handle the 'netns error unwind' test by checking nfnl_queue_net for a
NULL pointer and add a comment for this.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_queue.h |  4 ++--
 include/net/netns/netfilter.h    |  1 -
 net/netfilter/nf_queue.c         | 18 +++++++++---------
 net/netfilter/nfnetlink_queue.c  | 15 +++++++++++++--
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index e770bba00066..9eed51e920e8 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -33,8 +33,8 @@ struct nf_queue_handler {
 	void		(*nf_hook_drop)(struct net *net);
 };
 
-void nf_register_queue_handler(struct net *net, const struct nf_queue_handler *qh);
-void nf_unregister_queue_handler(struct net *net);
+void nf_register_queue_handler(const struct nf_queue_handler *qh);
+void nf_unregister_queue_handler(void);
 void nf_reinject(struct nf_queue_entry *entry, unsigned int verdict);
 
 void nf_queue_entry_get_refs(struct nf_queue_entry *entry);
diff --git a/include/net/netns/netfilter.h b/include/net/netns/netfilter.h
index 15e2b13fb0c0..986a2a9cfdfa 100644
--- a/include/net/netns/netfilter.h
+++ b/include/net/netns/netfilter.h
@@ -12,7 +12,6 @@ struct netns_nf {
 #if defined CONFIG_PROC_FS
 	struct proc_dir_entry *proc_netfilter;
 #endif
-	const struct nf_queue_handler __rcu *queue_handler;
 	const struct nf_logger __rcu *nf_loggers[NFPROTO_NUMPROTO];
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_header *nf_log_dir_header;
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index bbd1209694b8..e36a8461486b 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -21,6 +21,8 @@
 
 #include "nf_internals.h"
 
+static const struct nf_queue_handler __rcu *nf_queue_handler;
+
 /*
  * Hook for nfnetlink_queue to register its queue handler.
  * We do this so that most of the NFQUEUE code can be modular.
@@ -29,20 +31,18 @@
  * receives, no matter what.
  */
 
-/* return EBUSY when somebody else is registered, return EEXIST if the
- * same handler is registered, return 0 in case of success. */
-void nf_register_queue_handler(struct net *net, const struct nf_queue_handler *qh)
+void nf_register_queue_handler(const struct nf_queue_handler *qh)
 {
 	/* should never happen, we only have one queueing backend in kernel */
-	WARN_ON(rcu_access_pointer(net->nf.queue_handler));
-	rcu_assign_pointer(net->nf.queue_handler, qh);
+	WARN_ON(rcu_access_pointer(nf_queue_handler));
+	rcu_assign_pointer(nf_queue_handler, qh);
 }
 EXPORT_SYMBOL(nf_register_queue_handler);
 
 /* The caller must flush their queue before this */
-void nf_unregister_queue_handler(struct net *net)
+void nf_unregister_queue_handler(void)
 {
-	RCU_INIT_POINTER(net->nf.queue_handler, NULL);
+	RCU_INIT_POINTER(nf_queue_handler, NULL);
 }
 EXPORT_SYMBOL(nf_unregister_queue_handler);
 
@@ -116,7 +116,7 @@ void nf_queue_nf_hook_drop(struct net *net)
 	const struct nf_queue_handler *qh;
 
 	rcu_read_lock();
-	qh = rcu_dereference(net->nf.queue_handler);
+	qh = rcu_dereference(nf_queue_handler);
 	if (qh)
 		qh->nf_hook_drop(net);
 	rcu_read_unlock();
@@ -162,7 +162,7 @@ static int __nf_queue(struct sk_buff *skb, const struct nf_hook_state *state,
 	int status;
 
 	/* QUEUE == DROP if no one is waiting, to be safe. */
-	qh = rcu_dereference(net->nf.queue_handler);
+	qh = rcu_dereference(nf_queue_handler);
 	if (!qh)
 		return -ESRCH;
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index f774de0fc24f..4c3fbaaeb103 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -951,6 +951,16 @@ static void nfqnl_nf_hook_drop(struct net *net)
 	struct nfnl_queue_net *q = nfnl_queue_pernet(net);
 	int i;
 
+	/* This function is also called on net namespace error unwind,
+	 * when pernet_ops->init() failed and ->exit() functions of the
+	 * previous pernet_ops gets called.
+	 *
+	 * This may result in a call to nfqnl_nf_hook_drop() before
+	 * struct nfnl_queue_net was allocated.
+	 */
+	if (!q)
+		return;
+
 	for (i = 0; i < INSTANCE_BUCKETS; i++) {
 		struct nfqnl_instance *inst;
 		struct hlist_head *head = &q->instance_table[i];
@@ -1502,7 +1512,6 @@ static int __net_init nfnl_queue_net_init(struct net *net)
 			&nfqnl_seq_ops, sizeof(struct iter_state)))
 		return -ENOMEM;
 #endif
-	nf_register_queue_handler(net, &nfqh);
 	return 0;
 }
 
@@ -1511,7 +1520,6 @@ static void __net_exit nfnl_queue_net_exit(struct net *net)
 	struct nfnl_queue_net *q = nfnl_queue_pernet(net);
 	unsigned int i;
 
-	nf_unregister_queue_handler(net);
 #ifdef CONFIG_PROC_FS
 	remove_proc_entry("nfnetlink_queue", net->nf.proc_netfilter);
 #endif
@@ -1555,6 +1563,8 @@ static int __init nfnetlink_queue_init(void)
 		goto cleanup_netlink_subsys;
 	}
 
+	nf_register_queue_handler(&nfqh);
+
 	return status;
 
 cleanup_netlink_subsys:
@@ -1568,6 +1578,7 @@ static int __init nfnetlink_queue_init(void)
 
 static void __exit nfnetlink_queue_fini(void)
 {
+	nf_unregister_queue_handler();
 	unregister_netdevice_notifier(&nfqnl_dev_notifier);
 	nfnetlink_subsys_unregister(&nfqnl_subsys);
 	netlink_unregister_notifier(&nfqnl_rtnl_notifier);
-- 
2.31.1

