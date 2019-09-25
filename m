Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E43BE721
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Sep 2019 23:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfIYV2E (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Sep 2019 17:28:04 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45908 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbfIYV2E (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:28:04 -0400
Received: from localhost ([::1]:58998 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iDEpP-0005Iy-Gr; Wed, 25 Sep 2019 23:28:03 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 03/24] tests: shell: Support running for legacy/nft only
Date:   Wed, 25 Sep 2019 23:25:44 +0200
Message-Id: <20190925212605.1005-4-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925212605.1005-1-phil@nwl.cc>
References: <20190925212605.1005-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

After some changes, one might want to test a single variant only. Allow
this by supporting -n/--nft and -l/--legacy parameters, each disabling
the other variant.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/tests/shell/run-tests.sh | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/iptables/tests/shell/run-tests.sh b/iptables/tests/shell/run-tests.sh
index 7bef09f74643d..d71c13729b3ee 100755
--- a/iptables/tests/shell/run-tests.sh
+++ b/iptables/tests/shell/run-tests.sh
@@ -38,6 +38,14 @@ while [ -n "$1" ]; do
 		HOST=y
 		shift
 		;;
+	-l|--legacy)
+		LEGACY_ONLY=y
+		shift
+		;;
+	-n|--nft)
+		NFT_ONLY=y
+		shift
+		;;
 	*${RETURNCODE_SEPARATOR}+([0-9]))
 		SINGLE+=" $1"
 		VERBOSE=y
@@ -98,19 +106,23 @@ do_test() {
 }
 
 echo ""
-for testfile in $(find_tests);do
-	do_test "$testfile" "$XTABLES_LEGACY_MULTI"
-done
-msg_info "legacy results: [OK] $ok [FAILED] $failed [TOTAL] $((ok+failed))"
+if [ "$NFT_ONLY" != "y" ]; then
+	for testfile in $(find_tests);do
+		do_test "$testfile" "$XTABLES_LEGACY_MULTI"
+	done
+	msg_info "legacy results: [OK] $ok [FAILED] $failed [TOTAL] $((ok+failed))"
 
+fi
 legacy_ok=$ok
 legacy_fail=$failed
 ok=0
 failed=0
-for testfile in $(find_tests);do
-	do_test "$testfile" "$XTABLES_NFT_MULTI"
-done
-msg_info "nft results: [OK] $ok [FAILED] $failed [TOTAL] $((ok+failed))"
+if [ "$LEGACY_ONLY" != "y" ]; then
+	for testfile in $(find_tests);do
+		do_test "$testfile" "$XTABLES_NFT_MULTI"
+	done
+	msg_info "nft results: [OK] $ok [FAILED] $failed [TOTAL] $((ok+failed))"
+fi
 
 ok=$((legacy_ok+ok))
 failed=$((legacy_fail+failed))
-- 
2.23.0

