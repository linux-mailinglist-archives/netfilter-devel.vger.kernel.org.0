Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A66C6C19A
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jul 2019 21:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfGQTnB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Jul 2019 15:43:01 -0400
Received: from mail.us.es ([193.147.175.20]:57734 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfGQTnA (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Jul 2019 15:43:00 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1F22ADA72F
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Jul 2019 21:42:59 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 128D9DA732
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Jul 2019 21:42:59 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 07F3458F; Wed, 17 Jul 2019 21:42:59 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E93CADA732;
        Wed, 17 Jul 2019 21:42:56 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 17 Jul 2019 21:42:56 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id AD5B34265A31;
        Wed, 17 Jul 2019 21:42:56 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, jiri@resnulli.us,
        jakub.kicinski@netronome.com
Subject: [PATCH net,v3 1/4] net: openvswitch: rename flow_stats to sw_flow_stats
Date:   Wed, 17 Jul 2019 21:42:45 +0200
Message-Id: <20190717194248.2522-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

There is a flow_stats structure defined in include/net/flow_offload.h
which is placed in the networking core. I think that definition takes
precedence on OVS, so rename flow_stats in OVS to sw_flow_stats.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
OVS compilation breaks here after this patchset since flow_stats
structure is already defined in include/net/flow_offload.h. This patch
is new in this batch.

 net/openvswitch/flow.c       | 8 ++++----
 net/openvswitch/flow.h       | 4 ++--
 net/openvswitch/flow_table.c | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index dca3b1e2acf0..bc89e16e0505 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -59,7 +59,7 @@ u64 ovs_flow_used_time(unsigned long flow_jiffies)
 void ovs_flow_stats_update(struct sw_flow *flow, __be16 tcp_flags,
 			   const struct sk_buff *skb)
 {
-	struct flow_stats *stats;
+	struct sw_flow_stats *stats;
 	unsigned int cpu = smp_processor_id();
 	int len = skb->len + (skb_vlan_tag_present(skb) ? VLAN_HLEN : 0);
 
@@ -87,7 +87,7 @@ void ovs_flow_stats_update(struct sw_flow *flow, __be16 tcp_flags,
 			if (likely(flow->stats_last_writer != -1) &&
 			    likely(!rcu_access_pointer(flow->stats[cpu]))) {
 				/* Try to allocate CPU-specific stats. */
-				struct flow_stats *new_stats;
+				struct sw_flow_stats *new_stats;
 
 				new_stats =
 					kmem_cache_alloc_node(flow_stats_cache,
@@ -134,7 +134,7 @@ void ovs_flow_stats_get(const struct sw_flow *flow,
 
 	/* We open code this to make sure cpu 0 is always considered */
 	for (cpu = 0; cpu < nr_cpu_ids; cpu = cpumask_next(cpu, &flow->cpu_used_mask)) {
-		struct flow_stats *stats = rcu_dereference_ovsl(flow->stats[cpu]);
+		struct sw_flow_stats *stats = rcu_dereference_ovsl(flow->stats[cpu]);
 
 		if (stats) {
 			/* Local CPU may write on non-local stats, so we must
@@ -158,7 +158,7 @@ void ovs_flow_stats_clear(struct sw_flow *flow)
 
 	/* We open code this to make sure cpu 0 is always considered */
 	for (cpu = 0; cpu < nr_cpu_ids; cpu = cpumask_next(cpu, &flow->cpu_used_mask)) {
-		struct flow_stats *stats = ovsl_dereference(flow->stats[cpu]);
+		struct sw_flow_stats *stats = ovsl_dereference(flow->stats[cpu]);
 
 		if (stats) {
 			spin_lock_bh(&stats->lock);
diff --git a/net/openvswitch/flow.h b/net/openvswitch/flow.h
index 3e2cc2202d66..a5506e2d4b7a 100644
--- a/net/openvswitch/flow.h
+++ b/net/openvswitch/flow.h
@@ -194,7 +194,7 @@ struct sw_flow_actions {
 	struct nlattr actions[];
 };
 
-struct flow_stats {
+struct sw_flow_stats {
 	u64 packet_count;		/* Number of packets matched. */
 	u64 byte_count;			/* Number of bytes matched. */
 	unsigned long used;		/* Last used time (in jiffies). */
@@ -216,7 +216,7 @@ struct sw_flow {
 	struct cpumask cpu_used_mask;
 	struct sw_flow_mask *mask;
 	struct sw_flow_actions __rcu *sf_acts;
-	struct flow_stats __rcu *stats[]; /* One for each CPU.  First one
+	struct sw_flow_stats __rcu *stats[]; /* One for each CPU.  First one
 					   * is allocated at flow creation time,
 					   * the rest are allocated on demand
 					   * while holding the 'stats[0].lock'.
diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 988fd8a94e43..651093e33351 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -66,7 +66,7 @@ void ovs_flow_mask_key(struct sw_flow_key *dst, const struct sw_flow_key *src,
 struct sw_flow *ovs_flow_alloc(void)
 {
 	struct sw_flow *flow;
-	struct flow_stats *stats;
+	struct sw_flow_stats *stats;
 
 	flow = kmem_cache_zalloc(flow_cache, GFP_KERNEL);
 	if (!flow)
-- 
2.11.0

