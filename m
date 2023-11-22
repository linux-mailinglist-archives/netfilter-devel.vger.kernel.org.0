Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85D57F43EE
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Nov 2023 11:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjKVKce (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Nov 2023 05:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjKVKcc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:32:32 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0648693
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Nov 2023 02:32:29 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 8/8] tests: shell: skip if kernel does not allow to restore set element expiration
Date:   Wed, 22 Nov 2023 11:32:21 +0100
Message-Id: <20231122103221.90160-8-pablo@netfilter.org>
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
 tests/shell/features/setelem_expiration.sh     | 18 ++++++++++++++++++
 .../sets/0036add_set_element_expiration_0      |  2 ++
 2 files changed, 20 insertions(+)
 create mode 100755 tests/shell/features/setelem_expiration.sh

diff --git a/tests/shell/features/setelem_expiration.sh b/tests/shell/features/setelem_expiration.sh
new file mode 100755
index 000000000000..deb06cfb2f06
--- /dev/null
+++ b/tests/shell/features/setelem_expiration.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+
+# v5.3-rc1~140^2~153^2~8
+# 79ebb5bb4e38 ("netfilter: nf_tables: enable set expiration time for set elements")
+
+EXPECTED="table ip x {
+	set y {
+		type ipv4_addr
+		flags dynamic,timeout;
+		elements = { 1.1.1.1 expires 30s }
+	}
+}"
+
+$NFT -f - <<< $EXPECTED
+
+$NFT list ruleset | grep "expires"
+[ $? -ne 1 ] && exit 1
+exit 0
diff --git a/tests/shell/testcases/sets/0036add_set_element_expiration_0 b/tests/shell/testcases/sets/0036add_set_element_expiration_0
index 0fd016e9f857..d961ffd4cdcd 100755
--- a/tests/shell/testcases/sets/0036add_set_element_expiration_0
+++ b/tests/shell/testcases/sets/0036add_set_element_expiration_0
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_setelem_expiration)
+
 set -e
 
 drop_seconds() {
-- 
2.30.2

