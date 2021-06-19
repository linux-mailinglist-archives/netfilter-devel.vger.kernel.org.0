Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D243AD636
	for <lists+netfilter-devel@lfdr.de>; Sat, 19 Jun 2021 02:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhFSAL1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Jun 2021 20:11:27 -0400
Received: from mail.netfilter.org ([217.70.188.207]:51450 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhFSAL0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Jun 2021 20:11:26 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id EB0DA6426B;
        Sat, 19 Jun 2021 02:07:54 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     chutzpah@gentoo.org
Subject: [PATCH nf] netfilter: nf_tables_offload: skip VLAN handling if FLOW_DISSECTOR_KEY_CONTROL is unset
Date:   Sat, 19 Jun 2021 02:09:10 +0200
Message-Id: <20210619000910.1985-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Restore hardware offload support for rules that provide no matching
ethertype through FLOW_DISSECTOR_KEY_CONTROL.

Fixes: 783003f3bb8a ("netfilter: nftables_offload: special ethertype handling for VLAN")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_offload.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index a48c5fd53a80..6fc29f9cc11e 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -56,8 +56,10 @@ static void nft_flow_rule_transfer_vlan(struct nft_offload_ctx *ctx,
 	struct nft_flow_match *match = &flow->match;
 	struct nft_offload_ethertype ethertype;
 
-	if (match->dissector.used_keys & BIT(FLOW_DISSECTOR_KEY_CONTROL) &&
-	    match->key.basic.n_proto != htons(ETH_P_8021Q) &&
+	if (!(match->dissector.used_keys & BIT(FLOW_DISSECTOR_KEY_CONTROL)))
+		return;
+
+	if (match->key.basic.n_proto != htons(ETH_P_8021Q) &&
 	    match->key.basic.n_proto != htons(ETH_P_8021AD))
 		return;
 
-- 
2.30.2

