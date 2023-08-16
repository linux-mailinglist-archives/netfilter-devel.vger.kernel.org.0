Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6B277D7FB
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Aug 2023 03:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbjHPB6P (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Aug 2023 21:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241241AbjHPB5n (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:57:43 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C6C2136;
        Tue, 15 Aug 2023 18:57:27 -0700 (PDT)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTP id 87393121B2;
        Wed, 16 Aug 2023 04:57:26 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id 7026C121B1;
        Wed, 16 Aug 2023 04:57:26 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
        by ink.ssi.bg (Postfix) with ESMTPSA id D42633C07D3;
        Wed, 16 Aug 2023 04:57:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
        t=1692151028; bh=pK1P7x01A48ZlwM1FSadC7e6+gxKK8w7zEAoSAA/BfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hV5lz2bkOTp2l1Op7GCT25WW6LX/WInycMkrRJAwJvvsIWff3Xx5MCo/noGP/6ys/
         zrTvBdX7tvsOYFOFVd+XDo68tY1JUgkmSGHviLD2ySTMzXL6ti04nyvaMgX5uyfe7h
         nDF/YkcftVQE2+s8Pq6MNzXMuWuAHgsOJScn0HNw=
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 37FHWI2i168665;
        Tue, 15 Aug 2023 20:32:18 +0300
Received: (from root@localhost)
        by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 37FHWIG4168664;
        Tue, 15 Aug 2023 20:32:18 +0300
From:   Julian Anastasov <ja@ssi.bg>
To:     Simon Horman <horms@verge.net.au>
Cc:     lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        netdev@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Dust Li <dust.li@linux.alibaba.com>,
        Jiejian Wu <jiejian@linux.alibaba.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: [PATCH RFC net-next 13/14] ipvs: add ip_vs_status info
Date:   Tue, 15 Aug 2023 20:30:30 +0300
Message-ID: <20230815173031.168344-14-ja@ssi.bg>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815173031.168344-1-ja@ssi.bg>
References: <20230815173031.168344-1-ja@ssi.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add /proc/net/ip_vs_status to show current state of IPVS.

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 147 +++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 43057b81c924..5b2a5e3bf309 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2910,6 +2910,146 @@ static int ip_vs_stats_percpu_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
+
+static int ip_vs_status_show(struct seq_file *seq, void *v)
+{
+	struct net *net = seq_file_single_net(seq);
+	struct netns_ipvs *ipvs = net_ipvs(net);
+	unsigned int resched_score = 0;
+	struct ip_vs_conn_hnode *hn;
+	struct hlist_bl_head *head;
+	struct ip_vs_service *svc;
+	struct ip_vs_rht *t, *pt;
+	struct hlist_bl_node *e;
+	int old_gen, new_gen;
+	u32 counts[8];
+	u32 bucket;
+	int count;
+	u32 sum1;
+	u32 sum;
+	int i;
+
+	old_gen = atomic_read(&ipvs->conn_tab_changes);
+
+	rcu_read_lock();
+
+	t = rcu_dereference(ipvs->conn_tab);
+
+	seq_printf(seq, "Conns:\t%d\n", atomic_read(&ipvs->conn_count));
+	seq_printf(seq, "Conn buckets:\t%d (%d bits, lfactor %d)\n",
+		   t ? t->size : 0, t ? t->bits : 0, t ? t->lfactor : 0);
+
+	if (!atomic_read(&ipvs->conn_count))
+		goto after_conns;
+	old_gen = atomic_read(&ipvs->conn_tab_changes);
+
+repeat_conn:
+	smp_rmb(); /* ipvs->conn_tab and conn_tab_changes */
+	memset(counts, 0, sizeof(counts));
+	ip_vs_rht_for_each_table_rcu(ipvs->conn_tab, t, pt) {
+		for (bucket = 0; bucket < t->size; bucket++) {
+			DECLARE_IP_VS_RHT_WALK_BUCKET_RCU();
+
+			count = 0;
+			resched_score++;
+			ip_vs_rht_walk_bucket_rcu(t, bucket, head) {
+				count = 0;
+				hlist_bl_for_each_entry_rcu(hn, e, head, node)
+					count++;
+			}
+			resched_score += count;
+			if (resched_score >= 100) {
+				resched_score = 0;
+				cond_resched_rcu();
+				new_gen = atomic_read(&ipvs->conn_tab_changes);
+				/* New table installed ? */
+				if (old_gen != new_gen) {
+					old_gen = new_gen;
+					goto repeat_conn;
+				}
+			}
+			counts[min(count, (int)ARRAY_SIZE(counts) - 1)]++;
+		}
+	}
+	for (sum = 0, i = 0; i < ARRAY_SIZE(counts); i++)
+		sum += counts[i];
+	sum1 = sum - counts[0];
+	seq_printf(seq, "Conn buckets empty:\t%u (%lu%%)\n",
+		   counts[0], (unsigned long)counts[0] * 100 / max(sum, 1U));
+	for (i = 1; i < ARRAY_SIZE(counts); i++) {
+		if (!counts[i])
+			continue;
+		seq_printf(seq, "Conn buckets len-%d:\t%u (%lu%%)\n",
+			   i, counts[i],
+			   (unsigned long)counts[i] * 100 / max(sum1, 1U));
+	}
+
+after_conns:
+	t = rcu_dereference(ipvs->svc_table);
+
+	count = ip_vs_get_num_services(ipvs);
+	seq_printf(seq, "Services:\t%d\n", count);
+	seq_printf(seq, "Service buckets:\t%d (%d bits, lfactor %d)\n",
+		   t ? t->size : 0, t ? t->bits : 0, t ? t->lfactor : 0);
+
+	if (!count)
+		goto after_svc;
+	old_gen = atomic_read(&ipvs->svc_table_changes);
+
+repeat_svc:
+	smp_rmb(); /* ipvs->svc_table and svc_table_changes */
+	memset(counts, 0, sizeof(counts));
+	ip_vs_rht_for_each_table_rcu(ipvs->svc_table, t, pt) {
+		for (bucket = 0; bucket < t->size; bucket++) {
+			DECLARE_IP_VS_RHT_WALK_BUCKET_RCU();
+
+			count = 0;
+			resched_score++;
+			ip_vs_rht_walk_bucket_rcu(t, bucket, head) {
+				count = 0;
+				hlist_bl_for_each_entry_rcu(svc, e, head,
+							    s_list)
+					count++;
+			}
+			resched_score += count;
+			if (resched_score >= 100) {
+				resched_score = 0;
+				cond_resched_rcu();
+				new_gen = atomic_read(&ipvs->svc_table_changes);
+				/* New table installed ? */
+				if (old_gen != new_gen) {
+					old_gen = new_gen;
+					goto repeat_svc;
+				}
+			}
+			counts[min(count, (int)ARRAY_SIZE(counts) - 1)]++;
+		}
+	}
+	for (sum = 0, i = 0; i < ARRAY_SIZE(counts); i++)
+		sum += counts[i];
+	sum1 = sum - counts[0];
+	seq_printf(seq, "Service buckets empty:\t%u (%lu%%)\n",
+		   counts[0], (unsigned long)counts[0] * 100 / max(sum, 1U));
+	for (i = 1; i < ARRAY_SIZE(counts); i++) {
+		if (!counts[i])
+			continue;
+		seq_printf(seq, "Service buckets len-%d:\t%u (%lu%%)\n",
+			   i, counts[i],
+			   (unsigned long)counts[i] * 100 / max(sum1, 1U));
+	}
+
+after_svc:
+	seq_printf(seq, "Stats thread slots:\t%d (max %lu)\n",
+		   ipvs->est_kt_count, ipvs->est_max_threads);
+	seq_printf(seq, "Stats chain max len:\t%d\n", ipvs->est_chain_max);
+	seq_printf(seq, "Stats thread ests:\t%d\n",
+		   ipvs->est_chain_max * IPVS_EST_CHAIN_FACTOR *
+		   IPVS_EST_NTICKS);
+
+	rcu_read_unlock();
+	return 0;
+}
+
 #endif
 
 /*
@@ -4819,6 +4959,9 @@ int __net_init ip_vs_control_net_init(struct netns_ipvs *ipvs)
 				    ipvs->net->proc_net,
 				    ip_vs_stats_percpu_show, NULL))
 		goto err_percpu;
+	if (!proc_create_net_single("ip_vs_status", 0, ipvs->net->proc_net,
+				    ip_vs_status_show, NULL))
+		goto err_status;
 #endif
 
 	ret = ip_vs_control_net_init_sysctl(ipvs);
@@ -4829,6 +4972,9 @@ int __net_init ip_vs_control_net_init(struct netns_ipvs *ipvs)
 
 err:
 #ifdef CONFIG_PROC_FS
+	remove_proc_entry("ip_vs_status", ipvs->net->proc_net);
+
+err_status:
 	remove_proc_entry("ip_vs_stats_percpu", ipvs->net->proc_net);
 
 err_percpu:
@@ -4854,6 +5000,7 @@ void __net_exit ip_vs_control_net_cleanup(struct netns_ipvs *ipvs)
 	ip_vs_control_net_cleanup_sysctl(ipvs);
 	cancel_delayed_work_sync(&ipvs->est_reload_work);
 #ifdef CONFIG_PROC_FS
+	remove_proc_entry("ip_vs_status", ipvs->net->proc_net);
 	remove_proc_entry("ip_vs_stats_percpu", ipvs->net->proc_net);
 	remove_proc_entry("ip_vs_stats", ipvs->net->proc_net);
 	remove_proc_entry("ip_vs", ipvs->net->proc_net);
-- 
2.41.0


