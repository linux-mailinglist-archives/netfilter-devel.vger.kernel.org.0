Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02E144ABC2
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Nov 2021 11:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245439AbhKIKrx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Nov 2021 05:47:53 -0500
Received: from mail.netfilter.org ([217.70.188.207]:50172 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242370AbhKIKrw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Nov 2021 05:47:52 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id AF10860639
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Nov 2021 11:43:06 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v3 2/2] cache: do not populate cache if it is going to be flushed
Date:   Tue,  9 Nov 2021 11:44:57 +0100
Message-Id: <20211109104457.90843-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109104457.90843-1-pablo@netfilter.org>
References: <20211109104457.90843-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Skip set element netlink dump if set is flushed, this speeds up
set flush + add element operation in a batch file for an existing set.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: allocate the filter hashtable in the heap.

 include/cache.h   | 15 ++++++++++-
 src/cache.c       | 69 +++++++++++++++++++++++++++++++++++++++++++++--
 src/libnftables.c | 11 +++++---
 3 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/include/cache.h b/include/cache.h
index 7d61701a02b5..6ea6a7380a30 100644
--- a/include/cache.h
+++ b/include/cache.h
@@ -38,11 +38,23 @@ enum cache_level_flags {
 	NFT_CACHE_FLUSHED	= (1 << 31),
 };
 
+struct nft_filter_obj {
+	struct list_head list;
+	const char	*table;
+	const char	*set;
+};
+
+#define NFT_CACHE_HSIZE	8192
+
 struct nft_cache_filter {
 	struct {
 		const char	*table;
 		const char	*set;
 	} list;
+
+	struct {
+		struct list_head head;
+	} obj[NFT_CACHE_HSIZE];
 };
 
 struct nft_cache;
@@ -66,7 +78,8 @@ static inline uint32_t djb_hash(const char *key)
 	return hash;
 }
 
-#define NFT_CACHE_HSIZE 8192
+struct nft_cache_filter *nft_cache_filter_init(void);
+void nft_cache_filter_fini(struct nft_cache_filter *filter);
 
 struct table;
 struct chain;
diff --git a/src/cache.c b/src/cache.c
index 58397551aafc..3231e2692856 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -96,13 +96,72 @@ static unsigned int evaluate_cache_get(struct cmd *cmd, unsigned int flags)
 	return flags;
 }
 
-static unsigned int evaluate_cache_flush(struct cmd *cmd, unsigned int flags)
+struct nft_cache_filter *nft_cache_filter_init(void)
+{
+	struct nft_cache_filter *filter;
+	int i;
+
+	filter = xmalloc(sizeof(struct nft_cache_filter));
+	memset(&filter->list, 0, sizeof(filter->list));
+	for (i = 0; i < NFT_CACHE_HSIZE; i++)
+		init_list_head(&filter->obj[i].head);
+
+	return filter;
+}
+
+void nft_cache_filter_fini(struct nft_cache_filter *filter)
+{
+	int i;
+
+	for (i = 0; i < NFT_CACHE_HSIZE; i++) {
+		struct nft_filter_obj *obj, *next;
+
+		list_for_each_entry_safe(obj, next, &filter->obj[i].head, list)
+			xfree(obj);
+	}
+	xfree(filter);
+}
+
+static void cache_filter_add(struct nft_cache_filter *filter,
+			     const struct cmd *cmd)
+{
+	struct nft_filter_obj *obj;
+	uint32_t hash;
+
+	obj = xmalloc(sizeof(struct nft_filter_obj));
+	obj->table = cmd->handle.table.name;
+	obj->set = cmd->handle.set.name;
+
+	hash = djb_hash(cmd->handle.set.name) % NFT_CACHE_HSIZE;
+	list_add_tail(&obj->list, &filter->obj[hash].head);
+}
+
+static bool cache_filter_find(const struct nft_cache_filter *filter,
+			      const struct handle *handle)
+{
+	struct nft_filter_obj *obj;
+	uint32_t hash;
+
+	hash = djb_hash(handle->set.name) % NFT_CACHE_HSIZE;
+
+	list_for_each_entry(obj, &filter->obj[hash].head, list) {
+		if (!strcmp(obj->table, handle->table.name) &&
+		    !strcmp(obj->set, handle->set.name))
+			return true;
+	}
+
+	return false;
+}
+
+static unsigned int evaluate_cache_flush(struct cmd *cmd, unsigned int flags,
+					 struct nft_cache_filter *filter)
 {
 	switch (cmd->obj) {
 	case CMD_OBJ_SET:
 	case CMD_OBJ_MAP:
 	case CMD_OBJ_METER:
 		flags |= NFT_CACHE_SET;
+		cache_filter_add(filter, cmd);
 		break;
 	case CMD_OBJ_RULESET:
 		flags |= NFT_CACHE_FLUSHED;
@@ -219,7 +278,7 @@ unsigned int nft_cache_evaluate(struct nft_ctx *nft, struct list_head *cmds,
 			flags |= NFT_CACHE_FULL;
 			break;
 		case CMD_FLUSH:
-			flags = evaluate_cache_flush(cmd, flags);
+			flags = evaluate_cache_flush(cmd, flags, filter);
 			break;
 		case CMD_RENAME:
 			flags = evaluate_cache_rename(cmd, flags);
@@ -685,6 +744,9 @@ static int cache_init_objects(struct netlink_ctx *ctx, unsigned int flags,
 		}
 		if (flags & NFT_CACHE_SETELEM_BIT) {
 			list_for_each_entry(set, &table->set_cache.list, cache.list) {
+				if (cache_filter_find(filter, &set->handle))
+					continue;
+
 				ret = netlink_list_setelems(ctx, &set->handle,
 							    set);
 				if (ret < 0) {
@@ -694,6 +756,9 @@ static int cache_init_objects(struct netlink_ctx *ctx, unsigned int flags,
 			}
 		} else if (flags & NFT_CACHE_SETELEM_MAYBE) {
 			list_for_each_entry(set, &table->set_cache.list, cache.list) {
+				if (cache_filter_find(filter, &set->handle))
+					continue;
+
 				if (!set_is_non_concat_range(set))
 					continue;
 
diff --git a/src/libnftables.c b/src/libnftables.c
index 2b2ed1a44329..7b9d7efaeaae 100644
--- a/src/libnftables.c
+++ b/src/libnftables.c
@@ -459,13 +459,18 @@ static int nft_parse_bison_filename(struct nft_ctx *nft, const char *filename,
 static int nft_evaluate(struct nft_ctx *nft, struct list_head *msgs,
 			struct list_head *cmds)
 {
-	struct nft_cache_filter filter = {};
+	struct nft_cache_filter *filter;
 	unsigned int flags;
 	struct cmd *cmd;
 
-	flags = nft_cache_evaluate(nft, cmds, &filter);
-	if (nft_cache_update(nft, flags, msgs, &filter) < 0)
+	filter = nft_cache_filter_init();
+	flags = nft_cache_evaluate(nft, cmds, filter);
+	if (nft_cache_update(nft, flags, msgs, filter) < 0) {
+		nft_cache_filter_fini(filter);
 		return -1;
+	}
+
+	nft_cache_filter_fini(filter);
 
 	list_for_each_entry(cmd, cmds, list) {
 		struct eval_ctx ectx = {
-- 
2.30.2

