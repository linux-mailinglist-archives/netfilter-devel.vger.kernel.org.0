Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C4D535524
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 May 2022 22:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349071AbiEZUyZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 26 May 2022 16:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349168AbiEZUyW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 26 May 2022 16:54:22 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1009E8B95;
        Thu, 26 May 2022 13:54:17 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com
Subject: [PATCH net 1/2] netfilter: nf_tables: disallow non-stateful expression in sets earlier
Date:   Thu, 26 May 2022 22:54:10 +0200
Message-Id: <20220526205411.315136-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526205411.315136-1-pablo@netfilter.org>
References: <20220526205411.315136-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Since 3e135cd499bf ("netfilter: nft_dynset: dynamic stateful expression
instantiation"), it is possible to attach stateful expressions to set
elements.

cd5125d8f518 ("netfilter: nf_tables: split set destruction in deactivate
and destroy phase") introduces conditional destruction on the object to
accomodate transaction semantics.

nft_expr_init() calls expr->ops->init() first, then check for
NFT_STATEFUL_EXPR, this stills allows to initialize a non-stateful
lookup expressions which points to a set, which might lead to UAF since
the set is not properly detached from the set->binding for this case.
Anyway, this combination is non-sense from nf_tables perspective.

This patch fixes this problem by checking for NFT_STATEFUL_EXPR before
expr->ops->init() is called.

The reporter provides a KASAN splat and a poc reproducer (similar to
those autogenerated by syzbot to report use-after-free errors). It is
unknown to me if they are using syzbot or if they use similar automated
tool to locate the bug that they are reporting.

For the record, this is the KASAN splat.

[   85.431824] ==================================================================
[   85.432901] BUG: KASAN: use-after-free in nf_tables_bind_set+0x81b/0xa20
[   85.433825] Write of size 8 at addr ffff8880286f0e98 by task poc/776
[   85.434756]
[   85.434999] CPU: 1 PID: 776 Comm: poc Tainted: G        W         5.18.0+ #2
[   85.436023] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014

Fixes: 0b2d8a7b638b ("netfilter: nf_tables: add helper functions for expression handling")
Reported-and-tested-by: Aaron Adams <edg-e@nccgroup.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 12fc9cda4a2c..f296dfe86b62 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2873,27 +2873,31 @@ static struct nft_expr *nft_expr_init(const struct nft_ctx *ctx,
 
 	err = nf_tables_expr_parse(ctx, nla, &expr_info);
 	if (err < 0)
-		goto err1;
+		goto err_expr_parse;
+
+	err = -EOPNOTSUPP;
+	if (!(expr_info.ops->type->flags & NFT_EXPR_STATEFUL))
+		goto err_expr_stateful;
 
 	err = -ENOMEM;
 	expr = kzalloc(expr_info.ops->size, GFP_KERNEL_ACCOUNT);
 	if (expr == NULL)
-		goto err2;
+		goto err_expr_stateful;
 
 	err = nf_tables_newexpr(ctx, &expr_info, expr);
 	if (err < 0)
-		goto err3;
+		goto err_expr_new;
 
 	return expr;
-err3:
+err_expr_new:
 	kfree(expr);
-err2:
+err_expr_stateful:
 	owner = expr_info.ops->type->owner;
 	if (expr_info.ops->type->release_ops)
 		expr_info.ops->type->release_ops(expr_info.ops);
 
 	module_put(owner);
-err1:
+err_expr_parse:
 	return ERR_PTR(err);
 }
 
@@ -5413,9 +5417,6 @@ struct nft_expr *nft_set_elem_expr_alloc(const struct nft_ctx *ctx,
 		return expr;
 
 	err = -EOPNOTSUPP;
-	if (!(expr->ops->type->flags & NFT_EXPR_STATEFUL))
-		goto err_set_elem_expr;
-
 	if (expr->ops->type->flags & NFT_EXPR_GC) {
 		if (set->flags & NFT_SET_TIMEOUT)
 			goto err_set_elem_expr;
-- 
2.30.2

