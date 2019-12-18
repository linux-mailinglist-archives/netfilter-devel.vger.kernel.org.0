Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC8B012454C
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Dec 2019 12:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLRLFq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Dec 2019 06:05:46 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:35982 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbfLRLFq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:05:46 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ihX9E-00077p-Rt; Wed, 18 Dec 2019 12:05:45 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 4/9] netfilter: nft_meta: move cgroup handling to helper
Date:   Wed, 18 Dec 2019 12:05:16 +0100
Message-Id: <20191218110521.14048-5-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218110521.14048-1-fw@strlen.de>
References: <20191218110521.14048-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Reduce size of main eval function.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_meta.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 1b32440ec2e6..3fca1c3ec361 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -161,6 +161,20 @@ nft_meta_get_eval_skugid(enum nft_meta_keys key,
 	return true;
 }
 
+#ifdef CONFIG_CGROUP_NET_CLASSID
+static noinline bool
+nft_meta_get_eval_cgroup(u32 *dest, const struct nft_pktinfo *pkt)
+{
+	struct sock *sk = skb_to_full_sk(pkt->skb);
+
+	if (!sk || !sk_fullsock(sk) || !net_eq(nft_net(pkt), sock_net(sk)))
+		return false;
+
+	*dest = sock_cgroup_classid(&sk->sk_cgrp_data);
+	return true;
+}
+#endif
+
 void nft_meta_get_eval(const struct nft_expr *expr,
 		       struct nft_regs *regs,
 		       const struct nft_pktinfo *pkt)
@@ -168,7 +182,6 @@ void nft_meta_get_eval(const struct nft_expr *expr,
 	const struct nft_meta *priv = nft_expr_priv(expr);
 	const struct sk_buff *skb = pkt->skb;
 	const struct net_device *in = nft_in(pkt), *out = nft_out(pkt);
-	struct sock *sk;
 	u32 *dest = &regs->data[priv->dreg];
 
 	switch (priv->key) {
@@ -258,11 +271,8 @@ void nft_meta_get_eval(const struct nft_expr *expr,
 		break;
 #ifdef CONFIG_CGROUP_NET_CLASSID
 	case NFT_META_CGROUP:
-		sk = skb_to_full_sk(skb);
-		if (!sk || !sk_fullsock(sk) ||
-		    !net_eq(nft_net(pkt), sock_net(sk)))
+		if (!nft_meta_get_eval_cgroup(dest, pkt))
 			goto err;
-		*dest = sock_cgroup_classid(&sk->sk_cgrp_data);
 		break;
 #endif
 	case NFT_META_PRANDOM: {
-- 
2.24.1

