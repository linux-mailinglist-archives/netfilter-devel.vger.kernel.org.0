Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58444CBF38
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Mar 2022 14:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiCCNzn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 3 Mar 2022 08:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiCCNzn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:55:43 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D138018BA74
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Mar 2022 05:54:57 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nPluy-0001WO-CG; Thu, 03 Mar 2022 14:54:56 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [RFC v3 nf-next 07/15] netfilter: conntrack: remove the percpu dying list
Date:   Thu,  3 Mar 2022 14:54:11 +0100
Message-Id: <20220303135419.10837-8-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220303135419.10837-1-fw@strlen.de>
References: <20220303135419.10837-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Its no longer needed. Entries that need event redelivery are placed
on the new pernet dying list.

The advantage is that there is no need to take additional spinlock on
conntrack removal unless event redelivery failed or the conntrack entry
was never added to the table in the first place (confirmed bit not set).

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netns/conntrack.h        |  1 -
 net/netfilter/nf_conntrack_core.c    | 35 +++++-----------------------
 net/netfilter/nf_conntrack_ecache.c  |  1 -
 net/netfilter/nf_conntrack_netlink.c | 23 ++++++------------
 4 files changed, 13 insertions(+), 47 deletions(-)

diff --git a/include/net/netns/conntrack.h b/include/net/netns/conntrack.h
index 3bb62e938fa9..dd1d096b2ada 100644
--- a/include/net/netns/conntrack.h
+++ b/include/net/netns/conntrack.h
@@ -96,7 +96,6 @@ struct nf_ip_net {
 struct ct_pcpu {
 	spinlock_t		lock;
 	struct hlist_nulls_head unconfirmed;
-	struct hlist_nulls_head dying;
 };
 
 struct netns_ct {
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 7eefcfa55fc2..6f7471ba0744 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -512,21 +512,6 @@ clean_from_lists(struct nf_conn *ct)
 	nf_ct_remove_expectations(ct);
 }
 
-/* must be called with local_bh_disable */
-static void nf_ct_add_to_dying_list(struct nf_conn *ct)
-{
-	struct ct_pcpu *pcpu;
-
-	/* add this conntrack to the (per cpu) dying list */
-	ct->cpu = smp_processor_id();
-	pcpu = per_cpu_ptr(nf_ct_net(ct)->ct.pcpu_lists, ct->cpu);
-
-	spin_lock(&pcpu->lock);
-	hlist_nulls_add_head(&ct->tuplehash[IP_CT_DIR_ORIGINAL].hnnode,
-			     &pcpu->dying);
-	spin_unlock(&pcpu->lock);
-}
-
 /* must be called with local_bh_disable */
 static void nf_ct_add_to_unconfirmed_list(struct nf_conn *ct)
 {
@@ -543,11 +528,11 @@ static void nf_ct_add_to_unconfirmed_list(struct nf_conn *ct)
 }
 
 /* must be called with local_bh_disable */
-static void nf_ct_del_from_dying_or_unconfirmed_list(struct nf_conn *ct)
+static void nf_ct_del_from_unconfirmed_list(struct nf_conn *ct)
 {
 	struct ct_pcpu *pcpu;
 
-	/* We overload first tuple to link into unconfirmed or dying list.*/
+	/* We overload first tuple to link into unconfirmed list.*/
 	pcpu = per_cpu_ptr(nf_ct_net(ct)->ct.pcpu_lists, ct->cpu);
 
 	spin_lock(&pcpu->lock);
@@ -635,7 +620,8 @@ void nf_ct_destroy(struct nf_conntrack *nfct)
 	 */
 	nf_ct_remove_expectations(ct);
 
-	nf_ct_del_from_dying_or_unconfirmed_list(ct);
+	if (unlikely(!nf_ct_is_confirmed(ct)))
+		nf_ct_del_from_unconfirmed_list(ct);
 
 	local_bh_enable();
 
@@ -673,7 +659,6 @@ static void nf_ct_delete_from_lists(struct nf_conn *ct)
 	local_bh_disable();
 
 	__nf_ct_delete_from_lists(ct);
-	nf_ct_add_to_dying_list(ct);
 
 	local_bh_enable();
 }
@@ -687,8 +672,6 @@ static void nf_ct_add_to_ecache_list(struct nf_conn *ct)
 	hlist_nulls_add_head_rcu(&ct->tuplehash[IP_CT_DIR_ORIGINAL].hnnode,
 				 &cnet->ecache.dying_list);
 	spin_unlock(&cnet->ecache.dying_lock);
-#else
-	nf_ct_add_to_dying_list(ct);
 #endif
 }
 
@@ -982,7 +965,6 @@ static void __nf_conntrack_insert_prepare(struct nf_conn *ct)
 	struct nf_conn_tstamp *tstamp;
 
 	refcount_inc(&ct->ct_general.use);
-	ct->status |= IPS_CONFIRMED;
 
 	/* set conntrack timestamp, if enabled. */
 	tstamp = nf_conn_tstamp_find(ct);
@@ -1011,7 +993,6 @@ static int __nf_ct_resolve_clash(struct sk_buff *skb,
 		nf_conntrack_get(&ct->ct_general);
 
 		nf_ct_acct_merge(ct, ctinfo, loser_ct);
-		nf_ct_add_to_dying_list(loser_ct);
 		nf_ct_put(loser_ct);
 		nf_ct_set(skb, ct, ctinfo);
 
@@ -1144,7 +1125,6 @@ nf_ct_resolve_clash(struct sk_buff *skb, struct nf_conntrack_tuple_hash *h,
 		return ret;
 
 drop:
-	nf_ct_add_to_dying_list(loser_ct);
 	NF_CT_STAT_INC(net, drop);
 	NF_CT_STAT_INC(net, insert_failed);
 	return NF_DROP;
@@ -1211,10 +1191,10 @@ __nf_conntrack_confirm(struct sk_buff *skb)
 	 * user context, else we insert an already 'dead' hash, blocking
 	 * further use of that particular connection -JM.
 	 */
-	nf_ct_del_from_dying_or_unconfirmed_list(ct);
+	nf_ct_del_from_unconfirmed_list(ct);
+	ct->status |= IPS_CONFIRMED;
 
 	if (unlikely(nf_ct_is_dying(ct))) {
-		nf_ct_add_to_dying_list(ct);
 		NF_CT_STAT_INC(net, insert_failed);
 		goto dying;
 	}
@@ -1238,7 +1218,6 @@ __nf_conntrack_confirm(struct sk_buff *skb)
 			goto out;
 		if (chainlen++ > max_chainlen) {
 chaintoolong:
-			nf_ct_add_to_dying_list(ct);
 			NF_CT_STAT_INC(net, chaintoolong);
 			NF_CT_STAT_INC(net, insert_failed);
 			ret = NF_DROP;
@@ -2752,7 +2731,6 @@ void nf_conntrack_init_end(void)
  * We need to use special "null" values, not used in hash table
  */
 #define UNCONFIRMED_NULLS_VAL	((1<<30)+0)
-#define DYING_NULLS_VAL		((1<<30)+1)
 
 int nf_conntrack_init_net(struct net *net)
 {
@@ -2773,7 +2751,6 @@ int nf_conntrack_init_net(struct net *net)
 
 		spin_lock_init(&pcpu->lock);
 		INIT_HLIST_NULLS_HEAD(&pcpu->unconfirmed, UNCONFIRMED_NULLS_VAL);
-		INIT_HLIST_NULLS_HEAD(&pcpu->dying, DYING_NULLS_VAL);
 	}
 
 	net->ct.stat = alloc_percpu(struct ip_conntrack_stat);
diff --git a/net/netfilter/nf_conntrack_ecache.c b/net/netfilter/nf_conntrack_ecache.c
index ce3ebd420585..a6ae8fd0c00e 100644
--- a/net/netfilter/nf_conntrack_ecache.c
+++ b/net/netfilter/nf_conntrack_ecache.c
@@ -95,7 +95,6 @@ static enum retry_state ecache_work_evict_list(struct nf_conntrack_net *cnet)
 	hlist_nulls_for_each_entry_safe(h, n, &evicted_list, hnnode) {
 		struct nf_conn *ct = nf_ct_tuplehash_to_ctrack(h);
 
-		hlist_nulls_add_fake(&ct->tuplehash[IP_CT_DIR_ORIGINAL].hnnode);
 		hlist_nulls_del_rcu(&ct->tuplehash[IP_CT_DIR_REPLY].hnnode);
 		nf_ct_put(ct);
 
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 3cd0d9d35b13..51e387e8da85 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -62,7 +62,6 @@ struct ctnetlink_list_dump_ctx {
 	struct nf_conn *last;
 	unsigned int cpu;
 	bool done;
-	bool retrans_done;
 };
 
 static int ctnetlink_dump_tuples_proto(struct sk_buff *skb,
@@ -1751,13 +1750,12 @@ static int ctnetlink_dump_one_entry(struct sk_buff *skb,
 }
 
 static int
-ctnetlink_dump_list(struct sk_buff *skb, struct netlink_callback *cb, bool dying)
+ctnetlink_dump_unconfirmed(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct ctnetlink_list_dump_ctx *ctx = (void *)cb->ctx;
 	struct nf_conn *ct, *last;
 	struct nf_conntrack_tuple_hash *h;
 	struct hlist_nulls_node *n;
-	struct hlist_nulls_head *list;
 	struct net *net = sock_net(skb->sk);
 	int res, cpu;
 
@@ -1774,12 +1772,11 @@ ctnetlink_dump_list(struct sk_buff *skb, struct netlink_callback *cb, bool dying
 
 		pcpu = per_cpu_ptr(net->ct.pcpu_lists, cpu);
 		spin_lock_bh(&pcpu->lock);
-		list = dying ? &pcpu->dying : &pcpu->unconfirmed;
 restart:
-		hlist_nulls_for_each_entry(h, n, list, hnnode) {
+		hlist_nulls_for_each_entry(h, n, &pcpu->unconfirmed, hnnode) {
 			ct = nf_ct_tuplehash_to_ctrack(h);
 
-			res = ctnetlink_dump_one_entry(skb, cb, ct, dying);
+			res = ctnetlink_dump_one_entry(skb, cb, ct, false);
 			if (res < 0) {
 				ctx->cpu = cpu;
 				spin_unlock_bh(&pcpu->lock);
@@ -1812,8 +1809,8 @@ ctnetlink_dump_dying(struct sk_buff *skb, struct netlink_callback *cb)
 	struct hlist_nulls_node *n;
 #endif
 
-	if (ctx->retrans_done)
-		return ctnetlink_dump_list(skb, cb, true);
+	if (ctx->done)
+		return 0;
 
 	ctx->last = NULL;
 
@@ -1842,10 +1839,10 @@ ctnetlink_dump_dying(struct sk_buff *skb, struct netlink_callback *cb)
 
 	spin_unlock_bh(&ecache_net->dying_lock);
 #endif
+	ctx->done = true;
 	nf_ct_put(last);
-	ctx->retrans_done = true;
 
-	return ctnetlink_dump_list(skb, cb, true);
+	return skb->len;
 }
 
 static int ctnetlink_get_ct_dying(struct sk_buff *skb,
@@ -1863,12 +1860,6 @@ static int ctnetlink_get_ct_dying(struct sk_buff *skb,
 	return -EOPNOTSUPP;
 }
 
-static int
-ctnetlink_dump_unconfirmed(struct sk_buff *skb, struct netlink_callback *cb)
-{
-	return ctnetlink_dump_list(skb, cb, false);
-}
-
 static int ctnetlink_get_ct_unconfirmed(struct sk_buff *skb,
 					const struct nfnl_info *info,
 					const struct nlattr * const cda[])
-- 
2.34.1

