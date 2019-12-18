Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6DF4124548
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Dec 2019 12:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfLRLFe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Dec 2019 06:05:34 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:35972 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbfLRLFe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:05:34 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ihX92-00077L-A5; Wed, 18 Dec 2019 12:05:32 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 1/9] netfilter: nft_meta: move time handling to helper
Date:   Wed, 18 Dec 2019 12:05:13 +0100
Message-Id: <20191218110521.14048-2-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218110521.14048-1-fw@strlen.de>
References: <20191218110521.14048-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

reduce size of the (large) meta evaluation function.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_meta.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 9740b554fdb3..ba74f3ee7264 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -33,8 +33,9 @@
 
 static DEFINE_PER_CPU(struct rnd_state, nft_prandom_state);
 
-static u8 nft_meta_weekday(time64_t secs)
+static u8 nft_meta_weekday(void)
 {
+	time64_t secs = ktime_get_real_seconds();
 	unsigned int dse;
 	u8 wday;
 
@@ -56,6 +57,25 @@ static u32 nft_meta_hour(time64_t secs)
 		+ tm.tm_sec;
 }
 
+static noinline_for_stack void
+nft_meta_get_eval_time(enum nft_meta_keys key,
+		       u32 *dest)
+{
+	switch (key) {
+	case NFT_META_TIME_NS:
+		nft_reg_store64(dest, ktime_get_real_ns());
+		break;
+	case NFT_META_TIME_DAY:
+		nft_reg_store8(dest, nft_meta_weekday());
+		break;
+	case NFT_META_TIME_HOUR:
+		*dest = nft_meta_hour(ktime_get_real_seconds());
+		break;
+	default:
+		break;
+	}
+}
+
 void nft_meta_get_eval(const struct nft_expr *expr,
 		       struct nft_regs *regs,
 		       const struct nft_pktinfo *pkt)
@@ -247,13 +267,9 @@ void nft_meta_get_eval(const struct nft_expr *expr,
 		strncpy((char *)dest, out->rtnl_link_ops->kind, IFNAMSIZ);
 		break;
 	case NFT_META_TIME_NS:
-		nft_reg_store64(dest, ktime_get_real_ns());
-		break;
 	case NFT_META_TIME_DAY:
-		nft_reg_store8(dest, nft_meta_weekday(ktime_get_real_seconds()));
-		break;
 	case NFT_META_TIME_HOUR:
-		*dest = nft_meta_hour(ktime_get_real_seconds());
+		nft_meta_get_eval_time(priv->key, dest);
 		break;
 	default:
 		WARN_ON(1);
-- 
2.24.1

