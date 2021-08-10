Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2E53E5C75
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Aug 2021 16:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbhHJOCd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Aug 2021 10:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbhHJOCd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:02:33 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5502C0613D3
        for <netfilter-devel@vger.kernel.org>; Tue, 10 Aug 2021 07:02:10 -0700 (PDT)
Received: from localhost ([::1]:51346 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mDSKU-0003yg-Qk; Tue, 10 Aug 2021 16:02:06 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] tests/py: Make netns spawning more robust
Date:   Tue, 10 Aug 2021 16:02:04 +0200
Message-Id: <20210810140204.19372-1-phil@nwl.cc>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On systems without unshare Python module, try to call unshare binary
with oneself as parameters.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/py/nft-test.py | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/tests/py/nft-test.py b/tests/py/nft-test.py
index 15e74d8b2c174..f993a2fa8cb46 100755
--- a/tests/py/nft-test.py
+++ b/tests/py/nft-test.py
@@ -1349,6 +1349,31 @@ def run_test_file(filename, force_all_family_option, specific_file):
 
     return [tests, passed, total_warning, total_error, total_unit_run]
 
+def spawn_netns():
+    # prefer unshare module
+    try:
+        import unshare
+        unshare.unshare(unshare.CLONE_NEWNET)
+        return True
+    except:
+        pass
+
+    # sledgehammer style
+    try:
+        import shutil
+
+        unshare = shutil.which("unshare")
+        if unshare is None:
+            return False
+
+        sys.argv.append("--no-netns")
+        if debug_option:
+            print("calling: ", [unshare, "-n", sys.executable] + sys.argv)
+        os.execv(unshare, [unshare, "-n", sys.executable] + sys.argv)
+    except:
+        pass
+
+    return False
 
 def main():
     parser = argparse.ArgumentParser(description='Run nft tests')
@@ -1376,6 +1401,10 @@ def main():
     parser.add_argument('-l', '--library', default=None,
                         help='path to libntables.so.1, overrides --host')
 
+    parser.add_argument('-N', '--no-netns', action='store_true',
+                        dest='no_netns',
+                        help='Do not run in own network namespace')
+
     parser.add_argument('-s', '--schema', action='store_true',
                         dest='enable_schema',
                         help='verify json input/output against schema')
@@ -1400,15 +1429,12 @@ def main():
         print("You need to be root to run this, sorry")
         return
 
+    if not args.no_netns and not spawn_netns():
+        print_warning("cannot run in own namespace, connectivity might break")
+
     # Change working directory to repository root
     os.chdir(TESTS_PATH + "/../..")
 
-    try:
-        import unshare
-        unshare.unshare(unshare.CLONE_NEWNET)
-    except:
-        print_warning("cannot run in own namespace, connectivity might break")
-
     check_lib_path = True
     if args.library is None:
         if args.host:
-- 
2.32.0

