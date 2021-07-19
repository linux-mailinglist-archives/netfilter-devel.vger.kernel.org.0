Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B403CE26B
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Jul 2021 18:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348391AbhGSPaQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Jul 2021 11:30:16 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49218 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347951AbhGSPX0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:23:26 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 9A98460692
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Jul 2021 18:03:40 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v2] netfilter: flowtable: remove nf_ct_l4proto_find() call
Date:   Mon, 19 Jul 2021 18:04:01 +0200
Message-Id: <20210719160401.1544-1-pablo@netfilter.org>
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
v2: fix kbuild robot compile warning in flow_offload_get_timeout().

 net/netfilter/nf_flow_table_core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 551976e4284c..548cf11e4577 100644
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
 
@@ -273,15 +268,10 @@ static const struct rhashtable_params nf_flow_offload_rhash_params = {
 
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

