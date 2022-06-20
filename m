Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7585512D1
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Jun 2022 10:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbiFTIch (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jun 2022 04:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239825AbiFTIcb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:32:31 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0247E12A96
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Jun 2022 01:32:29 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 17/18] optimize: limit statement is not supported yet
Date:   Mon, 20 Jun 2022 10:32:14 +0200
Message-Id: <20220620083215.1021238-18-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220620083215.1021238-1-pablo@netfilter.org>
References: <20220620083215.1021238-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Revert support for limit statement, the limit statement is stateful and
it applies a ratelimit per rule, transformation for merging rules with
the limit statement needs to use anonymous sets with statements.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/optimize.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/src/optimize.c b/src/optimize.c
index c6b85d74d302..2340ef466fc0 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -197,14 +197,6 @@ static bool __stmt_type_eq(const struct stmt *stmt_a, const struct stmt *stmt_b,
 		    expr_b->etype == EXPR_MAP)
 			return __expr_cmp(expr_a->map, expr_b->map);
 		break;
-	case STMT_LIMIT:
-		if (stmt_a->limit.rate != stmt_b->limit.rate ||
-		    stmt_a->limit.unit != stmt_b->limit.unit ||
-		    stmt_a->limit.burst != stmt_b->limit.burst ||
-		    stmt_a->limit.type != stmt_b->limit.type ||
-		    stmt_a->limit.flags != stmt_b->limit.flags)
-			return false;
-		break;
 	case STMT_LOG:
 		if (stmt_a->log.snaplen != stmt_b->log.snaplen ||
 		    stmt_a->log.group != stmt_b->log.group ||
@@ -322,7 +314,6 @@ static bool stmt_type_find(struct optimize_ctx *ctx, const struct stmt *stmt)
 	case STMT_VERDICT:
 	case STMT_COUNTER:
 	case STMT_NOTRACK:
-	case STMT_LIMIT:
 	case STMT_LOG:
 	case STMT_NAT:
 	case STMT_REJECT:
@@ -367,9 +358,6 @@ static int rule_collect_stmts(struct optimize_ctx *ctx, struct rule *rule)
 		case STMT_COUNTER:
 		case STMT_NOTRACK:
 			break;
-		case STMT_LIMIT:
-			memcpy(&clone->limit, &stmt->limit, sizeof(clone->limit));
-			break;
 		case STMT_LOG:
 			memcpy(&clone->log, &stmt->log, sizeof(clone->log));
 			if (stmt->log.prefix)
-- 
2.30.2

