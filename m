Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F6224D76E
	for <lists+netfilter-devel@lfdr.de>; Fri, 21 Aug 2020 16:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgHUOjw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 21 Aug 2020 10:39:52 -0400
Received: from correo.us.es ([193.147.175.20]:53158 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgHUOjw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:39:52 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 8BC7FFFB62
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Aug 2020 16:39:47 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7E35CDA73D
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Aug 2020 16:39:47 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 73F5BDA730; Fri, 21 Aug 2020 16:39:47 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F3E06DA72F;
        Fri, 21 Aug 2020 16:39:44 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 21 Aug 2020 16:39:44 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id D98FD42EE38E;
        Fri, 21 Aug 2020 16:39:44 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     ricardo.katz@gmail.com
Subject: [PATCH nft,v2] src: add chain hashtable cache
Date:   Fri, 21 Aug 2020 16:39:30 +0200
Message-Id: <20200821143930.27311-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This significantly improves ruleset listing time with large rulesets
(~50k rules) with _lots_ of non-base chains.

 # time nft list ruleset &> /dev/null

Before this patch:

real    0m11,172s
user    0m6,810s
sys     0m4,220s

After this patch:

real    0m4,747s
user    0m0,802s
sys     0m3,912s

This patch also removes list_bindings from netlink_ctx since there is no
need to keep a temporary list of chains anymore.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: dump chain netlink cache only once.

 include/cache.h   | 14 ++++++++
 include/netlink.h |  1 -
 include/rule.h    |  4 ++-
 src/cache.c       | 92 +++++++++++++++++++++++++++++++++++++++++++++++
 src/evaluate.c    |  6 ++--
 src/netlink.c     | 46 ------------------------
 src/rule.c        | 34 +++++++++++-------
 7 files changed, 133 insertions(+), 64 deletions(-)

diff --git a/include/cache.h b/include/cache.h
index b9db1a8f7650..baa2bb29f1e7 100644
--- a/include/cache.h
+++ b/include/cache.h
@@ -45,4 +45,18 @@ static inline uint32_t djb_hash(const char *key)
 	return hash;
 }
 
+#define NFT_CACHE_HSIZE 8192
+
+struct netlink_ctx;
+struct table;
+struct chain;
+struct handle;
+
+struct nftnl_chain_list *chain_cache_dump(struct netlink_ctx *ctx, int *err);
+int chain_cache_init(struct netlink_ctx *ctx, struct table *table,
+		     struct nftnl_chain_list *chain_cache);
+void chain_cache_add(struct chain *chain, struct table *table);
+struct chain *chain_cache_find(const struct table *table,
+			       const struct handle *handle);
+
 #endif /* _NFT_CACHE_H_ */
diff --git a/include/netlink.h b/include/netlink.h
index ad2247e9dd57..b78277a8ce30 100644
--- a/include/netlink.h
+++ b/include/netlink.h
@@ -64,7 +64,6 @@ struct netlink_ctx {
 	struct nft_ctx		*nft;
 	struct list_head	*msgs;
 	struct list_head	list;
-	struct list_head	list_bindings;
 	struct set		*set;
 	const void		*data;
 	uint32_t		seqnum;
diff --git a/include/rule.h b/include/rule.h
index f2f82cc0ca4b..62d25be2106e 100644
--- a/include/rule.h
+++ b/include/rule.h
@@ -8,6 +8,7 @@
 #include <libnftnl/object.h>	/* For NFTNL_CTTIMEOUT_ARRAY_MAX. */
 #include <linux/netfilter/nf_tables.h>
 #include <string.h>
+#include <cache.h>
 
 /**
  * struct handle_spec - handle ID
@@ -153,6 +154,7 @@ struct table {
 	struct handle		handle;
 	struct location		location;
 	struct scope		scope;
+	struct list_head	*chain_htable;
 	struct list_head	chains;
 	struct list_head	sets;
 	struct list_head	objs;
@@ -217,6 +219,7 @@ struct hook_spec {
  */
 struct chain {
 	struct list_head	list;
+	struct list_head	hlist;
 	struct handle		handle;
 	struct location		location;
 	unsigned int		refcnt;
@@ -242,7 +245,6 @@ extern const char *chain_hookname_lookup(const char *name);
 extern struct chain *chain_alloc(const char *name);
 extern struct chain *chain_get(struct chain *chain);
 extern void chain_free(struct chain *chain);
-extern void chain_add_hash(struct chain *chain, struct table *table);
 extern struct chain *chain_lookup(const struct table *table,
 				  const struct handle *h);
 extern struct chain *chain_lookup_fuzzy(const struct handle *h,
diff --git a/src/cache.c b/src/cache.c
index 7797ff6b0460..ed2609008e22 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -12,6 +12,9 @@
 #include <erec.h>
 #include <utils.h>
 #include <cache.h>
+#include <netlink.h>
+#include <mnl.h>
+#include <libnftnl/chain.h>
 
 static unsigned int evaluate_cache_add(struct cmd *cmd, unsigned int flags)
 {
@@ -164,3 +167,92 @@ unsigned int cache_evaluate(struct nft_ctx *nft, struct list_head *cmds)
 
 	return flags;
 }
+
+struct chain_cache_dump_ctx {
+	struct netlink_ctx	*nlctx;
+	struct table		*table;
+};
+
+static int chain_cache_cb(struct nftnl_chain *nlc, void *arg)
+{
+	struct chain_cache_dump_ctx *ctx = arg;
+	const char *chain_name, *table_name;
+	uint32_t hash, family;
+	struct chain *chain;
+
+	table_name = nftnl_chain_get_str(nlc, NFTNL_CHAIN_TABLE);
+	chain_name = nftnl_chain_get_str(nlc, NFTNL_CHAIN_NAME);
+	family = nftnl_chain_get_u32(nlc, NFTNL_CHAIN_FAMILY);
+
+	if (strcmp(table_name, ctx->table->handle.table.name) ||
+	    family != ctx->table->handle.family)
+		return 0;
+
+	hash = djb_hash(chain_name) % NFT_CACHE_HSIZE;
+	chain = netlink_delinearize_chain(ctx->nlctx, nlc);
+
+	if (chain->flags & CHAIN_F_BINDING) {
+		list_add_tail(&chain->list, &ctx->table->chain_bindings);
+	} else {
+		list_add_tail(&chain->hlist, &ctx->table->chain_htable[hash]);
+		list_add_tail(&chain->list, &ctx->table->chains);
+	}
+
+	nftnl_chain_list_del(nlc);
+	nftnl_chain_free(nlc);
+
+	return 0;
+}
+
+int chain_cache_init(struct netlink_ctx *ctx, struct table *table,
+		     struct nftnl_chain_list *chain_list)
+{
+	struct chain_cache_dump_ctx dump_ctx = {
+		.nlctx	= ctx,
+		.table	= table,
+	};
+	nftnl_chain_list_foreach(chain_list, chain_cache_cb, &dump_ctx);
+
+	return 0;
+}
+
+struct nftnl_chain_list *chain_cache_dump(struct netlink_ctx *ctx, int *err)
+{
+	struct nftnl_chain_list *chain_list;
+
+	chain_list = mnl_nft_chain_dump(ctx, AF_UNSPEC);
+	if (chain_list == NULL) {
+		if (errno == EINTR) {
+			*err = -1;
+			return NULL;
+		}
+		*err = 0;
+		return NULL;
+	}
+
+	return chain_list;
+}
+
+void chain_cache_add(struct chain *chain, struct table *table)
+{
+	uint32_t hash;
+
+	hash = djb_hash(chain->handle.chain.name) % NFT_CACHE_HSIZE;
+	list_add_tail(&chain->hlist, &table->chain_htable[hash]);
+	list_add_tail(&chain->list, &table->chains);
+}
+
+struct chain *chain_cache_find(const struct table *table,
+			       const struct handle *handle)
+{
+	struct chain *chain;
+	uint32_t hash;
+
+	hash = djb_hash(handle->chain.name) % NFT_CACHE_HSIZE;
+	list_for_each_entry(chain, &table->chain_htable[hash], hlist) {
+		if (!strcmp(chain->handle.chain.name, handle->chain.name))
+			return chain;
+	}
+
+	return NULL;
+}
diff --git a/src/evaluate.c b/src/evaluate.c
index b64ed3c0c6a4..320a464f9162 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3855,7 +3855,7 @@ static int rule_cache_update(struct eval_ctx *ctx, enum cmd_ops op)
 	if (!table)
 		return table_not_found(ctx);
 
-	chain = chain_lookup(table, &rule->handle);
+	chain = chain_cache_find(table, &rule->handle);
 	if (!chain)
 		return chain_not_found(ctx);
 
@@ -3999,12 +3999,12 @@ static int chain_evaluate(struct eval_ctx *ctx, struct chain *chain)
 		if (chain_lookup(table, &ctx->cmd->handle) == NULL) {
 			chain = chain_alloc(NULL);
 			handle_merge(&chain->handle, &ctx->cmd->handle);
-			chain_add_hash(chain, table);
+			chain_cache_add(chain, table);
 		}
 		return 0;
 	} else if (!(chain->flags & CHAIN_F_BINDING)) {
 		if (chain_lookup(table, &chain->handle) == NULL)
-			chain_add_hash(chain_get(chain), table);
+			chain_cache_add(chain_get(chain), table);
 	}
 
 	if (chain->flags & CHAIN_F_BASECHAIN) {
diff --git a/src/netlink.c b/src/netlink.c
index 20b3cdf5e469..1188590995fe 100644
--- a/src/netlink.c
+++ b/src/netlink.c
@@ -537,52 +537,6 @@ struct chain *netlink_delinearize_chain(struct netlink_ctx *ctx,
 	return chain;
 }
 
-static int list_chain_cb(struct nftnl_chain *nlc, void *arg)
-{
-	struct netlink_ctx *ctx = arg;
-	const struct handle *h = ctx->data;
-	const char *table;
-	const char *name;
-	struct chain *chain;
-	uint32_t family;
-
-	table  = nftnl_chain_get_str(nlc, NFTNL_CHAIN_TABLE);
-	name   = nftnl_chain_get_str(nlc, NFTNL_CHAIN_NAME);
-	family = nftnl_chain_get_u32(nlc, NFTNL_CHAIN_FAMILY);
-
-	if (h->family != family || strcmp(table, h->table.name) != 0)
-		return 0;
-	if (h->chain.name && strcmp(name, h->chain.name) != 0)
-		return 0;
-
-	chain = netlink_delinearize_chain(ctx, nlc);
-	if (chain->flags & CHAIN_F_BINDING)
-		list_add_tail(&chain->list, &ctx->list_bindings);
-	else
-		list_add_tail(&chain->list, &ctx->list);
-
-	return 0;
-}
-
-int netlink_list_chains(struct netlink_ctx *ctx, const struct handle *h)
-{
-	struct nftnl_chain_list *chain_cache;
-
-	chain_cache = mnl_nft_chain_dump(ctx, h->family);
-	if (chain_cache == NULL) {
-		if (errno == EINTR)
-			return -1;
-
-		return 0;
-	}
-
-	ctx->data = h;
-	nftnl_chain_list_foreach(chain_cache, list_chain_cb, ctx);
-	nftnl_chain_list_free(chain_cache);
-
-	return 0;
-}
-
 struct table *netlink_delinearize_table(struct netlink_ctx *ctx,
 					const struct nftnl_table *nlt)
 {
diff --git a/src/rule.c b/src/rule.c
index 2b5685c23e54..a925d8448760 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -152,11 +152,18 @@ static int cache_init_tables(struct netlink_ctx *ctx, struct handle *h,
 
 static int cache_init_objects(struct netlink_ctx *ctx, unsigned int flags)
 {
+	struct nftnl_chain_list *chain_list = NULL;
 	struct rule *rule, *nrule;
 	struct table *table;
 	struct chain *chain;
 	struct set *set;
-	int ret;
+	int ret = 0;
+
+	if (flags & NFT_CACHE_CHAIN_BIT) {
+		chain_list = chain_cache_dump(ctx, &ret);
+		if (!chain_list)
+			return ret;
+	}
 
 	list_for_each_entry(table, &ctx->nft->cache.list, list) {
 		if (flags & NFT_CACHE_SET_BIT) {
@@ -174,13 +181,9 @@ static int cache_init_objects(struct netlink_ctx *ctx, unsigned int flags)
 			}
 		}
 		if (flags & NFT_CACHE_CHAIN_BIT) {
-			ret = netlink_list_chains(ctx, &table->handle);
+			ret = chain_cache_init(ctx, table, chain_list);
 			if (ret < 0)
 				return -1;
-
-			list_splice_tail_init(&ctx->list, &table->chains);
-			list_splice_tail_init(&ctx->list_bindings,
-					      &table->chain_bindings);
 		}
 		if (flags & NFT_CACHE_FLOWTABLE_BIT) {
 			ret = netlink_list_flowtables(ctx, &table->handle);
@@ -198,7 +201,7 @@ static int cache_init_objects(struct netlink_ctx *ctx, unsigned int flags)
 		if (flags & NFT_CACHE_RULE_BIT) {
 			ret = netlink_list_rules(ctx, &table->handle);
 			list_for_each_entry_safe(rule, nrule, &ctx->list, list) {
-				chain = chain_lookup(table, &rule->handle);
+				chain = chain_cache_find(table, &rule->handle);
 				if (!chain)
 					chain = chain_binding_lookup(table,
 							rule->handle.chain.name);
@@ -208,6 +211,10 @@ static int cache_init_objects(struct netlink_ctx *ctx, unsigned int flags)
 				return -1;
 		}
 	}
+
+	if (flags & NFT_CACHE_CHAIN_BIT)
+		nftnl_chain_list_free(chain_list);
+
 	return 0;
 }
 
@@ -256,7 +263,6 @@ int cache_update(struct nft_ctx *nft, unsigned int flags, struct list_head *msgs
 {
 	struct netlink_ctx ctx = {
 		.list		= LIST_HEAD_INIT(ctx.list),
-		.list_bindings	= LIST_HEAD_INIT(ctx.list_bindings),
 		.nft		= nft,
 		.msgs		= msgs,
 	};
@@ -926,11 +932,6 @@ void chain_free(struct chain *chain)
 	xfree(chain);
 }
 
-void chain_add_hash(struct chain *chain, struct table *table)
-{
-	list_add_tail(&chain->list, &table->chains);
-}
-
 struct chain *chain_lookup(const struct table *table, const struct handle *h)
 {
 	struct chain *chain;
@@ -1295,6 +1296,7 @@ void chain_print_plain(const struct chain *chain, struct output_ctx *octx)
 struct table *table_alloc(void)
 {
 	struct table *table;
+	int i;
 
 	table = xzalloc(sizeof(*table));
 	init_list_head(&table->chains);
@@ -1305,6 +1307,11 @@ struct table *table_alloc(void)
 	init_list_head(&table->scope.symbols);
 	table->refcnt = 1;
 
+	table->chain_htable =
+		xmalloc(sizeof(struct list_head) * NFT_CACHE_HSIZE);
+	for (i = 0; i < NFT_CACHE_HSIZE; i++)
+		init_list_head(&table->chain_htable[i]);
+
 	return table;
 }
 
@@ -1329,6 +1336,7 @@ void table_free(struct table *table)
 		obj_free(obj);
 	handle_free(&table->handle);
 	scope_release(&table->scope);
+	xfree(table->chain_htable);
 	xfree(table);
 }
 
-- 
2.20.1

