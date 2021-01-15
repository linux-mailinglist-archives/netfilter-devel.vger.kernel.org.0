Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F752F8721
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Jan 2021 22:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbhAOVFS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 Jan 2021 16:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbhAOVFS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:05:18 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC890C061757
        for <netfilter-devel@vger.kernel.org>; Fri, 15 Jan 2021 13:04:37 -0800 (PST)
Received: from localhost ([::1]:39058 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1l0WGp-0008BR-21; Fri, 15 Jan 2021 22:04:35 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] tests/shell: Fix nft-only/0009-needless-bitwise_0
Date:   Fri, 15 Jan 2021 22:04:26 +0100
Message-Id: <20210115210426.11057-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

For whatever reason, stored expected output contains false handles. To
overcome this, filter the rule data lines from both expected and stored
output before comparing.

Fixes: 81a2e12851283 ("tests/shell: Add test for bitwise avoidance fixes")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 .../shell/testcases/nft-only/0009-needless-bitwise_0     | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/iptables/tests/shell/testcases/nft-only/0009-needless-bitwise_0 b/iptables/tests/shell/testcases/nft-only/0009-needless-bitwise_0
index 41d765e537312..41588a10863ec 100755
--- a/iptables/tests/shell/testcases/nft-only/0009-needless-bitwise_0
+++ b/iptables/tests/shell/testcases/nft-only/0009-needless-bitwise_0
@@ -336,4 +336,11 @@ bridge filter OUTPUT 10 9
   [ counter pkts 0 bytes 0 ]
 "
 
-diff -u -Z <(echo "$EXPECT") <(nft --debug=netlink list ruleset | awk '/^table/{exit} {print}')
+# print nothing but:
+# - lines with bytecode (starting with '  [')
+# - empty lines (so printed diff is not a complete mess)
+filter() {
+	awk '/^(  \[|$)/{print}'
+}
+
+diff -u -Z <(filter <<< "$EXPECT") <(nft --debug=netlink list ruleset | filter)
-- 
2.28.0

