Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ED2586C59
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Aug 2022 15:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiHAN44 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Aug 2022 09:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiHAN4z (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:56:55 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A31C2DE8
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Aug 2022 06:56:54 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1oIVue-0000hR-CN; Mon, 01 Aug 2022 15:56:52 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>, Eric Garver <eric@garver.life>
Subject: [PATCH nft v2 3/8] proto: track full stack of seen l2 protocols, not just cumulative offset
Date:   Mon,  1 Aug 2022 15:56:28 +0200
Message-Id: <20220801135633.5317-4-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801135633.5317-1-fw@strlen.de>
References: <20220801135633.5317-1-fw@strlen.de>
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

For input, a cumulative size counter of all pushed l2 headers is enough,
because we have the full expression tree available to us.

For delinearization we need to track all seen l2 headers, else we lose
information that we might need at a later time.

Consider:

rule netdev nt nc set update ether saddr . vlan id

during delinearization, the vlan proto_desc replaces the ethernet one,
and by the time we try to split the concatenation apart we will search
the ether saddr offset vs. the templates for proto_vlan.

This replaces the offset with an array that stores the protocol
descriptions seen.

Then, if the payload offset is larger than our description, search the
l2 stack and adjust the offset until we're within the expected offset
boundary.

Reported-by: Eric Garver <eric@garver.life>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2: no changes.

 include/proto.h           |  3 +-
 src/evaluate.c            | 15 +++++++--
 src/netlink_delinearize.c |  5 ---
 src/payload.c             | 67 ++++++++++++++++++++++++++++++++-------
 src/proto.c               |  2 --
 5 files changed, 71 insertions(+), 21 deletions(-)

diff --git a/include/proto.h b/include/proto.h
index a04240a5de81..35e760c7e16e 100644
--- a/include/proto.h
+++ b/include/proto.h
@@ -193,13 +193,14 @@ struct proto_ctx {
 	struct {
 		struct location			location;
 		const struct proto_desc		*desc;
-		unsigned int			offset;
 		struct {
 			struct location		location;
 			const struct proto_desc	*desc;
 		} protos[PROTO_CTX_NUM_PROTOS];
 		unsigned int			num_protos;
 	} protocol[PROTO_BASE_MAX + 1];
+	const struct proto_desc *stacked_ll[PROTO_CTX_NUM_PROTOS];
+	uint8_t stacked_ll_count;
 };
 
 extern void proto_ctx_init(struct proto_ctx *ctx, unsigned int family,
diff --git a/src/evaluate.c b/src/evaluate.c
index 9ae525769bc3..be9fcd5117fb 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -678,7 +678,13 @@ static int resolve_protocol_conflict(struct eval_ctx *ctx,
 	    conflict_resolution_gen_dependency(ctx, link, payload, &nstmt) < 0)
 		return 1;
 
-	payload->payload.offset += ctx->pctx.protocol[base].offset;
+	if (base == PROTO_BASE_LL_HDR) {
+		unsigned int i;
+
+		for (i = 0; i < ctx->pctx.stacked_ll_count; i++)
+			payload->payload.offset += ctx->pctx.stacked_ll[i]->length;
+	}
+
 	rule_stmt_insert_at(ctx->rule, nstmt, ctx->stmt);
 
 	return 0;
@@ -727,7 +733,12 @@ static int __expr_evaluate_payload(struct eval_ctx *ctx, struct expr *expr)
 	if (desc == payload->payload.desc) {
 		const struct proto_hdr_template *tmpl;
 
-		payload->payload.offset += ctx->pctx.protocol[base].offset;
+		if (desc->base == PROTO_BASE_LL_HDR) {
+			unsigned int i;
+
+			for (i = 0; i < ctx->pctx.stacked_ll_count; i++)
+				payload->payload.offset += ctx->pctx.stacked_ll[i]->length;
+		}
 check_icmp:
 		if (desc != &proto_icmp && desc != &proto_icmp6)
 			return 0;
diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 42221f8ca526..8851043bf277 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -1977,11 +1977,6 @@ static void payload_match_postprocess(struct rule_pp_ctx *ctx,
 				      struct expr *expr,
 				      struct expr *payload)
 {
-	enum proto_bases base = payload->payload.base;
-
-	assert(payload->payload.offset >= ctx->pctx.protocol[base].offset);
-	payload->payload.offset -= ctx->pctx.protocol[base].offset;
-
 	switch (expr->op) {
 	case OP_EQ:
 	case OP_NEQ:
diff --git a/src/payload.c b/src/payload.c
index 66418cddb3b5..2c0d0ac9e8ae 100644
--- a/src/payload.c
+++ b/src/payload.c
@@ -116,8 +116,13 @@ static void payload_expr_pctx_update(struct proto_ctx *ctx,
 	if (desc->base == base->base) {
 		assert(base->length > 0);
 
-		if (!left->payload.is_raw)
-			ctx->protocol[base->base].offset += base->length;
+		if (!left->payload.is_raw) {
+			if (desc->base == PROTO_BASE_LL_HDR &&
+			    ctx->stacked_ll_count < PROTO_CTX_NUM_PROTOS) {
+				ctx->stacked_ll[ctx->stacked_ll_count] = base;
+				ctx->stacked_ll_count++;
+			}
+		}
 	}
 	proto_ctx_update(ctx, desc->base, loc, desc);
 }
@@ -869,6 +874,38 @@ void exthdr_dependency_kill(struct payload_dep_ctx *ctx, struct expr *expr,
 	}
 }
 
+static const struct proto_desc *get_stacked_desc(const struct proto_ctx *ctx,
+						 const struct proto_desc *top,
+						 const struct expr *e,
+						 unsigned int *skip)
+{
+	unsigned int i, total, payload_offset = e->payload.offset;
+
+	assert(e->etype == EXPR_PAYLOAD);
+
+	if (e->payload.base != PROTO_BASE_LL_HDR ||
+	    payload_offset < top->length) {
+		*skip = 0;
+		return top;
+	}
+
+	for (i = 0, total = 0; i < ctx->stacked_ll_count; i++) {
+		const struct proto_desc *stacked;
+
+		stacked = ctx->stacked_ll[i];
+		if (payload_offset < stacked->length) {
+			*skip = total;
+			return stacked;
+		}
+
+		payload_offset -= stacked->length;
+		total += stacked->length;
+	}
+
+	*skip = total;
+	return top;
+}
+
 /**
  * payload_expr_complete - fill in type information of a raw payload expr
  *
@@ -880,9 +917,10 @@ void exthdr_dependency_kill(struct payload_dep_ctx *ctx, struct expr *expr,
  */
 void payload_expr_complete(struct expr *expr, const struct proto_ctx *ctx)
 {
+	unsigned int payload_offset = expr->payload.offset;
 	const struct proto_desc *desc;
 	const struct proto_hdr_template *tmpl;
-	unsigned int i;
+	unsigned int i, total;
 
 	assert(expr->etype == EXPR_PAYLOAD);
 
@@ -891,9 +929,12 @@ void payload_expr_complete(struct expr *expr, const struct proto_ctx *ctx)
 		return;
 	assert(desc->base == expr->payload.base);
 
+	desc = get_stacked_desc(ctx, desc, expr, &total);
+	payload_offset -= total;
+
 	for (i = 0; i < array_size(desc->templates); i++) {
 		tmpl = &desc->templates[i];
-		if (tmpl->offset != expr->payload.offset ||
+		if (tmpl->offset != payload_offset ||
 		    tmpl->len    != expr->len)
 			continue;
 
@@ -950,6 +991,7 @@ bool payload_expr_trim(struct expr *expr, struct expr *mask,
 	unsigned int payload_len = expr->len;
 	const struct proto_desc *desc;
 	unsigned int off, i, len = 0;
+	unsigned int total;
 
 	assert(expr->etype == EXPR_PAYLOAD);
 
@@ -959,10 +1001,8 @@ bool payload_expr_trim(struct expr *expr, struct expr *mask,
 
 	assert(desc->base == expr->payload.base);
 
-	if (ctx->protocol[expr->payload.base].offset) {
-		assert(payload_offset >= ctx->protocol[expr->payload.base].offset);
-		payload_offset -= ctx->protocol[expr->payload.base].offset;
-	}
+	desc = get_stacked_desc(ctx, desc, expr, &total);
+	payload_offset -= total;
 
 	off = round_up(mask->len, BITS_PER_BYTE) - mask_len;
 	payload_offset += off;
@@ -1009,10 +1049,11 @@ bool payload_expr_trim(struct expr *expr, struct expr *mask,
 void payload_expr_expand(struct list_head *list, struct expr *expr,
 			 const struct proto_ctx *ctx)
 {
+	unsigned int payload_offset = expr->payload.offset;
 	const struct proto_hdr_template *tmpl;
 	const struct proto_desc *desc;
+	unsigned int i, total;
 	struct expr *new;
-	unsigned int i;
 
 	assert(expr->etype == EXPR_PAYLOAD);
 
@@ -1021,13 +1062,16 @@ void payload_expr_expand(struct list_head *list, struct expr *expr,
 		goto raw;
 	assert(desc->base == expr->payload.base);
 
+	desc = get_stacked_desc(ctx, desc, expr, &total);
+	payload_offset -= total;
+
 	for (i = 1; i < array_size(desc->templates); i++) {
 		tmpl = &desc->templates[i];
 
 		if (tmpl->len == 0)
 			break;
 
-		if (tmpl->offset != expr->payload.offset)
+		if (tmpl->offset != payload_offset)
 			continue;
 
 		if (tmpl->icmp_dep && ctx->th_dep.icmp.type &&
@@ -1039,6 +1083,7 @@ void payload_expr_expand(struct list_head *list, struct expr *expr,
 			list_add_tail(&new->list, list);
 			expr->len	     -= tmpl->len;
 			expr->payload.offset += tmpl->len;
+			payload_offset       += tmpl->len;
 			if (expr->len == 0)
 				return;
 		} else if (expr->len > 0) {
@@ -1051,7 +1096,7 @@ void payload_expr_expand(struct list_head *list, struct expr *expr,
 	}
 raw:
 	new = payload_expr_alloc(&expr->location, NULL, 0);
-	payload_init_raw(new, expr->payload.base, expr->payload.offset,
+	payload_init_raw(new, expr->payload.base, payload_offset,
 			 expr->len);
 	list_add_tail(&new->list, list);
 }
diff --git a/src/proto.c b/src/proto.c
index a013a00d2c7b..2663f216860b 100644
--- a/src/proto.c
+++ b/src/proto.c
@@ -160,8 +160,6 @@ static void proto_ctx_debug(const struct proto_ctx *ctx, enum proto_bases base,
 			 proto_base_names[i],
 			 ctx->protocol[i].desc ? ctx->protocol[i].desc->name :
 						 "none");
-		if (ctx->protocol[i].offset)
-			pr_debug(" (offset: %u)", ctx->protocol[i].offset);
 		if (i == base)
 			pr_debug(" <-");
 		pr_debug("\n");
-- 
2.35.1

