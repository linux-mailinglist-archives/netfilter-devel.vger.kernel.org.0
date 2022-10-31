Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9B7613458
	for <lists+netfilter-devel@lfdr.de>; Mon, 31 Oct 2022 12:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJaLQ0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 31 Oct 2022 07:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJaLQZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:16:25 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C0E0DF17
        for <netfilter-devel@vger.kernel.org>; Mon, 31 Oct 2022 04:16:24 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] netlink_delinearize: complete payload expression in payload statement
Date:   Mon, 31 Oct 2022 12:16:15 +0100
Message-Id: <20221031111616.96702-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Call payload_expr_complete() to complete payload expression in payload
statement, otherwise expr->payload.desc is set to proto_unknown.

Call stmt_payload_binop_postprocess() introduced by 50ca788ca4d0
("netlink: decode payload statment") if payload_expr_complete() fails to
provide a protocol description (eg. ip dscp).

Follow up patch do not allow to remove redundant payload dependency if
proto_unknown is set to deal with the raw payload expression case.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/netlink_delinearize.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 828ad12d7536..0b6cf1072294 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -2995,15 +2995,16 @@ static void stmt_payload_postprocess(struct rule_pp_ctx *ctx)
 {
 	struct stmt *stmt = ctx->stmt;
 
+	payload_expr_complete(stmt->payload.expr, &ctx->pctx);
+	if (!payload_is_known(stmt->payload.expr))
+		stmt_payload_binop_postprocess(ctx);
+
 	expr_postprocess(ctx, &stmt->payload.expr);
 
 	expr_set_type(stmt->payload.val,
 		      stmt->payload.expr->dtype,
 		      stmt->payload.expr->byteorder);
 
-	if (!payload_is_known(stmt->payload.expr))
-		stmt_payload_binop_postprocess(ctx);
-
 	expr_postprocess(ctx, &stmt->payload.val);
 }
 
-- 
2.30.2

