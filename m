Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9615E7A83
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Sep 2022 14:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiIWMWk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 23 Sep 2022 08:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiIWMV6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:21:58 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08698130732
        for <netfilter-devel@vger.kernel.org>; Fri, 23 Sep 2022 05:17:18 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1obhcL-0004xZ-Ay; Fri, 23 Sep 2022 14:17:17 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH iptables-nft] nft: track each register individually
Date:   Fri, 23 Sep 2022 14:17:08 +0200
Message-Id: <20220923121708.839-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Instead of assuming only one register is used, track all 16 regs
individually.

This avoids need for the 'PREV_PAYLOAD' hack and also avoids the need to
clear out old flags:

When we see that register 'x' will be written to, that register state is
reset automatically.

Existing dissector decodes
ip saddr 1.2.3.4 meta l4proto tcp
... as
-s 6.0.0.0 -p tcp

iptables-nft -s 1.2.3.4 -p tcp is decoded correctly because the expressions
are ordered like:

meta l4proto tcp ip saddr 1.2.3.4
                                                                                                                                                                                                                   |
... and 'meta l4proto' did clear the PAYLOAD flag.

The simpler fix is:
		ctx->flags &= ~NFT_XT_CTX_PAYLOAD;

in nft_parse_cmp(), but that breaks dissection of '1-42', because
the second compare ('cmp lte 42') will not find the
payload expression anymore.

Link: https://lore.kernel.org/netfilter-devel/20220922143544.GA22541@breakpoint.cc/T/#t
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 iptables/nft-arp.c    |  57 ++++++------
 iptables/nft-bridge.c | 102 +++++++++++++--------
 iptables/nft-ipv4.c   |  49 +++++-----
 iptables/nft-ipv6.c   |  36 ++++----
 iptables/nft-shared.c | 205 +++++++++++++++++++++++++++++-------------
 iptables/nft-shared.h | 110 +++++++++++++++++------
 6 files changed, 360 insertions(+), 199 deletions(-)

diff --git a/iptables/nft-arp.c b/iptables/nft-arp.c
index e6e4d2d81e52..e9e111416d79 100644
--- a/iptables/nft-arp.c
+++ b/iptables/nft-arp.c
@@ -160,25 +160,27 @@ static int nft_arp_add(struct nft_handle *h, struct nftnl_rule *r,
 	return ret;
 }
 
-static void nft_arp_parse_meta(struct nft_xt_ctx *ctx, struct nftnl_expr *e,
+static void nft_arp_parse_meta(struct nft_xt_ctx *ctx,
+			       const struct nft_xt_ctx_reg *reg,
+			       struct nftnl_expr *e,
 			       struct iptables_command_state *cs)
 {
 	struct arpt_entry *fw = &cs->arp;
 	uint8_t flags = 0;
 
-	parse_meta(ctx, e, ctx->meta.key, fw->arp.iniface, fw->arp.iniface_mask,
+	parse_meta(ctx, e, reg->meta_dreg.key, fw->arp.iniface, fw->arp.iniface_mask,
 		   fw->arp.outiface, fw->arp.outiface_mask,
 		   &flags);
 
 	fw->arp.invflags |= flags;
 }
 
-static void parse_mask_ipv4(struct nft_xt_ctx *ctx, struct in_addr *mask)
+static void parse_mask_ipv4(const struct nft_xt_ctx_reg *reg, struct in_addr *mask)
 {
-	mask->s_addr = ctx->bitwise.mask[0];
+	mask->s_addr = reg->bitwise.mask[0];
 }
 
-static bool nft_arp_parse_devaddr(struct nft_xt_ctx *ctx,
+static bool nft_arp_parse_devaddr(const struct nft_xt_ctx_reg *reg,
 				  struct nftnl_expr *e,
 				  struct arpt_devaddr_info *info)
 {
@@ -192,18 +194,17 @@ static bool nft_arp_parse_devaddr(struct nft_xt_ctx *ctx,
 
 	get_cmp_data(e, info->addr, ETH_ALEN, &inv);
 
-	if (ctx->flags & NFT_XT_CTX_BITWISE) {
-		memcpy(info->mask, ctx->bitwise.mask, ETH_ALEN);
-		ctx->flags &= ~NFT_XT_CTX_BITWISE;
-	} else {
+	if (reg->bitwise.set)
+		memcpy(info->mask, reg->bitwise.mask, ETH_ALEN);
+	else
 		memset(info->mask, 0xff,
-		       min(ctx->payload.len, ETH_ALEN));
-	}
+		       min(reg->payload.len, ETH_ALEN));
 
 	return inv;
 }
 
 static void nft_arp_parse_payload(struct nft_xt_ctx *ctx,
+				  const struct nft_xt_ctx_reg *reg,
 				  struct nftnl_expr *e,
 				  struct iptables_command_state *cs)
 {
@@ -213,7 +214,7 @@ static void nft_arp_parse_payload(struct nft_xt_ctx *ctx,
 	uint8_t ar_hln;
 	bool inv;
 
-	switch (ctx->payload.offset) {
+	switch (reg->payload.offset) {
 	case offsetof(struct arphdr, ar_hrd):
 		get_cmp_data(e, &ar_hrd, sizeof(ar_hrd), &inv);
 		fw->arp.arhrd = ar_hrd;
@@ -243,43 +244,39 @@ static void nft_arp_parse_payload(struct nft_xt_ctx *ctx,
 			fw->arp.invflags |= IPT_INV_ARPOP;
 		break;
 	default:
-		if (ctx->payload.offset == sizeof(struct arphdr)) {
-			if (nft_arp_parse_devaddr(ctx, e, &fw->arp.src_devaddr))
+		if (reg->payload.offset == sizeof(struct arphdr)) {
+			if (nft_arp_parse_devaddr(reg, e, &fw->arp.src_devaddr))
 				fw->arp.invflags |= IPT_INV_SRCDEVADDR;
-		} else if (ctx->payload.offset == sizeof(struct arphdr) +
+		} else if (reg->payload.offset == sizeof(struct arphdr) +
 					   fw->arp.arhln) {
 			get_cmp_data(e, &addr, sizeof(addr), &inv);
 			fw->arp.src.s_addr = addr.s_addr;
-			if (ctx->flags & NFT_XT_CTX_BITWISE) {
-				parse_mask_ipv4(ctx, &fw->arp.smsk);
-				ctx->flags &= ~NFT_XT_CTX_BITWISE;
-			} else {
+			if (reg->bitwise.set)
+				parse_mask_ipv4(reg, &fw->arp.smsk);
+			else
 				memset(&fw->arp.smsk, 0xff,
-				       min(ctx->payload.len,
+				       min(reg->payload.len,
 					   sizeof(struct in_addr)));
-			}
 
 			if (inv)
 				fw->arp.invflags |= IPT_INV_SRCIP;
-		} else if (ctx->payload.offset == sizeof(struct arphdr) +
+		} else if (reg->payload.offset == sizeof(struct arphdr) +
 						  fw->arp.arhln +
 						  sizeof(struct in_addr)) {
-			if (nft_arp_parse_devaddr(ctx, e, &fw->arp.tgt_devaddr))
+			if (nft_arp_parse_devaddr(reg, e, &fw->arp.tgt_devaddr))
 				fw->arp.invflags |= IPT_INV_TGTDEVADDR;
-		} else if (ctx->payload.offset == sizeof(struct arphdr) +
+		} else if (reg->payload.offset == sizeof(struct arphdr) +
 						  fw->arp.arhln +
 						  sizeof(struct in_addr) +
 						  fw->arp.arhln) {
 			get_cmp_data(e, &addr, sizeof(addr), &inv);
 			fw->arp.tgt.s_addr = addr.s_addr;
-			if (ctx->flags & NFT_XT_CTX_BITWISE) {
-				parse_mask_ipv4(ctx, &fw->arp.tmsk);
-				ctx->flags &= ~NFT_XT_CTX_BITWISE;
-			} else {
+			if (reg->bitwise.set)
+				parse_mask_ipv4(reg, &fw->arp.tmsk);
+			else
 				memset(&fw->arp.tmsk, 0xff,
-				       min(ctx->payload.len,
+				       min(reg->payload.len,
 					   sizeof(struct in_addr)));
-			}
 
 			if (inv)
 				fw->arp.invflags |= IPT_INV_DSTIP;
diff --git a/iptables/nft-bridge.c b/iptables/nft-bridge.c
index 106bcc72889f..1121e8644a4e 100644
--- a/iptables/nft-bridge.c
+++ b/iptables/nft-bridge.c
@@ -170,6 +170,7 @@ static int nft_bridge_add(struct nft_handle *h,
 }
 
 static void nft_bridge_parse_meta(struct nft_xt_ctx *ctx,
+				  const struct nft_xt_ctx_reg *reg,
 				  struct nftnl_expr *e,
 				  struct iptables_command_state *cs)
 {
@@ -177,9 +178,9 @@ static void nft_bridge_parse_meta(struct nft_xt_ctx *ctx,
 	uint8_t invflags = 0;
 	char iifname[IFNAMSIZ] = {}, oifname[IFNAMSIZ] = {};
 
-	parse_meta(ctx, e, ctx->meta.key, iifname, NULL, oifname, NULL, &invflags);
+	parse_meta(ctx, e, reg->meta_dreg.key, iifname, NULL, oifname, NULL, &invflags);
 
-	switch (ctx->meta.key) {
+	switch (reg->meta_dreg.key) {
 	case NFT_META_BRI_IIFNAME:
 		if (invflags & IPT_INV_VIA_IN)
 			cs->eb.invflags |= EBT_ILOGICALIN;
@@ -206,6 +207,7 @@ static void nft_bridge_parse_meta(struct nft_xt_ctx *ctx,
 }
 
 static void nft_bridge_parse_payload(struct nft_xt_ctx *ctx,
+				     const struct nft_xt_ctx_reg *reg,
 				     struct nftnl_expr *e,
 				     struct iptables_command_state *cs)
 {
@@ -215,7 +217,7 @@ static void nft_bridge_parse_payload(struct nft_xt_ctx *ctx,
 	bool inv;
 	int i;
 
-	switch (ctx->payload.offset) {
+	switch (reg->payload.offset) {
 	case offsetof(struct ethhdr, h_dest):
 		get_cmp_data(e, addr, sizeof(addr), &inv);
 		for (i = 0; i < ETH_ALEN; i++)
@@ -223,13 +225,11 @@ static void nft_bridge_parse_payload(struct nft_xt_ctx *ctx,
 		if (inv)
 			fw->invflags |= EBT_IDEST;
 
-		if (ctx->flags & NFT_XT_CTX_BITWISE) {
-                        memcpy(fw->destmsk, ctx->bitwise.mask, ETH_ALEN);
-                        ctx->flags &= ~NFT_XT_CTX_BITWISE;
-                } else {
+		if (reg->bitwise.set)
+                        memcpy(fw->destmsk, reg->bitwise.mask, ETH_ALEN);
+                else
 			memset(&fw->destmsk, 0xff,
-			       min(ctx->payload.len, ETH_ALEN));
-                }
+			       min(reg->payload.len, ETH_ALEN));
 		fw->bitmask |= EBT_IDEST;
 		break;
 	case offsetof(struct ethhdr, h_source):
@@ -238,13 +238,11 @@ static void nft_bridge_parse_payload(struct nft_xt_ctx *ctx,
 			fw->sourcemac[i] = addr[i];
 		if (inv)
 			fw->invflags |= EBT_ISOURCE;
-		if (ctx->flags & NFT_XT_CTX_BITWISE) {
-                        memcpy(fw->sourcemsk, ctx->bitwise.mask, ETH_ALEN);
-                        ctx->flags &= ~NFT_XT_CTX_BITWISE;
-                } else {
+		if (reg->bitwise.set)
+                        memcpy(fw->sourcemsk, reg->bitwise.mask, ETH_ALEN);
+                else
 			memset(&fw->sourcemsk, 0xff,
-			       min(ctx->payload.len, ETH_ALEN));
-                }
+			       min(reg->payload.len, ETH_ALEN));
 		fw->bitmask |= EBT_ISOURCE;
 		break;
 	case offsetof(struct ethhdr, h_proto):
@@ -294,28 +292,53 @@ lookup_check_iphdr_payload(uint32_t base, uint32_t offset, uint32_t len)
 /* Make sure previous payload expression(s) is/are consistent and extract if
  * matching on source or destination address and if matching on MAC and IP or
  * only MAC address. */
-static int lookup_analyze_payloads(const struct nft_xt_ctx *ctx,
+static int lookup_analyze_payloads(struct nft_xt_ctx *ctx,
+				   enum nft_registers sreg,
+				   uint32_t key_len,
 				   bool *dst, bool *ip)
 {
+	const struct nft_xt_ctx_reg *reg;
+	uint32_t sreg_count;
 	int val, val2 = -1;
 
-	if (ctx->flags & NFT_XT_CTX_PREV_PAYLOAD) {
-		val = lookup_check_ether_payload(ctx->prev_payload.base,
-						 ctx->prev_payload.offset,
-						 ctx->prev_payload.len);
+	reg = nft_xt_ctx_get_sreg(ctx, sreg);
+	if (!reg)
+		return -1;
+
+	if (reg->type != NFT_XT_REG_PAYLOAD) {
+		ctx->errmsg = "lookup reg is not payload type";
+		return -1;
+	}
+
+	sreg_count = sreg;
+	switch (key_len) {
+	case 12: /* ether + ipv4addr */
+		val = lookup_check_ether_payload(reg->payload.base,
+						 reg->payload.offset,
+						 reg->payload.len);
 		if (val < 0) {
 			DEBUGP("unknown payload base/offset/len %d/%d/%d\n",
-			       ctx->prev_payload.base, ctx->prev_payload.offset,
-			       ctx->prev_payload.len);
+			       reg->payload.base, reg->payload.offset,
+			       reg->payload.len);
 			return -1;
 		}
-		if (!(ctx->flags & NFT_XT_CTX_PAYLOAD)) {
-			DEBUGP("Previous but no current payload?\n");
+
+		sreg_count += 2;
+
+		reg = nft_xt_ctx_get_sreg(ctx, sreg_count);
+		if (!reg) {
+			ctx->errmsg = "next lookup register is invalid";
+			return -1;
+		}
+
+		if (reg->type != NFT_XT_REG_PAYLOAD) {
+			ctx->errmsg = "next lookup reg is not payload type";
 			return -1;
 		}
-		val2 = lookup_check_iphdr_payload(ctx->payload.base,
-						  ctx->payload.offset,
-						  ctx->payload.len);
+
+		val2 = lookup_check_iphdr_payload(reg->payload.base,
+						  reg->payload.offset,
+						  reg->payload.len);
 		if (val2 < 0) {
 			DEBUGP("unknown payload base/offset/len %d/%d/%d\n",
 			       ctx->payload.base, ctx->payload.offset,
@@ -325,18 +348,20 @@ static int lookup_analyze_payloads(const struct nft_xt_ctx *ctx,
 			DEBUGP("mismatching payload match offsets\n");
 			return -1;
 		}
-	} else if (ctx->flags & NFT_XT_CTX_PAYLOAD) {
-		val = lookup_check_ether_payload(ctx->payload.base,
-						 ctx->payload.offset,
-						 ctx->payload.len);
+		break;
+	case 4: /* ipv4addr */
+		val = lookup_check_ether_payload(reg->payload.base,
+						 reg->payload.offset,
+						 reg->payload.len);
 		if (val < 0) {
 			DEBUGP("unknown payload base/offset/len %d/%d/%d\n",
 			       ctx->payload.base, ctx->payload.offset,
 			       ctx->payload.len);
 			return -1;
 		}
-	} else {
-		DEBUGP("unknown LHS of lookup expression\n");
+		break;
+	default:
+		ctx->errmsg = "unsupported lookup key length";
 		return -1;
 	}
 
@@ -413,14 +438,17 @@ static void nft_bridge_parse_lookup(struct nft_xt_ctx *ctx,
 	size_t poff, size;
 	uint32_t cnt;
 
-	if (lookup_analyze_payloads(ctx, &is_dst, &have_ip))
-		return;
-
 	s = set_from_lookup_expr(ctx, e);
 	if (!s)
 		xtables_error(OTHER_PROBLEM,
 			      "BUG: lookup expression references unknown set");
 
+	if (lookup_analyze_payloads(ctx,
+				    nftnl_expr_get_u32(e, NFTNL_EXPR_LOOKUP_SREG),
+				    nftnl_set_get_u32(s, NFTNL_SET_KEY_LEN),
+				    &is_dst, &have_ip))
+		return;
+
 	cnt = nftnl_set_get_u32(s, NFTNL_SET_DESC_SIZE);
 
 	for (ematch = ctx->cs->match_list; ematch; ematch = ematch->next) {
@@ -468,8 +496,6 @@ static void nft_bridge_parse_lookup(struct nft_xt_ctx *ctx,
 	if (set_elems_to_among_pairs(among_data->pairs + poff, s, cnt))
 		xtables_error(OTHER_PROBLEM,
 			      "ebtables among pair parsing failed");
-
-	ctx->flags &= ~(NFT_XT_CTX_PAYLOAD | NFT_XT_CTX_PREV_PAYLOAD);
 }
 
 static void parse_watcher(void *object, struct ebt_match **match_list,
diff --git a/iptables/nft-ipv4.c b/iptables/nft-ipv4.c
index 1865d1515296..92a914f1a4a4 100644
--- a/iptables/nft-ipv4.c
+++ b/iptables/nft-ipv4.c
@@ -115,28 +115,28 @@ static bool nft_ipv4_is_same(const struct iptables_command_state *a,
 				  b->fw.ip.iniface_mask, b->fw.ip.outiface_mask);
 }
 
-static void get_frag(struct nft_xt_ctx *ctx, struct nftnl_expr *e, bool *inv)
+static bool get_frag(const struct nft_xt_ctx_reg *reg, struct nftnl_expr *e)
 {
 	uint8_t op;
 
 	/* we assume correct mask and xor */
-	if (!(ctx->flags & NFT_XT_CTX_BITWISE))
-		return;
+	if (!reg->bitwise.set)
+		return false;
 
 	/* we assume correct data */
 	op = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP);
 	if (op == NFT_CMP_EQ)
-		*inv = true;
-	else
-		*inv = false;
+		return true;
 
-	ctx->flags &= ~NFT_XT_CTX_BITWISE;
+	return false;
 }
 
-static void nft_ipv4_parse_meta(struct nft_xt_ctx *ctx, struct nftnl_expr *e,
+static void nft_ipv4_parse_meta(struct nft_xt_ctx *ctx,
+				const struct nft_xt_ctx_reg *reg,
+				struct nftnl_expr *e,
 				struct iptables_command_state *cs)
 {
-	switch (ctx->meta.key) {
+	switch (reg->meta_dreg.key) {
 	case NFT_META_L4PROTO:
 		cs->fw.ip.proto = nftnl_expr_get_u8(e, NFTNL_EXPR_CMP_DATA);
 		if (nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP) == NFT_CMP_NEQ)
@@ -146,17 +146,18 @@ static void nft_ipv4_parse_meta(struct nft_xt_ctx *ctx, struct nftnl_expr *e,
 		break;
 	}
 
-	parse_meta(ctx, e, ctx->meta.key, cs->fw.ip.iniface, cs->fw.ip.iniface_mask,
+	parse_meta(ctx, e, reg->meta_dreg.key, cs->fw.ip.iniface, cs->fw.ip.iniface_mask,
 		   cs->fw.ip.outiface, cs->fw.ip.outiface_mask,
 		   &cs->fw.ip.invflags);
 }
 
-static void parse_mask_ipv4(struct nft_xt_ctx *ctx, struct in_addr *mask)
+static void parse_mask_ipv4(const struct nft_xt_ctx_reg *sreg, struct in_addr *mask)
 {
-	mask->s_addr = ctx->bitwise.mask[0];
+	mask->s_addr = sreg->bitwise.mask[0];
 }
 
 static void nft_ipv4_parse_payload(struct nft_xt_ctx *ctx,
+				   const struct nft_xt_ctx_reg *sreg,
 				   struct nftnl_expr *e,
 				   struct iptables_command_state *cs)
 {
@@ -164,16 +165,15 @@ static void nft_ipv4_parse_payload(struct nft_xt_ctx *ctx,
 	uint8_t proto;
 	bool inv;
 
-	switch(ctx->payload.offset) {
+	switch (sreg->payload.offset) {
 	case offsetof(struct iphdr, saddr):
 		get_cmp_data(e, &addr, sizeof(addr), &inv);
 		cs->fw.ip.src.s_addr = addr.s_addr;
-		if (ctx->flags & NFT_XT_CTX_BITWISE) {
-			parse_mask_ipv4(ctx, &cs->fw.ip.smsk);
-			ctx->flags &= ~NFT_XT_CTX_BITWISE;
+		if (sreg->bitwise.set) {
+			parse_mask_ipv4(sreg, &cs->fw.ip.smsk);
 		} else {
 			memset(&cs->fw.ip.smsk, 0xff,
-			       min(ctx->payload.len, sizeof(struct in_addr)));
+			       min(sreg->payload.len, sizeof(struct in_addr)));
 		}
 
 		if (inv)
@@ -182,13 +182,11 @@ static void nft_ipv4_parse_payload(struct nft_xt_ctx *ctx,
 	case offsetof(struct iphdr, daddr):
 		get_cmp_data(e, &addr, sizeof(addr), &inv);
 		cs->fw.ip.dst.s_addr = addr.s_addr;
-		if (ctx->flags & NFT_XT_CTX_BITWISE) {
-			parse_mask_ipv4(ctx, &cs->fw.ip.dmsk);
-			ctx->flags &= ~NFT_XT_CTX_BITWISE;
-		} else {
+		if (sreg->bitwise.set)
+			parse_mask_ipv4(sreg, &cs->fw.ip.dmsk);
+		else
 			memset(&cs->fw.ip.dmsk, 0xff,
-			       min(ctx->payload.len, sizeof(struct in_addr)));
-		}
+			       min(sreg->payload.len, sizeof(struct in_addr)));
 
 		if (inv)
 			cs->fw.ip.invflags |= IPT_INV_DSTIP;
@@ -201,8 +199,7 @@ static void nft_ipv4_parse_payload(struct nft_xt_ctx *ctx,
 		break;
 	case offsetof(struct iphdr, frag_off):
 		cs->fw.ip.flags |= IPT_F_FRAG;
-		inv = false;
-		get_frag(ctx, e, &inv);
+		inv = get_frag(sreg, e);
 		if (inv)
 			cs->fw.ip.invflags |= IPT_INV_FRAG;
 		break;
@@ -210,7 +207,7 @@ static void nft_ipv4_parse_payload(struct nft_xt_ctx *ctx,
 		nft_parse_hl(ctx, e, cs);
 		break;
 	default:
-		DEBUGP("unknown payload offset %d\n", ctx->payload.offset);
+		DEBUGP("unknown payload offset %d\n", sreg->payload.offset);
 		break;
 	}
 }
diff --git a/iptables/nft-ipv6.c b/iptables/nft-ipv6.c
index 0ab1f9719344..05d65fbb4624 100644
--- a/iptables/nft-ipv6.c
+++ b/iptables/nft-ipv6.c
@@ -104,10 +104,12 @@ static bool nft_ipv6_is_same(const struct iptables_command_state *a,
 				  b->fw6.ipv6.outiface_mask);
 }
 
-static void nft_ipv6_parse_meta(struct nft_xt_ctx *ctx, struct nftnl_expr *e,
+static void nft_ipv6_parse_meta(struct nft_xt_ctx *ctx,
+				const struct nft_xt_ctx_reg *reg,
+				struct nftnl_expr *e,
 				struct iptables_command_state *cs)
 {
-	switch (ctx->meta.key) {
+	switch (reg->meta_dreg.key) {
 	case NFT_META_L4PROTO:
 		cs->fw6.ipv6.proto = nftnl_expr_get_u8(e, NFTNL_EXPR_CMP_DATA);
 		if (nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP) == NFT_CMP_NEQ)
@@ -117,17 +119,19 @@ static void nft_ipv6_parse_meta(struct nft_xt_ctx *ctx, struct nftnl_expr *e,
 		break;
 	}
 
-	parse_meta(ctx, e, ctx->meta.key, cs->fw6.ipv6.iniface,
+	parse_meta(ctx, e, reg->meta_dreg.key, cs->fw6.ipv6.iniface,
 		   cs->fw6.ipv6.iniface_mask, cs->fw6.ipv6.outiface,
 		   cs->fw6.ipv6.outiface_mask, &cs->fw6.ipv6.invflags);
 }
 
-static void parse_mask_ipv6(struct nft_xt_ctx *ctx, struct in6_addr *mask)
+static void parse_mask_ipv6(const struct nft_xt_ctx_reg *reg,
+			    struct in6_addr *mask)
 {
-	memcpy(mask, ctx->bitwise.mask, sizeof(struct in6_addr));
+	memcpy(mask, reg->bitwise.mask, sizeof(struct in6_addr));
 }
 
 static void nft_ipv6_parse_payload(struct nft_xt_ctx *ctx,
+				   const struct nft_xt_ctx_reg *reg,
 				   struct nftnl_expr *e,
 				   struct iptables_command_state *cs)
 {
@@ -135,17 +139,15 @@ static void nft_ipv6_parse_payload(struct nft_xt_ctx *ctx,
 	uint8_t proto;
 	bool inv;
 
-	switch (ctx->payload.offset) {
+	switch (reg->payload.offset) {
 	case offsetof(struct ip6_hdr, ip6_src):
 		get_cmp_data(e, &addr, sizeof(addr), &inv);
 		memcpy(cs->fw6.ipv6.src.s6_addr, &addr, sizeof(addr));
-		if (ctx->flags & NFT_XT_CTX_BITWISE) {
-			parse_mask_ipv6(ctx, &cs->fw6.ipv6.smsk);
-			ctx->flags &= ~NFT_XT_CTX_BITWISE;
-		} else {
+		if (reg->bitwise.set)
+			parse_mask_ipv6(reg, &cs->fw6.ipv6.smsk);
+		else
 			memset(&cs->fw6.ipv6.smsk, 0xff,
-			       min(ctx->payload.len, sizeof(struct in6_addr)));
-		}
+			       min(reg->payload.len, sizeof(struct in6_addr)));
 
 		if (inv)
 			cs->fw6.ipv6.invflags |= IP6T_INV_SRCIP;
@@ -153,13 +155,11 @@ static void nft_ipv6_parse_payload(struct nft_xt_ctx *ctx,
 	case offsetof(struct ip6_hdr, ip6_dst):
 		get_cmp_data(e, &addr, sizeof(addr), &inv);
 		memcpy(cs->fw6.ipv6.dst.s6_addr, &addr, sizeof(addr));
-		if (ctx->flags & NFT_XT_CTX_BITWISE) {
-			parse_mask_ipv6(ctx, &cs->fw6.ipv6.dmsk);
-			ctx->flags &= ~NFT_XT_CTX_BITWISE;
-		} else {
+		if (reg->bitwise.set)
+			parse_mask_ipv6(reg, &cs->fw6.ipv6.dmsk);
+		else
 			memset(&cs->fw6.ipv6.dmsk, 0xff,
-			       min(ctx->payload.len, sizeof(struct in6_addr)));
-		}
+			       min(reg->payload.len, sizeof(struct in6_addr)));
 
 		if (inv)
 			cs->fw6.ipv6.invflags |= IP6T_INV_DSTIP;
diff --git a/iptables/nft-shared.c b/iptables/nft-shared.c
index 71e2f18dab92..555f74f03530 100644
--- a/iptables/nft-shared.c
+++ b/iptables/nft-shared.c
@@ -299,6 +299,16 @@ nft_create_match(struct nft_xt_ctx *ctx,
 		 struct iptables_command_state *cs,
 		 const char *name);
 
+static uint32_t get_meta_mask(struct nft_xt_ctx *ctx, enum nft_registers sreg)
+{
+	struct nft_xt_ctx_reg *reg = nft_xt_ctx_get_sreg(ctx, sreg);
+
+	if (reg->bitwise.set)
+		return reg->bitwise.mask[0];
+
+	return ~0u;
+}
+
 static int parse_meta_mark(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
 {
 	struct xt_mark_mtinfo1 *mark;
@@ -316,12 +326,7 @@ static int parse_meta_mark(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
 
 	value = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_DATA);
 	mark->mark = value;
-	if (ctx->flags & NFT_XT_CTX_BITWISE) {
-		memcpy(&mark->mask, &ctx->bitwise.mask, sizeof(mark->mask));
-		ctx->flags &= ~NFT_XT_CTX_BITWISE;
-	} else {
-		mark->mask = 0xffffffff;
-	}
+	mark->mask = get_meta_mask(ctx, nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_SREG));
 
 	return 0;
 }
@@ -479,20 +484,40 @@ void get_cmp_data(struct nftnl_expr *e, void *data, size_t dlen, bool *inv)
 		*inv = false;
 }
 
-static void nft_meta_set_to_target(struct nft_xt_ctx *ctx)
+static void nft_meta_set_to_target(struct nft_xt_ctx *ctx,
+				   struct nftnl_expr *e)
 {
 	struct xtables_target *target;
+	struct nft_xt_ctx_reg *sreg;
+	enum nft_registers sregnum;
 	struct xt_entry_target *t;
 	unsigned int size;
 	const char *targname;
 
-	switch (ctx->meta.key) {
+	sregnum = nftnl_expr_get_u32(e, NFTNL_EXPR_META_SREG);
+	sreg = nft_xt_ctx_get_sreg(ctx, sregnum);
+	if (!sreg)
+		return;
+
+	if (sreg->meta_sreg.set == 0)
+		return;
+
+	switch (sreg->meta_sreg.key) {
 	case NFT_META_NFTRACE:
-		if (ctx->immediate.data[0] == 0)
+		if ((sreg->type != NFT_XT_REG_IMMEDIATE)) {
+			ctx->errmsg = "meta nftrace but reg not immediate";
 			return;
+		}
+
+		if (sreg->immediate.data[0] == 0) {
+			ctx->errmsg = "trace is cleared";
+			return;
+		}
+
 		targname = "TRACE";
 		break;
 	default:
+		ctx->errmsg = "meta sreg key not supported";
 		return;
 	}
 
@@ -514,51 +539,74 @@ static void nft_meta_set_to_target(struct nft_xt_ctx *ctx)
 
 static void nft_parse_meta(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
 {
-	ctx->meta.key = nftnl_expr_get_u32(e, NFTNL_EXPR_META_KEY);
+        struct nft_xt_ctx_reg *reg;
 
-	if (nftnl_expr_is_set(e, NFTNL_EXPR_META_SREG) &&
-	    (ctx->flags & NFT_XT_CTX_IMMEDIATE) &&
-	     nftnl_expr_get_u32(e, NFTNL_EXPR_META_SREG) == ctx->immediate.reg) {
-		ctx->flags &= ~NFT_XT_CTX_IMMEDIATE;
-		nft_meta_set_to_target(ctx);
+	if (nftnl_expr_is_set(e, NFTNL_EXPR_META_SREG)) {
+		nft_meta_set_to_target(ctx, e);
 		return;
 	}
 
-	ctx->reg = nftnl_expr_get_u32(e, NFTNL_EXPR_META_DREG);
-	ctx->flags |= NFT_XT_CTX_META;
+	reg = nft_xt_ctx_get_dreg(ctx, nftnl_expr_get_u32(e, NFTNL_EXPR_META_DREG));
+	if (!reg)
+		return;
+
+	reg->meta_dreg.key = nftnl_expr_get_u32(e, NFTNL_EXPR_META_KEY);
+	reg->type = NFT_XT_REG_META_DREG;
 }
 
 static void nft_parse_payload(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
 {
-	if (ctx->flags & NFT_XT_CTX_PAYLOAD) {
-		memcpy(&ctx->prev_payload, &ctx->payload,
-		       sizeof(ctx->prev_payload));
-		ctx->flags |= NFT_XT_CTX_PREV_PAYLOAD;
-	}
+	enum nft_registers regnum = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_DREG);
+	struct nft_xt_ctx_reg *reg = nft_xt_ctx_get_dreg(ctx, regnum);
 
-	ctx->reg = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_DREG);
-	ctx->payload.base = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_BASE);
-	ctx->payload.offset = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_OFFSET);
-	ctx->payload.len = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_LEN);
-	ctx->flags |= NFT_XT_CTX_PAYLOAD;
+	if (!reg)
+		return;
+
+	reg->type = NFT_XT_REG_PAYLOAD;
+	reg->payload.base = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_BASE);
+	reg->payload.offset = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_OFFSET);
+	reg->payload.len = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_LEN);
 }
 
 static void nft_parse_bitwise(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
 {
-	uint32_t reg, len;
+	enum nft_registers sregnum = nftnl_expr_get_u32(e, NFTNL_EXPR_BITWISE_SREG);
+	enum nft_registers dregnum = nftnl_expr_get_u32(e, NFTNL_EXPR_BITWISE_DREG);
+	struct nft_xt_ctx_reg *sreg = nft_xt_ctx_get_sreg(ctx, sregnum);
+	struct nft_xt_ctx_reg *dreg = sreg;
 	const void *data;
+	uint32_t len;
 
-	reg = nftnl_expr_get_u32(e, NFTNL_EXPR_BITWISE_SREG);
-	if (ctx->reg && reg != ctx->reg)
+	if (!sreg)
 		return;
 
-	reg = nftnl_expr_get_u32(e, NFTNL_EXPR_BITWISE_DREG);
-	ctx->reg = reg;
+	if (sregnum != dregnum) {
+		dreg = nft_xt_ctx_get_sreg(ctx, dregnum); /* sreg, do NOT clear ... */
+		if (!dreg)
+			return;
+
+		*dreg = *sreg;  /* .. and copy content instead */
+	}
+
 	data = nftnl_expr_get(e, NFTNL_EXPR_BITWISE_XOR, &len);
-	memcpy(ctx->bitwise.xor, data, len);
+
+	if (len > sizeof(dreg->bitwise.xor)) {
+		ctx->errmsg = "bitwise xor too large";
+		return;
+	}
+
+	memcpy(dreg->bitwise.xor, data, len);
+
 	data = nftnl_expr_get(e, NFTNL_EXPR_BITWISE_MASK, &len);
-	memcpy(ctx->bitwise.mask, data, len);
-	ctx->flags |= NFT_XT_CTX_BITWISE;
+
+	if (len > sizeof(dreg->bitwise.mask)) {
+		ctx->errmsg = "bitwise mask too large";
+		return;
+	}
+
+	memcpy(dreg->bitwise.mask, data, len);
+
+	dreg->bitwise.set = true;
 }
 
 static struct xtables_match *
@@ -863,6 +911,8 @@ static void nft_parse_transport(struct nft_xt_ctx *ctx,
 				struct nftnl_expr *e,
 				struct iptables_command_state *cs)
 {
+	struct nft_xt_ctx_reg *sreg;
+	enum nft_registers reg;
 	uint32_t sdport;
 	uint16_t port;
 	uint8_t proto, op;
@@ -883,7 +933,17 @@ static void nft_parse_transport(struct nft_xt_ctx *ctx,
 	nftnl_expr_get(e, NFTNL_EXPR_CMP_DATA, &len);
 	op = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP);
 
-	switch(ctx->payload.offset) {
+	reg = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_SREG);
+	sreg = nft_xt_ctx_get_sreg(ctx, reg);
+	if (!sreg)
+		return;
+
+	if (sreg->type != NFT_XT_REG_PAYLOAD) {
+		ctx->errmsg = "sgreg not payload";
+		return;
+	}
+
+	switch(sreg->payload.offset) {
 	case 0: /* th->sport */
 		switch (len) {
 		case 2: /* load sport only */
@@ -909,10 +969,9 @@ static void nft_parse_transport(struct nft_xt_ctx *ctx,
 			uint8_t flags = nftnl_expr_get_u8(e, NFTNL_EXPR_CMP_DATA);
 			uint8_t mask = ~0;
 
-			if (ctx->flags & NFT_XT_CTX_BITWISE) {
-				memcpy(&mask, &ctx->bitwise.mask, sizeof(mask));
-				ctx->flags &= ~NFT_XT_CTX_BITWISE;
-			}
+			if (sreg->bitwise.set)
+				memcpy(&mask, &sreg->bitwise.mask, sizeof(mask));
+
 			nft_parse_tcp_flags(ctx, cs, op, flags, mask);
 		}
 		return;
@@ -920,6 +979,7 @@ static void nft_parse_transport(struct nft_xt_ctx *ctx,
 }
 
 static void nft_parse_transport_range(struct nft_xt_ctx *ctx,
+				      const struct nft_xt_ctx_reg *sreg,
 				      struct nftnl_expr *e,
 				      struct iptables_command_state *cs)
 {
@@ -949,7 +1009,7 @@ static void nft_parse_transport_range(struct nft_xt_ctx *ctx,
 	from = ntohs(nftnl_expr_get_u16(e, NFTNL_EXPR_RANGE_FROM_DATA));
 	to = ntohs(nftnl_expr_get_u16(e, NFTNL_EXPR_RANGE_TO_DATA));
 
-	switch(ctx->payload.offset) {
+	switch (sreg->payload.offset) {
 	case 0:
 		nft_parse_th_port_range(ctx, cs, proto, from, to, -1, -1, op);
 		return;
@@ -962,30 +1022,40 @@ static void nft_parse_transport_range(struct nft_xt_ctx *ctx,
 
 static void nft_parse_cmp(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
 {
+	struct nft_xt_ctx_reg *sreg;
 	uint32_t reg;
 
 	reg = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_SREG);
-	if (ctx->reg && reg != ctx->reg)
+
+	sreg = nft_xt_ctx_get_sreg(ctx, reg);
+	if (!sreg)
 		return;
 
-	if (ctx->flags & NFT_XT_CTX_META) {
-		ctx->h->ops->parse_meta(ctx, e, ctx->cs);
-		ctx->flags &= ~NFT_XT_CTX_META;
-	}
-	/* bitwise context is interpreted from payload */
-	if (ctx->flags & NFT_XT_CTX_PAYLOAD) {
-		switch (ctx->payload.base) {
+	switch (sreg->type) {
+	case NFT_XT_REG_UNDEF:
+		ctx->errmsg = "cmp sreg undef";
+		break;
+	case NFT_XT_REG_META_DREG:
+		ctx->h->ops->parse_meta(ctx, sreg, e, ctx->cs);
+		break;
+	case NFT_XT_REG_PAYLOAD:
+		switch (sreg->payload.base) {
 		case NFT_PAYLOAD_LL_HEADER:
 			if (ctx->h->family == NFPROTO_BRIDGE)
-				ctx->h->ops->parse_payload(ctx, e, ctx->cs);
+				ctx->h->ops->parse_payload(ctx, sreg, e, ctx->cs);
 			break;
 		case NFT_PAYLOAD_NETWORK_HEADER:
-			ctx->h->ops->parse_payload(ctx, e, ctx->cs);
+			ctx->h->ops->parse_payload(ctx, sreg, e, ctx->cs);
 			break;
 		case NFT_PAYLOAD_TRANSPORT_HEADER:
 			nft_parse_transport(ctx, e, ctx->cs);
 			break;
 		}
+
+		break;
+	default:
+		ctx->errmsg = "cmp sreg has unknown type";
+		break;
 	}
 }
 
@@ -1004,18 +1074,22 @@ static void nft_parse_immediate(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
 	int verdict;
 
 	if (nftnl_expr_is_set(e, NFTNL_EXPR_IMM_DATA)) {
+		struct nft_xt_ctx_reg *dreg;
 		const void *imm_data;
 		uint32_t len;
 
 		imm_data = nftnl_expr_get_data(e, NFTNL_EXPR_IMM_DATA, &len);
+		dreg = nft_xt_ctx_get_dreg(ctx, nftnl_expr_get_u32(e, NFTNL_EXPR_IMM_DREG));
+		if (!dreg)
+			return;
 
-		if (len > sizeof(ctx->immediate.data))
+		if (len > sizeof(dreg->immediate.data))
 			return;
 
-		memcpy(ctx->immediate.data, imm_data, len);
-		ctx->immediate.len = len;
-		ctx->immediate.reg = nftnl_expr_get_u32(e, NFTNL_EXPR_IMM_DREG);
-		ctx->flags |= NFT_XT_CTX_IMMEDIATE;
+		memcpy(dreg->immediate.data, imm_data, len);
+		dreg->immediate.len = len;
+		dreg->type = NFT_XT_REG_IMMEDIATE;
+
 		return;
 	}
 
@@ -1152,20 +1226,29 @@ static void nft_parse_lookup(struct nft_xt_ctx *ctx, struct nft_handle *h,
 
 static void nft_parse_range(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
 {
+	struct nft_xt_ctx_reg *sreg;
 	uint32_t reg;
 
 	reg = nftnl_expr_get_u32(e, NFTNL_EXPR_RANGE_SREG);
-	if (reg != ctx->reg)
-		return;
+	sreg = nft_xt_ctx_get_sreg(ctx, reg);
 
-	if (ctx->flags & NFT_XT_CTX_PAYLOAD) {
-		switch (ctx->payload.base) {
+	switch (sreg->type) {
+	case NFT_XT_REG_UNDEF:
+		ctx->errmsg = "range sreg undef";
+		break;
+	case NFT_XT_REG_PAYLOAD:
+		switch (sreg->payload.base) {
 		case NFT_PAYLOAD_TRANSPORT_HEADER:
-			nft_parse_transport_range(ctx, e, ctx->cs);
+			nft_parse_transport_range(ctx, sreg, e, ctx->cs);
 			break;
 		default:
+			ctx->errmsg = "range with unknown payload base";
 			break;
 		}
+		break;
+	default:
+		ctx->errmsg = "range sreg type unsupported";
+		break;
 	}
 }
 
diff --git a/iptables/nft-shared.h b/iptables/nft-shared.h
index 0718dc23e8b7..421706389e55 100644
--- a/iptables/nft-shared.h
+++ b/iptables/nft-shared.h
@@ -38,13 +38,41 @@ struct xtables_args;
 struct nft_handle;
 struct xt_xlate;
 
-enum {
-	NFT_XT_CTX_PAYLOAD	= (1 << 0),
-	NFT_XT_CTX_META		= (1 << 1),
-	NFT_XT_CTX_BITWISE	= (1 << 2),
-	NFT_XT_CTX_IMMEDIATE	= (1 << 3),
-	NFT_XT_CTX_PREV_PAYLOAD	= (1 << 4),
-	NFT_XT_CTX_RANGE	= (1 << 5),
+enum nft_ctx_reg_type {
+	NFT_XT_REG_UNDEF,
+	NFT_XT_REG_PAYLOAD,
+	NFT_XT_REG_IMMEDIATE,
+	NFT_XT_REG_META_DREG,
+};
+
+struct nft_xt_ctx_reg {
+	enum nft_ctx_reg_type type:8;
+
+	union {
+		struct {
+			uint32_t base;
+			uint32_t offset;
+			uint32_t len;
+		} payload;
+		struct {
+			uint32_t data[4];
+			uint8_t len;
+		} immediate;
+		struct {
+			uint32_t key;
+		} meta_dreg;
+	};
+
+	struct {
+		uint32_t mask[4];
+		uint32_t xor[4];
+		bool set;
+	} bitwise;
+
+	struct {
+		uint32_t key;
+		bool set;
+	} meta_sreg;
 };
 
 struct nft_xt_ctx {
@@ -58,25 +86,51 @@ struct nft_xt_ctx {
 		struct xt_udp *udp;
 	} tcpudp;
 
-	uint32_t reg;
-	struct {
-		uint32_t base;
-		uint32_t offset;
-		uint32_t len;
-	} payload, prev_payload;
-	struct {
-		uint32_t key;
-	} meta;
-	struct {
-		uint32_t data[4];
-		uint32_t len, reg;
-	} immediate;
-	struct {
-		uint32_t mask[4];
-		uint32_t xor[4];
-	} bitwise;
+	struct nft_xt_ctx_reg regs[1 + 16];
+
+	const char *errmsg;
 };
 
+static inline struct nft_xt_ctx_reg *nft_xt_ctx_get_sreg(struct nft_xt_ctx *ctx, enum nft_registers reg)
+{
+	switch (reg) {
+	case NFT_REG_VERDICT:
+		return &ctx->regs[0];
+	case NFT_REG_1:
+		return &ctx->regs[1];
+	case NFT_REG_2:
+		return &ctx->regs[5];
+	case NFT_REG_3:
+		return &ctx->regs[9];
+	case NFT_REG_4:
+		return &ctx->regs[13];
+	case NFT_REG32_00...NFT_REG32_15:
+		return &ctx->regs[reg - NFT_REG32_00];
+	default:
+		ctx->errmsg = "Unknown register requested";
+		break;
+	}
+
+	return NULL;
+}
+
+static inline void nft_xt_reg_clear(struct nft_xt_ctx_reg *r)
+{
+	r->type = 0;
+	r->bitwise.set = false;
+	r->meta_sreg.set = false;
+}
+
+static inline struct nft_xt_ctx_reg *nft_xt_ctx_get_dreg(struct nft_xt_ctx *ctx, enum nft_registers reg)
+{
+	struct nft_xt_ctx_reg *r = nft_xt_ctx_get_sreg(ctx, reg);
+
+	if (r)
+		nft_xt_reg_clear(r);
+
+	return r;
+}
+
 struct nft_family_ops {
 	int (*add)(struct nft_handle *h, struct nftnl_rule *r,
 		   struct iptables_command_state *cs);
@@ -84,9 +138,13 @@ struct nft_family_ops {
 			const struct iptables_command_state *cs_b);
 	void (*print_payload)(struct nftnl_expr *e,
 			      struct nftnl_expr_iter *iter);
-	void (*parse_meta)(struct nft_xt_ctx *ctx, struct nftnl_expr *e,
+	void (*parse_meta)(struct nft_xt_ctx *ctx,
+			   const struct nft_xt_ctx_reg *sreg,
+			   struct nftnl_expr *e,
 			   struct iptables_command_state *cs);
-	void (*parse_payload)(struct nft_xt_ctx *ctx, struct nftnl_expr *e,
+	void (*parse_payload)(struct nft_xt_ctx *ctx,
+			      const struct nft_xt_ctx_reg *sreg,
+			      struct nftnl_expr *e,
 			      struct iptables_command_state *cs);
 	void (*parse_lookup)(struct nft_xt_ctx *ctx, struct nftnl_expr *e);
 	void (*set_goto_flag)(struct iptables_command_state *cs);
-- 
2.35.1

