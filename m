Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CE5B3F3F
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Sep 2019 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390206AbfIPQuV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Sep 2019 12:50:21 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:51160 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390198AbfIPQuV (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:50:21 -0400
Received: from localhost ([::1]:36018 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1i9uCh-0003nJ-ES; Mon, 16 Sep 2019 18:50:19 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 01/14] tests/shell: Make ebtables-basic test more verbose
Date:   Mon, 16 Sep 2019 18:49:47 +0200
Message-Id: <20190916165000.18217-2-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190916165000.18217-1-phil@nwl.cc>
References: <20190916165000.18217-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Print expected entries count if it doesn't match.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 .../testcases/ebtables/0001-ebtables-basic_0  | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/iptables/tests/shell/testcases/ebtables/0001-ebtables-basic_0 b/iptables/tests/shell/testcases/ebtables/0001-ebtables-basic_0
index b0db216ae3854..c7f24a383f698 100755
--- a/iptables/tests/shell/testcases/ebtables/0001-ebtables-basic_0
+++ b/iptables/tests/shell/testcases/ebtables/0001-ebtables-basic_0
@@ -1,5 +1,9 @@
 #!/bin/sh
 
+get_entries_count() { # (chain)
+	$XT_MULTI ebtables -L $1 | sed -n 's/.*entries: \([0-9]*\).*/\1/p'
+}
+
 set -x
 case "$XT_MULTI" in
 */xtables-nft-multi)
@@ -28,32 +32,32 @@ case "$XT_MULTI" in
 		exit 1
 	fi
 
-	$XT_MULTI ebtables -L FOO | grep -q 'entries: 0'
-	if [ $? -ne 0 ]; then
-		echo "Unexpected entries count in empty unreferenced chain"
+	entries=$(get_entries_count FOO)
+	if [ $entries -ne 0 ]; then
+		echo "Unexpected entries count in empty unreferenced chain (expected 0, have $entries)"
 		$XT_MULTI ebtables -L
 		exit 1
 	fi
 
 	$XT_MULTI ebtables -A FORWARD -j FOO
-	$XT_MULTI ebtables -L FORWARD | grep -q 'entries: 1'
-	if [ $? -ne 0 ]; then
-		echo "Unexpected entries count in FORWARD chain"
+	entries=$(get_entries_count FORWARD)
+	if [ $entries -ne 1 ]; then
+		echo "Unexpected entries count in FORWARD chain (expected 1, have $entries)"
 		$XT_MULTI ebtables -L
 		exit 1
 	fi
 
-	$XT_MULTI ebtables -L FOO | grep -q 'entries: 0'
-	if [ $? -ne 0 ]; then
-		echo "Unexpected entries count in empty referenced chain"
+	entries=$(get_entries_count FOO)
+	if [ $entries -ne 0 ]; then
+		echo "Unexpected entries count in empty referenced chain (expected 0, have $entries)"
 		$XT_MULTI ebtables -L
 		exit 1
 	fi
 
 	$XT_MULTI ebtables -A FOO -j ACCEPT
-	$XT_MULTI ebtables -L FOO | grep -q 'entries: 1'
-	if [ $? -ne 0 ]; then
-		echo "Unexpected entries count in non-empty referenced chain"
+	entries=$(get_entries_count FOO)
+	if [ $entries -ne 1 ]; then
+		echo "Unexpected entries count in non-empty referenced chain (expected 1, have $entries)"
 		$XT_MULTI ebtables -L
 		exit 1
 	fi
-- 
2.23.0

