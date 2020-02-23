Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C9F169722
	for <lists+netfilter-devel@lfdr.de>; Sun, 23 Feb 2020 11:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgBWKC3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 23 Feb 2020 05:02:29 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:44546 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbgBWKC3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 23 Feb 2020 05:02:29 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1j5o5k-0001Pp-3D; Sun, 23 Feb 2020 11:02:28 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] expression: use common code for expr_ops/expr_ops_by_type
Date:   Sun, 23 Feb 2020 11:02:20 +0100
Message-Id: <20200223100220.32597-1-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Useless duplication.  Also, this avoids bloating expr_ops_by_type()
when it needs to cope with more expressions.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/expression.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/src/expression.c b/src/expression.c
index cb11cda43792..c47b3673d19a 100644
--- a/src/expression.c
+++ b/src/expression.c
@@ -1185,9 +1185,9 @@ void range_expr_value_high(mpz_t rop, const struct expr *expr)
 	}
 }
 
-const struct expr_ops *expr_ops(const struct expr *e)
+static const struct expr_ops *__expr_ops_by_type(enum expr_types etype)
 {
-	switch (e->etype) {
+	switch (etype) {
 	case EXPR_INVALID:
 		BUG("Invalid expression ops requested");
 		break;
@@ -1220,26 +1220,18 @@ const struct expr_ops *expr_ops(const struct expr *e)
 	case EXPR_XFRM: return &xfrm_expr_ops;
 	}
 
-	BUG("Unknown expression type %d\n", e->etype);
+	BUG("Unknown expression type %d\n", etype);
 }
 
-const struct expr_ops *expr_ops_by_type(enum expr_types etype)
+const struct expr_ops *expr_ops(const struct expr *e)
 {
-	switch (etype) {
-	case EXPR_PAYLOAD: return &payload_expr_ops;
-	case EXPR_EXTHDR: return &exthdr_expr_ops;
-	case EXPR_META: return &meta_expr_ops;
-	case EXPR_SOCKET: return &socket_expr_ops;
-	case EXPR_OSF: return &osf_expr_ops;
-	case EXPR_CT: return &ct_expr_ops;
-	case EXPR_NUMGEN: return &numgen_expr_ops;
-	case EXPR_HASH: return &hash_expr_ops;
-	case EXPR_RT: return &rt_expr_ops;
-	case EXPR_FIB: return &fib_expr_ops;
-	case EXPR_XFRM: return &xfrm_expr_ops;
-	default:
-		break;
-	}
+	return __expr_ops_by_type(e->etype);
+}
 
-	BUG("Unknown expression type %d\n", etype);
+const struct expr_ops *expr_ops_by_type(uint32_t value)
+{
+	if (value > EXPR_XFRM)
+		return NULL;
+
+	return __expr_ops_by_type(value);
 }
-- 
2.24.1

