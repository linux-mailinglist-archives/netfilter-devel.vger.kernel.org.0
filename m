Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED755694BD
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Jul 2022 23:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiGFVya (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Jul 2022 17:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiGFVy3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:54:29 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B71B275D8
        for <netfilter-devel@vger.kernel.org>; Wed,  6 Jul 2022 14:54:28 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1o9CyY-0006vj-Nc; Wed, 06 Jul 2022 23:54:26 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] scanner: allow prefix in ip6 scope
Date:   Wed,  6 Jul 2022 23:54:21 +0200
Message-Id: <20220706215421.32531-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

'ip6 prefix' is valid syntax, so make sure scanner recognizes it
also in ip6 context.

Also add test case.

Fixes: a67fce7ffe7e ("scanner: nat: Move to own scope")
Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1619
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/scanner.l                        | 2 +-
 tests/shell/testcases/parsing/prefix | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100755 tests/shell/testcases/parsing/prefix

diff --git a/src/scanner.l b/src/scanner.l
index 5741261a690a..1371cd044b65 100644
--- a/src/scanner.l
+++ b/src/scanner.l
@@ -403,7 +403,7 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 }
 
 "log"			{ scanner_push_start_cond(yyscanner, SCANSTATE_STMT_LOG); return LOG; }
-<SCANSTATE_STMT_LOG,SCANSTATE_STMT_NAT,SCANSTATE_IP>"prefix"		{ return PREFIX; }
+<SCANSTATE_STMT_LOG,SCANSTATE_STMT_NAT,SCANSTATE_IP,SCANSTATE_IP6>"prefix"		{ return PREFIX; }
 <SCANSTATE_STMT_LOG>{
 	"snaplen"		{ return SNAPLEN; }
 	"queue-threshold"	{ return QUEUE_THRESHOLD; }
diff --git a/tests/shell/testcases/parsing/prefix b/tests/shell/testcases/parsing/prefix
new file mode 100755
index 000000000000..4580d6b8b37f
--- /dev/null
+++ b/tests/shell/testcases/parsing/prefix
@@ -0,0 +1,6 @@
+#!/bin/bash
+
+$NFT add table ip6 t || exit 1
+$NFT add chain ip6 t c || exit 1
+$NFT add rule ip6 t c 'snat ip6 prefix to ip6 saddr map { 2001:db8:1111::/64 : 2001:db8:2222::/64 }'
+$NFT delete table ip6 t || exit 1
-- 
2.35.1

