Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D892D5B3A
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Dec 2020 14:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389059AbgLJNHH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Dec 2020 08:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388970AbgLJNHH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:07:07 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E30C0613D6
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Dec 2020 05:06:27 -0800 (PST)
Received: from localhost ([::1]:40960 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1knLeK-0000fk-2x; Thu, 10 Dec 2020 14:06:24 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v3 7/9] nft: cache: Sort custom chains by name
Date:   Thu, 10 Dec 2020 14:06:34 +0100
Message-Id: <20201210130636.26379-8-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210130636.26379-1-phil@nwl.cc>
References: <20201210130636.26379-1-phil@nwl.cc>
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
 iptables/nft-cache.c                              | 15 +++++++++++++--
 .../ebtables/0002-ebtables-save-restore_0         |  2 +-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/iptables/nft-cache.c b/iptables/nft-cache.c
index bd19b6dfc4d8a..6b6e6da40a826 100644
--- a/iptables/nft-cache.c
+++ b/iptables/nft-cache.c
@@ -223,8 +223,19 @@ int nft_cache_add_chain(struct nft_handle *h, const struct builtin_table *t,
 
 		h->cache->table[t->type].base_chains[hooknum] = nc;
 	} else {
-		list_add_tail(&nc->head,
-			      &h->cache->table[t->type].chains->list);
+		struct nft_chain_list *clist = h->cache->table[t->type].chains;
+		struct list_head *pos = &clist->list;
+		struct nft_chain *cur;
+		const char *n;
+
+		list_for_each_entry(cur, &clist->list, head) {
+			n = nftnl_chain_get_str(cur->nftnl, NFTNL_CHAIN_NAME);
+			if (strcmp(cname, n) <= 0) {
+				pos = &cur->head;
+				break;
+			}
+		}
+		list_add_tail(&nc->head, pos);
 	}
 	hlist_add_head(&nc->hnode, chain_name_hlist(h, t, cname));
 	return 0;
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

