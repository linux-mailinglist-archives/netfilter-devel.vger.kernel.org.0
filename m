Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBAB7EBFA5
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Nov 2023 10:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjKOJmm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Nov 2023 04:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjKOJml (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:42:41 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10777FE
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Nov 2023 01:42:38 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, thaller@redhat.com
Subject: [PATCH nft 1/4] tests: shell: skip if kernel does not support flowtable counter
Date:   Wed, 15 Nov 2023 10:42:28 +0100
Message-Id: <20231115094231.168870-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231115094231.168870-1-pablo@netfilter.org>
References: <20231115094231.168870-1-pablo@netfilter.org>
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

Check if kernel provides flowtable counter supports which is available
since 53c2b2899af7 ("netfilter: flowtable: add counter support").

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/features/flowtable_counter.sh        | 16 ++++++++++++++++
 .../testcases/flowtable/0012flowtable_variable_0 |  2 ++
 2 files changed, 18 insertions(+)
 create mode 100755 tests/shell/features/flowtable_counter.sh

diff --git a/tests/shell/features/flowtable_counter.sh b/tests/shell/features/flowtable_counter.sh
new file mode 100755
index 000000000000..a4c4c62124b0
--- /dev/null
+++ b/tests/shell/features/flowtable_counter.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+
+# 53c2b2899af7 ("netfilter: flowtable: add counter support")
+# v5.7-rc1~146^2~12^2~16
+
+EXPECTED="table ip filter2 {
+	flowtable main_ft2 {
+		hook ingress priority filter
+		devices = { lo }
+		counter
+	}
+}"
+
+$NFT -f - <<< $EXPECTED
+
+diff -u <($NFT list ruleset) - <<<"$EXPECTED"
diff --git a/tests/shell/testcases/flowtable/0012flowtable_variable_0 b/tests/shell/testcases/flowtable/0012flowtable_variable_0
index 080059d24935..9c03820f128e 100755
--- a/tests/shell/testcases/flowtable/0012flowtable_variable_0
+++ b/tests/shell/testcases/flowtable/0012flowtable_variable_0
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_flowtable_counter)
+
 set -e
 
 iface_cleanup() {
-- 
2.30.2

