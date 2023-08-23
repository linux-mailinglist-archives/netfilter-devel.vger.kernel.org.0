Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506BF7857DF
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Aug 2023 14:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjHWMZX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Aug 2023 08:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjHWMZX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:25:23 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F182E9
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Aug 2023 05:25:21 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nft] tests: shell: use minutes granularity in sets/0036add_set_element_expiration_0
Date:   Wed, 23 Aug 2023 14:25:17 +0200
Message-Id: <20230823122517.93992-1-pablo@netfilter.org>
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

Use minute granularity to fix bogus failures of this test on slow testbed.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 .../shell/testcases/sets/0036add_set_element_expiration_0 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/shell/testcases/sets/0036add_set_element_expiration_0 b/tests/shell/testcases/sets/0036add_set_element_expiration_0
index 3097d077506c..12f10074409f 100755
--- a/tests/shell/testcases/sets/0036add_set_element_expiration_0
+++ b/tests/shell/testcases/sets/0036add_set_element_expiration_0
@@ -2,11 +2,15 @@
 
 set -e
 
+drop_seconds() {
+       sed 's/m[0-9]*s[0-9]*ms/m/g'
+}
+
 RULESET="add table ip x
 add set ip x y { type ipv4_addr; flags dynamic,timeout; } 
-add element ip x y { 1.1.1.1 timeout 30s expires 15s }"
+add element ip x y { 1.1.1.1 timeout 30m expires 15m }"
 
-test_output=$($NFT -e -f - <<< "$RULESET" 2>&1 | grep -v '# new generation')
+test_output=$($NFT -e -f - <<< "$RULESET" 2>&1 | grep -v '# new generation' | drop_seconds)
 
 if [ "$test_output" != "$RULESET" ] ; then
 	$DIFF -u <(echo "$test_output") <(echo "$RULESET")
-- 
2.30.2

