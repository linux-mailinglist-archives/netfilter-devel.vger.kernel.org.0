Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C76A7AAEDE
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 Sep 2023 11:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjIVJzR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 22 Sep 2023 05:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjIVJzQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:55:16 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F404E19D
        for <netfilter-devel@vger.kernel.org>; Fri, 22 Sep 2023 02:55:08 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qjcsM-0004nn-84; Fri, 22 Sep 2023 11:55:06 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] tests: shell: skip flowtable-uaf if we lack table owner support
Date:   Fri, 22 Sep 2023 11:54:58 +0200
Message-ID: <20230922095501.3302-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/shell/features/table_flag_owner.nft      | 5 +++++
 tests/shell/testcases/owner/0001-flowtable-uaf | 2 ++
 2 files changed, 7 insertions(+)
 create mode 100644 tests/shell/features/table_flag_owner.nft

diff --git a/tests/shell/features/table_flag_owner.nft b/tests/shell/features/table_flag_owner.nft
new file mode 100644
index 000000000000..6e6f608a7e94
--- /dev/null
+++ b/tests/shell/features/table_flag_owner.nft
@@ -0,0 +1,5 @@
+# 6001a930ce03 ("netfilter: nftables: introduce table ownership")
+# v5.12-rc1~200^2~6^2
+table t {
+	flag owner;
+}
diff --git a/tests/shell/testcases/owner/0001-flowtable-uaf b/tests/shell/testcases/owner/0001-flowtable-uaf
index 8b7a551cc69e..c07e8d6a0ab9 100755
--- a/tests/shell/testcases/owner/0001-flowtable-uaf
+++ b/tests/shell/testcases/owner/0001-flowtable-uaf
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_table_flag_owner)
+
 set -e
 
 $NFT -f - <<EOF
-- 
2.41.0

