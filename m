Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA2446F7EB
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Dec 2021 01:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhLJAQQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Dec 2021 19:16:16 -0500
Received: from mail.netfilter.org ([217.70.188.207]:44344 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbhLJAQP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:16:15 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 5B6EA6009B
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Dec 2021 01:10:16 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 5/5] netfilter: nf_tables: make counter support built-in
Date:   Fri, 10 Dec 2021 01:12:31 +0100
Message-Id: <20211210001231.144098-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210001231.144098-1-pablo@netfilter.org>
References: <20211210001231.144098-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Make counter support built-in to allow for direct call in case of
CONFIG_RETPOLINE.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables_core.h |  4 ++
 net/netfilter/Kconfig                  |  6 ---
 net/netfilter/Makefile                 |  3 +-
 net/netfilter/nf_tables_core.c         |  3 ++
 net/netfilter/nft_counter.c            | 59 +++++++-------------------
 5 files changed, 24 insertions(+), 51 deletions(-)

diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
index 0fa5a6d98a00..c66a0d9af95a 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -7,6 +7,7 @@
 
 extern struct nft_expr_type nft_imm_type;
 extern struct nft_expr_type nft_cmp_type;
+extern struct nft_expr_type nft_counter_type;
 extern struct nft_expr_type nft_lookup_type;
 extern struct nft_expr_type nft_bitwise_type;
 extern struct nft_expr_type nft_byteorder_type;
@@ -21,6 +22,7 @@ extern struct nft_expr_type nft_last_type;
 #ifdef CONFIG_NETWORK_SECMARK
 extern struct nft_object_type nft_secmark_obj_type;
 #endif
+extern struct nft_object_type nft_counter_obj_type;
 
 int nf_tables_core_module_init(void);
 void nf_tables_core_module_exit(void);
@@ -143,4 +145,6 @@ void nft_dynset_eval(const struct nft_expr *expr,
 		     struct nft_regs *regs, const struct nft_pktinfo *pkt);
 void nft_rt_get_eval(const struct nft_expr *expr,
 		     struct nft_regs *regs, const struct nft_pktinfo *pkt);
+void nft_counter_eval(const struct nft_expr *expr, struct nft_regs *regs,
+                      const struct nft_pktinfo *pkt);
 #endif /* _NET_NF_TABLES_CORE_H */
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 3646fc195e7d..ddc54b6d18ee 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -515,12 +515,6 @@ config NFT_FLOW_OFFLOAD
 	  This option adds the "flow_offload" expression that you can use to
 	  choose what flows are placed into the hardware.
 
-config NFT_COUNTER
-	tristate "Netfilter nf_tables counter module"
-	help
-	  This option adds the "counter" expression that you can use to
-	  include packet and byte counters in a rule.
-
 config NFT_CONNLIMIT
 	tristate "Netfilter nf_tables connlimit module"
 	depends on NF_CONNTRACK
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index aab20e575ecd..a135b1a46014 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -75,7 +75,7 @@ nf_tables-objs := nf_tables_core.o nf_tables_api.o nft_chain_filter.o \
 		  nf_tables_trace.o nft_immediate.o nft_cmp.o nft_range.o \
 		  nft_bitwise.o nft_byteorder.o nft_payload.o nft_lookup.o \
 		  nft_dynset.o nft_meta.o nft_rt.o nft_exthdr.o nft_last.o \
-		  nft_chain_route.o nf_tables_offload.o \
+		  nft_counter.o nft_chain_route.o nf_tables_offload.o \
 		  nft_set_hash.o nft_set_bitmap.o nft_set_rbtree.o \
 		  nft_set_pipapo.o
 
@@ -100,7 +100,6 @@ obj-$(CONFIG_NFT_REJECT) 	+= nft_reject.o
 obj-$(CONFIG_NFT_REJECT_INET)	+= nft_reject_inet.o
 obj-$(CONFIG_NFT_REJECT_NETDEV)	+= nft_reject_netdev.o
 obj-$(CONFIG_NFT_TUNNEL)	+= nft_tunnel.o
-obj-$(CONFIG_NFT_COUNTER)	+= nft_counter.o
 obj-$(CONFIG_NFT_LOG)		+= nft_log.o
 obj-$(CONFIG_NFT_MASQ)		+= nft_masq.o
 obj-$(CONFIG_NFT_REDIR)		+= nft_redir.o
diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index d2ada666d889..1fe4911e7e72 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -169,6 +169,7 @@ static void expr_call_ops_eval(const struct nft_expr *expr,
 
 	X(e, nft_payload_eval);
 	X(e, nft_cmp_eval);
+	X(e, nft_counter_eval);
 	X(e, nft_meta_get_eval);
 	X(e, nft_lookup_eval);
 	X(e, nft_range_eval);
@@ -292,12 +293,14 @@ static struct nft_expr_type *nft_basic_types[] = {
 	&nft_rt_type,
 	&nft_exthdr_type,
 	&nft_last_type,
+	&nft_counter_type,
 };
 
 static struct nft_object_type *nft_basic_objects[] = {
 #ifdef CONFIG_NETWORK_SECMARK
 	&nft_secmark_obj_type,
 #endif
+	&nft_counter_obj_type,
 };
 
 int __init nf_tables_core_module_init(void)
diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index 8edd3b3c173d..3cbacfb9168c 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -55,11 +55,21 @@ static inline void nft_counter_obj_eval(struct nft_object *obj,
 	nft_counter_do_eval(priv, regs, pkt);
 }
 
+static bool nft_counter_initialized;
+
 static int nft_counter_do_init(const struct nlattr * const tb[],
 			       struct nft_counter_percpu_priv *priv)
 {
 	struct nft_counter __percpu *cpu_stats;
 	struct nft_counter *this_cpu;
+	int cpu;
+
+	if (unlikely(!nft_counter_initialized)) {
+		for_each_possible_cpu(cpu)
+			seqcount_init(per_cpu_ptr(&nft_counter_seq, cpu));
+
+		nft_counter_initialized = true;
+	}
 
 	cpu_stats = alloc_percpu(struct nft_counter);
 	if (cpu_stats == NULL)
@@ -174,7 +184,7 @@ static const struct nla_policy nft_counter_policy[NFTA_COUNTER_MAX + 1] = {
 	[NFTA_COUNTER_BYTES]	= { .type = NLA_U64 },
 };
 
-static struct nft_object_type nft_counter_obj_type;
+struct nft_object_type nft_counter_obj_type;
 static const struct nft_object_ops nft_counter_obj_ops = {
 	.type		= &nft_counter_obj_type,
 	.size		= sizeof(struct nft_counter_percpu_priv),
@@ -184,7 +194,7 @@ static const struct nft_object_ops nft_counter_obj_ops = {
 	.dump		= nft_counter_obj_dump,
 };
 
-static struct nft_object_type nft_counter_obj_type __read_mostly = {
+struct nft_object_type nft_counter_obj_type __read_mostly = {
 	.type		= NFT_OBJECT_COUNTER,
 	.ops		= &nft_counter_obj_ops,
 	.maxattr	= NFTA_COUNTER_MAX,
@@ -192,9 +202,8 @@ static struct nft_object_type nft_counter_obj_type __read_mostly = {
 	.owner		= THIS_MODULE,
 };
 
-static void nft_counter_eval(const struct nft_expr *expr,
-			     struct nft_regs *regs,
-			     const struct nft_pktinfo *pkt)
+void nft_counter_eval(const struct nft_expr *expr, struct nft_regs *regs,
+		      const struct nft_pktinfo *pkt)
 {
 	struct nft_counter_percpu_priv *priv = nft_expr_priv(expr);
 
@@ -275,7 +284,7 @@ static void nft_counter_offload_stats(struct nft_expr *expr,
 	preempt_enable();
 }
 
-static struct nft_expr_type nft_counter_type;
+struct nft_expr_type nft_counter_type;
 static const struct nft_expr_ops nft_counter_ops = {
 	.type		= &nft_counter_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_counter_percpu_priv)),
@@ -289,7 +298,7 @@ static const struct nft_expr_ops nft_counter_ops = {
 	.offload_stats	= nft_counter_offload_stats,
 };
 
-static struct nft_expr_type nft_counter_type __read_mostly = {
+struct nft_expr_type nft_counter_type __read_mostly = {
 	.name		= "counter",
 	.ops		= &nft_counter_ops,
 	.policy		= nft_counter_policy,
@@ -297,39 +306,3 @@ static struct nft_expr_type nft_counter_type __read_mostly = {
 	.flags		= NFT_EXPR_STATEFUL,
 	.owner		= THIS_MODULE,
 };
-
-static int __init nft_counter_module_init(void)
-{
-	int cpu, err;
-
-	for_each_possible_cpu(cpu)
-		seqcount_init(per_cpu_ptr(&nft_counter_seq, cpu));
-
-	err = nft_register_obj(&nft_counter_obj_type);
-	if (err < 0)
-		return err;
-
-	err = nft_register_expr(&nft_counter_type);
-	if (err < 0)
-		goto err1;
-
-	return 0;
-err1:
-	nft_unregister_obj(&nft_counter_obj_type);
-	return err;
-}
-
-static void __exit nft_counter_module_exit(void)
-{
-	nft_unregister_expr(&nft_counter_type);
-	nft_unregister_obj(&nft_counter_obj_type);
-}
-
-module_init(nft_counter_module_init);
-module_exit(nft_counter_module_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Patrick McHardy <kaber@trash.net>");
-MODULE_ALIAS_NFT_EXPR("counter");
-MODULE_ALIAS_NFT_OBJ(NFT_OBJECT_COUNTER);
-MODULE_DESCRIPTION("nftables counter rule support");
-- 
2.30.2

