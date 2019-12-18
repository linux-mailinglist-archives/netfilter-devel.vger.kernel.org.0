Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B28C12454D
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Dec 2019 12:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLRLFu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Dec 2019 06:05:50 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:35986 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbfLRLFu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:05:50 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ihX9J-000782-7l; Wed, 18 Dec 2019 12:05:49 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 5/9] netfilter: nft_meta: move interface kind handling to helper
Date:   Wed, 18 Dec 2019 12:05:17 +0100
Message-Id: <20191218110521.14048-6-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218110521.14048-1-fw@strlen.de>
References: <20191218110521.14048-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

checkpatch complains about == NULL checks in original code,
so use !in instead.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_meta.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 3fca1c3ec361..2f7cc64b0c15 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -175,6 +175,30 @@ nft_meta_get_eval_cgroup(u32 *dest, const struct nft_pktinfo *pkt)
 }
 #endif
 
+static noinline bool nft_meta_get_eval_kind(enum nft_meta_keys key,
+					    u32 *dest,
+					    const struct nft_pktinfo *pkt)
+{
+	const struct net_device *in = nft_in(pkt), *out = nft_out(pkt);
+
+	switch (key) {
+	case NFT_META_IIFKIND:
+		if (!in || !in->rtnl_link_ops)
+			return false;
+		strncpy((char *)dest, in->rtnl_link_ops->kind, IFNAMSIZ);
+		break;
+	case NFT_META_OIFKIND:
+		if (!out || !out->rtnl_link_ops)
+			return false;
+		strncpy((char *)dest, out->rtnl_link_ops->kind, IFNAMSIZ);
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 void nft_meta_get_eval(const struct nft_expr *expr,
 		       struct nft_regs *regs,
 		       const struct nft_pktinfo *pkt)
@@ -286,14 +310,9 @@ void nft_meta_get_eval(const struct nft_expr *expr,
 		break;
 #endif
 	case NFT_META_IIFKIND:
-		if (in == NULL || in->rtnl_link_ops == NULL)
-			goto err;
-		strncpy((char *)dest, in->rtnl_link_ops->kind, IFNAMSIZ);
-		break;
 	case NFT_META_OIFKIND:
-		if (out == NULL || out->rtnl_link_ops == NULL)
+		if (!nft_meta_get_eval_kind(priv->key, dest, pkt))
 			goto err;
-		strncpy((char *)dest, out->rtnl_link_ops->kind, IFNAMSIZ);
 		break;
 	case NFT_META_TIME_NS:
 	case NFT_META_TIME_DAY:
-- 
2.24.1

