Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E1A97626
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 11:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfHUJ10 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Aug 2019 05:27:26 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:43820 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfHUJ10 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:27:26 -0400
Received: from localhost ([::1]:56910 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1i0Mto-00058L-E1; Wed, 21 Aug 2019 11:27:24 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 13/14] nft: Support parsing lookup expression
Date:   Wed, 21 Aug 2019 11:26:01 +0200
Message-Id: <20190821092602.16292-14-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821092602.16292-1-phil@nwl.cc>
References: <20190821092602.16292-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add required glue code to support family specific lookup expression
parsers implemented as family_ops callback.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-shared.c | 9 +++++++++
 iptables/nft-shared.h | 2 ++
 iptables/nft.c        | 5 ++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/iptables/nft-shared.c b/iptables/nft-shared.c
index 5615dfae00569..1c540ccfb70e1 100644
--- a/iptables/nft-shared.c
+++ b/iptables/nft-shared.c
@@ -588,6 +588,13 @@ static void nft_parse_limit(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
 		ctx->h->ops->parse_match(match, ctx->cs);
 }
 
+static void nft_parse_lookup(struct nft_xt_ctx *ctx, struct nft_handle *h,
+			     struct nftnl_expr *e)
+{
+	if (ctx->h->ops->parse_lookup)
+		ctx->h->ops->parse_lookup(ctx, e, NULL);
+}
+
 void nft_rule_to_iptables_command_state(struct nft_handle *h,
 					const struct nftnl_rule *r,
 					struct iptables_command_state *cs)
@@ -628,6 +635,8 @@ void nft_rule_to_iptables_command_state(struct nft_handle *h,
 			nft_parse_target(&ctx, expr);
 		else if (strcmp(name, "limit") == 0)
 			nft_parse_limit(&ctx, expr);
+		else if (strcmp(name, "lookup") == 0)
+			nft_parse_lookup(&ctx, h, expr);
 
 		expr = nftnl_expr_iter_next(iter);
 	}
diff --git a/iptables/nft-shared.h b/iptables/nft-shared.h
index 6d2b237d90bbc..e5acb447045d3 100644
--- a/iptables/nft-shared.h
+++ b/iptables/nft-shared.h
@@ -86,6 +86,8 @@ struct nft_family_ops {
 			      void *data);
 	void (*parse_cmp)(struct nft_xt_ctx *ctx, struct nftnl_expr *e,
 			  void *data);
+	void (*parse_lookup)(struct nft_xt_ctx *ctx, struct nftnl_expr *e,
+			     void *data);
 	void (*parse_immediate)(const char *jumpto, bool nft_goto, void *data);
 
 	void (*print_table_header)(const char *tablename);
diff --git a/iptables/nft.c b/iptables/nft.c
index 821afa8f5e78c..4cc4b1798d979 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -1065,6 +1065,8 @@ int add_match(struct nft_handle *h,
 
 	if (!strcmp(m->u.user.name, "limit"))
 		return add_nft_limit(r, m);
+	else if (!strcmp(m->u.user.name, "among"))
+		return add_nft_among(h, r, m);
 
 	expr = nftnl_expr_alloc("match");
 	if (expr == NULL)
@@ -3497,7 +3499,8 @@ static const char *supported_exprs[] = {
 	"cmp",
 	"bitwise",
 	"counter",
-	"immediate"
+	"immediate",
+	"lookup"
 };
 
 
-- 
2.22.0

