Return-Path: <netfilter-devel+bounces-4721-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2199B04AA
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Oct 2024 15:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B30284411
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Oct 2024 13:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AB41E00BF;
	Fri, 25 Oct 2024 13:54:39 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8C4A1B
	for <netfilter-devel@vger.kernel.org>; Fri, 25 Oct 2024 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864479; cv=none; b=Ep3AasJ5OjTe4nJid2nQojaWw0uS4iQJSz7swK6bvxVkM1nlwe+qvr+EBZHpJ2r7xRqjXBS1uF3fv0S1Qc7UFpubrPR08RhOzwXr2HLi6wRa/WezyIakqn/cPZKZfWNnDlAkGBZZjUN3aMl4Kmf0nuXLTtjTGH/J7GdvHq3Rh60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864479; c=relaxed/simple;
	bh=+Y+7V5h8CMo2PAdYPx9r8lIlLGTO1FwSzJ06h0wklXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJ5T6OQ6byoyHmuCrupblHDe75/s2WlOCtpHYwdIhRIQ841zOYdvJ2Cd7r/lOBCvP6AYjteoTG09xSoFJY1NowsO2oBt0zSMaPa1n3RSviTNS208WjLGM4GnVlcLeUMOTscyydNameQjxkRSlteuY646KFT+DSy0QHOAWEcJcv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1t4Klw-0005y6-1q; Fri, 25 Oct 2024 15:54:36 +0200
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 3/7] netfilter: nf_tables: avoid false-positive lockdep splats with flowtables
Date: Fri, 25 Oct 2024 15:32:20 +0200
Message-ID: <20241025133230.22491-4-fw@strlen.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241025133230.22491-1-fw@strlen.de>
References: <20241025133230.22491-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The transaction mutex prevents concurrent add/delete, its ok to iterate
those lists outside of rcu read side critical sections.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_tables.h |  3 ++-
 net/netfilter/nf_tables_api.c     | 15 +++++++++------
 net/netfilter/nft_flow_offload.c  |  4 ++--
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 91ae20cb7648..c1513bd14568 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1463,7 +1463,8 @@ struct nft_flowtable {
 	struct nf_flowtable		data;
 };
 
-struct nft_flowtable *nft_flowtable_lookup(const struct nft_table *table,
+struct nft_flowtable *nft_flowtable_lookup(const struct net *net,
+					   const struct nft_table *table,
 					   const struct nlattr *nla,
 					   u8 genmask);
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a51731d76401..9e367e134691 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8378,12 +8378,14 @@ static const struct nla_policy nft_flowtable_policy[NFTA_FLOWTABLE_MAX + 1] = {
 	[NFTA_FLOWTABLE_FLAGS]		= { .type = NLA_U32 },
 };
 
-struct nft_flowtable *nft_flowtable_lookup(const struct nft_table *table,
+struct nft_flowtable *nft_flowtable_lookup(const struct net *net,
+					   const struct nft_table *table,
 					   const struct nlattr *nla, u8 genmask)
 {
 	struct nft_flowtable *flowtable;
 
-	list_for_each_entry_rcu(flowtable, &table->flowtables, list) {
+	list_for_each_entry_rcu(flowtable, &table->flowtables, list,
+				lockdep_commit_lock_is_held(net)) {
 		if (!nla_strcmp(nla, flowtable->name) &&
 		    nft_active_genmask(flowtable, genmask))
 			return flowtable;
@@ -8739,7 +8741,7 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 		return PTR_ERR(table);
 	}
 
-	flowtable = nft_flowtable_lookup(table, nla[NFTA_FLOWTABLE_NAME],
+	flowtable = nft_flowtable_lookup(net, table, nla[NFTA_FLOWTABLE_NAME],
 					 genmask);
 	if (IS_ERR(flowtable)) {
 		err = PTR_ERR(flowtable);
@@ -8933,7 +8935,7 @@ static int nf_tables_delflowtable(struct sk_buff *skb,
 		flowtable = nft_flowtable_lookup_byhandle(table, attr, genmask);
 	} else {
 		attr = nla[NFTA_FLOWTABLE_NAME];
-		flowtable = nft_flowtable_lookup(table, attr, genmask);
+		flowtable = nft_flowtable_lookup(net, table, attr, genmask);
 	}
 
 	if (IS_ERR(flowtable)) {
@@ -9003,7 +9005,8 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 	if (!hook_list)
 		hook_list = &flowtable->hook_list;
 
-	list_for_each_entry_rcu(hook, hook_list, list) {
+	list_for_each_entry_rcu(hook, hook_list, list,
+				lockdep_commit_lock_is_held(net)) {
 		if (nla_put_string(skb, NFTA_DEVICE_NAME, hook->ops.dev->name))
 			goto nla_put_failure;
 	}
@@ -9145,7 +9148,7 @@ static int nf_tables_getflowtable(struct sk_buff *skb,
 		return PTR_ERR(table);
 	}
 
-	flowtable = nft_flowtable_lookup(table, nla[NFTA_FLOWTABLE_NAME],
+	flowtable = nft_flowtable_lookup(net, table, nla[NFTA_FLOWTABLE_NAME],
 					 genmask);
 	if (IS_ERR(flowtable)) {
 		NL_SET_BAD_ATTR(extack, nla[NFTA_FLOWTABLE_NAME]);
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 2f732fae5a83..65199c23c75c 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -409,8 +409,8 @@ static int nft_flow_offload_init(const struct nft_ctx *ctx,
 	if (!tb[NFTA_FLOW_TABLE_NAME])
 		return -EINVAL;
 
-	flowtable = nft_flowtable_lookup(ctx->table, tb[NFTA_FLOW_TABLE_NAME],
-					 genmask);
+	flowtable = nft_flowtable_lookup(ctx->net, ctx->table,
+					 tb[NFTA_FLOW_TABLE_NAME], genmask);
 	if (IS_ERR(flowtable))
 		return PTR_ERR(flowtable);
 
-- 
2.45.2


