Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18827F43EA
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Nov 2023 11:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjKVKcc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Nov 2023 05:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjKVKca (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:32:30 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47FEAB2
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Nov 2023 02:32:26 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/8] tests: shell: skip stateful object updates if unsupported
Date:   Wed, 22 Nov 2023 11:32:15 +0100
Message-Id: <20231122103221.90160-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231122103221.90160-1-pablo@netfilter.org>
References: <20231122103221.90160-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 .../shell/features/stateful_object_update.sh  | 21 +++++++++++++++++++
 .../optionals/update_object_handles_0         |  2 ++
 2 files changed, 23 insertions(+)
 create mode 100755 tests/shell/features/stateful_object_update.sh

diff --git a/tests/shell/features/stateful_object_update.sh b/tests/shell/features/stateful_object_update.sh
new file mode 100755
index 000000000000..62fbf7e38563
--- /dev/null
+++ b/tests/shell/features/stateful_object_update.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+
+# d62d0ba97b58 ("netfilter: nf_tables: Introduce stateful object update operation")
+# v5.4-rc1~131^2~59^2~2
+
+set -e
+$NFT add table test-ip
+$NFT add quota test-ip traffic-quota 25 mbytes
+$NFT add quota test-ip traffic-quota 50 mbytes
+
+EXPECTED="table ip test-ip {
+	quota traffic-quota {
+		50 mbytes
+	}
+}"
+
+GET="$($NFT list ruleset)"
+if [ "$EXPECTED" != "$GET" ] ; then
+	diff -u <(echo "$EXPECTED") <(echo "$GET")
+	exit 1
+fi
diff --git a/tests/shell/testcases/optionals/update_object_handles_0 b/tests/shell/testcases/optionals/update_object_handles_0
index 8b12b8c57cd8..ccd96779d9b3 100755
--- a/tests/shell/testcases/optionals/update_object_handles_0
+++ b/tests/shell/testcases/optionals/update_object_handles_0
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_stateful_object_update)
+
 set -e
 $NFT add table test-ip
 $NFT add counter test-ip traffic-counter
-- 
2.30.2

