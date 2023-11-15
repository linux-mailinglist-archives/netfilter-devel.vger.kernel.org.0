Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C187E9D5E
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Nov 2023 14:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjKMNjQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Nov 2023 08:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjKMNjN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:39:13 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14ED110E2
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Nov 2023 05:39:10 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, thaller@redhat.com
Subject: [PATCH nft,v2 10/11] tests: shell: split single element in anonymous set
Date:   Mon, 13 Nov 2023 14:38:57 +0100
Message-Id: <20231113133858.121324-10-pablo@netfilter.org>
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

Split this to move set stateful expression support into a separated test
not to harm existing coverage.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes

 .../optimizations/dumps/single_anon_set.nft   |  1 -
 .../dumps/single_anon_set_expr.nft            |  5 ++++
 .../testcases/optimizations/single_anon_set   |  3 ---
 .../optimizations/single_anon_set_expr        | 26 +++++++++++++++++++
 4 files changed, 31 insertions(+), 4 deletions(-)
 create mode 100644 tests/shell/testcases/optimizations/dumps/single_anon_set_expr.nft
 create mode 100755 tests/shell/testcases/optimizations/single_anon_set_expr

diff --git a/tests/shell/testcases/optimizations/dumps/single_anon_set.nft b/tests/shell/testcases/optimizations/dumps/single_anon_set.nft
index 3f703034d80f..35e3f36e1a54 100644
--- a/tests/shell/testcases/optimizations/dumps/single_anon_set.nft
+++ b/tests/shell/testcases/optimizations/dumps/single_anon_set.nft
@@ -11,6 +11,5 @@ table ip test {
 		ip daddr . tcp dport { 192.168.0.1 . 22 } accept
 		meta mark set ip daddr map { 192.168.0.1 : 0x00000001 }
 		ct state { established, related } accept
-		meta mark { 0x0000000a counter packets 0 bytes 0 }
 	}
 }
diff --git a/tests/shell/testcases/optimizations/dumps/single_anon_set_expr.nft b/tests/shell/testcases/optimizations/dumps/single_anon_set_expr.nft
new file mode 100644
index 000000000000..54880b927250
--- /dev/null
+++ b/tests/shell/testcases/optimizations/dumps/single_anon_set_expr.nft
@@ -0,0 +1,5 @@
+table ip test {
+	chain test {
+		meta mark { 0x0000000a counter packets 0 bytes 0 }
+	}
+}
diff --git a/tests/shell/testcases/optimizations/single_anon_set b/tests/shell/testcases/optimizations/single_anon_set
index 84fc2a7f03a8..632e965f37a7 100755
--- a/tests/shell/testcases/optimizations/single_anon_set
+++ b/tests/shell/testcases/optimizations/single_anon_set
@@ -46,9 +46,6 @@ table ip test {
 		# ct state cannot be both established and related
 		# at the same time, but this needs extra work.
 		ct state { established, related } accept
-
-		# with stateful statement
-		meta mark { 0x0000000a counter }
 	}
 }
 EOF
diff --git a/tests/shell/testcases/optimizations/single_anon_set_expr b/tests/shell/testcases/optimizations/single_anon_set_expr
new file mode 100755
index 000000000000..81b7cebadd5d
--- /dev/null
+++ b/tests/shell/testcases/optimizations/single_anon_set_expr
@@ -0,0 +1,26 @@
+#!/bin/bash
+
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_set_expr)
+
+set -e
+
+test -d "$NFT_TEST_TESTTMPDIR"
+
+# Input file contains rules with anon sets that contain
+# one element, plus extra rule with two elements (that should be
+# left alone).
+
+# Dump file has the simplified rules where anon sets have been
+# replaced by equality tests where possible.
+file_input1="$NFT_TEST_TESTTMPDIR/input1.nft"
+
+cat <<EOF > "$file_input1"
+table ip test {
+	chain test {
+		# with stateful statement
+		meta mark { 0x0000000a counter }
+	}
+}
+EOF
+
+$NFT -f "$file_input1"
-- 
2.30.2

