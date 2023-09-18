Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5B37A51D3
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 Sep 2023 20:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjIRSOE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 Sep 2023 14:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIRSOD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:14:03 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29D82101
        for <netfilter-devel@vger.kernel.org>; Mon, 18 Sep 2023 11:13:56 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] evaluate: update mark datatype compatibility check from maps
Date:   Mon, 18 Sep 2023 20:13:50 +0200
Message-Id: <20230918181350.330701-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Wrap datatype compatibility check into a helper function and use it for
map evaluation, otherwise the following bogus error message is
displayed:

  Error: datatype mismatch, map expects packet mark, mapping expression has type integer

Add unit tests to improve coverage for this usecase.

Fixes: 5d8e33ddb112 ("evaluate: relax type-checking for integer arguments in mark statements")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c                                | 19 ++++++----
 .../maps/dumps/vmap_mark_bitwise_0.nft        | 26 +++++++++++++
 .../shell/testcases/maps/vmap_mark_bitwise_0  | 38 +++++++++++++++++++
 3 files changed, 76 insertions(+), 7 deletions(-)
 create mode 100644 tests/shell/testcases/maps/dumps/vmap_mark_bitwise_0.nft
 create mode 100755 tests/shell/testcases/maps/vmap_mark_bitwise_0

diff --git a/src/evaluate.c b/src/evaluate.c
index a537dcfd52b3..9fccd032aaee 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1882,6 +1882,15 @@ static int mapping_expr_expand(struct eval_ctx *ctx)
 	return 0;
 }
 
+static bool datatype_compatible(const struct datatype *a, const struct datatype *b)
+{
+	return (a->type == TYPE_MARK &&
+		!datatype_equal(datatype_basetype(a), datatype_basetype(b))) ||
+	       (a->type != TYPE_MARK &&
+		b->type != TYPE_INTEGER &&
+		!datatype_equal(b, a));
+}
+
 static int expr_evaluate_map(struct eval_ctx *ctx, struct expr **expr)
 {
 	struct expr *map = *expr, *mappings;
@@ -1989,7 +1998,7 @@ static int expr_evaluate_map(struct eval_ctx *ctx, struct expr **expr)
 		    expr_name(map->mappings));
 	}
 
-	if (!datatype_equal(map->map->dtype, map->mappings->set->key->dtype))
+	if (!datatype_compatible(map->map->dtype, map->mappings->set->key->dtype))
 		return expr_binary_error(ctx->msgs, map->mappings, map->map,
 					 "datatype mismatch, map expects %s, "
 					 "mapping expression has type %s",
@@ -2823,11 +2832,7 @@ static int __stmt_evaluate_arg(struct eval_ctx *ctx, struct stmt *stmt,
 					 dtype->desc, (*expr)->dtype->desc,
 					 (*expr)->len);
 
-	if ((dtype->type == TYPE_MARK &&
-	     !datatype_equal(datatype_basetype(dtype), datatype_basetype((*expr)->dtype))) ||
-	    (dtype->type != TYPE_MARK &&
-	     (*expr)->dtype->type != TYPE_INTEGER &&
-	     !datatype_equal((*expr)->dtype, dtype)))
+	if (!datatype_compatible(dtype, (*expr)->dtype))
 		return stmt_binary_error(ctx, *expr, stmt,		/* verdict vs invalid? */
 					 "datatype mismatch: expected %s, "
 					 "expression has type %s",
@@ -4385,7 +4390,7 @@ static int stmt_evaluate_objref_map(struct eval_ctx *ctx, struct stmt *stmt)
 		    expr_name(map->mappings));
 	}
 
-	if (!datatype_equal(map->map->dtype, map->mappings->set->key->dtype))
+	if (!datatype_compatible(map->map->dtype, map->mappings->set->key->dtype))
 		return expr_binary_error(ctx->msgs, map->mappings, map->map,
 					 "datatype mismatch, map expects %s, "
 					 "mapping expression has type %s",
diff --git a/tests/shell/testcases/maps/dumps/vmap_mark_bitwise_0.nft b/tests/shell/testcases/maps/dumps/vmap_mark_bitwise_0.nft
new file mode 100644
index 000000000000..beb5ffb098f5
--- /dev/null
+++ b/tests/shell/testcases/maps/dumps/vmap_mark_bitwise_0.nft
@@ -0,0 +1,26 @@
+table ip x {
+	counter c_o0_0 {
+		packets 0 bytes 0
+	}
+
+	map sctm_o0 {
+		type mark : verdict
+		elements = { 0x00000000 : jump sctm_o0_0, 0x00000001 : jump sctm_o0_1 }
+	}
+
+	map sctm_o1 {
+		type mark : counter
+		elements = { 0x00000000 : "c_o0_0" }
+	}
+
+	chain sctm_o0_0 {
+	}
+
+	chain sctm_o0_1 {
+	}
+
+	chain SET_ctmark_RPLYroute {
+		meta mark >> 8 & 0xf vmap @sctm_o0
+		counter name meta mark >> 8 & 0xf map @sctm_o1
+	}
+}
diff --git a/tests/shell/testcases/maps/vmap_mark_bitwise_0 b/tests/shell/testcases/maps/vmap_mark_bitwise_0
new file mode 100755
index 000000000000..3ac99d2853b2
--- /dev/null
+++ b/tests/shell/testcases/maps/vmap_mark_bitwise_0
@@ -0,0 +1,38 @@
+#!/bin/bash
+
+set -e
+
+RULESET="table ip x {
+	chain sctm_o0_0 {
+	}
+
+	chain sctm_o0_1 {
+	}
+
+	map sctm_o0 {
+		type mark : verdict
+		elements = {
+			0x0 : jump sctm_o0_0,
+			0x1 : jump sctm_o0_1,
+		}
+	}
+
+	counter c_o0_0 {}
+
+	map sctm_o1 {
+		type mark : counter
+		elements = {
+			0x0 : \"c_o0_0\",
+		}
+	}
+
+	chain SET_ctmark_RPLYroute {
+		(meta mark >> 8) & 0xF vmap @sctm_o0
+	}
+
+	chain SET_ctmark_RPLYroute {
+		counter name (meta mark >>  8) & 0xF map @sctm_o1
+	}
+}"
+
+$NFT -f - <<< $RULESET
-- 
2.30.2

