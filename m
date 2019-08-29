Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA21A1C3C
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Aug 2019 16:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfH2OCT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Aug 2019 10:02:19 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:50840 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbfH2OCT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:02:19 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1i3L0D-0004Ap-BH; Thu, 29 Aug 2019 16:02:17 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     a@juaristi.eus, Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 1/4] evaluate: New internal helper __expr_evaluate_range
Date:   Thu, 29 Aug 2019 16:09:01 +0200
Message-Id: <20190829140904.3858-2-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829140904.3858-1-fw@strlen.de>
References: <20190829140904.3858-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Ander Juaristi <a@juaristi.eus>

This is used by the followup patch to evaluate a range without emitting
an error when the left value is larger than the right one.

This is done to handle time-matching such as
23:00-01:00 -- expr_evaluate_range() will reject this, but
we want to be able to evaluate and then handle this as a request
to match from 23:00 to 1am.

Signed-off-by: Ander Juaristi <a@juaristi.eus>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 831eb7c25c5c..a707f5e7e1fb 100755
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -941,16 +941,28 @@ static int expr_evaluate_range_expr(struct eval_ctx *ctx,
 	return 0;
 }
 
-static int expr_evaluate_range(struct eval_ctx *ctx, struct expr **expr)
+static int __expr_evaluate_range(struct eval_ctx *ctx, struct expr **expr)
 {
-	struct expr *range = *expr, *left, *right;
+	struct expr *range = *expr;
 
 	if (expr_evaluate_range_expr(ctx, range, &range->left) < 0)
 		return -1;
-	left = range->left;
-
 	if (expr_evaluate_range_expr(ctx, range, &range->right) < 0)
 		return -1;
+
+	return 0;
+}
+
+static int expr_evaluate_range(struct eval_ctx *ctx, struct expr **expr)
+{
+	struct expr *range = *expr, *left, *right;
+	int rc;
+
+	rc = __expr_evaluate_range(ctx, expr);
+	if (rc)
+		return rc;
+
+	left = range->left;
 	right = range->right;
 
 	if (mpz_cmp(left->value, right->value) >= 0)
-- 
2.21.0

