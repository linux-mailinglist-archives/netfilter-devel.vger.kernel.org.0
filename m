Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828D86D6573
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Apr 2023 16:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbjDDOeu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 Apr 2023 10:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjDDOeq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:34:46 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF7651734
        for <netfilter-devel@vger.kernel.org>; Tue,  4 Apr 2023 07:34:44 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/4] optimize: assert nat type on nat statement helper
Date:   Tue,  4 Apr 2023 16:34:34 +0200
Message-Id: <20230404143437.133493-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230404143437.133493-1-pablo@netfilter.org>
References: <20230404143437.133493-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add assert() to helper function to expression from NAT statement.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/optimize.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/optimize.c b/src/optimize.c
index 3548719031e6..e0154beb556d 100644
--- a/src/optimize.c
+++ b/src/optimize.c
@@ -855,6 +855,8 @@ static struct expr *stmt_nat_expr(struct stmt *nat_stmt)
 {
 	struct expr *nat_expr;
 
+	assert(nat_stmt->ops->type == STMT_NAT);
+
 	if (nat_stmt->nat.proto) {
 		nat_expr = concat_expr_alloc(&internal_location);
 		compound_expr_add(nat_expr, expr_get(nat_stmt->nat.addr));
@@ -865,6 +867,8 @@ static struct expr *stmt_nat_expr(struct stmt *nat_stmt)
 		nat_expr = expr_get(nat_stmt->nat.addr);
 	}
 
+	assert(nat_expr);
+
 	return nat_expr;
 }
 
-- 
2.30.2

