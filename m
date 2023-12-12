Return-Path: <netfilter-devel+bounces-278-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6665A80EE2D
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Dec 2023 14:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A561C20A8F
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Dec 2023 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC5F6F63A;
	Tue, 12 Dec 2023 13:57:59 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A84AD
	for <netfilter-devel@vger.kernel.org>; Tue, 12 Dec 2023 05:57:55 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rD3Gj-00005q-9l; Tue, 12 Dec 2023 14:57:53 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] parser_bison: reject large raw payload expressions
Date: Tue, 12 Dec 2023 14:57:41 +0100
Message-ID: <20231212135746.10129-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel will reject this too, but unfortunately nft will
try to cram the data into the underlying libnftnl expr.

This causes heap corruption.  This should also needs an independent
fix in libnftnl.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/parser_bison.y                                         | 7 +++++++
 .../bogons/nft-f/stack_overflow_via_large_raw_expr         | 5 +++++
 2 files changed, 12 insertions(+)
 create mode 100644 tests/shell/testcases/bogons/nft-f/stack_overflow_via_large_raw_expr

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 85cc9b6b0a80..2796e4387e03 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -5641,6 +5641,13 @@ payload_expr		:	payload_raw_expr
 
 payload_raw_expr	:	AT	payload_base_spec	COMMA	NUM	COMMA	NUM	close_scope_at
 			{
+				if ($6 > NFT_REG32_COUNT * sizeof(uint32_t) * BITS_PER_BYTE) {
+					erec_queue(error(&@1, "raw payload length %u exceeds upper limit of %u",
+							 $6, NFT_REG32_COUNT * sizeof(uint32_t) * BITS_PER_BYTE),
+							 state->msgs);
+					YYERROR;
+				}
+
 				$$ = payload_expr_alloc(&@$, NULL, 0);
 				payload_init_raw($$, $2, $4, $6);
 				$$->byteorder		= BYTEORDER_BIG_ENDIAN;
diff --git a/tests/shell/testcases/bogons/nft-f/stack_overflow_via_large_raw_expr b/tests/shell/testcases/bogons/nft-f/stack_overflow_via_large_raw_expr
new file mode 100644
index 000000000000..66bd6bf87732
--- /dev/null
+++ b/tests/shell/testcases/bogons/nft-f/stack_overflow_via_large_raw_expr
@@ -0,0 +1,5 @@
+table t {
+	chain c {
+		 @th,160,1272 gt 0
+	}
+}
-- 
2.41.0


