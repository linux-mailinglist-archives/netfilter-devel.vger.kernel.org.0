Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87681761A2
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Mar 2020 18:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgCBRyY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Mar 2020 12:54:24 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:53336 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbgCBRyY (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:54:24 -0500
Received: from localhost ([::1]:38194 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1j8pGp-0007JY-4A; Mon, 02 Mar 2020 18:54:23 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 1/4] nft: cache: Fix nft_release_cache() under stress
Date:   Mon,  2 Mar 2020 18:53:55 +0100
Message-Id: <20200302175358.27796-2-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302175358.27796-1-phil@nwl.cc>
References: <20200302175358.27796-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

iptables-nft-restore calls nft_action(h, NFT_COMPAT_COMMIT) for each
COMMIT line in input. When restoring a dump containing multiple large
tables, chances are nft_rebuild_cache() has to run multiple times.

If the above happens, consecutive table contents are added to __cache[1]
which nft_rebuild_cache() then frees, so next commit attempt accesses
invalid memory.

Fix this by making nft_release_cache() (called after each successful
commit) return things into pre-rebuild state again, but keeping the
fresh cache copy.

Fixes: f6ad231d698c7 ("nft: keep original cache in case of ERESTART")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-cache.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/iptables/nft-cache.c b/iptables/nft-cache.c
index 7345a27e2894b..6f21f2283e0fb 100644
--- a/iptables/nft-cache.c
+++ b/iptables/nft-cache.c
@@ -647,8 +647,14 @@ void nft_rebuild_cache(struct nft_handle *h)
 
 void nft_release_cache(struct nft_handle *h)
 {
-	if (h->cache_index)
-		flush_cache(h, &h->__cache[0], NULL);
+	if (!h->cache_index)
+		return;
+
+	flush_cache(h, &h->__cache[0], NULL);
+	memcpy(&h->__cache[0], &h->__cache[1], sizeof(h->__cache[0]));
+	memset(&h->__cache[1], 0, sizeof(h->__cache[1]));
+	h->cache_index = 0;
+	h->cache = &h->__cache[0];
 }
 
 struct nftnl_table_list *nftnl_table_list_get(struct nft_handle *h)
-- 
2.25.1

