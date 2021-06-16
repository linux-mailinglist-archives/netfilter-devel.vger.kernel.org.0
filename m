Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50D43AA346
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Jun 2021 20:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhFPSmQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Jun 2021 14:42:16 -0400
Received: from mail.netfilter.org ([217.70.188.207]:46546 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhFPSmP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:42:15 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 69B196423C
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Jun 2021 20:38:49 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v2 1/2] netfilter: nft_exthdr: check for IPv6 packet before further processing
Date:   Wed, 16 Jun 2021 20:40:04 +0200
Message-Id: <20210616184005.120570-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

ipv6_find_hdr() does not validate that this is an IPv6 packet. Add a
sanity check for calling ipv6_find_hdr() to make sure an IPv6 packet
is passed for parsing.

Fixes: 96518518cc41 ("netfilter: add nftables")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: fix kbuild report.

 net/netfilter/nft_exthdr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index f64f0017e9a5..670dd146fb2b 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -42,6 +42,9 @@ static void nft_exthdr_ipv6_eval(const struct nft_expr *expr,
 	unsigned int offset = 0;
 	int err;
 
+	if (pkt->skb->protocol != htons(ETH_P_IPV6))
+		goto err;
+
 	err = ipv6_find_hdr(pkt->skb, &offset, priv->type, NULL, NULL);
 	if (priv->flags & NFT_EXTHDR_F_PRESENT) {
 		nft_reg_store8(dest, err >= 0);
-- 
2.30.2

