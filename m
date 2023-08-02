Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31F076CFEB
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Aug 2023 16:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjHBOT7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Aug 2023 10:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjHBOT6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:19:58 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CCE272D
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Aug 2023 07:19:55 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qRChe-0004mC-00; Wed, 02 Aug 2023 16:19:54 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] tests: fix inet nat prio tests
Date:   Wed,  2 Aug 2023 16:19:45 +0200
Message-ID: <20230802141949.8889-1-fw@strlen.de>
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

Its legal to DNAT in output and SNAT in input chain, so don't test
for that being illegal.

Fixes: 8beafab74c39 ("rule: allow src/dstnat prios in input and output")
Fixes: 34ce4e4a7bb6 ("test: shell: Test cases for standard chain prios")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/shell/testcases/chains/0023prio_inet_srcnat_1 | 2 +-
 tests/shell/testcases/chains/0024prio_inet_dstnat_1 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/shell/testcases/chains/0023prio_inet_srcnat_1 b/tests/shell/testcases/chains/0023prio_inet_srcnat_1
index d2b1fa431ee6..e4a668e1899b 100755
--- a/tests/shell/testcases/chains/0023prio_inet_srcnat_1
+++ b/tests/shell/testcases/chains/0023prio_inet_srcnat_1
@@ -2,7 +2,7 @@
 
 for family in ip ip6 inet
 do
-	for hook in prerouting input forward output
+	for hook in prerouting forward output
 	do
 		$NFT add table $family x
 		$NFT add chain $family x y "{ type filter hook $hook priority srcnat; }" &> /dev/null
diff --git a/tests/shell/testcases/chains/0024prio_inet_dstnat_1 b/tests/shell/testcases/chains/0024prio_inet_dstnat_1
index d112f2c958c0..f1b802a05b0f 100755
--- a/tests/shell/testcases/chains/0024prio_inet_dstnat_1
+++ b/tests/shell/testcases/chains/0024prio_inet_dstnat_1
@@ -2,7 +2,7 @@
 
 for family in ip ip6 inet
 do
-	for hook in input forward output postrouting
+	for hook in input forward postrouting
 	do
 		$NFT add table $family x
 		$NFT add chain $family x y "{ type filter hook $hook priority dstnat; }" &> /dev/null
-- 
2.41.0

