Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219231891A
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 May 2019 13:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfEILgM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 May 2019 07:36:12 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35050 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfEILgM (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 May 2019 07:36:12 -0400
Received: from localhost ([::1]:48140 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hOhLO-0000dG-SW; Thu, 09 May 2019 13:36:10 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 4/9] tests/py: Fix JSON equivalents of osf tests
Date:   Thu,  9 May 2019 13:35:40 +0200
Message-Id: <20190509113545.4017-5-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509113545.4017-1-phil@nwl.cc>
References: <20190509113545.4017-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fixes: 12adf747a3f62 ("tests: py: add osf tests with versions")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/py/inet/osf.t.json | 59 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/tests/py/inet/osf.t.json b/tests/py/inet/osf.t.json
index a2e744952140d..cedb7f67bd52f 100644
--- a/tests/py/inet/osf.t.json
+++ b/tests/py/inet/osf.t.json
@@ -45,13 +45,14 @@
     }
 ]
 
-# osf name version "Linux:3.0"
+# osf ttl skip version "Linux:3.0"
 [
     {
         "match": {
             "left": {
                 "osf": {
-                    "key": "version"
+                    "key": "version",
+                    "ttl": "skip"
                 }
             },
             "op": "==",
@@ -80,6 +81,26 @@
     }
 ]
 
+# osf version { "Windows:XP", "MacOs:Sierra" }
+[
+    {
+        "match": {
+            "left": {
+                "osf": {
+                    "key": "version"
+                }
+            },
+            "op": "==",
+            "right": {
+                "set": [
+                    "Windows:XP",
+                    "MacOs:Sierra"
+                ]
+            }
+        }
+    }
+]
+
 # ct mark set osf name map { "Windows" : 0x00000001, "MacOs" : 0x00000002 }
 [
     {
@@ -113,3 +134,37 @@
         }
     }
 ]
+
+# ct mark set osf version map { "Windows:XP" : 0x00000003, "MacOs:Sierra" : 0x00000004 }
+[
+    {
+        "mangle": {
+            "key": {
+                "ct": {
+                    "key": "mark"
+                }
+            },
+            "value": {
+                "map": {
+                    "data": {
+                        "set": [
+                            [
+                                "Windows:XP",
+                                3
+                            ],
+                            [
+                                "MacOs:Sierra",
+                                4
+                            ]
+                        ]
+                    },
+                    "key": {
+                        "osf": {
+                            "key": "version"
+                        }
+                    }
+                }
+            }
+        }
+    }
+]
-- 
2.21.0

