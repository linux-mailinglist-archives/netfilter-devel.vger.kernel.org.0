Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A08B1A0F53
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2020 16:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgDGOfG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 7 Apr 2020 10:35:06 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:54948 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728306AbgDGOfG (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:35:06 -0400
Received: from localhost ([::1]:39806 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jLpJg-0007fP-Lr; Tue, 07 Apr 2020 16:35:04 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 2/3] nft: cache: Init per table set list along with chain list
Date:   Tue,  7 Apr 2020 16:34:44 +0200
Message-Id: <20200407143445.26394-3-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200407143445.26394-1-phil@nwl.cc>
References: <20200407143445.26394-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This simplifies code a bit and also aligns set and chain lists handling
in cache.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-cache.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/iptables/nft-cache.c b/iptables/nft-cache.c
index 369692fe44fc7..e042bd83bebf5 100644
--- a/iptables/nft-cache.c
+++ b/iptables/nft-cache.c
@@ -113,6 +113,10 @@ static int fetch_table_cache(struct nft_handle *h)
 		h->cache->table[type].chains = nftnl_chain_list_alloc();
 		if (!h->cache->table[type].chains)
 			return 0;
+
+		h->cache->table[type].sets = nftnl_set_list_alloc();
+		if (!h->cache->table[type].sets)
+			return 0;
 	}
 
 	return 1;
@@ -254,21 +258,6 @@ static int fetch_set_cache(struct nft_handle *h,
 	char buf[16536];
 	int i, ret;
 
-	if (!t) {
-		for (i = 0; i < NFT_TABLE_MAX; i++) {
-			enum nft_table_type type = h->tables[i].type;
-
-			if (!h->tables[i].name)
-				continue;
-
-			h->cache->table[type].sets = nftnl_set_list_alloc();
-			if (!h->cache->table[type].sets)
-				return -1;
-		}
-	} else if (!h->cache->table[t->type].sets) {
-		h->cache->table[t->type].sets = nftnl_set_list_alloc();
-	}
-
 	if (t && set) {
 		struct nftnl_set *s = nftnl_set_alloc();
 
-- 
2.25.1

