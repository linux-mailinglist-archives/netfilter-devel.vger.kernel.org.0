Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152BADB9DB
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Oct 2019 00:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438316AbfJQWtT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Oct 2019 18:49:19 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:42636 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732705AbfJQWtT (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 18:49:19 -0400
Received: from localhost ([::1]:55726 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iLEa5-00045W-Tk; Fri, 18 Oct 2019 00:49:18 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 8/8] xtables-restore: Drop chain_list callback
Date:   Fri, 18 Oct 2019 00:48:36 +0200
Message-Id: <20191017224836.8261-9-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017224836.8261-1-phil@nwl.cc>
References: <20191017224836.8261-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Since commit 0baa08fed43fa ("xtables: unify user chain add/flush for
restore case") it is not used anymore, so just drop it.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-shared.h      |  2 --
 iptables/xtables-restore.c | 15 ---------------
 2 files changed, 17 deletions(-)

diff --git a/iptables/nft-shared.h b/iptables/nft-shared.h
index b062f3e5792e3..8b073b18fb0d9 100644
--- a/iptables/nft-shared.h
+++ b/iptables/nft-shared.h
@@ -243,8 +243,6 @@ struct nftnl_chain_list;
 
 struct nft_xt_restore_cb {
 	void (*table_new)(struct nft_handle *h, const char *table);
-	struct nftnl_chain_list *(*chain_list)(struct nft_handle *h,
-					       const char *table);
 	int (*chain_set)(struct nft_handle *h, const char *table,
 			 const char *chain, const char *policy,
 			 const struct xt_counters *counters);
diff --git a/iptables/xtables-restore.c b/iptables/xtables-restore.c
index 900e476eaf968..18c824b3784ec 100644
--- a/iptables/xtables-restore.c
+++ b/iptables/xtables-restore.c
@@ -58,20 +58,7 @@ static void print_usage(const char *name, const char *version)
 			"	   [ --ipv6 ]\n", name);
 }
 
-static struct nftnl_chain_list *get_chain_list(struct nft_handle *h,
-					       const char *table)
-{
-	struct nftnl_chain_list *chain_list;
-
-	chain_list = nft_chain_list_get(h, table, NULL);
-	if (chain_list == NULL)
-		xtables_error(OTHER_PROBLEM, "cannot retrieve chain list\n");
-
-	return chain_list;
-}
-
 static const struct nft_xt_restore_cb restore_cb = {
-	.chain_list	= get_chain_list,
 	.commit		= nft_commit,
 	.abort		= nft_abort,
 	.table_new	= nft_table_new,
@@ -425,7 +412,6 @@ static int ebt_table_flush(struct nft_handle *h, const char *table)
 }
 
 static const struct nft_xt_restore_cb ebt_restore_cb = {
-	.chain_list	= get_chain_list,
 	.commit		= nft_bridge_commit,
 	.table_new	= nft_table_new,
 	.table_flush	= ebt_table_flush,
@@ -471,7 +457,6 @@ int xtables_eb_restore_main(int argc, char *argv[])
 }
 
 static const struct nft_xt_restore_cb arp_restore_cb = {
-	.chain_list	= get_chain_list,
 	.commit		= nft_commit,
 	.table_new	= nft_table_new,
 	.table_flush	= nft_table_flush,
-- 
2.23.0

