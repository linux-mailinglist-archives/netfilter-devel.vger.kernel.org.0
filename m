Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A50776C811
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jul 2019 05:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfGRDjp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Jul 2019 23:39:45 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:33902 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389086AbfGRDjp (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:39:45 -0400
Received: from localhost ([::1]:46992 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hnxGi-0008Qq-7c; Thu, 18 Jul 2019 05:39:44 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 2/3] meta: Reject nfproto value 0xffff
Date:   Thu, 18 Jul 2019 05:39:39 +0200
Message-Id: <20190718033940.12820-2-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718033940.12820-1-phil@nwl.cc>
References: <20190718033940.12820-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Since parsing of arphrd_type happens via sym_tbl, there is no dedicated
parser function to perform the check in. So instead make use of maxval
in expr_ctx to reject the value.

While being at it, introduce a switch() to check for meta.key value in a
single place.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/evaluate.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 55cd9d00d274c..ff52aefc669e0 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -23,6 +23,7 @@
 #include <netinet/icmp6.h>
 #include <net/ethernet.h>
 #include <net/if.h>
+#include <net/if_arp.h>
 #include <errno.h>
 
 #include <expression.h>
@@ -1795,14 +1796,25 @@ static int expr_evaluate_fib(struct eval_ctx *ctx, struct expr **exprp)
 static int expr_evaluate_meta(struct eval_ctx *ctx, struct expr **exprp)
 {
 	struct expr *meta = *exprp;
+	unsigned int maxval = 0;
 
-	if (ctx->pctx.family != NFPROTO_INET &&
-	    meta->flags & EXPR_F_PROTOCOL &&
-	    meta->meta.key == NFT_META_NFPROTO)
+	switch (meta->meta.key) {
+	case NFT_META_NFPROTO:
+		if (ctx->pctx.family == NFPROTO_INET ||
+		    !(meta->flags & EXPR_F_PROTOCOL))
+			break;
 		return expr_error(ctx->msgs, meta,
-					  "meta nfproto is only useful in the inet family");
-
-	return expr_evaluate_primary(ctx, exprp);
+				  "meta nfproto is only useful in the inet family");
+	case NFT_META_IIFTYPE:
+	case NFT_META_OIFTYPE:
+		maxval = ARPHRD_VOID - 1;
+		break;
+	default:
+		break;
+	}
+	__expr_set_context(&ctx->ectx, (*exprp)->dtype, (*exprp)->byteorder,
+			   (*exprp)->len, maxval);
+	return 0;
 }
 
 static int expr_evaluate_socket(struct eval_ctx *ctx, struct expr **expr)
-- 
2.22.0

