Return-Path: <netfilter-devel+bounces-3473-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AAA95C0BA
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Aug 2024 00:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1A61C233A8
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Aug 2024 22:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724DF1D2785;
	Thu, 22 Aug 2024 22:19:51 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B6E1C9ED7;
	Thu, 22 Aug 2024 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724365191; cv=none; b=oSmR20jMwcspL/NCuw/IsO2B1SjTcB+RstVeGrWfS3cOounhfW8RDI/KcdVmXsvq3Kw/LYDoVYV//ozE6XYW1FlMq+7qcdAtlpOoTNgrhaMJdO4ckptJbAWa95TEhz+JkHlf7BWm7F0pRVyZSEtPGTZ4UPXrcfeAdvgkwHgIsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724365191; c=relaxed/simple;
	bh=uDsGaH0z5w7WNVeIlAMGMR9zyfKpXP3nGLMOmu12WJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c6SCJS9U8Lc+aMmkm/p/RCVhgCuWChxUqNeqM20uzkhasV4A6ktGA7H3Gd72U6ETJRXSEliK6WUVa2RB6pa5EZgWn9fwRc2IIwC5pJqizElA6VpD3nbajgs4W9i3vxnqD16Fyc4CTufBMqocmASEwUvHkCw223e5up197h2YkuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 4/9] netfilter: nf_tables: store new sets in dedicated list
Date: Fri, 23 Aug 2024 00:19:34 +0200
Message-Id: <20240822221939.157858-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240822221939.157858-1-pablo@netfilter.org>
References: <20240822221939.157858-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

nft_set_lookup_byid() is very slow when transaction becomes large, due to
walk of the transaction list.

Add a dedicated list that contains only the new sets.

Before: nft -f ruleset 0.07s user 0.00s system 0% cpu 1:04.84 total
After: nft -f ruleset 0.07s user 0.00s system 0% cpu 30.115 total

.. where ruleset contains ~10 sets with ~100k elements.
The above number is for a combined flush+reload of the ruleset.

With previous flush, even the first NEWELEM has to walk through a few
hundred thousands of DELSET(ELEM) transactions before the first NEWSET
object. To cope with random-order-newset-newsetelem we'd need to replace
commit_set_list with a hashtable.

Expectation is that a NEWELEM operation refers to the most recently added
set, so last entry of the dedicated list should be the set we want.

NB: This is not a bug fix per se (functionality is fine), but with
larger transaction batches list search takes forever, so it would be
nice to speed this up for -stable too, hence adding a "fixes" tag.

Fixes: 958bee14d071 ("netfilter: nf_tables: use new transaction infrastructure to handle sets")
Reported-by: Nadia Pinaeva <n.m.pinaeva@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h |  2 ++
 net/netfilter/nf_tables_api.c     | 29 ++++++++++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 1bfdd16890fa..2be4738eae1c 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1674,6 +1674,7 @@ struct nft_trans_rule {
 
 struct nft_trans_set {
 	struct nft_trans_binding	nft_trans_binding;
+	struct list_head		list_trans_newset;
 	struct nft_set			*set;
 	u32				set_id;
 	u32				gc_int;
@@ -1875,6 +1876,7 @@ static inline int nft_request_module(struct net *net, const char *fmt, ...) { re
 struct nftables_pernet {
 	struct list_head	tables;
 	struct list_head	commit_list;
+	struct list_head	commit_set_list;
 	struct list_head	binding_list;
 	struct list_head	module_list;
 	struct list_head	notify_list;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0a2f79346958..3ea5d0163510 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -393,6 +393,7 @@ static void nft_trans_commit_list_add_tail(struct net *net, struct nft_trans *tr
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 	struct nft_trans_binding *binding;
+	struct nft_trans_set *trans_set;
 
 	list_add_tail(&trans->list, &nft_net->commit_list);
 
@@ -402,9 +403,13 @@ static void nft_trans_commit_list_add_tail(struct net *net, struct nft_trans *tr
 
 	switch (trans->msg_type) {
 	case NFT_MSG_NEWSET:
+		trans_set = nft_trans_container_set(trans);
+
 		if (!nft_trans_set_update(trans) &&
 		    nft_set_is_anonymous(nft_trans_set(trans)))
 			list_add_tail(&binding->binding_list, &nft_net->binding_list);
+
+		list_add_tail(&trans_set->list_trans_newset, &nft_net->commit_set_list);
 		break;
 	case NFT_MSG_NEWCHAIN:
 		if (!nft_trans_chain_update(trans) &&
@@ -611,6 +616,7 @@ static int __nft_trans_set_add(const struct nft_ctx *ctx, int msg_type,
 
 	trans_set = nft_trans_container_set(trans);
 	INIT_LIST_HEAD(&trans_set->nft_trans_binding.binding_list);
+	INIT_LIST_HEAD(&trans_set->list_trans_newset);
 
 	if (msg_type == NFT_MSG_NEWSET && ctx->nla[NFTA_SET_ID] && !desc) {
 		nft_trans_set_id(trans) =
@@ -4485,17 +4491,16 @@ static struct nft_set *nft_set_lookup_byid(const struct net *net,
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 	u32 id = ntohl(nla_get_be32(nla));
-	struct nft_trans *trans;
+	struct nft_trans_set *trans;
 
-	list_for_each_entry(trans, &nft_net->commit_list, list) {
-		if (trans->msg_type == NFT_MSG_NEWSET) {
-			struct nft_set *set = nft_trans_set(trans);
+	/* its likely the id we need is at the tail, not at start */
+	list_for_each_entry_reverse(trans, &nft_net->commit_set_list, list_trans_newset) {
+		struct nft_set *set = trans->set;
 
-			if (id == nft_trans_set_id(trans) &&
-			    set->table == table &&
-			    nft_active_genmask(set, genmask))
-				return set;
-		}
+		if (id == trans->set_id &&
+		    set->table == table &&
+		    nft_active_genmask(set, genmask))
+			return set;
 	}
 	return ERR_PTR(-ENOENT);
 }
@@ -10447,6 +10452,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 				nft_flow_rule_destroy(nft_trans_flow_rule(trans));
 			break;
 		case NFT_MSG_NEWSET:
+			list_del(&nft_trans_container_set(trans)->list_trans_newset);
 			if (nft_trans_set_update(trans)) {
 				struct nft_set *set = nft_trans_set(trans);
 
@@ -10755,6 +10761,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWSET:
+			list_del(&nft_trans_container_set(trans)->list_trans_newset);
 			if (nft_trans_set_update(trans)) {
 				nft_trans_destroy(trans);
 				break;
@@ -10850,6 +10857,8 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		}
 	}
 
+	WARN_ON_ONCE(!list_empty(&nft_net->commit_set_list));
+
 	nft_set_abort_update(&set_update_list);
 
 	synchronize_rcu();
@@ -11519,6 +11528,7 @@ static int __net_init nf_tables_init_net(struct net *net)
 
 	INIT_LIST_HEAD(&nft_net->tables);
 	INIT_LIST_HEAD(&nft_net->commit_list);
+	INIT_LIST_HEAD(&nft_net->commit_set_list);
 	INIT_LIST_HEAD(&nft_net->binding_list);
 	INIT_LIST_HEAD(&nft_net->module_list);
 	INIT_LIST_HEAD(&nft_net->notify_list);
@@ -11549,6 +11559,7 @@ static void __net_exit nf_tables_exit_net(struct net *net)
 	gc_seq = nft_gc_seq_begin(nft_net);
 
 	WARN_ON_ONCE(!list_empty(&nft_net->commit_list));
+	WARN_ON_ONCE(!list_empty(&nft_net->commit_set_list));
 
 	if (!list_empty(&nft_net->module_list))
 		nf_tables_module_autoload_cleanup(net);
-- 
2.30.2


