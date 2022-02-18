Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC80A4BB9F4
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Feb 2022 14:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiBRNRH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Feb 2022 08:17:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiBRNRH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:17:07 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B014283
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Feb 2022 05:16:50 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nL37w-00022e-2J; Fri, 18 Feb 2022 14:16:48 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH nf] netfilter: nf_tables: fix memory leak during stateful obj update
Date:   Fri, 18 Feb 2022 14:16:33 +0100
Message-Id: <20220218131633.2047-1-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

stateful objects can be updated from the control plane.
The transaction logic allocates a temporary object for this purpose.

This object has to be released via nft_obj_destroy, not kfree, since
the ->init function was called and it can have side effects beyond
memory allocation.

Fixes: d62d0ba97b58 ("netfilter: nf_tables: Introduce stateful object update operation")
Cc: Fernando Fernandez Mancera <ffmancera@riseup.net>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3081c4399f10..b867e023163c 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8185,7 +8185,7 @@ static void nft_obj_commit_update(struct nft_trans *trans)
 	if (obj->ops->update)
 		obj->ops->update(obj, newobj);
 
-	kfree(newobj);
+	nft_obj_destroy(&trans->ctx, newobj);
 }
 
 static void nft_commit_release(struct nft_trans *trans)
@@ -8976,7 +8976,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			break;
 		case NFT_MSG_NEWOBJ:
 			if (nft_trans_obj_update(trans)) {
-				kfree(nft_trans_obj_newobj(trans));
+				nft_obj_destroy(&trans->ctx, nft_trans_obj_newobj(trans));
 				nft_trans_destroy(trans);
 			} else {
 				trans->ctx.table->use--;
-- 
2.34.1

