Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE744FBA63
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 Apr 2022 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345472AbiDKLEJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 11 Apr 2022 07:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345792AbiDKLEE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:04:04 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3375C47
        for <netfilter-devel@vger.kernel.org>; Mon, 11 Apr 2022 04:01:49 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ndrno-0000JK-Cu; Mon, 11 Apr 2022 13:01:48 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v4 04/10] netfilter: cttimeout: decouple unlink and free on netns destruction
Date:   Mon, 11 Apr 2022 13:01:19 +0200
Message-Id: <20220411110125.4854-5-fw@strlen.de>
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

Make it so netns pre_exit unlinks the objects from the pernet list, so
they cannot be found anymore.

netns core issues a synchronize_rcu() before calling the exit hooks so
any the time the exit hooks run unconfirmed nf_conn entries have been
free'd or they have been committed to the hashtable.

The exit hook still tags unconfirmed entries as dying, this can
now be removed in a followup change.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_conntrack_timeout.h |  8 ------
 net/netfilter/nfnetlink_cttimeout.c          | 30 ++++++++++++++++++--
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_timeout.h b/include/net/netfilter/nf_conntrack_timeout.h
index 3ea94f6f3844..fea258983d23 100644
--- a/include/net/netfilter/nf_conntrack_timeout.h
+++ b/include/net/netfilter/nf_conntrack_timeout.h
@@ -17,14 +17,6 @@ struct nf_ct_timeout {
 	char			data[];
 };
 
-struct ctnl_timeout {
-	struct list_head	head;
-	struct rcu_head		rcu_head;
-	refcount_t		refcnt;
-	char			name[CTNL_TIMEOUT_NAME_MAX];
-	struct nf_ct_timeout	timeout;
-};
-
 struct nf_conn_timeout {
 	struct nf_ct_timeout __rcu *timeout;
 };
diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index eea486f32971..83fa15c4193c 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -33,8 +33,19 @@
 
 static unsigned int nfct_timeout_id __read_mostly;
 
+struct ctnl_timeout {
+	struct list_head	head;
+	struct rcu_head		rcu_head;
+	refcount_t		refcnt;
+	char			name[CTNL_TIMEOUT_NAME_MAX];
+	struct nf_ct_timeout	timeout;
+
+	struct list_head	free_head;
+};
+
 struct nfct_timeout_pernet {
 	struct list_head	nfct_timeout_list;
+	struct list_head	nfct_timeout_freelist;
 };
 
 MODULE_LICENSE("GPL");
@@ -574,10 +585,24 @@ static int __net_init cttimeout_net_init(struct net *net)
 	struct nfct_timeout_pernet *pernet = nfct_timeout_pernet(net);
 
 	INIT_LIST_HEAD(&pernet->nfct_timeout_list);
+	INIT_LIST_HEAD(&pernet->nfct_timeout_freelist);
 
 	return 0;
 }
 
+static void __net_exit cttimeout_net_pre_exit(struct net *net)
+{
+	struct nfct_timeout_pernet *pernet = nfct_timeout_pernet(net);
+	struct ctnl_timeout *cur, *tmp;
+
+	list_for_each_entry_safe(cur, tmp, &pernet->nfct_timeout_list, head) {
+		list_del_rcu(&cur->head);
+		list_add(&cur->free_head, &pernet->nfct_timeout_freelist);
+	}
+
+	/* core calls synchronize_rcu() after this */
+}
+
 static void __net_exit cttimeout_net_exit(struct net *net)
 {
 	struct nfct_timeout_pernet *pernet = nfct_timeout_pernet(net);
@@ -586,8 +611,8 @@ static void __net_exit cttimeout_net_exit(struct net *net)
 	nf_ct_unconfirmed_destroy(net);
 	nf_ct_untimeout(net, NULL);
 
-	list_for_each_entry_safe(cur, tmp, &pernet->nfct_timeout_list, head) {
-		list_del_rcu(&cur->head);
+	list_for_each_entry_safe(cur, tmp, &pernet->nfct_timeout_freelist, head) {
+		list_del(&cur->free_head);
 
 		if (refcount_dec_and_test(&cur->refcnt))
 			kfree_rcu(cur, rcu_head);
@@ -596,6 +621,7 @@ static void __net_exit cttimeout_net_exit(struct net *net)
 
 static struct pernet_operations cttimeout_ops = {
 	.init	= cttimeout_net_init,
+	.pre_exit = cttimeout_net_pre_exit,
 	.exit	= cttimeout_net_exit,
 	.id     = &nfct_timeout_id,
 	.size   = sizeof(struct nfct_timeout_pernet),
-- 
2.35.1

