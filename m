Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D587CDA27
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Oct 2023 13:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjJRLSs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Oct 2023 07:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRLSr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:18:47 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 376AAFE
        for <netfilter-devel@vger.kernel.org>; Wed, 18 Oct 2023 04:18:46 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nf] Revert "netfilter: nf_tables: do not remove elements if set backend implements .abort"
Date:   Wed, 18 Oct 2023 13:18:39 +0200
Message-Id: <20231018111839.1702-1-pablo@netfilter.org>
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

Revert b311ecfb7ba0 ("netfilter: nf_tables: do not remove elements if
set backend implements .abort").

nf_tables_abort_release() path calls nft_set_elem_destroy() for
NFT_MSG_NEWSETELEM which releases the element, however, a reference to
the element still remains in the working copy.

Fixes: b311ecfb7ba0 ("netfilter: nf_tables: do not remove elements if set backend implements .abort").
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a623d31b6518..00b21b3ff318 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -10339,10 +10339,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 				break;
 			}
 			te = (struct nft_trans_elem *)trans->data;
-			if (!te->set->ops->abort ||
-			    nft_setelem_is_catchall(te->set, &te->elem))
-				nft_setelem_remove(net, te->set, &te->elem);
-
+			nft_setelem_remove(net, te->set, &te->elem);
 			if (!nft_setelem_is_catchall(te->set, &te->elem))
 				atomic_dec(&te->set->nelems);
 
-- 
2.30.2

