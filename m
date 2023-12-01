Return-Path: <netfilter-devel+bounces-129-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6498800B99
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 Dec 2023 14:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178E61F20F7C
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 Dec 2023 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F362577F;
	Fri,  1 Dec 2023 13:16:32 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B70A0
	for <netfilter-devel@vger.kernel.org>; Fri,  1 Dec 2023 05:16:26 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1r93NY-0005WZ-3n; Fri, 01 Dec 2023 14:16:24 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] evaluate: prevent assert when evaluating very large shift values
Date: Fri,  1 Dec 2023 14:16:14 +0100
Message-ID: <20231201131617.10613-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error out instead of 'nft: gmputil.c:67: mpz_get_uint32: Assertion `cnt <= 1' failed.'.

Fixes: edecd58755a8 ("evaluate: support shifts larger than the width of the left operand")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c                                       | 9 +++++++--
 tests/shell/testcases/bogons/nft-f/huge_shift_assert | 5 +++++
 2 files changed, 12 insertions(+), 2 deletions(-)
 create mode 100644 tests/shell/testcases/bogons/nft-f/huge_shift_assert

diff --git a/src/evaluate.c b/src/evaluate.c
index 048880e54daf..e4dc5f65e3bd 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1312,9 +1312,14 @@ static int constant_binop_simplify(struct eval_ctx *ctx, struct expr **expr)
 static int expr_evaluate_shift(struct eval_ctx *ctx, struct expr **expr)
 {
 	struct expr *op = *expr, *left = op->left, *right = op->right;
-	unsigned int shift = mpz_get_uint32(right->value);
-	unsigned int max_shift_len;
+	unsigned int shift, max_shift_len;
 
+	/* mpz_get_uint32 has assert() for huge values */
+	if (mpz_cmp_ui(right->value, UINT_MAX) > 0)
+		return expr_binary_error(ctx->msgs, right, left,
+					 "shifts exceeding %u bits are not supported", UINT_MAX);
+
+	shift = mpz_get_uint32(right->value);
 	if (ctx->stmt_len > left->len)
 		max_shift_len = ctx->stmt_len;
 	else
diff --git a/tests/shell/testcases/bogons/nft-f/huge_shift_assert b/tests/shell/testcases/bogons/nft-f/huge_shift_assert
new file mode 100644
index 000000000000..7599f8505209
--- /dev/null
+++ b/tests/shell/testcases/bogons/nft-f/huge_shift_assert
@@ -0,0 +1,5 @@
+table ip t {
+        chain c {
+		counter name meta mark >> 88888888888888888888
+        }
+}
-- 
2.41.0


