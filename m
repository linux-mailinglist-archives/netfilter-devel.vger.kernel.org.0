Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA53E1058AD
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Nov 2019 18:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfKURhB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Nov 2019 12:37:01 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:41628 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfKURhB (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:37:01 -0500
Received: from localhost ([::1]:54718 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iXqO3-0006If-Vg; Thu, 21 Nov 2019 18:37:00 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v4 06/12] nft: Eliminate pointless calls to nft_family_ops_lookup()
Date:   Thu, 21 Nov 2019 18:36:41 +0100
Message-Id: <20191121173647.31488-7-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121173647.31488-1-phil@nwl.cc>
References: <20191121173647.31488-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If nft_handle is available, use its 'ops' field instead of performing a
new lookup. For the same reason, there is no need to pass ops pointer to
__nft_print_header().

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 36c3bc2d41764..22a4dc8904126 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -1336,12 +1336,10 @@ static const char *policy_name[NF_ACCEPT+1] = {
 
 int nft_chain_save(struct nft_handle *h, struct nftnl_chain_list *list)
 {
+	struct nft_family_ops *ops = h->ops;
 	struct nftnl_chain_list_iter *iter;
-	struct nft_family_ops *ops;
 	struct nftnl_chain *c;
 
-	ops = nft_family_ops_lookup(h->family);
-
 	iter = nftnl_chain_list_iter_create(list);
 	if (iter == NULL)
 		return 0;
@@ -2165,7 +2163,6 @@ static int nft_rule_count(struct nft_handle *h, struct nftnl_chain *c)
 }
 
 static void __nft_print_header(struct nft_handle *h,
-			       const struct nft_family_ops *ops,
 			       struct nftnl_chain *c, unsigned int format)
 {
 	const char *chain_name = nftnl_chain_get_str(c, NFTNL_CHAIN_NAME);
@@ -2181,14 +2178,14 @@ static void __nft_print_header(struct nft_handle *h,
 	if (nftnl_chain_is_set(c, NFTNL_CHAIN_POLICY))
 		pname = policy_name[nftnl_chain_get_u32(c, NFTNL_CHAIN_POLICY)];
 
-	ops->print_header(format, chain_name, pname,
+	h->ops->print_header(format, chain_name, pname,
 			&ctrs, basechain, refs - entries, entries);
 }
 
 int nft_rule_list(struct nft_handle *h, const char *chain, const char *table,
 		  int rulenum, unsigned int format)
 {
-	const struct nft_family_ops *ops;
+	const struct nft_family_ops *ops = h->ops;
 	struct nftnl_chain_list *list;
 	struct nftnl_chain_list_iter *iter;
 	struct nftnl_chain *c;
@@ -2197,8 +2194,6 @@ int nft_rule_list(struct nft_handle *h, const char *chain, const char *table,
 	nft_xt_builtin_init(h, table);
 	nft_assert_table_compatible(h, table, chain);
 
-	ops = nft_family_ops_lookup(h->family);
-
 	list = nft_chain_list_get(h, table, chain);
 	if (!list)
 		return 0;
@@ -2211,7 +2206,7 @@ int nft_rule_list(struct nft_handle *h, const char *chain, const char *table,
 		if (!rulenum) {
 			if (ops->print_table_header)
 				ops->print_table_header(table);
-			__nft_print_header(h, ops, c, format);
+			__nft_print_header(h, c, format);
 		}
 		__nft_rule_list(h, c, rulenum, format, ops->print_rule);
 		return 1;
@@ -2229,7 +2224,7 @@ int nft_rule_list(struct nft_handle *h, const char *chain, const char *table,
 		if (found)
 			printf("\n");
 
-		__nft_print_header(h, ops, c, format);
+		__nft_print_header(h, c, format);
 		__nft_rule_list(h, c, rulenum, format, ops->print_rule);
 
 		found = true;
-- 
2.24.0

