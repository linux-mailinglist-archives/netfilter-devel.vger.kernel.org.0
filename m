Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BF3275EC5
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Sep 2020 19:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIWRh3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Sep 2020 13:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgIWRh2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:37:28 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC974C0613CE
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Sep 2020 10:37:28 -0700 (PDT)
Received: from localhost ([::1]:54136 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kL8hq-0003qR-GQ; Wed, 23 Sep 2020 19:37:27 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 08/10] nft: cache: Sort custom chains by name
Date:   Wed, 23 Sep 2020 19:48:47 +0200
Message-Id: <20200923174849.5773-9-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923174849.5773-1-phil@nwl.cc>
References: <20200923174849.5773-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

With base chains no longer residing in the tables' chain lists, they can
easily be sorted upon insertion. This on one hand aligns custom chain
ordering with legacy iptables and on the other makes it predictable,
which is very helpful when manually comparing ruleset dumps for
instance.

Adjust the one ebtables-nft test case this change breaks (as wrong
ordering is expected in there). The manual output sorting done for tests
which apply to legacy as well as nft is removed in a separate patch.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v1:
- Extended commit message.
- Rewrote to not rely upon changes in libnftnl (namely,
  nftnl_chain_list_add_sorted()).
---
 iptables/nft-cache.c                             | 16 +++++++++++++---
 .../ebtables/0002-ebtables-save-restore_0        |  2 +-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/iptables/nft-cache.c b/iptables/nft-cache.c
index 83ff11e794a65..f7c51d2f92692 100644
--- a/iptables/nft-cache.c
+++ b/iptables/nft-cache.c
@@ -205,6 +205,7 @@ int nft_cache_add_chain(struct nft_handle *h, const struct builtin_table *t,
 			struct nftnl_chain *c)
 {
 	struct nft_chain *nc = nft_chain_alloc(c);
+	const char *cname = nft_chain_name(nc);
 
 	if (nft_chain_builtin(nc)) {
 		uint32_t hooknum = nft_chain_hooknum(nc);
@@ -221,10 +222,19 @@ int nft_cache_add_chain(struct nft_handle *h, const struct builtin_table *t,
 
 		h->cache->table[t->type].base_chains[hooknum] = nc;
 	} else {
-		list_add_tail(&nc->head,
-			      &h->cache->table[t->type].chains->list);
+		struct nft_chain_list *clist = h->cache->table[t->type].chains;
+		struct list_head *pos = &clist->list;
+		struct nft_chain *cur;
+
+		list_for_each_entry(cur, &clist->list, head) {
+			if (strcmp(cname, nft_chain_name(cur)) <= 0) {
+				pos = &cur->head;
+				break;
+			}
+		}
+		list_add_tail(&nc->head, pos);
 	}
-	hlist_add_head(&nc->hnode, chain_name_hlist(h, t, nft_chain_name(nc)));
+	hlist_add_head(&nc->hnode, chain_name_hlist(h, t, cname));
 	return 0;
 }
 
diff --git a/iptables/tests/shell/testcases/ebtables/0002-ebtables-save-restore_0 b/iptables/tests/shell/testcases/ebtables/0002-ebtables-save-restore_0
index b84f63a7c3672..ccdef19cfb215 100755
--- a/iptables/tests/shell/testcases/ebtables/0002-ebtables-save-restore_0
+++ b/iptables/tests/shell/testcases/ebtables/0002-ebtables-save-restore_0
@@ -70,8 +70,8 @@ DUMP='*filter
 :INPUT ACCEPT
 :FORWARD DROP
 :OUTPUT ACCEPT
-:foo ACCEPT
 :bar RETURN
+:foo ACCEPT
 -A INPUT -p IPv4 -i lo -j ACCEPT
 -A FORWARD -j foo
 -A OUTPUT -s Broadcast -j DROP
-- 
2.28.0

