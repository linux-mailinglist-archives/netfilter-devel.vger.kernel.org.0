Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029CA7F13D4
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Nov 2023 13:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjKTM4O (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Nov 2023 07:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjKTM4N (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:56:13 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A07410C
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Nov 2023 04:56:10 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1r53ou-0005sL-RG; Mon, 20 Nov 2023 13:56:08 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] tests: shell: skip maps delete test if dynset lacks delete op
Date:   Mon, 20 Nov 2023 13:56:01 +0100
Message-ID: <20231120125604.19504-1-fw@strlen.de>
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
 tests/shell/features/dynset_op_delete.nft         | 12 ++++++++++++
 tests/shell/testcases/maps/typeof_maps_add_delete |  2 ++
 2 files changed, 14 insertions(+)
 create mode 100644 tests/shell/features/dynset_op_delete.nft

diff --git a/tests/shell/features/dynset_op_delete.nft b/tests/shell/features/dynset_op_delete.nft
new file mode 100644
index 000000000000..125b4526bbc3
--- /dev/null
+++ b/tests/shell/features/dynset_op_delete.nft
@@ -0,0 +1,12 @@
+# d0a8d877da97 ("netfilter: nft_dynset: support for element deletion")
+# v5.4-rc1~131^2~59^2~4
+table ip x {
+	set s {
+		flags dynamic;
+		type inet_service;
+	}
+
+	chain y {
+		delete @s { tcp dport }
+	}
+}
diff --git a/tests/shell/testcases/maps/typeof_maps_add_delete b/tests/shell/testcases/maps/typeof_maps_add_delete
index 5e2f8ecc473f..d2ac9f1ce8c9 100755
--- a/tests/shell/testcases/maps/typeof_maps_add_delete
+++ b/tests/shell/testcases/maps/typeof_maps_add_delete
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_dynset_op_delete)
+
 CONDMATCH="ip saddr @dynmark"
 NCONDMATCH="ip saddr != @dynmark"
 
-- 
2.41.0

