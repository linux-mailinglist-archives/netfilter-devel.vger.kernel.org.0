Return-Path: <netfilter-devel+bounces-765-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF2B83B1EF
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jan 2024 20:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD361F235EF
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jan 2024 19:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF48813342D;
	Wed, 24 Jan 2024 19:12:59 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2492132C10;
	Wed, 24 Jan 2024 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123579; cv=none; b=at8bPGD6FIf0bcqG3EmbZe4Bz6wUJAhKdtbJ7kYIhafGTDjT9KEW1NxFHVYQzbAJ2DKmjW93AXxFxSP5nTcC5nzbUxQ99rpy/MvTDgQemWLogDOO7qKMaNpewQvPJwJ7syPYD+ULrjXAn/oVDRsf219GXNzfiviQ8gc91Lcw+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123579; c=relaxed/simple;
	bh=WL5tGIwU6oaPtagTXFU0CYWlH+uOCIWUgqsE+PPyLz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FdXmnmOBW8yv1QZuSQj1aoCERrZaVwBBD5E0DnY/AguqQzYj9rz/79Ug/f7qJ5W1vgI1rF1MHSz5CAB5NDypOlcZWaFWjvQkHQfryjf65nWHN20RFOA4NO0DmFuxMLbS96zCOzZPSziRvYneW6Inc3L0Me5Q2/3et9A/S1doDNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 6/6] netfilter: nf_tables: validate NFPROTO_* family
Date: Wed, 24 Jan 2024 20:12:48 +0100
Message-Id: <20240124191248.75463-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240124191248.75463-1-pablo@netfilter.org>
References: <20240124191248.75463-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several expressions explicitly refer to NF_INET_* hook definitions
from expr->ops->validate, however, family is not validated.

Bail out with EOPNOTSUPP in case they are used from unsupported
families.

Fixes: 0ca743a55991 ("netfilter: nf_tables: add compatibility layer for x_tables")
Fixes: a3c90f7a2323 ("netfilter: nf_tables: flow offload expression")
Fixes: 2fa841938c64 ("netfilter: nf_tables: introduce routing expression")
Fixes: 554ced0a6e29 ("netfilter: nf_tables: add support for native socket matching")
Fixes: ad49d86e07a4 ("netfilter: nf_tables: Add synproxy support")
Fixes: 4ed8eb6570a4 ("netfilter: nf_tables: Add native tproxy support")
Fixes: 6c47260250fc ("netfilter: nf_tables: add xfrm expression")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_compat.c       | 12 ++++++++++++
 net/netfilter/nft_flow_offload.c |  5 +++++
 net/netfilter/nft_nat.c          |  5 +++++
 net/netfilter/nft_rt.c           |  5 +++++
 net/netfilter/nft_socket.c       |  5 +++++
 net/netfilter/nft_synproxy.c     |  7 +++++--
 net/netfilter/nft_tproxy.c       |  5 +++++
 net/netfilter/nft_xfrm.c         |  5 +++++
 8 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 5284cd2ad532..f0eeda97bfcd 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -350,6 +350,12 @@ static int nft_target_validate(const struct nft_ctx *ctx,
 	unsigned int hook_mask = 0;
 	int ret;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_BRIDGE &&
+	    ctx->family != NFPROTO_ARP)
+		return -EOPNOTSUPP;
+
 	if (nft_is_base_chain(ctx->chain)) {
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
@@ -595,6 +601,12 @@ static int nft_match_validate(const struct nft_ctx *ctx,
 	unsigned int hook_mask = 0;
 	int ret;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_BRIDGE &&
+	    ctx->family != NFPROTO_ARP)
+		return -EOPNOTSUPP;
+
 	if (nft_is_base_chain(ctx->chain)) {
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index ab3362c483b4..397351fa4d5f 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -384,6 +384,11 @@ static int nft_flow_offload_validate(const struct nft_ctx *ctx,
 {
 	unsigned int hook_mask = (1 << NF_INET_FORWARD);
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain, hook_mask);
 }
 
diff --git a/net/netfilter/nft_nat.c b/net/netfilter/nft_nat.c
index 583885ce7232..808f5802c270 100644
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -143,6 +143,11 @@ static int nft_nat_validate(const struct nft_ctx *ctx,
 	struct nft_nat *priv = nft_expr_priv(expr);
 	int err;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	err = nft_chain_validate_dependency(ctx->chain, NFT_CHAIN_T_NAT);
 	if (err < 0)
 		return err;
diff --git a/net/netfilter/nft_rt.c b/net/netfilter/nft_rt.c
index 35a2c28caa60..24d977138572 100644
--- a/net/netfilter/nft_rt.c
+++ b/net/netfilter/nft_rt.c
@@ -166,6 +166,11 @@ static int nft_rt_validate(const struct nft_ctx *ctx, const struct nft_expr *exp
 	const struct nft_rt *priv = nft_expr_priv(expr);
 	unsigned int hooks;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	switch (priv->key) {
 	case NFT_RT_NEXTHOP4:
 	case NFT_RT_NEXTHOP6:
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 9ed85be79452..f30163e2ca62 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -242,6 +242,11 @@ static int nft_socket_validate(const struct nft_ctx *ctx,
 			       const struct nft_expr *expr,
 			       const struct nft_data **data)
 {
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain,
 					(1 << NF_INET_PRE_ROUTING) |
 					(1 << NF_INET_LOCAL_IN) |
diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
index 13da882669a4..1d737f89dfc1 100644
--- a/net/netfilter/nft_synproxy.c
+++ b/net/netfilter/nft_synproxy.c
@@ -186,7 +186,6 @@ static int nft_synproxy_do_init(const struct nft_ctx *ctx,
 		break;
 #endif
 	case NFPROTO_INET:
-	case NFPROTO_BRIDGE:
 		err = nf_synproxy_ipv4_init(snet, ctx->net);
 		if (err)
 			goto nf_ct_failure;
@@ -219,7 +218,6 @@ static void nft_synproxy_do_destroy(const struct nft_ctx *ctx)
 		break;
 #endif
 	case NFPROTO_INET:
-	case NFPROTO_BRIDGE:
 		nf_synproxy_ipv4_fini(snet, ctx->net);
 		nf_synproxy_ipv6_fini(snet, ctx->net);
 		break;
@@ -253,6 +251,11 @@ static int nft_synproxy_validate(const struct nft_ctx *ctx,
 				 const struct nft_expr *expr,
 				 const struct nft_data **data)
 {
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain, (1 << NF_INET_LOCAL_IN) |
 						    (1 << NF_INET_FORWARD));
 }
diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index ae15cd693f0e..71412adb73d4 100644
--- a/net/netfilter/nft_tproxy.c
+++ b/net/netfilter/nft_tproxy.c
@@ -316,6 +316,11 @@ static int nft_tproxy_validate(const struct nft_ctx *ctx,
 			       const struct nft_expr *expr,
 			       const struct nft_data **data)
 {
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	return nft_chain_validate_hooks(ctx->chain, 1 << NF_INET_PRE_ROUTING);
 }
 
diff --git a/net/netfilter/nft_xfrm.c b/net/netfilter/nft_xfrm.c
index 452f8587adda..1c866757db55 100644
--- a/net/netfilter/nft_xfrm.c
+++ b/net/netfilter/nft_xfrm.c
@@ -235,6 +235,11 @@ static int nft_xfrm_validate(const struct nft_ctx *ctx, const struct nft_expr *e
 	const struct nft_xfrm *priv = nft_expr_priv(expr);
 	unsigned int hooks;
 
+	if (ctx->family != NFPROTO_IPV4 &&
+	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET)
+		return -EOPNOTSUPP;
+
 	switch (priv->dir) {
 	case XFRM_POLICY_IN:
 		hooks = (1 << NF_INET_FORWARD) |
-- 
2.30.2


