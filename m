Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED312D5B40
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Dec 2020 14:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbgLJNHs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Dec 2020 08:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731240AbgLJNHr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:07:47 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D88C0613CF
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Dec 2020 05:06:57 -0800 (PST)
Received: from localhost ([::1]:40996 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1knLep-0000gn-PZ; Thu, 10 Dec 2020 14:06:55 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v3 4/9] nft: cache: Move nft_chain_find() over
Date:   Thu, 10 Dec 2020 14:06:31 +0100
Message-Id: <20201210130636.26379-5-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210130636.26379-1-phil@nwl.cc>
References: <20201210130636.26379-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

It is basically just a cache lookup, hence fits better in here.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-cache.c | 14 ++++++++++++++
 iptables/nft-cache.h |  3 +++
 iptables/nft.c       | 17 -----------------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/iptables/nft-cache.c b/iptables/nft-cache.c
index 109524c3fbc79..929fa0fa152c1 100644
--- a/iptables/nft-cache.c
+++ b/iptables/nft-cache.c
@@ -165,6 +165,20 @@ static int fetch_table_cache(struct nft_handle *h)
 	return 1;
 }
 
+struct nftnl_chain *
+nft_chain_find(struct nft_handle *h, const char *table, const char *chain)
+{
+	const struct builtin_table *t;
+	struct nftnl_chain_list *list;
+
+	t = nft_table_builtin_find(h, table);
+	if (!t)
+		return NULL;
+
+	list = h->cache->table[t->type].chains;
+	return list ? nftnl_chain_list_lookup_byname(list, chain) : NULL;
+}
+
 int nft_cache_add_chain(struct nft_handle *h, const struct builtin_table *t,
 			struct nftnl_chain *c)
 {
diff --git a/iptables/nft-cache.h b/iptables/nft-cache.h
index 52ad2d396199e..085594c26457b 100644
--- a/iptables/nft-cache.h
+++ b/iptables/nft-cache.h
@@ -16,6 +16,9 @@ void nft_cache_build(struct nft_handle *h);
 int nft_cache_add_chain(struct nft_handle *h, const struct builtin_table *t,
 			struct nftnl_chain *c);
 
+struct nftnl_chain *
+nft_chain_find(struct nft_handle *h, const char *table, const char *chain);
+
 struct nftnl_set_list *
 nft_set_list_get(struct nft_handle *h, const char *table, const char *set);
 
diff --git a/iptables/nft.c b/iptables/nft.c
index afe7fe9ed05c5..9b40b3c3b9631 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -738,9 +738,6 @@ nft_chain_builtin_find(const struct builtin_table *t, const char *chain)
 	return found ? &t->chains[i] : NULL;
 }
 
-static struct nftnl_chain *
-nft_chain_find(struct nft_handle *h, const char *table, const char *chain);
-
 static void nft_chain_builtin_init(struct nft_handle *h,
 				   const struct builtin_table *table)
 {
@@ -1837,20 +1834,6 @@ out:
 	return ret == 0 ? 1 : 0;
 }
 
-static struct nftnl_chain *
-nft_chain_find(struct nft_handle *h, const char *table, const char *chain)
-{
-	const struct builtin_table *t;
-	struct nftnl_chain_list *list;
-
-	t = nft_table_builtin_find(h, table);
-	if (!t)
-		return NULL;
-
-	list = h->cache->table[t->type].chains;
-	return list ? nftnl_chain_list_lookup_byname(list, chain) : NULL;
-}
-
 bool nft_chain_exists(struct nft_handle *h,
 		      const char *table, const char *chain)
 {
-- 
2.28.0

