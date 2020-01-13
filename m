Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 728D1139895
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jan 2020 19:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgAMSQD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Jan 2020 13:16:03 -0500
Received: from correo.us.es ([193.147.175.20]:34700 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgAMSQD (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:16:03 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 05E1315AEA0
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:16:01 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E552FDA70E
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:16:00 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id DAD5CDA714; Mon, 13 Jan 2020 19:16:00 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D4E08DA70E
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:15:58 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 13 Jan 2020 19:15:58 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (50.pool85-54-104.dynamic.orange.es [85.54.104.50])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id B484942EF52A
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jan 2020 19:15:58 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v3 1/9] netfilter: flowtable: fetch stats only if flow is still alive
Date:   Mon, 13 Jan 2020 19:15:46 +0100
Message-Id: <20200113181554.52612-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Do not fetch statistics if flow has expired since it might not in
hardware anymore. After this update, remove the FLOW_OFFLOAD_HW_DYING
check from nf_flow_offload_stats() since this flag is never set on.

Fixes: c29f74e0df7a ("netfilter: nf_flow_table: hardware offload support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Acked-by: wenxu <wenxu@ucloud.cn>
---
v3: Rebase on top of nf-next.

 net/netfilter/nf_flow_table_core.c    | 5 ++---
 net/netfilter/nf_flow_table_offload.c | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index e33a73cb1f42..9e6de2bbeccb 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -348,9 +348,6 @@ static void nf_flow_offload_gc_step(struct flow_offload *flow, void *data)
 {
 	struct nf_flowtable *flow_table = data;
 
-	if (flow->flags & FLOW_OFFLOAD_HW)
-		nf_flow_offload_stats(flow_table, flow);
-
 	if (nf_flow_has_expired(flow) || nf_ct_is_dying(flow->ct) ||
 	    (flow->flags & (FLOW_OFFLOAD_DYING | FLOW_OFFLOAD_TEARDOWN))) {
 		if (flow->flags & FLOW_OFFLOAD_HW) {
@@ -361,6 +358,8 @@ static void nf_flow_offload_gc_step(struct flow_offload *flow, void *data)
 		} else {
 			flow_offload_del(flow_table, flow);
 		}
+	} else if (flow->flags & FLOW_OFFLOAD_HW) {
+		nf_flow_offload_stats(flow_table, flow);
 	}
 }
 
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index d06969af1085..4d1e81e2880f 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -784,8 +784,7 @@ void nf_flow_offload_stats(struct nf_flowtable *flowtable,
 	__s32 delta;
 
 	delta = nf_flow_timeout_delta(flow->timeout);
-	if ((delta >= (9 * NF_FLOW_TIMEOUT) / 10) ||
-	    flow->flags & FLOW_OFFLOAD_HW_DYING)
+	if ((delta >= (9 * NF_FLOW_TIMEOUT) / 10))
 		return;
 
 	offload = kzalloc(sizeof(struct flow_offload_work), GFP_ATOMIC);
-- 
2.11.0

