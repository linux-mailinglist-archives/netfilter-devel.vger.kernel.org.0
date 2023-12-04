Return-Path: <netfilter-devel+bounces-157-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA37D8040B1
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Dec 2023 22:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F681F21176
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Dec 2023 21:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1028935EF6;
	Mon,  4 Dec 2023 21:05:03 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC53FA
	for <netfilter-devel@vger.kernel.org>; Mon,  4 Dec 2023 13:04:58 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rAG7b-0002r6-Gd; Mon, 04 Dec 2023 22:04:55 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] evaluate: disable meta set with ranges
Date: Mon,  4 Dec 2023 22:04:44 +0100
Message-ID: <20231204210450.16139-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... this will cause an assertion in netlink linearization, catch this
at eval stage instead.

before:
BUG: unknown expression type range
nft: netlink_linearize.c:908: netlink_gen_expr: Assertion `0' failed.

after:
/unknown_expr_type_range_assert:3:31-40: Error: Meta expression cannot be a range
meta mark set 0x001-3434
              ^^^^^^^^^^

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c                                      | 13 +++++++++++++
 .../bogons/nft-f/unknown_expr_type_range_assert     |  5 +++++
 2 files changed, 18 insertions(+)
 create mode 100644 tests/shell/testcases/bogons/nft-f/unknown_expr_type_range_assert

diff --git a/src/evaluate.c b/src/evaluate.c
index 51ae276aac6a..131b0a0eaa66 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3169,6 +3169,19 @@ static int stmt_evaluate_meta(struct eval_ctx *ctx, struct stmt *stmt)
 				&stmt->meta.expr);
 	ctx->stmt_len = 0;
 
+	if (ret < 0)
+		return ret;
+
+	switch (stmt->meta.expr->etype) {
+	case EXPR_RANGE:
+		ret = expr_error(ctx->msgs, stmt->meta.expr,
+				 "Meta expression cannot be a range");
+		break;
+	default:
+		break;
+
+	}
+
 	return ret;
 }
 
diff --git a/tests/shell/testcases/bogons/nft-f/unknown_expr_type_range_assert b/tests/shell/testcases/bogons/nft-f/unknown_expr_type_range_assert
new file mode 100644
index 000000000000..234dd623167d
--- /dev/null
+++ b/tests/shell/testcases/bogons/nft-f/unknown_expr_type_range_assert
@@ -0,0 +1,5 @@
+table ip x {
+        chain k {
+                meta mark set 0x001-3434
+        }
+}
-- 
2.41.0


