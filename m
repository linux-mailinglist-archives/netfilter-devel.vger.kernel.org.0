Return-Path: <netfilter-devel+bounces-12280-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM1wGW+d8WlfiwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12280-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 07:55:59 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B58C448F95F
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 07:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE327302797B
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 05:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CEC33A9F3;
	Wed, 29 Apr 2026 05:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="AIAfzYwM"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FB4299948
	for <netfilter-devel@vger.kernel.org>; Wed, 29 Apr 2026 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777442138; cv=none; b=YWuEsniWiS9a9U/Su4CWKv0GnFHbg+0XJuxiALkLjjAhJjZEtGVgtX1gw3mI+hAoLLWeTK4sJrb56WSjwhNmd415oAOolXhoeWV+7NbjG8b0IWiJp0QKrCPBXyq2BsoX3NN15nXrjkF3iy2SkuzjUl7bfYMv93BFkBpNXwGRVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777442138; c=relaxed/simple;
	bh=JG42MYuECap9MeD+3XqztVYPkp8Vs1CXy8iMxFfJBjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaqBSbiQXVXq2p8G1e/RSJO4XqH4yv/AcjI0UcXNrb32aMvEpua8UPs7TUOwPZOF9P/YWk71XUg3XFGZCnHmU+c9x4BLHgoyIMrdS3AUEqpabHke8e9ekoujIs9lR/K9TXpKII1cZt7fSrxn4rfFycwSD5oJdYpfDhWYiAs8T0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=AIAfzYwM; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 102B9602A0;
	Wed, 29 Apr 2026 07:55:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1777442135;
	bh=RhANZcwapRweOFCO/gSCAmHoSRoWSiz8B5pj9xAsJDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIAfzYwMhI5bPcsMQBfEzIgZTuRxwjR2L125ae/+IYJsgTpiglq/GBOUR5rCYeJLW
	 h02tnD3DKyejBeFXUSREsTr5kPOTcrUb7vnjLC+MMrUACgV3INjZwBwnJNwlm6Q6lo
	 mhq/74t0uzfS+GbN6BwMNjeLc5iUJ1X2JoPvJWDBdiwTX9vt9IReVsoRVekmZrV5Gm
	 Yl/QBChBlPTJgH1TOqvFnpb1ikYolDG9E5iMb1X9oy7SDI1V3BikgFElz5hJZr2bi7
	 dfyJzXm0SChXOkE0kdR2fXmPnqZNjmOlbe2zrGXX4ggiLdI2foseR4K3fKy3apZWXI
	 feutDGZBuC3og==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nf,v2 2/2] netfilter: nft_compat: run checkentry() from .validate
Date: Wed, 29 Apr 2026 07:55:29 +0200
Message-ID: <20260429055529.104504-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429055529.104504-1-pablo@netfilter.org>
References: <20260429055529.104504-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B58C448F95F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12280-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[netfilter.org:s=2025];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	GREYLIST(0.00)[pass,meta];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_SPAM(0.00)[0.352];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]

Several matches and one target check that the hook is correct from
checkentry(), however, the basechain is only available from
nft_table_validate().

This patch uses .check_hooks() for matches and targets from the
nft_compat expression .validate path.

This patch sets the table in the nft_ctx struct in nft_table_validate()
which is required by this patch.

Based on patch from Florian Westphal.

Fixes: 0ca743a55991 ("netfilter: nf_tables: add compatibility layer for x_tables")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: - adjust commit description to current approach
    - remove double check for nft_is_base_chain()
    - propagate error in xt_check_hooks_target() call
    - remove redudannt call to xt_check_hooks_{match,target}() from .init

 net/netfilter/nf_tables_api.c |  1 +
 net/netfilter/nft_compat.c    | 44 +++++++++++++++++++++++++++++------
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d20ce5c36d31..38e33c66c618 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4205,6 +4205,7 @@ static int nft_table_validate(struct net *net, const struct nft_table *table)
 	struct nft_chain *chain;
 	struct nft_ctx ctx = {
 		.net	= net,
+		.table	= (struct nft_table *)table,
 		.family	= table->family,
 	v};
 	int err = 0;
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index decc725a33c2..abdf3aad0928 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -261,10 +261,10 @@ nft_target_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 			return ret;
 	}
 
-	nft_target_set_tgchk_param(&par, ctx, target, info, &e, proto, inv);
-
 	nft_compat_wait_for_destructors(ctx->net);
 
+	nft_target_set_tgchk_param(&par, ctx, target, info, &e, proto, inv);
+
 	ret = xt_check_target(&par, size, proto, inv);
 	if (ret < 0) {
 		if (ret == -ENOENT) {
@@ -353,7 +353,6 @@ static int nft_target_dump(struct sk_buff *skb,
 static int nft_target_validate(const struct nft_ctx *ctx,
 			       const struct nft_expr *expr)
 {
-	struct xt_target *target = expr->ops->data;
 	unsigned int hook_mask = 0;
 	int ret;
 
@@ -377,11 +376,21 @@ static int nft_target_validate(const struct nft_ctx *ctx,
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
 		const struct nf_hook_ops *ops = &basechain->ops;
+		struct xt_target *target = expr->ops->data;
+		void *info = nft_expr_priv(expr);
+		struct xt_tgchk_param par;
+		union nft_entry e = {};
 
 		hook_mask = 1 << ops->hooknum;
 		if (target->hooks && !(hook_mask & target->hooks))
 			return -EINVAL;
 
+		nft_target_set_tgchk_param(&par, ctx, target, info, &e, 0, false);
+
+		ret = xt_check_hooks_target(&par);
+		if (ret < 0)
+			return ret;
+
 		ret = nft_compat_chain_validate_dependency(ctx, target->table);
 		if (ret < 0)
 			return ret;
@@ -515,10 +524,10 @@ __nft_match_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 			return ret;
 	}
 
-	nft_match_set_mtchk_param(&par, ctx, match, info, &e, proto, inv);
-
 	nft_compat_wait_for_destructors(ctx->net);
 
+	nft_match_set_mtchk_param(&par, ctx, match, info, &e, proto, inv);
+
 	return xt_check_match(&par, size, proto, inv);
 }
 
@@ -614,8 +623,6 @@ static int nft_match_large_dump(struct sk_buff *skb,
 static int nft_match_validate(const struct nft_ctx *ctx,
 			      const struct nft_expr *expr)
 {
-	struct xt_match *match = expr->ops->data;
-	unsigned int hook_mask = 0;
 	int ret;
 
 	if (ctx->family != NFPROTO_IPV4 &&
@@ -638,11 +645,34 @@ static int nft_match_validate(const struct nft_ctx *ctx,
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
 		const struct nf_hook_ops *ops = &basechain->ops;
+		unsigned int hook_mask = 1 << ops->hooknum;
+		struct xt_match *match = expr->ops->data;
+		size_t size = XT_ALIGN(match->matchsize);
+		struct xt_mtchk_param par;
+		union nft_entry e = {};
+		void *info;
 
 		hook_mask = 1 << ops->hooknum;
 		if (match->hooks && !(hook_mask & match->hooks))
 			return -EINVAL;
 
+		if (NFT_EXPR_SIZE(size) > NFT_MATCH_LARGE_THRESH) {
+			struct nft_xt_match_priv *priv = nft_expr_priv(expr);
+
+			info = priv->info;
+		} else {
+			info = nft_expr_priv(expr);
+		}
+
+		if (match->hooks && !(hook_mask & match->hooks))
+			return -EINVAL;
+
+		nft_match_set_mtchk_param(&par, ctx, match, info, &e, 0, false);
+
+		ret = xt_check_hooks_match(&par);
+		if (ret < 0)
+			return ret;
+
 		ret = nft_compat_chain_validate_dependency(ctx, match->table);
 		if (ret < 0)
 			return ret;
-- 
2.47.3


