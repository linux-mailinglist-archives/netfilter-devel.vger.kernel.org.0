Return-Path: <netfilter-devel+bounces-1448-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08068813F6
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Mar 2024 15:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5588C284CA9
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Mar 2024 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FE74AEF0;
	Wed, 20 Mar 2024 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="InH8OUuh"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB56250A72
	for <netfilter-devel@vger.kernel.org>; Wed, 20 Mar 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946695; cv=none; b=u2NjXKz1EG0hDihTKz02iAYyb+mpY3GfFGd1XQcxt6pbwcETAz52q5+Jwjd2lcM1XUI//Y46nfnRT+glTIIBEfTqZpJtD8R5BGoAllfUb2cWUb4zTzVB8c/MOB0/KyRftibfjVAjiaAFvEQkRHiZjmXvc6dOFpPIUHiGsRZz58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946695; c=relaxed/simple;
	bh=m6TZw2FTCvd68K6E89LmeoaMjs2CPmX41/NXIMSG8dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXQ6/PB6+TomTrIpLpdrCxAqXw7aGm685TOoC8P0tc4C42YJ7HaZDaIh3W1h2b3J9TDPztcruCOQ35ulPG1keV6Co5ZawgCBfBHSxEArjwRuA5eHbKRcgJbhQUlZGOKsLWXdwtzNrDgFA4PDqnJElNclH+iS9QBrRxDBBnZA62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=InH8OUuh; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ol+ORYwttWPlfRFhG086gQ18xhhtW6S5dVsfFI14LF8=; b=InH8OUuhtBWvNTwR/fy0POYHYa
	bADiW4MpUOm+wQld4QQvTLeIsdhqmtUFnkaytEP4BCYJIz5OouhL/xfzfeZo0hnWsYx1s4jOSW6WX
	6c8LLQXxo8uS/fvci1SxWBoI6g9OxHJeTKEMNogdeH/AZmBpGOkAF9dMKKoPd1xuoxWXsYEfT1+cW
	gia2bP2jf2QNqjiYNOifzsC97RaEoceg35sLNdiu6QfACssx8o5hdWR4iDSgSj8s+tOlX2GngW5Xq
	bHJTVGSbmzS+NZhCnOxNt+KSl+NnMbZYue1rf+DChew3ZRi0G3CYTkn7xEklYRqtrT3c8Q2b+EQ4m
	X4DPwZeA==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1rmxOM-000000003g7-2DhF;
	Wed, 20 Mar 2024 15:58:10 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: [nft PATCH] json: Accept more than two operands in binary expressions
Date: Wed, 20 Mar 2024 15:58:06 +0100
Message-ID: <20240320145806.4167-1-phil@nwl.cc>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The most common use case is ORing flags like

| syn | ack | rst

but nft seems to be fine with less intuitive stuff like

| meta mark set ip dscp << 2 << 3

so support all of them.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 doc/libnftables-json.adoc                     | 18 ++--
 src/json.c                                    | 19 +++-
 src/parser_json.c                             | 12 +++
 tests/py/inet/tcp.t.json                      | 50 +---------
 tests/py/inet/tcp.t.json.output               | 34 ++-----
 .../dumps/0012different_defines_0.json-nft    |  8 +-
 .../sets/dumps/0055tcpflags_0.json-nft        | 98 +++++--------------
 7 files changed, 75 insertions(+), 164 deletions(-)

diff --git a/doc/libnftables-json.adoc b/doc/libnftables-json.adoc
index 3948a0bad47c1..e3b24cc4ed60d 100644
--- a/doc/libnftables-json.adoc
+++ b/doc/libnftables-json.adoc
@@ -1343,15 +1343,17 @@ Perform kernel Forwarding Information Base lookups.
 
 === BINARY OPERATION
 [verse]
-*{ "|": [* 'EXPRESSION'*,* 'EXPRESSION' *] }*
-*{ "^": [* 'EXPRESSION'*,* 'EXPRESSION' *] }*
-*{ "&": [* 'EXPRESSION'*,* 'EXPRESSION' *] }*
-*{ "+<<+": [* 'EXPRESSION'*,* 'EXPRESSION' *] }*
-*{ ">>": [* 'EXPRESSION'*,* 'EXPRESSION' *] }*
-
-All binary operations expect an array of exactly two expressions, of which the
+*{ "|": [* 'EXPRESSION'*,* 'EXPRESSIONS' *] }*
+*{ "^": [* 'EXPRESSION'*,* 'EXPRESSIONS' *] }*
+*{ "&": [* 'EXPRESSION'*,* 'EXPRESSIONS' *] }*
+*{ "+<<+": [* 'EXPRESSION'*,* 'EXPRESSIONS' *] }*
+*{ ">>": [* 'EXPRESSION'*,* 'EXPRESSIONS' *] }*
+'EXPRESSIONS' := 'EXPRESSION' | 'EXPRESSION'*,* 'EXPRESSIONS'
+
+All binary operations expect an array of at least two expressions, of which the
 first element denotes the left hand side and the second one the right hand
-side.
+side. Extra elements are accepted in the given array and appended to the term
+accordingly.
 
 === VERDICT
 [verse]
diff --git a/src/json.c b/src/json.c
index 29fbd0cfdba28..3753017169930 100644
--- a/src/json.c
+++ b/src/json.c
@@ -540,11 +540,24 @@ json_t *flagcmp_expr_json(const struct expr *expr, struct output_ctx *octx)
 			 "right", expr_print_json(expr->flagcmp.value, octx));
 }
 
+static json_t *
+__binop_expr_json(int op, const struct expr *expr, struct output_ctx *octx)
+{
+	json_t *a = json_array();
+
+	if (expr->etype == EXPR_BINOP && expr->op == op) {
+		json_array_extend(a, __binop_expr_json(op, expr->left, octx));
+		json_array_extend(a, __binop_expr_json(op, expr->right, octx));
+	} else {
+		json_array_append_new(a, expr_print_json(expr, octx));
+	}
+	return a;
+}
+
 json_t *binop_expr_json(const struct expr *expr, struct output_ctx *octx)
 {
-	return json_pack("{s:[o, o]}", expr_op_symbols[expr->op],
-			 expr_print_json(expr->left, octx),
-			 expr_print_json(expr->right, octx));
+	return json_pack("{s:o}", expr_op_symbols[expr->op],
+			 __binop_expr_json(expr->op, expr, octx));
 }
 
 json_t *relational_expr_json(const struct expr *expr, struct output_ctx *octx)
diff --git a/src/parser_json.c b/src/parser_json.c
index 04255688ca04c..55d65c415bf5c 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -1204,6 +1204,18 @@ static struct expr *json_parse_binop_expr(struct json_ctx *ctx,
 		return NULL;
 	}
 
+	if (json_array_size(root) > 2) {
+		left = json_parse_primary_expr(ctx, json_array_get(root, 0));
+		right = json_parse_primary_expr(ctx, json_array_get(root, 1));
+		left = binop_expr_alloc(int_loc, thisop, left, right);
+		for (i = 2; i < json_array_size(root); i++) {
+			jright = json_array_get(root, i);
+			right = json_parse_primary_expr(ctx, jright);
+			left = binop_expr_alloc(int_loc, thisop, left, right);
+		}
+		return left;
+	}
+
 	if (json_unpack_err(ctx, root, "[o, o!]", &jleft, &jright))
 		return NULL;
 
diff --git a/tests/py/inet/tcp.t.json b/tests/py/inet/tcp.t.json
index 8439c2b5931dd..9a1b158e7ac0b 100644
--- a/tests/py/inet/tcp.t.json
+++ b/tests/py/inet/tcp.t.json
@@ -954,12 +954,12 @@
                         }
                     },
                     {
-                        "|": [ "fin", { "|": [ "syn", { "|": [ "rst", { "|": [ "psh", { "|": [ "ack", { "|": [ "urg", { "|": [ "ecn", "cwr" ] } ] } ] } ] } ] } ] } ]
+                        "|": [ "fin", "syn", "rst", "psh", "ack", "urg", "ecn", "cwr" ]
                     }
                 ]
             },
             "op": "==",
-            "right": { "|": [ "fin", { "|": [ "syn", { "|": [ "rst", { "|": [ "psh", { "|": [ "ack", { "|": [ "urg", { "|": [ "ecn", "cwr" ] } ] } ] } ] } ] } ] } ] }
+            "right": { "|": [ "fin", "syn", "rst", "psh", "ack", "urg", "ecn", "cwr" ] }
         }
     }
 ]
@@ -1395,55 +1395,15 @@
                             "protocol": "tcp"
                         }
                     },
-                    {
-                        "|": [
-                            {
-                                "|": [
-                                    {
-                                        "|": [
-                                            {
-                                                "|": [
-                                                    {
-                                                        "|": [
-                                                            "fin",
-                                                            "syn"
-                                                        ]
-                                                    },
-                                                    "rst"
-                                                ]
-                                            },
-                                            "psh"
-                                        ]
-                                    },
-                                    "ack"
-                                ]
-                            },
-                            "urg"
-                        ]
-                    }
+                    { "|": [ "fin", "syn", "rst", "psh", "ack", "urg" ] }
                 ]
             },
             "op": "==",
             "right": {
                 "set": [
-                    {
-                        "|": [
-                            {
-                                "|": [
-                                    "fin",
-                                    "psh"
-                                ]
-                            },
-                            "ack"
-                        ]
-                    },
+                    { "|": [ "fin", "psh", "ack" ] },
                     "fin",
-                    {
-                        "|": [
-                            "psh",
-                            "ack"
-                        ]
-                    },
+                    { "|": [ "psh", "ack" ] },
                     "ack"
                 ]
             }
diff --git a/tests/py/inet/tcp.t.json.output b/tests/py/inet/tcp.t.json.output
index c471e8d8dcef5..5a16714e9145d 100644
--- a/tests/py/inet/tcp.t.json.output
+++ b/tests/py/inet/tcp.t.json.output
@@ -155,27 +155,11 @@
                     },
                     {
                         "|": [
-                            {
-                                "|": [
-                                    {
-                                        "|": [
-                                            {
-                                                "|": [
-                                                    {
-                                                        "|": [
-                                                            "fin",
-                                                            "syn"
-                                                        ]
-                                                    },
-                                                    "rst"
-                                                ]
-                                            },
-                                            "psh"
-                                        ]
-                                    },
-                                    "ack"
-                                ]
-                            },
+                            "fin",
+                            "syn",
+                            "rst",
+                            "psh",
+                            "ack",
                             "urg"
                         ]
                     }
@@ -187,12 +171,8 @@
                     "fin",
                     {
                         "|": [
-                            {
-                                "|": [
-                                    "fin",
-                                    "psh"
-                                ]
-                            },
+                            "fin",
+                            "psh",
                             "ack"
                         ]
                     },
diff --git a/tests/shell/testcases/nft-f/dumps/0012different_defines_0.json-nft b/tests/shell/testcases/nft-f/dumps/0012different_defines_0.json-nft
index 8f3f3a81a9bc8..1b2e342047f4b 100644
--- a/tests/shell/testcases/nft-f/dumps/0012different_defines_0.json-nft
+++ b/tests/shell/testcases/nft-f/dumps/0012different_defines_0.json-nft
@@ -169,12 +169,8 @@
               },
               "right": {
                 "|": [
-                  {
-                    "|": [
-                      "established",
-                      "related"
-                    ]
-                  },
+                  "established",
+                  "related",
                   "new"
                 ]
               }
diff --git a/tests/shell/testcases/sets/dumps/0055tcpflags_0.json-nft b/tests/shell/testcases/sets/dumps/0055tcpflags_0.json-nft
index cd39f0909e120..6a3511515f785 100644
--- a/tests/shell/testcases/sets/dumps/0055tcpflags_0.json-nft
+++ b/tests/shell/testcases/sets/dumps/0055tcpflags_0.json-nft
@@ -27,39 +27,23 @@
         "elem": [
           {
             "|": [
-              {
-                "|": [
-                  {
-                    "|": [
-                      "fin",
-                      "psh"
-                    ]
-                  },
-                  "ack"
-                ]
-              },
+              "fin",
+              "psh",
+              "ack",
               "urg"
             ]
           },
           {
             "|": [
-              {
-                "|": [
-                  "fin",
-                  "psh"
-                ]
-              },
+              "fin",
+              "psh",
               "ack"
             ]
           },
           {
             "|": [
-              {
-                "|": [
-                  "fin",
-                  "ack"
-                ]
-              },
+              "fin",
+              "ack",
               "urg"
             ]
           },
@@ -71,39 +55,23 @@
           },
           {
             "|": [
-              {
-                "|": [
-                  {
-                    "|": [
-                      "syn",
-                      "psh"
-                    ]
-                  },
-                  "ack"
-                ]
-              },
+              "syn",
+              "psh",
+              "ack",
               "urg"
             ]
           },
           {
             "|": [
-              {
-                "|": [
-                  "syn",
-                  "psh"
-                ]
-              },
+              "syn",
+              "psh",
               "ack"
             ]
           },
           {
             "|": [
-              {
-                "|": [
-                  "syn",
-                  "ack"
-                ]
-              },
+              "syn",
+              "ack",
               "urg"
             ]
           },
@@ -116,39 +84,23 @@
           "syn",
           {
             "|": [
-              {
-                "|": [
-                  {
-                    "|": [
-                      "rst",
-                      "psh"
-                    ]
-                  },
-                  "ack"
-                ]
-              },
+              "rst",
+              "psh",
+              "ack",
               "urg"
             ]
           },
           {
             "|": [
-              {
-                "|": [
-                  "rst",
-                  "psh"
-                ]
-              },
+              "rst",
+              "psh",
               "ack"
             ]
           },
           {
             "|": [
-              {
-                "|": [
-                  "rst",
-                  "ack"
-                ]
-              },
+              "rst",
+              "ack",
               "urg"
             ]
           },
@@ -161,12 +113,8 @@
           "rst",
           {
             "|": [
-              {
-                "|": [
-                  "psh",
-                  "ack"
-                ]
-              },
+              "psh",
+              "ack",
               "urg"
             ]
           },
-- 
2.43.0


