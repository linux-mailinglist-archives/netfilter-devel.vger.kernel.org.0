Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2685D6DDDF8
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Apr 2023 16:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjDKObF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 11 Apr 2023 10:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjDKOal (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:30:41 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21FD525E
        for <netfilter-devel@vger.kernel.org>; Tue, 11 Apr 2023 07:30:06 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pmF0W-0002MD-3f; Tue, 11 Apr 2023 16:30:04 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 3/3] netfilter: nf_tables: don't store chain address on jump
Date:   Tue, 11 Apr 2023 16:29:47 +0200
Message-Id: <20230411142947.9038-4-fw@strlen.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411142947.9038-1-fw@strlen.de>
References: <20230411142947.9038-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Now that the rule trailer/end marker and the rcu head reside in the
same structure, we no longer need to save/restore the chain pointer
when performing/returning from a jump.

We can simply let the trace infra walk the evaluated rule until it
hits the end marker and then fetch the chain pointer from there.

When the rule is NULL (policy tracing), then chain and basechain
pointers were already identical, so just use the basechain.

This cuts size of jumpstack in half, from 256 to 128 bytes in 64bit,
scripts/stackusage says:

nf_tables_core.c:251 nft_do_chain    328     static

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_tables.h | 14 ++++++++++++--
 net/netfilter/nf_tables_api.c     |  7 -------
 net/netfilter/nf_tables_core.c    | 21 ++++++---------------
 net/netfilter/nf_tables_trace.c   | 30 ++++++++++++++++++++++++++----
 4 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 9430128aae99..7b9f141120a1 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1046,6 +1046,18 @@ struct nft_rule_dp {
 		__attribute__((aligned(__alignof__(struct nft_expr))));
 };
 
+struct nft_rule_dp_last {
+	struct nft_rule_dp end;		/* end of nft_rule_blob marker */
+	struct rcu_head h;		/* call_rcu head */
+	struct nft_rule_blob *blob;	/* ptr to free via call_rcu */
+	const struct nft_chain *chain;	/* for nftables tracing */
+};
+
+static inline const struct nft_rule_dp *nft_rule_next(const struct nft_rule_dp *rule)
+{
+	return (void *)rule + sizeof(*rule) + rule->dlen;
+}
+
 struct nft_rule_blob {
 	unsigned long			size;
 	unsigned char			data[]
@@ -1392,7 +1404,6 @@ void nft_unregister_flowtable_type(struct nf_flowtable_type *type);
  *	@packet_dumped: packet headers sent in a previous traceinfo message
  *	@pkt: pktinfo currently processed
  *	@basechain: base chain currently processed
- *	@chain: chain currently processed
  *	@rule:  rule that was evaluated
  *	@verdict: verdict given by rule
  */
@@ -1404,7 +1415,6 @@ struct nft_traceinfo {
 	u32				skbid;
 	const struct nft_pktinfo	*pkt;
 	const struct nft_base_chain	*basechain;
-	const struct nft_chain		*chain;
 	const struct nft_rule_dp	*rule;
 	const struct nft_verdict	*verdict;
 };
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index f89fa158ead9..fbc699bf0918 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2110,13 +2110,6 @@ static void nft_chain_release_hook(struct nft_chain_hook *hook)
 	module_put(hook->type->owner);
 }
 
-struct nft_rule_dp_last {
-	struct nft_rule_dp end;	/* end of nft_rule_blob marker */
-	struct rcu_head h;
-	struct nft_rule_blob *blob;
-	const struct nft_chain *chain;	/* for tracing */
-};
-
 static void nft_last_rule(const struct nft_chain *chain, const void *ptr)
 {
 	struct nft_rule_dp_last *lrule;
diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index ec3bab751092..89c05b64c2a2 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -42,13 +42,11 @@ static inline void nf_skip_indirect_calls_enable(void) { }
 #endif
 
 static noinline void __nft_trace_packet(struct nft_traceinfo *info,
-					const struct nft_chain *chain,
 					enum nft_trace_types type)
 {
 	if (!info->trace || !info->nf_trace)
 		return;
 
-	info->chain = chain;
 	info->type = type;
 
 	nft_trace_notify(info);
@@ -56,14 +54,13 @@ static noinline void __nft_trace_packet(struct nft_traceinfo *info,
 
 static inline void nft_trace_packet(const struct nft_pktinfo *pkt,
 				    struct nft_traceinfo *info,
-				    const struct nft_chain *chain,
 				    const struct nft_rule_dp *rule,
 				    enum nft_trace_types type)
 {
 	if (static_branch_unlikely(&nft_trace_enabled)) {
 		info->nf_trace = pkt->skb->nf_trace;
 		info->rule = rule;
-		__nft_trace_packet(info, chain, type);
+		__nft_trace_packet(info, type);
 	}
 }
 
@@ -111,7 +108,6 @@ static void nft_cmp16_fast_eval(const struct nft_expr *expr,
 }
 
 static noinline void __nft_trace_verdict(struct nft_traceinfo *info,
-					 const struct nft_chain *chain,
 					 const struct nft_regs *regs)
 {
 	enum nft_trace_types type;
@@ -133,17 +129,16 @@ static noinline void __nft_trace_verdict(struct nft_traceinfo *info,
 		break;
 	}
 
-	__nft_trace_packet(info, chain, type);
+	__nft_trace_packet(info, type);
 }
 
 static inline void nft_trace_verdict(struct nft_traceinfo *info,
-				     const struct nft_chain *chain,
 				     const struct nft_rule_dp *rule,
 				     const struct nft_regs *regs)
 {
 	if (static_branch_unlikely(&nft_trace_enabled)) {
 		info->rule = rule;
-		__nft_trace_verdict(info, chain, regs);
+		__nft_trace_verdict(info, regs);
 	}
 }
 
@@ -203,7 +198,6 @@ static noinline void nft_update_chain_stats(const struct nft_chain *chain,
 }
 
 struct nft_jumpstack {
-	const struct nft_chain *chain;
 	const struct nft_rule_dp *rule;
 };
 
@@ -247,7 +241,6 @@ static void expr_call_ops_eval(const struct nft_expr *expr,
 #define nft_rule_expr_first(rule)	(struct nft_expr *)&rule->data[0]
 #define nft_rule_expr_next(expr)	((void *)expr) + expr->ops->size
 #define nft_rule_expr_last(rule)	(struct nft_expr *)&rule->data[rule->dlen]
-#define nft_rule_next(rule)		(void *)rule + sizeof(*rule) + rule->dlen
 
 #define nft_rule_dp_for_each_expr(expr, last, rule) \
         for ((expr) = nft_rule_expr_first(rule), (last) = nft_rule_expr_last(rule); \
@@ -302,14 +295,14 @@ nft_do_chain(struct nft_pktinfo *pkt, void *priv)
 			nft_trace_copy_nftrace(pkt, &info);
 			continue;
 		case NFT_CONTINUE:
-			nft_trace_packet(pkt, &info, chain, rule,
+			nft_trace_packet(pkt, &info, rule,
 					 NFT_TRACETYPE_RULE);
 			continue;
 		}
 		break;
 	}
 
-	nft_trace_verdict(&info, chain, rule, &regs);
+	nft_trace_verdict(&info, rule, &regs);
 
 	switch (regs.verdict.code & NF_VERDICT_MASK) {
 	case NF_ACCEPT:
@@ -323,7 +316,6 @@ nft_do_chain(struct nft_pktinfo *pkt, void *priv)
 	case NFT_JUMP:
 		if (WARN_ON_ONCE(stackptr >= NFT_JUMP_STACK_SIZE))
 			return NF_DROP;
-		jumpstack[stackptr].chain = chain;
 		jumpstack[stackptr].rule = nft_rule_next(rule);
 		stackptr++;
 		fallthrough;
@@ -339,12 +331,11 @@ nft_do_chain(struct nft_pktinfo *pkt, void *priv)
 
 	if (stackptr > 0) {
 		stackptr--;
-		chain = jumpstack[stackptr].chain;
 		rule = jumpstack[stackptr].rule;
 		goto next_rule;
 	}
 
-	nft_trace_packet(pkt, &info, basechain, NULL, NFT_TRACETYPE_POLICY);
+	nft_trace_packet(pkt, &info, NULL, NFT_TRACETYPE_POLICY);
 
 	if (static_branch_unlikely(&nft_counters_enabled))
 		nft_update_chain_stats(basechain, pkt);
diff --git a/net/netfilter/nf_tables_trace.c b/net/netfilter/nf_tables_trace.c
index 1163ba9c1401..3d9b83d84a84 100644
--- a/net/netfilter/nf_tables_trace.c
+++ b/net/netfilter/nf_tables_trace.c
@@ -164,9 +164,29 @@ static bool nft_trace_have_verdict_chain(struct nft_traceinfo *info)
 	return true;
 }
 
+static const struct nft_chain *nft_trace_get_chain(const struct nft_traceinfo *info)
+{
+	const struct nft_rule_dp *rule = info->rule;
+	const struct nft_rule_dp_last *last;
+
+	if (!rule)
+		return &info->basechain->chain;
+
+	while (!rule->is_last)
+		rule = nft_rule_next(rule);
+
+	last = (const struct nft_rule_dp_last *)rule;
+
+	if (WARN_ON_ONCE(!last->chain))
+		return &info->basechain->chain;
+
+	return last->chain;
+}
+
 void nft_trace_notify(struct nft_traceinfo *info)
 {
 	const struct nft_pktinfo *pkt = info->pkt;
+	const struct nft_chain *chain;
 	struct nlmsghdr *nlh;
 	struct sk_buff *skb;
 	unsigned int size;
@@ -176,9 +196,11 @@ void nft_trace_notify(struct nft_traceinfo *info)
 	if (!nfnetlink_has_listeners(nft_net(pkt), NFNLGRP_NFTRACE))
 		return;
 
+	chain = nft_trace_get_chain(info);
+
 	size = nlmsg_total_size(sizeof(struct nfgenmsg)) +
-		nla_total_size(strlen(info->chain->table->name)) +
-		nla_total_size(strlen(info->chain->name)) +
+		nla_total_size(strlen(chain->table->name)) +
+		nla_total_size(strlen(chain->name)) +
 		nla_total_size_64bit(sizeof(__be64)) +	/* rule handle */
 		nla_total_size(sizeof(__be32)) +	/* trace type */
 		nla_total_size(0) +			/* VERDICT, nested */
@@ -217,10 +239,10 @@ void nft_trace_notify(struct nft_traceinfo *info)
 	if (nla_put_u32(skb, NFTA_TRACE_ID, info->skbid))
 		goto nla_put_failure;
 
-	if (nla_put_string(skb, NFTA_TRACE_CHAIN, info->chain->name))
+	if (nla_put_string(skb, NFTA_TRACE_CHAIN, chain->name))
 		goto nla_put_failure;
 
-	if (nla_put_string(skb, NFTA_TRACE_TABLE, info->chain->table->name))
+	if (nla_put_string(skb, NFTA_TRACE_TABLE, chain->table->name))
 		goto nla_put_failure;
 
 	if (nf_trace_fill_rule_info(skb, info))
-- 
2.39.2

