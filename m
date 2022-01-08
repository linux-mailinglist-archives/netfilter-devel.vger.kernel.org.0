Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879324886B1
	for <lists+netfilter-devel@lfdr.de>; Sat,  8 Jan 2022 23:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiAHW0w (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 8 Jan 2022 17:26:52 -0500
Received: from mail.netfilter.org ([217.70.188.207]:40122 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiAHW0t (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 8 Jan 2022 17:26:49 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 658186468D
        for <netfilter-devel@vger.kernel.org>; Sat,  8 Jan 2022 23:23:59 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v2 09/14] netfilter: nf_tables: add register tracking infrastructure
Date:   Sat,  8 Jan 2022 23:26:33 +0100
Message-Id: <20220108222638.36037-10-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108222638.36037-1-pablo@netfilter.org>
References: <20220108222638.36037-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds new infrastructure to skip redundant selector store
operations on the same register to achieve a performance boost from
the packet path.

This is particularly noticeable in pure linear rulesets but it also
helps in rulesets which are already heaving relying in maps to avoid
ruleset linear inspection.

The idea is to keep data of the most recurrent store operations on
register to reuse them with cmp and lookup expressions.

This infrastructure allows for dynamic ruleset updates since the ruleset
blob reduction happens from the kernel.

Userspace still needs to be updated to maximize register utilization to
cooperate to improve register data reuse / reduce number of store on
register operations.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h | 12 ++++++++++++
 net/netfilter/nf_tables_api.c     | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 515e5db97e01..1c37ce61daea 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -122,6 +122,16 @@ struct nft_regs {
 	};
 };
 
+struct nft_regs_track {
+	struct {
+		const struct nft_expr		*selector;
+		const struct nft_expr		*bitwise;
+	} regs[NFT_REG32_NUM];
+
+	const struct nft_expr			*cur;
+	const struct nft_expr			*last;
+};
+
 /* Store/load an u8, u16 or u64 integer to/from the u32 data register.
  *
  * Note, when using concatenations, register allocation happens at 32-bit
@@ -886,6 +896,8 @@ struct nft_expr_ops {
 	int				(*validate)(const struct nft_ctx *ctx,
 						    const struct nft_expr *expr,
 						    const struct nft_data **data);
+	bool				(*reduce)(struct nft_regs_track *track,
+						  const struct nft_expr *expr);
 	bool				(*gc)(struct net *net,
 					      const struct nft_expr *expr);
 	int				(*offload)(struct nft_offload_ctx *ctx,
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 171e0ba4a6fb..926db0e87e85 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8256,6 +8256,7 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 {
 	const struct nft_expr *expr, *last;
 	unsigned int alloc = 0, size = 0;
+	struct nft_regs_track track = {};
 	struct nft_rule_dp *prule;
 	struct nft_rule *rule;
 	char *ptr;
@@ -8288,9 +8289,20 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 		prule = (struct nft_rule_dp *)ptr;
 		ptr += offsetof(struct nft_rule_dp, data);
 
+		size = 0;
+		track.last = last;
 		nft_rule_for_each_expr(expr, last, rule) {
+			track.cur = expr;
+
+			if (expr->ops->reduce &&
+			    expr->ops->reduce(&track, expr)) {
+				expr = track.cur;
+				continue;
+			}
+
 			memcpy(ptr, expr, expr->ops->size);
 			ptr += expr->ops->size;
+			size += expr->ops->size;
 		}
 		prule->handle = rule->handle;
 		prule->dlen = size;
-- 
2.30.2

