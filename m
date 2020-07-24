Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565CC22C467
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 Jul 2020 13:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGXLey (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 24 Jul 2020 07:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGXLex (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:34:53 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2B7C0619D3
        for <netfilter-devel@vger.kernel.org>; Fri, 24 Jul 2020 04:34:53 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1jyvyV-0006cq-QU; Fri, 24 Jul 2020 13:34:51 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayso <pablo@netfilter.org>
Subject: [PATCH nf] netfilter: nft_compat: make sure xtables destructors have run
Date:   Fri, 24 Jul 2020 13:34:46 +0200
Message-Id: <20200724113446.29113-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira found that after recent update of xt_IDLETIMER the
iptables-nft tests sometimes show an error.

He tracked this down to the delayed cleanup used by nf_tables core:
del rule (transaction A)
add rule (transaction B)

Its possible that by time transaction B (both in same netns) runs,
the xt target destructor has not been invoked yet.

For native nft expressions this is no problem because all expressions
that have such side effects make sure these are handled from the commit
phase, rather than async cleanup.

For nft_compat however this isn't true.

Instead of forcing synchronous behaviour for nft_compat, keep track
of the number of outstanding destructor calls.

When we attempt to create a new expression, flush the cleanup worker
to make sure destructors have completed.

With lots of help from Pablo Neira.

Reported-by: Pablo Neira Ayso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_tables.h |  2 ++
 net/netfilter/nf_tables_api.c     | 10 +++++++--
 net/netfilter/nft_compat.c        | 36 +++++++++++++++++++++++++++----
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 6f0f6fca9ac3..2571c09be8bb 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1498,4 +1498,6 @@ void nft_chain_filter_fini(void);
 
 void __init nft_chain_route_init(void);
 void nft_chain_route_fini(void);
+
+void nf_tables_trans_destroy_flush_work(void);
 #endif /* _NET_NF_TABLES_H */
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 88325b264737..79e4db3cadec 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7290,6 +7290,12 @@ static void nf_tables_trans_destroy_work(struct work_struct *w)
 	}
 }
 
+void nf_tables_trans_destroy_flush_work(void)
+{
+	flush_work(&trans_destroy_work);
+}
+EXPORT_SYMBOL_GPL(nf_tables_trans_destroy_flush_work);
+
 static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *chain)
 {
 	struct nft_rule *rule;
@@ -7472,9 +7478,9 @@ static void nf_tables_commit_release(struct net *net)
 	spin_unlock(&nf_tables_destroy_list_lock);
 
 	nf_tables_module_autoload_cleanup(net);
-	mutex_unlock(&net->nft.commit_mutex);
-
 	schedule_work(&trans_destroy_work);
+
+	mutex_unlock(&net->nft.commit_mutex);
 }
 
 static int nf_tables_commit(struct net *net, struct sk_buff *skb)
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index aa1a066cb74b..6428856ccbec 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -27,6 +27,8 @@ struct nft_xt_match_priv {
 	void *info;
 };
 
+static refcount_t nft_compat_pending_destroy = REFCOUNT_INIT(1);
+
 static int nft_compat_chain_validate_dependency(const struct nft_ctx *ctx,
 						const char *tablename)
 {
@@ -236,6 +238,15 @@ nft_target_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 
 	nft_target_set_tgchk_param(&par, ctx, target, info, &e, proto, inv);
 
+	/* xtables matches or targets can have side effects, e.g.
+	 * creation/destruction of /proc files.
+	 * The xt ->destroy functions are run asynchronously from
+	 * work queue.  If we have pending invocations we thus
+	 * need to wait for those to finish.
+	 */
+	if (refcount_read(&nft_compat_pending_destroy) > 1)
+		nf_tables_trans_destroy_flush_work();
+
 	ret = xt_check_target(&par, size, proto, inv);
 	if (ret < 0)
 		return ret;
@@ -247,6 +258,13 @@ nft_target_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	return 0;
 }
 
+static void __nft_mt_tg_destroy(struct module *me, const struct nft_expr *expr)
+{
+	refcount_dec(&nft_compat_pending_destroy);
+	module_put(me);
+	kfree(expr->ops);
+}
+
 static void
 nft_target_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
 {
@@ -262,8 +280,7 @@ nft_target_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
 	if (par.target->destroy != NULL)
 		par.target->destroy(&par);
 
-	module_put(me);
-	kfree(expr->ops);
+	__nft_mt_tg_destroy(me, expr);
 }
 
 static int nft_extension_dump_info(struct sk_buff *skb, int attr,
@@ -494,8 +511,7 @@ __nft_match_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	if (par.match->destroy != NULL)
 		par.match->destroy(&par);
 
-	module_put(me);
-	kfree(expr->ops);
+	__nft_mt_tg_destroy(me, expr);
 }
 
 static void
@@ -700,6 +716,14 @@ static const struct nfnetlink_subsystem nfnl_compat_subsys = {
 
 static struct nft_expr_type nft_match_type;
 
+static void nft_mt_tg_deactivate(const struct nft_ctx *ctx,
+				 const struct nft_expr *expr,
+				 enum nft_trans_phase phase)
+{
+	if (phase == NFT_TRANS_COMMIT)
+		refcount_inc(&nft_compat_pending_destroy);
+}
+
 static const struct nft_expr_ops *
 nft_match_select_ops(const struct nft_ctx *ctx,
 		     const struct nlattr * const tb[])
@@ -738,6 +762,7 @@ nft_match_select_ops(const struct nft_ctx *ctx,
 	ops->type = &nft_match_type;
 	ops->eval = nft_match_eval;
 	ops->init = nft_match_init;
+	ops->deactivate = nft_mt_tg_deactivate,
 	ops->destroy = nft_match_destroy;
 	ops->dump = nft_match_dump;
 	ops->validate = nft_match_validate;
@@ -828,6 +853,7 @@ nft_target_select_ops(const struct nft_ctx *ctx,
 	ops->size = NFT_EXPR_SIZE(XT_ALIGN(target->targetsize));
 	ops->init = nft_target_init;
 	ops->destroy = nft_target_destroy;
+	ops->deactivate = nft_mt_tg_deactivate,
 	ops->dump = nft_target_dump;
 	ops->validate = nft_target_validate;
 	ops->data = target;
@@ -891,6 +917,8 @@ static void __exit nft_compat_module_exit(void)
 	nfnetlink_subsys_unregister(&nfnl_compat_subsys);
 	nft_unregister_expr(&nft_target_type);
 	nft_unregister_expr(&nft_match_type);
+
+	WARN_ON_ONCE(refcount_read(&nft_compat_pending_destroy) != 1);
 }
 
 MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_NFT_COMPAT);
-- 
2.26.2

