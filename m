Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78D9BEB6D4
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Oct 2019 19:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfJaSVf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Oct 2019 14:21:35 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:47724 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfJaSVf (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:21:35 -0400
Received: from localhost ([::1]:60814 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iQF4f-0008O7-Eu; Thu, 31 Oct 2019 19:21:33 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] evaluate: Reject set references in mapping LHS
Date:   Thu, 31 Oct 2019 19:21:24 +0100
Message-Id: <20191031182124.11393-1-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This wasn't explicitly caught before causing a program abort:

| BUG: invalid range expression type set reference
| nft: expression.c:1162: range_expr_value_low: Assertion `0' failed.
| zsh: abort      sudo ./install/sbin/nft add rule t c meta mark set tcp dport map '{ @s : 23 }

With this patch in place, the error message is way more descriptive:

| Error: Key can't be set reference
| add rule t c meta mark set tcp dport map { @s : 23 }
|                                            ^^

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/evaluate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index 81230fc7f4be4..500780aeae243 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1456,6 +1456,10 @@ static int expr_evaluate_mapping(struct eval_ctx *ctx, struct expr **expr)
 	if (!expr_is_constant(mapping->left))
 		return expr_error(ctx->msgs, mapping->left,
 				  "Key must be a constant");
+	if (mapping->left->etype == EXPR_SET_ELEM &&
+	    mapping->left->key->etype == EXPR_SET_REF)
+		return expr_error(ctx->msgs, mapping->left,
+				  "Key can't be set reference");
 	mapping->flags |= mapping->left->flags & EXPR_F_SINGLETON;
 
 	expr_set_context(&ctx->ectx, set->datatype, set->datalen);
-- 
2.23.0

