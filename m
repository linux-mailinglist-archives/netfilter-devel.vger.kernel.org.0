Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89167D5B99
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Oct 2023 21:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbjJXTi1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Oct 2023 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbjJXTi1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:38:27 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A62FB3
        for <netfilter-devel@vger.kernel.org>; Tue, 24 Oct 2023 12:38:24 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     vladbu@nvidia.com, fw@strlen.de, paulb@nvidia.com
Subject: [PATCH nf] netfilter: nf_flow_table: GC pushes back packets to classic path
Date:   Tue, 24 Oct 2023 21:38:15 +0200
Message-Id: <20231024193815.1987-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Since 41f2c7c342d3 ("net/sched: act_ct: Fix promotion of offloaded
unreplied tuple"), flowtable GC pushes back flows with IPS_SEEN_REPLY
back to classic path in every run, ie. every second. This is because of
a new check for NF_FLOW_HW_ESTABLISHED which is specific of sched/act_ct.

In Netfilter's flowtable case, NF_FLOW_HW_ESTABLISHED never gets set on
and IPS_SEEN_REPLY is unreliable since users decide when to offload the
flow before, such bit might be set on at a later stage.

Fix it by adding a custom .gc handler that sched/act_ct can use to
deal with its NF_FLOW_HW_ESTABLISHED bit.

Fixes: 41f2c7c342d3 ("net/sched: act_ct: Fix promotion of offloaded unreplied tuple")
Reported-by: Vladimir Smelhaus <vl.sm@email.cz>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_flow_table.h |  1 +
 net/netfilter/nf_flow_table_core.c    | 14 +++++++-------
 net/sched/act_ct.c                    |  7 +++++++
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index d466e1a3b0b1..fe1507c1db82 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -53,6 +53,7 @@ struct nf_flowtable_type {
 	struct list_head		list;
 	int				family;
 	int				(*init)(struct nf_flowtable *ft);
+	bool				(*gc)(const struct flow_offload *flow);
 	int				(*setup)(struct nf_flowtable *ft,
 						 struct net_device *dev,
 						 enum flow_block_command cmd);
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 1d34d700bd09..920a5a29ae1d 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -316,12 +316,6 @@ void flow_offload_refresh(struct nf_flowtable *flow_table,
 }
 EXPORT_SYMBOL_GPL(flow_offload_refresh);
 
-static bool nf_flow_is_outdated(const struct flow_offload *flow)
-{
-	return test_bit(IPS_SEEN_REPLY_BIT, &flow->ct->status) &&
-		!test_bit(NF_FLOW_HW_ESTABLISHED, &flow->flags);
-}
-
 static inline bool nf_flow_has_expired(const struct flow_offload *flow)
 {
 	return nf_flow_timeout_delta(flow->timeout) <= 0;
@@ -407,12 +401,18 @@ nf_flow_table_iterate(struct nf_flowtable *flow_table,
 	return err;
 }
 
+static bool nf_flow_custom_gc(struct nf_flowtable *flow_table,
+			      const struct flow_offload *flow)
+{
+	return flow_table->type->gc && flow_table->type->gc(flow);
+}
+
 static void nf_flow_offload_gc_step(struct nf_flowtable *flow_table,
 				    struct flow_offload *flow, void *data)
 {
 	if (nf_flow_has_expired(flow) ||
 	    nf_ct_is_dying(flow->ct) ||
-	    nf_flow_is_outdated(flow))
+	    nf_flow_custom_gc(flow_table, flow))
 		flow_offload_teardown(flow);
 
 	if (test_bit(NF_FLOW_TEARDOWN, &flow->flags)) {
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 7c652d14528b..0d44da4e8c8e 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -278,7 +278,14 @@ static int tcf_ct_flow_table_fill_actions(struct net *net,
 	return err;
 }
 
+static bool tcf_ct_flow_is_outdated(const struct flow_offload *flow)
+{
+	return test_bit(IPS_SEEN_REPLY_BIT, &flow->ct->status) &&
+	       !test_bit(NF_FLOW_HW_ESTABLISHED, &flow->flags);
+}
+
 static struct nf_flowtable_type flowtable_ct = {
+	.gc		= tcf_ct_flow_is_outdated,
 	.action		= tcf_ct_flow_table_fill_actions,
 	.owner		= THIS_MODULE,
 };
-- 
2.30.2

