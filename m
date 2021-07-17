Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976463CC204
	for <lists+netfilter-devel@lfdr.de>; Sat, 17 Jul 2021 10:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhGQI3Y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 17 Jul 2021 04:29:24 -0400
Received: from mail.netfilter.org ([217.70.188.207]:46224 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhGQI3U (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 17 Jul 2021 04:29:20 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 08D546164A
        for <netfilter-devel@vger.kernel.org>; Sat, 17 Jul 2021 10:25:58 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next] netfilter: flowtable: remove nf_ct_l4proto_find() call
Date:   Sat, 17 Jul 2021 10:26:17 +0200
Message-Id: <20210717082617.5120-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

TCP and UDP are built-in conntrack protocol trackers and the flowtable
only supports for TCP and UDP, remove this call.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_flow_table_core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 551976e4284c..19f4c4343b7d 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -180,15 +180,10 @@ static void flow_offload_fixup_tcp(struct ip_ct_tcp *tcp)
 
 static void flow_offload_fixup_ct_timeout(struct nf_conn *ct)
 {
-	const struct nf_conntrack_l4proto *l4proto;
 	struct net *net = nf_ct_net(ct);
 	int l4num = nf_ct_protonum(ct);
 	unsigned int timeout;
 
-	l4proto = nf_ct_l4proto_find(l4num);
-	if (!l4proto)
-		return;
-
 	if (l4num == IPPROTO_TCP) {
 		struct nf_tcp_net *tn = nf_tcp_pernet(net);
 
@@ -197,8 +192,6 @@ static void flow_offload_fixup_ct_timeout(struct nf_conn *ct)
 		struct nf_udp_net *tn = nf_udp_pernet(net);
 
 		timeout = tn->offload_pickup;
-	} else {
-		return;
 	}
 
 	if (nf_flow_timeout_delta(ct->timeout) > (__s32)timeout)
@@ -273,15 +266,10 @@ static const struct rhashtable_params nf_flow_offload_rhash_params = {
 
 unsigned long flow_offload_get_timeout(struct flow_offload *flow)
 {
-	const struct nf_conntrack_l4proto *l4proto;
 	unsigned long timeout = NF_FLOW_TIMEOUT;
 	struct net *net = nf_ct_net(flow->ct);
 	int l4num = nf_ct_protonum(flow->ct);
 
-	l4proto = nf_ct_l4proto_find(l4num);
-	if (!l4proto)
-		return timeout;
-
 	if (l4num == IPPROTO_TCP) {
 		struct nf_tcp_net *tn = nf_tcp_pernet(net);
 
-- 
2.30.2

