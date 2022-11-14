Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6490627A8D
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Nov 2022 11:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbiKNKcQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Nov 2022 05:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiKNKb7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:31:59 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C459AF595
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Nov 2022 02:31:58 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables: do not set up extensions for end interval
Date:   Mon, 14 Nov 2022 11:31:54 +0100
Message-Id: <20221114103154.8148-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Elements with end interval flag on do not store extensions. The set
definition is currently setting on the timeout and stateful expression
for end interval elements.

This leads to skipping end interval elements from the set->ops->walk()
path as the expired check bogusly reports true.

Moreover, do not set up stateful expressions for elements with end
interval flag set on since this is never used.

Fixes: 65038428b2c6 ("netfilter: nf_tables: allow to specify stateful expression in set definition")
Fixes: 8d8540c4f5e0 ("netfilter: nft_set_rbtree: add timeout support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 80e613405f6f..c73352896e60 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6006,7 +6006,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 					    &timeout);
 		if (err)
 			return err;
-	} else if (set->flags & NFT_SET_TIMEOUT) {
+	} else if (set->flags & NFT_SET_TIMEOUT &&
+		   !(flags & NFT_SET_ELEM_INTERVAL_END)) {
 		timeout = set->timeout;
 	}
 
@@ -6072,7 +6073,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			err = -EOPNOTSUPP;
 			goto err_set_elem_expr;
 		}
-	} else if (set->num_exprs > 0) {
+	} else if (set->num_exprs > 0 &&
+		   !(flags & NFT_SET_ELEM_INTERVAL_END)) {
 		err = nft_set_elem_expr_clone(ctx, set, expr_array);
 		if (err < 0)
 			goto err_set_elem_expr_clone;
-- 
2.30.2

