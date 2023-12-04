Return-Path: <netfilter-devel+bounces-159-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2978B804130
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Dec 2023 22:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 617FAB20AFB
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Dec 2023 21:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F44239FEE;
	Mon,  4 Dec 2023 21:55:01 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EE1C3
	for <netfilter-devel@vger.kernel.org>; Mon,  4 Dec 2023 13:54:57 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rAGu0-00037n-BG; Mon, 04 Dec 2023 22:54:56 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] evaluate: catch implicit map expressions without known datatype
Date: Mon,  4 Dec 2023 22:54:34 +0100
Message-ID: <20231204215444.19566-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mapping_With_invalid_datatype_crash:1:8-65: Error: Implicit map expression without known datatype
bla to tcp dport map { 80 : 1.1.1.1 . 8001, 81 : 2.2.2.2 . 9001 } bla
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c                                                | 4 ++++
 .../bogons/nft-f/mapping_With_invalid_datatype_crash          | 1 +
 2 files changed, 5 insertions(+)
 create mode 100644 tests/shell/testcases/bogons/nft-f/mapping_With_invalid_datatype_crash

diff --git a/src/evaluate.c b/src/evaluate.c
index f05cac416eb8..16ad6473db1a 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1969,6 +1969,10 @@ static int expr_evaluate_map(struct eval_ctx *ctx, struct expr **expr)
 						  ctx->ectx.len, NULL);
 		}
 
+		if (!ectx.dtype)
+			return expr_error(ctx->msgs, map,
+					  "Implicit map expression without known datatype");
+
 		if (ectx.dtype->type == TYPE_VERDICT) {
 			data = verdict_expr_alloc(&netlink_location, 0, NULL);
 		} else {
diff --git a/tests/shell/testcases/bogons/nft-f/mapping_With_invalid_datatype_crash b/tests/shell/testcases/bogons/nft-f/mapping_With_invalid_datatype_crash
new file mode 100644
index 000000000000..9f7084c838bb
--- /dev/null
+++ b/tests/shell/testcases/bogons/nft-f/mapping_With_invalid_datatype_crash
@@ -0,0 +1 @@
+bla to tcp dport map { 80 : 1.1.1.1 . 8001, 81 : 2.2.2.2 . 9001 } bla
-- 
2.41.0


