Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40541145D8D
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Jan 2020 22:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgAVVRR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Jan 2020 16:17:17 -0500
Received: from correo.us.es ([193.147.175.20]:57612 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgAVVRR (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:17:17 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 37995DA70A
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jan 2020 22:17:13 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 26CE9DA712
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jan 2020 22:17:13 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1C4C4DA70E; Wed, 22 Jan 2020 22:17:13 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B3592DA710
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jan 2020 22:17:10 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 22 Jan 2020 22:17:10 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id A299242EF9E1
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jan 2020 22:17:10 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v2] netfilter: nf_tables: autoload modules from the abort path
Date:   Wed, 22 Jan 2020 22:17:06 +0100
Message-Id: <20200122211706.150042-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch introduces a list of pending module requests that is updated
from preparation phase. Then, at the very end of the abort phase,
iterate over this list to load the requested modules. Given the mutex is
released when loading modules, the list of modules is zapped so this is
iteration occurs over a local list. Thus, the request_module() call
occurs when object lists in consistent state and the commit list is
empty.

This new module list is composed of nft_module_request objects that
contain the module name and one status field that tells if the module
has been already loaded (the 'done' field).

The module list handling must be the very last thing, and the commit
list must be already empty.

This patch also updates nfnetlink to include the reason to enter the
abort phase, which is required for this new autoload module rationale.

Fixes: 452238e8d5ff ("netfilter: nf_tables: add and use helper for module autoload")
Reported-by: syzbot+29125d208b3dae9a7019@syzkaller.appspotmail.com
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: call nf_tables_module_autoload_cleanup() holding the mutex from
    the nf_tables_commit_release() path. Only one Fixes: tag.

 include/linux/netfilter/nfnetlink.h |   2 +-
 include/net/netns/nftables.h        |   1 +
 net/netfilter/nf_tables_api.c       | 121 ++++++++++++++++++++++++------------
 net/netfilter/nfnetlink.c           |   6 +-
 4 files changed, 86 insertions(+), 44 deletions(-)

diff --git a/include/linux/netfilter/nfnetlink.h b/include/linux/netfilter/nfnetlink.h
index cf09ab37b45b..851425c3178f 100644
--- a/include/linux/netfilter/nfnetlink.h
+++ b/include/linux/netfilter/nfnetlink.h
@@ -31,7 +31,7 @@ struct nfnetlink_subsystem {
 	const struct nfnl_callback *cb;	/* callback for individual types */
 	struct module *owner;
 	int (*commit)(struct net *net, struct sk_buff *skb);
-	int (*abort)(struct net *net, struct sk_buff *skb);
+	int (*abort)(struct net *net, struct sk_buff *skb, bool autoload);
 	void (*cleanup)(struct net *net);
 	bool (*valid_genid)(struct net *net, u32 genid);
 };
diff --git a/include/net/netns/nftables.h b/include/net/netns/nftables.h
index 286fd960896f..a1a8d45adb42 100644
--- a/include/net/netns/nftables.h
+++ b/include/net/netns/nftables.h
@@ -7,6 +7,7 @@
 struct netns_nftables {
 	struct list_head	tables;
 	struct list_head	commit_list;
+	struct list_head	module_list;
 	struct mutex		commit_mutex;
 	unsigned int		base_seq;
 	u8			gencursor;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 4aa01c1253b1..b61d3025e3f1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -578,35 +578,40 @@ __nf_tables_chain_type_lookup(const struct nlattr *nla, u8 family)
 	return NULL;
 }
 
-/*
- * Loading a module requires dropping mutex that guards the transaction.
- * A different client might race to start a new transaction meanwhile. Zap the
- * list of pending transaction and then restore it once the mutex is grabbed
- * again. Users of this function return EAGAIN which implicitly triggers the
- * transaction abort path to clean up the list of pending transactions.
- */
+struct nft_module_request {
+	struct list_head	list;
+	char			module[MODULE_NAME_LEN];
+	bool			done;
+};
+
 #ifdef CONFIG_MODULES
-static void nft_request_module(struct net *net, const char *fmt, ...)
+static int nft_request_module(struct net *net, const char *fmt, ...)
 {
 	char module_name[MODULE_NAME_LEN];
-	LIST_HEAD(commit_list);
+	struct nft_module_request *req;
 	va_list args;
 	int ret;
 
-	list_splice_init(&net->nft.commit_list, &commit_list);
-
 	va_start(args, fmt);
 	ret = vsnprintf(module_name, MODULE_NAME_LEN, fmt, args);
 	va_end(args);
 	if (ret >= MODULE_NAME_LEN)
-		return;
+		return 0;
 
-	mutex_unlock(&net->nft.commit_mutex);
-	request_module("%s", module_name);
-	mutex_lock(&net->nft.commit_mutex);
+	list_for_each_entry(req, &net->nft.module_list, list) {
+		if (!strcmp(req->module, module_name) && req->done)
+			return 0;
+	}
 
-	WARN_ON_ONCE(!list_empty(&net->nft.commit_list));
-	list_splice(&commit_list, &net->nft.commit_list);
+	req = kmalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->done = false;
+	strlcpy(req->module, module_name, MODULE_NAME_LEN);
+	list_add_tail(&req->list, &net->nft.module_list);
+
+	return -EAGAIN;
 }
 #endif
 
@@ -630,10 +635,9 @@ nf_tables_chain_type_lookup(struct net *net, const struct nlattr *nla,
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
 	if (autoload) {
-		nft_request_module(net, "nft-chain-%u-%.*s", family,
-				   nla_len(nla), (const char *)nla_data(nla));
-		type = __nf_tables_chain_type_lookup(nla, family);
-		if (type != NULL)
+		if (nft_request_module(net, "nft-chain-%u-%.*s", family,
+				       nla_len(nla),
+				       (const char *)nla_data(nla)) == -EAGAIN)
 			return ERR_PTR(-EAGAIN);
 	}
 #endif
@@ -2341,9 +2345,8 @@ static const struct nft_expr_type *__nft_expr_type_get(u8 family,
 static int nft_expr_type_request_module(struct net *net, u8 family,
 					struct nlattr *nla)
 {
-	nft_request_module(net, "nft-expr-%u-%.*s", family,
-			   nla_len(nla), (char *)nla_data(nla));
-	if (__nft_expr_type_get(family, nla))
+	if (nft_request_module(net, "nft-expr-%u-%.*s", family,
+			       nla_len(nla), (char *)nla_data(nla)) == -EAGAIN)
 		return -EAGAIN;
 
 	return 0;
@@ -2369,9 +2372,9 @@ static const struct nft_expr_type *nft_expr_type_get(struct net *net,
 		if (nft_expr_type_request_module(net, family, nla) == -EAGAIN)
 			return ERR_PTR(-EAGAIN);
 
-		nft_request_module(net, "nft-expr-%.*s",
-				   nla_len(nla), (char *)nla_data(nla));
-		if (__nft_expr_type_get(family, nla))
+		if (nft_request_module(net, "nft-expr-%.*s",
+				       nla_len(nla),
+				       (char *)nla_data(nla)) == -EAGAIN)
 			return ERR_PTR(-EAGAIN);
 	}
 #endif
@@ -2462,9 +2465,10 @@ static int nf_tables_expr_parse(const struct nft_ctx *ctx,
 			err = PTR_ERR(ops);
 #ifdef CONFIG_MODULES
 			if (err == -EAGAIN)
-				nft_expr_type_request_module(ctx->net,
-							     ctx->family,
-							     tb[NFTA_EXPR_NAME]);
+				if (nft_expr_type_request_module(ctx->net,
+								 ctx->family,
+								 tb[NFTA_EXPR_NAME]) != -EAGAIN)
+					err = -ENOENT;
 #endif
 			goto err1;
 		}
@@ -3301,8 +3305,7 @@ nft_select_set_ops(const struct nft_ctx *ctx,
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
 	if (list_empty(&nf_tables_set_types)) {
-		nft_request_module(ctx->net, "nft-set");
-		if (!list_empty(&nf_tables_set_types))
+		if (nft_request_module(ctx->net, "nft-set") == -EAGAIN)
 			return ERR_PTR(-EAGAIN);
 	}
 #endif
@@ -5428,8 +5431,7 @@ nft_obj_type_get(struct net *net, u32 objtype)
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
 	if (type == NULL) {
-		nft_request_module(net, "nft-obj-%u", objtype);
-		if (__nft_obj_type_get(objtype))
+		if (nft_request_module(net, "nft-obj-%u", objtype) == -EAGAIN)
 			return ERR_PTR(-EAGAIN);
 	}
 #endif
@@ -6002,8 +6004,7 @@ nft_flowtable_type_get(struct net *net, u8 family)
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
 	if (type == NULL) {
-		nft_request_module(net, "nf-flowtable-%u", family);
-		if (__nft_flowtable_type_get(family))
+		if (nft_request_module(net, "nf-flowtable-%u", family) == -EAGAIN)
 			return ERR_PTR(-EAGAIN);
 	}
 #endif
@@ -7005,6 +7006,18 @@ static void nft_chain_del(struct nft_chain *chain)
 	list_del_rcu(&chain->list);
 }
 
+static void nf_tables_module_autoload_cleanup(struct net *net)
+{
+	struct nft_module_request *req, *next;
+
+	WARN_ON_ONCE(!list_empty(&net->nft.commit_list));
+	list_for_each_entry_safe(req, next, &net->nft.module_list, list) {
+		WARN_ON_ONCE(!req->done);
+		list_del(&req->list);
+		kfree(req);
+	}
+}
+
 static void nf_tables_commit_release(struct net *net)
 {
 	struct nft_trans *trans;
@@ -7017,6 +7030,7 @@ static void nf_tables_commit_release(struct net *net)
 	 * to prevent expensive synchronize_rcu() in commit phase.
 	 */
 	if (list_empty(&net->nft.commit_list)) {
+		nf_tables_module_autoload_cleanup(net);
 		mutex_unlock(&net->nft.commit_mutex);
 		return;
 	}
@@ -7031,6 +7045,7 @@ static void nf_tables_commit_release(struct net *net)
 	list_splice_tail_init(&net->nft.commit_list, &nf_tables_destroy_list);
 	spin_unlock(&nf_tables_destroy_list_lock);
 
+	nf_tables_module_autoload_cleanup(net);
 	mutex_unlock(&net->nft.commit_mutex);
 
 	schedule_work(&trans_destroy_work);
@@ -7222,6 +7237,26 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	return 0;
 }
 
+static void nf_tables_module_autoload(struct net *net)
+{
+	struct nft_module_request *req, *next;
+	LIST_HEAD(module_list);
+
+	list_splice_init(&net->nft.module_list, &module_list);
+	mutex_unlock(&net->nft.commit_mutex);
+	list_for_each_entry_safe(req, next, &module_list, list) {
+		if (req->done) {
+			list_del(&req->list);
+			kfree(req);
+		} else {
+			request_module("%s", req->module);
+			req->done = true;
+		}
+	}
+	mutex_lock(&net->nft.commit_mutex);
+	list_splice(&module_list, &net->nft.module_list);
+}
+
 static void nf_tables_abort_release(struct nft_trans *trans)
 {
 	switch (trans->msg_type) {
@@ -7251,7 +7286,7 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 	kfree(trans);
 }
 
-static int __nf_tables_abort(struct net *net)
+static int __nf_tables_abort(struct net *net, bool autoload)
 {
 	struct nft_trans *trans, *next;
 	struct nft_trans_elem *te;
@@ -7373,6 +7408,11 @@ static int __nf_tables_abort(struct net *net)
 		nf_tables_abort_release(trans);
 	}
 
+	if (autoload)
+		nf_tables_module_autoload(net);
+	else
+		nf_tables_module_autoload_cleanup(net);
+
 	return 0;
 }
 
@@ -7381,9 +7421,9 @@ static void nf_tables_cleanup(struct net *net)
 	nft_validate_state_update(net, NFT_VALIDATE_SKIP);
 }
 
-static int nf_tables_abort(struct net *net, struct sk_buff *skb)
+static int nf_tables_abort(struct net *net, struct sk_buff *skb, bool autoload)
 {
-	int ret = __nf_tables_abort(net);
+	int ret = __nf_tables_abort(net, autoload);
 
 	mutex_unlock(&net->nft.commit_mutex);
 
@@ -7978,6 +8018,7 @@ static int __net_init nf_tables_init_net(struct net *net)
 {
 	INIT_LIST_HEAD(&net->nft.tables);
 	INIT_LIST_HEAD(&net->nft.commit_list);
+	INIT_LIST_HEAD(&net->nft.module_list);
 	mutex_init(&net->nft.commit_mutex);
 	net->nft.base_seq = 1;
 	net->nft.validate_state = NFT_VALIDATE_SKIP;
@@ -7989,7 +8030,7 @@ static void __net_exit nf_tables_exit_net(struct net *net)
 {
 	mutex_lock(&net->nft.commit_mutex);
 	if (!list_empty(&net->nft.commit_list))
-		__nf_tables_abort(net);
+		__nf_tables_abort(net, false);
 	__nft_release_tables(net);
 	mutex_unlock(&net->nft.commit_mutex);
 	WARN_ON_ONCE(!list_empty(&net->nft.tables));
diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index 4abbb452cf6c..99127e2d95a8 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -476,7 +476,7 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 done:
 	if (status & NFNL_BATCH_REPLAY) {
-		ss->abort(net, oskb);
+		ss->abort(net, oskb, true);
 		nfnl_err_reset(&err_list);
 		kfree_skb(skb);
 		module_put(ss->owner);
@@ -487,11 +487,11 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 			status |= NFNL_BATCH_REPLAY;
 			goto done;
 		} else if (err) {
-			ss->abort(net, oskb);
+			ss->abort(net, oskb, false);
 			netlink_ack(oskb, nlmsg_hdr(oskb), err, NULL);
 		}
 	} else {
-		ss->abort(net, oskb);
+		ss->abort(net, oskb, false);
 	}
 	if (ss->cleanup)
 		ss->cleanup(net);
-- 
2.11.0

