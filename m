Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657EB48F8B8
	for <lists+netfilter-devel@lfdr.de>; Sat, 15 Jan 2022 19:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiAOS1y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 15 Jan 2022 13:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiAOS1w (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 15 Jan 2022 13:27:52 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72F4C06173F
        for <netfilter-devel@vger.kernel.org>; Sat, 15 Jan 2022 10:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AjU1EmMX5cioAcBkO0GTVMC2nAdGcE3d0FtjpGhn7j0=; b=Znn0He6xZUdzyy79C7DrZtCwss
        6KOA/sB0loRemMRb9AHEVDGVhoYq19y2qdLBoItc8qBGRfYZ+8KcxWCDiDaVJo9Ek32wmm10Nip61
        T/oJ2aNLUsp+C9gXb1dkCBGWRX+QB+5yps/tpG+v3kyFr+ChIrv61ZHmN1aQoftspyNYmruzdHWqX
        F0B1l7Xnr1HVZcAPnH1pOVWBtu0akjyKEkH4RkH/NyuSYely7Qj3gj+WD8eYFelHILc0h4paHk0tj
        cCqzID4RqU3m/EUTe2yBtpqOpK9J//c9C2MxAlvi3/cezBEKoAazzwgdux0O3IfBZNdV1USwnltJd
        4pA7uTAQ==;
Received: from ulthar.dreamlands ([192.168.96.2] helo=ulthar.dreamlands.azazel.net)
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1n8nmH-008OQb-Kl; Sat, 15 Jan 2022 18:27:49 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [nft PATCH v2 3/5] src: store more than one payload dependency
Date:   Sat, 15 Jan 2022 18:27:07 +0000
Message-Id: <20220115182709.1999424-4-jeremy@azazel.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220115182709.1999424-1-jeremy@azazel.net>
References: <20220115182709.1999424-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 192.168.96.2
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Change the payload-dependency context to store a dependency for every
protocol layer.  This allows us to eliminate more redundant protocol
expressions.
---
 include/payload.h         | 13 +++++------
 src/netlink_delinearize.c | 14 +++++++----
 src/payload.c             | 49 ++++++++++++++++++++++++---------------
 3 files changed, 45 insertions(+), 31 deletions(-)

diff --git a/include/payload.h b/include/payload.h
index af6fa4782706..378699283c0a 100644
--- a/include/payload.h
+++ b/include/payload.h
@@ -25,16 +25,14 @@ extern int exthdr_gen_dependency(struct eval_ctx *ctx, const struct expr *expr,
 /**
  * struct payload_dep_ctx - payload protocol dependency tracking
  *
- * @pbase: protocol base of last dependency match
  * @icmp_type: extra info for icmp(6) decoding
- * @pdep: last dependency match
  * @prev: previous statement
+ * @pdeps: last dependency match per protocol layer
  */
 struct payload_dep_ctx {
-	enum proto_bases	pbase:8;
-	uint8_t			icmp_type;
-	struct stmt		*pdep;
-	struct stmt		*prev;
+	uint8_t		icmp_type;
+	struct stmt	*prev;
+	struct stmt	*pdeps[PROTO_BASE_MAX + 1];
 };
 
 extern bool payload_is_known(const struct expr *expr);
@@ -49,7 +47,8 @@ extern bool payload_dependency_exists(const struct payload_dep_ctx *ctx,
 				      enum proto_bases base);
 extern struct expr *payload_dependency_get(struct payload_dep_ctx *ctx,
 					   enum proto_bases base);
-extern void payload_dependency_release(struct payload_dep_ctx *ctx);
+extern void payload_dependency_release(struct payload_dep_ctx *ctx,
+				       enum proto_bases base);
 extern void payload_dependency_kill(struct payload_dep_ctx *ctx,
 				    struct expr *expr, unsigned int family);
 extern void exthdr_dependency_kill(struct payload_dep_ctx *ctx,
diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 5e474b321379..86b7006aaa71 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -2119,11 +2119,12 @@ static void ct_meta_common_postprocess(struct rule_pp_ctx *ctx,
 
 		relational_expr_pctx_update(&ctx->pctx, expr);
 
-		if (ctx->pdctx.pbase < PROTO_BASE_TRANSPORT_HDR) {
+		if (base < PROTO_BASE_TRANSPORT_HDR) {
 			if (payload_dependency_exists(&ctx->pdctx, base) &&
 			    meta_may_dependency_kill(&ctx->pdctx,
 						     ctx->pctx.family, expr))
-				payload_dependency_release(&ctx->pdctx);
+				payload_dependency_release(&ctx->pdctx, base);
+
 			if (left->flags & EXPR_F_PROTOCOL)
 				payload_dependency_store(&ctx->pdctx, ctx->stmt, base);
 		}
@@ -2653,7 +2654,8 @@ static void stmt_reject_postprocess(struct rule_pp_ctx *rctx)
 		if (stmt->reject.type == NFT_REJECT_TCP_RST &&
 		    payload_dependency_exists(&rctx->pdctx,
 					      PROTO_BASE_TRANSPORT_HDR))
-			payload_dependency_release(&rctx->pdctx);
+			payload_dependency_release(&rctx->pdctx,
+						   PROTO_BASE_TRANSPORT_HDR);
 		break;
 	case NFPROTO_IPV6:
 		stmt->reject.family = rctx->pctx.family;
@@ -2661,7 +2663,8 @@ static void stmt_reject_postprocess(struct rule_pp_ctx *rctx)
 		if (stmt->reject.type == NFT_REJECT_TCP_RST &&
 		    payload_dependency_exists(&rctx->pdctx,
 					      PROTO_BASE_TRANSPORT_HDR))
-			payload_dependency_release(&rctx->pdctx);
+			payload_dependency_release(&rctx->pdctx,
+						   PROTO_BASE_TRANSPORT_HDR);
 		break;
 	case NFPROTO_INET:
 	case NFPROTO_BRIDGE:
@@ -2695,7 +2698,8 @@ static void stmt_reject_postprocess(struct rule_pp_ctx *rctx)
 		}
 
 		if (payload_dependency_exists(&rctx->pdctx, PROTO_BASE_NETWORK_HDR))
-			payload_dependency_release(&rctx->pdctx);
+			payload_dependency_release(&rctx->pdctx,
+						   PROTO_BASE_NETWORK_HDR);
 		break;
 	default:
 		break;
diff --git a/src/payload.c b/src/payload.c
index accbe0ab6066..f433c38421a4 100644
--- a/src/payload.c
+++ b/src/payload.c
@@ -610,8 +610,7 @@ void payload_dependency_store(struct payload_dep_ctx *ctx,
 	if (ignore_dep)
 		return;
 
-	ctx->pdep  = stmt;
-	ctx->pbase = base + 1;
+	ctx->pdeps[base + 1] = stmt;
 }
 
 /**
@@ -626,9 +625,11 @@ void payload_dependency_store(struct payload_dep_ctx *ctx,
 bool payload_dependency_exists(const struct payload_dep_ctx *ctx,
 			       enum proto_bases base)
 {
-	return ctx->pbase != PROTO_BASE_INVALID &&
-	       ctx->pdep != NULL &&
-	       (ctx->pbase == base || (base == PROTO_BASE_TRANSPORT_HDR && ctx->pbase == base + 1));
+	if (ctx->pdeps[base])
+		return true;
+
+	return	base == PROTO_BASE_TRANSPORT_HDR &&
+		ctx->pdeps[PROTO_BASE_INNER_HDR];
 }
 
 /**
@@ -642,25 +643,35 @@ bool payload_dependency_exists(const struct payload_dep_ctx *ctx,
 struct expr *payload_dependency_get(struct payload_dep_ctx *ctx,
 				    enum proto_bases base)
 {
-	if (ctx->pbase == base)
-		return ctx->pdep->expr;
+	if (ctx->pdeps[base])
+		return ctx->pdeps[base]->expr;
 
 	if (base == PROTO_BASE_TRANSPORT_HDR &&
-	    ctx->pbase == PROTO_BASE_INNER_HDR)
-		return ctx->pdep->expr;
+	    ctx->pdeps[PROTO_BASE_INNER_HDR])
+		return ctx->pdeps[PROTO_BASE_INNER_HDR]->expr;
 
 	return NULL;
 }
 
-void payload_dependency_release(struct payload_dep_ctx *ctx)
+static void __payload_dependency_release(struct payload_dep_ctx *ctx,
+					 enum proto_bases base)
 {
-	list_del(&ctx->pdep->list);
-	stmt_free(ctx->pdep);
+	list_del(&ctx->pdeps[base]->list);
+	stmt_free(ctx->pdeps[base]);
 
-	ctx->pbase = PROTO_BASE_INVALID;
-	if (ctx->pdep == ctx->prev)
+	if (ctx->pdeps[base] == ctx->prev)
 		ctx->prev = NULL;
-	ctx->pdep  = NULL;
+	ctx->pdeps[base] = NULL;
+}
+
+void payload_dependency_release(struct payload_dep_ctx *ctx,
+				enum proto_bases base)
+{
+	if (ctx->pdeps[base])
+		__payload_dependency_release(ctx, base);
+	else if (base == PROTO_BASE_TRANSPORT_HDR &&
+		 ctx->pdeps[PROTO_BASE_INNER_HDR])
+		__payload_dependency_release(ctx, PROTO_BASE_INNER_HDR);
 }
 
 static uint8_t icmp_dep_to_type(enum icmp_hdr_field_type t)
@@ -786,7 +797,7 @@ void payload_dependency_kill(struct payload_dep_ctx *ctx, struct expr *expr,
 {
 	if (payload_dependency_exists(ctx, expr->payload.base) &&
 	    payload_may_dependency_kill(ctx, family, expr))
-		payload_dependency_release(ctx);
+		payload_dependency_release(ctx, expr->payload.base);
 }
 
 void exthdr_dependency_kill(struct payload_dep_ctx *ctx, struct expr *expr,
@@ -795,15 +806,15 @@ void exthdr_dependency_kill(struct payload_dep_ctx *ctx, struct expr *expr,
 	switch (expr->exthdr.op) {
 	case NFT_EXTHDR_OP_TCPOPT:
 		if (payload_dependency_exists(ctx, PROTO_BASE_TRANSPORT_HDR))
-			payload_dependency_release(ctx);
+			payload_dependency_release(ctx, PROTO_BASE_TRANSPORT_HDR);
 		break;
 	case NFT_EXTHDR_OP_IPV6:
 		if (payload_dependency_exists(ctx, PROTO_BASE_NETWORK_HDR))
-			payload_dependency_release(ctx);
+			payload_dependency_release(ctx, PROTO_BASE_NETWORK_HDR);
 		break;
 	case NFT_EXTHDR_OP_IPV4:
 		if (payload_dependency_exists(ctx, PROTO_BASE_NETWORK_HDR))
-			payload_dependency_release(ctx);
+			payload_dependency_release(ctx, PROTO_BASE_NETWORK_HDR);
 		break;
 	default:
 		break;
-- 
2.34.1

