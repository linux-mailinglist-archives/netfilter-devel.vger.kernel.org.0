Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37CA34EA5B
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Mar 2021 16:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhC3OYl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Mar 2021 10:24:41 -0400
Received: from mail.netfilter.org ([217.70.188.207]:45544 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhC3OYU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:24:20 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 2F6D763E4C
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Mar 2021 16:24:04 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH] netfilter: flowtable: fix NAT IPv6 offload mangling
Date:   Tue, 30 Mar 2021 16:24:11 +0200
Message-Id: <20210330142411.11254-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fix out-of-bound access in the address array.

Fixes: 5c27d8d76ce8 ("netfilter: nf_flow_table_offload: add IPv6 support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_flow_table_offload.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 7d0d128407be..4f1a145ff74b 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -336,12 +336,12 @@ static void flow_offload_ipv6_mangle(struct nf_flow_rule *flow_rule,
 				     const __be32 *addr, const __be32 *mask)
 {
 	struct flow_action_entry *entry;
-	int i;
+	int i, j;
 
-	for (i = 0; i < sizeof(struct in6_addr) / sizeof(u32); i += sizeof(u32)) {
+	for (i = 0, j = 0; i < sizeof(struct in6_addr) / sizeof(u32); i += sizeof(u32), j++) {
 		entry = flow_action_entry_next(flow_rule);
 		flow_offload_mangle(entry, FLOW_ACT_MANGLE_HDR_TYPE_IP6,
-				    offset + i, &addr[i], mask);
+				    offset + i, &addr[j], mask);
 	}
 }
 
-- 
2.20.1

