Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619B84FBA60
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 Apr 2022 13:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiDKLEL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 11 Apr 2022 07:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345818AbiDKLEF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:04:05 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416D4F54
        for <netfilter-devel@vger.kernel.org>; Mon, 11 Apr 2022 04:01:51 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ndrnp-0000Jg-Oo; Mon, 11 Apr 2022 13:01:49 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v4 05/10] netfilter: remove nf_ct_unconfirmed_destroy helper
Date:   Mon, 11 Apr 2022 13:01:20 +0200
Message-Id: <20220411110125.4854-6-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411110125.4854-1-fw@strlen.de>
References: <20220411110125.4854-1-fw@strlen.de>
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

This helper tags connetions not yet in the conntrack table as
dying.  These nf_conn entries will be dropped instead when the
core attempts to insert them from the input or postrouting
'confirm' hook.

After the previous change, the entries get unlinked from the
list earlier, so that by the time the actual exit hook runs,
new connections no longer have a timeout policy assigned.

Its enough to walk the hashtable instead.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_conntrack.h |  3 ---
 net/netfilter/nf_conntrack_core.c    | 14 --------------
 net/netfilter/nfnetlink_cttimeout.c  |  4 +++-
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 28672a944499..f60212244b13 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -237,9 +237,6 @@ static inline bool nf_ct_kill(struct nf_conn *ct)
 	return nf_ct_delete(ct, 0, 0);
 }
 
-/* Set all unconfirmed conntrack as dying */
-void nf_ct_unconfirmed_destroy(struct net *);
-
 /* Iterate over all conntracks: if iter returns true, it's deleted. */
 void nf_ct_iterate_cleanup_net(struct net *net,
 			       int (*iter)(struct nf_conn *i, void *data),
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 9010b6e5a072..b3cc318ceb45 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2431,20 +2431,6 @@ __nf_ct_unconfirmed_destroy(struct net *net)
 	}
 }
 
-void nf_ct_unconfirmed_destroy(struct net *net)
-{
-	struct nf_conntrack_net *cnet = nf_ct_pernet(net);
-
-	might_sleep();
-
-	if (atomic_read(&cnet->count) > 0) {
-		__nf_ct_unconfirmed_destroy(net);
-		nf_queue_nf_hook_drop(net);
-		synchronize_net();
-	}
-}
-EXPORT_SYMBOL_GPL(nf_ct_unconfirmed_destroy);
-
 void nf_ct_iterate_cleanup_net(struct net *net,
 			       int (*iter)(struct nf_conn *i, void *data),
 			       void *data, u32 portid, int report)
diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index 83fa15c4193c..f366b8187915 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -608,7 +608,9 @@ static void __net_exit cttimeout_net_exit(struct net *net)
 	struct nfct_timeout_pernet *pernet = nfct_timeout_pernet(net);
 	struct ctnl_timeout *cur, *tmp;
 
-	nf_ct_unconfirmed_destroy(net);
+	if (list_empty(&pernet->nfct_timeout_freelist))
+		return;
+
 	nf_ct_untimeout(net, NULL);
 
 	list_for_each_entry_safe(cur, tmp, &pernet->nfct_timeout_freelist, head) {
-- 
2.35.1

