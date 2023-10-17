Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3877CC532
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Oct 2023 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjJQNww (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Oct 2023 09:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjJQNww (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:52:52 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60332F0
        for <netfilter-devel@vger.kernel.org>; Tue, 17 Oct 2023 06:52:50 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] evaluate: validate maximum log statement prefix length
Date:   Tue, 17 Oct 2023 15:52:46 +0200
Message-Id: <20231017135246.16991-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Otherwise too long string overruns the log prefix buffer.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1714
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index b7ae9113b5a8..2196e92813d0 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -4175,8 +4175,13 @@ static int stmt_evaluate_log_prefix(struct eval_ctx *ctx, struct stmt *stmt)
 	size_t offset = 0;
 	struct expr *expr;
 
-	if (stmt->log.prefix->etype != EXPR_LIST)
+	if (stmt->log.prefix->etype != EXPR_LIST) {
+		if (stmt->log.prefix &&
+		    div_round_up(stmt->log.prefix->len, BITS_PER_BYTE) >= NF_LOG_PREFIXLEN)
+			return expr_error(ctx->msgs, stmt->log.prefix, "log prefix is too long");
+
 		return 0;
+	}
 
 	prefix[0] = '\0';
 
-- 
2.30.2

