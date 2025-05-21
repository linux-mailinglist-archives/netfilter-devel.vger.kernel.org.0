Return-Path: <netfilter-devel+bounces-7230-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 513CCABFE15
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 May 2025 22:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22FA9E6B08
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 May 2025 20:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A10629DB60;
	Wed, 21 May 2025 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="QKsFEYUC"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618E29CB4C
	for <netfilter-devel@vger.kernel.org>; Wed, 21 May 2025 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860289; cv=none; b=opbp5E+5fb4MEtnoTQGR2OMgsGkzbV32IhDMFPXi6+9pAqdkuz0xfB0R+maePJqRiybA8hbZNZ0ZedEPRsSFZA1wBswn6zA0Rgv37Vq6Kbsiu+eeNeQIxN3oEr3YrmlzQgXZYKjiLnqz4Dfvlt6zUuTJ5jzShgsce0mO8lyKtRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860289; c=relaxed/simple;
	bh=w2d1+NVSnwy3Kh2r+azSr6slvl//N6Ja15Sn93UfQoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKALUyhHoQZKXV7leIHJ/Ax2kqFXKThE1WwiY78y14YryehDfscnwYvzITI4KVHNWrYpHd4AxOCpYyZVr2xHZ3EuigwMaQ9tlW818OF7Hqxct76b6eCkM/L9n/xqQRJvjP8GL6T2dt6bDMYG+w8y6WD1KTzcMLMvxxKIYRbha6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=QKsFEYUC; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wSG1TVSzIDQUXqxIYAW3WOEjqReP1jVbx/YZ8eZh1bk=; b=QKsFEYUCGlHIcG9ijL5HSGUoVI
	CylhDkx52ciuaDG9IQb6q0bXKSdJF+Exx7y6toQjiaSARCs/qzb7Bz2xFAq42zz2sIpPHWl3/7QlC
	aH9jAHPVRZ6c+vo58pK7MhvQlr0u7HGHWYJP9jD1PlNKgubdaDrezbfPv0zfyO75OVA5sWQzTfGDk
	lhejFcuDH7LPVnM3ccbqERYZ+aYbQDuGkcaQpEBLuqN2nUPMBCnUlSFH8tH0E5Bxp3Hk/OpX8bw+E
	51eSF+n8qgx4qVT98LLvxMxi/Pieu0XpzoSC2h1YUrWW3ZAgk2hF+HD9GVpqNdCcQEkmAPhNFvo7q
	dXVoP3kw==;
Authentication-Results: mail.nwl.cc;
	iprev=pass (localhost) smtp.remote-ip=::1
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1uHqIv-000000007RU-0WXJ;
	Wed, 21 May 2025 22:44:45 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Eric Garver <e@erig.me>
Subject: [nf-next PATCH v7 05/13] netfilter: nf_tables: Have a list of nf_hook_ops in nft_hook
Date: Wed, 21 May 2025 22:44:26 +0200
Message-ID: <20250521204434.13210-6-phil@nwl.cc>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521204434.13210-1-phil@nwl.cc>
References: <20250521204434.13210-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supporting a 1:n relationship between nft_hook and nf_hook_ops is
convenient since a chain's or flowtable's nft_hooks may remain in place
despite matching interfaces disappearing. This stabilizes ruleset dumps
in that regard and opens the possibility to claim newly added interfaces
which match the spec. Also it prepares for wildcard interface specs
since these will potentially match multiple interfaces.

All spots dealing with hook registration are updated to handle a list of
multiple nf_hook_ops, but nft_netdev_hook_alloc() only adds a single
item for now to retain the old behaviour. The only expected functional
change here is how vanishing interfaces are handled: Instead of dropping
the respective nft_hook, only the matching nf_hook_ops are dropped.

To safely remove individual ops from the list in netdev handlers, an
rcu_head is added to struct nf_hook_ops so kfree_rcu() may be used.
There is at least nft_flowtable_find_dev() which may be iterating
through the list at the same time.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v6:
- No need for save list traversal in nft_netdev_unregister_hooks, the
  loop's body does not remove items.
- Keep the break in nft_netdev_event(): A given device will not match
  multiple hooks, nf_tables_parse_netdev_hooks() prevents that.

Changes since v3:
- Add an rcu_head to nf_hook_ops.
- RCU-free an nft_hook along with its ops_list via call_rcu() and a
  callback.
---
 include/linux/netfilter.h         |   3 +
 include/net/netfilter/nf_tables.h |   2 +-
 net/netfilter/nf_tables_api.c     | 142 ++++++++++++++++++++++--------
 net/netfilter/nf_tables_offload.c |  49 ++++++-----
 net/netfilter/nft_chain_filter.c  |   4 +-
 5 files changed, 137 insertions(+), 63 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 2b8aac2c70ad..949ced7d58f5 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -95,6 +95,9 @@ enum nf_hook_ops_type {
 };
 
 struct nf_hook_ops {
+	struct list_head	list;
+	struct rcu_head		rcu;
+
 	/* User fills in from here down. */
 	nf_hookfn		*hook;
 	struct net_device	*dev;
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index df0b151743a2..5e49619ae49c 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1199,7 +1199,7 @@ struct nft_stats {
 
 struct nft_hook {
 	struct list_head	list;
-	struct nf_hook_ops	ops;
+	struct list_head	ops_list;
 	struct rcu_head		rcu;
 	char			ifname[IFNAMSIZ];
 	u8			ifnamelen;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8fb8bcdfdcb2..62bf498d1ec9 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -300,37 +300,60 @@ void nf_tables_unbind_chain(const struct nft_ctx *ctx, struct nft_chain *chain)
 static int nft_netdev_register_hooks(struct net *net,
 				     struct list_head *hook_list)
 {
+	struct nf_hook_ops *ops;
 	struct nft_hook *hook;
 	int err, j;
 
 	j = 0;
 	list_for_each_entry(hook, hook_list, list) {
-		err = nf_register_net_hook(net, &hook->ops);
-		if (err < 0)
-			goto err_register;
+		list_for_each_entry(ops, &hook->ops_list, list) {
+			err = nf_register_net_hook(net, ops);
+			if (err < 0)
+				goto err_register;
 
-		j++;
+			j++;
+		}
 	}
 	return 0;
 
 err_register:
 	list_for_each_entry(hook, hook_list, list) {
-		if (j-- <= 0)
-			break;
+		list_for_each_entry(ops, &hook->ops_list, list) {
+			if (j-- <= 0)
+				break;
 
-		nf_unregister_net_hook(net, &hook->ops);
+			nf_unregister_net_hook(net, ops);
+		}
 	}
 	return err;
 }
 
+static void nft_netdev_hook_free_ops(struct nft_hook *hook)
+{
+	struct nf_hook_ops *ops, *next;
+
+	list_for_each_entry_safe(ops, next, &hook->ops_list, list) {
+		list_del(&ops->list);
+		kfree(ops);
+	}
+}
+
 static void nft_netdev_hook_free(struct nft_hook *hook)
 {
+	nft_netdev_hook_free_ops(hook);
 	kfree(hook);
 }
 
+static void __nft_netdev_hook_free_rcu(struct rcu_head *rcu)
+{
+	struct nft_hook *hook = container_of(rcu, struct nft_hook, rcu);
+
+	nft_netdev_hook_free(hook);
+}
+
 static void nft_netdev_hook_free_rcu(struct nft_hook *hook)
 {
-	kfree_rcu(hook, rcu);
+	call_rcu(&hook->rcu, __nft_netdev_hook_free_rcu);
 }
 
 static void nft_netdev_unregister_hooks(struct net *net,
@@ -338,9 +361,11 @@ static void nft_netdev_unregister_hooks(struct net *net,
 					bool release_netdev)
 {
 	struct nft_hook *hook, *next;
+	struct nf_hook_ops *ops;
 
 	list_for_each_entry_safe(hook, next, hook_list, list) {
-		nf_unregister_net_hook(net, &hook->ops);
+		list_for_each_entry(ops, &hook->ops_list, list)
+			nf_unregister_net_hook(net, ops);
 		if (release_netdev) {
 			list_del(&hook->list);
 			nft_netdev_hook_free_rcu(hook);
@@ -2284,6 +2309,7 @@ void nf_tables_chain_destroy(struct nft_chain *chain)
 static struct nft_hook *nft_netdev_hook_alloc(struct net *net,
 					      const struct nlattr *attr)
 {
+	struct nf_hook_ops *ops;
 	struct net_device *dev;
 	struct nft_hook *hook;
 	int err;
@@ -2293,6 +2319,7 @@ static struct nft_hook *nft_netdev_hook_alloc(struct net *net,
 		err = -ENOMEM;
 		goto err_hook_alloc;
 	}
+	INIT_LIST_HEAD(&hook->ops_list);
 
 	err = nla_strscpy(hook->ifname, attr, IFNAMSIZ);
 	if (err < 0)
@@ -2309,7 +2336,14 @@ static struct nft_hook *nft_netdev_hook_alloc(struct net *net,
 		err = -ENOENT;
 		goto err_hook_dev;
 	}
-	hook->ops.dev = dev;
+
+	ops = kzalloc(sizeof(struct nf_hook_ops), GFP_KERNEL_ACCOUNT);
+	if (!ops) {
+		err = -ENOMEM;
+		goto err_hook_dev;
+	}
+	ops->dev = dev;
+	list_add_tail(&ops->list, &hook->ops_list);
 
 	return hook;
 
@@ -2569,6 +2603,7 @@ static int nft_basechain_init(struct nft_base_chain *basechain, u8 family,
 			      struct nft_chain_hook *hook, u32 flags)
 {
 	struct nft_chain *chain;
+	struct nf_hook_ops *ops;
 	struct nft_hook *h;
 
 	basechain->type = hook->type;
@@ -2577,8 +2612,10 @@ static int nft_basechain_init(struct nft_base_chain *basechain, u8 family,
 
 	if (nft_base_chain_netdev(family, hook->num)) {
 		list_splice_init(&hook->list, &basechain->hook_list);
-		list_for_each_entry(h, &basechain->hook_list, list)
-			nft_basechain_hook_init(&h->ops, family, hook, chain);
+		list_for_each_entry(h, &basechain->hook_list, list) {
+			list_for_each_entry(ops, &h->ops_list, list)
+				nft_basechain_hook_init(ops, family, hook, chain);
+		}
 	}
 	nft_basechain_hook_init(&basechain->ops, family, hook, chain);
 
@@ -2797,11 +2834,13 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 
 		if (nft_base_chain_netdev(ctx->family, basechain->ops.hooknum)) {
 			list_for_each_entry_safe(h, next, &hook.list, list) {
-				h->ops.pf	= basechain->ops.pf;
-				h->ops.hooknum	= basechain->ops.hooknum;
-				h->ops.priority	= basechain->ops.priority;
-				h->ops.priv	= basechain->ops.priv;
-				h->ops.hook	= basechain->ops.hook;
+				list_for_each_entry(ops, &h->ops_list, list) {
+					ops->pf		= basechain->ops.pf;
+					ops->hooknum	= basechain->ops.hooknum;
+					ops->priority	= basechain->ops.priority;
+					ops->priv	= basechain->ops.priv;
+					ops->hook	= basechain->ops.hook;
+				}
 
 				if (nft_hook_list_find(&basechain->hook_list, h)) {
 					list_del(&h->list);
@@ -2923,8 +2962,10 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 err_hooks:
 	if (nla[NFTA_CHAIN_HOOK]) {
 		list_for_each_entry_safe(h, next, &hook.list, list) {
-			if (unregister)
-				nf_unregister_net_hook(ctx->net, &h->ops);
+			if (unregister) {
+				list_for_each_entry(ops, &h->ops_list, list)
+					nf_unregister_net_hook(ctx->net, ops);
+			}
 			list_del(&h->list);
 			nft_netdev_hook_free_rcu(h);
 		}
@@ -8795,6 +8836,7 @@ static int nft_flowtable_parse_hook(const struct nft_ctx *ctx,
 				    struct netlink_ext_ack *extack, bool add)
 {
 	struct nlattr *tb[NFTA_FLOWTABLE_HOOK_MAX + 1];
+	struct nf_hook_ops *ops;
 	struct nft_hook *hook;
 	int hooknum, priority;
 	int err;
@@ -8849,11 +8891,13 @@ static int nft_flowtable_parse_hook(const struct nft_ctx *ctx,
 	}
 
 	list_for_each_entry(hook, &flowtable_hook->list, list) {
-		hook->ops.pf		= NFPROTO_NETDEV;
-		hook->ops.hooknum	= flowtable_hook->num;
-		hook->ops.priority	= flowtable_hook->priority;
-		hook->ops.priv		= &flowtable->data;
-		hook->ops.hook		= flowtable->data.type->hook;
+		list_for_each_entry(ops, &hook->ops_list, list) {
+			ops->pf		= NFPROTO_NETDEV;
+			ops->hooknum	= flowtable_hook->num;
+			ops->priority	= flowtable_hook->priority;
+			ops->priv	= &flowtable->data;
+			ops->hook	= flowtable->data.type->hook;
+		}
 	}
 
 	return err;
@@ -8910,9 +8954,11 @@ static void __nft_unregister_flowtable_net_hooks(struct net *net,
 					         bool release_netdev)
 {
 	struct nft_hook *hook, *next;
+	struct nf_hook_ops *ops;
 
 	list_for_each_entry_safe(hook, next, hook_list, list) {
-		nft_unregister_flowtable_ops(net, flowtable, &hook->ops);
+		list_for_each_entry(ops, &hook->ops_list, list)
+			nft_unregister_flowtable_ops(net, flowtable, ops);
 		if (release_netdev) {
 			list_del(&hook->list);
 			nft_netdev_hook_free_rcu(hook);
@@ -8954,6 +9000,7 @@ static int nft_register_flowtable_net_hooks(struct net *net,
 {
 	struct nft_hook *hook, *next;
 	struct nft_flowtable *ft;
+	struct nf_hook_ops *ops;
 	int err, i = 0;
 
 	list_for_each_entry(hook, hook_list, list) {
@@ -8967,21 +9014,25 @@ static int nft_register_flowtable_net_hooks(struct net *net,
 			}
 		}
 
-		err = nft_register_flowtable_ops(net, flowtable, &hook->ops);
-		if (err < 0)
-			goto err_unregister_net_hooks;
+		list_for_each_entry(ops, &hook->ops_list, list) {
+			err = nft_register_flowtable_ops(net, flowtable, ops);
+			if (err < 0)
+				goto err_unregister_net_hooks;
 
-		i++;
+			i++;
+		}
 	}
 
 	return 0;
 
 err_unregister_net_hooks:
 	list_for_each_entry_safe(hook, next, hook_list, list) {
-		if (i-- <= 0)
-			break;
+		list_for_each_entry(ops, &hook->ops_list, list) {
+			if (i-- <= 0)
+				break;
 
-		nft_unregister_flowtable_ops(net, flowtable, &hook->ops);
+			nft_unregister_flowtable_ops(net, flowtable, ops);
+		}
 		list_del_rcu(&hook->list);
 		nft_netdev_hook_free_rcu(hook);
 	}
@@ -9006,6 +9057,7 @@ static int nft_flowtable_update(struct nft_ctx *ctx, const struct nlmsghdr *nlh,
 	const struct nlattr * const *nla = ctx->nla;
 	struct nft_flowtable_hook flowtable_hook;
 	struct nft_hook *hook, *next;
+	struct nf_hook_ops *ops;
 	struct nft_trans *trans;
 	bool unregister = false;
 	u32 flags;
@@ -9063,8 +9115,11 @@ static int nft_flowtable_update(struct nft_ctx *ctx, const struct nlmsghdr *nlh,
 
 err_flowtable_update_hook:
 	list_for_each_entry_safe(hook, next, &flowtable_hook.list, list) {
-		if (unregister)
-			nft_unregister_flowtable_ops(ctx->net, flowtable, &hook->ops);
+		if (unregister) {
+			list_for_each_entry(ops, &hook->ops_list, list)
+				nft_unregister_flowtable_ops(ctx->net,
+							     flowtable, ops);
+		}
 		list_del_rcu(&hook->list);
 		nft_netdev_hook_free_rcu(hook);
 	}
@@ -9611,9 +9666,12 @@ static int nf_tables_fill_gen_info(struct sk_buff *skb, struct net *net,
 struct nf_hook_ops *nft_hook_find_ops(const struct nft_hook *hook,
 				      const struct net_device *dev)
 {
-	if (hook->ops.dev == dev)
-		return (struct nf_hook_ops *)&hook->ops;
+	struct nf_hook_ops *ops;
 
+	list_for_each_entry(ops, &hook->ops_list, list) {
+		if (ops->dev == dev)
+			return ops;
+	}
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(nft_hook_find_ops);
@@ -9621,7 +9679,13 @@ EXPORT_SYMBOL_GPL(nft_hook_find_ops);
 struct nf_hook_ops *nft_hook_find_ops_rcu(const struct nft_hook *hook,
 					  const struct net_device *dev)
 {
-	return nft_hook_find_ops(hook, dev);
+	struct nf_hook_ops *ops;
+
+	list_for_each_entry_rcu(ops, &hook->ops_list, list) {
+		if (ops->dev == dev)
+			return ops;
+	}
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(nft_hook_find_ops_rcu);
 
@@ -9638,8 +9702,8 @@ static void nft_flowtable_event(unsigned long event, struct net_device *dev,
 
 		/* flow_offload_netdev_event() cleans up entries for us. */
 		nft_unregister_flowtable_ops(dev_net(dev), flowtable, ops);
-		list_del_rcu(&hook->list);
-		kfree_rcu(hook, rcu);
+		list_del_rcu(&ops->list);
+		kfree_rcu(ops, rcu);
 		break;
 	}
 }
diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 75b756f0b9f0..fd30e205de84 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -220,6 +220,7 @@ static int nft_chain_offload_priority(const struct nft_base_chain *basechain)
 
 bool nft_chain_offload_support(const struct nft_base_chain *basechain)
 {
+	struct nf_hook_ops *ops;
 	struct net_device *dev;
 	struct nft_hook *hook;
 
@@ -227,13 +228,16 @@ bool nft_chain_offload_support(const struct nft_base_chain *basechain)
 		return false;
 
 	list_for_each_entry(hook, &basechain->hook_list, list) {
-		if (hook->ops.pf != NFPROTO_NETDEV ||
-		    hook->ops.hooknum != NF_NETDEV_INGRESS)
-			return false;
-
-		dev = hook->ops.dev;
-		if (!dev->netdev_ops->ndo_setup_tc && !flow_indr_dev_exists())
-			return false;
+		list_for_each_entry(ops, &hook->ops_list, list) {
+			if (ops->pf != NFPROTO_NETDEV ||
+			    ops->hooknum != NF_NETDEV_INGRESS)
+				return false;
+
+			dev = ops->dev;
+			if (!dev->netdev_ops->ndo_setup_tc &&
+			    !flow_indr_dev_exists())
+				return false;
+		}
 	}
 
 	return true;
@@ -455,34 +459,37 @@ static int nft_flow_block_chain(struct nft_base_chain *basechain,
 				const struct net_device *this_dev,
 				enum flow_block_command cmd)
 {
-	struct net_device *dev;
+	struct nf_hook_ops *ops;
 	struct nft_hook *hook;
 	int err, i = 0;
 
 	list_for_each_entry(hook, &basechain->hook_list, list) {
-		dev = hook->ops.dev;
-		if (this_dev && this_dev != dev)
-			continue;
+		list_for_each_entry(ops, &hook->ops_list, list) {
+			if (this_dev && this_dev != ops->dev)
+				continue;
 
-		err = nft_chain_offload_cmd(basechain, dev, cmd);
-		if (err < 0 && cmd == FLOW_BLOCK_BIND) {
-			if (!this_dev)
-				goto err_flow_block;
+			err = nft_chain_offload_cmd(basechain, ops->dev, cmd);
+			if (err < 0 && cmd == FLOW_BLOCK_BIND) {
+				if (!this_dev)
+					goto err_flow_block;
 
-			return err;
+				return err;
+			}
+			i++;
 		}
-		i++;
 	}
 
 	return 0;
 
 err_flow_block:
 	list_for_each_entry(hook, &basechain->hook_list, list) {
-		if (i-- <= 0)
-			break;
+		list_for_each_entry(ops, &hook->ops_list, list) {
+			if (i-- <= 0)
+				break;
 
-		dev = hook->ops.dev;
-		nft_chain_offload_cmd(basechain, dev, FLOW_BLOCK_UNBIND);
+			nft_chain_offload_cmd(basechain, ops->dev,
+					      FLOW_BLOCK_UNBIND);
+		}
 	}
 	return err;
 }
diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 783e4b5ef3e0..862eab45851a 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -332,8 +332,8 @@ static void nft_netdev_event(unsigned long event, struct net_device *dev,
 		if (!(basechain->chain.table->flags & NFT_TABLE_F_DORMANT))
 			nf_unregister_net_hook(dev_net(dev), ops);
 
-		list_del_rcu(&hook->list);
-		kfree_rcu(hook, rcu);
+		list_del_rcu(&ops->list);
+		kfree_rcu(ops, rcu);
 		break;
 	}
 }
-- 
2.49.0


