Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9274C447079
	for <lists+netfilter-devel@lfdr.de>; Sat,  6 Nov 2021 21:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhKFUyy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 6 Nov 2021 16:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhKFUyx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 6 Nov 2021 16:54:53 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E026C061570
        for <netfilter-devel@vger.kernel.org>; Sat,  6 Nov 2021 13:52:12 -0700 (PDT)
Received: from localhost ([::1]:58732 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mjSfa-00042u-FX; Sat, 06 Nov 2021 21:52:10 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] xlate-test: Print full path if testing all files
Date:   Sat,  6 Nov 2021 21:52:01 +0100
Message-Id: <20211106205201.14284-1-phil@nwl.cc>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Lines won't become too long and it's more clear to users where test
input comes from this way.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 xlate-test.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/xlate-test.py b/xlate-test.py
index 4a56e798b9587..d78e864869318 100755
--- a/xlate-test.py
+++ b/xlate-test.py
@@ -80,15 +80,15 @@ def run_test(name, payload):
 
 def load_test_files():
     test_files = total_tests = total_passed = total_error = total_failed = 0
-    for test in sorted(os.listdir("extensions")):
-        if test.endswith(".txlate"):
-            with open("extensions/" + test, "r") as payload:
-                tests, passed, failed, errors = run_test(test, payload)
-                test_files += 1
-                total_tests += tests
-                total_passed += passed
-                total_failed += failed
-                total_error += errors
+    tests = sorted(os.listdir("extensions"))
+    for test in ['extensions/' + f for f in tests if f.endswith(".txlate")]:
+        with open(test, "r") as payload:
+            tests, passed, failed, errors = run_test(test, payload)
+            test_files += 1
+            total_tests += tests
+            total_passed += passed
+            total_failed += failed
+            total_error += errors
     return (test_files, total_tests, total_passed, total_failed, total_error)
 
 
-- 
2.33.0

