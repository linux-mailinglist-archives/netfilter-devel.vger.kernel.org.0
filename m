Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF2530E2B5
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Feb 2021 19:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhBCSnX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Feb 2021 13:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbhBCSnW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:43:22 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1222C061786
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Feb 2021 10:42:42 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1l7N6v-0005wj-B0; Wed, 03 Feb 2021 19:42:41 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 3/3] evaluate: do not crash if dynamic set has no statements
Date:   Wed,  3 Feb 2021 19:42:27 +0100
Message-Id: <20210203184227.32208-3-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203184227.32208-1-fw@strlen.de>
References: <20210203184150.32145-1-fw@strlen.de>
 <20210203184227.32208-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

list_first_entry() returns garbage when the list is empty.
There is no need to run the following loop if we have no statements,
so just return 0.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 0b251ab5554c..2ddbde0a370f 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1363,10 +1363,12 @@ static int __expr_evaluate_set_elem(struct eval_ctx *ctx, struct expr *elem)
 					  "number of statements mismatch, set expects %d "
 					  "but element has %d", num_set_exprs,
 					  num_elem_exprs);
-		} else if (num_set_exprs == 0 && !(set->flags & NFT_SET_EVAL)) {
-			return expr_error(ctx->msgs, elem,
-					  "missing statements in %s definition",
-					  set_is_map(set->flags) ? "map" : "set");
+		} else if (num_set_exprs == 0) {
+			if (!(set->flags & NFT_SET_EVAL))
+				return expr_error(ctx->msgs, elem,
+						  "missing statements in %s definition",
+						  set_is_map(set->flags) ? "map" : "set");
+			return 0;
 		}
 
 		set_stmt = list_first_entry(&set->stmt_list, struct stmt, list);
-- 
2.26.2

