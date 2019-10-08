Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5CCFEBE
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Oct 2019 18:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfJHQPv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Oct 2019 12:15:51 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:48532 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfJHQPv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:15:51 -0400
Received: from localhost ([::1]:33390 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iHs9N-0004YD-DW; Tue, 08 Oct 2019 18:15:49 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v3 06/11] nft-cache: Cover for multiple fetcher invocation
Date:   Tue,  8 Oct 2019 18:14:42 +0200
Message-Id: <20191008161447.6595-7-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008161447.6595-1-phil@nwl.cc>
References: <20191008161447.6595-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Preparing for partial caches, it is necessary to make sure these
functions don't cause harm if called repeatedly.

* Use h->cache->tables pointer as indicator for existing table cache,
  return immediately from fetch_table_cache() if non-NULL.

* Initialize table's chain list only if non-NULL.

* Search for chain in table's chain list before adding it.

* Don't fetch rules for a chain if it has any rules already. With rule
  list being embedded in struct nftnl_chain, this is the best way left
  to check if rules have been fetched already or not. It will fail for
  empty chains, but causes no harm in that case, either.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-cache.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/iptables/nft-cache.c b/iptables/nft-cache.c
index 5f27aec6d9c30..a2cfb6ef6dbcf 100644
--- a/iptables/nft-cache.c
+++ b/iptables/nft-cache.c
@@ -86,6 +86,9 @@ static int fetch_table_cache(struct nft_handle *h)
 	struct nftnl_table_list *list;
 	int ret;
 
+	if (h->cache->tables)
+		return 0;
+
 	list = nftnl_table_list_alloc();
 	if (list == NULL)
 		return 0;
@@ -106,7 +109,9 @@ static int nftnl_chain_list_cb(const struct nlmsghdr *nlh, void *data)
 {
 	struct nft_handle *h = data;
 	const struct builtin_table *t;
+	struct nftnl_chain_list *list;
 	struct nftnl_chain *c;
+	const char *cname;
 
 	c = nftnl_chain_alloc();
 	if (c == NULL)
@@ -120,7 +125,13 @@ static int nftnl_chain_list_cb(const struct nlmsghdr *nlh, void *data)
 	if (!t)
 		goto out;
 
-	nftnl_chain_list_add_tail(c, h->cache->table[t->type].chains);
+	list = h->cache->table[t->type].chains;
+	cname = nftnl_chain_get_str(c, NFTNL_CHAIN_NAME);
+
+	if (nftnl_chain_list_lookup_byname(list, cname))
+		goto out;
+
+	nftnl_chain_list_add_tail(c, list);
 
 	return MNL_CB_OK;
 out:
@@ -141,6 +152,9 @@ static int fetch_chain_cache(struct nft_handle *h)
 		if (!h->tables[i].name)
 			continue;
 
+		if (h->cache->table[type].chains)
+			continue;
+
 		h->cache->table[type].chains = nftnl_chain_list_alloc();
 		if (!h->cache->table[type].chains)
 			return -1;
@@ -182,6 +196,9 @@ static int nft_rule_list_update(struct nftnl_chain *c, void *data)
 	struct nftnl_rule *rule;
 	int ret;
 
+	if (nftnl_rule_lookup_byindex(c, 0))
+		return 0;
+
 	rule = nftnl_rule_alloc();
 	if (!rule)
 		return -1;
-- 
2.23.0

