Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867B3B3F44
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Sep 2019 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390201AbfIPQub (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Sep 2019 12:50:31 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:51172 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbfIPQub (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:50:31 -0400
Received: from localhost ([::1]:36030 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1i9uCs-0003nn-9B; Mon, 16 Sep 2019 18:50:30 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 13/14] nft: Optimize flushing all chains of a table
Date:   Mon, 16 Sep 2019 18:49:59 +0200
Message-Id: <20190916165000.18217-14-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190916165000.18217-1-phil@nwl.cc>
References: <20190916165000.18217-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Leverage nftables' support for flushing all chains of a table by
omitting NFTNL_RULE_CHAIN attribute in NFT_MSG_DELRULE payload.

The only caveat is with verbose output, as that still requires to have a
list of (existing) chains to iterate over. Apart from that, implementing
this shortcut is pretty straightforward: Don't retrieve a chain list and
just call __nft_rule_flush() directly which doesn't set above attribute
if chain name pointer is NULL.

A bigger deal is keeping rule cache consistent: Instead of just clearing
rule list for each flushed chain, flush_rule_cache() is updated to
iterate over all cached chains of the given table and clears their rule
lists if not called for a specific chain.

While being at it, sort local variable declarations in nft_rule_flush()
from longest to shortest and drop the loop-local 'chain_name' variable
(but instead use 'chain' function parameter which is not used at that
point).

Note that this change by itself only marginally improves 'iptables-nft
-F' performance for a ruleset with many chains because
nft_xt_builtin_init() still fetches all chains from kernel. A follow-up
patch takes care of that, finally establishing O(1) complexity.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 54 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 294cb306700d0..5eb129461dab2 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -836,7 +836,7 @@ int nft_init(struct nft_handle *h, const struct builtin_table *t)
 	return 0;
 }
 
-static int __flush_rule_cache(struct nftnl_rule *r, void *data)
+static int ____flush_rule_cache(struct nftnl_rule *r, void *data)
 {
 	nftnl_rule_list_del(r);
 	nftnl_rule_free(r);
@@ -844,9 +844,25 @@ static int __flush_rule_cache(struct nftnl_rule *r, void *data)
 	return 0;
 }
 
-static void flush_rule_cache(struct nftnl_chain *c)
+static int __flush_rule_cache(struct nftnl_chain *c, void *data)
 {
-	nftnl_rule_foreach(c, __flush_rule_cache, NULL);
+	return nftnl_rule_foreach(c, ____flush_rule_cache, NULL);
+}
+
+static int flush_rule_cache(struct nft_handle *h, const char *table,
+			    struct nftnl_chain *c)
+{
+	const struct builtin_table *t;
+
+	if (c)
+		return __flush_rule_cache(c, NULL);
+
+	t = nft_table_builtin_find(h, table);
+	if (!t|| !h->cache->table[t->type].chains)
+		return 0;
+
+	return nftnl_chain_list_foreach(h->cache->table[t->type].chains,
+					__flush_rule_cache, NULL);
 }
 
 static int __flush_chain_cache(struct nftnl_chain *c, void *data)
@@ -1860,7 +1876,7 @@ __nft_rule_flush(struct nft_handle *h, const char *table,
 	struct obj_update *obj;
 	struct nftnl_rule *r;
 
-	if (verbose)
+	if (verbose && chain)
 		fprintf(stdout, "Flushing chain `%s'\n", chain);
 
 	r = nftnl_rule_alloc();
@@ -1868,7 +1884,8 @@ __nft_rule_flush(struct nft_handle *h, const char *table,
 		return;
 
 	nftnl_rule_set_str(r, NFTNL_RULE_TABLE, table);
-	nftnl_rule_set_str(r, NFTNL_RULE_CHAIN, chain);
+	if (chain)
+		nftnl_rule_set_str(r, NFTNL_RULE_CHAIN, chain);
 
 	obj = batch_rule_add(h, NFT_COMPAT_RULE_FLUSH, r);
 	if (!obj) {
@@ -1882,19 +1899,21 @@ __nft_rule_flush(struct nft_handle *h, const char *table,
 int nft_rule_flush(struct nft_handle *h, const char *chain, const char *table,
 		   bool verbose)
 {
-	int ret = 0;
-	struct nftnl_chain_list *list;
 	struct nftnl_chain_list_iter *iter;
-	struct nftnl_chain *c;
+	struct nftnl_chain_list *list;
+	struct nftnl_chain *c = NULL;
+	int ret = 0;
 
 	nft_xt_builtin_init(h, table);
 
 	nft_fn = nft_rule_flush;
 
-	list = nft_chain_list_get(h, table, chain);
-	if (list == NULL) {
-		ret = 1;
-		goto err;
+	if (chain || verbose) {
+		list = nft_chain_list_get(h, table, chain);
+		if (list == NULL) {
+			ret = 1;
+			goto err;
+		}
 	}
 
 	if (chain) {
@@ -1903,9 +1922,11 @@ int nft_rule_flush(struct nft_handle *h, const char *chain, const char *table,
 			errno = ENOENT;
 			return 0;
 		}
+	}
 
+	if (chain || !verbose) {
 		__nft_rule_flush(h, table, chain, verbose, false);
-		flush_rule_cache(c);
+		flush_rule_cache(h, table, c);
 		return 1;
 	}
 
@@ -1917,11 +1938,10 @@ int nft_rule_flush(struct nft_handle *h, const char *chain, const char *table,
 
 	c = nftnl_chain_list_iter_next(iter);
 	while (c != NULL) {
-		const char *chain_name =
-			nftnl_chain_get_str(c, NFTNL_CHAIN_NAME);
+		chain = nftnl_chain_get_str(c, NFTNL_CHAIN_NAME);
 
-		__nft_rule_flush(h, table, chain_name, verbose, false);
-		flush_rule_cache(c);
+		__nft_rule_flush(h, table, chain, verbose, false);
+		flush_rule_cache(h, table, c);
 		c = nftnl_chain_list_iter_next(iter);
 	}
 	nftnl_chain_list_iter_destroy(iter);
-- 
2.23.0

