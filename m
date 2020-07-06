Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747F8215625
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jul 2020 13:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgGFLM4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Jul 2020 07:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgGFLM4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:12:56 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADCDC061794
        for <netfilter-devel@vger.kernel.org>; Mon,  6 Jul 2020 04:12:55 -0700 (PDT)
Received: from localhost ([::1]:47852 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1jsP3M-0001S8-Ts; Mon, 06 Jul 2020 13:12:52 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] tests: shell: Add help output to run-tests.sh
Date:   Mon,  6 Jul 2020 13:12:49 +0200
Message-Id: <20200706111249.11547-1-phil@nwl.cc>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The script has quite a few options nowadays, so add a bit of help text
also.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/tests/shell/run-tests.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/iptables/tests/shell/run-tests.sh b/iptables/tests/shell/run-tests.sh
index 2125e2cb119bb..65c37adb75f2a 100755
--- a/iptables/tests/shell/run-tests.sh
+++ b/iptables/tests/shell/run-tests.sh
@@ -4,6 +4,21 @@
 TESTDIR="./$(dirname $0)/"
 RETURNCODE_SEPARATOR="_"
 
+usage() {
+	cat <<EOF
+Usage: $(basename $0) [-v|--verbose] [-H|--host] [-V|--valgrind]
+		      [[-l|--legacy]|[-n|--nft]] [testscript ...]
+
+-v | --verbose		Enable verbose mode (do not drop testscript output).
+-H | --host		Run tests against installed binaries in \$PATH,
+			not those built in this source tree.
+-V | --valgrind		Enable leak checking via valgrind.
+-l | --legacy		Test legacy variant only. Conflicts with --nft.
+-n | --nft		Test nft variant only. Conflicts with --legacy.
+testscript		Run only specific test(s). Implies --verbose.
+EOF
+}
+
 msg_error() {
         echo "E: $1 ..." >&2
         exit 1
@@ -50,6 +65,10 @@ while [ -n "$1" ]; do
 		VALGRIND=y
 		shift
 		;;
+	-h|--help)
+		usage
+		exit 0
+		;;
 	*${RETURNCODE_SEPARATOR}+([0-9]))
 		SINGLE+=" $1"
 		VERBOSE=y
-- 
2.27.0

