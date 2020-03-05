Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E3517A2F6
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Mar 2020 11:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgCEKPs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Mar 2020 05:15:48 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:50764 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbgCEKPs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:15:48 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1j9nXe-00073i-Ku; Thu, 05 Mar 2020 11:15:46 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: nf_tables: fix infinite loop when expr is not available
Date:   Thu,  5 Mar 2020 11:15:36 +0100
Message-Id: <20200305101536.13029-1-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nft will loop forever if the kernel doesn't support an expression:

1. nft_expr_type_get() appends the family specific name to the module list.
2. -EAGAIN is returned to nfnetlink, nfnetlink calls abort path.
3. abort path sets ->done to true and calls request_module for the
   expression.
4. nfnetlink replays the batch, we end up in nft_expr_type_get() again.
5. nft_expr_type_get attempts to append family-specific name. This
   one already exists on the list, so we continue
6. nft_expr_type_get adds the generic expression name to the module
   list. -EAGAIN is returned, nfnetlink calls abort path.
7. abort path encounters the family-specific expression which
   has 'done' set, so it gets removed.
8. abort path requests the generic expression name, sets done to true.
9. batch is replayed.

If the expression could not be loaded, then we will end up back at 1),
because the family-specific name got removed and the cycle starts again.

Note that userspace can SIGKILL the nft process to stop the cycle, but
the desired behaviour is to return an error after the generic expr name
fails to load the expression.

Fixes: eb014de4fd418 ("netfilter: nf_tables: autoload modules from the abort path")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index bb064aa4154b..798a20648c2f 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7383,13 +7383,8 @@ static void nf_tables_module_autoload(struct net *net)
 	list_splice_init(&net->nft.module_list, &module_list);
 	mutex_unlock(&net->nft.commit_mutex);
 	list_for_each_entry_safe(req, next, &module_list, list) {
-		if (req->done) {
-			list_del(&req->list);
-			kfree(req);
-		} else {
-			request_module("%s", req->module);
-			req->done = true;
-		}
+		request_module("%s", req->module);
+		req->done = true;
 	}
 	mutex_lock(&net->nft.commit_mutex);
 	list_splice(&module_list, &net->nft.module_list);
@@ -8172,6 +8167,7 @@ static void __net_exit nf_tables_exit_net(struct net *net)
 	__nft_release_tables(net);
 	mutex_unlock(&net->nft.commit_mutex);
 	WARN_ON_ONCE(!list_empty(&net->nft.tables));
+	WARN_ON_ONCE(!list_empty(&net->nft.module_list));
 }
 
 static struct pernet_operations nf_tables_net_ops = {
-- 
2.24.1

