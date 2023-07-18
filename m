Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDB57575BF
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Jul 2023 09:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGRHxG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 Jul 2023 03:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjGRHxF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:53:05 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCD6FD;
        Tue, 18 Jul 2023 00:53:04 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qLfVw-0005dO-Uy; Tue, 18 Jul 2023 09:52:56 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 2/2] netfilter: nf_tables: use NLA_POLICY_MASK to test for valid flag options
Date:   Tue, 18 Jul 2023 09:52:30 +0200
Message-ID: <20230718075234.3863-3-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718075234.3863-1-fw@strlen.de>
References: <20230718075234.3863-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nf_tables relies on manual test of netlink attributes coming from userspace
even in cases where this could be handled via netlink policy.

Convert a bunch of 'flag' attributes to use NLA_POLICY_MASK checks.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_fib.c    | 13 +++++++------
 net/netfilter/nft_lookup.c |  6 ++----
 net/netfilter/nft_masq.c   |  8 +++-----
 net/netfilter/nft_nat.c    |  8 +++-----
 net/netfilter/nft_redir.c  |  8 +++-----
 5 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 6e049fd48760..601c9e09d07a 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -14,17 +14,18 @@
 #include <net/netfilter/nf_tables.h>
 #include <net/netfilter/nft_fib.h>
 
+#define NFTA_FIB_F_ALL (NFTA_FIB_F_SADDR | NFTA_FIB_F_DADDR | \
+			NFTA_FIB_F_MARK | NFTA_FIB_F_IIF | NFTA_FIB_F_OIF | \
+			NFTA_FIB_F_PRESENT)
+
 const struct nla_policy nft_fib_policy[NFTA_FIB_MAX + 1] = {
 	[NFTA_FIB_DREG]		= { .type = NLA_U32 },
 	[NFTA_FIB_RESULT]	= { .type = NLA_U32 },
-	[NFTA_FIB_FLAGS]	= { .type = NLA_U32 },
+	[NFTA_FIB_FLAGS]	=
+		NLA_POLICY_MASK(NLA_BE32, NFTA_FIB_F_ALL),
 };
 EXPORT_SYMBOL(nft_fib_policy);
 
-#define NFTA_FIB_F_ALL (NFTA_FIB_F_SADDR | NFTA_FIB_F_DADDR | \
-			NFTA_FIB_F_MARK | NFTA_FIB_F_IIF | NFTA_FIB_F_OIF | \
-			NFTA_FIB_F_PRESENT)
-
 int nft_fib_validate(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		     const struct nft_data **data)
 {
@@ -77,7 +78,7 @@ int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 
 	priv->flags = ntohl(nla_get_be32(tb[NFTA_FIB_FLAGS]));
 
-	if (priv->flags == 0 || (priv->flags & ~NFTA_FIB_F_ALL))
+	if (priv->flags == 0)
 		return -EINVAL;
 
 	if ((priv->flags & (NFTA_FIB_F_SADDR | NFTA_FIB_F_DADDR)) ==
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index 29ac48cdd6db..870e5b113d13 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -90,7 +90,8 @@ static const struct nla_policy nft_lookup_policy[NFTA_LOOKUP_MAX + 1] = {
 	[NFTA_LOOKUP_SET_ID]	= { .type = NLA_U32 },
 	[NFTA_LOOKUP_SREG]	= { .type = NLA_U32 },
 	[NFTA_LOOKUP_DREG]	= { .type = NLA_U32 },
-	[NFTA_LOOKUP_FLAGS]	= { .type = NLA_U32 },
+	[NFTA_LOOKUP_FLAGS]	=
+		NLA_POLICY_MASK(NLA_BE32, NFT_LOOKUP_F_INV),
 };
 
 static int nft_lookup_init(const struct nft_ctx *ctx,
@@ -120,9 +121,6 @@ static int nft_lookup_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_LOOKUP_FLAGS]) {
 		flags = ntohl(nla_get_be32(tb[NFTA_LOOKUP_FLAGS]));
 
-		if (flags & ~NFT_LOOKUP_F_INV)
-			return -EINVAL;
-
 		if (flags & NFT_LOOKUP_F_INV)
 			priv->invert = true;
 	}
diff --git a/net/netfilter/nft_masq.c b/net/netfilter/nft_masq.c
index b115d77fbbc7..8a14aaca93bb 100644
--- a/net/netfilter/nft_masq.c
+++ b/net/netfilter/nft_masq.c
@@ -20,7 +20,8 @@ struct nft_masq {
 };
 
 static const struct nla_policy nft_masq_policy[NFTA_MASQ_MAX + 1] = {
-	[NFTA_MASQ_FLAGS]		= { .type = NLA_U32 },
+	[NFTA_MASQ_FLAGS]		=
+		NLA_POLICY_MASK(NLA_BE32, NF_NAT_RANGE_MASK),
 	[NFTA_MASQ_REG_PROTO_MIN]	= { .type = NLA_U32 },
 	[NFTA_MASQ_REG_PROTO_MAX]	= { .type = NLA_U32 },
 };
@@ -47,11 +48,8 @@ static int nft_masq_init(const struct nft_ctx *ctx,
 	struct nft_masq *priv = nft_expr_priv(expr);
 	int err;
 
-	if (tb[NFTA_MASQ_FLAGS]) {
+	if (tb[NFTA_MASQ_FLAGS])
 		priv->flags = ntohl(nla_get_be32(tb[NFTA_MASQ_FLAGS]));
-		if (priv->flags & ~NF_NAT_RANGE_MASK)
-			return -EINVAL;
-	}
 
 	if (tb[NFTA_MASQ_REG_PROTO_MIN]) {
 		err = nft_parse_register_load(tb[NFTA_MASQ_REG_PROTO_MIN],
diff --git a/net/netfilter/nft_nat.c b/net/netfilter/nft_nat.c
index 5c29915ab028..583885ce7232 100644
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -132,7 +132,8 @@ static const struct nla_policy nft_nat_policy[NFTA_NAT_MAX + 1] = {
 	[NFTA_NAT_REG_ADDR_MAX]	 = { .type = NLA_U32 },
 	[NFTA_NAT_REG_PROTO_MIN] = { .type = NLA_U32 },
 	[NFTA_NAT_REG_PROTO_MAX] = { .type = NLA_U32 },
-	[NFTA_NAT_FLAGS]	 = { .type = NLA_U32 },
+	[NFTA_NAT_FLAGS]	 =
+		NLA_POLICY_MASK(NLA_BE32, NF_NAT_RANGE_MASK),
 };
 
 static int nft_nat_validate(const struct nft_ctx *ctx,
@@ -246,11 +247,8 @@ static int nft_nat_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		priv->flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
 	}
 
-	if (tb[NFTA_NAT_FLAGS]) {
+	if (tb[NFTA_NAT_FLAGS])
 		priv->flags |= ntohl(nla_get_be32(tb[NFTA_NAT_FLAGS]));
-		if (priv->flags & ~NF_NAT_RANGE_MASK)
-			return -EOPNOTSUPP;
-	}
 
 	return nf_ct_netns_get(ctx->net, family);
 }
diff --git a/net/netfilter/nft_redir.c b/net/netfilter/nft_redir.c
index a70196ffcb1e..a58bd8d291ff 100644
--- a/net/netfilter/nft_redir.c
+++ b/net/netfilter/nft_redir.c
@@ -22,7 +22,8 @@ struct nft_redir {
 static const struct nla_policy nft_redir_policy[NFTA_REDIR_MAX + 1] = {
 	[NFTA_REDIR_REG_PROTO_MIN]	= { .type = NLA_U32 },
 	[NFTA_REDIR_REG_PROTO_MAX]	= { .type = NLA_U32 },
-	[NFTA_REDIR_FLAGS]		= { .type = NLA_U32 },
+	[NFTA_REDIR_FLAGS]		=
+		NLA_POLICY_MASK(NLA_BE32, NF_NAT_RANGE_MASK),
 };
 
 static int nft_redir_validate(const struct nft_ctx *ctx,
@@ -68,11 +69,8 @@ static int nft_redir_init(const struct nft_ctx *ctx,
 		priv->flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
 	}
 
-	if (tb[NFTA_REDIR_FLAGS]) {
+	if (tb[NFTA_REDIR_FLAGS])
 		priv->flags = ntohl(nla_get_be32(tb[NFTA_REDIR_FLAGS]));
-		if (priv->flags & ~NF_NAT_RANGE_MASK)
-			return -EINVAL;
-	}
 
 	return nf_ct_netns_get(ctx->net, ctx->family);
 }
-- 
2.41.0

