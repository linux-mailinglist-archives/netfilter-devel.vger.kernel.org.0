Return-Path: <netfilter-devel+bounces-5736-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39344A075DC
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jan 2025 13:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032631888FA0
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jan 2025 12:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07992217707;
	Thu,  9 Jan 2025 12:38:14 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052331E531;
	Thu,  9 Jan 2025 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736426293; cv=none; b=s+qS6HZzcM1/XJdRJoN8DRhW5yISsl+s4GF/oVgKxa3Mz9Xhz6CZL4YGyjaGcV7jCP52anHmXSVbIH25eQbqd14kGTSc6nNhDb0R8R5AwMDiSw3DTqeYF0ei4OWUE++aeFHBwYb496fF88RUoCH1p/sFTne3/pRKvFam8EJXrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736426293; c=relaxed/simple;
	bh=8dbT0vV5DRmTiR01CR9RepFxBPrVOwzWjse1s9CkQfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NU89DERYklXQ2T66Yitcf/NiHQpa7vB0OFAXjrpzH59sYgKN3bJ9UK1hVIaqxHjrOtS3mNAJKmsayEl6+Bc5jN7viNUeB2xr1vxwP3+c5vfUWnGrgmhlmy5vGpJFjvLdaIjo8j48RnpKMR1tO0ACLUDnGIEofVt7rO5CXSJA6sM=
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
Subject: [PATCH net 1/2] netfilter: nf_tables: imbalance in flowtable binding
Date: Thu,  9 Jan 2025 13:38:05 +0100
Message-Id: <20250109123806.42021-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All these cases cause imbalance between BIND and UNBIND calls:

- Delete an interface from a flowtable with multiple interfaces

- Add a (device to a) flowtable with --check flag

- Delete a netns containing a flowtable

- In an interactive nft session, create a table with owner flag and
  flowtable inside, then quit.

Fix it by calling FLOW_BLOCK_UNBIND when unregistering hooks, then
remove late FLOW_BLOCK_UNBIND call when destroying flowtable.

Fixes: ff4bf2f42a40 ("netfilter: nf_tables: add nft_unregister_flowtable_hook()")
Reported-by: Phil Sutter <phil@nwl.cc>
Tested-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0b9f1e8dfe49..c4af283356e7 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8822,6 +8822,7 @@ static void nft_unregister_flowtable_hook(struct net *net,
 }
 
 static void __nft_unregister_flowtable_net_hooks(struct net *net,
+						 struct nft_flowtable *flowtable,
 						 struct list_head *hook_list,
 					         bool release_netdev)
 {
@@ -8829,6 +8830,8 @@ static void __nft_unregister_flowtable_net_hooks(struct net *net,
 
 	list_for_each_entry_safe(hook, next, hook_list, list) {
 		nf_unregister_net_hook(net, &hook->ops);
+		flowtable->data.type->setup(&flowtable->data, hook->ops.dev,
+					    FLOW_BLOCK_UNBIND);
 		if (release_netdev) {
 			list_del(&hook->list);
 			kfree_rcu(hook, rcu);
@@ -8837,9 +8840,10 @@ static void __nft_unregister_flowtable_net_hooks(struct net *net,
 }
 
 static void nft_unregister_flowtable_net_hooks(struct net *net,
+					       struct nft_flowtable *flowtable,
 					       struct list_head *hook_list)
 {
-	__nft_unregister_flowtable_net_hooks(net, hook_list, false);
+	__nft_unregister_flowtable_net_hooks(net, flowtable, hook_list, false);
 }
 
 static int nft_register_flowtable_net_hooks(struct net *net,
@@ -9481,8 +9485,6 @@ static void nf_tables_flowtable_destroy(struct nft_flowtable *flowtable)
 
 	flowtable->data.type->free(&flowtable->data);
 	list_for_each_entry_safe(hook, next, &flowtable->hook_list, list) {
-		flowtable->data.type->setup(&flowtable->data, hook->ops.dev,
-					    FLOW_BLOCK_UNBIND);
 		list_del_rcu(&hook->list);
 		kfree_rcu(hook, rcu);
 	}
@@ -10870,6 +10872,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 							   &nft_trans_flowtable_hooks(trans),
 							   trans->msg_type);
 				nft_unregister_flowtable_net_hooks(net,
+								   nft_trans_flowtable(trans),
 								   &nft_trans_flowtable_hooks(trans));
 			} else {
 				list_del_rcu(&nft_trans_flowtable(trans)->list);
@@ -10878,6 +10881,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 							   NULL,
 							   trans->msg_type);
 				nft_unregister_flowtable_net_hooks(net,
+						nft_trans_flowtable(trans),
 						&nft_trans_flowtable(trans)->hook_list);
 			}
 			break;
@@ -11140,11 +11144,13 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		case NFT_MSG_NEWFLOWTABLE:
 			if (nft_trans_flowtable_update(trans)) {
 				nft_unregister_flowtable_net_hooks(net,
+						nft_trans_flowtable(trans),
 						&nft_trans_flowtable_hooks(trans));
 			} else {
 				nft_use_dec_restore(&table->use);
 				list_del_rcu(&nft_trans_flowtable(trans)->list);
 				nft_unregister_flowtable_net_hooks(net,
+						nft_trans_flowtable(trans),
 						&nft_trans_flowtable(trans)->hook_list);
 			}
 			break;
@@ -11737,7 +11743,8 @@ static void __nft_release_hook(struct net *net, struct nft_table *table)
 	list_for_each_entry(chain, &table->chains, list)
 		__nf_tables_unregister_hook(net, table, chain, true);
 	list_for_each_entry(flowtable, &table->flowtables, list)
-		__nft_unregister_flowtable_net_hooks(net, &flowtable->hook_list,
+		__nft_unregister_flowtable_net_hooks(net, flowtable,
+						     &flowtable->hook_list,
 						     true);
 }
 
-- 
2.30.2


