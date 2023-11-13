Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD217E9D5B
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Nov 2023 14:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjKMNjO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Nov 2023 08:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjKMNjM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:39:12 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8C2E172C
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Nov 2023 05:39:07 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, thaller@redhat.com
Subject: [PATCH nft,v2 05/11] tests: shell: skip comment tests if kernel lacks support
Date:   Mon, 13 Nov 2023 14:38:52 +0100
Message-Id: <20231113133858.121324-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231113133858.121324-1-pablo@netfilter.org>
References: <20231113133858.121324-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Skip tests that require comment support

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: use git describe --contains, requested by Florian.

 tests/shell/features/comment.sh                    | 14 ++++++++++++++
 tests/shell/testcases/json/0006obj_comment_0       |  1 +
 tests/shell/testcases/optionals/comments_chain_0   |  2 ++
 tests/shell/testcases/optionals/comments_objects_0 |  2 ++
 tests/shell/testcases/optionals/comments_table_0   |  2 ++
 tests/shell/testcases/sets/0020comments_0          |  2 ++
 6 files changed, 23 insertions(+)
 create mode 100755 tests/shell/features/comment.sh

diff --git a/tests/shell/features/comment.sh b/tests/shell/features/comment.sh
new file mode 100755
index 000000000000..0ad24d04cd4d
--- /dev/null
+++ b/tests/shell/features/comment.sh
@@ -0,0 +1,14 @@
+#!/bin/bash
+
+# 002f21765320 ("netfilter: nf_tables: add userdata attributes to nft_chain")
+# v5.10-rc1~107^2~60^2~5
+
+EXPECTED="table ip x {
+	chain y {
+		comment \"test\"
+	}
+}"
+
+$NFT -f - <<< $EXPECTED
+
+diff -u <($NFT list ruleset) - <<<"$EXPECTED"
diff --git a/tests/shell/testcases/json/0006obj_comment_0 b/tests/shell/testcases/json/0006obj_comment_0
index 4c2a0e8c0880..7ce859d2529f 100755
--- a/tests/shell/testcases/json/0006obj_comment_0
+++ b/tests/shell/testcases/json/0006obj_comment_0
@@ -1,6 +1,7 @@
 #!/bin/bash
 
 # NFT_TEST_REQUIRES(NFT_TEST_HAVE_json)
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_comment)
 
 set -e
 
diff --git a/tests/shell/testcases/optionals/comments_chain_0 b/tests/shell/testcases/optionals/comments_chain_0
index fba961c76841..1a84cfa67a2a 100755
--- a/tests/shell/testcases/optionals/comments_chain_0
+++ b/tests/shell/testcases/optionals/comments_chain_0
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_comment)
+
 EXPECTED='table ip test_table {
 	chain test_chain {
 		comment "test"
diff --git a/tests/shell/testcases/optionals/comments_objects_0 b/tests/shell/testcases/optionals/comments_objects_0
index 301f5518fb80..28041ebd2a43 100755
--- a/tests/shell/testcases/optionals/comments_objects_0
+++ b/tests/shell/testcases/optionals/comments_objects_0
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_comment)
+
 set -e
 
 COMMENT128="12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678"
diff --git a/tests/shell/testcases/optionals/comments_table_0 b/tests/shell/testcases/optionals/comments_table_0
index a0dfd7494661..56bb206bddcf 100755
--- a/tests/shell/testcases/optionals/comments_table_0
+++ b/tests/shell/testcases/optionals/comments_table_0
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_comment)
+
 # comments are shown
 
 $NFT add table test { comment \"test_comment\"\; }
diff --git a/tests/shell/testcases/sets/0020comments_0 b/tests/shell/testcases/sets/0020comments_0
index 44d451a8ad3a..1df38326ab57 100755
--- a/tests/shell/testcases/sets/0020comments_0
+++ b/tests/shell/testcases/sets/0020comments_0
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_comment)
+
 # Test that comments are added to set elements in standard sets.
 # Explicitly test bitmap backend set implementation.
 
-- 
2.30.2

