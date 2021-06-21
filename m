Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6B73AF419
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Jun 2021 20:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhFUSGg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Jun 2021 14:06:36 -0400
Received: from mail.netfilter.org ([217.70.188.207]:55908 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhFUSC4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:02:56 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 60B8B63087
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Jun 2021 19:59:17 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables_offload: check FLOW_DISSECTOR_KEY_BASIC in VLAN transfer logic
Date:   Mon, 21 Jun 2021 20:00:36 +0200
Message-Id: <20210621180036.102257-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The VLAN transfer logic should actually check for
FLOW_DISSECTOR_KEY_BASIC, not FLOW_DISSECTOR_KEY_CONTROL. Moreover, do
not fallback to case 2) .n_proto is set to 802.1q or 802.1ad, if
FLOW_DISSECTOR_KEY_BASIC is unset.

Fixes: 783003f3bb8a ("netfilter: nftables_offload: special ethertype handling for VLAN")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
Supersedes: https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210619001006.2067-1-pablo@netfilter.org/

 net/netfilter/nf_tables_offload.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index a48c5fd53a80..987bfede06fb 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -54,15 +54,10 @@ static void nft_flow_rule_transfer_vlan(struct nft_offload_ctx *ctx,
 					struct nft_flow_rule *flow)
 {
 	struct nft_flow_match *match = &flow->match;
-	struct nft_offload_ethertype ethertype;
-
-	if (match->dissector.used_keys & BIT(FLOW_DISSECTOR_KEY_CONTROL) &&
-	    match->key.basic.n_proto != htons(ETH_P_8021Q) &&
-	    match->key.basic.n_proto != htons(ETH_P_8021AD))
-		return;
-
-	ethertype.value = match->key.basic.n_proto;
-	ethertype.mask = match->mask.basic.n_proto;
+	struct nft_offload_ethertype ethertype = {
+		.value	= match->key.basic.n_proto,
+		.mask	= match->mask.basic.n_proto,
+	};
 
 	if (match->dissector.used_keys & BIT(FLOW_DISSECTOR_KEY_VLAN) &&
 	    (match->key.vlan.vlan_tpid == htons(ETH_P_8021Q) ||
@@ -76,7 +71,9 @@ static void nft_flow_rule_transfer_vlan(struct nft_offload_ctx *ctx,
 		match->dissector.offset[FLOW_DISSECTOR_KEY_CVLAN] =
 			offsetof(struct nft_flow_key, cvlan);
 		match->dissector.used_keys |= BIT(FLOW_DISSECTOR_KEY_CVLAN);
-	} else {
+	} else if (match->dissector.used_keys & BIT(FLOW_DISSECTOR_KEY_BASIC) &&
+		   (match->key.basic.n_proto == htons(ETH_P_8021Q) ||
+		    match->key.basic.n_proto == htons(ETH_P_8021AD))) {
 		match->key.basic.n_proto = match->key.vlan.vlan_tpid;
 		match->mask.basic.n_proto = match->mask.vlan.vlan_tpid;
 		match->key.vlan.vlan_tpid = ethertype.value;
-- 
2.30.2

