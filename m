Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823BE64938E
	for <lists+netfilter-devel@lfdr.de>; Sun, 11 Dec 2022 11:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiLKKMZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 11 Dec 2022 05:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiLKKMS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 11 Dec 2022 05:12:18 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51BA9CE3C;
        Sun, 11 Dec 2022 02:12:17 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Subject: [PATCH net-next 08/12] ipvs: use common functions for stats allocation
Date:   Sun, 11 Dec 2022 11:12:00 +0100
Message-Id: <20221211101204.1751-9-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221211101204.1751-1-pablo@netfilter.org>
References: <20221211101204.1751-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Julian Anastasov <ja@ssi.bg>

Move alloc_percpu/free_percpu logic in new functions

Signed-off-by: Julian Anastasov <ja@ssi.bg>
Cc: yunhong-cgl jiang <xintian1976@gmail.com>
Cc: "dust.li" <dust.li@linux.alibaba.com>
Reviewed-by: Jiri Wiesner <jwiesner@suse.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/ip_vs.h            |  5 ++
 net/netfilter/ipvs/ip_vs_ctl.c | 96 +++++++++++++++++++---------------
 2 files changed, 60 insertions(+), 41 deletions(-)

diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index bd8ae137e43b..e5582c01a4a3 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -410,6 +410,11 @@ struct ip_vs_stats_rcu {
 	struct rcu_head		rcu_head;
 };
 
+int ip_vs_stats_init_alloc(struct ip_vs_stats *s);
+struct ip_vs_stats *ip_vs_stats_alloc(void);
+void ip_vs_stats_release(struct ip_vs_stats *stats);
+void ip_vs_stats_free(struct ip_vs_stats *stats);
+
 struct dst_entry;
 struct iphdr;
 struct ip_vs_conn;
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 9016b641ae52..ec6db864ac36 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -471,7 +471,7 @@ __ip_vs_bind_svc(struct ip_vs_dest *dest, struct ip_vs_service *svc)
 
 static void ip_vs_service_free(struct ip_vs_service *svc)
 {
-	free_percpu(svc->stats.cpustats);
+	ip_vs_stats_release(&svc->stats);
 	kfree(svc);
 }
 
@@ -782,7 +782,7 @@ static void ip_vs_dest_rcu_free(struct rcu_head *head)
 	struct ip_vs_dest *dest;
 
 	dest = container_of(head, struct ip_vs_dest, rcu_head);
-	free_percpu(dest->stats.cpustats);
+	ip_vs_stats_release(&dest->stats);
 	ip_vs_dest_put_and_free(dest);
 }
 
@@ -822,7 +822,7 @@ static void ip_vs_stats_rcu_free(struct rcu_head *head)
 						  struct ip_vs_stats_rcu,
 						  rcu_head);
 
-	free_percpu(rs->s.cpustats);
+	ip_vs_stats_release(&rs->s);
 	kfree(rs);
 }
 
@@ -879,6 +879,47 @@ ip_vs_zero_stats(struct ip_vs_stats *stats)
 	spin_unlock_bh(&stats->lock);
 }
 
+/* Allocate fields after kzalloc */
+int ip_vs_stats_init_alloc(struct ip_vs_stats *s)
+{
+	int i;
+
+	spin_lock_init(&s->lock);
+	s->cpustats = alloc_percpu(struct ip_vs_cpu_stats);
+	if (!s->cpustats)
+		return -ENOMEM;
+
+	for_each_possible_cpu(i) {
+		struct ip_vs_cpu_stats *cs = per_cpu_ptr(s->cpustats, i);
+
+		u64_stats_init(&cs->syncp);
+	}
+	return 0;
+}
+
+struct ip_vs_stats *ip_vs_stats_alloc(void)
+{
+	struct ip_vs_stats *s = kzalloc(sizeof(*s), GFP_KERNEL);
+
+	if (s && ip_vs_stats_init_alloc(s) >= 0)
+		return s;
+	kfree(s);
+	return NULL;
+}
+
+void ip_vs_stats_release(struct ip_vs_stats *stats)
+{
+	free_percpu(stats->cpustats);
+}
+
+void ip_vs_stats_free(struct ip_vs_stats *stats)
+{
+	if (stats) {
+		ip_vs_stats_release(stats);
+		kfree(stats);
+	}
+}
+
 /*
  *	Update a destination in the given service
  */
@@ -978,14 +1019,13 @@ static int
 ip_vs_new_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest)
 {
 	struct ip_vs_dest *dest;
-	unsigned int atype, i;
+	unsigned int atype;
+	int ret;
 
 	EnterFunction(2);
 
 #ifdef CONFIG_IP_VS_IPV6
 	if (udest->af == AF_INET6) {
-		int ret;
-
 		atype = ipv6_addr_type(&udest->addr.in6);
 		if ((!(atype & IPV6_ADDR_UNICAST) ||
 			atype & IPV6_ADDR_LINKLOCAL) &&
@@ -1007,16 +1047,10 @@ ip_vs_new_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest)
 	if (dest == NULL)
 		return -ENOMEM;
 
-	dest->stats.cpustats = alloc_percpu(struct ip_vs_cpu_stats);
-	if (!dest->stats.cpustats)
+	ret = ip_vs_stats_init_alloc(&dest->stats);
+	if (ret < 0)
 		goto err_alloc;
 
-	for_each_possible_cpu(i) {
-		struct ip_vs_cpu_stats *ip_vs_dest_stats;
-		ip_vs_dest_stats = per_cpu_ptr(dest->stats.cpustats, i);
-		u64_stats_init(&ip_vs_dest_stats->syncp);
-	}
-
 	dest->af = udest->af;
 	dest->protocol = svc->protocol;
 	dest->vaddr = svc->addr;
@@ -1032,7 +1066,6 @@ ip_vs_new_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest)
 
 	INIT_HLIST_NODE(&dest->d_list);
 	spin_lock_init(&dest->dst_lock);
-	spin_lock_init(&dest->stats.lock);
 	__ip_vs_update_dest(svc, dest, udest, 1);
 
 	LeaveFunction(2);
@@ -1040,7 +1073,7 @@ ip_vs_new_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest)
 
 err_alloc:
 	kfree(dest);
-	return -ENOMEM;
+	return ret;
 }
 
 
@@ -1299,7 +1332,7 @@ static int
 ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 		  struct ip_vs_service **svc_p)
 {
-	int ret = 0, i;
+	int ret = 0;
 	struct ip_vs_scheduler *sched = NULL;
 	struct ip_vs_pe *pe = NULL;
 	struct ip_vs_service *svc = NULL;
@@ -1359,18 +1392,9 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 		ret = -ENOMEM;
 		goto out_err;
 	}
-	svc->stats.cpustats = alloc_percpu(struct ip_vs_cpu_stats);
-	if (!svc->stats.cpustats) {
-		ret = -ENOMEM;
+	ret = ip_vs_stats_init_alloc(&svc->stats);
+	if (ret < 0)
 		goto out_err;
-	}
-
-	for_each_possible_cpu(i) {
-		struct ip_vs_cpu_stats *ip_vs_stats;
-		ip_vs_stats = per_cpu_ptr(svc->stats.cpustats, i);
-		u64_stats_init(&ip_vs_stats->syncp);
-	}
-
 
 	/* I'm the first user of the service */
 	atomic_set(&svc->refcnt, 0);
@@ -1387,7 +1411,6 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 
 	INIT_LIST_HEAD(&svc->destinations);
 	spin_lock_init(&svc->sched_lock);
-	spin_lock_init(&svc->stats.lock);
 
 	/* Bind the scheduler */
 	if (sched) {
@@ -4166,7 +4189,7 @@ static struct notifier_block ip_vs_dst_notifier = {
 
 int __net_init ip_vs_control_net_init(struct netns_ipvs *ipvs)
 {
-	int i, idx;
+	int idx;
 
 	/* Initialize rs_table */
 	for (idx = 0; idx < IP_VS_RTAB_SIZE; idx++)
@@ -4183,18 +4206,9 @@ int __net_init ip_vs_control_net_init(struct netns_ipvs *ipvs)
 	ipvs->tot_stats = kzalloc(sizeof(*ipvs->tot_stats), GFP_KERNEL);
 	if (!ipvs->tot_stats)
 		return -ENOMEM;
-	ipvs->tot_stats->s.cpustats = alloc_percpu(struct ip_vs_cpu_stats);
-	if (!ipvs->tot_stats->s.cpustats)
+	if (ip_vs_stats_init_alloc(&ipvs->tot_stats->s) < 0)
 		goto err_tot_stats;
 
-	for_each_possible_cpu(i) {
-		struct ip_vs_cpu_stats *ipvs_tot_stats;
-		ipvs_tot_stats = per_cpu_ptr(ipvs->tot_stats->s.cpustats, i);
-		u64_stats_init(&ipvs_tot_stats->syncp);
-	}
-
-	spin_lock_init(&ipvs->tot_stats->s.lock);
-
 #ifdef CONFIG_PROC_FS
 	if (!proc_create_net("ip_vs", 0, ipvs->net->proc_net,
 			     &ip_vs_info_seq_ops, sizeof(struct ip_vs_iter)))
@@ -4225,7 +4239,7 @@ int __net_init ip_vs_control_net_init(struct netns_ipvs *ipvs)
 
 err_vs:
 #endif
-	free_percpu(ipvs->tot_stats->s.cpustats);
+	ip_vs_stats_release(&ipvs->tot_stats->s);
 
 err_tot_stats:
 	kfree(ipvs->tot_stats);
-- 
2.30.2

