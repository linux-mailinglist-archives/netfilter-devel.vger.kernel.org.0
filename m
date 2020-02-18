Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC4D16251D
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Feb 2020 11:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgBRK7j (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 Feb 2020 05:59:39 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:45178 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbgBRK7i (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:59:38 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1j40bI-0002mv-EL; Tue, 18 Feb 2020 11:59:36 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v2 1/2] netfilter: nf_tables: make sets built-in
Date:   Tue, 18 Feb 2020 11:59:26 +0100
Message-Id: <20200218105927.4685-2-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200218105927.4685-1-fw@strlen.de>
References: <20200218105927.4685-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Placing nftables set support in an extra module is pointless:

1. nf_tables needs dynamic registeration interface for sake of one module
2. nft heavily relies on sets, e.g. even simple rule like
   "nft ... tcp dport { 80, 443 }" will not work with _SETS=n.

IOW, either nftables isn't used or both nf_tables and nf_tables_set
modules are needed anyway.

With extra module:
 307K net/netfilter/nf_tables.ko
  79K net/netfilter/nf_tables_set.ko

   text  data  bss     dec filename
 146416  3072  545  150033 nf_tables.ko
  35496  1817    0   37313 nf_tables_set.ko

This patch:
 373K net/netfilter/nf_tables.ko

 178563  4049  545  183157 nf_tables.ko

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 No changes since v1.

 include/net/netfilter/nf_tables.h  |  6 -----
 net/netfilter/Kconfig              |  8 ------
 net/netfilter/Makefile             |  9 +++----
 net/netfilter/nf_tables_api.c      | 41 +++++++++---------------------
 net/netfilter/nf_tables_set_core.c | 31 ----------------------
 5 files changed, 15 insertions(+), 80 deletions(-)
 delete mode 100644 net/netfilter/nf_tables_set_core.c

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 4170c033d461..9a5f41028736 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -397,9 +397,6 @@ struct nft_set_type {
 };
 #define to_set_type(o) container_of(o, struct nft_set_type, ops)
 
-int nft_register_set(struct nft_set_type *type);
-void nft_unregister_set(struct nft_set_type *type);
-
 /**
  * 	struct nft_set - nf_tables set instance
  *
@@ -1253,9 +1250,6 @@ void nft_trace_notify(struct nft_traceinfo *info);
 #define MODULE_ALIAS_NFT_EXPR(name) \
 	MODULE_ALIAS("nft-expr-" name)
 
-#define MODULE_ALIAS_NFT_SET() \
-	MODULE_ALIAS("nft-set")
-
 #define MODULE_ALIAS_NFT_OBJ(type) \
 	MODULE_ALIAS("nft-obj-" __stringify(type))
 
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 91efae88e8c2..468fea1aebba 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -455,14 +455,6 @@ config NF_TABLES
 	  To compile it as a module, choose M here.
 
 if NF_TABLES
-
-config NF_TABLES_SET
-	tristate "Netfilter nf_tables set infrastructure"
-	help
-	  This option enables the nf_tables set infrastructure that allows to
-	  look up for elements in a set and to build one-way mappings between
-	  matchings and actions.
-
 config NF_TABLES_INET
 	depends on IPV6
 	select NF_TABLES_IPV4
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index 3f572e5a975e..4fff7d0e2d27 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -78,14 +78,11 @@ nf_tables-objs := nf_tables_core.o nf_tables_api.o nft_chain_filter.o \
 		  nf_tables_trace.o nft_immediate.o nft_cmp.o nft_range.o \
 		  nft_bitwise.o nft_byteorder.o nft_payload.o nft_lookup.o \
 		  nft_dynset.o nft_meta.o nft_rt.o nft_exthdr.o \
-		  nft_chain_route.o nf_tables_offload.o
-
-nf_tables_set-objs := nf_tables_set_core.o \
-		      nft_set_hash.o nft_set_bitmap.o nft_set_rbtree.o \
-		      nft_set_pipapo.o
+		  nft_chain_route.o nf_tables_offload.o \
+		  nft_set_hash.o nft_set_bitmap.o nft_set_rbtree.o \
+		  nft_set_pipapo.o
 
 obj-$(CONFIG_NF_TABLES)		+= nf_tables.o
-obj-$(CONFIG_NF_TABLES_SET)	+= nf_tables_set.o
 obj-$(CONFIG_NFT_COMPAT)	+= nft_compat.o
 obj-$(CONFIG_NFT_CONNLIMIT)	+= nft_connlimit.o
 obj-$(CONFIG_NFT_NUMGEN)	+= nft_numgen.o
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d1318bdf49ca..28add8f24191 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3261,25 +3261,14 @@ static int nf_tables_delrule(struct net *net, struct sock *nlsk,
 /*
  * Sets
  */
-
-static LIST_HEAD(nf_tables_set_types);
-
-int nft_register_set(struct nft_set_type *type)
-{
-	nfnl_lock(NFNL_SUBSYS_NFTABLES);
-	list_add_tail_rcu(&type->list, &nf_tables_set_types);
-	nfnl_unlock(NFNL_SUBSYS_NFTABLES);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(nft_register_set);
-
-void nft_unregister_set(struct nft_set_type *type)
-{
-	nfnl_lock(NFNL_SUBSYS_NFTABLES);
-	list_del_rcu(&type->list);
-	nfnl_unlock(NFNL_SUBSYS_NFTABLES);
-}
-EXPORT_SYMBOL_GPL(nft_unregister_set);
+static const struct nft_set_type *nft_set_types[] = {
+	&nft_set_hash_fast_type,
+	&nft_set_hash_type,
+	&nft_set_rhash_type,
+	&nft_set_bitmap_type,
+	&nft_set_rbtree_type,
+	&nft_set_pipapo_type,
+};
 
 #define NFT_SET_FEATURES	(NFT_SET_INTERVAL | NFT_SET_MAP | \
 				 NFT_SET_TIMEOUT | NFT_SET_OBJECT | \
@@ -3305,15 +3294,11 @@ nft_select_set_ops(const struct nft_ctx *ctx,
 	struct nft_set_estimate est, best;
 	const struct nft_set_type *type;
 	u32 flags = 0;
+	int i;
 
 	lockdep_assert_held(&ctx->net->nft.commit_mutex);
 	lockdep_nfnl_nft_mutex_not_held();
-#ifdef CONFIG_MODULES
-	if (list_empty(&nf_tables_set_types)) {
-		if (nft_request_module(ctx->net, "nft-set") == -EAGAIN)
-			return ERR_PTR(-EAGAIN);
-	}
-#endif
+
 	if (nla[NFTA_SET_FLAGS] != NULL)
 		flags = ntohl(nla_get_be32(nla[NFTA_SET_FLAGS]));
 
@@ -3322,7 +3307,8 @@ nft_select_set_ops(const struct nft_ctx *ctx,
 	best.lookup = ~0;
 	best.space  = ~0;
 
-	list_for_each_entry(type, &nf_tables_set_types, list) {
+	for (i = 0; i < ARRAY_SIZE(nft_set_types); i++) {
+		type = nft_set_types[i];
 		ops = &type->ops;
 
 		if (!nft_set_ops_candidate(type, flags))
@@ -4307,7 +4293,6 @@ const struct nft_set_ext_type nft_set_ext_types[] = {
 		.align	= __alignof__(u32),
 	},
 };
-EXPORT_SYMBOL_GPL(nft_set_ext_types);
 
 /*
  * Set elements
@@ -5360,7 +5345,6 @@ void nft_set_gc_batch_release(struct rcu_head *rcu)
 		nft_set_elem_destroy(gcb->head.set, gcb->elems[i], true);
 	kfree(gcb);
 }
-EXPORT_SYMBOL_GPL(nft_set_gc_batch_release);
 
 struct nft_set_gc_batch *nft_set_gc_batch_alloc(const struct nft_set *set,
 						gfp_t gfp)
@@ -5373,7 +5357,6 @@ struct nft_set_gc_batch *nft_set_gc_batch_alloc(const struct nft_set *set,
 	gcb->head.set = set;
 	return gcb;
 }
-EXPORT_SYMBOL_GPL(nft_set_gc_batch_alloc);
 
 /*
  * Stateful objects
diff --git a/net/netfilter/nf_tables_set_core.c b/net/netfilter/nf_tables_set_core.c
deleted file mode 100644
index 586b621007eb..000000000000
--- a/net/netfilter/nf_tables_set_core.c
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/module.h>
-#include <net/netfilter/nf_tables_core.h>
-
-static int __init nf_tables_set_module_init(void)
-{
-	nft_register_set(&nft_set_hash_fast_type);
-	nft_register_set(&nft_set_hash_type);
-	nft_register_set(&nft_set_rhash_type);
-	nft_register_set(&nft_set_bitmap_type);
-	nft_register_set(&nft_set_rbtree_type);
-	nft_register_set(&nft_set_pipapo_type);
-
-	return 0;
-}
-
-static void __exit nf_tables_set_module_exit(void)
-{
-	nft_unregister_set(&nft_set_pipapo_type);
-	nft_unregister_set(&nft_set_rbtree_type);
-	nft_unregister_set(&nft_set_bitmap_type);
-	nft_unregister_set(&nft_set_rhash_type);
-	nft_unregister_set(&nft_set_hash_type);
-	nft_unregister_set(&nft_set_hash_fast_type);
-}
-
-module_init(nf_tables_set_module_init);
-module_exit(nf_tables_set_module_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_NFT_SET();
-- 
2.24.1

