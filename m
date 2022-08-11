Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8786358FB2C
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Aug 2022 13:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiHKLTz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 11 Aug 2022 07:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbiHKLTy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:19:54 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18999410F
        for <netfilter-devel@vger.kernel.org>; Thu, 11 Aug 2022 04:19:52 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1oM6EA-0000wV-SQ; Thu, 11 Aug 2022 13:19:50 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] tests: shell: check for a tainted kernel
Date:   Thu, 11 Aug 2022 13:19:44 +0200
Message-Id: <20220811111944.210376-1-fw@strlen.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If a test case results in a kernel taint (WARN splat for example), make
sure the test script indicates this.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/shell/run-tests.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/shell/run-tests.sh b/tests/shell/run-tests.sh
index 33006d2c63fe..931bba967b37 100755
--- a/tests/shell/run-tests.sh
+++ b/tests/shell/run-tests.sh
@@ -109,8 +109,22 @@ find_tests() {
 echo ""
 ok=0
 failed=0
+taint=0
+
+check_taint()
+{
+	read taint_now < /proc/sys/kernel/tainted
+	if [ $taint -ne $taint_now ] ; then
+		msg_warn "[FAILED]	kernel is tainted: $taint  -> $taint_now"
+		((failed++))
+	fi
+}
+
+check_taint
+
 for testfile in $(find_tests)
 do
+	read taint < /proc/sys/kernel/tainted
 	kernel_cleanup
 
 	msg_info "[EXECUTING]	$testfile"
@@ -155,6 +169,8 @@ do
 			msg_warn "[FAILED]	$testfile"
 		fi
 	fi
+
+	check_taint
 done
 
 echo ""
-- 
2.37.1

