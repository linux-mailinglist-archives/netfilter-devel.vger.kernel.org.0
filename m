Return-Path: <netfilter-devel+bounces-589-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FD082A11E
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jan 2024 20:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204CF287187
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jan 2024 19:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96024D13F;
	Wed, 10 Jan 2024 19:42:32 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F544D588
	for <netfilter-devel@vger.kernel.org>; Wed, 10 Jan 2024 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nft 1/4] evaluate: skip anonymous set optimization for concatenations
Date: Wed, 10 Jan 2024 20:42:14 +0100
Message-Id: <20240110194217.484064-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240110194217.484064-1-pablo@netfilter.org>
References: <20240110194217.484064-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Concatenation is only supported with sets. Moreover, stripping of the
set leads to broken ruleset listing, therefore, skip this optimization
for the concatenations.

Fixes: fa17b17ea74a ("evaluate: revisit anonymous set with single element optimization")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 41524eef12b7..6405d55647fa 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2548,15 +2548,17 @@ static int expr_evaluate_relational(struct eval_ctx *ctx, struct expr **expr)
 		return expr_binary_error(ctx->msgs, right, left,
 					 "Cannot be used with right hand side constant value");
 
-	switch (rel->op) {
-	case OP_EQ:
-	case OP_IMPLICIT:
-	case OP_NEQ:
-		if (right->etype == EXPR_SET && right->size == 1)
-			optimize_singleton_set(rel, &right);
-		break;
-	default:
-		break;
+	if (left->etype != EXPR_CONCAT) {
+		switch (rel->op) {
+		case OP_EQ:
+		case OP_IMPLICIT:
+		case OP_NEQ:
+			if (right->etype == EXPR_SET && right->size == 1)
+				optimize_singleton_set(rel, &right);
+			break;
+		default:
+			break;
+		}
 	}
 
 	switch (rel->op) {
-- 
2.30.2


