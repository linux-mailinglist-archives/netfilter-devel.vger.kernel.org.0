Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D537749FE
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Aug 2023 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjHHUJl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Aug 2023 16:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbjHHUJa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:09:30 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD8A1FD6
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Aug 2023 11:40:27 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qTRd3-0003Ja-Ah; Tue, 08 Aug 2023 20:40:25 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: nf_tables: fix false-positive lockdep splat
Date:   Tue,  8 Aug 2023 20:40:17 +0200
Message-ID: <20230808184020.12779-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

->abort invocation may cause splat on debug kernels:

WARNING: suspicious RCU usage
net/netfilter/nft_set_pipapo.c:1697 suspicious rcu_dereference_check() usage!
[..]
rcu_scheduler_active = 2, debug_locks = 1
1 lock held by nft/133554: [..] (nft_net->commit_mutex){+.+.}-{3:3}, at: nf_tables_valid_genid
[..]
 lockdep_rcu_suspicious+0x1ad/0x260
 nft_pipapo_abort+0x145/0x180
 __nf_tables_abort+0x5359/0x63d0
 nf_tables_abort+0x24/0x40
 nfnetlink_rcv+0x1a0a/0x22c0
 netlink_unicast+0x73c/0x900
 netlink_sendmsg+0x7f0/0xc20
 ____sys_sendmsg+0x48d/0x760

Transaction mutex is held, so parallel updates are not possible.
Switch to _protected and check mutex is held for lockdep enabled builds.

Fixes: 212ed75dc5fb ("netfilter: nf_tables: integrate pipapo into commit protocol")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_set_pipapo.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 49915a2a58eb..f29c4bef1a3e 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1664,6 +1664,17 @@ static void nft_pipapo_commit(const struct nft_set *set)
 	priv->clone = new_clone;
 }
 
+static bool nft_pipapo_transaction_mutex_held(const struct nft_set *set)
+{
+#ifdef CONFIG_PROVE_LOCKING
+	const struct net *net = read_pnet(&set->net);
+
+	return lockdep_is_held(&nft_pernet(net)->commit_mutex);
+#else
+	return true;
+#endif
+}
+
 static void nft_pipapo_abort(const struct nft_set *set)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
@@ -1672,7 +1683,7 @@ static void nft_pipapo_abort(const struct nft_set *set)
 	if (!priv->dirty)
 		return;
 
-	m = rcu_dereference(priv->match);
+	m = rcu_dereference_protected(priv->match, nft_pipapo_transaction_mutex_held(set));
 
 	new_clone = pipapo_clone(m);
 	if (IS_ERR(new_clone))
-- 
2.41.0

