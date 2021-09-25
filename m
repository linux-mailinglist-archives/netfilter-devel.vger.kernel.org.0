Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965DA41847F
	for <lists+netfilter-devel@lfdr.de>; Sat, 25 Sep 2021 22:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhIYUsG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 25 Sep 2021 16:48:06 -0400
Received: from mail.netfilter.org ([217.70.188.207]:51758 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhIYUsF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 25 Sep 2021 16:48:05 -0400
Received: from localhost.localdomain (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id D2AB763EB1
        for <netfilter-devel@vger.kernel.org>; Sat, 25 Sep 2021 22:45:07 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] evaluate: provide a hint on missing dynamic flag
Date:   Sat, 25 Sep 2021 22:46:25 +0200
Message-Id: <20210925204625.22803-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Provide a hint to users if they forget to set on the dynamic flag, if
such set is updated from the packet path.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index 8ebc75617b1c..a0c67fb0e213 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3598,6 +3598,11 @@ static int stmt_evaluate_set(struct eval_ctx *ctx, struct stmt *stmt)
 		return expr_error(ctx->msgs, stmt->set.set,
 				  "Expression does not refer to a set");
 
+	if (!(stmt->set.set->set->flags & NFT_SET_EVAL))
+		return expr_error(ctx->msgs, stmt->set.set,
+				  "%s does not allow for dynamic updates, add 'flags dynamic' to your set declaration",
+				  stmt->set.set->set->flags & NFT_SET_MAP ? "map" : "set");
+
 	if (stmt_evaluate_arg(ctx, stmt,
 			      stmt->set.set->set->key->dtype,
 			      stmt->set.set->set->key->len,
-- 
2.30.2

