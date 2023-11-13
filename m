Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368D97E9D59
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Nov 2023 14:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjKMNjO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Nov 2023 08:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjKMNjL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:39:11 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BF0C10E5
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Nov 2023 05:39:06 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, thaller@redhat.com
Subject: [PATCH nft,v2 02/11] tests: shell: skip prerouting reject tests if kernel lacks support
Date:   Mon, 13 Nov 2023 14:38:49 +0100
Message-Id: <20231113133858.121324-2-pablo@netfilter.org>
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

Skip tests that require reject at prerouting hook.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: use git describe --contains, requested by Florian.

 tests/shell/features/prerouting_reject.nft  | 8 ++++++++
 tests/shell/testcases/optimizations/ruleset | 2 ++
 2 files changed, 10 insertions(+)
 create mode 100644 tests/shell/features/prerouting_reject.nft

diff --git a/tests/shell/features/prerouting_reject.nft b/tests/shell/features/prerouting_reject.nft
new file mode 100644
index 000000000000..3dcfb40e0cbb
--- /dev/null
+++ b/tests/shell/features/prerouting_reject.nft
@@ -0,0 +1,8 @@
+# f53b9b0bdc59 netfilter: introduce support for reject at prerouting stage
+# v5.9-rc1~133^2~302^2~11
+table inet t {
+	chain nat_filter {
+		type filter hook prerouting priority 0; policy accept;
+		reject with icmpx type host-unreachable
+	}
+}
diff --git a/tests/shell/testcases/optimizations/ruleset b/tests/shell/testcases/optimizations/ruleset
index ef2652dbeae8..2b2d80ffc009 100755
--- a/tests/shell/testcases/optimizations/ruleset
+++ b/tests/shell/testcases/optimizations/ruleset
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_prerouting_reject)
+
 RULESET="table inet uni {
 	chain gtfo {
 		reject with icmpx type host-unreachable
-- 
2.30.2

