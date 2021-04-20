Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67613658DC
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Apr 2021 14:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhDTMZz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Apr 2021 08:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhDTMZz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Apr 2021 08:25:55 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF185C06174A
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Apr 2021 05:25:23 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lYpRS-0008E9-Ft; Tue, 20 Apr 2021 14:25:22 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 02/12] netfilter: x_tables: remove ipt_unregister_table
Date:   Tue, 20 Apr 2021 14:24:57 +0200
Message-Id: <20210420122507.505-3-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210420122507.505-1-fw@strlen.de>
References: <20210420122507.505-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Its the same function as ipt_unregister_table_exit.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter_ipv4/ip_tables.h  | 3 ---
 include/linux/netfilter_ipv6/ip6_tables.h | 2 --
 net/ipv4/netfilter/ip_tables.c            | 6 +-----
 net/ipv4/netfilter/iptable_nat.c          | 2 +-
 net/ipv6/netfilter/ip6_tables.c           | 9 ---------
 net/ipv6/netfilter/ip6table_nat.c         | 2 +-
 6 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/include/linux/netfilter_ipv4/ip_tables.h b/include/linux/netfilter_ipv4/ip_tables.h
index c4676d6feeff..9f440eb6cf6c 100644
--- a/include/linux/netfilter_ipv4/ip_tables.h
+++ b/include/linux/netfilter_ipv4/ip_tables.h
@@ -31,9 +31,6 @@ void ipt_unregister_table_pre_exit(struct net *net, struct xt_table *table,
 
 void ipt_unregister_table_exit(struct net *net, struct xt_table *table);
 
-void ipt_unregister_table(struct net *net, struct xt_table *table,
-			  const struct nf_hook_ops *ops);
-
 /* Standard entry. */
 struct ipt_standard {
 	struct ipt_entry entry;
diff --git a/include/linux/netfilter_ipv6/ip6_tables.h b/include/linux/netfilter_ipv6/ip6_tables.h
index 1547d5f9ae06..b88a27ce61b0 100644
--- a/include/linux/netfilter_ipv6/ip6_tables.h
+++ b/include/linux/netfilter_ipv6/ip6_tables.h
@@ -27,8 +27,6 @@ extern void *ip6t_alloc_initial_table(const struct xt_table *);
 int ip6t_register_table(struct net *net, const struct xt_table *table,
 			const struct ip6t_replace *repl,
 			const struct nf_hook_ops *ops, struct xt_table **res);
-void ip6t_unregister_table(struct net *net, struct xt_table *table,
-			   const struct nf_hook_ops *ops);
 void ip6t_unregister_table_pre_exit(struct net *net, struct xt_table *table,
 				    const struct nf_hook_ops *ops);
 void ip6t_unregister_table_exit(struct net *net, struct xt_table *table);
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index f77ea0dbe656..e2521ccb056c 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1770,11 +1770,8 @@ void ipt_unregister_table_exit(struct net *net, struct xt_table *table)
 	__ipt_unregister_table(net, table);
 }
 
-void ipt_unregister_table(struct net *net, struct xt_table *table,
-			  const struct nf_hook_ops *ops)
+void ipt_unregister_table(struct net *net, struct xt_table *table)
 {
-	if (ops)
-		ipt_unregister_table_pre_exit(net, table, ops);
 	__ipt_unregister_table(net, table);
 }
 
@@ -1924,7 +1921,6 @@ static void __exit ip_tables_fini(void)
 }
 
 EXPORT_SYMBOL(ipt_register_table);
-EXPORT_SYMBOL(ipt_unregister_table);
 EXPORT_SYMBOL(ipt_unregister_table_pre_exit);
 EXPORT_SYMBOL(ipt_unregister_table_exit);
 EXPORT_SYMBOL(ipt_do_table);
diff --git a/net/ipv4/netfilter/iptable_nat.c b/net/ipv4/netfilter/iptable_nat.c
index b0143b109f25..a89c1b9f94c2 100644
--- a/net/ipv4/netfilter/iptable_nat.c
+++ b/net/ipv4/netfilter/iptable_nat.c
@@ -105,7 +105,7 @@ static int __net_init iptable_nat_table_init(struct net *net)
 
 	ret = ipt_nat_register_lookups(net);
 	if (ret < 0) {
-		ipt_unregister_table(net, net->ipv4.nat_table, NULL);
+		ipt_unregister_table_exit(net, net->ipv4.nat_table);
 		net->ipv4.nat_table = NULL;
 	}
 
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index eb2b5404806c..e605c28cfed5 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1780,14 +1780,6 @@ void ip6t_unregister_table_exit(struct net *net, struct xt_table *table)
 	__ip6t_unregister_table(net, table);
 }
 
-void ip6t_unregister_table(struct net *net, struct xt_table *table,
-			   const struct nf_hook_ops *ops)
-{
-	if (ops)
-		ip6t_unregister_table_pre_exit(net, table, ops);
-	__ip6t_unregister_table(net, table);
-}
-
 /* Returns 1 if the type and code is matched by the range, 0 otherwise */
 static inline bool
 icmp6_type_code_match(u_int8_t test_type, u_int8_t min_code, u_int8_t max_code,
@@ -1935,7 +1927,6 @@ static void __exit ip6_tables_fini(void)
 }
 
 EXPORT_SYMBOL(ip6t_register_table);
-EXPORT_SYMBOL(ip6t_unregister_table);
 EXPORT_SYMBOL(ip6t_unregister_table_pre_exit);
 EXPORT_SYMBOL(ip6t_unregister_table_exit);
 EXPORT_SYMBOL(ip6t_do_table);
diff --git a/net/ipv6/netfilter/ip6table_nat.c b/net/ipv6/netfilter/ip6table_nat.c
index 0a23265e3caa..4cef1b405074 100644
--- a/net/ipv6/netfilter/ip6table_nat.c
+++ b/net/ipv6/netfilter/ip6table_nat.c
@@ -107,7 +107,7 @@ static int __net_init ip6table_nat_table_init(struct net *net)
 
 	ret = ip6t_nat_register_lookups(net);
 	if (ret < 0) {
-		ip6t_unregister_table(net, net->ipv6.ip6table_nat, NULL);
+		ip6t_unregister_table_exit(net, net->ipv6.ip6table_nat);
 		net->ipv6.ip6table_nat = NULL;
 	}
 	kfree(repl);
-- 
2.26.3

