Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91D11BBD2C
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2020 14:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgD1MLd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Apr 2020 08:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgD1MLd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:11:33 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97448C03C1A9
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 05:11:33 -0700 (PDT)
Received: from localhost ([::1]:38686 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jTP5I-00089L-1x; Tue, 28 Apr 2020 14:11:32 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 02/18] nft: cache: Eliminate init_chain_cache()
Date:   Tue, 28 Apr 2020 14:09:57 +0200
Message-Id: <20200428121013.24507-3-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200428121013.24507-1-phil@nwl.cc>
References: <20200428121013.24507-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The function is always called immediately after fetch_table_cache(), so
merge it into the latter.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-cache.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/iptables/nft-cache.c b/iptables/nft-cache.c
index a0c76705c848e..369692fe44fc7 100644
--- a/iptables/nft-cache.c
+++ b/iptables/nft-cache.c
@@ -86,7 +86,7 @@ static int fetch_table_cache(struct nft_handle *h)
 	char buf[16536];
 	struct nlmsghdr *nlh;
 	struct nftnl_table_list *list;
-	int ret;
+	int i, ret;
 
 	if (h->cache->tables)
 		return 0;
@@ -104,13 +104,6 @@ static int fetch_table_cache(struct nft_handle *h)
 
 	h->cache->tables = list;
 
-	return 1;
-}
-
-static int init_chain_cache(struct nft_handle *h)
-{
-	int i;
-
 	for (i = 0; i < NFT_TABLE_MAX; i++) {
 		enum nft_table_type type = h->tables[i].type;
 
@@ -119,9 +112,10 @@ static int init_chain_cache(struct nft_handle *h)
 
 		h->cache->table[type].chains = nftnl_chain_list_alloc();
 		if (!h->cache->table[type].chains)
-			return -1;
+			return 0;
 	}
-	return 0;
+
+	return 1;
 }
 
 struct nftnl_chain_list_cb_data {
@@ -458,7 +452,6 @@ __nft_build_cache(struct nft_handle *h, enum nft_cache_level level,
 	switch (h->cache_level) {
 	case NFT_CL_NONE:
 		fetch_table_cache(h);
-		init_chain_cache(h);
 		if (level == NFT_CL_TABLES)
 			break;
 		/* fall through */
@@ -505,7 +498,6 @@ void nft_build_cache(struct nft_handle *h, struct nftnl_chain *c)
 void nft_fake_cache(struct nft_handle *h)
 {
 	fetch_table_cache(h);
-	init_chain_cache(h);
 
 	h->cache_level = NFT_CL_FAKE;
 	mnl_genid_get(h, &h->nft_genid);
-- 
2.25.1

