Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8B063481C
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Nov 2022 21:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiKVU1Y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Nov 2022 15:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKVU1X (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:27:23 -0500
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D120286D6;
        Tue, 22 Nov 2022 12:27:20 -0800 (PST)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 382EA267AB;
        Tue, 22 Nov 2022 22:27:12 +0200 (EET)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 4B70025FFB;
        Tue, 22 Nov 2022 18:47:52 +0200 (EET)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 091383C0440;
        Tue, 22 Nov 2022 18:47:17 +0200 (EET)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 2AMGlH73066801;
        Tue, 22 Nov 2022 18:47:17 +0200
Received: (from root@localhost)
        by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 2AMGlHGh066800;
        Tue, 22 Nov 2022 18:47:17 +0200
From:   Julian Anastasov <ja@ssi.bg>
To:     Simon Horman <horms@verge.net.au>
Cc:     lvs-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Jiri Wiesner <jwiesner@suse.de>,
        yunhong-cgl jiang <xintian1976@gmail.com>,
        dust.li@linux.alibaba.com
Subject: [PATCHv7 4/6] ipvs: use kthreads for stats estimation
Date:   Tue, 22 Nov 2022 18:46:02 +0200
Message-Id: <20221122164604.66621-5-ja@ssi.bg>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122164604.66621-1-ja@ssi.bg>
References: <20221122164604.66621-1-ja@ssi.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Estimating all entries in single list in timer context
by single CPU causes large latency with multiple IPVS rules
as reported in [1], [2], [3].

Spread the estimator structures in multiple chains and
use kthread(s) for the estimation. The chains are processed
in multiple (50) timer ticks to ensure the 2-second interval
between estimations with some accuracy. Every chain is
processed under RCU lock.

Every kthread works over its own data structure and all
such contexts are attached to array. The contexts can be
preserved while the kthread tasks are stopped or restarted.
When estimators are removed, unused kthread contexts are
released and the slots in array are left empty.

First kthread determines parameters to use, eg. maximum
number of estimators to process per kthread based on
chain's length (chain_max), allowing sub-100us cond_resched
rate and estimation taking up to 1/8 of the CPU capacity
to avoid any problems if chain_max is not correctly
calculated.

chain_max is calculated taking into account factors
such as CPU speed and memory/cache speed where the
cache_factor (4) is selected from real tests with
current generation of CPU/NUMA configurations to
correct the difference in CPU usage between
cached (during calc phase) and non-cached (working) state
of the estimated per-cpu data.

First kthread also plays the role of distributor of
added estimators to all kthreads, keeping low the
time to add estimators. The optimization is based on
the fact that newly added estimator should be estimated
after 2 seconds, so we have the time to offload the
adding to chain from controlling process to kthread 0.

The allocated kthread context may grow from 1 to 50
allocated structures for timer ticks which saves memory for
setups with small number of estimators.

We also add delayed work est_reload_work that will
make sure the kthread tasks are properly started/stopped.

ip_vs_start_estimator() is changed to report errors
which allows to safely store the estimators in
allocated structures.

Many thanks to Jiri Wiesner for his valuable comments
and for spending a lot of time reviewing and testing
the changes on different platforms with 48-256 CPUs and
1-8 NUMA nodes under different cpufreq governors.

[1] Report from Yunhong Jiang:
https://lore.kernel.org/netdev/D25792C1-1B89-45DE-9F10-EC350DC04ADC@gmail.com/
[2]
https://marc.info/?l=linux-virtual-server&m=159679809118027&w=2
[3] Report from Dust:
https://archive.linuxvirtualserver.org/html/lvs-devel/2020-12/msg00000.html

Signed-off-by: Julian Anastasov <ja@ssi.bg>
Cc: yunhong-cgl jiang <xintian1976@gmail.com>
Cc: "dust.li" <dust.li@linux.alibaba.com>
Reviewed-by: Jiri Wiesner <jwiesner@suse.de>
Tested-by: Jiri Wiesner <jwiesner@suse.de>
---
 include/net/ip_vs.h            |  88 +++-
 net/netfilter/ipvs/ip_vs_ctl.c | 126 ++++-
 net/netfilter/ipvs/ip_vs_est.c | 876 ++++++++++++++++++++++++++++++---
 3 files changed, 990 insertions(+), 100 deletions(-)

diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index a4d44138c2a8..04960dc6228f 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -42,6 +42,8 @@ static inline struct netns_ipvs *net_ipvs(struct net* net)
 /* Connections' size value needed by ip_vs_ctl.c */
 extern int ip_vs_conn_tab_size;
 
+extern struct mutex __ip_vs_mutex;
+
 struct ip_vs_iphdr {
 	int hdr_flags;	/* ipvs flags */
 	__u32 off;	/* Where IP or IPv4 header starts */
@@ -365,7 +367,7 @@ struct ip_vs_cpu_stats {
 
 /* IPVS statistics objects */
 struct ip_vs_estimator {
-	struct list_head	list;
+	struct hlist_node	list;
 
 	u64			last_inbytes;
 	u64			last_outbytes;
@@ -378,6 +380,10 @@ struct ip_vs_estimator {
 	u64			outpps;
 	u64			inbps;
 	u64			outbps;
+
+	s32			ktid:16,	/* kthread ID, -1=temp list */
+				ktrow:8,	/* row/tick ID for kthread */
+				ktcid:8;	/* chain ID for kthread tick */
 };
 
 /*
@@ -415,6 +421,66 @@ struct ip_vs_stats *ip_vs_stats_alloc(void);
 void ip_vs_stats_release(struct ip_vs_stats *stats);
 void ip_vs_stats_free(struct ip_vs_stats *stats);
 
+/* Process estimators in multiple timer ticks (20/50/100, see ktrow) */
+#define IPVS_EST_NTICKS		50
+/* Estimation uses a 2-second period containing ticks (in jiffies) */
+#define IPVS_EST_TICK		((2 * HZ) / IPVS_EST_NTICKS)
+
+/* Limit of CPU load per kthread (8 for 12.5%), ratio of CPU capacity (1/C).
+ * Value of 4 and above ensures kthreads will take work without exceeding
+ * the CPU capacity under different circumstances.
+ */
+#define IPVS_EST_LOAD_DIVISOR	8
+
+/* Kthreads should not have work that exceeds the CPU load above 50% */
+#define IPVS_EST_CPU_KTHREADS	(IPVS_EST_LOAD_DIVISOR / 2)
+
+/* Desired number of chains per timer tick (chain load factor in 100us units),
+ * 48=4.8ms of 40ms tick (12% CPU usage):
+ * 2 sec * 1000 ms in sec * 10 (100us in ms) / 8 (12.5%) / 50
+ */
+#define IPVS_EST_CHAIN_FACTOR	\
+	ALIGN_DOWN(2 * 1000 * 10 / IPVS_EST_LOAD_DIVISOR / IPVS_EST_NTICKS, 8)
+
+/* Compiled number of chains per tick
+ * The defines should match cond_resched_rcu
+ */
+#if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
+#define IPVS_EST_TICK_CHAINS	IPVS_EST_CHAIN_FACTOR
+#else
+#define IPVS_EST_TICK_CHAINS	1
+#endif
+
+#if IPVS_EST_NTICKS > 127
+#error Too many timer ticks for ktrow
+#endif
+
+/* Multiple chains processed in same tick */
+struct ip_vs_est_tick_data {
+	struct hlist_head	chains[IPVS_EST_TICK_CHAINS];
+	DECLARE_BITMAP(present, IPVS_EST_TICK_CHAINS);
+	DECLARE_BITMAP(full, IPVS_EST_TICK_CHAINS);
+	int			chain_len[IPVS_EST_TICK_CHAINS];
+};
+
+/* Context for estimation kthread */
+struct ip_vs_est_kt_data {
+	struct netns_ipvs	*ipvs;
+	struct task_struct	*task;		/* task if running */
+	struct ip_vs_est_tick_data __rcu *ticks[IPVS_EST_NTICKS];
+	DECLARE_BITMAP(avail, IPVS_EST_NTICKS);	/* tick has space for ests */
+	unsigned long		est_timer;	/* estimation timer (jiffies) */
+	struct ip_vs_stats	*calc_stats;	/* Used for calculation */
+	int			tick_len[IPVS_EST_NTICKS];	/* est count */
+	int			id;		/* ktid per netns */
+	int			chain_max;	/* max ests per tick chain */
+	int			tick_max;	/* max ests per tick */
+	int			est_count;	/* attached ests to kthread */
+	int			est_max_count;	/* max ests per kthread */
+	int			add_row;	/* row for new ests */
+	int			est_row;	/* estimated row */
+};
+
 struct dst_entry;
 struct iphdr;
 struct ip_vs_conn;
@@ -953,9 +1019,17 @@ struct netns_ipvs {
 	struct ctl_table_header	*lblcr_ctl_header;
 	struct ctl_table	*lblcr_ctl_table;
 	/* ip_vs_est */
-	struct list_head	est_list;	/* estimator list */
-	spinlock_t		est_lock;
-	struct timer_list	est_timer;	/* Estimation timer */
+	struct delayed_work	est_reload_work;/* Reload kthread tasks */
+	struct mutex		est_mutex;	/* protect kthread tasks */
+	struct hlist_head	est_temp_list;	/* Ests during calc phase */
+	struct ip_vs_est_kt_data **est_kt_arr;	/* Array of kthread data ptrs */
+	unsigned long		est_max_threads;/* Hard limit of kthreads */
+	int			est_calc_phase;	/* Calculation phase */
+	int			est_chain_max;	/* Calculated chain_max */
+	int			est_kt_count;	/* Allocated ptrs */
+	int			est_add_ktid;	/* ktid where to add ests */
+	atomic_t		est_genid;	/* kthreads reload genid */
+	atomic_t		est_genid_done;	/* applied genid */
 	/* ip_vs_sync */
 	spinlock_t		sync_lock;
 	struct ipvs_master_sync_state *ms;
@@ -1486,10 +1560,14 @@ int stop_sync_thread(struct netns_ipvs *ipvs, int state);
 void ip_vs_sync_conn(struct netns_ipvs *ipvs, struct ip_vs_conn *cp, int pkts);
 
 /* IPVS rate estimator prototypes (from ip_vs_est.c) */
-void ip_vs_start_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats);
+int ip_vs_start_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats);
 void ip_vs_stop_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats);
 void ip_vs_zero_estimator(struct ip_vs_stats *stats);
 void ip_vs_read_estimator(struct ip_vs_kstats *dst, struct ip_vs_stats *stats);
+void ip_vs_est_reload_start(struct netns_ipvs *ipvs);
+int ip_vs_est_kthread_start(struct netns_ipvs *ipvs,
+			    struct ip_vs_est_kt_data *kd);
+void ip_vs_est_kthread_stop(struct ip_vs_est_kt_data *kd);
 
 /* Various IPVS packet transmitters (from ip_vs_xmit.c) */
 int ip_vs_null_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 5f9cc2e7ba71..c41a5392edc9 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -49,8 +49,7 @@
 
 MODULE_ALIAS_GENL_FAMILY(IPVS_GENL_NAME);
 
-/* semaphore for IPVS sockopts. And, [gs]etsockopt may sleep. */
-static DEFINE_MUTEX(__ip_vs_mutex);
+DEFINE_MUTEX(__ip_vs_mutex); /* Serialize configuration with sockopt/netlink */
 
 /* sysctl variables */
 
@@ -241,6 +240,47 @@ static void defense_work_handler(struct work_struct *work)
 }
 #endif
 
+static void est_reload_work_handler(struct work_struct *work)
+{
+	struct netns_ipvs *ipvs =
+		container_of(work, struct netns_ipvs, est_reload_work.work);
+	int genid_done = atomic_read(&ipvs->est_genid_done);
+	unsigned long delay = HZ / 10;	/* repeat startups after failure */
+	bool repeat = false;
+	int genid;
+	int id;
+
+	mutex_lock(&ipvs->est_mutex);
+	genid = atomic_read(&ipvs->est_genid);
+	for (id = 0; id < ipvs->est_kt_count; id++) {
+		struct ip_vs_est_kt_data *kd = ipvs->est_kt_arr[id];
+
+		/* netns clean up started, abort delayed work */
+		if (!ipvs->enable)
+			goto unlock;
+		if (!kd)
+			continue;
+		/* New config ? Stop kthread tasks */
+		if (genid != genid_done)
+			ip_vs_est_kthread_stop(kd);
+		if (!kd->task) {
+			/* Do not start kthreads above 0 in calc phase */
+			if ((!id || !ipvs->est_calc_phase) &&
+			    ip_vs_est_kthread_start(ipvs, kd) < 0)
+				repeat = true;
+		}
+	}
+
+	atomic_set(&ipvs->est_genid_done, genid);
+
+	if (repeat)
+		queue_delayed_work(system_long_wq, &ipvs->est_reload_work,
+				   delay);
+
+unlock:
+	mutex_unlock(&ipvs->est_mutex);
+}
+
 int
 ip_vs_use_count_inc(void)
 {
@@ -831,7 +871,7 @@ ip_vs_copy_stats(struct ip_vs_kstats *dst, struct ip_vs_stats *src)
 {
 #define IP_VS_SHOW_STATS_COUNTER(c) dst->c = src->kstats.c - src->kstats0.c
 
-	spin_lock_bh(&src->lock);
+	spin_lock(&src->lock);
 
 	IP_VS_SHOW_STATS_COUNTER(conns);
 	IP_VS_SHOW_STATS_COUNTER(inpkts);
@@ -841,7 +881,7 @@ ip_vs_copy_stats(struct ip_vs_kstats *dst, struct ip_vs_stats *src)
 
 	ip_vs_read_estimator(dst, src);
 
-	spin_unlock_bh(&src->lock);
+	spin_unlock(&src->lock);
 }
 
 static void
@@ -862,7 +902,7 @@ ip_vs_export_stats_user(struct ip_vs_stats_user *dst, struct ip_vs_kstats *src)
 static void
 ip_vs_zero_stats(struct ip_vs_stats *stats)
 {
-	spin_lock_bh(&stats->lock);
+	spin_lock(&stats->lock);
 
 	/* get current counters as zero point, rates are zeroed */
 
@@ -876,7 +916,7 @@ ip_vs_zero_stats(struct ip_vs_stats *stats)
 
 	ip_vs_zero_estimator(stats);
 
-	spin_unlock_bh(&stats->lock);
+	spin_unlock(&stats->lock);
 }
 
 /* Allocate fields after kzalloc */
@@ -998,7 +1038,6 @@ __ip_vs_update_dest(struct ip_vs_service *svc, struct ip_vs_dest *dest,
 	spin_unlock_bh(&dest->dst_lock);
 
 	if (add) {
-		ip_vs_start_estimator(svc->ipvs, &dest->stats);
 		list_add_rcu(&dest->n_list, &svc->destinations);
 		svc->num_dests++;
 		sched = rcu_dereference_protected(svc->scheduler, 1);
@@ -1051,6 +1090,10 @@ ip_vs_new_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest)
 	if (ret < 0)
 		goto err_alloc;
 
+	ret = ip_vs_start_estimator(svc->ipvs, &dest->stats);
+	if (ret < 0)
+		goto err_stats;
+
 	dest->af = udest->af;
 	dest->protocol = svc->protocol;
 	dest->vaddr = svc->addr;
@@ -1071,6 +1114,9 @@ ip_vs_new_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest)
 	LeaveFunction(2);
 	return 0;
 
+err_stats:
+	ip_vs_stats_release(&dest->stats);
+
 err_alloc:
 	kfree(dest);
 	return ret;
@@ -1135,14 +1181,18 @@ ip_vs_add_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest)
 			      IP_VS_DBG_ADDR(svc->af, &dest->vaddr),
 			      ntohs(dest->vport));
 
+		ret = ip_vs_start_estimator(svc->ipvs, &dest->stats);
+		if (ret < 0)
+			goto err;
 		__ip_vs_update_dest(svc, dest, udest, 1);
-		ret = 0;
 	} else {
 		/*
 		 * Allocate and initialize the dest structure
 		 */
 		ret = ip_vs_new_dest(svc, udest);
 	}
+
+err:
 	LeaveFunction(2);
 
 	return ret;
@@ -1420,6 +1470,10 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 		sched = NULL;
 	}
 
+	ret = ip_vs_start_estimator(ipvs, &svc->stats);
+	if (ret < 0)
+		goto out_err;
+
 	/* Bind the ct retriever */
 	RCU_INIT_POINTER(svc->pe, pe);
 	pe = NULL;
@@ -1432,8 +1486,6 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 	if (svc->pe && svc->pe->conn_out)
 		atomic_inc(&ipvs->conn_out_counter);
 
-	ip_vs_start_estimator(ipvs, &svc->stats);
-
 	/* Count only IPv4 services for old get/setsockopt interface */
 	if (svc->af == AF_INET)
 		ipvs->num_services++;
@@ -1444,8 +1496,15 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 	ip_vs_svc_hash(svc);
 
 	*svc_p = svc;
-	/* Now there is a service - full throttle */
-	ipvs->enable = 1;
+
+	if (!ipvs->enable) {
+		/* Now there is a service - full throttle */
+		ipvs->enable = 1;
+
+		/* Start estimation for first time */
+		ip_vs_est_reload_start(ipvs);
+	}
+
 	return 0;
 
 
@@ -4065,13 +4124,16 @@ static void ip_vs_genl_unregister(void)
 static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 {
 	struct net *net = ipvs->net;
-	int idx;
 	struct ctl_table *tbl;
+	int idx, ret;
 
 	atomic_set(&ipvs->dropentry, 0);
 	spin_lock_init(&ipvs->dropentry_lock);
 	spin_lock_init(&ipvs->droppacket_lock);
 	spin_lock_init(&ipvs->securetcp_lock);
+	INIT_DELAYED_WORK(&ipvs->defense_work, defense_work_handler);
+	INIT_DELAYED_WORK(&ipvs->expire_nodest_conn_work,
+			  expire_nodest_conn_handler);
 
 	if (!net_eq(net, &init_net)) {
 		tbl = kmemdup(vs_vars, sizeof(vs_vars), GFP_KERNEL);
@@ -4139,24 +4201,27 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 		tbl[idx++].mode = 0444;
 #endif
 
+	ret = -ENOMEM;
 	ipvs->sysctl_hdr = register_net_sysctl(net, "net/ipv4/vs", tbl);
-	if (ipvs->sysctl_hdr == NULL) {
-		if (!net_eq(net, &init_net))
-			kfree(tbl);
-		return -ENOMEM;
-	}
+	if (!ipvs->sysctl_hdr)
+		goto err;
 	ipvs->sysctl_tbl = tbl;
+
+	ret = ip_vs_start_estimator(ipvs, &ipvs->tot_stats->s);
+	if (ret < 0)
+		goto err;
+
 	/* Schedule defense work */
-	INIT_DELAYED_WORK(&ipvs->defense_work, defense_work_handler);
 	queue_delayed_work(system_long_wq, &ipvs->defense_work,
 			   DEFENSE_TIMER_PERIOD);
 
-	/* Init delayed work for expiring no dest conn */
-	INIT_DELAYED_WORK(&ipvs->expire_nodest_conn_work,
-			  expire_nodest_conn_handler);
-
-	ip_vs_start_estimator(ipvs, &ipvs->tot_stats->s);
 	return 0;
+
+err:
+	unregister_net_sysctl_table(ipvs->sysctl_hdr);
+	if (!net_eq(net, &init_net))
+		kfree(tbl);
+	return ret;
 }
 
 static void __net_exit ip_vs_control_net_cleanup_sysctl(struct netns_ipvs *ipvs)
@@ -4189,6 +4254,7 @@ static struct notifier_block ip_vs_dst_notifier = {
 
 int __net_init ip_vs_control_net_init(struct netns_ipvs *ipvs)
 {
+	int ret = -ENOMEM;
 	int idx;
 
 	/* Initialize rs_table */
@@ -4202,10 +4268,12 @@ int __net_init ip_vs_control_net_init(struct netns_ipvs *ipvs)
 	atomic_set(&ipvs->nullsvc_counter, 0);
 	atomic_set(&ipvs->conn_out_counter, 0);
 
+	INIT_DELAYED_WORK(&ipvs->est_reload_work, est_reload_work_handler);
+
 	/* procfs stats */
 	ipvs->tot_stats = kzalloc(sizeof(*ipvs->tot_stats), GFP_KERNEL);
 	if (!ipvs->tot_stats)
-		return -ENOMEM;
+		goto out;
 	if (ip_vs_stats_init_alloc(&ipvs->tot_stats->s) < 0)
 		goto err_tot_stats;
 
@@ -4222,7 +4290,8 @@ int __net_init ip_vs_control_net_init(struct netns_ipvs *ipvs)
 		goto err_percpu;
 #endif
 
-	if (ip_vs_control_net_init_sysctl(ipvs))
+	ret = ip_vs_control_net_init_sysctl(ipvs);
+	if (ret < 0)
 		goto err;
 
 	return 0;
@@ -4243,13 +4312,16 @@ int __net_init ip_vs_control_net_init(struct netns_ipvs *ipvs)
 
 err_tot_stats:
 	kfree(ipvs->tot_stats);
-	return -ENOMEM;
+
+out:
+	return ret;
 }
 
 void __net_exit ip_vs_control_net_cleanup(struct netns_ipvs *ipvs)
 {
 	ip_vs_trash_cleanup(ipvs);
 	ip_vs_control_net_cleanup_sysctl(ipvs);
+	cancel_delayed_work_sync(&ipvs->est_reload_work);
 #ifdef CONFIG_PROC_FS
 	remove_proc_entry("ip_vs_stats_percpu", ipvs->net->proc_net);
 	remove_proc_entry("ip_vs_stats", ipvs->net->proc_net);
diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
index f53150d82a92..2fb6c097437c 100644
--- a/net/netfilter/ipvs/ip_vs_est.c
+++ b/net/netfilter/ipvs/ip_vs_est.c
@@ -30,9 +30,6 @@
   long interval, it is easy to implement a user level daemon which
   periodically reads those statistical counters and measure rate.
 
-  Currently, the measurement is activated by slow timer handler. Hope
-  this measurement will not introduce too much load.
-
   We measure rate during the last 8 seconds every 2 seconds:
 
     avgrate = avgrate*(1-W) + rate*W
@@ -47,68 +44,76 @@
     to 32-bit values for conns, packets, bps, cps and pps.
 
   * A lot of code is taken from net/core/gen_estimator.c
- */
-
 
-/*
- * Make a summary from each cpu
+  KEY POINTS:
+  - cpustats counters are updated per-cpu in SoftIRQ context with BH disabled
+  - kthreads read the cpustats to update the estimators (svcs, dests, total)
+  - the states of estimators can be read (get stats) or modified (zero stats)
+    from processes
+
+  KTHREADS:
+  - estimators are added initially to est_temp_list and later kthread 0
+    distributes them to one or many kthreads for estimation
+  - kthread contexts are created and attached to array
+  - the kthread tasks are started when first service is added, before that
+    the total stats are not estimated
+  - the kthread context holds lists with estimators (chains) which are
+    processed every 2 seconds
+  - as estimators can be added dynamically and in bursts, we try to spread
+    them to multiple chains which are estimated at different time
+  - on start, kthread 0 enters calculation phase to determine the chain limits
+    and the limit of estimators per kthread
+  - est_add_ktid: ktid where to add new ests, can point to empty slot where
+    we should add kt data
  */
-static void ip_vs_read_cpu_stats(struct ip_vs_kstats *sum,
-				 struct ip_vs_cpu_stats __percpu *stats)
-{
-	int i;
-	bool add = false;
-
-	for_each_possible_cpu(i) {
-		struct ip_vs_cpu_stats *s = per_cpu_ptr(stats, i);
-		unsigned int start;
-		u64 conns, inpkts, outpkts, inbytes, outbytes;
 
-		if (add) {
-			do {
-				start = u64_stats_fetch_begin(&s->syncp);
-				conns = u64_stats_read(&s->cnt.conns);
-				inpkts = u64_stats_read(&s->cnt.inpkts);
-				outpkts = u64_stats_read(&s->cnt.outpkts);
-				inbytes = u64_stats_read(&s->cnt.inbytes);
-				outbytes = u64_stats_read(&s->cnt.outbytes);
-			} while (u64_stats_fetch_retry(&s->syncp, start));
-			sum->conns += conns;
-			sum->inpkts += inpkts;
-			sum->outpkts += outpkts;
-			sum->inbytes += inbytes;
-			sum->outbytes += outbytes;
-		} else {
-			add = true;
-			do {
-				start = u64_stats_fetch_begin(&s->syncp);
-				sum->conns = u64_stats_read(&s->cnt.conns);
-				sum->inpkts = u64_stats_read(&s->cnt.inpkts);
-				sum->outpkts = u64_stats_read(&s->cnt.outpkts);
-				sum->inbytes = u64_stats_read(&s->cnt.inbytes);
-				sum->outbytes = u64_stats_read(&s->cnt.outbytes);
-			} while (u64_stats_fetch_retry(&s->syncp, start));
-		}
-	}
-}
+static struct lock_class_key __ipvs_est_key;
 
+static void ip_vs_est_calc_phase(struct netns_ipvs *ipvs);
+static void ip_vs_est_drain_temp_list(struct netns_ipvs *ipvs);
 
-static void estimation_timer(struct timer_list *t)
+static void ip_vs_chain_estimation(struct hlist_head *chain)
 {
 	struct ip_vs_estimator *e;
+	struct ip_vs_cpu_stats *c;
 	struct ip_vs_stats *s;
 	u64 rate;
-	struct netns_ipvs *ipvs = from_timer(ipvs, t, est_timer);
 
-	if (!sysctl_run_estimation(ipvs))
-		goto skip;
+	hlist_for_each_entry_rcu(e, chain, list) {
+		u64 conns, inpkts, outpkts, inbytes, outbytes;
+		u64 kconns = 0, kinpkts = 0, koutpkts = 0;
+		u64 kinbytes = 0, koutbytes = 0;
+		unsigned int start;
+		int i;
+
+		if (kthread_should_stop())
+			break;
 
-	spin_lock(&ipvs->est_lock);
-	list_for_each_entry(e, &ipvs->est_list, list) {
 		s = container_of(e, struct ip_vs_stats, est);
+		for_each_possible_cpu(i) {
+			c = per_cpu_ptr(s->cpustats, i);
+			do {
+				start = u64_stats_fetch_begin(&c->syncp);
+				conns = u64_stats_read(&c->cnt.conns);
+				inpkts = u64_stats_read(&c->cnt.inpkts);
+				outpkts = u64_stats_read(&c->cnt.outpkts);
+				inbytes = u64_stats_read(&c->cnt.inbytes);
+				outbytes = u64_stats_read(&c->cnt.outbytes);
+			} while (u64_stats_fetch_retry(&c->syncp, start));
+			kconns += conns;
+			kinpkts += inpkts;
+			koutpkts += outpkts;
+			kinbytes += inbytes;
+			koutbytes += outbytes;
+		}
 
 		spin_lock(&s->lock);
-		ip_vs_read_cpu_stats(&s->kstats, s->cpustats);
+
+		s->kstats.conns = kconns;
+		s->kstats.inpkts = kinpkts;
+		s->kstats.outpkts = koutpkts;
+		s->kstats.inbytes = kinbytes;
+		s->kstats.outbytes = koutbytes;
 
 		/* scaled by 2^10, but divided 2 seconds */
 		rate = (s->kstats.conns - e->last_conns) << 9;
@@ -133,30 +138,754 @@ static void estimation_timer(struct timer_list *t)
 		e->outbps += ((s64)rate - (s64)e->outbps) >> 2;
 		spin_unlock(&s->lock);
 	}
-	spin_unlock(&ipvs->est_lock);
+}
 
-skip:
-	mod_timer(&ipvs->est_timer, jiffies + 2*HZ);
+static void ip_vs_tick_estimation(struct ip_vs_est_kt_data *kd, int row)
+{
+	struct ip_vs_est_tick_data *td;
+	int cid;
+
+	rcu_read_lock();
+	td = rcu_dereference(kd->ticks[row]);
+	if (!td)
+		goto out;
+	for_each_set_bit(cid, td->present, IPVS_EST_TICK_CHAINS) {
+		if (kthread_should_stop())
+			break;
+		ip_vs_chain_estimation(&td->chains[cid]);
+		cond_resched_rcu();
+		td = rcu_dereference(kd->ticks[row]);
+		if (!td)
+			break;
+	}
+
+out:
+	rcu_read_unlock();
 }
 
-void ip_vs_start_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
+static int ip_vs_estimation_kthread(void *data)
 {
-	struct ip_vs_estimator *est = &stats->est;
+	struct ip_vs_est_kt_data *kd = data;
+	struct netns_ipvs *ipvs = kd->ipvs;
+	int row = kd->est_row;
+	unsigned long now;
+	int id = kd->id;
+	long gap;
+
+	if (id > 0) {
+		if (!ipvs->est_chain_max)
+			return 0;
+	} else {
+		if (!ipvs->est_chain_max) {
+			ipvs->est_calc_phase = 1;
+			/* commit est_calc_phase before reading est_genid */
+			smp_mb();
+		}
+
+		/* kthread 0 will handle the calc phase */
+		if (ipvs->est_calc_phase)
+			ip_vs_est_calc_phase(ipvs);
+	}
+
+	while (1) {
+		if (!id && !hlist_empty(&ipvs->est_temp_list))
+			ip_vs_est_drain_temp_list(ipvs);
+		set_current_state(TASK_IDLE);
+		if (kthread_should_stop())
+			break;
+
+		/* before estimation, check if we should sleep */
+		now = jiffies;
+		gap = kd->est_timer - now;
+		if (gap > 0) {
+			if (gap > IPVS_EST_TICK) {
+				kd->est_timer = now - IPVS_EST_TICK;
+				gap = IPVS_EST_TICK;
+			}
+			schedule_timeout(gap);
+		} else {
+			__set_current_state(TASK_RUNNING);
+			if (gap < -8 * IPVS_EST_TICK)
+				kd->est_timer = now;
+		}
+
+		if (sysctl_run_estimation(ipvs) && kd->tick_len[row])
+			ip_vs_tick_estimation(kd, row);
+
+		row++;
+		if (row >= IPVS_EST_NTICKS)
+			row = 0;
+		WRITE_ONCE(kd->est_row, row);
+		kd->est_timer += IPVS_EST_TICK;
+	}
+	__set_current_state(TASK_RUNNING);
+
+	return 0;
+}
+
+/* Schedule stop/start for kthread tasks */
+void ip_vs_est_reload_start(struct netns_ipvs *ipvs)
+{
+	/* Ignore reloads before first service is added */
+	if (!ipvs->enable)
+		return;
+	/* Bump the kthread configuration genid */
+	atomic_inc(&ipvs->est_genid);
+	queue_delayed_work(system_long_wq, &ipvs->est_reload_work, 0);
+}
+
+/* Start kthread task with current configuration */
+int ip_vs_est_kthread_start(struct netns_ipvs *ipvs,
+			    struct ip_vs_est_kt_data *kd)
+{
+	unsigned long now;
+	int ret = 0;
+	long gap;
+
+	lockdep_assert_held(&ipvs->est_mutex);
+
+	if (kd->task)
+		goto out;
+	now = jiffies;
+	gap = kd->est_timer - now;
+	/* Sync est_timer if task is starting later */
+	if (abs(gap) > 4 * IPVS_EST_TICK)
+		kd->est_timer = now;
+	kd->task = kthread_create(ip_vs_estimation_kthread, kd, "ipvs-e:%d:%d",
+				  ipvs->gen, kd->id);
+	if (IS_ERR(kd->task)) {
+		ret = PTR_ERR(kd->task);
+		kd->task = NULL;
+		goto out;
+	}
+
+	pr_info("starting estimator thread %d...\n", kd->id);
+	wake_up_process(kd->task);
+
+out:
+	return ret;
+}
+
+void ip_vs_est_kthread_stop(struct ip_vs_est_kt_data *kd)
+{
+	if (kd->task) {
+		pr_info("stopping estimator thread %d...\n", kd->id);
+		kthread_stop(kd->task);
+		kd->task = NULL;
+	}
+}
+
+/* Apply parameters to kthread */
+static void ip_vs_est_set_params(struct netns_ipvs *ipvs,
+				 struct ip_vs_est_kt_data *kd)
+{
+	kd->chain_max = ipvs->est_chain_max;
+	/* We are using single chain on RCU preemption */
+	if (IPVS_EST_TICK_CHAINS == 1)
+		kd->chain_max *= IPVS_EST_CHAIN_FACTOR;
+	kd->tick_max = IPVS_EST_TICK_CHAINS * kd->chain_max;
+	kd->est_max_count = IPVS_EST_NTICKS * kd->tick_max;
+}
+
+/* Create and start estimation kthread in a free or new array slot */
+static int ip_vs_est_add_kthread(struct netns_ipvs *ipvs)
+{
+	struct ip_vs_est_kt_data *kd = NULL;
+	int id = ipvs->est_kt_count;
+	int ret = -ENOMEM;
+	void *arr = NULL;
+	int i;
+
+	if ((unsigned long)ipvs->est_kt_count >= ipvs->est_max_threads &&
+	    ipvs->enable && ipvs->est_max_threads)
+		return -EINVAL;
+
+	mutex_lock(&ipvs->est_mutex);
+
+	for (i = 0; i < id; i++) {
+		if (!ipvs->est_kt_arr[i])
+			break;
+	}
+	if (i >= id) {
+		arr = krealloc_array(ipvs->est_kt_arr, id + 1,
+				     sizeof(struct ip_vs_est_kt_data *),
+				     GFP_KERNEL);
+		if (!arr)
+			goto out;
+		ipvs->est_kt_arr = arr;
+	} else {
+		id = i;
+	}
+
+	kd = kzalloc(sizeof(*kd), GFP_KERNEL);
+	if (!kd)
+		goto out;
+	kd->ipvs = ipvs;
+	bitmap_fill(kd->avail, IPVS_EST_NTICKS);
+	kd->est_timer = jiffies;
+	kd->id = id;
+	ip_vs_est_set_params(ipvs, kd);
+
+	/* Pre-allocate stats used in calc phase */
+	if (!id && !kd->calc_stats) {
+		kd->calc_stats = ip_vs_stats_alloc();
+		if (!kd->calc_stats)
+			goto out;
+	}
+
+	/* Start kthread tasks only when services are present */
+	if (ipvs->enable) {
+		ret = ip_vs_est_kthread_start(ipvs, kd);
+		if (ret < 0)
+			goto out;
+	}
+
+	if (arr)
+		ipvs->est_kt_count++;
+	ipvs->est_kt_arr[id] = kd;
+	kd = NULL;
+	/* Use most recent kthread for new ests */
+	ipvs->est_add_ktid = id;
+	ret = 0;
+
+out:
+	mutex_unlock(&ipvs->est_mutex);
+	if (kd) {
+		ip_vs_stats_free(kd->calc_stats);
+		kfree(kd);
+	}
+
+	return ret;
+}
+
+/* Select ktid where to add new ests: available, unused or new slot */
+static void ip_vs_est_update_ktid(struct netns_ipvs *ipvs)
+{
+	int ktid, best = ipvs->est_kt_count;
+	struct ip_vs_est_kt_data *kd;
+
+	for (ktid = 0; ktid < ipvs->est_kt_count; ktid++) {
+		kd = ipvs->est_kt_arr[ktid];
+		if (kd) {
+			if (kd->est_count < kd->est_max_count) {
+				best = ktid;
+				break;
+			}
+		} else if (ktid < best) {
+			best = ktid;
+		}
+	}
+	ipvs->est_add_ktid = best;
+}
+
+/* Add estimator to current kthread (est_add_ktid) */
+static int ip_vs_enqueue_estimator(struct netns_ipvs *ipvs,
+				   struct ip_vs_estimator *est)
+{
+	struct ip_vs_est_kt_data *kd = NULL;
+	struct ip_vs_est_tick_data *td;
+	int ktid, row, crow, cid, ret;
+	int delay = est->ktrow;
+
+	BUILD_BUG_ON_MSG(IPVS_EST_TICK_CHAINS > 127,
+			 "Too many chains for ktcid");
+
+	if (ipvs->est_add_ktid < ipvs->est_kt_count) {
+		kd = ipvs->est_kt_arr[ipvs->est_add_ktid];
+		if (kd)
+			goto add_est;
+	}
+
+	ret = ip_vs_est_add_kthread(ipvs);
+	if (ret < 0)
+		goto out;
+	kd = ipvs->est_kt_arr[ipvs->est_add_ktid];
+
+add_est:
+	ktid = kd->id;
+	/* For small number of estimators prefer to use few ticks,
+	 * otherwise try to add into the last estimated row.
+	 * est_row and add_row point after the row we should use
+	 */
+	if (kd->est_count >= 2 * kd->tick_max || delay < IPVS_EST_NTICKS - 1)
+		crow = READ_ONCE(kd->est_row);
+	else
+		crow = kd->add_row;
+	crow += delay;
+	if (crow >= IPVS_EST_NTICKS)
+		crow -= IPVS_EST_NTICKS;
+	/* Assume initial delay ? */
+	if (delay >= IPVS_EST_NTICKS - 1) {
+		/* Preserve initial delay or decrease it if no space in tick */
+		row = crow;
+		if (crow < IPVS_EST_NTICKS - 1) {
+			crow++;
+			row = find_last_bit(kd->avail, crow);
+		}
+		if (row >= crow)
+			row = find_last_bit(kd->avail, IPVS_EST_NTICKS);
+	} else {
+		/* Preserve delay or increase it if no space in tick */
+		row = IPVS_EST_NTICKS;
+		if (crow > 0)
+			row = find_next_bit(kd->avail, IPVS_EST_NTICKS, crow);
+		if (row >= IPVS_EST_NTICKS)
+			row = find_first_bit(kd->avail, IPVS_EST_NTICKS);
+	}
+
+	td = rcu_dereference_protected(kd->ticks[row], 1);
+	if (!td) {
+		td = kzalloc(sizeof(*td), GFP_KERNEL);
+		if (!td) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		rcu_assign_pointer(kd->ticks[row], td);
+	}
+
+	cid = find_first_zero_bit(td->full, IPVS_EST_TICK_CHAINS);
+
+	kd->est_count++;
+	kd->tick_len[row]++;
+	if (!td->chain_len[cid])
+		__set_bit(cid, td->present);
+	td->chain_len[cid]++;
+	est->ktid = ktid;
+	est->ktrow = row;
+	est->ktcid = cid;
+	hlist_add_head_rcu(&est->list, &td->chains[cid]);
+
+	if (td->chain_len[cid] >= kd->chain_max) {
+		__set_bit(cid, td->full);
+		if (kd->tick_len[row] >= kd->tick_max)
+			__clear_bit(row, kd->avail);
+	}
+
+	/* Update est_add_ktid to point to first available/empty kt slot */
+	if (kd->est_count == kd->est_max_count)
+		ip_vs_est_update_ktid(ipvs);
+
+	ret = 0;
+
+out:
+	return ret;
+}
 
-	INIT_LIST_HEAD(&est->list);
+/* Start estimation for stats */
+int ip_vs_start_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
+{
+	struct ip_vs_estimator *est = &stats->est;
+	int ret;
+
+	if (!ipvs->est_max_threads && ipvs->enable)
+		ipvs->est_max_threads = IPVS_EST_CPU_KTHREADS *
+					num_possible_cpus();
+
+	est->ktid = -1;
+	est->ktrow = IPVS_EST_NTICKS - 1;	/* Initial delay */
+
+	/* We prefer this code to be short, kthread 0 will requeue the
+	 * estimator to available chain. If tasks are disabled, we
+	 * will not allocate much memory, just for kt 0.
+	 */
+	ret = 0;
+	if (!ipvs->est_kt_count || !ipvs->est_kt_arr[0])
+		ret = ip_vs_est_add_kthread(ipvs);
+	if (ret >= 0)
+		hlist_add_head(&est->list, &ipvs->est_temp_list);
+	else
+		INIT_HLIST_NODE(&est->list);
+	return ret;
+}
 
-	spin_lock_bh(&ipvs->est_lock);
-	list_add(&est->list, &ipvs->est_list);
-	spin_unlock_bh(&ipvs->est_lock);
+static void ip_vs_est_kthread_destroy(struct ip_vs_est_kt_data *kd)
+{
+	if (kd) {
+		if (kd->task) {
+			pr_info("stop unused estimator thread %d...\n", kd->id);
+			kthread_stop(kd->task);
+		}
+		ip_vs_stats_free(kd->calc_stats);
+		kfree(kd);
+	}
 }
 
+/* Unlink estimator from chain */
 void ip_vs_stop_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
 {
 	struct ip_vs_estimator *est = &stats->est;
+	struct ip_vs_est_tick_data *td;
+	struct ip_vs_est_kt_data *kd;
+	int ktid = est->ktid;
+	int row = est->ktrow;
+	int cid = est->ktcid;
+
+	/* Failed to add to chain ? */
+	if (hlist_unhashed(&est->list))
+		return;
+
+	/* On return, estimator can be freed, dequeue it now */
+
+	/* In est_temp_list ? */
+	if (ktid < 0) {
+		hlist_del(&est->list);
+		goto end_kt0;
+	}
+
+	hlist_del_rcu(&est->list);
+	kd = ipvs->est_kt_arr[ktid];
+	td = rcu_dereference_protected(kd->ticks[row], 1);
+	__clear_bit(cid, td->full);
+	td->chain_len[cid]--;
+	if (!td->chain_len[cid])
+		__clear_bit(cid, td->present);
+	kd->tick_len[row]--;
+	__set_bit(row, kd->avail);
+	if (!kd->tick_len[row]) {
+		RCU_INIT_POINTER(kd->ticks[row], NULL);
+		kfree_rcu(td);
+	}
+	kd->est_count--;
+	if (kd->est_count) {
+		/* This kt slot can become available just now, prefer it */
+		if (ktid < ipvs->est_add_ktid)
+			ipvs->est_add_ktid = ktid;
+		return;
+	}
 
-	spin_lock_bh(&ipvs->est_lock);
-	list_del(&est->list);
-	spin_unlock_bh(&ipvs->est_lock);
+	if (ktid > 0) {
+		mutex_lock(&ipvs->est_mutex);
+		ip_vs_est_kthread_destroy(kd);
+		ipvs->est_kt_arr[ktid] = NULL;
+		if (ktid == ipvs->est_kt_count - 1) {
+			ipvs->est_kt_count--;
+			while (ipvs->est_kt_count > 1 &&
+			       !ipvs->est_kt_arr[ipvs->est_kt_count - 1])
+				ipvs->est_kt_count--;
+		}
+		mutex_unlock(&ipvs->est_mutex);
+
+		/* This slot is now empty, prefer another available kt slot */
+		if (ktid == ipvs->est_add_ktid)
+			ip_vs_est_update_ktid(ipvs);
+	}
+
+end_kt0:
+	/* kt 0 is freed after all other kthreads and chains are empty */
+	if (ipvs->est_kt_count == 1 && hlist_empty(&ipvs->est_temp_list)) {
+		kd = ipvs->est_kt_arr[0];
+		if (!kd || !kd->est_count) {
+			mutex_lock(&ipvs->est_mutex);
+			if (kd) {
+				ip_vs_est_kthread_destroy(kd);
+				ipvs->est_kt_arr[0] = NULL;
+			}
+			ipvs->est_kt_count--;
+			mutex_unlock(&ipvs->est_mutex);
+			ipvs->est_add_ktid = 0;
+		}
+	}
+}
+
+/* Register all ests from est_temp_list to kthreads */
+static void ip_vs_est_drain_temp_list(struct netns_ipvs *ipvs)
+{
+	struct ip_vs_estimator *est;
+
+	while (1) {
+		int max = 16;
+
+		mutex_lock(&__ip_vs_mutex);
+
+		while (max-- > 0) {
+			est = hlist_entry_safe(ipvs->est_temp_list.first,
+					       struct ip_vs_estimator, list);
+			if (est) {
+				if (kthread_should_stop())
+					goto unlock;
+				hlist_del_init(&est->list);
+				if (ip_vs_enqueue_estimator(ipvs, est) >= 0)
+					continue;
+				est->ktid = -1;
+				hlist_add_head(&est->list,
+					       &ipvs->est_temp_list);
+				/* Abort, some entries will not be estimated
+				 * until next attempt
+				 */
+			}
+			goto unlock;
+		}
+		mutex_unlock(&__ip_vs_mutex);
+		cond_resched();
+	}
+
+unlock:
+	mutex_unlock(&__ip_vs_mutex);
+}
+
+/* Calculate limits for all kthreads */
+static int ip_vs_est_calc_limits(struct netns_ipvs *ipvs, int *chain_max)
+{
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+	struct ip_vs_est_kt_data *kd;
+	struct hlist_head chain;
+	struct ip_vs_stats *s;
+	int cache_factor = 4;
+	int i, loops, ntest;
+	s32 min_est = 0;
+	ktime_t t1, t2;
+	s64 diff, val;
+	int max = 8;
+	int ret = 1;
+
+	INIT_HLIST_HEAD(&chain);
+	mutex_lock(&__ip_vs_mutex);
+	kd = ipvs->est_kt_arr[0];
+	mutex_unlock(&__ip_vs_mutex);
+	s = kd ? kd->calc_stats : NULL;
+	if (!s)
+		goto out;
+	hlist_add_head(&s->est.list, &chain);
+
+	loops = 1;
+	/* Get best result from many tests */
+	for (ntest = 0; ntest < 12; ntest++) {
+		if (!(ntest & 3)) {
+			/* Wait for cpufreq frequency transition */
+			wait_event_idle_timeout(wq, kthread_should_stop(),
+						HZ / 50);
+			if (!ipvs->enable || kthread_should_stop())
+				goto stop;
+		}
+
+		local_bh_disable();
+		rcu_read_lock();
+
+		/* Put stats in cache */
+		ip_vs_chain_estimation(&chain);
+
+		t1 = ktime_get();
+		for (i = loops * cache_factor; i > 0; i--)
+			ip_vs_chain_estimation(&chain);
+		t2 = ktime_get();
+
+		rcu_read_unlock();
+		local_bh_enable();
+
+		if (!ipvs->enable || kthread_should_stop())
+			goto stop;
+		cond_resched();
+
+		diff = ktime_to_ns(ktime_sub(t2, t1));
+		if (diff <= 1 * NSEC_PER_USEC) {
+			/* Do more loops on low time resolution */
+			loops *= 2;
+			continue;
+		}
+		if (diff >= NSEC_PER_SEC)
+			continue;
+		val = diff;
+		do_div(val, loops);
+		if (!min_est || val < min_est) {
+			min_est = val;
+			/* goal: 95usec per chain */
+			val = 95 * NSEC_PER_USEC;
+			if (val >= min_est) {
+				do_div(val, min_est);
+				max = (int)val;
+			} else {
+				max = 1;
+			}
+		}
+	}
+
+out:
+	if (s)
+		hlist_del_init(&s->est.list);
+	*chain_max = max;
+	return ret;
+
+stop:
+	ret = 0;
+	goto out;
+}
+
+/* Calculate the parameters and apply them in context of kt #0
+ * ECP: est_calc_phase
+ * ECM: est_chain_max
+ * ECP	ECM	Insert Chain	enable	Description
+ * ---------------------------------------------------------------------------
+ * 0	0	est_temp_list	0	create kt #0 context
+ * 0	0	est_temp_list	0->1	service added, start kthread #0 task
+ * 0->1	0	est_temp_list	1	kt task #0 started, enters calc phase
+ * 1	0	est_temp_list	1	kt #0: determine est_chain_max,
+ *					stop tasks, move ests to est_temp_list
+ *					and free kd for kthreads 1..last
+ * 1->0	0->N	kt chains	1	ests can go to kthreads
+ * 0	N	kt chains	1	drain est_temp_list, create new kthread
+ *					contexts, start tasks, estimate
+ */
+static void ip_vs_est_calc_phase(struct netns_ipvs *ipvs)
+{
+	int genid = atomic_read(&ipvs->est_genid);
+	struct ip_vs_est_tick_data *td;
+	struct ip_vs_est_kt_data *kd;
+	struct ip_vs_estimator *est;
+	struct ip_vs_stats *stats;
+	int id, row, cid, delay;
+	bool last, last_td;
+	int chain_max;
+	int step;
+
+	if (!ip_vs_est_calc_limits(ipvs, &chain_max))
+		return;
+
+	mutex_lock(&__ip_vs_mutex);
+
+	/* Stop all other tasks, so that we can immediately move the
+	 * estimators to est_temp_list without RCU grace period
+	 */
+	mutex_lock(&ipvs->est_mutex);
+	for (id = 1; id < ipvs->est_kt_count; id++) {
+		/* netns clean up started, abort */
+		if (!ipvs->enable)
+			goto unlock2;
+		kd = ipvs->est_kt_arr[id];
+		if (!kd)
+			continue;
+		ip_vs_est_kthread_stop(kd);
+	}
+	mutex_unlock(&ipvs->est_mutex);
+
+	/* Move all estimators to est_temp_list but carefully,
+	 * all estimators and kthread data can be released while
+	 * we reschedule. Even for kthread 0.
+	 */
+	step = 0;
+
+	/* Order entries in est_temp_list in ascending delay, so now
+	 * walk delay(desc), id(desc), cid(asc)
+	 */
+	delay = IPVS_EST_NTICKS;
+
+next_delay:
+	delay--;
+	if (delay < 0)
+		goto end_dequeue;
+
+last_kt:
+	/* Destroy contexts backwards */
+	id = ipvs->est_kt_count;
+
+next_kt:
+	if (!ipvs->enable || kthread_should_stop())
+		goto unlock;
+	id--;
+	if (id < 0)
+		goto next_delay;
+	kd = ipvs->est_kt_arr[id];
+	if (!kd)
+		goto next_kt;
+	/* kt 0 can exist with empty chains */
+	if (!id && kd->est_count <= 1)
+		goto next_delay;
+
+	row = kd->est_row + delay;
+	if (row >= IPVS_EST_NTICKS)
+		row -= IPVS_EST_NTICKS;
+	td = rcu_dereference_protected(kd->ticks[row], 1);
+	if (!td)
+		goto next_kt;
+
+	cid = 0;
+
+walk_chain:
+	if (kthread_should_stop())
+		goto unlock;
+	step++;
+	if (!(step & 63)) {
+		/* Give chance estimators to be added (to est_temp_list)
+		 * and deleted (releasing kthread contexts)
+		 */
+		mutex_unlock(&__ip_vs_mutex);
+		cond_resched();
+		mutex_lock(&__ip_vs_mutex);
+
+		/* Current kt released ? */
+		if (id >= ipvs->est_kt_count)
+			goto last_kt;
+		if (kd != ipvs->est_kt_arr[id])
+			goto next_kt;
+		/* Current td released ? */
+		if (td != rcu_dereference_protected(kd->ticks[row], 1))
+			goto next_kt;
+		/* No fatal changes on the current kd and td */
+	}
+	est = hlist_entry_safe(td->chains[cid].first, struct ip_vs_estimator,
+			       list);
+	if (!est) {
+		cid++;
+		if (cid >= IPVS_EST_TICK_CHAINS)
+			goto next_kt;
+		goto walk_chain;
+	}
+	/* We can cheat and increase est_count to protect kt 0 context
+	 * from release but we prefer to keep the last estimator
+	 */
+	last = kd->est_count <= 1;
+	/* Do not free kt #0 data */
+	if (!id && last)
+		goto next_delay;
+	last_td = kd->tick_len[row] <= 1;
+	stats = container_of(est, struct ip_vs_stats, est);
+	ip_vs_stop_estimator(ipvs, stats);
+	/* Tasks are stopped, move without RCU grace period */
+	est->ktid = -1;
+	est->ktrow = row - kd->est_row;
+	if (est->ktrow < 0)
+		est->ktrow += IPVS_EST_NTICKS;
+	hlist_add_head(&est->list, &ipvs->est_temp_list);
+	/* kd freed ? */
+	if (last)
+		goto next_kt;
+	/* td freed ? */
+	if (last_td)
+		goto next_kt;
+	goto walk_chain;
+
+end_dequeue:
+	/* All estimators removed while calculating ? */
+	if (!ipvs->est_kt_count)
+		goto unlock;
+	kd = ipvs->est_kt_arr[0];
+	if (!kd)
+		goto unlock;
+	kd->add_row = kd->est_row;
+	ipvs->est_chain_max = chain_max;
+	ip_vs_est_set_params(ipvs, kd);
+
+	pr_info("using max %d ests per chain, %d per kthread\n",
+		kd->chain_max, kd->est_max_count);
+
+	/* Try to keep tot_stats in kt0, enqueue it early */
+	if (ipvs->tot_stats && !hlist_unhashed(&ipvs->tot_stats->s.est.list) &&
+	    ipvs->tot_stats->s.est.ktid == -1) {
+		hlist_del(&ipvs->tot_stats->s.est.list);
+		hlist_add_head(&ipvs->tot_stats->s.est.list,
+			       &ipvs->est_temp_list);
+	}
+
+	mutex_lock(&ipvs->est_mutex);
+
+	/* We completed the calc phase, new calc phase not requested */
+	if (genid == atomic_read(&ipvs->est_genid))
+		ipvs->est_calc_phase = 0;
+
+unlock2:
+	mutex_unlock(&ipvs->est_mutex);
+
+unlock:
+	mutex_unlock(&__ip_vs_mutex);
 }
 
 void ip_vs_zero_estimator(struct ip_vs_stats *stats)
@@ -191,14 +920,25 @@ void ip_vs_read_estimator(struct ip_vs_kstats *dst, struct ip_vs_stats *stats)
 
 int __net_init ip_vs_estimator_net_init(struct netns_ipvs *ipvs)
 {
-	INIT_LIST_HEAD(&ipvs->est_list);
-	spin_lock_init(&ipvs->est_lock);
-	timer_setup(&ipvs->est_timer, estimation_timer, 0);
-	mod_timer(&ipvs->est_timer, jiffies + 2 * HZ);
+	INIT_HLIST_HEAD(&ipvs->est_temp_list);
+	ipvs->est_kt_arr = NULL;
+	ipvs->est_max_threads = 0;
+	ipvs->est_calc_phase = 0;
+	ipvs->est_chain_max = 0;
+	ipvs->est_kt_count = 0;
+	ipvs->est_add_ktid = 0;
+	atomic_set(&ipvs->est_genid, 0);
+	atomic_set(&ipvs->est_genid_done, 0);
+	__mutex_init(&ipvs->est_mutex, "ipvs->est_mutex", &__ipvs_est_key);
 	return 0;
 }
 
 void __net_exit ip_vs_estimator_net_cleanup(struct netns_ipvs *ipvs)
 {
-	del_timer_sync(&ipvs->est_timer);
+	int i;
+
+	for (i = 0; i < ipvs->est_kt_count; i++)
+		ip_vs_est_kthread_destroy(ipvs->est_kt_arr[i]);
+	kfree(ipvs->est_kt_arr);
+	mutex_destroy(&ipvs->est_mutex);
 }
-- 
2.38.1


