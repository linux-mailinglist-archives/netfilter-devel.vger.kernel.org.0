Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616C664633E
	for <lists+netfilter-devel@lfdr.de>; Wed,  7 Dec 2022 22:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiLGV1m (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 7 Dec 2022 16:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLGV1l (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:27:41 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0481B49B
        for <netfilter-devel@vger.kernel.org>; Wed,  7 Dec 2022 13:27:39 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     eric@garver.life
Subject: [PATCH nft 1/2] tests: py: missing json for different byteorder selector with interval concatenation
Date:   Wed,  7 Dec 2022 22:27:30 +0100
Message-Id: <20221207212731.179911-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add missing json output, otherwise -j reports an error.

Fixes: 1017d323cafa ("src: support for selectors with different byteorder with interval concatenations")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/py/inet/meta.t.json | 61 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tests/py/inet/meta.t.json b/tests/py/inet/meta.t.json
index 723a36f74946..bc268a2ef2ae 100644
--- a/tests/py/inet/meta.t.json
+++ b/tests/py/inet/meta.t.json
@@ -289,3 +289,64 @@
         }
     }
 ]
+
+# meta mark . tcp dport { 0x0000000a-0x00000014 . 80-90, 0x00100000-0x00100123 . 100-120 }
+[
+    {
+        "match": {
+            "left": {
+                "concat": [
+                    {
+                        "meta": {
+                            "key": "mark"
+                        }
+                    },
+                    {
+                        "payload": {
+                            "field": "dport",
+                            "protocol": "tcp"
+                        }
+                    }
+                ]
+            },
+            "op": "==",
+            "right": {
+                "set": [
+                    {
+                        "concat": [
+                            {
+                                "range": [
+                                    10,
+                                    20
+                                ]
+                            },
+                            {
+                                "range": [
+                                    80,
+                                    90
+                                ]
+                            }
+                        ]
+                    },
+                    {
+                        "concat": [
+                            {
+                                "range": [
+                                    1048576,
+                                    1048867
+                                ]
+                            },
+                            {
+                                "range": [
+                                    100,
+                                    120
+                                ]
+                            }
+                        ]
+                    }
+                ]
+            }
+        }
+    }
+]
+
-- 
2.30.2

