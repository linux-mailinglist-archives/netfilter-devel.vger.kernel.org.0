Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888AD582552
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Jul 2022 13:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiG0LUl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Jul 2022 07:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbiG0LUj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:20:39 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C4227FE4
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Jul 2022 04:20:37 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1oGf5f-0003cQ-GY; Wed, 27 Jul 2022 13:20:35 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>, Eric Garver <eric@garver.life>
Subject: [PATCH nft 6/7] evaluate: search stacked header list for matching payload dep
Date:   Wed, 27 Jul 2022 13:20:02 +0200
Message-Id: <20220727112003.26022-7-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220727112003.26022-1-fw@strlen.de>
References: <20220727112003.26022-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

"ether saddr 0:1:2:3:4:6 vlan id 2" works, but reverse fails:

"vlan id 2 ether saddr 0:1:2:3:4:6" will give
Error: conflicting protocols specified: vlan vs. ether

After "proto: track full stack of seen l2 protocols, not just cumulative offset",
we have a list of all l2 headers, so search those to see if we had this
proto base in the past before rejecting this.

Reported-by: Eric Garver <eric@garver.life>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c                        | 21 +++++++---
 tests/py/bridge/vlan.t                |  3 ++
 tests/py/bridge/vlan.t.json           | 56 +++++++++++++++++++++++++++
 tests/py/bridge/vlan.t.payload        | 16 ++++++++
 tests/py/bridge/vlan.t.payload.netdev | 20 ++++++++++
 5 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index be9fcd5117fb..919c38c5604e 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -659,13 +659,22 @@ static int resolve_protocol_conflict(struct eval_ctx *ctx,
 	struct stmt *nstmt = NULL;
 	int link, err;
 
-	if (payload->payload.base == PROTO_BASE_LL_HDR &&
-	    proto_is_dummy(desc)) {
-		err = meta_iiftype_gen_dependency(ctx, payload, &nstmt);
-		if (err < 0)
-			return err;
+	if (payload->payload.base == PROTO_BASE_LL_HDR) {
+		if (proto_is_dummy(desc)) {
+			err = meta_iiftype_gen_dependency(ctx, payload, &nstmt);
+			if (err < 0)
+				return err;
 
-		rule_stmt_insert_at(ctx->rule, nstmt, ctx->stmt);
+			rule_stmt_insert_at(ctx->rule, nstmt, ctx->stmt);
+		} else {
+			unsigned int i;
+
+			/* payload desc stored in the L2 header stack? No conflict. */
+			for (i = 0; i < ctx->pctx.stacked_ll_count; i++) {
+				if (ctx->pctx.stacked_ll[i] == payload->payload.desc)
+					return 0;
+			}
+		}
 	}
 
 	assert(base <= PROTO_BASE_MAX);
diff --git a/tests/py/bridge/vlan.t b/tests/py/bridge/vlan.t
index 924ed4ed3679..49206017fff2 100644
--- a/tests/py/bridge/vlan.t
+++ b/tests/py/bridge/vlan.t
@@ -47,3 +47,6 @@ ether type ip vlan id 1 ip saddr 10.0.0.1;fail
 
 # mangling
 vlan id 1 vlan id set 2;ok
+
+ether saddr 00:01:02:03:04:05 vlan id 1;ok
+vlan id 2 ether saddr 0:1:2:3:4:6;ok;ether saddr 00:01:02:03:04:06 vlan id 2
diff --git a/tests/py/bridge/vlan.t.json b/tests/py/bridge/vlan.t.json
index e7640f9a6a37..58d4a40f5baf 100644
--- a/tests/py/bridge/vlan.t.json
+++ b/tests/py/bridge/vlan.t.json
@@ -761,3 +761,59 @@
         }
     }
 ]
+
+# ether saddr 00:01:02:03:04:05 vlan id 1
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "saddr",
+                    "protocol": "ether"
+                }
+            },
+            "op": "==",
+            "right": "00:01:02:03:04:05"
+        }
+    },
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "id",
+                    "protocol": "vlan"
+                }
+            },
+            "op": "==",
+            "right": 1
+        }
+    }
+]
+
+# vlan id 2 ether saddr 0:1:2:3:4:6
+[
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "saddr",
+                    "protocol": "ether"
+                }
+            },
+            "op": "==",
+            "right": "00:01:02:03:04:06"
+        }
+    },
+    {
+        "match": {
+            "left": {
+                "payload": {
+                    "field": "id",
+                    "protocol": "vlan"
+                }
+            },
+            "op": "==",
+            "right": 2
+        }
+    }
+]
diff --git a/tests/py/bridge/vlan.t.payload b/tests/py/bridge/vlan.t.payload
index 6c8d595a1aad..713670e9e721 100644
--- a/tests/py/bridge/vlan.t.payload
+++ b/tests/py/bridge/vlan.t.payload
@@ -276,3 +276,19 @@ bridge
   [ payload load 2b @ link header + 14 => reg 1 ]
   [ bitwise reg 1 = ( reg 1 & 0x000000f0 ) ^ 0x00000200 ]
   [ payload write reg 1 => 2b @ link header + 14 csum_type 0 csum_off 0 csum_flags 0x0 ]
+
+# ether saddr 00:01:02:03:04:05 vlan id 1
+bridge test-bridge input
+  [ payload load 8b @ link header + 6 => reg 1 ]
+  [ cmp eq reg 1 0x03020100 0x00810504 ]
+  [ payload load 2b @ link header + 14 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000ff0f ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000100 ]
+
+# vlan id 2 ether saddr 0:1:2:3:4:6
+bridge test-bridge input
+  [ payload load 8b @ link header + 6 => reg 1 ]
+  [ cmp eq reg 1 0x03020100 0x00810604 ]
+  [ payload load 2b @ link header + 14 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000ff0f ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000200 ]
diff --git a/tests/py/bridge/vlan.t.payload.netdev b/tests/py/bridge/vlan.t.payload.netdev
index d2c7d74a4e85..98a2a2b0f379 100644
--- a/tests/py/bridge/vlan.t.payload.netdev
+++ b/tests/py/bridge/vlan.t.payload.netdev
@@ -322,3 +322,23 @@ netdev
   [ payload load 2b @ link header + 14 => reg 1 ]
   [ bitwise reg 1 = ( reg 1 & 0x000000f0 ) ^ 0x00000200 ]
   [ payload write reg 1 => 2b @ link header + 14 csum_type 0 csum_off 0 csum_flags 0x0 ]
+
+# vlan id 2 ether saddr 0:1:2:3:4:6
+netdev test-netdev ingress
+  [ meta load iiftype => reg 1 ]
+  [ cmp eq reg 1 0x00000001 ]
+  [ payload load 8b @ link header + 6 => reg 1 ]
+  [ cmp eq reg 1 0x03020100 0x00810604 ]
+  [ payload load 2b @ link header + 14 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000ff0f ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000200 ]
+
+# ether saddr 00:01:02:03:04:05 vlan id 1
+netdev test-netdev ingress
+  [ meta load iiftype => reg 1 ]
+  [ cmp eq reg 1 0x00000001 ]
+  [ payload load 8b @ link header + 6 => reg 1 ]
+  [ cmp eq reg 1 0x03020100 0x00810504 ]
+  [ payload load 2b @ link header + 14 => reg 1 ]
+  [ bitwise reg 1 = ( reg 1 & 0x0000ff0f ) ^ 0x00000000 ]
+  [ cmp eq reg 1 0x00000100 ]
-- 
2.35.1

