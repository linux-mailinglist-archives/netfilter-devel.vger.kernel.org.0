Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBC1738170
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jun 2023 13:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjFUKSV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Jun 2023 06:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFUKRx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:17:53 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9852268D;
        Wed, 21 Jun 2023 03:17:15 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Subject: [PATCH net 02/14] netfilter: nf_tables: fix chain binding transaction logic
Date:   Wed, 21 Jun 2023 12:07:19 +0200
Message-Id: <20230621100731.68068-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621100731.68068-1-pablo@netfilter.org>
References: <20230621100731.68068-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add bound flag to rule and chain transactions as in 6a0a8d10a366
("netfilter: nf_tables: use-after-free in failing rule with bound set")
to skip them in case that the chain is already bound from the abort
path.

This patch fixes an imbalance in the chain use refcnt that triggers a
WARN_ON on the table and chain destroy path.

This patch also disallows nested chain bindings, which is not
supported from userspace.

The logic to deal with chain binding in nft_data_hold() and
nft_data_release() is not correct. The NFT_TRANS_PREPARE state needs a
special handling in case a chain is bound but next expressions in the
same rule fail to initialize as described by 1240eb93f061 ("netfilter:
nf_tables: incorrect error path handling with NFT_MSG_NEWRULE").

The chain is left bound if rule construction fails, so the objects
stored in this chain (and the chain itself) are released by the
transaction records from the abort path, follow up patch ("netfilter:
nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain")
completes this error handling.

When deleting an existing rule, chain bound flag is set off so the
rule expression .destroy path releases the objects.

Fixes: d0e2c7de92c7 ("netfilter: nf_tables: add NFT_CHAIN_BINDING")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h | 21 +++++++-
 net/netfilter/nf_tables_api.c     | 86 +++++++++++++++++++-----------
 net/netfilter/nft_immediate.c     | 87 +++++++++++++++++++++++++++----
 3 files changed, 153 insertions(+), 41 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 83db182decc8..8ba7f81e81a6 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1009,7 +1009,10 @@ static inline struct nft_userdata *nft_userdata(const struct nft_rule *rule)
 	return (void *)&rule->data[rule->dlen];
 }
 
-void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *rule);
+void nft_rule_expr_activate(const struct nft_ctx *ctx, struct nft_rule *rule);
+void nft_rule_expr_deactivate(const struct nft_ctx *ctx, struct nft_rule *rule,
+			      enum nft_trans_phase phase);
+void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule);
 
 static inline void nft_set_elem_update_expr(const struct nft_set_ext *ext,
 					    struct nft_regs *regs,
@@ -1104,6 +1107,7 @@ int nft_setelem_validate(const struct nft_ctx *ctx, struct nft_set *set,
 			 const struct nft_set_iter *iter,
 			 struct nft_set_elem *elem);
 int nft_set_catchall_validate(const struct nft_ctx *ctx, struct nft_set *set);
+int nf_tables_bind_chain(const struct nft_ctx *ctx, struct nft_chain *chain);
 
 enum nft_chain_types {
 	NFT_CHAIN_T_DEFAULT = 0,
@@ -1140,11 +1144,17 @@ int nft_chain_validate_dependency(const struct nft_chain *chain,
 int nft_chain_validate_hooks(const struct nft_chain *chain,
                              unsigned int hook_flags);
 
+static inline bool nft_chain_binding(const struct nft_chain *chain)
+{
+	return chain->flags & NFT_CHAIN_BINDING;
+}
+
 static inline bool nft_chain_is_bound(struct nft_chain *chain)
 {
 	return (chain->flags & NFT_CHAIN_BINDING) && chain->bound;
 }
 
+int nft_chain_add(struct nft_table *table, struct nft_chain *chain);
 void nft_chain_del(struct nft_chain *chain);
 void nf_tables_chain_destroy(struct nft_ctx *ctx);
 
@@ -1575,6 +1585,7 @@ struct nft_trans_rule {
 	struct nft_rule			*rule;
 	struct nft_flow_rule		*flow;
 	u32				rule_id;
+	bool				bound;
 };
 
 #define nft_trans_rule(trans)	\
@@ -1583,6 +1594,8 @@ struct nft_trans_rule {
 	(((struct nft_trans_rule *)trans->data)->flow)
 #define nft_trans_rule_id(trans)	\
 	(((struct nft_trans_rule *)trans->data)->rule_id)
+#define nft_trans_rule_bound(trans)	\
+	(((struct nft_trans_rule *)trans->data)->bound)
 
 struct nft_trans_set {
 	struct nft_set			*set;
@@ -1607,15 +1620,19 @@ struct nft_trans_set {
 	(((struct nft_trans_set *)trans->data)->gc_int)
 
 struct nft_trans_chain {
+	struct nft_chain		*chain;
 	bool				update;
 	char				*name;
 	struct nft_stats __percpu	*stats;
 	u8				policy;
+	bool				bound;
 	u32				chain_id;
 	struct nft_base_chain		*basechain;
 	struct list_head		hook_list;
 };
 
+#define nft_trans_chain(trans)	\
+	(((struct nft_trans_chain *)trans->data)->chain)
 #define nft_trans_chain_update(trans)	\
 	(((struct nft_trans_chain *)trans->data)->update)
 #define nft_trans_chain_name(trans)	\
@@ -1624,6 +1641,8 @@ struct nft_trans_chain {
 	(((struct nft_trans_chain *)trans->data)->stats)
 #define nft_trans_chain_policy(trans)	\
 	(((struct nft_trans_chain *)trans->data)->policy)
+#define nft_trans_chain_bound(trans)	\
+	(((struct nft_trans_chain *)trans->data)->bound)
 #define nft_trans_chain_id(trans)	\
 	(((struct nft_trans_chain *)trans->data)->chain_id)
 #define nft_trans_basechain(trans)	\
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 69bceefaa5c8..5e4965b98528 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -193,6 +193,48 @@ static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
 	}
 }
 
+static void nft_chain_trans_bind(const struct nft_ctx *ctx, struct nft_chain *chain)
+{
+	struct nftables_pernet *nft_net;
+	struct net *net = ctx->net;
+	struct nft_trans *trans;
+
+	if (!nft_chain_binding(chain))
+		return;
+
+	nft_net = nft_pernet(net);
+	list_for_each_entry_reverse(trans, &nft_net->commit_list, list) {
+		switch (trans->msg_type) {
+		case NFT_MSG_NEWCHAIN:
+			if (nft_trans_chain(trans) == chain)
+				nft_trans_chain_bound(trans) = true;
+			break;
+		case NFT_MSG_NEWRULE:
+			if (trans->ctx.chain == chain)
+				nft_trans_rule_bound(trans) = true;
+			break;
+		}
+	}
+}
+
+int nf_tables_bind_chain(const struct nft_ctx *ctx, struct nft_chain *chain)
+{
+	if (!nft_chain_binding(chain))
+		return 0;
+
+	if (nft_chain_binding(ctx->chain))
+		return -EOPNOTSUPP;
+
+	if (chain->bound)
+		return -EBUSY;
+
+	chain->bound = true;
+	chain->use++;
+	nft_chain_trans_bind(ctx, chain);
+
+	return 0;
+}
+
 static int nft_netdev_register_hooks(struct net *net,
 				     struct list_head *hook_list)
 {
@@ -338,8 +380,9 @@ static struct nft_trans *nft_trans_chain_add(struct nft_ctx *ctx, int msg_type)
 				ntohl(nla_get_be32(ctx->nla[NFTA_CHAIN_ID]));
 		}
 	}
-
+	nft_trans_chain(trans) = ctx->chain;
 	nft_trans_commit_list_add_tail(ctx->net, trans);
+
 	return trans;
 }
 
@@ -357,8 +400,7 @@ static int nft_delchain(struct nft_ctx *ctx)
 	return 0;
 }
 
-static void nft_rule_expr_activate(const struct nft_ctx *ctx,
-				   struct nft_rule *rule)
+void nft_rule_expr_activate(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
 	struct nft_expr *expr;
 
@@ -371,9 +413,8 @@ static void nft_rule_expr_activate(const struct nft_ctx *ctx,
 	}
 }
 
-static void nft_rule_expr_deactivate(const struct nft_ctx *ctx,
-				     struct nft_rule *rule,
-				     enum nft_trans_phase phase)
+void nft_rule_expr_deactivate(const struct nft_ctx *ctx, struct nft_rule *rule,
+			      enum nft_trans_phase phase)
 {
 	struct nft_expr *expr;
 
@@ -2226,7 +2267,7 @@ static int nft_basechain_init(struct nft_base_chain *basechain, u8 family,
 	return 0;
 }
 
-static int nft_chain_add(struct nft_table *table, struct nft_chain *chain)
+int nft_chain_add(struct nft_table *table, struct nft_chain *chain)
 {
 	int err;
 
@@ -3490,8 +3531,7 @@ static int nf_tables_getrule(struct sk_buff *skb, const struct nfnl_info *info,
 	return err;
 }
 
-static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
-				   struct nft_rule *rule)
+void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
 	struct nft_expr *expr, *next;
 
@@ -3508,7 +3548,7 @@ static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
 	kfree(rule);
 }
 
-void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *rule)
+static void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
 	nft_rule_expr_deactivate(ctx, rule, NFT_TRANS_RELEASE);
 	nf_tables_rule_destroy(ctx, rule);
@@ -6638,7 +6678,6 @@ static int nf_tables_newsetelem(struct sk_buff *skb,
 void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 {
 	struct nft_chain *chain;
-	struct nft_rule *rule;
 
 	if (type == NFT_DATA_VERDICT) {
 		switch (data->verdict.code) {
@@ -6646,15 +6685,6 @@ void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 		case NFT_GOTO:
 			chain = data->verdict.chain;
 			chain->use++;
-
-			if (!nft_chain_is_bound(chain))
-				break;
-
-			chain->table->use++;
-			list_for_each_entry(rule, &chain->rules, list)
-				chain->use++;
-
-			nft_chain_add(chain->table, chain);
 			break;
 		}
 	}
@@ -9677,7 +9707,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 				kfree(nft_trans_chain_name(trans));
 				nft_trans_destroy(trans);
 			} else {
-				if (nft_chain_is_bound(trans->ctx.chain)) {
+				if (nft_trans_chain_bound(trans)) {
 					nft_trans_destroy(trans);
 					break;
 				}
@@ -9700,6 +9730,10 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWRULE:
+			if (nft_trans_rule_bound(trans)) {
+				nft_trans_destroy(trans);
+				break;
+			}
 			trans->ctx.chain->use--;
 			list_del_rcu(&nft_trans_rule(trans)->list);
 			nft_rule_expr_deactivate(&trans->ctx,
@@ -10263,22 +10297,12 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 static void nft_verdict_uninit(const struct nft_data *data)
 {
 	struct nft_chain *chain;
-	struct nft_rule *rule;
 
 	switch (data->verdict.code) {
 	case NFT_JUMP:
 	case NFT_GOTO:
 		chain = data->verdict.chain;
 		chain->use--;
-
-		if (!nft_chain_is_bound(chain))
-			break;
-
-		chain->table->use--;
-		list_for_each_entry(rule, &chain->rules, list)
-			chain->use--;
-
-		nft_chain_del(chain);
 		break;
 	}
 }
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index c9d2f7c29f53..0492a04064f1 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -76,11 +76,9 @@ static int nft_immediate_init(const struct nft_ctx *ctx,
 		switch (priv->data.verdict.code) {
 		case NFT_JUMP:
 		case NFT_GOTO:
-			if (nft_chain_is_bound(chain)) {
-				err = -EBUSY;
-				goto err1;
-			}
-			chain->bound = true;
+			err = nf_tables_bind_chain(ctx, chain);
+			if (err < 0)
+				return err;
 			break;
 		default:
 			break;
@@ -98,6 +96,31 @@ static void nft_immediate_activate(const struct nft_ctx *ctx,
 				   const struct nft_expr *expr)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
+	const struct nft_data *data = &priv->data;
+	struct nft_ctx chain_ctx;
+	struct nft_chain *chain;
+	struct nft_rule *rule;
+
+	if (priv->dreg == NFT_REG_VERDICT) {
+		switch (data->verdict.code) {
+		case NFT_JUMP:
+		case NFT_GOTO:
+			chain = data->verdict.chain;
+			if (!nft_chain_binding(chain))
+				break;
+
+			chain_ctx = *ctx;
+			chain_ctx.chain = chain;
+
+			list_for_each_entry(rule, &chain->rules, list)
+				nft_rule_expr_activate(&chain_ctx, rule);
+
+			nft_clear(ctx->net, chain);
+			break;
+		default:
+			break;
+		}
+	}
 
 	return nft_data_hold(&priv->data, nft_dreg_to_type(priv->dreg));
 }
@@ -107,6 +130,40 @@ static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 				     enum nft_trans_phase phase)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
+	const struct nft_data *data = &priv->data;
+	struct nft_ctx chain_ctx;
+	struct nft_chain *chain;
+	struct nft_rule *rule;
+
+	if (priv->dreg == NFT_REG_VERDICT) {
+		switch (data->verdict.code) {
+		case NFT_JUMP:
+		case NFT_GOTO:
+			chain = data->verdict.chain;
+			if (!nft_chain_binding(chain))
+				break;
+
+			chain_ctx = *ctx;
+			chain_ctx.chain = chain;
+
+			list_for_each_entry(rule, &chain->rules, list)
+				nft_rule_expr_deactivate(&chain_ctx, rule, phase);
+
+			switch (phase) {
+			case NFT_TRANS_PREPARE:
+				nft_deactivate_next(ctx->net, chain);
+				break;
+			default:
+				nft_chain_del(chain);
+				chain->bound = false;
+				chain->table->use--;
+				break;
+			}
+			break;
+		default:
+			break;
+		}
+	}
 
 	if (phase == NFT_TRANS_COMMIT)
 		return;
@@ -131,15 +188,27 @@ static void nft_immediate_destroy(const struct nft_ctx *ctx,
 	case NFT_GOTO:
 		chain = data->verdict.chain;
 
-		if (!nft_chain_is_bound(chain))
+		if (!nft_chain_binding(chain))
+			break;
+
+		/* Rule construction failed, but chain is already bound:
+		 * let the transaction records release this chain and its rules.
+		 */
+		if (chain->bound) {
+			chain->use--;
 			break;
+		}
 
+		/* Rule has been deleted, release chain and its rules. */
 		chain_ctx = *ctx;
 		chain_ctx.chain = chain;
 
-		list_for_each_entry_safe(rule, n, &chain->rules, list)
-			nf_tables_rule_release(&chain_ctx, rule);
-
+		chain->use--;
+		list_for_each_entry_safe(rule, n, &chain->rules, list) {
+			chain->use--;
+			list_del(&rule->list);
+			nf_tables_rule_destroy(&chain_ctx, rule);
+		}
 		nf_tables_chain_destroy(&chain_ctx);
 		break;
 	default:
-- 
2.30.2

