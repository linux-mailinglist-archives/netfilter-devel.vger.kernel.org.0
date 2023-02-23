Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C606A127E
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Feb 2023 23:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBWWCU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Feb 2023 17:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBWWCT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:02:19 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EE224FA8F
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Feb 2023 14:02:18 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nft 1/2] tests: shell: cover rule insertion by index
Date:   Thu, 23 Feb 2023 23:02:09 +0100
Message-Id: <20230223220210.6580-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Original patch including this feature did not include a test, add it.

Fixes: 816d8c7659c1 ("Support 'add/insert rule index <IDX>'")
Reported-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/testcases/cache/0011_index_0           | 12 ++++++++++++
 tests/shell/testcases/cache/dumps/0011_index_0.nft |  8 ++++++++
 2 files changed, 20 insertions(+)
 create mode 100755 tests/shell/testcases/cache/0011_index_0
 create mode 100644 tests/shell/testcases/cache/dumps/0011_index_0.nft

diff --git a/tests/shell/testcases/cache/0011_index_0 b/tests/shell/testcases/cache/0011_index_0
new file mode 100755
index 000000000000..c9eb86830c8d
--- /dev/null
+++ b/tests/shell/testcases/cache/0011_index_0
@@ -0,0 +1,12 @@
+#!/bin/bash
+
+set -e
+
+RULESET="flush ruleset
+add table inet t
+add chain inet t c { type filter hook input priority 0 ; }
+add rule inet t c tcp dport 1234 accept
+add rule inet t c accept
+insert rule inet t c index 1 udp dport 4321 accept"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/cache/dumps/0011_index_0.nft b/tests/shell/testcases/cache/dumps/0011_index_0.nft
new file mode 100644
index 000000000000..7e855eb1cfb9
--- /dev/null
+++ b/tests/shell/testcases/cache/dumps/0011_index_0.nft
@@ -0,0 +1,8 @@
+table inet t {
+	chain c {
+		type filter hook input priority filter; policy accept;
+		tcp dport 1234 accept
+		udp dport 4321 accept
+		accept
+	}
+}
-- 
2.30.2

