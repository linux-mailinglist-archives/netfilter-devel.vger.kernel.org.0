Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639023A85F6
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Jun 2021 18:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFOQEY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Jun 2021 12:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhFOQEM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:04:12 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F51C061574
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Jun 2021 09:02:07 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ltBVt-0001K9-R0; Tue, 15 Jun 2021 18:02:05 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft v2 2/3] payload: do not remove icmp echo dependency
Date:   Tue, 15 Jun 2021 18:01:50 +0200
Message-Id: <20210615160151.10594-3-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615160151.10594-1-fw@strlen.de>
References: <20210615160151.10594-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

"icmp type echo-request icmp id 2" and "icmp id 2" are not the same,
the latter gains an implicit dependency on both echo-request and
echo-reply.

Change payload dependency tracking to not store dependency in case
the value type is ICMP(6)_ECHO(REPLY).

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/payload.c | 61 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/src/payload.c b/src/payload.c
index cfa952248a15..97b60713e800 100644
--- a/src/payload.c
+++ b/src/payload.c
@@ -98,12 +98,16 @@ static void payload_expr_pctx_update(struct proto_ctx *ctx,
 	desc = proto_find_upper(base, proto);
 
 	if (!desc) {
-		if (base == &proto_icmp || base == &proto_icmp6) {
+		if (base == &proto_icmp) {
 			/* proto 0 is ECHOREPLY, just pretend its ECHO.
 			 * Not doing this would need an additional marker
 			 * bit to tell when icmp.type was set.
 			 */
 			ctx->th_dep.icmp.type = proto ? proto : ICMP_ECHO;
+		} else if (base == &proto_icmp6) {
+			if (proto == ICMP6_ECHO_REPLY)
+				proto = ICMP6_ECHO_REQUEST;
+			ctx->th_dep.icmp.type = proto;
 		}
 		return;
 	}
@@ -554,33 +558,39 @@ void payload_dependency_reset(struct payload_dep_ctx *ctx)
 	memset(ctx, 0, sizeof(*ctx));
 }
 
-static uint8_t icmp_get_type(const struct proto_desc *desc, uint8_t value)
+static bool payload_dependency_store_icmp_type(struct payload_dep_ctx *ctx,
+					       const struct stmt *stmt)
 {
-	if (desc == &proto_icmp && value == 0)
-		return ICMP_ECHO;
+	struct expr *dep = stmt->expr;
+	const struct proto_desc *desc;
+	const struct expr *right;
+	uint8_t type;
 
-	return value;
-}
+	if (dep->left->etype != EXPR_PAYLOAD)
+		return false;
 
-static uint8_t icmp_get_dep_type(const struct proto_desc *desc, struct expr *right)
-{
-	if (right->etype == EXPR_VALUE && right->len == BITS_PER_BYTE)
-		return icmp_get_type(desc, mpz_get_uint8(right->value));
+	right = dep->right;
+	if (right->etype != EXPR_VALUE || right->len != BITS_PER_BYTE)
+		return false;
 
-	return 0;
-}
+	desc = dep->left->payload.desc;
+	if (desc == &proto_icmp) {
+		type = mpz_get_uint8(right->value);
 
-static void payload_dependency_store_icmp_type(struct payload_dep_ctx *ctx)
-{
-	struct expr *dep = ctx->pdep->expr;
-	const struct proto_desc *desc;
+		if (type == ICMP_ECHOREPLY)
+			type = ICMP_ECHO;
 
-	if (dep->left->etype != EXPR_PAYLOAD)
-		return;
+		ctx->icmp_type = type;
 
-	desc = dep->left->payload.desc;
-	if (desc == &proto_icmp || desc == &proto_icmp6)
-		ctx->icmp_type = icmp_get_dep_type(dep->left->payload.desc, dep->right);
+		return type == ICMP_ECHO;
+	} else if (desc == &proto_icmp6) {
+		type = mpz_get_uint8(right->value);
+
+		ctx->icmp_type = type;
+		return type == ICMP6_ECHO_REQUEST || type == ICMP6_ECHO_REPLY;
+	}
+
+	return false;
 }
 
 /**
@@ -593,10 +603,13 @@ static void payload_dependency_store_icmp_type(struct payload_dep_ctx *ctx)
 void payload_dependency_store(struct payload_dep_ctx *ctx,
 			      struct stmt *stmt, enum proto_bases base)
 {
-	ctx->pbase = base + 1;
-	ctx->pdep  = stmt;
+	bool ignore_dep = payload_dependency_store_icmp_type(ctx, stmt);
+
+	if (ignore_dep)
+		return;
 
-	payload_dependency_store_icmp_type(ctx);
+	ctx->pdep  = stmt;
+	ctx->pbase = base + 1;
 }
 
 /**
-- 
2.31.1

