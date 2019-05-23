Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B4627E6E
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 May 2019 15:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfEWNnu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 May 2019 09:43:50 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:48834 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729698AbfEWNnu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 May 2019 09:43:50 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hTo0a-0007je-HP; Thu, 23 May 2019 15:43:48 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 5/8] netfilter: nf_tables: prefer skb_ensure_writable
Date:   Thu, 23 May 2019 15:44:09 +0200
Message-Id: <20190523134412.3295-6-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523134412.3295-1-fw@strlen.de>
References: <20190523134412.3295-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

.. so skb_make_writable can be removed.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_exthdr.c  | 3 ++-
 net/netfilter/nft_payload.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index a940c9fd9045..45c8a6c07783 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -156,7 +156,8 @@ static void nft_exthdr_tcp_set_eval(const struct nft_expr *expr,
 		if (i + optl > tcphdr_len || priv->len + priv->offset > optl)
 			return;
 
-		if (!skb_make_writable(pkt->skb, pkt->xt.thoff + i + priv->len))
+		if (skb_ensure_writable(pkt->skb,
+					pkt->xt.thoff + i + priv->len))
 			return;
 
 		tcph = nft_tcp_header_pointer(pkt, sizeof(buff), buff,
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 54e15de4b79a..1465b7d6d2b0 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -243,7 +243,7 @@ static int nft_payload_l4csum_update(const struct nft_pktinfo *pkt,
 					  tsum));
 	}
 
-	if (!skb_make_writable(skb, l4csum_offset + sizeof(sum)) ||
+	if (skb_ensure_writable(skb, l4csum_offset + sizeof(sum)) ||
 	    skb_store_bits(skb, l4csum_offset, &sum, sizeof(sum)) < 0)
 		return -1;
 
@@ -259,7 +259,7 @@ static int nft_payload_csum_inet(struct sk_buff *skb, const u32 *src,
 		return -1;
 
 	nft_csum_replace(&sum, fsum, tsum);
-	if (!skb_make_writable(skb, csum_offset + sizeof(sum)) ||
+	if (skb_ensure_writable(skb, csum_offset + sizeof(sum)) ||
 	    skb_store_bits(skb, csum_offset, &sum, sizeof(sum)) < 0)
 		return -1;
 
@@ -312,7 +312,7 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 			goto err;
 	}
 
-	if (!skb_make_writable(skb, max(offset + priv->len, 0)) ||
+	if (skb_ensure_writable(skb, max(offset + priv->len, 0)) ||
 	    skb_store_bits(skb, offset, src, priv->len) < 0)
 		goto err;
 
-- 
2.21.0

