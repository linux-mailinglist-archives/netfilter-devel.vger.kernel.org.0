Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCA13D649F
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jul 2021 18:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbhGZP76 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Jul 2021 11:59:58 -0400
Received: from mail.netfilter.org ([217.70.188.207]:33182 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbhGZP57 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:57:59 -0400
Received: from salvia.lan (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id 2B64C642A7
        for <netfilter-devel@vger.kernel.org>; Mon, 26 Jul 2021 18:37:57 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] evaluate: error reporting for missing statements in set/map declaration
Date:   Mon, 26 Jul 2021 18:38:21 +0200
Message-Id: <20210726163821.10869-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Assuming this map:

        map y {
                type ipv4_addr : verdict
        }

This patch slightly improves error reporting to refer to the missing
'counter' statement in the map declaration.

 # nft 'add element x y { 1.2.3.4 counter packets 1 bytes 1 : accept, * counter : drop }'
 Error: missing statement in map declaration
 add element x y { 1.2.3.4 counter packets 10 bytes 640 : accept, * counter : drop }
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 98309ea83ac0..4609576b2a61 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1351,10 +1351,12 @@ static int __expr_evaluate_set_elem(struct eval_ctx *ctx, struct expr *elem)
 					  "but element has %d", num_set_exprs,
 					  num_elem_exprs);
 		} else if (num_set_exprs == 0) {
-			if (!(set->flags & NFT_SET_EVAL))
-				return expr_error(ctx->msgs, elem,
-						  "missing statements in %s definition",
+			if (!(set->flags & NFT_SET_EVAL)) {
+				elem_stmt = list_first_entry(&elem->stmt_list, struct stmt, list);
+				return stmt_error(ctx, elem_stmt,
+						  "missing statement in %s declaration",
 						  set_is_map(set->flags) ? "map" : "set");
+			}
 			return 0;
 		}
 
-- 
2.20.1

