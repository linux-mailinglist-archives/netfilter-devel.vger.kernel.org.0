Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8707E3133DD
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Feb 2021 14:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBHNyY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Feb 2021 08:54:24 -0500
Received: from correo.us.es ([193.147.175.20]:49112 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231671AbhBHNyH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:54:07 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6F061DA72F
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Feb 2021 14:53:17 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5B8D5DA73F
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Feb 2021 14:53:17 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 50959DA730; Mon,  8 Feb 2021 14:53:17 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E1A66DA789
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Feb 2021 14:53:14 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 08 Feb 2021 14:53:14 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id CDE8142DF562
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Feb 2021 14:53:14 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nftables: relax check for stateful expressions in set definition
Date:   Mon,  8 Feb 2021 14:53:11 +0100
Message-Id: <20210208135311.11465-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch fixes a regression when adding an element with a stateful
expression, eg. counter, but the set definition specifies no stateful
expressions.

Remove defensive checks otherwise this breaks backward compatibility.

Fixes: 8cfd9b0f8515 ("netfilter: nftables: generalize set expressions support")
Fixes: 48b0ae046ee9 ("netfilter: nftables: netlink support for several set element expressions")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 43fe80f10313..361f88873195 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5281,6 +5281,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	struct nft_expr *expr_array[NFT_SET_EXPR_MAX] = {};
 	struct nlattr *nla[NFTA_SET_ELEM_MAX + 1];
 	u8 genmask = nft_genmask_next(ctx->net);
+	u32 flags = 0, size = 0, num_exprs = 0;
 	struct nft_set_ext_tmpl tmpl;
 	struct nft_set_ext *ext, *ext2;
 	struct nft_set_elem elem;
@@ -5290,7 +5291,6 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	struct nft_data_desc desc;
 	enum nft_registers dreg;
 	struct nft_trans *trans;
-	u32 flags = 0, size = 0;
 	u64 timeout;
 	u64 expiration;
 	int err, i;
@@ -5356,28 +5356,24 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	if (nla[NFTA_SET_ELEM_EXPR]) {
 		struct nft_expr *expr;
 
-		if (set->num_exprs != 1)
-			return -EOPNOTSUPP;
-
 		expr = nft_set_elem_expr_alloc(ctx, set,
 					       nla[NFTA_SET_ELEM_EXPR]);
 		if (IS_ERR(expr))
 			return PTR_ERR(expr);
 
 		expr_array[0] = expr;
+		num_exprs = 1;
 
-		if (set->exprs[0] && set->exprs[0]->ops != expr->ops) {
+		if (set->num_exprs && set->exprs[0]->ops != expr->ops) {
 			err = -EOPNOTSUPP;
 			goto err_set_elem_expr;
 		}
+
 	} else if (nla[NFTA_SET_ELEM_EXPRESSIONS]) {
 		struct nft_expr *expr;
 		struct nlattr *tmp;
 		int left;
 
-		if (set->num_exprs == 0)
-			return -EOPNOTSUPP;
-
 		i = 0;
 		nla_for_each_nested(tmp, nla[NFTA_SET_ELEM_EXPRESSIONS], left) {
 			if (i == set->num_exprs) {
@@ -5394,21 +5390,25 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 				goto err_set_elem_expr;
 			}
 			expr_array[i] = expr;
+			num_exprs++;
 
-			if (expr->ops != set->exprs[i]->ops) {
+			if (set->num_exprs && expr->ops != set->exprs[i]->ops) {
 				err = -EOPNOTSUPP;
 				goto err_set_elem_expr;
 			}
 			i++;
 		}
-		if (set->num_exprs != i) {
+		if (set->num_exprs && set->num_exprs != i) {
 			err = -EOPNOTSUPP;
 			goto err_set_elem_expr;
 		}
+
 	} else if (set->num_exprs > 0) {
 		err = nft_set_elem_expr_clone(ctx, set, expr_array);
 		if (err < 0)
 			goto err_set_elem_expr_clone;
+
+		num_exprs = set->num_exprs;
 	}
 
 	err = nft_setelem_parse_key(ctx, set, &elem.key.val,
@@ -5433,8 +5433,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			nft_set_ext_add(&tmpl, NFT_SET_EXT_TIMEOUT);
 	}
 
-	if (set->num_exprs) {
-		for (i = 0; i < set->num_exprs; i++)
+	if (num_exprs) {
+		for (i = 0; i < num_exprs; i++)
 			size += expr_array[i]->ops->size;
 
 		nft_set_ext_add_length(&tmpl, NFT_SET_EXT_EXPRESSIONS,
@@ -5522,7 +5522,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		*nft_set_ext_obj(ext) = obj;
 		obj->use++;
 	}
-	for (i = 0; i < set->num_exprs; i++)
+	for (i = 0; i < num_exprs; i++)
 		nft_set_elem_expr_setup(ext, i, expr_array);
 
 	trans = nft_trans_elem_alloc(ctx, NFT_MSG_NEWSETELEM, set);
@@ -5584,7 +5584,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 err_parse_key:
 	nft_data_release(&elem.key.val, NFT_DATA_VALUE);
 err_set_elem_expr:
-	for (i = 0; i < set->num_exprs && expr_array[i]; i++)
+	for (i = 0; i < num_exprs && expr_array[i]; i++)
 		nft_expr_destroy(ctx, expr_array[i]);
 err_set_elem_expr_clone:
 	return err;
-- 
2.29.2

