Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B95D11229DA
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Dec 2019 12:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfLQL1Y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Dec 2019 06:27:24 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:57318 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbfLQL1Y (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:27:24 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ihB0c-0006k4-99; Tue, 17 Dec 2019 12:27:22 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft v3 01/10] parser: add a helper for concat expression handling
Date:   Tue, 17 Dec 2019 12:27:04 +0100
Message-Id: <20191217112713.6017-2-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217112713.6017-1-fw@strlen.de>
References: <20191217112713.6017-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Cull the repeated copy&paste snippets and add/use a helper for this.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/parser_bison.y | 99 ++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 56 deletions(-)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 707f46716ed3..0fd9b94c5b2f 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -102,6 +102,25 @@ static void location_update(struct location *loc, struct location *rhs, int n)
 	}
 }
 
+static struct expr *handle_concat_expr(const struct location *loc,
+					 struct expr *expr,
+					 struct expr *expr_l, struct expr *expr_r,
+					 struct location loc_rhs[3])
+{
+	if (expr->etype != EXPR_CONCAT) {
+		expr = concat_expr_alloc(loc);
+		compound_expr_add(expr, expr_l);
+	} else {
+		location_update(&expr_r->location, loc_rhs, 2);
+
+		expr = expr_l;
+		expr->location = *loc;
+	}
+
+	compound_expr_add(expr, expr_r);
+	return expr;
+}
+
 #define YYLLOC_DEFAULT(Current, Rhs, N)	location_update(&Current, Rhs, N)
 
 #define symbol_value(loc, str) \
@@ -1878,20 +1897,12 @@ data_type_atom_expr	:	type_identifier
 data_type_expr		:	data_type_atom_expr
 			|	data_type_expr	DOT	data_type_atom_expr
 			{
-				if ($1->etype != EXPR_CONCAT) {
-					$$ = concat_expr_alloc(&@$);
-					compound_expr_add($$, $1);
-				} else {
-					struct location rhs[] = {
-						[1]	= @2,
-						[2]	= @3,
-					};
-					location_update(&$3->location, rhs, 2);
-
-					$$ = $1;
-					$$->location = @$;
-				}
-				compound_expr_add($$, $3);
+				struct location rhs[] = {
+					[1]	= @2,
+					[2]	= @3,
+				};
+
+				$$ = handle_concat_expr(&@$, $$, $1, $3, rhs);
 			}
 			;
 
@@ -2992,20 +3003,12 @@ basic_stmt_expr		:	inclusive_or_stmt_expr
 concat_stmt_expr	:	basic_stmt_expr
 			|	concat_stmt_expr	DOT	primary_stmt_expr
 			{
-				if ($$->etype != EXPR_CONCAT) {
-					$$ = concat_expr_alloc(&@$);
-					compound_expr_add($$, $1);
-				} else {
-					struct location rhs[] = {
-						[1]	= @2,
-						[2]	= @3,
-					};
-					location_update(&$3->location, rhs, 2);
-
-					$$ = $1;
-					$$->location = @$;
-				}
-				compound_expr_add($$, $3);
+				struct location rhs[] = {
+					[1]	= @2,
+					[2]	= @3,
+				};
+
+				$$ = handle_concat_expr(&@$, $$, $1, $3, rhs);
 			}
 			;
 
@@ -3525,20 +3528,12 @@ basic_expr		:	inclusive_or_expr
 concat_expr		:	basic_expr
 			|	concat_expr		DOT		basic_expr
 			{
-				if ($$->etype != EXPR_CONCAT) {
-					$$ = concat_expr_alloc(&@$);
-					compound_expr_add($$, $1);
-				} else {
-					struct location rhs[] = {
-						[1]	= @2,
-						[2]	= @3,
-					};
-					location_update(&$3->location, rhs, 2);
-
-					$$ = $1;
-					$$->location = @$;
-				}
-				compound_expr_add($$, $3);
+				struct location rhs[] = {
+					[1]	= @2,
+					[2]	= @3,
+				};
+
+				$$ = handle_concat_expr(&@$, $$, $1, $3, rhs);
 			}
 			;
 
@@ -3946,20 +3941,12 @@ basic_rhs_expr		:	inclusive_or_rhs_expr
 concat_rhs_expr		:	basic_rhs_expr
 			|	concat_rhs_expr	DOT	basic_rhs_expr
 			{
-				if ($$->etype != EXPR_CONCAT) {
-					$$ = concat_expr_alloc(&@$);
-					compound_expr_add($$, $1);
-				} else {
-					struct location rhs[] = {
-						[1]	= @2,
-						[2]	= @3,
-					};
-					location_update(&$3->location, rhs, 2);
-
-					$$ = $1;
-					$$->location = @$;
-				}
-				compound_expr_add($$, $3);
+				struct location rhs[] = {
+					[1]	= @2,
+					[2]	= @3,
+				};
+
+				$$ = handle_concat_expr(&@$, $$, $1, $3, rhs);
 			}
 			;
 
-- 
2.24.1

