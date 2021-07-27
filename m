Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DB73D8325
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jul 2021 00:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhG0Wje (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 27 Jul 2021 18:39:34 -0400
Received: from mail.netfilter.org ([217.70.188.207]:36896 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhG0Wje (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:39:34 -0400
Received: from salvia.lan (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id 952036429D;
        Wed, 28 Jul 2021 00:39:02 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     tom.ty89@gmail.com
Subject: [PATCH nft,v2 3/3] tests: py: tcp flags & (fin | syn | rst | ack) == syn
Date:   Wed, 28 Jul 2021 00:39:21 +0200
Message-Id: <20210727223921.29746-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210727223921.29746-1-pablo@netfilter.org>
References: <20210727223921.29746-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a test case to cover translation to tcp flags syn / fin,syn,rst,ack.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: new in this series.

 tests/py/inet/tcp.t         |  1 +
 tests/py/inet/tcp.t.json    | 27 +++++++++++++++++++++++++++
 tests/py/inet/tcp.t.payload |  8 ++++++++
 3 files changed, 36 insertions(+)

diff --git a/tests/py/inet/tcp.t b/tests/py/inet/tcp.t
index 17e0d9b6df9f..dece9eaa89f8 100644
--- a/tests/py/inet/tcp.t
+++ b/tests/py/inet/tcp.t
@@ -73,6 +73,7 @@ tcp flags & syn != 0;ok;tcp flags syn
 # it should be possible to transform this to: tcp flags syn
 tcp flags & syn == syn;ok
 tcp flags & (fin | syn | rst | ack) syn;ok;tcp flags syn / fin,syn,rst,ack
+tcp flags & (fin | syn | rst | ack) == syn;ok;tcp flags syn / fin,syn,rst,ack
 tcp flags & (fin | syn | rst | ack) != syn;ok;tcp flags != syn / fin,syn,rst,ack
 tcp flags & (fin | syn | rst | psh | ack | urg | ecn | cwr) == fin | syn | rst | psh | ack | urg | ecn | cwr;ok;tcp flags == 0xff
 tcp flags { syn, syn | ack };ok
diff --git a/tests/py/inet/tcp.t.json b/tests/py/inet/tcp.t.json
index c1e4fb35a87c..23244eaa2339 100644
--- a/tests/py/inet/tcp.t.json
+++ b/tests/py/inet/tcp.t.json
@@ -1584,6 +1584,33 @@
     }
 ]
 
+# tcp flags & (fin | syn | rst | ack) == syn
+[
+    {
+        "match": {
+            "left": {
+                "&": [
+                    {
+                        "payload": {
+                            "field": "flags",
+                            "protocol": "tcp"
+                        }
+                    },
+                    [
+                        "fin",
+                        "syn",
+                        "rst",
+                        "ack"
+                    ]
+                ]
+            },
+            "op": "==",
+            "right": "syn"
+        }
+    }
+]
+
+
 # tcp flags & (fin | syn | rst | ack) != syn
 [
     {
diff --git a/tests/py/inet/tcp.t.payload b/tests/py/inet/tcp.t.payload
index 77b301883a15..4e795aa931ac 100644
--- a/tests/py/inet/tcp.t.payload
+++ b/tests/py/inet/tcp.t.payload
@@ -394,6 +394,14 @@ inet test-inet input
   [ bitwise reg 1 = ( reg 1 & 0x00000017 ) ^ 0x00000000 ]
   [ cmp eq reg 1 0x00000002 ]
 
+# tcp flags & (fin | syn | rst | ack) == syn
+inet test-inet input
+  [ meta load l4proto => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
+  [ payload load 1b @ transport header + 13 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x00000017 ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000002 ]
+
 # tcp flags & (fin | syn | rst | ack) != syn
 inet test-inet input
   [ meta load l4proto => reg 1 ]
-- 
2.20.1

