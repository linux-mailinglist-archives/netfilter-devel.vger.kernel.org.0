Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055BD405948
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Sep 2021 16:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242857AbhIIOlj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Sep 2021 10:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346692AbhIIOld (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:41:33 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12271C06642B;
        Thu,  9 Sep 2021 07:04:02 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1mOKem-0003yH-KJ; Thu, 09 Sep 2021 16:04:00 +0200
From:   Florian Westphal <fw@strlen.de>
To:     stable@vger.kernel.org
Cc:     <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Laura Garcia Liebana <nevola@gmail.com>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH 5.10.y 3/3] netfilter: nftables: clone set element expression template
Date:   Thu,  9 Sep 2021 16:03:37 +0200
Message-Id: <20210909140337.29707-4-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210909140337.29707-1-fw@strlen.de>
References: <20210909140337.29707-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 4d8f9065830e526c83199186c5f56a6514f457d2 upstream.

memcpy() breaks when using connlimit in set elements. Use
nft_expr_clone() to initialize the connlimit expression list, otherwise
connlimit garbage collector crashes when walking on the list head copy.

[  493.064656] Workqueue: events_power_efficient nft_rhash_gc [nf_tables]
[  493.064685] RIP: 0010:find_or_evict+0x5a/0x90 [nf_conncount]
[  493.064694] Code: 2b 43 40 83 f8 01 77 0d 48 c7 c0 f5 ff ff ff 44 39 63 3c 75 df 83 6d 18 01 48 8b 43 08 48 89 de 48 8b 13 48 8b 3d ee 2f 00 00 <48> 89 42 08 48 89 10 48 b8 00 01 00 00 00 00 ad de 48 89 03 48 83
[  493.064699] RSP: 0018:ffffc90000417dc0 EFLAGS: 00010297
[  493.064704] RAX: 0000000000000000 RBX: ffff888134f38410 RCX: 0000000000000000
[  493.064708] RDX: 0000000000000000 RSI: ffff888134f38410 RDI: ffff888100060cc0
[  493.064711] RBP: ffff88812ce594a8 R08: ffff888134f38438 R09: 00000000ebb9025c
[  493.064714] R10: ffffffff8219f838 R11: 0000000000000017 R12: 0000000000000001
[  493.064718] R13: ffffffff82146740 R14: ffff888134f38410 R15: 0000000000000000
[  493.064721] FS:  0000000000000000(0000) GS:ffff88840e440000(0000) knlGS:0000000000000000
[  493.064725] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  493.064729] CR2: 0000000000000008 CR3: 00000001330aa002 CR4: 00000000001706e0
[  493.064733] Call Trace:
[  493.064737]  nf_conncount_gc_list+0x8f/0x150 [nf_conncount]
[  493.064746]  nft_rhash_gc+0x106/0x390 [nf_tables]

Reported-by: Laura Garcia Liebana <nevola@gmail.com>
Fixes: 409444522976 ("netfilter: nf_tables: add elements with stateful expressions")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 36 +++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3942a29413a4..2b5f97e1d40b 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5150,6 +5150,24 @@ static void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
 	kfree(elem);
 }
 
+static int nft_set_elem_expr_setup(struct nft_ctx *ctx,
+				   const struct nft_set_ext *ext,
+				   struct nft_expr *expr)
+{
+	struct nft_expr *elem_expr = nft_set_ext_expr(ext);
+	int err;
+
+	if (expr == NULL)
+		return 0;
+
+	err = nft_expr_clone(elem_expr, expr);
+	if (err < 0)
+		return -ENOMEM;
+
+	nft_expr_destroy(ctx, expr);
+	return 0;
+}
+
 static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			    const struct nlattr *attr, u32 nlmsg_flags)
 {
@@ -5352,15 +5370,17 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		*nft_set_ext_obj(ext) = obj;
 		obj->use++;
 	}
-	if (expr) {
-		memcpy(nft_set_ext_expr(ext), expr, expr->ops->size);
-		kfree(expr);
-		expr = NULL;
-	}
+
+	err = nft_set_elem_expr_setup(ctx, ext, expr);
+	if (err < 0)
+		goto err_elem_expr;
+	expr = NULL;
 
 	trans = nft_trans_elem_alloc(ctx, NFT_MSG_NEWSETELEM, set);
-	if (trans == NULL)
-		goto err_trans;
+	if (trans == NULL) {
+		err = -ENOMEM;
+		goto err_elem_expr;
+	}
 
 	ext->genmask = nft_genmask_cur(ctx->net) | NFT_SET_ELEM_BUSY_MASK;
 	err = set->ops->insert(ctx->net, set, &elem, &ext2);
@@ -5404,7 +5424,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	set->ops->remove(ctx->net, set, &elem);
 err_element_clash:
 	kfree(trans);
-err_trans:
+err_elem_expr:
 	if (obj)
 		obj->use--;
 
-- 
2.32.0

