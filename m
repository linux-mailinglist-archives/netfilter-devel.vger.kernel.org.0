Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A586017CAC2
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 Mar 2020 03:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCGC0t (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Mar 2020 21:26:49 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:36980 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgCGC0t (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Mar 2020 21:26:49 -0500
Received: from localhost ([::1]:50070 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jAPAt-0001Y8-EV; Sat, 07 Mar 2020 03:26:47 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Eric Garver <e@erig.me>, netfilter-devel@vger.kernel.org
Subject: [nft PATCH v2 1/2] parser_json: Support ranges in concat expressions
Date:   Sat,  7 Mar 2020 03:26:32 +0100
Message-Id: <20200307022633.6181-1-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Duplicate commit 8ac2f3b2fca38's changes to bison parser into JSON
parser by introducing a new context flag signalling we're parsing
concatenated expressions.

Fixes: 8ac2f3b2fca38 ("src: Add support for concatenated set ranges")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v1:
- Fix accidental reject of concat expressions on LHS.
---
 src/parser_json.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/src/parser_json.c b/src/parser_json.c
index 85082ccee7ef6..480b15aeb2507 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -40,6 +40,7 @@
 #define CTX_F_MANGLE	(1 << 5)
 #define CTX_F_SES	(1 << 6)	/* set_elem_expr_stmt */
 #define CTX_F_MAP	(1 << 7)	/* LHS of map_expr */
+#define CTX_F_CONCAT	(1 << 8)	/* inside concat_expr */
 
 struct json_ctx {
 	struct input_descriptor indesc;
@@ -99,6 +100,7 @@ static struct expr *json_parse_primary_expr(struct json_ctx *ctx, json_t *root);
 static struct expr *json_parse_set_rhs_expr(struct json_ctx *ctx, json_t *root);
 static struct expr *json_parse_set_elem_expr_stmt(struct json_ctx *ctx, json_t *root);
 static struct expr *json_parse_map_lhs_expr(struct json_ctx *ctx, json_t *root);
+static struct expr *json_parse_concat_elem_expr(struct json_ctx *ctx, json_t *root);
 static struct stmt *json_parse_stmt(struct json_ctx *ctx, json_t *root);
 
 /* parsing helpers */
@@ -1058,7 +1060,7 @@ static struct expr *json_parse_concat_expr(struct json_ctx *ctx,
 	}
 
 	json_array_foreach(root, index, value) {
-		tmp = json_parse_primary_expr(ctx, value);
+		tmp = json_parse_concat_elem_expr(ctx, value);
 		if (!tmp) {
 			json_error(ctx, "Parsing expr at index %zd failed.", index);
 			expr_free(expr);
@@ -1354,28 +1356,28 @@ static struct expr *json_parse_expr(struct json_ctx *ctx, json_t *root)
 		{ "set", json_parse_set_expr, CTX_F_RHS | CTX_F_STMT }, /* allow this as stmt expr because that allows set references */
 		{ "map", json_parse_map_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS },
 		/* below three are multiton_rhs_expr */
-		{ "prefix", json_parse_prefix_expr, CTX_F_RHS | CTX_F_STMT },
-		{ "range", json_parse_range_expr, CTX_F_RHS | CTX_F_STMT },
-		{ "payload", json_parse_payload_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_MANGLE | CTX_F_SES | CTX_F_MAP },
-		{ "exthdr", json_parse_exthdr_expr, CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP },
+		{ "prefix", json_parse_prefix_expr, CTX_F_RHS | CTX_F_STMT | CTX_F_CONCAT },
+		{ "range", json_parse_range_expr, CTX_F_RHS | CTX_F_STMT | CTX_F_CONCAT },
+		{ "payload", json_parse_payload_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_MANGLE | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
+		{ "exthdr", json_parse_exthdr_expr, CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
 		{ "tcp option", json_parse_tcp_option_expr, CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_MANGLE | CTX_F_SES },
 		{ "ip option", json_parse_ip_option_expr, CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_MANGLE | CTX_F_SES },
-		{ "meta", json_parse_meta_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_MANGLE | CTX_F_SES | CTX_F_MAP },
-		{ "osf", json_parse_osf_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_MAP },
-		{ "ipsec", json_parse_xfrm_expr, CTX_F_PRIMARY | CTX_F_MAP },
-		{ "socket", json_parse_socket_expr, CTX_F_PRIMARY },
-		{ "rt", json_parse_rt_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP },
-		{ "ct", json_parse_ct_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_MANGLE | CTX_F_SES | CTX_F_MAP },
-		{ "numgen", json_parse_numgen_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP },
+		{ "meta", json_parse_meta_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_MANGLE | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
+		{ "osf", json_parse_osf_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_MAP | CTX_F_CONCAT },
+		{ "ipsec", json_parse_xfrm_expr, CTX_F_PRIMARY | CTX_F_MAP | CTX_F_CONCAT },
+		{ "socket", json_parse_socket_expr, CTX_F_PRIMARY | CTX_F_CONCAT },
+		{ "rt", json_parse_rt_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
+		{ "ct", json_parse_ct_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_MANGLE | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
+		{ "numgen", json_parse_numgen_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
 		/* below two are hash expr */
-		{ "jhash", json_parse_hash_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP },
-		{ "symhash", json_parse_hash_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP },
-		{ "fib", json_parse_fib_expr, CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP },
-		{ "|", json_parse_binop_expr, CTX_F_RHS | CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP },
-		{ "^", json_parse_binop_expr, CTX_F_RHS | CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP },
-		{ "&", json_parse_binop_expr, CTX_F_RHS | CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP },
-		{ ">>", json_parse_binop_expr, CTX_F_RHS | CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP },
-		{ "<<", json_parse_binop_expr, CTX_F_RHS | CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP },
+		{ "jhash", json_parse_hash_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
+		{ "symhash", json_parse_hash_expr, CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
+		{ "fib", json_parse_fib_expr, CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
+		{ "|", json_parse_binop_expr, CTX_F_RHS | CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
+		{ "^", json_parse_binop_expr, CTX_F_RHS | CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
+		{ "&", json_parse_binop_expr, CTX_F_RHS | CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
+		{ ">>", json_parse_binop_expr, CTX_F_RHS | CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
+		{ "<<", json_parse_binop_expr, CTX_F_RHS | CTX_F_STMT | CTX_F_PRIMARY | CTX_F_SET_RHS | CTX_F_SES | CTX_F_MAP | CTX_F_CONCAT },
 		{ "accept", json_parse_verdict_expr, CTX_F_RHS | CTX_F_SET_RHS },
 		{ "drop", json_parse_verdict_expr, CTX_F_RHS | CTX_F_SET_RHS },
 		{ "continue", json_parse_verdict_expr, CTX_F_RHS | CTX_F_SET_RHS },
@@ -1500,6 +1502,11 @@ static struct expr *json_parse_map_lhs_expr(struct json_ctx *ctx, json_t *root)
 	return json_parse_flagged_expr(ctx, CTX_F_MAP, root);
 }
 
+static struct expr *json_parse_concat_elem_expr(struct json_ctx *ctx, json_t *root)
+{
+	return json_parse_flagged_expr(ctx, CTX_F_CONCAT, root);
+}
+
 static struct expr *json_parse_dtype_expr(struct json_ctx *ctx, json_t *root)
 {
 	if (json_is_string(root)) {
-- 
2.25.1

