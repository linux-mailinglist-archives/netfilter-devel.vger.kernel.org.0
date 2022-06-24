Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B728555969D
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 Jun 2022 11:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiFXJ0I (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 24 Jun 2022 05:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiFXJ0H (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:26:07 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A187E6F480
        for <netfilter-devel@vger.kernel.org>; Fri, 24 Jun 2022 02:26:06 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1o4fZl-0003oV-1x; Fri, 24 Jun 2022 11:26:05 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 1/3] tests/py: Add a test for failing ipsec after counter
Date:   Fri, 24 Jun 2022 11:25:53 +0200
Message-Id: <20220624092555.1572-2-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220624092555.1572-1-fw@strlen.de>
References: <20220624092555.1572-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Phil Sutter <phil@nwl.cc>

This is a bug in parser/scanner due to scoping:

| Error: syntax error, unexpected string, expecting saddr or daddr
| add rule ip ipsec-ip4 ipsec-forw counter ipsec out ip daddr 192.168.1.2
|                                                       ^^^^^

Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/py/inet/ipsec.t         |  2 ++
 tests/py/inet/ipsec.t.json    | 21 +++++++++++++++++++++
 tests/py/inet/ipsec.t.payload |  6 ++++++
 3 files changed, 29 insertions(+)

diff --git a/tests/py/inet/ipsec.t b/tests/py/inet/ipsec.t
index e924e9bcbdbc..b18df395de6c 100644
--- a/tests/py/inet/ipsec.t
+++ b/tests/py/inet/ipsec.t
@@ -19,3 +19,5 @@ ipsec in ip6 daddr dead::beef;ok
 ipsec out ip6 saddr dead::feed;ok
 
 ipsec in spnum 256 reqid 1;fail
+
+counter ipsec out ip daddr 192.168.1.2;ok
diff --git a/tests/py/inet/ipsec.t.json b/tests/py/inet/ipsec.t.json
index d7d3a03c2113..18a64f3533b3 100644
--- a/tests/py/inet/ipsec.t.json
+++ b/tests/py/inet/ipsec.t.json
@@ -134,3 +134,24 @@
         }
     }
 ]
+
+# counter ipsec out ip daddr 192.168.1.2
+[
+    {
+        "counter": null
+    },
+    {
+        "match": {
+            "left": {
+                "ipsec": {
+                    "dir": "out",
+                    "family": "ip",
+                    "key": "daddr",
+                    "spnum": 0
+                }
+            },
+            "op": "==",
+            "right": "192.168.1.2"
+        }
+    }
+]
diff --git a/tests/py/inet/ipsec.t.payload b/tests/py/inet/ipsec.t.payload
index c46a2263f6c0..9648255df02e 100644
--- a/tests/py/inet/ipsec.t.payload
+++ b/tests/py/inet/ipsec.t.payload
@@ -37,3 +37,9 @@ ip ipsec-ip4 ipsec-forw
   [ xfrm load out 0 saddr6 => reg 1 ]
   [ cmp eq reg 1 0x0000adde 0x00000000 0x00000000 0xedfe0000 ]
 
+# counter ipsec out ip daddr 192.168.1.2
+ip ipsec-ip4 ipsec-forw
+  [ counter pkts 0 bytes 0 ]
+  [ xfrm load out 0 daddr4 => reg 1 ]
+  [ cmp eq reg 1 0x0201a8c0 ]
+
-- 
2.35.1

