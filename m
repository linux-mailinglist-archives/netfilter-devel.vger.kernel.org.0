Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BED436667B
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Apr 2021 09:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbhDUHwL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Apr 2021 03:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237430AbhDUHwI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:52:08 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7218FC06138E
        for <netfilter-devel@vger.kernel.org>; Wed, 21 Apr 2021 00:51:32 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lZ7dz-0004sp-1Z; Wed, 21 Apr 2021 09:51:31 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v2 08/12] netfilter: xt_nat: pass table to hookfn
Date:   Wed, 21 Apr 2021 09:51:06 +0200
Message-Id: <20210421075110.19334-9-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421075110.19334-1-fw@strlen.de>
References: <20210421075110.19334-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This changes how ip(6)table nat passes the ruleset/table to the
evaluation loop.

At the moment, it will fetch the table from struct net.

This change stores the table in the hook_ops 'priv' argument
instead.

This requires to duplicate the hook_ops for each netns, so
they can store the (per-net) xt_table structure.

The dupliated nat hook_ops get stored in net_generic data area.
They are free'd in the namespace exit path.

This is a pre-requisite to remove the xt_table/ruleset pointers
from struct net.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv4/netfilter/iptable_nat.c  | 44 +++++++++++++++++++++++-------
 net/ipv6/netfilter/ip6table_nat.c | 45 ++++++++++++++++++++++++-------
 2 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/net/ipv4/netfilter/iptable_nat.c b/net/ipv4/netfilter/iptable_nat.c
index f4afd28ccc06..dfa9dc63a7b5 100644
--- a/net/ipv4/netfilter/iptable_nat.c
+++ b/net/ipv4/netfilter/iptable_nat.c
@@ -13,8 +13,14 @@
 
 #include <net/netfilter/nf_nat.h>
 
+struct iptable_nat_pernet {
+	struct nf_hook_ops *nf_nat_ops;
+};
+
 static int __net_init iptable_nat_table_init(struct net *net);
 
+static unsigned int iptable_nat_net_id __read_mostly;
+
 static const struct xt_table nf_nat_ipv4_table = {
 	.name		= "nat",
 	.valid_hooks	= (1 << NF_INET_PRE_ROUTING) |
@@ -30,7 +36,7 @@ static unsigned int iptable_nat_do_chain(void *priv,
 					 struct sk_buff *skb,
 					 const struct nf_hook_state *state)
 {
-	return ipt_do_table(skb, state, state->net->ipv4.nat_table);
+	return ipt_do_table(skb, state, priv);
 }
 
 static const struct nf_hook_ops nf_nat_ipv4_ops[] = {
@@ -60,50 +66,67 @@ static const struct nf_hook_ops nf_nat_ipv4_ops[] = {
 	},
 };
 
-static int ipt_nat_register_lookups(struct net *net)
+static int ipt_nat_register_lookups(struct net *net, struct xt_table *table)
 {
+	struct nf_hook_ops *ops = kmemdup(nf_nat_ipv4_ops, sizeof(nf_nat_ipv4_ops), GFP_KERNEL);
+	struct iptable_nat_pernet *xt_nat_net = net_generic(net, iptable_nat_net_id);
 	int i, ret;
 
+	if (!ops)
+		return -ENOMEM;
+
 	for (i = 0; i < ARRAY_SIZE(nf_nat_ipv4_ops); i++) {
-		ret = nf_nat_ipv4_register_fn(net, &nf_nat_ipv4_ops[i]);
+		ops[i].priv = table;
+		ret = nf_nat_ipv4_register_fn(net, &ops[i]);
 		if (ret) {
 			while (i)
-				nf_nat_ipv4_unregister_fn(net, &nf_nat_ipv4_ops[--i]);
+				nf_nat_ipv4_unregister_fn(net, &ops[--i]);
 
+			kfree(ops);
 			return ret;
 		}
 	}
 
+	xt_nat_net->nf_nat_ops = ops;
 	return 0;
 }
 
 static void ipt_nat_unregister_lookups(struct net *net)
 {
+	struct iptable_nat_pernet *xt_nat_net = net_generic(net, iptable_nat_net_id);
+	struct nf_hook_ops *ops = xt_nat_net->nf_nat_ops;
 	int i;
 
+	if (!ops)
+		return;
+
 	for (i = 0; i < ARRAY_SIZE(nf_nat_ipv4_ops); i++)
-		nf_nat_ipv4_unregister_fn(net, &nf_nat_ipv4_ops[i]);
+		nf_nat_ipv4_unregister_fn(net, &ops[i]);
+
+	kfree(ops);
 }
 
 static int __net_init iptable_nat_table_init(struct net *net)
 {
 	struct ipt_replace *repl;
+	struct xt_table *table;
 	int ret;
 
 	repl = ipt_alloc_initial_table(&nf_nat_ipv4_table);
 	if (repl == NULL)
 		return -ENOMEM;
 	ret = ipt_register_table(net, &nf_nat_ipv4_table, repl,
-				 NULL, &net->ipv4.nat_table);
+				 NULL, &table);
 	if (ret < 0) {
 		kfree(repl);
 		return ret;
 	}
 
-	ret = ipt_nat_register_lookups(net);
+	ret = ipt_nat_register_lookups(net, table);
 	if (ret < 0) {
 		ipt_unregister_table_exit(net, "nat");
-		net->ipv4.nat_table = NULL;
+	} else {
+		net->ipv4.nat_table = table;
 	}
 
 	kfree(repl);
@@ -112,8 +135,7 @@ static int __net_init iptable_nat_table_init(struct net *net)
 
 static void __net_exit iptable_nat_net_pre_exit(struct net *net)
 {
-	if (net->ipv4.nat_table)
-		ipt_nat_unregister_lookups(net);
+	ipt_nat_unregister_lookups(net);
 }
 
 static void __net_exit iptable_nat_net_exit(struct net *net)
@@ -125,6 +147,8 @@ static void __net_exit iptable_nat_net_exit(struct net *net)
 static struct pernet_operations iptable_nat_net_ops = {
 	.pre_exit = iptable_nat_net_pre_exit,
 	.exit	= iptable_nat_net_exit,
+	.id	= &iptable_nat_net_id,
+	.size	= sizeof(struct iptable_nat_pernet),
 };
 
 static int __init iptable_nat_init(void)
diff --git a/net/ipv6/netfilter/ip6table_nat.c b/net/ipv6/netfilter/ip6table_nat.c
index c7f98755191b..69b7f9601d03 100644
--- a/net/ipv6/netfilter/ip6table_nat.c
+++ b/net/ipv6/netfilter/ip6table_nat.c
@@ -15,8 +15,14 @@
 
 #include <net/netfilter/nf_nat.h>
 
+struct ip6table_nat_pernet {
+	struct nf_hook_ops *nf_nat_ops;
+};
+
 static int __net_init ip6table_nat_table_init(struct net *net);
 
+static unsigned int ip6table_nat_net_id __read_mostly;
+
 static const struct xt_table nf_nat_ipv6_table = {
 	.name		= "nat",
 	.valid_hooks	= (1 << NF_INET_PRE_ROUTING) |
@@ -32,7 +38,7 @@ static unsigned int ip6table_nat_do_chain(void *priv,
 					  struct sk_buff *skb,
 					  const struct nf_hook_state *state)
 {
-	return ip6t_do_table(skb, state, state->net->ipv6.ip6table_nat);
+	return ip6t_do_table(skb, state, priv);
 }
 
 static const struct nf_hook_ops nf_nat_ipv6_ops[] = {
@@ -62,59 +68,76 @@ static const struct nf_hook_ops nf_nat_ipv6_ops[] = {
 	},
 };
 
-static int ip6t_nat_register_lookups(struct net *net)
+static int ip6t_nat_register_lookups(struct net *net, struct xt_table *table)
 {
+	struct nf_hook_ops *ops = kmemdup(nf_nat_ipv6_ops, sizeof(nf_nat_ipv6_ops), GFP_KERNEL);
+	struct ip6table_nat_pernet *xt_nat_net = net_generic(net, ip6table_nat_net_id);
 	int i, ret;
 
+	if (!ops)
+		return -ENOMEM;
+
 	for (i = 0; i < ARRAY_SIZE(nf_nat_ipv6_ops); i++) {
-		ret = nf_nat_ipv6_register_fn(net, &nf_nat_ipv6_ops[i]);
+		ops[i].priv = table;
+		ret = nf_nat_ipv6_register_fn(net, &ops[i]);
 		if (ret) {
 			while (i)
-				nf_nat_ipv6_unregister_fn(net, &nf_nat_ipv6_ops[--i]);
+				nf_nat_ipv6_unregister_fn(net, &ops[--i]);
 
+			kfree(ops);
 			return ret;
 		}
 	}
 
+	xt_nat_net->nf_nat_ops = ops;
 	return 0;
 }
 
 static void ip6t_nat_unregister_lookups(struct net *net)
 {
+	struct ip6table_nat_pernet *xt_nat_net = net_generic(net, ip6table_nat_net_id);
+	struct nf_hook_ops *ops = xt_nat_net->nf_nat_ops;
 	int i;
 
+	if (!ops)
+		return;
+
 	for (i = 0; i < ARRAY_SIZE(nf_nat_ipv6_ops); i++)
-		nf_nat_ipv6_unregister_fn(net, &nf_nat_ipv6_ops[i]);
+		nf_nat_ipv6_unregister_fn(net, &ops[i]);
+
+	kfree(ops);
 }
 
 static int __net_init ip6table_nat_table_init(struct net *net)
 {
 	struct ip6t_replace *repl;
+	struct xt_table *table;
 	int ret;
 
 	repl = ip6t_alloc_initial_table(&nf_nat_ipv6_table);
 	if (repl == NULL)
 		return -ENOMEM;
 	ret = ip6t_register_table(net, &nf_nat_ipv6_table, repl,
-				  NULL, &net->ipv6.ip6table_nat);
+				  NULL, &table);
 	if (ret < 0) {
 		kfree(repl);
 		return ret;
 	}
 
-	ret = ip6t_nat_register_lookups(net);
+	ret = ip6t_nat_register_lookups(net, table);
 	if (ret < 0) {
 		ip6t_unregister_table_exit(net, "nat");
-		net->ipv6.ip6table_nat = NULL;
+	} else {
+		net->ipv6.ip6table_nat = table;
 	}
+
 	kfree(repl);
 	return ret;
 }
 
 static void __net_exit ip6table_nat_net_pre_exit(struct net *net)
 {
-	if (net->ipv6.ip6table_nat)
-		ip6t_nat_unregister_lookups(net);
+	ip6t_nat_unregister_lookups(net);
 }
 
 static void __net_exit ip6table_nat_net_exit(struct net *net)
@@ -126,6 +149,8 @@ static void __net_exit ip6table_nat_net_exit(struct net *net)
 static struct pernet_operations ip6table_nat_net_ops = {
 	.pre_exit = ip6table_nat_net_pre_exit,
 	.exit	= ip6table_nat_net_exit,
+	.id	= &ip6table_nat_net_id,
+	.size	= sizeof(struct ip6table_nat_pernet),
 };
 
 static int __init ip6table_nat_init(void)
-- 
2.26.3

