Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC23B7E5AA8
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Nov 2023 16:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjKHP6O (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 8 Nov 2023 10:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHP6N (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:58:13 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DED2172E;
        Wed,  8 Nov 2023 07:58:09 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com, fw@strlen.de,
        kadlec@netfilter.org
Subject: [PATCH net 2/5] netfilter: nf_tables: remove catchall element in GC sync path
Date:   Wed,  8 Nov 2023 16:57:59 +0100
Message-Id: <20231108155802.84617-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231108155802.84617-1-pablo@netfilter.org>
References: <20231108155802.84617-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The expired catchall element is not deactivated and removed from GC sync
path. This path holds mutex so just call nft_setelem_data_deactivate()
and nft_setelem_catchall_remove() before queueing the GC work.

Fixes: 4a9e12ea7e70 ("netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall GC")
Reported-by: lonial con <kongln9170@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 146b7447a969..a761ee6796f6 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6520,6 +6520,12 @@ static int nft_setelem_deactivate(const struct net *net,
 	return ret;
 }
 
+static void nft_setelem_catchall_destroy(struct nft_set_elem_catchall *catchall)
+{
+	list_del_rcu(&catchall->list);
+	kfree_rcu(catchall, rcu);
+}
+
 static void nft_setelem_catchall_remove(const struct net *net,
 					const struct nft_set *set,
 					struct nft_elem_priv *elem_priv)
@@ -6528,8 +6534,7 @@ static void nft_setelem_catchall_remove(const struct net *net,
 
 	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
 		if (catchall->elem == elem_priv) {
-			list_del_rcu(&catchall->list);
-			kfree_rcu(catchall, rcu);
+			nft_setelem_catchall_destroy(catchall);
 			break;
 		}
 	}
@@ -9678,11 +9683,12 @@ static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
 						  unsigned int gc_seq,
 						  bool sync)
 {
-	struct nft_set_elem_catchall *catchall;
+	struct nft_set_elem_catchall *catchall, *next;
 	const struct nft_set *set = gc->set;
+	struct nft_elem_priv *elem_priv;
 	struct nft_set_ext *ext;
 
-	list_for_each_entry_rcu(catchall, &set->catchall_list, list) {
+	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
 
 		if (!nft_set_elem_expired(ext))
@@ -9700,7 +9706,13 @@ static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
 		if (!gc)
 			return NULL;
 
-		nft_trans_gc_elem_add(gc, catchall->elem);
+		elem_priv = catchall->elem;
+		if (sync) {
+			nft_setelem_data_deactivate(gc->net, gc->set, elem_priv);
+			nft_setelem_catchall_destroy(catchall);
+		}
+
+		nft_trans_gc_elem_add(gc, elem_priv);
 	}
 
 	return gc;
-- 
2.30.2

