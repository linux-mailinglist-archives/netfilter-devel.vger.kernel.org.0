Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039523A47DF
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Jun 2021 19:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhFKR27 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Jun 2021 13:28:59 -0400
Received: from mail.netfilter.org ([217.70.188.207]:37724 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhFKR27 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:28:59 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id DC2786423A
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Jun 2021 19:25:45 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nft_tproxy: restrict support to TCP and UDP transport protocols
Date:   Fri, 11 Jun 2021 19:26:56 +0200
Message-Id: <20210611172656.15284-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add unfront check for TCP and UDP packets before performing further
processing.

Fixes: 4ed8eb6570a4 ("netfilter: nf_tables: Add native tproxy support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_tproxy.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index accef672088c..5cb4d575d47f 100644
--- a/net/netfilter/nft_tproxy.c
+++ b/net/netfilter/nft_tproxy.c
@@ -30,6 +30,12 @@ static void nft_tproxy_eval_v4(const struct nft_expr *expr,
 	__be16 tport = 0;
 	struct sock *sk;
 
+	if (pkt->tprot != IPPROTO_TCP &&
+	    pkt->tprot != IPPROTO_UDP) {
+		regs->verdict.code = NFT_BREAK;
+		return;
+	}
+
 	hp = skb_header_pointer(skb, ip_hdrlen(skb), sizeof(_hdr), &_hdr);
 	if (!hp) {
 		regs->verdict.code = NFT_BREAK;
@@ -91,7 +97,8 @@ static void nft_tproxy_eval_v6(const struct nft_expr *expr,
 
 	memset(&taddr, 0, sizeof(taddr));
 
-	if (!pkt->tprot_set) {
+	if (pkt->tprot != IPPROTO_TCP &&
+	    pkt->tprot != IPPROTO_UDP) {
 		regs->verdict.code = NFT_BREAK;
 		return;
 	}
-- 
2.20.1

