Return-Path: <netfilter-devel+bounces-4866-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D822A9BB00D
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Nov 2024 10:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164CA1C21C69
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Nov 2024 09:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3991AC428;
	Mon,  4 Nov 2024 09:44:18 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1DB1AE018
	for <netfilter-devel@vger.kernel.org>; Mon,  4 Nov 2024 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713458; cv=none; b=gcewMpBSSC99tnpaDRFLaJ9Me7BQxHsw+uwpgNlqTiBXrUDt9pd2VtzPNvtPPn1b+vf/iNqy+eChulZ+EaOvKkYt2/xQn4J0+kNFdTA0fyre/AC3bhet3k/y8n71VUocT2U8ADmUeiEZI/PrYH9tB1J0AZ4myICcxWclaQmrYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713458; c=relaxed/simple;
	bh=uMl0mh+EXUDaI7OrhBMbLKtvRz0+bmGuaq0zujsa/yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edvdmm1+kkuh22t1UMF/bToHYNNRRfJ9/4nStgyzGEe23uJL4QX5T3awK5oUERhznORk/L0+uf+EI7P7fyKwtFZxTEktubkhNbJBf9qissZyW2jkzfAaYpe09GXvVZicPYGKQ2cmkwFQZqVE4GZeKZ2G0zXB+MxQVwX3ii5o7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1t7td8-0003c3-B9; Mon, 04 Nov 2024 10:44:14 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH nf-next v3 1/7] netfilter: nf_tables: avoid false-positive lockdep splat on rule deletion
Date: Mon,  4 Nov 2024 10:41:13 +0100
Message-ID: <20241104094126.16917-2-fw@strlen.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104094126.16917-1-fw@strlen.de>
References: <20241104094126.16917-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On rule delete we get:
 WARNING: suspicious RCU usage
 net/netfilter/nf_tables_api.c:3420 RCU-list traversed in non-reader section!!
 1 lock held by iptables/134:
   #0: ffff888008c4fcc8 (&nft_net->commit_mutex){+.+.}-{3:3}, at: nf_tables_valid_genid (include/linux/jiffies.h:101) nf_tables

Code is fine, no other CPU can change the list because we're holding
transaction mutex.

Pass the needed lockdep annotation to the iterator and fix
two comments for functions that are no longer restricted to rcu-only
context.

This is enough to resolve rule delete, but there are several other
missing annotations, added in followup-patches.

Fixes: 28875945ba98 ("rcu: Add support for consolidated-RCU reader checking")
Reported-by: Matthieu Baerts <matttbe@kernel.org>
Tested-by: Matthieu Baerts <matttbe@kernel.org>
Closes: https://lore.kernel.org/netfilter-devel/da27f17f-3145-47af-ad0f-7fd2a823623e@kernel.org/
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 30331688301e..80c285ac7e07 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3411,13 +3411,15 @@ void nft_expr_destroy(const struct nft_ctx *ctx, struct nft_expr *expr)
  * Rules
  */
 
-static struct nft_rule *__nft_rule_lookup(const struct nft_chain *chain,
+static struct nft_rule *__nft_rule_lookup(const struct net *net,
+					  const struct nft_chain *chain,
 					  u64 handle)
 {
 	struct nft_rule *rule;
 
 	// FIXME: this sucks
-	list_for_each_entry_rcu(rule, &chain->rules, list) {
+	list_for_each_entry_rcu(rule, &chain->rules, list,
+				lockdep_commit_lock_is_held(net)) {
 		if (handle == rule->handle)
 			return rule;
 	}
@@ -3425,13 +3427,14 @@ static struct nft_rule *__nft_rule_lookup(const struct nft_chain *chain,
 	return ERR_PTR(-ENOENT);
 }
 
-static struct nft_rule *nft_rule_lookup(const struct nft_chain *chain,
+static struct nft_rule *nft_rule_lookup(const struct net *net,
+					const struct nft_chain *chain,
 					const struct nlattr *nla)
 {
 	if (nla == NULL)
 		return ERR_PTR(-EINVAL);
 
-	return __nft_rule_lookup(chain, be64_to_cpu(nla_get_be64(nla)));
+	return __nft_rule_lookup(net, chain, be64_to_cpu(nla_get_be64(nla)));
 }
 
 static const struct nla_policy nft_rule_policy[NFTA_RULE_MAX + 1] = {
@@ -3732,7 +3735,7 @@ static int nf_tables_dump_rules_done(struct netlink_callback *cb)
 	return 0;
 }
 
-/* called with rcu_read_lock held */
+/* Caller must hold rcu read lock or transaction mutex */
 static struct sk_buff *
 nf_tables_getrule_single(u32 portid, const struct nfnl_info *info,
 			 const struct nlattr * const nla[], bool reset)
@@ -3759,7 +3762,7 @@ nf_tables_getrule_single(u32 portid, const struct nfnl_info *info,
 		return ERR_CAST(chain);
 	}
 
-	rule = nft_rule_lookup(chain, nla[NFTA_RULE_HANDLE]);
+	rule = nft_rule_lookup(net, chain, nla[NFTA_RULE_HANDLE]);
 	if (IS_ERR(rule)) {
 		NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_HANDLE]);
 		return ERR_CAST(rule);
@@ -4057,7 +4060,7 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 
 	if (nla[NFTA_RULE_HANDLE]) {
 		handle = be64_to_cpu(nla_get_be64(nla[NFTA_RULE_HANDLE]));
-		rule = __nft_rule_lookup(chain, handle);
+		rule = __nft_rule_lookup(net, chain, handle);
 		if (IS_ERR(rule)) {
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_HANDLE]);
 			return PTR_ERR(rule);
@@ -4079,7 +4082,7 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 
 		if (nla[NFTA_RULE_POSITION]) {
 			pos_handle = be64_to_cpu(nla_get_be64(nla[NFTA_RULE_POSITION]));
-			old_rule = __nft_rule_lookup(chain, pos_handle);
+			old_rule = __nft_rule_lookup(net, chain, pos_handle);
 			if (IS_ERR(old_rule)) {
 				NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_POSITION]);
 				return PTR_ERR(old_rule);
@@ -4296,7 +4299,7 @@ static int nf_tables_delrule(struct sk_buff *skb, const struct nfnl_info *info,
 
 	if (chain) {
 		if (nla[NFTA_RULE_HANDLE]) {
-			rule = nft_rule_lookup(chain, nla[NFTA_RULE_HANDLE]);
+			rule = nft_rule_lookup(info->net, chain, nla[NFTA_RULE_HANDLE]);
 			if (IS_ERR(rule)) {
 				if (PTR_ERR(rule) == -ENOENT &&
 				    NFNL_MSG_TYPE(info->nlh->nlmsg_type) == NFT_MSG_DESTROYRULE)
@@ -8101,7 +8104,7 @@ static int nf_tables_dump_obj_done(struct netlink_callback *cb)
 	return 0;
 }
 
-/* called with rcu_read_lock held */
+/* Caller must hold rcu read lock or transaction mutex */
 static struct sk_buff *
 nf_tables_getobj_single(u32 portid, const struct nfnl_info *info,
 			const struct nlattr * const nla[], bool reset)
-- 
2.45.2


