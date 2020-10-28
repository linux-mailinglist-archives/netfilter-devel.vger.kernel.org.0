Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08A929DC8C
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Oct 2020 01:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbgJ1Wby (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Oct 2020 18:31:54 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35404 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387973AbgJ1Wbx (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:31:53 -0400
Received: from localhost ([::1]:60792 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kXorH-0000iq-2t; Wed, 28 Oct 2020 18:03:35 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] tests/shell: Restore testcases/sets/0036add_set_element_expiration_0
Date:   Wed, 28 Oct 2020 18:03:38 +0100
Message-Id: <20201028170338.32033-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This reverts both commits 46b54fdcf266d3d631ffb6102067825d7672db46 and
0e258556f7f3da35deeb6d5cfdec51eafc7db80d.

With both applied, the test succeeded *only* if 'nft monitor' was
running in background, which is equivalent to the original problem
(where the test succeeded only if *no* 'nft monitor' was running).

The test merely exposed a kernel bug, so in fact it is correct.

Fixes: 46b54fdcf266d ("Revert "monitor: do not print generation ID with --echo"")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/shell/testcases/sets/0036add_set_element_expiration_0 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/shell/testcases/sets/0036add_set_element_expiration_0 b/tests/shell/testcases/sets/0036add_set_element_expiration_0
index 7b2e39a3f0406..51ed0f2c1b3e8 100755
--- a/tests/shell/testcases/sets/0036add_set_element_expiration_0
+++ b/tests/shell/testcases/sets/0036add_set_element_expiration_0
@@ -6,7 +6,7 @@ RULESET="add table ip x
 add set ip x y { type ipv4_addr; flags dynamic,timeout; } 
 add element ip x y { 1.1.1.1 timeout 30s expires 15s }"
 
-test_output=$($NFT -e -f - <<< "$RULESET" 2>&1 | head -n -1)
+test_output=$($NFT -e -f - <<< "$RULESET" 2>&1)
 
 if [ "$test_output" != "$RULESET" ] ; then
 	$DIFF -u <(echo "$test_output") <(echo "$RULESET")
-- 
2.28.0

