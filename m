Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F153A85F9
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Jun 2021 18:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhFOQEq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Jun 2021 12:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhFOQEQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:04:16 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F3DC061574
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Jun 2021 09:02:11 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ltBVx-0001KI-WC; Tue, 15 Jun 2021 18:02:10 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft v2 3/3] tests: add a icmp-reply only and icmpv6 id test cases
Date:   Tue, 15 Jun 2021 18:01:51 +0200
Message-Id: <20210615160151.10594-4-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615160151.10594-1-fw@strlen.de>
References: <20210615160151.10594-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Check that nft doesn't remove the dependency in these cases:
icmp type echo-reply icmp id 1
("icmp id" matches both echo request and reply).

Add icmpv6 test cases.  These fail without the previous patches:

add rule ip6 test-ip6 input icmpv6 id 1:
 'icmpv6 id 1' mismatches
 'icmpv6 type { echo-request, echo-reply} icmpv6 parameter-problem 65536/16'

add rule ip6 test-ip6 input icmpv6 type echo-reply icmpv6 id 65534':
  'icmpv6 type echo-reply icmpv6 id 65534' mismatches
  'icmpv6 type echo-reply @th,32,16 65534'

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/py/ip/icmp.t                |  1 +
 tests/py/ip/icmp.t.json           | 28 ++++++++++++++
 tests/py/ip/icmp.t.payload.ip     |  9 +++++
 tests/py/ip6/icmpv6.t             |  3 ++
 tests/py/ip6/icmpv6.t.json        | 61 +++++++++++++++++++++++++++++++
 tests/py/ip6/icmpv6.t.payload.ip6 | 21 +++++++++++
 6 files changed, 123 insertions(+)

diff --git a/tests/py/ip/icmp.t b/tests/py/ip/icmp.t
index fd89af0dff20..7ddf8b38a538 100644
--- a/tests/py/ip/icmp.t
+++ b/tests/py/ip/icmp.t
@@ -53,6 +53,7 @@ icmp sequence { 33, 55, 67, 88};ok;icmp type { echo-request, echo-reply} icmp se
 icmp sequence != { 33, 55, 67, 88};ok;icmp type { echo-request, echo-reply} icmp sequence != { 33, 55, 67, 88}
 icmp id 1 icmp sequence 2;ok;icmp type { echo-reply, echo-request} icmp id 1 icmp sequence 2
 icmp type { echo-reply, echo-request} icmp id 1 icmp sequence 2;ok
+icmp type echo-reply icmp id 1;ok
 
 icmp mtu 33;ok
 icmp mtu 22-33;ok
diff --git a/tests/py/ip/icmp.t.json b/tests/py/ip/icmp.t.json
index 576335cc63d2..4f0525094cf0 100644
--- a/tests/py/ip/icmp.t.json
+++ b/tests/py/ip/icmp.t.json
@@ -1123,6 +1123,34 @@
     }
 ]
 
+# icmp type echo-reply icmp id 1
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "type",
+                    "protocol": "icmp"
+                }
+            },
+            "op": "==",
+            "right": "echo-reply"
+        }
+    },
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "id",
+                    "protocol": "icmp"
+                }
+            },
+            "op": "==",
+            "right": 1
+        }
+    }
+]
+
 # icmp mtu 33
 [
     {
diff --git a/tests/py/ip/icmp.t.payload.ip b/tests/py/ip/icmp.t.payload.ip
index 024739c0c3cc..3bc6de3cf717 100644
--- a/tests/py/ip/icmp.t.payload.ip
+++ b/tests/py/ip/icmp.t.payload.ip
@@ -413,6 +413,15 @@ ip
   [ payload load 4b @ transport header + 4 => reg 1 ]
   [ cmp eq reg 1 0x02000100 ]
 
+# icmp type echo-reply icmp id 1
+ip
+  [ meta load l4proto => reg 1 ]
+  [ cmp eq reg 1 0x00000001 ]
+  [ payload load 1b @ transport header + 0 => reg 1 ]
+  [ cmp eq reg 1 0x00000000 ]
+  [ payload load 2b @ transport header + 4 => reg 1 ]
+  [ cmp eq reg 1 0x00000100 ]
+
 # icmp mtu 33
 ip test-ip4 input
   [ meta load l4proto => reg 1 ]
diff --git a/tests/py/ip6/icmpv6.t b/tests/py/ip6/icmpv6.t
index c8d4cffcd9d7..4de6ee2377dd 100644
--- a/tests/py/ip6/icmpv6.t
+++ b/tests/py/ip6/icmpv6.t
@@ -67,6 +67,9 @@ icmpv6 id != 33-45;ok;icmpv6 type { echo-request, echo-reply} icmpv6 id != 33-45
 icmpv6 id {33, 55, 67, 88};ok;icmpv6 type { echo-request, echo-reply} icmpv6 id { 33, 55, 67, 88}
 icmpv6 id != {33, 55, 67, 88};ok;icmpv6 type { echo-request, echo-reply} icmpv6 id != { 33, 55, 67, 88}
 
+icmpv6 id 1;ok;icmpv6 type { echo-request, echo-reply} icmpv6 id 1
+icmpv6 type echo-reply icmpv6 id 65534;ok
+
 icmpv6 sequence 2;ok;icmpv6 type { echo-request, echo-reply} icmpv6 sequence 2
 icmpv6 sequence {3, 4, 5, 6, 7} accept;ok;icmpv6 type { echo-request, echo-reply} icmpv6 sequence { 3, 4, 5, 6, 7} accept
 
diff --git a/tests/py/ip6/icmpv6.t.json b/tests/py/ip6/icmpv6.t.json
index 30d2ad988185..2251be82a39e 100644
--- a/tests/py/ip6/icmpv6.t.json
+++ b/tests/py/ip6/icmpv6.t.json
@@ -856,6 +856,67 @@
     }
 ]
 
+# icmpv6 id 1
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "type",
+                    "protocol": "icmpv6"
+                }
+            },
+            "op": "==",
+            "right": {
+                "set": [
+                    "echo-request",
+                    "echo-reply"
+                ]
+            }
+        }
+    },
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "id",
+                    "protocol": "icmpv6"
+                }
+            },
+            "op": "==",
+            "right": 1
+        }
+    }
+]
+
+# icmpv6 type echo-reply icmpv6 id 65534
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "type",
+                    "protocol": "icmpv6"
+                }
+            },
+            "op": "==",
+            "right": "echo-reply"
+        }
+    },
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "id",
+                    "protocol": "icmpv6"
+                }
+            },
+            "op": "==",
+            "right": 65534
+        }
+    }
+]
+
 # icmpv6 sequence 2
 [
     {
diff --git a/tests/py/ip6/icmpv6.t.payload.ip6 b/tests/py/ip6/icmpv6.t.payload.ip6
index 76df184cd0d0..0e96be2d0788 100644
--- a/tests/py/ip6/icmpv6.t.payload.ip6
+++ b/tests/py/ip6/icmpv6.t.payload.ip6
@@ -407,6 +407,27 @@ ip6 test-ip6 input
   [ payload load 2b @ transport header + 4 => reg 1 ]
   [ lookup reg 1 set __set%d 0x1 ]
 
+# icmpv6 id 1
+__set%d test-ip6 3 size 2
+__set%d test-ip6 0
+	element 00000080  : 0 [end]	element 00000081  : 0 [end]
+ip6
+  [ meta load l4proto => reg 1 ]
+  [ cmp eq reg 1 0x0000003a ]
+  [ payload load 1b @ transport header + 0 => reg 1 ]
+  [ lookup reg 1 set __set%d ]
+  [ payload load 2b @ transport header + 4 => reg 1 ]
+  [ cmp eq reg 1 0x00000100 ]
+
+# icmpv6 type echo-reply icmpv6 id 65534
+ip6
+  [ meta load l4proto => reg 1 ]
+  [ cmp eq reg 1 0x0000003a ]
+  [ payload load 1b @ transport header + 0 => reg 1 ]
+  [ cmp eq reg 1 0x00000081 ]
+  [ payload load 2b @ transport header + 4 => reg 1 ]
+  [ cmp eq reg 1 0x0000feff ]
+
 # icmpv6 sequence 2
 __set%d test-ip6 3
 __set%d test-ip6 0
-- 
2.31.1

