Return-Path: <netfilter-devel+bounces-13314-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0U3GN4+NM2o9DQYAu9opvQ
	(envelope-from <netfilter-devel+bounces-13314-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 08:17:51 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C0669DD03
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 08:17:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13314-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13314-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D947301F4AC
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 06:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10D83264DC;
	Thu, 18 Jun 2026 06:17:20 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74712D5436
	for <netfilter-devel@vger.kernel.org>; Thu, 18 Jun 2026 06:17:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763440; cv=none; b=Cz+5UhsW1LEkgmdO+nY7+b2JyssnbnGFfl5yPNx9kCoKNd4YWf/MIRtSJMlW69FVCArFUhIaSoY1vQBRZxCbCLRpWFDc432CCOdY20zc9LErUqpsEf5oGJ/2p9T/K6n8kcByUPrwZbKapaZsPB7z7dhhAOg/X+SjSshhA0UmpN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763440; c=relaxed/simple;
	bh=0fgVizMUVFIY/6QyWuvd6K09GzFWVvTg99m9ZOsIMkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHV1GPo1VeKgJdToj8rZDsAw9+uXd/QzGZ1F98LcaAq1ATrBAgR+nCwP7OAURLP1DwG2uUSrPMjZHcs/kRv7tPc9FiVKU7SmwoEx8o6WrTWH38j4PjWjmY+tVhvgGz1RUU2p9+7wF5LrZnWYYThp4TgkU0omgc0Epcc5dKQg1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3861160541; Thu, 18 Jun 2026 08:17:16 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: nft_meta_bridge: add validate callback for get operations
Date: Thu, 18 Jun 2026 08:16:18 +0200
Message-ID: <20260618061631.21919-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13314-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,strlen.de:email,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43C0669DD03

Blamed commit added NFT_META_BRI_IIFHWADDR to the set validate callback,
yet this is a get operation.

Add a get validate callback and move the NFT_META_BRI_IIFHWADDR key
there.

AFAICS this is harmless, NFT_META_BRI_IIFHWADDR can deal with a NULL
input device and the set handler ignores a NFT_META_BRI_IIFHWADDR
operation, but it allows to read 4 bytes off bridge skb->cb[].

Fixes: cbd2257dc96e ("netfilter: nft_meta_bridge: introduce NFT_META_BRI_IIFHWADDR support")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nft_meta.h       |  2 ++
 net/bridge/netfilter/nft_meta_bridge.c | 19 ++++++++++++++++++-
 net/netfilter/nft_meta.c               |  5 +++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/net/netfilter/nft_meta.h b/include/net/netfilter/nft_meta.h
index f74e63290603..6cf1d910bbf8 100644
--- a/include/net/netfilter/nft_meta.h
+++ b/include/net/netfilter/nft_meta.h
@@ -40,6 +40,8 @@ void nft_meta_set_eval(const struct nft_expr *expr,
 void nft_meta_set_destroy(const struct nft_ctx *ctx,
 			  const struct nft_expr *expr);
 
+int nft_meta_get_validate(const struct nft_ctx *ctx,
+			  const struct nft_expr *expr);
 int nft_meta_set_validate(const struct nft_ctx *ctx,
 			  const struct nft_expr *expr);
 
diff --git a/net/bridge/netfilter/nft_meta_bridge.c b/net/bridge/netfilter/nft_meta_bridge.c
index 219c40680260..3d95f68e0906 100644
--- a/net/bridge/netfilter/nft_meta_bridge.c
+++ b/net/bridge/netfilter/nft_meta_bridge.c
@@ -107,12 +107,30 @@ static int nft_meta_bridge_get_init(const struct nft_ctx *ctx,
 					NULL, NFT_DATA_VALUE, len);
 }
 
+static int nft_meta_bridge_get_validate(const struct nft_ctx *ctx,
+					const struct nft_expr *expr)
+{
+	struct nft_meta *priv = nft_expr_priv(expr);
+	unsigned int hooks;
+
+	switch (priv->key) {
+	case NFT_META_BRI_IIFHWADDR:
+		hooks = 1 << NF_BR_PRE_ROUTING;
+		break;
+	default:
+		return nft_meta_get_validate(ctx, expr);
+	}
+
+	return nft_chain_validate_hooks(ctx->chain, hooks);
+}
+
 static struct nft_expr_type nft_meta_bridge_type;
 static const struct nft_expr_ops nft_meta_bridge_get_ops = {
 	.type		= &nft_meta_bridge_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_meta)),
 	.eval		= nft_meta_bridge_get_eval,
 	.init		= nft_meta_bridge_get_init,
+	.validate	= nft_meta_bridge_get_validate,
 	.dump		= nft_meta_get_dump,
 };
 
@@ -168,7 +186,6 @@ static int nft_meta_bridge_set_validate(const struct nft_ctx *ctx,
 
 	switch (priv->key) {
 	case NFT_META_BRI_BROUTE:
-	case NFT_META_BRI_IIFHWADDR:
 		hooks = 1 << NF_BR_PRE_ROUTING;
 		break;
 	default:
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 5b25851381e5..db937d66210d 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -635,8 +635,8 @@ static int nft_meta_get_validate_xfrm(const struct nft_ctx *ctx)
 #endif
 }
 
-static int nft_meta_get_validate(const struct nft_ctx *ctx,
-				 const struct nft_expr *expr)
+int nft_meta_get_validate(const struct nft_ctx *ctx,
+			  const struct nft_expr *expr)
 {
 	const struct nft_meta *priv = nft_expr_priv(expr);
 
@@ -652,6 +652,7 @@ static int nft_meta_get_validate(const struct nft_ctx *ctx,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nft_meta_get_validate);
 
 int nft_meta_set_validate(const struct nft_ctx *ctx,
 			  const struct nft_expr *expr)
-- 
2.53.0


