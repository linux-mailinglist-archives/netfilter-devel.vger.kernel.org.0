Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 142CAA1C3F
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Aug 2019 16:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfH2OCb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Aug 2019 10:02:31 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:50858 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727309AbfH2OCb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:02:31 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1i3L0P-0004BR-P2; Thu, 29 Aug 2019 16:02:29 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     a@juaristi.eus, Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 4/4] src: evaluate: catch invalid 'meta day' values in eval step
Date:   Thu, 29 Aug 2019 16:09:04 +0200
Message-Id: <20190829140904.3858-5-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829140904.3858-1-fw@strlen.de>
References: <20190829140904.3858-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c      | 17 +++++++++++++----
 tests/py/any/meta.t |  4 ++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 8d5f5f8014b8..b8bcf4866d8d 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1863,11 +1863,20 @@ static int expr_evaluate_meta(struct eval_ctx *ctx, struct expr **exprp)
 {
 	struct expr *meta = *exprp;
 
-	if (ctx->pctx.family != NFPROTO_INET &&
-	    meta->flags & EXPR_F_PROTOCOL &&
-	    meta->meta.key == NFT_META_NFPROTO)
-		return expr_error(ctx->msgs, meta,
+	switch (meta->meta.key) {
+	case NFT_META_NFPROTO:
+		if (ctx->pctx.family != NFPROTO_INET &&
+		    meta->flags & EXPR_F_PROTOCOL)
+			return expr_error(ctx->msgs, meta,
 					  "meta nfproto is only useful in the inet family");
+		break;
+	case NFT_META_TIME_DAY:
+		__expr_set_context(&ctx->ectx, meta->dtype, meta->byteorder,
+				   meta->len, 6);
+		return 0;
+	default:
+		break;
+	}
 
 	return expr_evaluate_primary(ctx, exprp);
 }
diff --git a/tests/py/any/meta.t b/tests/py/any/meta.t
index 5911b74ac060..86e5d258605d 100644
--- a/tests/py/any/meta.t
+++ b/tests/py/any/meta.t
@@ -218,3 +218,7 @@ meta hour "17:00:00" drop;ok;meta hour "17:00" drop
 meta hour "17:00:01" drop;ok
 meta hour "00:00" drop;ok
 meta hour "00:01" drop;ok
+
+meta time "meh";fail
+meta hour "24:00" drop;fail
+meta day 7 drop;fail
-- 
2.21.0

