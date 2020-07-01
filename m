Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F121148E
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jul 2020 22:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgGAUuT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Jul 2020 16:50:19 -0400
Received: from correo.us.es ([193.147.175.20]:34604 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgGAUuS (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:50:18 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id F26C6D28C0
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Jul 2020 22:50:13 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E2D8ADA72F
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Jul 2020 22:50:13 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D89D1DA722; Wed,  1 Jul 2020 22:50:13 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7C366DA73F
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Jul 2020 22:50:11 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 01 Jul 2020 22:50:11 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 66F8F4265A2F
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Jul 2020 22:50:11 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 6/6,v2] netfilter: nf_tables: add NFT_CHAIN_BINDING
Date:   Wed,  1 Jul 2020 22:50:08 +0200
Message-Id: <20200701205008.16845-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This new chain flag specifies that:

* the kernel dynamically allocates the chain name, if no chain name
  is specified.

* If the immediate expression that refers to this chain is removed,
  then this bound chain (and its content) is destroyed.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: fix NFTA_CHAIN_FLAGS netlink dumping.

 include/net/netfilter/nf_tables.h        | 13 +++-
 include/uapi/linux/netfilter/nf_tables.h |  1 +
 net/netfilter/nf_tables_api.c            | 78 ++++++++++++++++++++----
 net/netfilter/nft_immediate.c            | 51 ++++++++++++++++
 4 files changed, 130 insertions(+), 13 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 6d1e7da6e00a..0ebbe000bb0a 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -899,6 +899,8 @@ static inline struct nft_userdata *nft_userdata(const struct nft_rule *rule)
 	return (void *)&rule->data[rule->dlen];
 }
 
+void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule);
+
 static inline void nft_set_elem_update_expr(const struct nft_set_ext *ext,
 					    struct nft_regs *regs,
 					    const struct nft_pktinfo *pkt)
@@ -944,7 +946,8 @@ struct nft_chain {
 	struct nft_table		*table;
 	u64				handle;
 	u32				use;
-	u8				flags:6,
+	u8				flags:5,
+					bound:1,
 					genmask:2;
 	char				*name;
 
@@ -989,6 +992,14 @@ int nft_chain_validate_dependency(const struct nft_chain *chain,
 int nft_chain_validate_hooks(const struct nft_chain *chain,
                              unsigned int hook_flags);
 
+static inline bool nft_chain_is_bound(struct nft_chain *chain)
+{
+	return (chain->flags & NFT_CHAIN_BINDING) && chain->bound;
+}
+
+void nft_chain_del(struct nft_chain *chain);
+void nf_tables_chain_destroy(struct nft_ctx *ctx);
+
 struct nft_stats {
 	u64			bytes;
 	u64			pkts;
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 2cf7cc3b50c1..e00b4ae6174e 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -187,6 +187,7 @@ enum nft_table_attributes {
 enum nft_chain_flags {
 	NFT_CHAIN_BASE		= (1 << 0),
 	NFT_CHAIN_HW_OFFLOAD	= (1 << 1),
+	NFT_CHAIN_BINDING	= (1 << 2),
 };
 
 /**
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 572f049d7de4..06f652fe9fd5 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1098,6 +1098,9 @@ static int nft_flush_table(struct nft_ctx *ctx)
 		if (!nft_is_active_next(ctx->net, chain))
 			continue;
 
+		if (nft_chain_is_bound(chain))
+			continue;
+
 		ctx->chain = chain;
 
 		err = nft_delchain(ctx);
@@ -1413,13 +1416,12 @@ static int nf_tables_fill_chain_info(struct sk_buff *skb, struct net *net,
 					      lockdep_commit_lock_is_held(net));
 		if (nft_dump_stats(skb, stats))
 			goto nla_put_failure;
-
-		if ((chain->flags & NFT_CHAIN_HW_OFFLOAD) &&
-		    nla_put_be32(skb, NFTA_CHAIN_FLAGS,
-				 htonl(NFT_CHAIN_HW_OFFLOAD)))
-			goto nla_put_failure;
 	}
 
+	if (chain->flags &&
+	    nla_put_be32(skb, NFTA_CHAIN_FLAGS, htonl(chain->flags)))
+		goto nla_put_failure;
+
 	if (nla_put_be32(skb, NFTA_CHAIN_USE, htonl(chain->use)))
 		goto nla_put_failure;
 
@@ -1621,7 +1623,7 @@ static void nf_tables_chain_free_chain_rules(struct nft_chain *chain)
 	kvfree(chain->rules_next);
 }
 
-static void nf_tables_chain_destroy(struct nft_ctx *ctx)
+void nf_tables_chain_destroy(struct nft_ctx *ctx)
 {
 	struct nft_chain *chain = ctx->chain;
 	struct nft_hook *hook, *next;
@@ -1928,6 +1930,8 @@ static int nft_chain_add(struct nft_table *table, struct nft_chain *chain)
 	return 0;
 }
 
+static u64 chain_id;
+
 static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 			      u8 policy, u32 flags)
 {
@@ -1936,6 +1940,7 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	struct nft_base_chain *basechain;
 	struct nft_stats __percpu *stats;
 	struct net *net = ctx->net;
+	char name[NFT_NAME_MAXLEN];
 	struct nft_trans *trans;
 	struct nft_chain *chain;
 	struct nft_rule **rules;
@@ -1947,6 +1952,9 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 	if (nla[NFTA_CHAIN_HOOK]) {
 		struct nft_chain_hook hook;
 
+		if (flags & NFT_CHAIN_BINDING)
+			return -EOPNOTSUPP;
+
 		err = nft_chain_parse_hook(net, nla, &hook, family, true);
 		if (err < 0)
 			return err;
@@ -1976,16 +1984,33 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 			return err;
 		}
 	} else {
+		if (flags & NFT_CHAIN_BASE)
+			return -EINVAL;
+		if (flags & NFT_CHAIN_HW_OFFLOAD)
+			return -EOPNOTSUPP;
+
 		chain = kzalloc(sizeof(*chain), GFP_KERNEL);
 		if (chain == NULL)
 			return -ENOMEM;
+
+		chain->flags = flags;
 	}
 	ctx->chain = chain;
 
 	INIT_LIST_HEAD(&chain->rules);
 	chain->handle = nf_tables_alloc_handle(table);
 	chain->table = table;
-	chain->name = nla_strdup(nla[NFTA_CHAIN_NAME], GFP_KERNEL);
+
+	if (nla[NFTA_CHAIN_NAME]) {
+		chain->name = nla_strdup(nla[NFTA_CHAIN_NAME], GFP_KERNEL);
+	} else {
+		if (!(flags & NFT_CHAIN_BINDING))
+			return -EINVAL;
+
+		snprintf(name, sizeof(name), "__chain%llu", ++chain_id);
+		chain->name = kstrdup(name, GFP_KERNEL);
+	}
+
 	if (!chain->name) {
 		err = -ENOMEM;
 		goto err1;
@@ -2958,8 +2983,7 @@ static int nf_tables_getrule(struct net *net, struct sock *nlsk,
 	return err;
 }
 
-static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
-				   struct nft_rule *rule)
+void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
 	struct nft_expr *expr, *next;
 
@@ -5330,11 +5354,24 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
  */
 void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 {
+	struct nft_chain *chain;
+	struct nft_rule *rule;
+
 	if (type == NFT_DATA_VERDICT) {
 		switch (data->verdict.code) {
 		case NFT_JUMP:
 		case NFT_GOTO:
-			data->verdict.chain->use++;
+			chain = data->verdict.chain;
+			chain->use++;
+
+			if (!nft_chain_is_bound(chain))
+				break;
+
+			chain->table->use++;
+			list_for_each_entry(rule, &chain->rules, list)
+				chain->use++;
+
+			nft_chain_add(chain->table, chain);
 			break;
 		}
 	}
@@ -7474,7 +7511,7 @@ static void nft_obj_del(struct nft_object *obj)
 	list_del_rcu(&obj->list);
 }
 
-static void nft_chain_del(struct nft_chain *chain)
+void nft_chain_del(struct nft_chain *chain)
 {
 	struct nft_table *table = chain->table;
 
@@ -7825,6 +7862,10 @@ static int __nf_tables_abort(struct net *net, bool autoload)
 				kfree(nft_trans_chain_name(trans));
 				nft_trans_destroy(trans);
 			} else {
+				if (nft_chain_is_bound(trans->ctx.chain)) {
+					nft_trans_destroy(trans);
+					break;
+				}
 				trans->ctx.table->use--;
 				nft_chain_del(trans->ctx.chain);
 				nf_tables_unregister_hook(trans->ctx.net,
@@ -8321,10 +8362,23 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
 static void nft_verdict_uninit(const struct nft_data *data)
 {
+	struct nft_chain *chain;
+	struct nft_rule *rule;
+
 	switch (data->verdict.code) {
 	case NFT_JUMP:
 	case NFT_GOTO:
-		data->verdict.chain->use--;
+		chain = data->verdict.chain;
+		chain->use--;
+
+		if (!nft_chain_is_bound(chain))
+			break;
+
+		chain->table->use--;
+		list_for_each_entry(rule, &chain->rules, list)
+			chain->use--;
+
+		nft_chain_del(chain);
 		break;
 	}
 }
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index c7f0ef73d939..255603df1789 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -54,6 +54,23 @@ static int nft_immediate_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		goto err1;
 
+	if (priv->dreg == NFT_REG_VERDICT) {
+		struct nft_chain *chain = priv->data.verdict.chain;
+
+		switch (priv->data.verdict.code) {
+		case NFT_JUMP:
+		case NFT_GOTO:
+			if (nft_chain_is_bound(chain)) {
+				err = -EBUSY;
+				goto err1;
+			}
+			chain->bound = true;
+			break;
+		default:
+			break;
+		}
+	}
+
 	return 0;
 
 err1:
@@ -81,6 +98,39 @@ static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 	return nft_data_release(&priv->data, nft_dreg_to_type(priv->dreg));
 }
 
+static void nft_immediate_destroy(const struct nft_ctx *ctx,
+				  const struct nft_expr *expr)
+{
+	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
+	const struct nft_data *data = &priv->data;
+	struct nft_ctx chain_ctx;
+	struct nft_chain *chain;
+	struct nft_rule *rule;
+
+	if (priv->dreg != NFT_REG_VERDICT)
+		return;
+
+	switch (data->verdict.code) {
+	case NFT_JUMP:
+	case NFT_GOTO:
+		chain = data->verdict.chain;
+
+		if (!nft_chain_is_bound(chain))
+			break;
+
+		chain_ctx = *ctx;
+		chain_ctx.chain = chain;
+
+		list_for_each_entry(rule, &chain->rules, list)
+			nf_tables_rule_destroy(&chain_ctx, rule);
+
+		nf_tables_chain_destroy(&chain_ctx);
+		break;
+	default:
+		break;
+	}
+}
+
 static int nft_immediate_dump(struct sk_buff *skb, const struct nft_expr *expr)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
@@ -170,6 +220,7 @@ static const struct nft_expr_ops nft_imm_ops = {
 	.init		= nft_immediate_init,
 	.activate	= nft_immediate_activate,
 	.deactivate	= nft_immediate_deactivate,
+	.destroy	= nft_immediate_destroy,
 	.dump		= nft_immediate_dump,
 	.validate	= nft_immediate_validate,
 	.offload	= nft_immediate_offload,
-- 
2.20.1

