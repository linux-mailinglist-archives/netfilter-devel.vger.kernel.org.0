Return-Path: <netfilter-devel+bounces-272-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD2B80E800
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Dec 2023 10:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B881281E30
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 Dec 2023 09:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B0458AB8;
	Tue, 12 Dec 2023 09:44:49 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B3CD9
	for <netfilter-devel@vger.kernel.org>; Tue, 12 Dec 2023 01:44:45 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rCzJk-0006mu-LD; Tue, 12 Dec 2023 10:44:44 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] parser_bison: make sure obj_free releases timeout policies
Date: Tue, 12 Dec 2023 10:44:35 +0100
Message-ID: <20231212094438.26063-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

obj_free() won't release them because ->type is still 0 at this
point.

Init this to CT_TIMEOUT.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/parser_bison.y                                           | 1 +
 .../shell/testcases/bogons/nft-f/ct_timeout_memleak_objfree  | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100644 tests/shell/testcases/bogons/nft-f/ct_timeout_memleak_objfree

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 91c4d263dc73..ce80bcd917c3 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -2513,6 +2513,7 @@ ct_timeout_block	:	/*empty */
 			{
 				$$ = $<obj>-1;
 				init_list_head(&$$->ct_timeout.timeout_list);
+				$$->type = NFT_OBJECT_CT_TIMEOUT;
 			}
 			|	ct_timeout_block     common_block
 			|	ct_timeout_block     stmt_separator
diff --git a/tests/shell/testcases/bogons/nft-f/ct_timeout_memleak_objfree b/tests/shell/testcases/bogons/nft-f/ct_timeout_memleak_objfree
new file mode 100644
index 000000000000..28b1a211de0c
--- /dev/null
+++ b/tests/shell/testcases/bogons/nft-f/ct_timeout_memleak_objfree
@@ -0,0 +1,5 @@
+table ip filter {
+	ct timeout cttime {
+		protocol tcp
+		l3proto ip
+		policy = { close : 12s }
-- 
2.41.0


