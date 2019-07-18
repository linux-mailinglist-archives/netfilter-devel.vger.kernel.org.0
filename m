Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8846C812
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jul 2019 05:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389086AbfGRDju (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Jul 2019 23:39:50 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:33908 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389084AbfGRDju (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:39:50 -0400
Received: from localhost ([::1]:46998 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hnxGn-0008Qz-Jh; Thu, 18 Jul 2019 05:39:49 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 3/3] tests/py: Add missing meta tests
Date:   Thu, 18 Jul 2019 05:39:40 +0200
Message-Id: <20190718033940.12820-3-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718033940.12820-1-phil@nwl.cc>
References: <20190718033940.12820-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ensure invalid values are rejected. Also add basic positive tests for
{i,o}ifkind.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/py/any/meta.t         | 10 ++++++++++
 tests/py/any/meta.t.json    | 30 ++++++++++++++++++++++++++++++
 tests/py/any/meta.t.payload | 10 ++++++++++
 3 files changed, 50 insertions(+)

diff --git a/tests/py/any/meta.t b/tests/py/any/meta.t
index 4b3c604de110d..9771d9dd585a3 100644
--- a/tests/py/any/meta.t
+++ b/tests/py/any/meta.t
@@ -63,6 +63,7 @@ meta mark xor 0x03 != 0x01;ok;meta mark != 0x00000002
 
 meta iif "lo" accept;ok;iif "lo" accept
 meta iif != "lo" accept;ok;iif != "lo" accept
+meta iif 0;fail
 
 meta iifname "dummy0";ok;iifname "dummy0"
 meta iifname != "dummy0";ok;iifname != "dummy0"
@@ -78,9 +79,14 @@ meta iiftype != ether;ok
 meta iiftype ether;ok
 meta iiftype != ppp;ok
 meta iiftype ppp;ok
+meta iiftype 0xffff;fail
+
+meta iifkind "bond";ok
+meta iifkind "";fail
 
 meta oif "lo" accept;ok;oif "lo" accept
 meta oif != "lo" accept;ok;oif != "lo" accept
+meta oif 0;fail
 
 meta oifname "dummy0";ok;oifname "dummy0"
 meta oifname != "dummy0";ok;oifname != "dummy0"
@@ -93,6 +99,10 @@ meta oiftype {ether, ppp, ipip, ipip6, loopback, sit, ipgre};ok
 meta oiftype != {ether, ppp, ipip, ipip6, loopback, sit, ipgre};ok
 meta oiftype != ether;ok
 meta oiftype ether;ok
+meta oiftype 0xffff;fail
+
+meta oifkind "bond";ok
+meta oifkind "";fail
 
 meta skuid {"bin", "root", "daemon"} accept;ok;meta skuid { 0, 1, 2} accept
 meta skuid != {"bin", "root", "daemon"} accept;ok;meta skuid != { 1, 0, 2} accept
diff --git a/tests/py/any/meta.t.json b/tests/py/any/meta.t.json
index 447e553f8ba78..cff557f48a3ab 100644
--- a/tests/py/any/meta.t.json
+++ b/tests/py/any/meta.t.json
@@ -952,6 +952,21 @@
     }
 ]
 
+# meta iifkind "bond"
+[
+    {
+        "match": {
+            "left": {
+                "meta": {
+                    "key": "iifkind"
+                }
+            },
+            "op": "==",
+            "right": "bond"
+        }
+    }
+]
+
 # meta oif "lo" accept
 [
     {
@@ -1113,6 +1128,21 @@
     }
 ]
 
+# meta oifkind "bond"
+[
+    {
+        "match": {
+            "left": {
+                "meta": {
+                    "key": "oifkind"
+                }
+            },
+            "op": "==",
+            "right": "bond"
+        }
+    }
+]
+
 # meta oiftype ether
 [
     {
diff --git a/tests/py/any/meta.t.payload b/tests/py/any/meta.t.payload
index 1d8426de9632d..915101b3f70c4 100644
--- a/tests/py/any/meta.t.payload
+++ b/tests/py/any/meta.t.payload
@@ -263,6 +263,11 @@ ip test-ip4 input
   [ meta load iiftype => reg 1 ]
   [ cmp eq reg 1 0x00000200 ]
 
+# meta iifkind "bond"
+ip test-ip4 input 
+  [ meta load iifkind => reg 1 ]
+  [ cmp eq reg 1 0x646e6f62 0x00000000 0x00000000 0x00000000 ]
+
 # meta oif "lo" accept
 ip test-ip4 input
   [ meta load oif => reg 1 ]
@@ -329,6 +334,11 @@ ip test-ip4 input
   [ meta load oiftype => reg 1 ]
   [ cmp eq reg 1 0x00000001 ]
 
+# meta oifkind "bond"
+ip test-ip4 input 
+  [ meta load oifkind => reg 1 ]
+  [ cmp eq reg 1 0x646e6f62 0x00000000 0x00000000 0x00000000 ]
+
 # meta skuid {"bin", "root", "daemon"} accept
 __set%d test-ip4 3
 __set%d test-ip4 0
-- 
2.22.0

