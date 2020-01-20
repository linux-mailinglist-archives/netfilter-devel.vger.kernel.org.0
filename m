Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDC6142F86
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Jan 2020 17:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgATQZt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jan 2020 11:25:49 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:60796 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbgATQZt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:25:49 -0500
Received: from localhost ([::1]:45654 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1itZs4-00062L-6X; Mon, 20 Jan 2020 17:25:48 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 2/4] netlink: Fix leaks in netlink_parse_cmp()
Date:   Mon, 20 Jan 2020 17:25:38 +0100
Message-Id: <20200120162540.9699-3-phil@nwl.cc>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120162540.9699-1-phil@nwl.cc>
References: <20200120162540.9699-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This fixes several problems at once:

* Err path would leak expr 'right' in two places and 'left' in one.
* Concat case would leak 'right' by overwriting the pointer. Introduce a
  temporary variable to hold the new pointer.

Fixes: 6377380bc265f ("netlink_delinearize: handle relational and lookup concat expressions")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/netlink_delinearize.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 06a0312b9921a..88dbd5a8ecdf3 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -274,7 +274,7 @@ static void netlink_parse_cmp(struct netlink_parse_ctx *ctx,
 {
 	struct nft_data_delinearize nld;
 	enum nft_registers sreg;
-	struct expr *expr, *left, *right;
+	struct expr *expr, *left, *right, *tmp;
 	enum ops op;
 
 	sreg = netlink_parse_register(nle, NFTNL_EXPR_CMP_SREG);
@@ -291,19 +291,26 @@ static void netlink_parse_cmp(struct netlink_parse_ctx *ctx,
 
 	if (left->len > right->len &&
 	    expr_basetype(left) != &string_type) {
-		return netlink_error(ctx, loc, "Relational expression size mismatch");
+		netlink_error(ctx, loc, "Relational expression size mismatch");
+		goto err_free;
 	} else if (left->len > 0 && left->len < right->len) {
 		expr_free(left);
 		left = netlink_parse_concat_expr(ctx, loc, sreg, right->len);
 		if (left == NULL)
-			return;
-		right = netlink_parse_concat_data(ctx, loc, sreg, right->len, right);
-		if (right == NULL)
-			return;
+			goto err_free;
+		tmp = netlink_parse_concat_data(ctx, loc, sreg, right->len, right);
+		if (tmp == NULL)
+			goto err_free;
+		expr_free(right);
+		right = tmp;
 	}
 
 	expr = relational_expr_alloc(loc, op, left, right);
 	ctx->stmt = expr_stmt_alloc(loc, expr);
+	return;
+err_free:
+	expr_free(left);
+	expr_free(right);
 }
 
 static void netlink_parse_lookup(struct netlink_parse_ctx *ctx,
-- 
2.24.1

