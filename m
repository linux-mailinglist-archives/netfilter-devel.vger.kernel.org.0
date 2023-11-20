Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6F37F13D5
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Nov 2023 13:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjKTM4s (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Nov 2023 07:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjKTM4r (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:56:47 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C22910C
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Nov 2023 04:56:44 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1r53pS-0005sb-Ld; Mon, 20 Nov 2023 13:56:42 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] tests: shell: skip meta time test meta expression lacks support
Date:   Mon, 20 Nov 2023 13:56:20 +0100
Message-ID: <20231120125623.19540-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/shell/features/meta_time.nft      | 7 +++++++
 tests/shell/testcases/listing/meta_time | 2 ++
 2 files changed, 9 insertions(+)
 create mode 100644 tests/shell/features/meta_time.nft

diff --git a/tests/shell/features/meta_time.nft b/tests/shell/features/meta_time.nft
new file mode 100644
index 000000000000..34550de46ce9
--- /dev/null
+++ b/tests/shell/features/meta_time.nft
@@ -0,0 +1,7 @@
+# 63d10e12b00d ("netfilter: nft_meta: support for time matching")
+# v5.4-rc1~131^2~59^2~6
+table ip t {
+	chain c {
+		meta time "1970-05-23 21:07:14"
+	}
+}
diff --git a/tests/shell/testcases/listing/meta_time b/tests/shell/testcases/listing/meta_time
index a97619989986..4db517d3a83b 100755
--- a/tests/shell/testcases/listing/meta_time
+++ b/tests/shell/testcases/listing/meta_time
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_meta_time)
+
 set -e
 
 TMP1=$(mktemp)
-- 
2.41.0

