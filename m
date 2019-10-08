Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE4CFEB2
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Oct 2019 18:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfJHQPS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Oct 2019 12:15:18 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:48496 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfJHQPS (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:15:18 -0400
Received: from localhost ([::1]:33354 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iHs8r-0004Vs-Jz; Tue, 08 Oct 2019 18:15:17 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v3 10/11] nft: Support nft_is_table_compatible() per chain
Date:   Tue,  8 Oct 2019 18:14:46 +0200
Message-Id: <20191008161447.6595-11-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008161447.6595-1-phil@nwl.cc>
References: <20191008161447.6595-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When operating on a single chain only, compatibility checking causes
unwanted overhead by checking all chains of the current table. Avoid
this by accepting the current chain name as parameter and pass it along
to nft_chain_list_get().

While being at it, introduce nft_assert_table_compatible() which
calls xtables_error() in case compatibility check fails. If a chain name
was given, include that in error message.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c          | 32 ++++++++++++++++++++++++--------
 iptables/nft.h          |  5 ++++-
 iptables/xtables-save.c |  2 +-
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 7e019d54ee475..12cc423c87bbb 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -2192,12 +2192,10 @@ int nft_rule_list(struct nft_handle *h, const char *chain, const char *table,
 	bool found = false;
 
 	nft_xt_builtin_init(h, table);
+	nft_assert_table_compatible(h, table, chain);
 
 	ops = nft_family_ops_lookup(h->family);
 
-	if (!nft_is_table_compatible(h, table))
-		xtables_error(OTHER_PROBLEM, "table `%s' is incompatible, use 'nft' tool.\n", table);
-
 	list = nft_chain_list_get(h, table, chain);
 	if (!list)
 		return 0;
@@ -2295,9 +2293,7 @@ int nft_rule_list_save(struct nft_handle *h, const char *chain,
 	int ret = 0;
 
 	nft_xt_builtin_init(h, table);
-
-	if (!nft_is_table_compatible(h, table))
-		xtables_error(OTHER_PROBLEM, "table `%s' is incompatible, use 'nft' tool.\n", table);
+	nft_assert_table_compatible(h, table, chain);
 
 	list = nft_chain_list_get(h, table, chain);
 	if (!list)
@@ -3085,11 +3081,12 @@ static int nft_is_chain_compatible(struct nftnl_chain *c, void *data)
 	return 0;
 }
 
-bool nft_is_table_compatible(struct nft_handle *h, const char *tablename)
+bool nft_is_table_compatible(struct nft_handle *h,
+			     const char *table, const char *chain)
 {
 	struct nftnl_chain_list *clist;
 
-	clist = nft_chain_list_get(h, tablename, NULL);
+	clist = nft_chain_list_get(h, table, chain);
 	if (clist == NULL)
 		return false;
 
@@ -3098,3 +3095,22 @@ bool nft_is_table_compatible(struct nft_handle *h, const char *tablename)
 
 	return true;
 }
+
+void nft_assert_table_compatible(struct nft_handle *h,
+				 const char *table, const char *chain)
+{
+	const char *pfx = "", *sfx = "";
+
+	if (nft_is_table_compatible(h, table, chain))
+		return;
+
+	if (chain) {
+		pfx = "chain `";
+		sfx = "' in ";
+	} else {
+		chain = "";
+	}
+	xtables_error(OTHER_PROBLEM,
+		      "%s%s%stable `%s' is incompatible, use 'nft' tool.\n",
+		      pfx, chain, sfx, table);
+}
diff --git a/iptables/nft.h b/iptables/nft.h
index 9ae3122a1c515..4b8b3033a56c0 100644
--- a/iptables/nft.h
+++ b/iptables/nft.h
@@ -206,7 +206,10 @@ int nft_arp_rule_insert(struct nft_handle *h, const char *chain,
 
 void nft_rule_to_arpt_entry(struct nftnl_rule *r, struct arpt_entry *fw);
 
-bool nft_is_table_compatible(struct nft_handle *h, const char *name);
+bool nft_is_table_compatible(struct nft_handle *h,
+			     const char *table, const char *chain);
+void nft_assert_table_compatible(struct nft_handle *h,
+				 const char *table, const char *chain);
 
 int ebt_set_user_chain_policy(struct nft_handle *h, const char *table,
 			      const char *chain, const char *policy);
diff --git a/iptables/xtables-save.c b/iptables/xtables-save.c
index e234425ded293..44687f998c91a 100644
--- a/iptables/xtables-save.c
+++ b/iptables/xtables-save.c
@@ -77,7 +77,7 @@ __do_output(struct nft_handle *h, const char *tablename, void *data)
 	if (!nft_table_builtin_find(h, tablename))
 		return 0;
 
-	if (!nft_is_table_compatible(h, tablename)) {
+	if (!nft_is_table_compatible(h, tablename, NULL)) {
 		printf("# Table `%s' is incompatible, use 'nft' tool.\n",
 		       tablename);
 		return 0;
-- 
2.23.0

