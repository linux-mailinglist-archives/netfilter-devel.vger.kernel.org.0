Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE473F2B4A
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Aug 2021 13:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbhHTLfS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Aug 2021 07:35:18 -0400
Received: from mail.netfilter.org ([217.70.188.207]:53476 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239870AbhHTLfS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:35:18 -0400
Received: from localhost.localdomain (unknown [213.94.13.0])
        by mail.netfilter.org (Postfix) with ESMTPSA id 01E5160202;
        Fri, 20 Aug 2021 13:33:48 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nft,v2] src: queue: consolidate queue statement syntax
Date:   Fri, 20 Aug 2021 13:34:35 +0200
Message-Id: <20210820113435.11172-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Print queue statement using the 'queue ... to' syntax to consolidate the
syntax around Florian's proposal introduced in 6cf0f2c17bfb ("src:
queue: allow use of arbitrary queue expressions").

Retain backward compatibility, 'queue num' syntax is still allowed.

Update and add new tests.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: update manpage.
    update tests/py for json.
    fix broken tests/shell in v1.

 doc/statements.txt                            |  4 +-
 src/parser_bison.y                            | 14 +++-
 src/statement.c                               | 11 +--
 tests/py/any/queue.t                          | 22 ++++--
 tests/py/any/queue.t.json                     | 75 +++++++++++++++++++
 tests/py/any/queue.t.payload                  | 24 ++++++
 .../testcases/nft-f/0012different_defines_0   |  2 +-
 .../nft-f/dumps/0012different_defines_0.nft   |  6 +-
 8 files changed, 133 insertions(+), 25 deletions(-)

diff --git a/doc/statements.txt b/doc/statements.txt
index af98e42c3633..5bb3050f7ab2 100644
--- a/doc/statements.txt
+++ b/doc/statements.txt
@@ -589,8 +589,8 @@ for details.
 
 [verse]
 ____
-*queue* [*flags* 'QUEUE_FLAGS'] [*num* 'queue_number']
-*queue* [*flags* 'QUEUE_FLAGS'] [*num* 'queue_number_from' - 'queue_number_to']
+*queue* [*flags* 'QUEUE_FLAGS'] [*to* 'queue_number']
+*queue* [*flags* 'QUEUE_FLAGS'] [*to* 'queue_number_from' - 'queue_number_to']
 *queue* [*flags* 'QUEUE_FLAGS'] [*to* 'QUEUE_EXPRESSION' ]
 
 'QUEUE_FLAGS' := 'QUEUE_FLAG' [*,* 'QUEUE_FLAGS']
diff --git a/src/parser_bison.y b/src/parser_bison.y
index 6b87ece55a69..c25af6ba114a 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -705,8 +705,8 @@ int nft_lex(void *, void *, void *);
 
 %type <stmt>			queue_stmt queue_stmt_alloc	queue_stmt_compat
 %destructor { stmt_free($$); }	queue_stmt queue_stmt_alloc	queue_stmt_compat
-%type <expr>			queue_stmt_expr_simple queue_stmt_expr reject_with_expr
-%destructor { expr_free($$); }	queue_stmt_expr_simple queue_stmt_expr reject_with_expr
+%type <expr>			queue_stmt_expr_simple queue_stmt_expr queue_expr reject_with_expr
+%destructor { expr_free($$); }	queue_stmt_expr_simple queue_stmt_expr queue_expr reject_with_expr
 %type <val>			queue_stmt_flags queue_stmt_flag
 %type <stmt>			dup_stmt
 %destructor { stmt_free($$); }	dup_stmt
@@ -3790,14 +3790,22 @@ queue_stmt_arg		:	QUEUENUM	queue_stmt_expr_simple
 			}
 			;
 
+queue_expr		:	variable_expr
+			|	integer_expr
+			;
+
 queue_stmt_expr_simple	:	integer_expr
-			|	range_rhs_expr
 			|	variable_expr
+			|	queue_expr	DASH	queue_expr
+			{
+				$$ = range_expr_alloc(&@$, $1, $3);
+			}
 			;
 
 queue_stmt_expr		:	numgen_expr
 			|	hash_expr
 			|	map_expr
+			|	queue_stmt_expr_simple
 			;
 
 queue_stmt_flags	:	queue_stmt_flag
diff --git a/src/statement.c b/src/statement.c
index 97b163e8ac06..03c0acf6a361 100644
--- a/src/statement.c
+++ b/src/statement.c
@@ -507,15 +507,10 @@ static void queue_stmt_print(const struct stmt *stmt, struct output_ctx *octx)
 		nft_print(octx, "%sfanout", delim);
 
 	if (e) {
-		if (e->etype == EXPR_VALUE || e->etype == EXPR_RANGE) {
-			nft_print(octx, " num ");
-			expr_print(stmt->queue.queue, octx);
-		} else {
-			nft_print(octx, " to ");
-			expr_print(stmt->queue.queue, octx);
-		}
+		nft_print(octx, " to ");
+		expr_print(stmt->queue.queue, octx);
 	} else {
-		nft_print(octx, " num 0");
+		nft_print(octx, " to 0");
 	}
 }
 
diff --git a/tests/py/any/queue.t b/tests/py/any/queue.t
index 446b8b1806f2..f12acfafe19b 100644
--- a/tests/py/any/queue.t
+++ b/tests/py/any/queue.t
@@ -6,15 +6,15 @@
 *arp;test-arp;output
 *bridge;test-bridge;output
 
-queue;ok;queue num 0
-queue num 2;ok
-queue num 65535;ok
+queue;ok;queue to 0
+queue num 2;ok;queue to 2
+queue num 65535;ok;queue to 65535
 queue num 65536;fail
-queue num 2-3;ok
-queue num 1-65535;ok
-queue num 4-5 fanout bypass;ok;queue flags bypass,fanout num 4-5
-queue num 4-5 fanout;ok;queue flags fanout num 4-5
-queue num 4-5 bypass;ok;queue flags bypass num 4-5
+queue num 2-3;ok;queue to 2-3
+queue num 1-65535;ok;queue to 1-65535
+queue num 4-5 fanout bypass;ok;queue flags bypass,fanout to 4-5
+queue num 4-5 fanout;ok;queue flags fanout to 4-5
+queue num 4-5 bypass;ok;queue flags bypass to 4-5
 
 queue to symhash mod 2 offset 65536;fail
 queue num symhash mod 65536;fail
@@ -23,6 +23,12 @@ queue flags fanout to symhash mod 65536;fail
 queue flags bypass,fanout to symhash mod 65536;fail
 queue flags bypass to numgen inc mod 65536;ok
 queue to jhash oif . meta mark mod 32;ok
+queue to 2;ok
+queue to 65535;ok
+queue flags bypass to 65535;ok
+queue flags bypass to 1-65535;ok
+queue flags bypass,fanout to 1-65535;ok
+queue to 1-65535;ok
 queue to oif;fail
 queue num oif;fail
 queue flags bypass to oifname map { "eth0" : 0, "ppp0" : 2, "eth1" : 2 };ok
diff --git a/tests/py/any/queue.t.json b/tests/py/any/queue.t.json
index 162bdff875d6..5f7f9014f1a6 100644
--- a/tests/py/any/queue.t.json
+++ b/tests/py/any/queue.t.json
@@ -174,3 +174,78 @@
     }
 ]
 
+# queue to 2
+[
+    {
+        "queue": {
+            "num": 2
+        }
+    }
+]
+
+# queue to 65535
+[
+    {
+        "queue": {
+            "num": 65535
+        }
+    }
+]
+
+# queue flags bypass to 65535
+[
+    {
+        "queue": {
+            "flags": "bypass",
+            "num": 65535
+        }
+    }
+]
+
+# queue flags bypass to 1-65535
+[
+    {
+        "queue": {
+            "flags": "bypass",
+            "num": {
+                "range": [
+                    1,
+                    65535
+                ]
+            }
+        }
+    }
+]
+
+# queue flags bypass,fanout to 1-65535
+[
+    {
+        "queue": {
+            "flags": [
+                "bypass",
+                "fanout"
+            ],
+            "num": {
+                "range": [
+                    1,
+                    65535
+                ]
+            }
+        }
+    }
+]
+
+# queue to 1-65535
+[
+    {
+        "queue": {
+            "num": {
+                "range": [
+                    1,
+                    65535
+                ]
+            }
+        }
+    }
+]
+
diff --git a/tests/py/any/queue.t.payload b/tests/py/any/queue.t.payload
index 02660afa8d30..2f221930a1ef 100644
--- a/tests/py/any/queue.t.payload
+++ b/tests/py/any/queue.t.payload
@@ -55,3 +55,27 @@ ip
   [ meta load oifname => reg 1 ]
   [ lookup reg 1 set __map%d dreg 1 ]
   [ queue sreg_qnum 1 bypass ]
+
+# queue to 2
+ip
+  [ queue num 2 ]
+
+# queue to 65535
+ip
+  [ queue num 65535 ]
+
+# queue flags bypass to 65535
+ip
+  [ queue num 65535 bypass ]
+
+# queue flags bypass to 1-65535
+ip
+  [ queue num 1-65535 bypass ]
+
+# queue flags bypass,fanout to 1-65535
+ip
+  [ queue num 1-65535 bypass fanout ]
+
+# queue to 1-65535
+ip
+  [ queue num 1-65535 ]
diff --git a/tests/shell/testcases/nft-f/0012different_defines_0 b/tests/shell/testcases/nft-f/0012different_defines_0
index fe22858791a1..230c6e3f65b2 100755
--- a/tests/shell/testcases/nft-f/0012different_defines_0
+++ b/tests/shell/testcases/nft-f/0012different_defines_0
@@ -32,7 +32,7 @@ table inet t {
 		tcp dport \$d_ports
 		udp dport vmap { \$d_ports : accept }
 		tcp dport 1 tcp sport 1 meta oifname \"foobar\" queue num \$d_qnum bypass
-		tcp dport 1 tcp sport 1 meta oifname \"foobar\" queue num \$d_qnumr
+		tcp dport 1 tcp sport 1 meta oifname \"foobar\" queue to \$d_qnumr
 		tcp dport 1 tcp sport 1 meta oifname \"foobar\" queue flags bypass,fanout num \$d_qnumr
 		tcp dport 1 tcp sport 1 meta oifname \"foobar\" queue to symhash mod 2
 		tcp dport 1 tcp sport 1 meta oifname \"foobar\" queue flags bypass to jhash tcp dport . tcp sport mod 4
diff --git a/tests/shell/testcases/nft-f/dumps/0012different_defines_0.nft b/tests/shell/testcases/nft-f/dumps/0012different_defines_0.nft
index e690f322436d..4734b2fd8bd1 100644
--- a/tests/shell/testcases/nft-f/dumps/0012different_defines_0.nft
+++ b/tests/shell/testcases/nft-f/dumps/0012different_defines_0.nft
@@ -12,9 +12,9 @@ table inet t {
 		ip daddr . iif vmap { 10.0.0.0 . "lo" : accept }
 		tcp dport 100-222
 		udp dport vmap { 100-222 : accept }
-		tcp sport 1 tcp dport 1 oifname "foobar" queue flags bypass num 0
-		tcp sport 1 tcp dport 1 oifname "foobar" queue num 1-42
-		tcp sport 1 tcp dport 1 oifname "foobar" queue flags bypass,fanout num 1-42
+		tcp sport 1 tcp dport 1 oifname "foobar" queue flags bypass to 0
+		tcp sport 1 tcp dport 1 oifname "foobar" queue to 1-42
+		tcp sport 1 tcp dport 1 oifname "foobar" queue flags bypass,fanout to 1-42
 		tcp sport 1 tcp dport 1 oifname "foobar" queue to symhash mod 2
 		tcp sport 1 tcp dport 1 oifname "foobar" queue flags bypass to jhash tcp dport . tcp sport mod 4
 	}
-- 
2.20.1

