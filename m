Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CF0792960
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Sep 2023 18:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351862AbjIEQ0S (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 Sep 2023 12:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354823AbjIEOpI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:45:08 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7956F197
        for <netfilter-devel@vger.kernel.org>; Tue,  5 Sep 2023 07:45:04 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qdXIc-0007du-Jc; Tue, 05 Sep 2023 16:45:02 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] tests: shell: 0043concatenated_ranges_0: re-enable all tests
Date:   Tue,  5 Sep 2023 16:44:55 +0200
Message-ID: <20230905144458.9603-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This script suppressed a few tests when ran via run-tests.sh,
don't do that anymore.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/shell/testcases/sets/0043concatenated_ranges_0 | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tests/shell/testcases/sets/0043concatenated_ranges_0 b/tests/shell/testcases/sets/0043concatenated_ranges_0
index 8d3dacf6e38a..90ee6a82dbed 100755
--- a/tests/shell/testcases/sets/0043concatenated_ranges_0
+++ b/tests/shell/testcases/sets/0043concatenated_ranges_0
@@ -14,12 +14,7 @@
 # - delete them
 # - make sure they can't be deleted again
 
-if [ "$(ps -o comm= $PPID)" = "run-tests.sh" ]; then
-	# Skip some permutations on a full test suite run to keep it quick
-	TYPES="ipv4_addr ipv6_addr ether_addr inet_service"
-else
-	TYPES="ipv4_addr ipv6_addr ether_addr inet_proto inet_service mark"
-fi
+TYPES="ipv4_addr ipv6_addr ether_addr inet_proto inet_service mark"
 
 RULESPEC_ipv4_addr="ip saddr"
 ELEMS_ipv4_addr="192.0.2.1 198.51.100.0/25 203.0.113.0-203.0.113.129"
-- 
2.41.0

