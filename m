Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6AB7F43EF
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Nov 2023 11:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjKVKce (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Nov 2023 05:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjKVKcc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:32:32 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DCE6100
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Nov 2023 02:32:28 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 7/8] tests: shell: skip secmark tests if kernel does not support it
Date:   Wed, 22 Nov 2023 11:32:20 +0100
Message-Id: <20231122103221.90160-7-pablo@netfilter.org>
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
 tests/shell/features/secmark.nft                | 7 +++++++
 tests/shell/testcases/json/0005secmark_objref_0 | 1 +
 2 files changed, 8 insertions(+)
 create mode 100644 tests/shell/features/secmark.nft

diff --git a/tests/shell/features/secmark.nft b/tests/shell/features/secmark.nft
new file mode 100644
index 000000000000..ccbb572f2756
--- /dev/null
+++ b/tests/shell/features/secmark.nft
@@ -0,0 +1,7 @@
+# fb961945457f ("netfilter: nf_tables: add SECMARK support")
+# v4.20-rc1~14^2~125^2~5
+table inet x {
+	secmark ssh_server {
+		"system_u:object_r:ssh_server_packet_t:s0"
+	}
+}
diff --git a/tests/shell/testcases/json/0005secmark_objref_0 b/tests/shell/testcases/json/0005secmark_objref_0
index 992d1b000d86..5c44f09337be 100755
--- a/tests/shell/testcases/json/0005secmark_objref_0
+++ b/tests/shell/testcases/json/0005secmark_objref_0
@@ -1,6 +1,7 @@
 #!/bin/bash
 
 # NFT_TEST_REQUIRES(NFT_TEST_HAVE_json)
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_secmark)
 
 set -e
 
-- 
2.30.2

