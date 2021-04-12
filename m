Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E918035D01A
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Apr 2021 20:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243543AbhDLSOT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 12 Apr 2021 14:14:19 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49742 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243345AbhDLSOS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 12 Apr 2021 14:14:18 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 26DEA63E3E;
        Mon, 12 Apr 2021 20:13:35 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     wenxu@ucloud.cn
Subject: [PATCH nf-next,v2 3/3] netfilter: nftables_offload: special ethertype handling for VLAN
Date:   Mon, 12 Apr 2021 20:13:54 +0200
Message-Id: <20210412181354.1412-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412181354.1412-1-pablo@netfilter.org>
References: <20210412181354.1412-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The nftables offload parser sets FLOW_DISSECTOR_KEY_BASIC .n_proto to the
ethertype field in the ethertype frame. However:

- FLOW_DISSECTOR_KEY_BASIC .n_proto field always stores either IPv4 or IPv6
  ethertypes.
- FLOW_DISSECTOR_KEY_VLAN .vlan_tpid stores either the 802.1q and 802.1ad
  ethertypes. Same as for FLOW_DISSECTOR_KEY_CVLAN.

This function adjusts the flow dissector to handle two scenarios:

1) FLOW_DISSECTOR_KEY_VLAN .vlan_tpid is set to 802.1q or 802.1ad.
   Then, transfer:
   - the .n_proto field to FLOW_DISSECTOR_KEY_VLAN .tpid.
   - the original FLOW_DISSECTOR_KEY_VLAN .tpid to the
     FLOW_DISSECTOR_KEY_CVLAN .tpid
   - the original FLOW_DISSECTOR_KEY_CVLAN .tpid to the .n_proto field.

2) .n_proto is set to 802.1q or 802.1ad. Then, transfer:
   - the .n_proto field to FLOW_DISSECTOR_KEY_VLAN .tpid.
   - the original FLOW_DISSECTOR_KEY_VLAN .tpid to the .n_proto field.

Fixes: a82055af5959 ("netfilter: nft_payload: add VLAN offload support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: simplify vlan scenarios.

 net/netfilter/nf_tables_offload.c | 45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 43b56eff3b04..0ae2fbf3d97b 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -47,6 +47,49 @@ void nft_flow_rule_set_addr_type(struct nft_flow_rule *flow,
 		offsetof(struct nft_flow_key, control);
 }
 
+struct nft_offload_ethertype {
+	__be16 value;
+	__be16 mask;
+};
+
+static void nft_flow_rule_transfer_vlan(struct nft_offload_ctx *ctx,
+					struct nft_flow_rule *flow)
+{
+	struct nft_flow_match *match = &flow->match;
+	struct nft_offload_ethertype ethertype;
+
+	if (match->key.basic.n_proto != htons(ETH_P_8021Q) &&
+	    match->key.basic.n_proto != htons(ETH_P_8021AD))
+		return;
+
+	ethertype.value = match->key.basic.n_proto;
+	ethertype.mask = match->mask.basic.n_proto;
+
+	if (match->key.vlan.vlan_tpid == htons(ETH_P_8021Q) ||
+	    match->key.vlan.vlan_tpid == htons(ETH_P_8021AD)) {
+		match->key.basic.n_proto = match->key.cvlan.vlan_tpid;
+		match->mask.basic.n_proto = match->mask.cvlan.vlan_tpid;
+		match->key.cvlan.vlan_tpid = match->key.vlan.vlan_tpid;
+		match->mask.cvlan.vlan_tpid = match->mask.vlan.vlan_tpid;
+		match->key.vlan.vlan_tpid = ethertype.value;
+		match->mask.vlan.vlan_tpid = ethertype.mask;
+		match->dissector.offset[FLOW_DISSECTOR_KEY_VLAN] =
+			offsetof(struct nft_flow_key, vlan);
+		match->dissector.offset[FLOW_DISSECTOR_KEY_CVLAN] =
+			offsetof(struct nft_flow_key, cvlan);
+		match->dissector.used_keys |= BIT(FLOW_DISSECTOR_KEY_VLAN) |
+					      BIT(FLOW_DISSECTOR_KEY_CVLAN);
+	} else {
+		match->key.basic.n_proto = match->key.vlan.vlan_tpid;
+		match->mask.basic.n_proto = match->mask.vlan.vlan_tpid;
+		match->key.vlan.vlan_tpid = ethertype.value;
+		match->mask.vlan.vlan_tpid = ethertype.mask;
+		match->dissector.offset[FLOW_DISSECTOR_KEY_VLAN] =
+			offsetof(struct nft_flow_key, vlan);
+		match->dissector.used_keys |= BIT(FLOW_DISSECTOR_KEY_VLAN);
+	}
+}
+
 struct nft_flow_rule *nft_flow_rule_create(struct net *net,
 					   const struct nft_rule *rule)
 {
@@ -91,6 +134,8 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net,
 
 		expr = nft_expr_next(expr);
 	}
+	nft_flow_rule_transfer_vlan(ctx, flow);
+
 	flow->proto = ctx->dep.l3num;
 	kfree(ctx);
 
-- 
2.30.2

