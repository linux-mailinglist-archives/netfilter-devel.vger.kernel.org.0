Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 648C1271B5
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 May 2019 23:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfEVVdn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 May 2019 17:33:43 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:44902 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729691AbfEVVdn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 May 2019 17:33:43 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hTYrl-0002ps-3e; Wed, 22 May 2019 23:33:41 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: nf_tables: free base chain counters from worker
Date:   Wed, 22 May 2019 23:35:11 +0200
Message-Id: <20190522213511.21419-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

No need to use synchronize_rcu() here, just swap the two pointers
and have the release occur from work queue after commit has completed.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 4b5159936034..d444405211c5 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1449,25 +1449,18 @@ static struct nft_stats __percpu *nft_stats_alloc(const struct nlattr *attr)
 	return newstats;
 }
 
-static void nft_chain_stats_replace(struct net *net,
-				    struct nft_base_chain *chain,
-				    struct nft_stats __percpu *newstats)
+static void nft_chain_stats_replace(struct nft_trans *trans)
 {
-	struct nft_stats __percpu *oldstats;
+	struct nft_base_chain *chain = nft_base_chain(trans->ctx.chain);
 
-	if (newstats == NULL)
+	if (!nft_trans_chain_stats(trans))
 		return;
 
-	if (rcu_access_pointer(chain->stats)) {
-		oldstats = rcu_dereference_protected(chain->stats,
-					lockdep_commit_lock_is_held(net));
-		rcu_assign_pointer(chain->stats, newstats);
-		synchronize_rcu();
-		free_percpu(oldstats);
-	} else {
-		rcu_assign_pointer(chain->stats, newstats);
+	rcu_swap_protected(chain->stats, nft_trans_chain_stats(trans),
+			   lockdep_commit_lock_is_held(trans->ctx.net));
+
+	if (!nft_trans_chain_stats(trans))
 		static_branch_inc(&nft_counters_enabled);
-	}
 }
 
 static void nf_tables_chain_free_chain_rules(struct nft_chain *chain)
@@ -6362,9 +6355,9 @@ static void nft_chain_commit_update(struct nft_trans *trans)
 	if (!nft_is_base_chain(trans->ctx.chain))
 		return;
 
+	nft_chain_stats_replace(trans);
+
 	basechain = nft_base_chain(trans->ctx.chain);
-	nft_chain_stats_replace(trans->ctx.net, basechain,
-				nft_trans_chain_stats(trans));
 
 	switch (nft_trans_chain_policy(trans)) {
 	case NF_DROP:
@@ -6381,6 +6374,7 @@ static void nft_commit_release(struct nft_trans *trans)
 		nf_tables_table_destroy(&trans->ctx);
 		break;
 	case NFT_MSG_NEWCHAIN:
+		free_percpu(nft_trans_chain_stats(trans));
 		kfree(nft_trans_chain_name(trans));
 		break;
 	case NFT_MSG_DELCHAIN:
-- 
2.21.0

