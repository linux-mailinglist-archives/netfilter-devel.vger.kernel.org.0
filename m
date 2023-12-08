Return-Path: <netfilter-devel+bounces-251-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075BA80A371
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 Dec 2023 13:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A3328188A
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 Dec 2023 12:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F94A14265;
	Fri,  8 Dec 2023 12:37:46 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B121994
	for <netfilter-devel@vger.kernel.org>; Fri,  8 Dec 2023 04:37:39 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rBa6r-0007Ex-LL; Fri, 08 Dec 2023 13:37:37 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] parser_bison: fix memleak in meta set error handling
Date: Fri,  8 Dec 2023 13:37:27 +0100
Message-ID: <20231208123730.7081-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We must release the expression here, found via afl++ and
-fsanitize-address build.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/parser_bison.y                                           | 1 +
 .../shell/testcases/bogons/nft-f/memleak_on_meta_set_errpath | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100644 tests/shell/testcases/bogons/nft-f/memleak_on_meta_set_errpath

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 3e0f08b22c44..91c4d263dc73 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -5338,6 +5338,7 @@ meta_stmt		:	META	meta_key	SET	stmt_expr	close_scope_meta
 				free_const($2);
 				if (erec != NULL) {
 					erec_queue(erec, state->msgs);
+					expr_free($4);
 					YYERROR;
 				}
 
diff --git a/tests/shell/testcases/bogons/nft-f/memleak_on_meta_set_errpath b/tests/shell/testcases/bogons/nft-f/memleak_on_meta_set_errpath
new file mode 100644
index 000000000000..917e8bf83f6a
--- /dev/null
+++ b/tests/shell/testcases/bogons/nft-f/memleak_on_meta_set_errpath
@@ -0,0 +1,5 @@
+table filter {
+ chain y {
+  meta seccark set ct secmark
+ }
+}
-- 
2.41.0


