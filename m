Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1800F3794A6
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 May 2021 18:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhEJQ4K (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 May 2021 12:56:10 -0400
Received: from mail.netfilter.org ([217.70.188.207]:54332 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhEJQ4J (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 May 2021 12:56:09 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 80B7464164
        for <netfilter-devel@vger.kernel.org>; Mon, 10 May 2021 18:54:15 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nftables] evaluate: don't crash on set definition with incorrect datatype
Date:   Mon, 10 May 2021 18:55:00 +0200
Message-Id: <20210510165500.147706-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Cache updates have resurrected the bug described in 5afa5a164ff1
("evaluate: check for NULL datatype in rhs in lookup expr").

This is triggered by testcases/cache/0008_delete_by_handle_0.

Fixes: df48e56e987f ("cache: add hashtable cache for sets")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index e91d5236564e..75983b3c7a6a 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -262,7 +262,7 @@ static int expr_evaluate_symbol(struct eval_ctx *ctx, struct expr **expr)
 			return table_not_found(ctx);
 
 		set = set_cache_find(table, (*expr)->identifier);
-		if (set == NULL)
+		if (set == NULL || !set->key)
 			return set_not_found(ctx, &(*expr)->location,
 					     (*expr)->identifier);
 
-- 
2.30.2

