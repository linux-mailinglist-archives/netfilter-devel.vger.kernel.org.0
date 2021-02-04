Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FF130E05E
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Feb 2021 18:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhBCQ7z (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Feb 2021 11:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhBCQ6K (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:58:10 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B381C061788
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Feb 2021 08:57:30 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1l7LT7-0005Lh-0l; Wed, 03 Feb 2021 17:57:29 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 3/3] evaluate: set evaluation context for set elements
Date:   Wed,  3 Feb 2021 17:57:07 +0100
Message-Id: <20210203165707.21781-5-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203165707.21781-1-fw@strlen.de>
References: <20210203165707.21781-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This resolves same issue as previous patch when such
expression is used as a set key:

        set z {
                typeof ct zone
-               elements = { 1, 512, 768, 1024, 1280, 1536 }
+               elements = { 1, 2, 3, 4, 5, 6 }
        }

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 123fc7ab1a28..0b251ab5554c 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1391,8 +1391,15 @@ static int expr_evaluate_set_elem(struct eval_ctx *ctx, struct expr **expr)
 {
 	struct expr *elem = *expr;
 
-	if (ctx->set && __expr_evaluate_set_elem(ctx, elem) < 0)
-		return -1;
+	if (ctx->set) {
+		const struct expr *key;
+
+		if (__expr_evaluate_set_elem(ctx, elem) < 0)
+			return -1;
+
+		key = ctx->set->key;
+		__expr_set_context(&ctx->ectx, key->dtype, key->byteorder, key->len, 0);
+	}
 
 	if (expr_evaluate(ctx, &elem->key) < 0)
 		return -1;
-- 
2.26.2

