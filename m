Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A672C4147F7
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Sep 2021 13:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhIVLlf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Sep 2021 07:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhIVLle (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:41:34 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78984C061574
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Sep 2021 04:40:04 -0700 (PDT)
Received: from localhost ([::1]:59116 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mT0bZ-0003uW-Un; Wed, 22 Sep 2021 13:40:01 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] tests: iptables-test: Fix conditional colors on stderr
Date:   Wed, 22 Sep 2021 13:39:53 +0200
Message-Id: <20210922113953.1774-1-phil@nwl.cc>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Štěpán's patch to make colored output depend on whether output is a TTY
clashed with my change to print errors to stderr instead of stdout.

Fix this by telling maybe_colored() if it should print colors or not as
only caller knows where output is sent to.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables-test.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/iptables-test.py b/iptables-test.py
index a876f616dae4c..0ba3d36864fd7 100755
--- a/iptables-test.py
+++ b/iptables-test.py
@@ -33,15 +33,16 @@ LOGFILE="/tmp/iptables-test.log"
 log_file = None
 
 STDOUT_IS_TTY = sys.stdout.isatty()
+STDERR_IS_TTY = sys.stderr.isatty()
 
-def maybe_colored(color, text):
+def maybe_colored(color, text, isatty):
     terminal_sequences = {
         'green': '\033[92m',
         'red': '\033[91m',
     }
 
     return (
-        terminal_sequences[color] + text + '\033[0m' if STDOUT_IS_TTY else text
+        terminal_sequences[color] + text + '\033[0m' if isatty else text
     )
 
 
@@ -49,7 +50,7 @@ def print_error(reason, filename=None, lineno=None):
     '''
     Prints an error with nice colors, indicating file and line number.
     '''
-    print(filename + ": " + maybe_colored('red', "ERROR") +
+    print(filename + ": " + maybe_colored('red', "ERROR", STDERR_IS_TTY) +
         ": line %d (%s)" % (lineno, reason), file=sys.stderr)
 
 
@@ -288,7 +289,7 @@ def run_test_file(filename, netns):
     if netns:
         execute_cmd("ip netns del ____iptables-container-test", filename, 0)
     if total_test_passed:
-        print(filename + ": " + maybe_colored('green', "OK"))
+        print(filename + ": " + maybe_colored('green', "OK", STDOUT_IS_TTY))
 
     f.close()
     return tests, passed
-- 
2.33.0

