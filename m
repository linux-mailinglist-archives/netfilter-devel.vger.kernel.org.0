Return-Path: <netfilter-devel+bounces-2088-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 694038BB45B
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 May 2024 21:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5691C22998
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 May 2024 19:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1F0158DAA;
	Fri,  3 May 2024 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="lOtywLOM"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39EC158D89
	for <netfilter-devel@vger.kernel.org>; Fri,  3 May 2024 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765849; cv=none; b=aoYv1bF3GJUvQMtp1Mp+3LHlLc1qDcExA/p4743CxUuLjdtVsDq4+uwWpOaqDcMyfTtruIXAN6hESAyNH+88wId9SWIwzHjjB7CuqAz9AY2aLTD0uC89mHaENYaIJL6PeTV/U/GnZFyJZpTQL/v6Gh8B3m82xW6YeN1PebzPDUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765849; c=relaxed/simple;
	bh=XuZgZe1u+dIWHZrKq9e8/8UN8iMQPYciGYSmmoE3YZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWOVrAdsc/u4lDrvPGovGRc3oAI/TNmAnsuFn4MIII/iWDszcwjJQ7yUG98kT2JnjZk0AJ8PN5wGrwYkJBR5wRVNED/WFKhL9U7+QHNZEFPqwxK1arVwkU/Vgs5UdVsa/US4OC7gApQWu+wq0iEU6SDcPNKyVqPMyoKM/Ajnmj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=lOtywLOM; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AK++REY20x2HUNxL9jDSx1I00rmLnV1e40Qdi3dH2qo=; b=lOtywLOMJLI0p4QfBD7l2K98+s
	0Qch34eijdME4aHRWOWWSF7gea8GmA3d+43T41ShCHOU3hbbc94dKURU4eKZVDo+5tqcK4/SCNxaJ
	MdpLqKxVwvariXFYfOlusMroMFrsCaQb0eO+a+KhrRtWws/Bp2RS9gfCJk8kJXT0jdf8Cbd717Phy
	Xf3qRWnVXwrfGcgUlC/R9L+UzHB+Ook9fnWcBIUiSq+J5kL0NYUb3Wt5VgmvGyBRU/KjjYYeoVLGH
	sj4OAgy+9pxTupBZBVCBkKBGhrDDoANYbaAdWoSAsjGfw45P50uVLYTku6He3sM1iRo5Ue7RVfQBx
	kEH/ue8w==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1s2yvc-000000007Du-40lL;
	Fri, 03 May 2024 21:50:44 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Thomas Haller <thaller@redhat.com>
Subject: [nf-next PATCH 2/5] netfilter: nf_tables: Relax hook interface binding
Date: Fri,  3 May 2024 21:50:42 +0200
Message-ID: <20240503195045.6934-3-phil@nwl.cc>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503195045.6934-1-phil@nwl.cc>
References: <20240503195045.6934-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating a new flowtable or netdev-family chain, accept that the
devices to bind to may not exist and proceed to create a stub hook.
Such inactive hooks are identified by 'ops.dev' pointer being NULL,
ignore them for practical purposes.

When reacting upon a vanishing interface, merely deactivate the hook
instead of removing it from the list. Also leave netdev chains in place
even if no active hooks remain. In combination with externally stored
interface names, this stabilizes ruleset dumps with regard to
disappearing interfaces.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 include/net/netfilter/nf_tables.h |  2 -
 net/netfilter/nf_tables_api.c     | 63 +++++++++++++------------------
 net/netfilter/nft_chain_filter.c  | 29 +++-----------
 3 files changed, 33 insertions(+), 61 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 3dec239bdb22..9cbef71f0462 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1220,8 +1220,6 @@ static inline bool nft_is_base_chain(const struct nft_chain *chain)
 	return chain->flags & NFT_CHAIN_BASE;
 }
 
-int __nft_release_basechain(struct nft_ctx *ctx);
-
 unsigned int nft_do_chain(struct nft_pktinfo *pkt, void *priv);
 
 static inline bool nft_use_inc(u32 *use)
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 4f64dbac5abc..35990fbed444 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -282,6 +282,9 @@ static int nft_netdev_register_hooks(struct net *net,
 
 	j = 0;
 	list_for_each_entry(hook, hook_list, list) {
+		if (!hook->ops.dev)
+			continue;
+
 		err = nf_register_net_hook(net, &hook->ops);
 		if (err < 0)
 			goto err_register;
@@ -292,6 +295,9 @@ static int nft_netdev_register_hooks(struct net *net,
 
 err_register:
 	list_for_each_entry(hook, hook_list, list) {
+		if (!hook->ops.dev)
+			continue;
+
 		if (j-- <= 0)
 			break;
 
@@ -307,7 +313,10 @@ static void nft_netdev_unregister_hooks(struct net *net,
 	struct nft_hook *hook, *next;
 
 	list_for_each_entry_safe(hook, next, hook_list, list) {
-		nf_unregister_net_hook(net, &hook->ops);
+		if (hook->ops.dev) {
+			nf_unregister_net_hook(net, &hook->ops);
+			hook->ops.dev = NULL;
+		}
 		if (release_netdev) {
 			list_del(&hook->list);
 			kfree_rcu(hook, rcu);
@@ -2118,7 +2127,6 @@ void nf_tables_chain_destroy(struct nft_ctx *ctx)
 static struct nft_hook *nft_netdev_hook_alloc(struct net *net,
 					      const struct nlattr *attr)
 {
-	struct net_device *dev;
 	struct nft_hook *hook;
 	int err;
 
@@ -2134,17 +2142,10 @@ static struct nft_hook *nft_netdev_hook_alloc(struct net *net,
 	 * indirectly serializing all the other holders of the commit_mutex with
 	 * the rtnl_mutex.
 	 */
-	dev = __dev_get_by_name(net, hook->ifname);
-	if (!dev) {
-		err = -ENOENT;
-		goto err_hook_dev;
-	}
-	hook->ops.dev = dev;
+	hook->ops.dev = __dev_get_by_name(net, hook->ifname);
 
 	return hook;
 
-err_hook_dev:
-	kfree(hook);
 err_hook_alloc:
 	return ERR_PTR(err);
 }
@@ -8452,6 +8453,9 @@ static void nft_unregister_flowtable_hook(struct net *net,
 					  struct nft_flowtable *flowtable,
 					  struct nft_hook *hook)
 {
+	if (!hook->ops.dev)
+		return;
+
 	nf_unregister_net_hook(net, &hook->ops);
 	flowtable->data.type->setup(&flowtable->data, hook->ops.dev,
 				    FLOW_BLOCK_UNBIND);
@@ -8464,7 +8468,8 @@ static void __nft_unregister_flowtable_net_hooks(struct net *net,
 	struct nft_hook *hook, *next;
 
 	list_for_each_entry_safe(hook, next, hook_list, list) {
-		nf_unregister_net_hook(net, &hook->ops);
+		if (hook->ops.dev)
+			nf_unregister_net_hook(net, &hook->ops);
 		if (release_netdev) {
 			list_del(&hook->list);
 			kfree_rcu(hook, rcu);
@@ -8488,6 +8493,9 @@ static int nft_register_flowtable_net_hooks(struct net *net,
 	int err, i = 0;
 
 	list_for_each_entry(hook, hook_list, list) {
+		if (!hook->ops.dev)
+			continue;
+
 		list_for_each_entry(ft, &table->flowtables, list) {
 			if (!nft_is_active_next(net, ft))
 				continue;
@@ -8522,6 +8530,9 @@ static int nft_register_flowtable_net_hooks(struct net *net,
 
 err_unregister_net_hooks:
 	list_for_each_entry_safe(hook, next, hook_list, list) {
+		if (!hook->ops.dev)
+			continue;
+
 		if (i-- <= 0)
 			break;
 
@@ -9117,8 +9128,10 @@ static void nf_tables_flowtable_destroy(struct nft_flowtable *flowtable)
 
 	flowtable->data.type->free(&flowtable->data);
 	list_for_each_entry_safe(hook, next, &flowtable->hook_list, list) {
-		flowtable->data.type->setup(&flowtable->data, hook->ops.dev,
-					    FLOW_BLOCK_UNBIND);
+		if (hook->ops.dev)
+			flowtable->data.type->setup(&flowtable->data,
+						    hook->ops.dev,
+						    FLOW_BLOCK_UNBIND);
 		list_del_rcu(&hook->list);
 		kfree(hook);
 	}
@@ -9164,8 +9177,7 @@ static void nft_flowtable_event(unsigned long event, struct net_device *dev,
 
 		/* flow_offload_netdev_event() cleans up entries for us. */
 		nft_unregister_flowtable_hook(dev_net(dev), flowtable, hook);
-		list_del_rcu(&hook->list);
-		kfree_rcu(hook, rcu);
+		hook->ops.dev = NULL;
 		break;
 	}
 }
@@ -11406,27 +11418,6 @@ int nft_data_dump(struct sk_buff *skb, int attr, const struct nft_data *data,
 }
 EXPORT_SYMBOL_GPL(nft_data_dump);
 
-int __nft_release_basechain(struct nft_ctx *ctx)
-{
-	struct nft_rule *rule, *nr;
-
-	if (WARN_ON(!nft_is_base_chain(ctx->chain)))
-		return 0;
-
-	nf_tables_unregister_hook(ctx->net, ctx->chain->table, ctx->chain);
-	list_for_each_entry_safe(rule, nr, &ctx->chain->rules, list) {
-		list_del(&rule->list);
-		nft_use_dec(&ctx->chain->use);
-		nf_tables_rule_release(ctx, rule);
-	}
-	nft_chain_del(ctx->chain);
-	nft_use_dec(&ctx->table->use);
-	nf_tables_chain_destroy(ctx);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(__nft_release_basechain);
-
 static void __nft_release_hook(struct net *net, struct nft_table *table)
 {
 	struct nft_flowtable *flowtable;
diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 274b6f7e6bb5..ddb438bc2afd 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -322,35 +322,18 @@ static void nft_netdev_event(unsigned long event, struct net_device *dev,
 			     struct nft_ctx *ctx)
 {
 	struct nft_base_chain *basechain = nft_base_chain(ctx->chain);
-	struct nft_hook *hook, *found = NULL;
-	int n = 0;
+	struct nft_hook *hook;
 
 	if (event != NETDEV_UNREGISTER)
 		return;
 
 	list_for_each_entry(hook, &basechain->hook_list, list) {
-		if (hook->ops.dev == dev)
-			found = hook;
-
-		n++;
-	}
-	if (!found)
-		return;
-
-	if (n > 1) {
-		nf_unregister_net_hook(ctx->net, &found->ops);
-		list_del_rcu(&found->list);
-		kfree_rcu(found, rcu);
-		return;
+		if (hook->ops.dev == dev) {
+			nf_unregister_net_hook(ctx->net, &hook->ops);
+			hook->ops.dev = NULL;
+			break;
+		}
 	}
-
-	/* UNREGISTER events are also happening on netns exit.
-	 *
-	 * Although nf_tables core releases all tables/chains, only this event
-	 * handler provides guarantee that hook->ops.dev is still accessible,
-	 * so we cannot skip exiting net namespaces.
-	 */
-	__nft_release_basechain(ctx);
 }
 
 static int nf_tables_netdev_event(struct notifier_block *this,
-- 
2.43.0


