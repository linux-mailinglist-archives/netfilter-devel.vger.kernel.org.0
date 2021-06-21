Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2744C3AF0F0
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Jun 2021 18:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhFUQys (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Jun 2021 12:54:48 -0400
Received: from mail.netfilter.org ([217.70.188.207]:55388 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbhFUQwe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:52:34 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id C26796425E
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Jun 2021 18:48:53 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v3] netfilter: nf_tables: memleak in hw offload abort path
Date:   Mon, 21 Jun 2021 18:50:13 +0200
Message-Id: <20210621165013.1366-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Release flow from the abort path, this is easy to reproduce since
b72920f6e4a9 ("netfilter: nftables: counter hardware offload support").

unreferenced object 0xffff8881f0fa7700 (size 128):
  comm "nft", pid 1335, jiffies 4294931120 (age 4163.740s)
  hex dump (first 32 bytes):
    08 e4 de 13 82 88 ff ff 98 e4 de 13 82 88 ff ff  ................
    48 e4 de 13 82 88 ff ff 01 00 00 00 00 00 00 00  H...............
  backtrace:
    [<00000000634547e7>] flow_rule_alloc+0x26/0x80
    [<00000000c8426156>] nft_flow_rule_create+0xc9/0x3f0 [nf_tables]
    [<0000000075ff8e46>] nf_tables_newrule+0xc79/0x10a0 [nf_tables]
    [<00000000ba65e40e>] nfnetlink_rcv_batch+0xaac/0xf90 [nfnetlink]
    [<00000000505c614a>] nfnetlink_rcv+0x1bb/0x1f0 [nfnetlink]
    [<00000000eb78e1fe>] netlink_unicast+0x34b/0x480
    [<00000000a8f72c94>] netlink_sendmsg+0x3af/0x690
    [<000000009cb1ddf4>] sock_sendmsg+0x96/0xa0
    [<0000000039d06e44>] ____sys_sendmsg+0x3fe/0x440
    [<00000000137e82ca>] ___sys_sendmsg+0xd8/0x140
    [<000000000c6bf6a6>] __sys_sendmsg+0xb3/0x130
    [<0000000043bd6268>] do_syscall_64+0x40/0xb0
    [<00000000afdebc2d>] entry_SYSCALL_64_after_hwframe+0x44/0xae

Move nft_flow_rule_create() call before the transaction object is
created otherwise the abort path might find a NULL pointer to the
flow rule object.

While at it, rename BASIC-like goto tags to slightly more meaningful
names rather than adding a new "err3" tag.

Fixes: 63b48c73ff56 ("netfilter: nf_tables_offload: undo updates if transaction fails")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: fix crash on v2 when adding a rule.

 net/netfilter/nf_tables_api.c | 51 +++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index bf4d6ec9fc55..ca9ec8721e6c 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3243,9 +3243,9 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 	u8 genmask = nft_genmask_next(info->net);
 	struct nft_rule *rule, *old_rule = NULL;
 	struct nft_expr_info *expr_info = NULL;
+	struct nft_flow_rule *flow = NULL;
 	int family = nfmsg->nfgen_family;
 	struct net *net = info->net;
-	struct nft_flow_rule *flow;
 	struct nft_userdata *udata;
 	struct nft_table *table;
 	struct nft_chain *chain;
@@ -3340,13 +3340,13 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 		nla_for_each_nested(tmp, nla[NFTA_RULE_EXPRESSIONS], rem) {
 			err = -EINVAL;
 			if (nla_type(tmp) != NFTA_LIST_ELEM)
-				goto err1;
+				goto err_release_expr;
 			if (n == NFT_RULE_MAXEXPRS)
-				goto err1;
+				goto err_release_expr;
 			err = nf_tables_expr_parse(&ctx, tmp, &expr_info[n]);
 			if (err < 0) {
 				NL_SET_BAD_ATTR(extack, tmp);
-				goto err1;
+				goto err_release_expr;
 			}
 			size += expr_info[n].ops->size;
 			n++;
@@ -3355,7 +3355,7 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 	/* Check for overflow of dlen field */
 	err = -EFBIG;
 	if (size >= 1 << 12)
-		goto err1;
+		goto err_release_expr;
 
 	if (nla[NFTA_RULE_USERDATA]) {
 		ulen = nla_len(nla[NFTA_RULE_USERDATA]);
@@ -3366,7 +3366,7 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 	err = -ENOMEM;
 	rule = kzalloc(sizeof(*rule) + size + usize, GFP_KERNEL);
 	if (rule == NULL)
-		goto err1;
+		goto err_release_expr;
 
 	nft_activate_next(net, rule);
 
@@ -3385,7 +3385,7 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 		err = nf_tables_newexpr(&ctx, &expr_info[i], expr);
 		if (err < 0) {
 			NL_SET_BAD_ATTR(extack, expr_info[i].attr);
-			goto err2;
+			goto err_release_rule;
 		}
 
 		if (expr_info[i].ops->validate)
@@ -3395,16 +3395,24 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 		expr = nft_expr_next(expr);
 	}
 
+	if (chain->flags & NFT_CHAIN_HW_OFFLOAD) {
+		flow = nft_flow_rule_create(net, rule);
+		if (IS_ERR(flow)) {
+			err = PTR_ERR(flow);
+			goto err_release_rule;
+		}
+	}
+
 	if (info->nlh->nlmsg_flags & NLM_F_REPLACE) {
 		trans = nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule);
 		if (trans == NULL) {
 			err = -ENOMEM;
-			goto err2;
+			goto err_destroy_flow_rule;
 		}
 		err = nft_delrule(&ctx, old_rule);
 		if (err < 0) {
 			nft_trans_destroy(trans);
-			goto err2;
+			goto err_destroy_flow_rule;
 		}
 
 		list_add_tail_rcu(&rule->list, &old_rule->list);
@@ -3412,7 +3420,7 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 		trans = nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule);
 		if (!trans) {
 			err = -ENOMEM;
-			goto err2;
+			goto err_destroy_flow_rule;
 		}
 
 		if (info->nlh->nlmsg_flags & NLM_F_APPEND) {
@@ -3430,21 +3438,19 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 	kvfree(expr_info);
 	chain->use++;
 
+	if (flow)
+		nft_trans_flow_rule(trans) = flow;
+
 	if (nft_net->validate_state == NFT_VALIDATE_DO)
 		return nft_table_validate(net, table);
 
-	if (chain->flags & NFT_CHAIN_HW_OFFLOAD) {
-		flow = nft_flow_rule_create(net, rule);
-		if (IS_ERR(flow))
-			return PTR_ERR(flow);
-
-		nft_trans_flow_rule(trans) = flow;
-	}
-
 	return 0;
-err2:
+
+err_destroy_flow_rule:
+	nft_flow_rule_destroy(flow);
+err_release_rule:
 	nf_tables_rule_release(&ctx, rule);
-err1:
+err_release_expr:
 	for (i = 0; i < n; i++) {
 		if (expr_info[i].ops) {
 			module_put(expr_info[i].ops->type->owner);
@@ -8839,11 +8845,16 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			nft_rule_expr_deactivate(&trans->ctx,
 						 nft_trans_rule(trans),
 						 NFT_TRANS_ABORT);
+			if (trans->ctx.chain->flags & NFT_CHAIN_HW_OFFLOAD)
+				nft_flow_rule_destroy(nft_trans_flow_rule(trans));
 			break;
 		case NFT_MSG_DELRULE:
 			trans->ctx.chain->use++;
 			nft_clear(trans->ctx.net, nft_trans_rule(trans));
 			nft_rule_expr_activate(&trans->ctx, nft_trans_rule(trans));
+			if (trans->ctx.chain->flags & NFT_CHAIN_HW_OFFLOAD)
+				nft_flow_rule_destroy(nft_trans_flow_rule(trans));
+
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWSET:
-- 
2.30.2

