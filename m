Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC613989F
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jan 2020 19:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAMSQI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Jan 2020 13:16:08 -0500
Received: from correo.us.es ([193.147.175.20]:34778 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbgAMSQH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:16:07 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A9E4815AEB6
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:16:05 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9B1DFDA705
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:16:05 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 90A98DA702; Mon, 13 Jan 2020 19:16:05 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 86447DA709
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:16:03 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 13 Jan 2020 19:16:03 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (50.pool85-54-104.dynamic.orange.es [85.54.104.50])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 6676242EF52A
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:16:03 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 8/9] netfilter: flowtable: add flow_offload_tuple() helper
Date:   Mon, 13 Jan 2020 19:15:53 +0100
Message-Id: <20200113181554.52612-8-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200113181554.52612-1-pablo@netfilter.org>
References: <20200113181554.52612-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Consolidate code to configure the flow_cls_offload structure into one
helper function.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_flow_table_offload.c | 47 ++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 77b129f196c6..a08756dc96e4 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -592,23 +592,25 @@ static void nf_flow_offload_init(struct flow_cls_offload *cls_flow,
 	cls_flow->cookie = (unsigned long)tuple;
 }
 
-static int flow_offload_tuple_add(struct flow_offload_work *offload,
-				  struct nf_flow_rule *flow_rule,
-				  enum flow_offload_tuple_dir dir)
+static int flow_offload_tuple(struct nf_flowtable *flowtable,
+			      struct flow_offload *flow,
+			      struct nf_flow_rule *flow_rule,
+			      enum flow_offload_tuple_dir dir,
+			      int priority, int cmd,
+			      struct list_head *block_cb_list)
 {
-	struct nf_flowtable *flowtable = offload->flowtable;
 	struct flow_cls_offload cls_flow = {};
 	struct flow_block_cb *block_cb;
 	struct netlink_ext_ack extack;
 	__be16 proto = ETH_P_ALL;
 	int err, i = 0;
 
-	nf_flow_offload_init(&cls_flow, proto, offload->priority,
-			     FLOW_CLS_REPLACE,
-			     &offload->flow->tuplehash[dir].tuple, &extack);
-	cls_flow.rule = flow_rule->rule;
+	nf_flow_offload_init(&cls_flow, proto, priority, cmd,
+			     &flow->tuplehash[dir].tuple, &extack);
+	if (cmd == FLOW_CLS_REPLACE)
+		cls_flow.rule = flow_rule->rule;
 
-	list_for_each_entry(block_cb, &flowtable->flow_block.cb_list, list) {
+	list_for_each_entry(block_cb, block_cb_list, list) {
 		err = block_cb->cb(TC_SETUP_CLSFLOWER, &cls_flow,
 				   block_cb->cb_priv);
 		if (err < 0)
@@ -619,24 +621,23 @@ static int flow_offload_tuple_add(struct flow_offload_work *offload,
 
 	return i;
 }
+EXPORT_SYMBOL_GPL(flow_offload_tuple);
+
+static int flow_offload_tuple_add(struct flow_offload_work *offload,
+				  struct nf_flow_rule *flow_rule,
+				  enum flow_offload_tuple_dir dir)
+{
+	return flow_offload_tuple(offload->flowtable, offload->flow, flow_rule,
+				  dir, offload->priority, FLOW_CLS_REPLACE,
+				  &offload->flowtable->flow_block.cb_list);
+}
 
 static void flow_offload_tuple_del(struct flow_offload_work *offload,
 				   enum flow_offload_tuple_dir dir)
 {
-	struct nf_flowtable *flowtable = offload->flowtable;
-	struct flow_cls_offload cls_flow = {};
-	struct flow_block_cb *block_cb;
-	struct netlink_ext_ack extack;
-	__be16 proto = ETH_P_ALL;
-
-	nf_flow_offload_init(&cls_flow, proto, offload->priority,
-			     FLOW_CLS_DESTROY,
-			     &offload->flow->tuplehash[dir].tuple, &extack);
-
-	list_for_each_entry(block_cb, &flowtable->flow_block.cb_list, list)
-		block_cb->cb(TC_SETUP_CLSFLOWER, &cls_flow, block_cb->cb_priv);
-
-	set_bit(NF_FLOW_HW_DEAD, &offload->flow->flags);
+	flow_offload_tuple(offload->flowtable, offload->flow, NULL,
+			   dir, offload->priority, FLOW_CLS_DESTROY,
+			   &offload->flowtable->flow_block.cb_list);
 }
 
 static int flow_offload_rule_add(struct flow_offload_work *offload,
-- 
2.11.0

