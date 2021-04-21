Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024FD366677
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Apr 2021 09:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbhDUHwD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Apr 2021 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbhDUHwA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:52:00 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C4AC06174A
        for <netfilter-devel@vger.kernel.org>; Wed, 21 Apr 2021 00:51:27 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lZ7du-0004sJ-Af; Wed, 21 Apr 2021 09:51:26 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v2 04/12] netfilter: iptables: unregister the tables by name
Date:   Wed, 21 Apr 2021 09:51:02 +0200
Message-Id: <20210421075110.19334-5-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421075110.19334-1-fw@strlen.de>
References: <20210421075110.19334-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

xtables stores the xt_table structs in the struct net.  This isn't
needed anymore, the structures could be passed via the netfilter hook
'private' pointer to the hook functions, which would allow us to remove
those pointers from struct net.

As a first step, reduce the number of accesses to the
net->ipv4.ip6table_{raw,filter,...} pointers.
This allows the tables to get unregistered by name instead of having to
pass the raw address.

The xt_table structure cane looked up by name+address family instead.

This patch is useless as-is (the backends still have the raw pointer
address), but it lowers the bar to remove those.

It also allows to put the 'was table registered in the first place' check
into ip_tables.c rather than have it in each table sub module.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter_ipv4/ip_tables.h |  6 +++---
 net/ipv4/netfilter/ip_tables.c           | 14 ++++++++++----
 net/ipv4/netfilter/iptable_filter.c      |  8 ++------
 net/ipv4/netfilter/iptable_mangle.c      |  8 ++------
 net/ipv4/netfilter/iptable_nat.c         |  6 ++----
 net/ipv4/netfilter/iptable_raw.c         |  8 ++------
 net/ipv4/netfilter/iptable_security.c    |  8 ++------
 7 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/include/linux/netfilter_ipv4/ip_tables.h b/include/linux/netfilter_ipv4/ip_tables.h
index 9f440eb6cf6c..73bcf7f261d2 100644
--- a/include/linux/netfilter_ipv4/ip_tables.h
+++ b/include/linux/netfilter_ipv4/ip_tables.h
@@ -26,10 +26,10 @@ int ipt_register_table(struct net *net, const struct xt_table *table,
 		       const struct ipt_replace *repl,
 		       const struct nf_hook_ops *ops, struct xt_table **res);
 
-void ipt_unregister_table_pre_exit(struct net *net, struct xt_table *table,
-		       const struct nf_hook_ops *ops);
+void ipt_unregister_table_pre_exit(struct net *net, const char *name,
+				   const struct nf_hook_ops *ops);
 
-void ipt_unregister_table_exit(struct net *net, struct xt_table *table);
+void ipt_unregister_table_exit(struct net *net, const char *name);
 
 /* Standard entry. */
 struct ipt_standard {
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 2fa7f28b88e3..0b859ec2d3f8 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1759,15 +1759,21 @@ int ipt_register_table(struct net *net, const struct xt_table *table,
 	return ret;
 }
 
-void ipt_unregister_table_pre_exit(struct net *net, struct xt_table *table,
+void ipt_unregister_table_pre_exit(struct net *net, const char *name,
 				   const struct nf_hook_ops *ops)
 {
-	nf_unregister_net_hooks(net, ops, hweight32(table->valid_hooks));
+	struct xt_table *table = xt_find_table(net, NFPROTO_IPV4, name);
+
+	if (table)
+		nf_unregister_net_hooks(net, ops, hweight32(table->valid_hooks));
 }
 
-void ipt_unregister_table_exit(struct net *net, struct xt_table *table)
+void ipt_unregister_table_exit(struct net *net, const char *name)
 {
-	__ipt_unregister_table(net, table);
+	struct xt_table *table = xt_find_table(net, NFPROTO_IPV4, name);
+
+	if (table)
+		__ipt_unregister_table(net, table);
 }
 
 /* Returns 1 if the type and code is matched by the range, 0 otherwise */
diff --git a/net/ipv4/netfilter/iptable_filter.c b/net/ipv4/netfilter/iptable_filter.c
index 8f7bc1ee7453..a39998c7977f 100644
--- a/net/ipv4/netfilter/iptable_filter.c
+++ b/net/ipv4/netfilter/iptable_filter.c
@@ -74,16 +74,12 @@ static int __net_init iptable_filter_net_init(struct net *net)
 
 static void __net_exit iptable_filter_net_pre_exit(struct net *net)
 {
-	if (net->ipv4.iptable_filter)
-		ipt_unregister_table_pre_exit(net, net->ipv4.iptable_filter,
-					      filter_ops);
+	ipt_unregister_table_pre_exit(net, "filter", filter_ops);
 }
 
 static void __net_exit iptable_filter_net_exit(struct net *net)
 {
-	if (!net->ipv4.iptable_filter)
-		return;
-	ipt_unregister_table_exit(net, net->ipv4.iptable_filter);
+	ipt_unregister_table_exit(net, "filter");
 	net->ipv4.iptable_filter = NULL;
 }
 
diff --git a/net/ipv4/netfilter/iptable_mangle.c b/net/ipv4/netfilter/iptable_mangle.c
index 833079589273..7d1713e22553 100644
--- a/net/ipv4/netfilter/iptable_mangle.c
+++ b/net/ipv4/netfilter/iptable_mangle.c
@@ -102,16 +102,12 @@ static int __net_init iptable_mangle_table_init(struct net *net)
 
 static void __net_exit iptable_mangle_net_pre_exit(struct net *net)
 {
-	if (net->ipv4.iptable_mangle)
-		ipt_unregister_table_pre_exit(net, net->ipv4.iptable_mangle,
-					      mangle_ops);
+	ipt_unregister_table_pre_exit(net, "mangle", mangle_ops);
 }
 
 static void __net_exit iptable_mangle_net_exit(struct net *net)
 {
-	if (!net->ipv4.iptable_mangle)
-		return;
-	ipt_unregister_table_exit(net, net->ipv4.iptable_mangle);
+	ipt_unregister_table_exit(net, "mangle");
 	net->ipv4.iptable_mangle = NULL;
 }
 
diff --git a/net/ipv4/netfilter/iptable_nat.c b/net/ipv4/netfilter/iptable_nat.c
index a89c1b9f94c2..16bf3009642e 100644
--- a/net/ipv4/netfilter/iptable_nat.c
+++ b/net/ipv4/netfilter/iptable_nat.c
@@ -105,7 +105,7 @@ static int __net_init iptable_nat_table_init(struct net *net)
 
 	ret = ipt_nat_register_lookups(net);
 	if (ret < 0) {
-		ipt_unregister_table_exit(net, net->ipv4.nat_table);
+		ipt_unregister_table_exit(net, "nat");
 		net->ipv4.nat_table = NULL;
 	}
 
@@ -121,9 +121,7 @@ static void __net_exit iptable_nat_net_pre_exit(struct net *net)
 
 static void __net_exit iptable_nat_net_exit(struct net *net)
 {
-	if (!net->ipv4.nat_table)
-		return;
-	ipt_unregister_table_exit(net, net->ipv4.nat_table);
+	ipt_unregister_table_exit(net, "nat");
 	net->ipv4.nat_table = NULL;
 }
 
diff --git a/net/ipv4/netfilter/iptable_raw.c b/net/ipv4/netfilter/iptable_raw.c
index 9abfe6bf2cb9..a1f556464b93 100644
--- a/net/ipv4/netfilter/iptable_raw.c
+++ b/net/ipv4/netfilter/iptable_raw.c
@@ -69,16 +69,12 @@ static int __net_init iptable_raw_table_init(struct net *net)
 
 static void __net_exit iptable_raw_net_pre_exit(struct net *net)
 {
-	if (net->ipv4.iptable_raw)
-		ipt_unregister_table_pre_exit(net, net->ipv4.iptable_raw,
-					      rawtable_ops);
+	ipt_unregister_table_pre_exit(net, "raw", rawtable_ops);
 }
 
 static void __net_exit iptable_raw_net_exit(struct net *net)
 {
-	if (!net->ipv4.iptable_raw)
-		return;
-	ipt_unregister_table_exit(net, net->ipv4.iptable_raw);
+	ipt_unregister_table_exit(net, "raw");
 	net->ipv4.iptable_raw = NULL;
 }
 
diff --git a/net/ipv4/netfilter/iptable_security.c b/net/ipv4/netfilter/iptable_security.c
index 415c1975d770..33eded4f9080 100644
--- a/net/ipv4/netfilter/iptable_security.c
+++ b/net/ipv4/netfilter/iptable_security.c
@@ -64,16 +64,12 @@ static int __net_init iptable_security_table_init(struct net *net)
 
 static void __net_exit iptable_security_net_pre_exit(struct net *net)
 {
-	if (net->ipv4.iptable_security)
-		ipt_unregister_table_pre_exit(net, net->ipv4.iptable_security,
-					      sectbl_ops);
+	ipt_unregister_table_pre_exit(net, "security", sectbl_ops);
 }
 
 static void __net_exit iptable_security_net_exit(struct net *net)
 {
-	if (!net->ipv4.iptable_security)
-		return;
-	ipt_unregister_table_exit(net, net->ipv4.iptable_security);
+	ipt_unregister_table_exit(net, "security");
 	net->ipv4.iptable_security = NULL;
 }
 
-- 
2.26.3

