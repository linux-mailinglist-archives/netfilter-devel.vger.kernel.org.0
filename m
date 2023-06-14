Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E66A730481
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Jun 2023 18:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFNQDb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 14 Jun 2023 12:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFNQDa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:03:30 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66EA11725
        for <netfilter-devel@vger.kernel.org>; Wed, 14 Jun 2023 09:03:28 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nft] tests: shell: bogus EBUSY errors in transactions
Date:   Wed, 14 Jun 2023 18:03:22 +0200
Message-Id: <20230614160322.67600-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
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

Make sure reference tracking during transaction update is correct by
checking for bogus EBUSY error. For example, when deleting map with
chain reference X, followed by a delete chain X command.

This test is covering the following paths:

- prepare + abort (via -c/--check option)
- prepare + commit
- release (when netns is destroyed)

Reported-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/testcases/transactions/0051map_0 | 78 ++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100755 tests/shell/testcases/transactions/0051map_0

diff --git a/tests/shell/testcases/transactions/0051map_0 b/tests/shell/testcases/transactions/0051map_0
new file mode 100755
index 000000000000..ffb02344e019
--- /dev/null
+++ b/tests/shell/testcases/transactions/0051map_0
@@ -0,0 +1,78 @@
+#!/bin/bash
+
+rnd=$(mktemp -u XXXXXXXX)
+ns1="nft1trans-$rnd"
+
+set -e
+
+#
+# dependency tracking for implicit set
+#
+RULESET="table ip x {
+        chain w {}
+
+        chain y {
+                ip saddr vmap { 1.1.1.1 : jump w }
+        }
+}"
+
+$NFT -c -f - <<< "$RULESET" >/dev/null || exit 0
+$NFT -f - <<< "$RULESET" >/dev/null || exit 0
+ip netns add $ns1
+ip netns exec $ns1 $NFT -f - <<< "$RULESET" >/dev/null || exit 0
+ip netns del $ns1
+
+RULESET="flush chain ip x y
+delete chain ip x w"
+
+$NFT -c -f - <<< "$RULESET" >/dev/null || exit 0
+$NFT -f - <<< "$RULESET" >/dev/null || exit 0
+
+#
+# dependency tracking for map in implicit chain
+#
+RULESET="table ip x {
+	chain w {}
+
+        chain y {
+		meta iifname \"eno1\" jump {
+			ip saddr vmap { 1.1.1.1 : jump w }
+		}
+	}
+}"
+
+$NFT -c -f - <<< "$RULESET" >/dev/null || exit 0
+$NFT -f - <<< "$RULESET" >/dev/null || exit 0
+ip netns add $ns1
+ip netns exec $ns1 $NFT -f - <<< "$RULESET" >/dev/null || exit 0
+ip netns del $ns1
+
+RULESET="flush chain ip x y
+delete chain ip x w"
+
+$NFT -c -f - <<< "$RULESET" >/dev/null || exit 0
+$NFT -f - <<< "$RULESET" >/dev/null || exit 0
+
+#
+# dependency tracking for explicit map
+#
+RULESET="table ip x {
+        chain w {}
+
+        map y {
+                type ipv4_addr : verdict
+                elements = { 1.1.1.1 : jump w }
+        }
+}"
+
+$NFT -c -f - <<< "$RULESET" >/dev/null || exit 0
+$NFT -f - <<< "$RULESET" >/dev/null || exit 0
+ip netns add $ns1
+ip netns exec $ns1 $NFT -f - <<< "$RULESET" >/dev/null || exit 0
+ip netns del $ns1
+
+RULESET="delete set ip x y
+delete chain ip x w"
+
+$NFT -c -f - <<< "$RULESET" >/dev/null || exit 0
+$NFT -f - <<< "$RULESET" >/dev/null || exit 0
-- 
2.30.2

