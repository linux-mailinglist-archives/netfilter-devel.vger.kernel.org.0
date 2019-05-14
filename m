Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C7C1C7F6
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 May 2019 13:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfENLqA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 May 2019 07:46:00 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:48016 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfENLqA (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 May 2019 07:46:00 -0400
Received: from localhost ([::1]:32874 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hQVsc-0007Km-Ft; Tue, 14 May 2019 13:45:58 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] tests: Fix ipt-restore/0004-restore-race_0 testcase
Date:   Tue, 14 May 2019 13:46:00 +0200
Message-Id: <20190514114600.19383-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Two issues fixed:

* XTABLES_LIBDIR was set wrong (CWD is not topdir but tests/). Drop the
  export altogether, the testscript does this already.

* $LINES is a variable set by bash, so initial dump sanity check failed
  all the time complaining about a spurious initial dump line count. Use
  $LINES1 instead.

Fixes: 4000b4cf2ea38 ("tests: add test script for race-free restore")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 .../tests/shell/testcases/ipt-restore/0004-restore-race_0  | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/iptables/tests/shell/testcases/ipt-restore/0004-restore-race_0 b/iptables/tests/shell/testcases/ipt-restore/0004-restore-race_0
index 14b910eb373bf..a92d18dcee058 100755
--- a/iptables/tests/shell/testcases/ipt-restore/0004-restore-race_0
+++ b/iptables/tests/shell/testcases/ipt-restore/0004-restore-race_0
@@ -1,6 +1,5 @@
 #!/bin/bash
 
-export XTABLES_LIBDIR=$(pwd)/extensions
 have_nft=false
 nft -v > /dev/null && have_nft=true
 
@@ -77,12 +76,12 @@ dumpfile=$(mktemp) || exit 1
 
 make_dummy_rules > $dumpfile
 $XT_MULTI iptables-restore -w < $dumpfile
-LINES=$(wc -l < $dumpfile)
+LINES1=$(wc -l < $dumpfile)
 $XT_MULTI iptables-save | grep -v '^#' > $dumpfile
 LINES2=$(wc -l < $dumpfile)
 
-if [ $LINES -ne $LINES2 ]; then
-	echo "Original dump has $LINES, not $LINES2" 1>&2
+if [ $LINES1 -ne $LINES2 ]; then
+	echo "Original dump has $LINES1, not $LINES2" 1>&2
 	exit 111
 fi
 
-- 
2.21.0

