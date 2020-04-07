Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B03EF1A1616
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2020 21:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgDGThS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 7 Apr 2020 15:37:18 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:55508 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgDGThS (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:37:18 -0400
Received: from localhost ([::1]:40366 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jLu28-0003K9-0K; Tue, 07 Apr 2020 21:37:16 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] ebtables-restore: Table line to trigger implicit commit
Date:   Tue,  7 Apr 2020 21:37:07 +0200
Message-Id: <20200407193707.32492-1-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Cache code is suited for holding multiple tables' data at once. The only
user of that is ebtables-restore with its support for multiple tables
and lack of explicit COMMIT lines. By introducing implicit commits when
parsing a table line in ebtables-restore, it will be possible to
simplify cache code considerably.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c             | 6 ++++++
 iptables/nft.h             | 1 +
 iptables/xtables-restore.c | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index cf3ab9fe239aa..3541569727888 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -2055,6 +2055,12 @@ void nft_table_new(struct nft_handle *h, const char *table)
 	nft_xt_builtin_init(h, table);
 }
 
+void nft_bridge_table_new(struct nft_handle *h, const char *table)
+{
+	nft_bridge_commit(h);
+	nft_table_new(h, table);
+}
+
 static int __nft_rule_del(struct nft_handle *h, struct nftnl_rule *r)
 {
 	struct obj_update *obj;
diff --git a/iptables/nft.h b/iptables/nft.h
index 2094b01455194..0a6a4cad38181 100644
--- a/iptables/nft.h
+++ b/iptables/nft.h
@@ -96,6 +96,7 @@ bool nft_table_find(struct nft_handle *h, const char *tablename);
 int nft_table_purge_chains(struct nft_handle *h, const char *table, struct nftnl_chain_list *list);
 int nft_table_flush(struct nft_handle *h, const char *table);
 void nft_table_new(struct nft_handle *h, const char *table);
+void nft_bridge_table_new(struct nft_handle *h, const char *table);
 const struct builtin_table *nft_table_builtin_find(struct nft_handle *h, const char *table);
 
 /*
diff --git a/iptables/xtables-restore.c b/iptables/xtables-restore.c
index c472ac9bf651b..baf77e3c3a892 100644
--- a/iptables/xtables-restore.c
+++ b/iptables/xtables-restore.c
@@ -493,7 +493,7 @@ static int ebt_table_flush(struct nft_handle *h, const char *table)
 
 static const struct nft_xt_restore_cb ebt_restore_cb = {
 	.commit		= nft_bridge_commit,
-	.table_new	= nft_table_new,
+	.table_new	= nft_bridge_table_new,
 	.table_flush	= ebt_table_flush,
 	.do_command	= do_commandeb,
 	.chain_set	= nft_chain_set,
-- 
2.25.1

