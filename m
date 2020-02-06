Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB776153C63
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Feb 2020 01:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgBFA7E (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Feb 2020 19:59:04 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:47698 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgBFA7D (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Feb 2020 19:59:03 -0500
Received: from localhost ([::1]:60788 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1izVVV-0000lx-Sl; Thu, 06 Feb 2020 01:59:01 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 4/4] tests: py: Support testing host binaries
Date:   Thu,  6 Feb 2020 01:58:51 +0100
Message-Id: <20200206005851.28962-5-phil@nwl.cc>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206005851.28962-1-phil@nwl.cc>
References: <20200206005851.28962-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Support -H/--host option to use host's libnftables.so.1. Alternatively
users may specify a custom library path via -l/--library option.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/py/nft-test.py | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/tests/py/nft-test.py b/tests/py/nft-test.py
index 6edca3c6a5a2f..01ee6c980ad4a 100755
--- a/tests/py/nft-test.py
+++ b/tests/py/nft-test.py
@@ -1357,10 +1357,16 @@ def main():
                         dest='force_all_family',
                         help='keep testing all families on error')
 
+    parser.add_argument('-H', '--host', action='store_true',
+                        help='run tests against installed libnftables.so.1')
+
     parser.add_argument('-j', '--enable-json', action='store_true',
                         dest='enable_json',
                         help='test JSON functionality as well')
 
+    parser.add_argument('-l', '--library', default=None,
+                        help='path to libntables.so.1, overrides --host')
+
     parser.add_argument('-s', '--schema', action='store_true',
                         dest='enable_schema',
                         help='verify json input/output against schema')
@@ -1388,9 +1394,17 @@ def main():
     # Change working directory to repository root
     os.chdir(TESTS_PATH + "/../..")
 
-    if not os.path.exists('src/.libs/libnftables.so'):
-        print("The nftables library does not exist. "
-              "You need to build the project.")
+    check_lib_path = True
+    if args.library is None:
+        if args.host:
+            args.library = 'libnftables.so.1'
+            check_lib_path = False
+        else:
+            args.library = 'src/.libs/libnftables.so.1'
+
+    if check_lib_path and not os.path.exists(args.library):
+        print("The nftables library at '%s' does not exist. "
+              "You need to build the project." % args.library)
         return
 
     if args.enable_schema and not args.enable_json:
@@ -1398,7 +1412,7 @@ def main():
         return
 
     global nftables
-    nftables = Nftables(sofile = 'src/.libs/libnftables.so')
+    nftables = Nftables(sofile = args.library)
 
     test_files = files_ok = run_total = 0
     tests = passed = warnings = errors = 0
-- 
2.24.1

