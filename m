Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8680713989E
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jan 2020 19:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgAMSQH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Jan 2020 13:16:07 -0500
Received: from correo.us.es ([193.147.175.20]:34740 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbgAMSQF (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:16:05 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6BE4515AEB7
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:16:03 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5CFB2DA718
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:16:03 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 46C16DA723; Mon, 13 Jan 2020 19:16:03 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 347CFDA70E
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:16:01 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 13 Jan 2020 19:16:01 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (50.pool85-54-104.dynamic.orange.es [85.54.104.50])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 145B842EF52A
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:16:01 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v2 4/9] netfilter: flowtable: remove dying bit, use teardown bit instead
Date:   Mon, 13 Jan 2020 19:15:49 +0100
Message-Id: <20200113181554.52612-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200113181554.52612-1-pablo@netfilter.org>
References: <20200113181554.52612-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The dying bit removes the conntrack entry if the netdev that owns this
flow is going down. Instead, use the teardown mechanism to push back the
flow to conntrack to let the classic software path decide what to do
with it.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: rebase on top of nf-next.

 include/net/netfilter/nf_flow_table.h | 5 -----
 net/netfilter/nf_flow_table_core.c    | 8 +++-----
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 415b8f49d150..4ad924d5f983 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -85,7 +85,6 @@ struct flow_offload_tuple_rhash {
 
 #define FLOW_OFFLOAD_SNAT	0x1
 #define FLOW_OFFLOAD_DNAT	0x2
-#define FLOW_OFFLOAD_DYING	0x4
 #define FLOW_OFFLOAD_TEARDOWN	0x8
 #define FLOW_OFFLOAD_HW		0x10
 #define FLOW_OFFLOAD_HW_DYING	0x20
@@ -134,10 +133,6 @@ int nf_flow_table_init(struct nf_flowtable *flow_table);
 void nf_flow_table_free(struct nf_flowtable *flow_table);
 
 void flow_offload_teardown(struct flow_offload *flow);
-static inline void flow_offload_dead(struct flow_offload *flow)
-{
-	flow->flags |= FLOW_OFFLOAD_DYING;
-}
 
 int nf_flow_snat_port(const struct flow_offload *flow,
 		      struct sk_buff *skb, unsigned int thoff,
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 9e6de2bbeccb..a9ed93a9e007 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -182,8 +182,6 @@ void flow_offload_free(struct flow_offload *flow)
 	default:
 		break;
 	}
-	if (flow->flags & FLOW_OFFLOAD_DYING)
-		nf_ct_delete(flow->ct, 0, 0);
 	nf_ct_put(flow->ct);
 	kfree_rcu(flow, rcu_head);
 }
@@ -300,7 +298,7 @@ flow_offload_lookup(struct nf_flowtable *flow_table,
 
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
-	if (flow->flags & (FLOW_OFFLOAD_DYING | FLOW_OFFLOAD_TEARDOWN))
+	if (flow->flags & FLOW_OFFLOAD_TEARDOWN)
 		return NULL;
 
 	if (unlikely(nf_ct_is_dying(flow->ct)))
@@ -349,7 +347,7 @@ static void nf_flow_offload_gc_step(struct flow_offload *flow, void *data)
 	struct nf_flowtable *flow_table = data;
 
 	if (nf_flow_has_expired(flow) || nf_ct_is_dying(flow->ct) ||
-	    (flow->flags & (FLOW_OFFLOAD_DYING | FLOW_OFFLOAD_TEARDOWN))) {
+	    (flow->flags & FLOW_OFFLOAD_TEARDOWN)) {
 		if (flow->flags & FLOW_OFFLOAD_HW) {
 			if (!(flow->flags & FLOW_OFFLOAD_HW_DYING))
 				nf_flow_offload_del(flow_table, flow);
@@ -523,7 +521,7 @@ static void nf_flow_table_do_cleanup(struct flow_offload *flow, void *data)
 	if (net_eq(nf_ct_net(flow->ct), dev_net(dev)) &&
 	    (flow->tuplehash[0].tuple.iifidx == dev->ifindex ||
 	     flow->tuplehash[1].tuple.iifidx == dev->ifindex))
-		flow_offload_dead(flow);
+		flow_offload_teardown(flow);
 }
 
 static void nf_flow_table_iterate_cleanup(struct nf_flowtable *flowtable,
-- 
2.11.0

