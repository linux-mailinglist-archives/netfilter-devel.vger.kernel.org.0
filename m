Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C77446692
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Nov 2021 16:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhKEQAW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 5 Nov 2021 12:00:22 -0400
Received: from mail.netfilter.org ([217.70.188.207]:40220 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhKEQAW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:00:22 -0400
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 4FD8F60830
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Nov 2021 16:55:45 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] tests: py: update rawpayload.t.json
Date:   Fri,  5 Nov 2021 16:57:35 +0100
Message-Id: <20211105155735.556732-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Missing update of json test.

Fixes: 6ad2058da66a ("datatype: add xinteger_type alias to print in hexadecimal")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/py/any/rawpayload.t.json        |  8 ++++----
 tests/py/any/rawpayload.t.json.output | 18 +++++++++++++++++-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/tests/py/any/rawpayload.t.json b/tests/py/any/rawpayload.t.json
index 22028ad82300..9481d9bf543b 100644
--- a/tests/py/any/rawpayload.t.json
+++ b/tests/py/any/rawpayload.t.json
@@ -66,7 +66,7 @@
     }
 ]
 
-# @nh,8,8 255
+# @nh,8,8 0xff
 [
     {
         "match": {
@@ -78,12 +78,12 @@
                 }
             },
 	    "op": "==",
-            "right": 255
+            "right": "0xff"
         }
     }
 ]
 
-# @nh,8,16 0
+# @nh,8,16 0x0
 [
     {
         "match": {
@@ -117,7 +117,7 @@
     }
 ]
 
-# @ll,0,8 and 0x80 eq 0x80
+# @ll,0,8 & 0x80 == 0x80
 [
     {
         "match": {
diff --git a/tests/py/any/rawpayload.t.json.output b/tests/py/any/rawpayload.t.json.output
index ccadbc57ce09..291b237aed0f 100644
--- a/tests/py/any/rawpayload.t.json.output
+++ b/tests/py/any/rawpayload.t.json.output
@@ -79,7 +79,7 @@
     }
 ]
 
-# @ll,0,8 and 0x80 eq 0x80
+# @ll,0,8 & 0x80 == 0x80
 [
     {
         "match": {
@@ -101,3 +101,19 @@
     }
 ]
 
+# @nh,8,8 0xff
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "base": "nh",
+                    "len": 8,
+                    "offset": 8
+                }
+            },
+            "op": "==",
+            "right": 255
+        }
+    }
+]
-- 
2.30.2

