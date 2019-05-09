Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68EFF1891D
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 May 2019 13:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEILg2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 May 2019 07:36:28 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35068 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfEILg2 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 May 2019 07:36:28 -0400
Received: from localhost ([::1]:48158 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hOhLe-0000eJ-VR; Thu, 09 May 2019 13:36:27 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 8/9] tests/py: Fix JSON expexted output after expr merge change
Date:   Thu,  9 May 2019 13:35:44 +0200
Message-Id: <20190509113545.4017-9-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509113545.4017-1-phil@nwl.cc>
References: <20190509113545.4017-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Looks like original patch missed this one.

Fixes: 88ba0c92754d8 ("tests: fix up expected payloads after expr merge change")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/py/inet/tcp.t.json.output | 44 ++-------------------------------
 1 file changed, 2 insertions(+), 42 deletions(-)

diff --git a/tests/py/inet/tcp.t.json.output b/tests/py/inet/tcp.t.json.output
index 143490f7322d2..0f7a593b788c1 100644
--- a/tests/py/inet/tcp.t.json.output
+++ b/tests/py/inet/tcp.t.json.output
@@ -23,32 +23,8 @@
     }
 ]
 
-# tcp sequence 0 tcp sport 1024 tcp dport 22
+# tcp sequence 0 tcp sport { 1024, 1022} tcp dport 22
 [
-    {
-        "match": {
-            "left": {
-                "payload": {
-                    "field": "sport",
-                    "protocol": "tcp"
-                }
-            },
-	    "op": "==",
-            "right": 1024
-        }
-    },
-    {
-        "match": {
-            "left": {
-                "payload": {
-                    "field": "dport",
-                    "protocol": "tcp"
-                }
-            },
-	    "op": "==",
-            "right": 22
-        }
-    },
     {
         "match": {
             "left": {
@@ -60,11 +36,7 @@
 	    "op": "==",
             "right": 0
         }
-    }
-]
-
-# tcp sequence 0 tcp sport { 1024, 1022} tcp dport 22
-[
+    },
     {
         "match": {
             "left": {
@@ -93,18 +65,6 @@
 	    "op": "==",
             "right": 22
         }
-    },
-    {
-        "match": {
-            "left": {
-                "payload": {
-                    "field": "sequence",
-                    "protocol": "tcp"
-                }
-            },
-	    "op": "==",
-            "right": 0
-        }
     }
 ]
 
-- 
2.21.0

