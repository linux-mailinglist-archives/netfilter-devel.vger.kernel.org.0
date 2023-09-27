Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01947B0820
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Sep 2023 17:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjI0PZW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Sep 2023 11:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjI0PZV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:25:21 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35B10193
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Sep 2023 08:25:17 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v2] tests: shell: fix spurious errors in sets/0036add_set_element_expiration_0
Date:   Wed, 27 Sep 2023 17:25:14 +0200
Message-Id: <20230927152514.473765-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add seconds as expiration, otherwise 14m59 reports 14m in minute
granularity, this ensures suficient time in a very slow environment with
debugging instrumentation. Provide expected output too.

Fixes: adf38fd84257 ("tests: shell: use minutes granularity in sets/0036add_set_element_expiration_0")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: previous approach was botched, echo $RULESET does not represents
    line break leading to an error in the comparison.

    Actually my third attempt to fix this test.

 .../shell/testcases/sets/0036add_set_element_expiration_0 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/shell/testcases/sets/0036add_set_element_expiration_0 b/tests/shell/testcases/sets/0036add_set_element_expiration_0
index 12f10074409f..023788464b70 100755
--- a/tests/shell/testcases/sets/0036add_set_element_expiration_0
+++ b/tests/shell/testcases/sets/0036add_set_element_expiration_0
@@ -7,13 +7,17 @@ drop_seconds() {
 }
 
 RULESET="add table ip x
-add set ip x y { type ipv4_addr; flags dynamic,timeout; } 
+add set ip x y { type ipv4_addr; flags dynamic,timeout; }
+add element ip x y { 1.1.1.1 timeout 30m expires 15m59s }"
+
+EXPECTED="add table ip x
+add set ip x y { type ipv4_addr; flags dynamic,timeout; }
 add element ip x y { 1.1.1.1 timeout 30m expires 15m }"
 
 test_output=$($NFT -e -f - <<< "$RULESET" 2>&1 | grep -v '# new generation' | drop_seconds)
 
 if [ "$test_output" != "$RULESET" ] ; then
-	$DIFF -u <(echo "$test_output") <(echo "$RULESET")
+	$DIFF -u <(echo "$test_output") <(echo "$EXPECTED")
 	exit 1
 fi
 
-- 
2.30.2

