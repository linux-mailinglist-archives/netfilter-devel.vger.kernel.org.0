Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F3B4DD96D
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Mar 2022 13:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiCRMM6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Mar 2022 08:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiCRMMs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:12:48 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 032C71FAA18
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Mar 2022 05:11:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 1DBF360743
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Mar 2022 13:08:58 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 2/2] netfilter: flowtable: pass flowtable to nf_flow_table_iterate()
Date:   Fri, 18 Mar 2022 13:11:24 +0100
Message-Id: <20220318121124.67894-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220318121124.67894-1-pablo@netfilter.org>
References: <20220318121124.67894-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The flowtable object is already passed as argument to
nf_flow_table_iterate(), do use not data pointer to pass flowtable.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_flow_table_core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index e66a375075c9..3db256da919b 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -405,7 +405,8 @@ EXPORT_SYMBOL_GPL(flow_offload_lookup);
 
 static int
 nf_flow_table_iterate(struct nf_flowtable *flow_table,
-		      void (*iter)(struct flow_offload *flow, void *data),
+		      void (*iter)(struct nf_flowtable *flowtable,
+				   struct flow_offload *flow, void *data),
 		      void *data)
 {
 	struct flow_offload_tuple_rhash *tuplehash;
@@ -429,7 +430,7 @@ nf_flow_table_iterate(struct nf_flowtable *flow_table,
 
 		flow = container_of(tuplehash, struct flow_offload, tuplehash[0]);
 
-		iter(flow, data);
+		iter(flow_table, flow, data);
 	}
 	rhashtable_walk_stop(&hti);
 	rhashtable_walk_exit(&hti);
@@ -457,10 +458,9 @@ static bool nf_flow_has_stale_dst(struct flow_offload *flow)
 	       flow_offload_stale_dst(&flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple);
 }
 
-static void nf_flow_offload_gc_step(struct flow_offload *flow, void *data)
+static void nf_flow_offload_gc_step(struct nf_flowtable *flow_table,
+				    struct flow_offload *flow, void *data)
 {
-	struct nf_flowtable *flow_table = data;
-
 	if (nf_flow_has_expired(flow) ||
 	    nf_ct_is_dying(flow->ct) ||
 	    nf_flow_has_stale_dst(flow))
@@ -485,7 +485,7 @@ static void nf_flow_offload_work_gc(struct work_struct *work)
 	struct nf_flowtable *flow_table;
 
 	flow_table = container_of(work, struct nf_flowtable, gc_work.work);
-	nf_flow_table_iterate(flow_table, nf_flow_offload_gc_step, flow_table);
+	nf_flow_table_iterate(flow_table, nf_flow_offload_gc_step, NULL);
 	queue_delayed_work(system_power_efficient_wq, &flow_table->gc_work, HZ);
 }
 
@@ -601,7 +601,8 @@ int nf_flow_table_init(struct nf_flowtable *flowtable)
 }
 EXPORT_SYMBOL_GPL(nf_flow_table_init);
 
-static void nf_flow_table_do_cleanup(struct flow_offload *flow, void *data)
+static void nf_flow_table_do_cleanup(struct nf_flowtable *flow_table,
+				     struct flow_offload *flow, void *data)
 {
 	struct net_device *dev = data;
 
@@ -643,11 +644,10 @@ void nf_flow_table_free(struct nf_flowtable *flow_table)
 
 	cancel_delayed_work_sync(&flow_table->gc_work);
 	nf_flow_table_iterate(flow_table, nf_flow_table_do_cleanup, NULL);
-	nf_flow_table_iterate(flow_table, nf_flow_offload_gc_step, flow_table);
+	nf_flow_table_iterate(flow_table, nf_flow_offload_gc_step, NULL);
 	nf_flow_table_offload_flush(flow_table);
 	if (nf_flowtable_hw_offload(flow_table))
-		nf_flow_table_iterate(flow_table, nf_flow_offload_gc_step,
-				      flow_table);
+		nf_flow_table_iterate(flow_table, nf_flow_offload_gc_step, NULL);
 	rhashtable_destroy(&flow_table->rhashtable);
 }
 EXPORT_SYMBOL_GPL(nf_flow_table_free);
-- 
2.30.2

