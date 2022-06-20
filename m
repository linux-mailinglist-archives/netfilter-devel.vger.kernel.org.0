Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A29C5512DC
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Jun 2022 10:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbiFTIcd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jun 2022 04:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbiFTIc3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:32:29 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAB0912A90
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Jun 2022 01:32:27 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 11/18] optimize: add numgen expression support
Date:   Mon, 20 Jun 2022 10:32:08 +0200
Message-Id: <20220620083215.1021238-12-pablo@netfilter.org>
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

Extend expr_cmp() to compare numgen expressions used in relational.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/optimize.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/optimize.c b/src/optimize.c
index 54dde948876f..1fa46cb6a663 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -99,6 +99,14 @@ static bool __expr_cmp(const struct expr *expr_a, const struct expr *expr_b)
 		if (expr_a->fib.result != expr_b->fib.result)
 			return false;
 		break;
+	case EXPR_NUMGEN:
+		if (expr_a->numgen.type != expr_b->numgen.type)
+			return false;
+		if (expr_a->numgen.mod != expr_b->numgen.mod)
+			return false;
+		if (expr_a->numgen.offset != expr_b->numgen.offset)
+			return false;
+		break;
 	case EXPR_BINOP:
 		return __expr_cmp(expr_a->left, expr_b->left);
 	default:
-- 
2.30.2

