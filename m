Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A1278C840
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Aug 2023 17:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjH2PEV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Aug 2023 11:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237185AbjH2PEQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:04:16 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF3A7C9
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Aug 2023 08:04:13 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nft] evaluate: do not remove anonymous set with protocol flags and single element
Date:   Tue, 29 Aug 2023 17:04:08 +0200
Message-Id: <20230829150408.42355-1-pablo@netfilter.org>
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

Set lookups with flags search for an exact match, however:

	tcp flags { syn }

gets transformed into:

	tcp flags syn

which is matching on the syn flag only (non-exact match).

This optimization is safe for ct state though, because only one bit is
ever set on in the ct state bitmask.

Since protocol flags allow for combining flags, skip this optimization
to retain exact match semantics.

Another possible solution is to turn OP_IMPLICIT into OP_EQ for exact
flag match to re-introduce this optimization to deal with this corner
case.

Fixes: fee6bda06403 ("evaluate: remove anon sets with exactly one element")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 1ae2ef0de10c..39b0077ce99e 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1817,7 +1817,12 @@ static int expr_evaluate_set(struct eval_ctx *ctx, struct expr **expr)
 			set->set_flags |= NFT_SET_CONCAT;
 	} else if (set->size == 1) {
 		i = list_first_entry(&set->expressions, struct expr, list);
-		if (i->etype == EXPR_SET_ELEM && list_empty(&i->stmt_list)) {
+		if (i->etype == EXPR_SET_ELEM &&
+		    (!i->dtype->basetype ||
+		     i->dtype->basetype->type != TYPE_BITMASK ||
+		     i->dtype->type == TYPE_CT_STATE) &&
+		    list_empty(&i->stmt_list)) {
+
 			switch (i->key->etype) {
 			case EXPR_PREFIX:
 			case EXPR_RANGE:
-- 
2.30.2

