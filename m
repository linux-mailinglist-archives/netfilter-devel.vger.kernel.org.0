Return-Path: <netfilter-devel+bounces-2834-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D4791A873
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Jun 2024 15:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FDAB24F31
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Jun 2024 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D284195398;
	Thu, 27 Jun 2024 13:58:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FBD36B0D
	for <netfilter-devel@vger.kernel.org>; Thu, 27 Jun 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496708; cv=none; b=JWAmCTp9p6Tcyy586ogv0PLYeRgiJ2HF853ZtmyewPF8ftAxZmSWNdUUKOho1dcZusSXwwAVUeiWF8zecZIT0qH64IvQ1A7//A5KuUrgGrVApxIimUBcSS28pmpcPg4U8HWWp6/WuHvwoLgVTHYA4E5qiDBGhwWzgij12IwhToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496708; c=relaxed/simple;
	bh=ElK/jC8cV4bCc7vE+AOI9Tm1ISntd15Q9lvLvoCu7KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idewDFMqoqM2ugbJKhd3lagGz/Wyy/23kIPUBkVOp15xxw7IEjTaQ/LCyl+NPrwRMry07/nCNw89m7TU6g8WQfVEGR9iG2fg2Hlovk/vK8ZDALMUGjOR6uu8HZz/BFP0MgM9aPTl5j10vingwXtLDUovvvORduMIVIP/lvIiD0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sMpdo-0002Ai-Gy; Thu, 27 Jun 2024 15:58:24 +0200
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [RFC nf-next 3/4] netfilter: nf_tables: insert register zeroing instructions for dodgy chains
Date: Thu, 27 Jun 2024 15:53:23 +0200
Message-ID: <20240627135330.17039-4-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240627135330.17039-1-fw@strlen.de>
References: <20240627135330.17039-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of rejecting rules that read from registers that saw no store,
insert nft_imm instruction preamble when building the ruleset blob.

Once any rule triggers 'uninitied access', table gets marked as
need-rebuild, then all base-chains in the affected table are regenerated.

Known drawback: 'nft monitor trace' may show 'unkown rule handle 0
verdict continue' when this auto-zero is active.
If this is unwanted, the trace infra in kernel could be patched to
suppress notification for handle-0 rules.

As normal rulesets generated by nft or iptables-nft never cause such
uninitialised reads this allows to revert the forced zeroing in the
next patch.

I would not add this patch and keep the reject behaviour, as the
nftables uapi is specifically built around the rule being a standalone
object.  I also question if it makes real sense to do such preload from
userspace, it has little benefit for well-formed (non-repetitive) rulesets.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_tables.h | 10 +++-
 net/netfilter/nf_tables_api.c     | 82 ++++++++++++++++++++++++++++---
 2 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 3f06ec7dc500..f974724a0c90 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -221,6 +221,7 @@ struct nft_ctx {
 	u8				family;
 	u8				level;
 	bool				report;
+	bool				reg_bad;
 	DECLARE_BITMAP(reg_inited, NFT_REG32_NUM);
 };
 
@@ -1247,6 +1248,12 @@ static inline void nft_use_inc_restore(u32 *use)
 
 #define nft_use_dec_restore	nft_use_dec
 
+enum nft_need_reg_zeroing {
+	NFT_REG_ZERO_NO,
+	NFT_REG_ZERO_NEED,
+	NFT_REG_ZERO_ON,
+};
+
 /**
  *	struct nft_table - nf_tables table
  *
@@ -1283,9 +1290,10 @@ struct nft_table {
 					genmask:2;
 	u32				nlpid;
 	char				*name;
-	u16				udlen;
 	u8				*udata;
+	u16				udlen;
 	u8				validate_state;
+	enum nft_need_reg_zeroing	zero_basechains:8;
 };
 
 static inline bool nft_table_has_owner(const struct nft_table *table)
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c59a32ab9145..213f3627b5b6 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -146,6 +146,7 @@ static void nft_ctx_init(struct nft_ctx *ctx,
 	ctx->report	= nlmsg_report(nlh);
 	ctx->flags	= nlh->nlmsg_flags;
 	ctx->seq	= nlh->nlmsg_seq;
+	ctx->reg_bad	= false;
 
 	bitmap_zero(ctx->reg_inited, NFT_REG32_NUM);
 }
@@ -543,9 +544,17 @@ static struct nft_trans *nft_trans_rule_add(struct nft_ctx *ctx, int msg_type,
 	if (trans == NULL)
 		return NULL;
 
-	if (msg_type == NFT_MSG_NEWRULE && ctx->nla[NFTA_RULE_ID] != NULL) {
-		nft_trans_rule_id(trans) =
-			ntohl(nla_get_be32(ctx->nla[NFTA_RULE_ID]));
+	if (msg_type == NFT_MSG_NEWRULE) {
+		struct nft_table *table = ctx->table;
+
+		if (ctx->nla[NFTA_RULE_ID]) {
+			nft_trans_rule_id(trans) =
+				ntohl(nla_get_be32(ctx->nla[NFTA_RULE_ID]));
+		}
+
+		if (ctx->reg_bad &&
+		    table->zero_basechains == NFT_REG_ZERO_NO)
+			table->zero_basechains = NFT_REG_ZERO_NEED;
 	}
 	nft_trans_rule(trans) = rule;
 	nft_trans_rule_chain(trans) = ctx->chain;
@@ -9613,11 +9622,58 @@ static bool nft_expr_reduce(struct nft_regs_track *track,
 	return false;
 }
 
+static unsigned int nft_reg_zero_size(void)
+{
+	return offsetof(struct nft_rule_dp, data) +
+	       NFT_EXPR_SIZE(sizeof(struct nft_immediate_expr)) * (NFT_REG_MAX + 1);
+}
+
+static unsigned int nft_reg_zero_add(struct nft_rule_blob *b)
+{
+	static const struct nft_expr_ops imm_zops = {
+		.eval = nft_immediate_eval,
+		.size = NFT_EXPR_SIZE(sizeof(struct nft_immediate_expr)),
+	};
+	struct nft_rule_dp *prule;
+	unsigned int size = 0;
+	void *data = (void *)b->data;
+	int i;
+
+	prule = data;
+	data += offsetof(struct nft_rule_dp, data);
+
+	for (i = 0; i <= NFT_REG_MAX; i++) {
+		struct nft_immediate_expr imm = {
+			.dlen = NFT_REG_SIZE,
+			.dreg = i * NFT_REG32_SIZE,
+		};
+		struct nft_expr *e = data;
+
+		if (i == 0)
+			imm.data.verdict.code = NFT_CONTINUE;
+
+		e->ops = &imm_zops;
+		memcpy(&e->data, &imm, sizeof(imm));
+		data += e->ops->size;
+		size += e->ops->size;
+	}
+
+	prule->is_last = 0;
+	prule->dlen = size;
+	prule->handle = 0;
+
+	size += offsetof(struct nft_rule_dp, data);
+	b->size += size;
+
+	return size;
+}
+
 static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *chain)
 {
 	const struct nft_expr *expr, *last;
 	struct nft_regs_track track = {};
 	unsigned int size, data_size;
+	bool need_register_zeroing;
 	void *data, *data_boundary;
 	struct nft_rule_dp *prule;
 	struct nft_rule *rule;
@@ -9627,6 +9683,10 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 		return 0;
 
 	data_size = 0;
+	need_register_zeroing = chain->table->zero_basechains != NFT_REG_ZERO_NO;
+	if (need_register_zeroing)
+		data_size = nft_reg_zero_size();
+
 	list_for_each_entry(rule, &chain->rules, list) {
 		if (nft_is_active_next(net, rule)) {
 			data_size += sizeof(*prule) + rule->dlen;
@@ -9639,9 +9699,18 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 	if (!chain->blob_next)
 		return -ENOMEM;
 
+	if (need_register_zeroing)
+		size = nft_reg_zero_add(chain->blob_next);
+	else
+		size = 0;
+
 	data = (void *)chain->blob_next->data;
 	data_boundary = data + data_size;
-	size = 0;
+
+	prule = (struct nft_rule_dp *)data;
+	data += size;
+	if (WARN_ON_ONCE(data > data_boundary))
+		return -ENOMEM;
 
 	list_for_each_entry(rule, &chain->rules, list) {
 		if (!nft_is_active_next(net, rule))
@@ -11104,9 +11173,10 @@ static int nft_validate_register_load(enum nft_registers reg, unsigned int len)
 	return 0;
 }
 
-int nft_parse_register_load(const struct nft_ctx *ctx,
+int nft_parse_register_load(const struct nft_ctx *__ctx,
 			    const struct nlattr *attr, u8 *sreg, u32 len)
 {
+	struct nft_ctx *ctx = (struct nft_ctx *)__ctx;
 	int err, invalid_reg;
 	u32 reg, next_register;
 
@@ -11129,7 +11199,7 @@ int nft_parse_register_load(const struct nft_ctx *ctx,
 
 	/* invalid register within the range that we're loading from? */
 	if (invalid_reg < next_register)
-		return -ENODATA;
+		ctx->reg_bad = true;
 
 	*sreg = reg;
 	return 0;
-- 
2.44.2


