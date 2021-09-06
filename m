Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7B6401E56
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Sep 2021 18:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbhIFQbj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Sep 2021 12:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244185AbhIFQbc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:31:32 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FAEC061575
        for <netfilter-devel@vger.kernel.org>; Mon,  6 Sep 2021 09:30:28 -0700 (PDT)
Received: from localhost ([::1]:42358 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mNHVq-0008Eo-I5; Mon, 06 Sep 2021 18:30:26 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 3/7] tests: xlate-test: Print errors to stderr
Date:   Mon,  6 Sep 2021 18:30:34 +0200
Message-Id: <20210906163038.15381-3-phil@nwl.cc>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906163038.15381-1-phil@nwl.cc>
References: <20210906163038.15381-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Return code is always zero, so grepping for output on stderr is a
simple way to detect testsuite failures.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 xlate-test.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/xlate-test.py b/xlate-test.py
index 1fa5eca3e0764..bb7a447dc799e 100755
--- a/xlate-test.py
+++ b/xlate-test.py
@@ -75,7 +75,7 @@ def run_test(name, payload):
     if (passed == tests) and not args.test:
         print(name + ": " + green("OK"))
     if not test_passed:
-        print("\n".join(result))
+        print("\n".join(result), file=sys.stderr)
     if args.test:
         print("1 test file, %d tests, %d tests passed, %d tests failed, %d errors" % (tests, passed, failed, errors))
     else:
@@ -111,7 +111,7 @@ def main():
             with open(args.test, "r") as payload:
                 run_test(args.test, payload)
         except IOError:
-            print(red("Error: ") + "test file does not exist")
+            print(red("Error: ") + "test file does not exist", file=sys.stderr)
     else:
         load_test_files()
 
-- 
2.33.0

