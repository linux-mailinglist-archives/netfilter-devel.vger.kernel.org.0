Return-Path: <netfilter-devel+bounces-280-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE0980F167
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Dec 2023 16:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9261C20981
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Dec 2023 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A9E76DCC;
	Tue, 12 Dec 2023 15:45:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FD7EB
	for <netfilter-devel@vger.kernel.org>; Tue, 12 Dec 2023 07:45:23 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rD4wj-0000nV-3o; Tue, 12 Dec 2023 16:45:21 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] evaluate: error out if concat expression becomes too large
Date: Tue, 12 Dec 2023 16:45:12 +0100
Message-ID: <20231212154516.21144-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before:
BUG: nld buffer overflow: want to copy 132, max 64

After:
Error: Concatenation of size 544 exceeds maximum size of 512
udp length . @th,0,512 . @th,512,512 { 47-63 . 0xe373135363130 . 0x33131303735353203 }
                             ^^^^^^^^^
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Pablo, I can merge this with
 "[nft] parser_bison: reject large raw payload expressions" if you
 prefer.

 src/evaluate.c                                               | 4 ++++
 .../bogons/nft-f/stack_overflow_via_large_concat_expr        | 5 +++++
 2 files changed, 9 insertions(+)
 create mode 100644 tests/shell/testcases/bogons/nft-f/stack_overflow_via_large_concat_expr

diff --git a/src/evaluate.c b/src/evaluate.c
index c7191e8cad08..e2d9a320587e 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1591,6 +1591,10 @@ static int expr_evaluate_concat(struct eval_ctx *ctx, struct expr **expr)
 		}
 
 		ctx->inner_desc = NULL;
+
+		if (size > NFT_REG32_COUNT * sizeof(uint32_t) * BITS_PER_BYTE)
+			return expr_error(ctx->msgs, i, "Concatenation of size %u exceeds maximum size of %u",
+					  size, NFT_REG32_COUNT * sizeof(uint32_t) * BITS_PER_BYTE);
 	}
 
 	(*expr)->flags |= flags;
diff --git a/tests/shell/testcases/bogons/nft-f/stack_overflow_via_large_concat_expr b/tests/shell/testcases/bogons/nft-f/stack_overflow_via_large_concat_expr
new file mode 100644
index 000000000000..8b0d27444c22
--- /dev/null
+++ b/tests/shell/testcases/bogons/nft-f/stack_overflow_via_large_concat_expr
@@ -0,0 +1,5 @@
+table t {
+	chain c {
+		udp length . @th,0,512 . @th,512,512 { 47-63 . 0xe373135363130 . 0x33131303735353203 }
+	}
+}
-- 
2.41.0


