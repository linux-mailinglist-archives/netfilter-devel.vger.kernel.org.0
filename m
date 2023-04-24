Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D916EB0B9
	for <lists+netfilter-devel@lfdr.de>; Fri, 21 Apr 2023 19:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjDURkG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 21 Apr 2023 13:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjDURj7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:39:59 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB67A12582
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Apr 2023 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0gnhBos42CEcw7g9FyeW/dSh8EXMUpzSdTBilBnin4Q=; b=C/UkWsy/h0xK7+etnne0C9zGrv
        YzTwAnJp8bt3QCBYYt6NHJncv0wxUXM61frr2vAp5epLaWSZxCtumR5ZAYAfe3ocQ+4dD5Oq5iDrl
        tdY7/DYzmNyBbhrMky4t8mloZalLzEntL1GoMv9vKdkqF+QQnxXoLH0nQHo4DKR4cgtAvZt9GuuJO
        h9hXWTouQr1pkpkvRUXjWWxML3U0kBipNRlKbGdmUtVQMe5reRHaPtFooxF78PSWjj4fC2ool/wT7
        xPM2diYUhCw/znDqxtWtQZv9Pjibnph1x7nSlpqvaX8l291PBBkcSTUASOf8XJkY3UIPs++zepifO
        WcA3GgTg==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1ppujd-00086F-Rv; Fri, 21 Apr 2023 19:39:50 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: [iptables PATCH 1/3] nft: Introduce nft-ruleparse.{c,h}
Date:   Fri, 21 Apr 2023 19:40:12 +0200
Message-Id: <20230421174014.17014-2-phil@nwl.cc>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421174014.17014-1-phil@nwl.cc>
References: <20230421174014.17014-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Extract all code dealing with parsing from struct nftnl_rule into struct
iptables_command_state from nft-shared.c into a separate source file.

Basically this is nft_rule_to_iptables_command_state() and the functions
it calls, plus family-independent parsers called from family-specific
callbacks.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/Makefile.am     |    1 +
 iptables/nft-ruleparse.c | 1208 ++++++++++++++++++++++++++++++++++++++
 iptables/nft-ruleparse.h |  117 ++++
 iptables/nft-shared.c    | 1190 -------------------------------------
 iptables/nft-shared.h    |  101 +---
 5 files changed, 1327 insertions(+), 1290 deletions(-)
 create mode 100644 iptables/nft-ruleparse.c
 create mode 100644 iptables/nft-ruleparse.h

diff --git a/iptables/Makefile.am b/iptables/Makefile.am
index 1f37640f263c9..d5922da6a2d84 100644
--- a/iptables/Makefile.am
+++ b/iptables/Makefile.am
@@ -46,6 +46,7 @@ xtables_nft_multi_SOURCES += nft.c nft.h \
 			     nft-cache.c nft-cache.h \
 			     nft-chain.c nft-chain.h \
 			     nft-cmd.c nft-cmd.h \
+			     nft-ruleparse.c nft-ruleparse.h \
 			     nft-shared.c nft-shared.h \
 			     xtables-monitor.c \
 			     xtables.c xtables-arp.c xtables-eb.c \
diff --git a/iptables/nft-ruleparse.c b/iptables/nft-ruleparse.c
new file mode 100644
index 0000000000000..2d84241a16819
--- /dev/null
+++ b/iptables/nft-ruleparse.c
@@ -0,0 +1,1208 @@
+/*
+ * (C) 2012-2013 by Pablo Neira Ayuso <pablo@netfilter.org>
+ * (C) 2013 by Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This code has been sponsored by Sophos Astaro <http://www.sophos.com>
+ */
+
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <linux/netfilter/nf_log.h>
+#include <linux/netfilter/xt_limit.h>
+#include <linux/netfilter/xt_mark.h>
+#include <linux/netfilter/xt_NFLOG.h>
+#include <linux/netfilter/xt_pkttype.h>
+
+#include <linux/netfilter_ipv6/ip6t_hl.h>
+
+#include <libnftnl/rule.h>
+#include <libnftnl/expr.h>
+
+#include <xtables.h>
+
+#include "nft-ruleparse.h"
+#include "nft.h"
+
+static struct xtables_match *
+nft_find_match_in_cs(struct iptables_command_state *cs, const char *name)
+{
+	struct xtables_rule_match *rm;
+	struct ebt_match *ebm;
+
+	for (ebm = cs->match_list; ebm; ebm = ebm->next) {
+		if (ebm->ismatch &&
+		    !strcmp(ebm->u.match->m->u.user.name, name))
+			return ebm->u.match;
+	}
+	for (rm = cs->matches; rm; rm = rm->next) {
+		if (!strcmp(rm->match->m->u.user.name, name))
+			return rm->match;
+	}
+	return NULL;
+}
+
+void *
+nft_create_match(struct nft_xt_ctx *ctx,
+		 struct iptables_command_state *cs,
+		 const char *name, bool reuse)
+{
+	struct xtables_match *match;
+	struct xt_entry_match *m;
+	unsigned int size;
+
+	if (reuse) {
+		match = nft_find_match_in_cs(cs, name);
+		if (match)
+			return match->m->data;
+	}
+
+	match = xtables_find_match(name, XTF_TRY_LOAD,
+				   &cs->matches);
+	if (!match)
+		return NULL;
+
+	size = XT_ALIGN(sizeof(struct xt_entry_match)) + match->size;
+	m = xtables_calloc(1, size);
+	m->u.match_size = size;
+	m->u.user.revision = match->revision;
+
+	strcpy(m->u.user.name, match->name);
+	match->m = m;
+
+	xs_init_match(match);
+
+	if (ctx->h->ops->parse_match)
+		ctx->h->ops->parse_match(match, cs);
+
+	return match->m->data;
+}
+
+static void nft_parse_counter(struct nftnl_expr *e, struct xt_counters *counters)
+{
+	counters->pcnt = nftnl_expr_get_u64(e, NFTNL_EXPR_CTR_PACKETS);
+	counters->bcnt = nftnl_expr_get_u64(e, NFTNL_EXPR_CTR_BYTES);
+}
+
+static void nft_parse_payload(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
+{
+	enum nft_registers regnum = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_DREG);
+	struct nft_xt_ctx_reg *reg = nft_xt_ctx_get_dreg(ctx, regnum);
+
+	if (!reg)
+		return;
+
+	reg->type = NFT_XT_REG_PAYLOAD;
+	reg->payload.base = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_BASE);
+	reg->payload.offset = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_OFFSET);
+	reg->payload.len = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_LEN);
+}
+
+static bool nft_parse_meta_set_common(struct nft_xt_ctx* ctx,
+				      struct nft_xt_ctx_reg *sreg)
+{
+	if ((sreg->type != NFT_XT_REG_IMMEDIATE)) {
+		ctx->errmsg = "meta sreg is not an immediate";
+		return false;
+	}
+
+	if (sreg->immediate.data[0] == 0) {
+		ctx->errmsg = "meta sreg immediate is 0";
+		return false;
+	}
+
+	return true;
+}
+
+static void nft_parse_meta_set(struct nft_xt_ctx *ctx,
+			       struct nftnl_expr *e)
+{
+	struct xtables_target *target;
+	struct nft_xt_ctx_reg *sreg;
+	enum nft_registers sregnum;
+	struct xt_entry_target *t;
+	unsigned int size;
+	const char *targname;
+
+	sregnum = nftnl_expr_get_u32(e, NFTNL_EXPR_META_SREG);
+	sreg = nft_xt_ctx_get_sreg(ctx, sregnum);
+	if (!sreg)
+		return;
+
+	switch (nftnl_expr_get_u32(e, NFTNL_EXPR_META_KEY)) {
+	case NFT_META_NFTRACE:
+		if (!nft_parse_meta_set_common(ctx, sreg))
+			return;
+
+		targname = "TRACE";
+		break;
+	case NFT_META_BRI_BROUTE:
+		if (!nft_parse_meta_set_common(ctx, sreg))
+			return;
+
+		ctx->cs->jumpto = "DROP";
+		return;
+	default:
+		ctx->errmsg = "meta sreg key not supported";
+		return;
+	}
+
+	target = xtables_find_target(targname, XTF_TRY_LOAD);
+	if (target == NULL) {
+		ctx->errmsg = "target TRACE not found";
+		return;
+	}
+
+	size = XT_ALIGN(sizeof(struct xt_entry_target)) + target->size;
+
+	t = xtables_calloc(1, size);
+	t->u.target_size = size;
+	t->u.user.revision = target->revision;
+	strcpy(t->u.user.name, targname);
+
+	target->t = t;
+
+	ctx->h->ops->parse_target(target, ctx->cs);
+}
+
+static void nft_parse_meta(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
+{
+        struct nft_xt_ctx_reg *reg;
+
+	if (nftnl_expr_is_set(e, NFTNL_EXPR_META_SREG)) {
+		nft_parse_meta_set(ctx, e);
+		return;
+	}
+
+	reg = nft_xt_ctx_get_dreg(ctx, nftnl_expr_get_u32(e, NFTNL_EXPR_META_DREG));
+	if (!reg)
+		return;
+
+	reg->meta_dreg.key = nftnl_expr_get_u32(e, NFTNL_EXPR_META_KEY);
+	reg->type = NFT_XT_REG_META_DREG;
+}
+
+static void nft_parse_bitwise(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
+{
+	enum nft_registers sregnum = nftnl_expr_get_u32(e, NFTNL_EXPR_BITWISE_SREG);
+	enum nft_registers dregnum = nftnl_expr_get_u32(e, NFTNL_EXPR_BITWISE_DREG);
+	struct nft_xt_ctx_reg *sreg = nft_xt_ctx_get_sreg(ctx, sregnum);
+	struct nft_xt_ctx_reg *dreg = sreg;
+	const void *data;
+	uint32_t len;
+
+	if (!sreg)
+		return;
+
+	if (sregnum != dregnum) {
+		dreg = nft_xt_ctx_get_sreg(ctx, dregnum); /* sreg, do NOT clear ... */
+		if (!dreg)
+			return;
+
+		*dreg = *sreg;  /* .. and copy content instead */
+	}
+
+	data = nftnl_expr_get(e, NFTNL_EXPR_BITWISE_XOR, &len);
+
+	if (len > sizeof(dreg->bitwise.xor)) {
+		ctx->errmsg = "bitwise xor too large";
+		return;
+	}
+
+	memcpy(dreg->bitwise.xor, data, len);
+
+	data = nftnl_expr_get(e, NFTNL_EXPR_BITWISE_MASK, &len);
+
+	if (len > sizeof(dreg->bitwise.mask)) {
+		ctx->errmsg = "bitwise mask too large";
+		return;
+	}
+
+	memcpy(dreg->bitwise.mask, data, len);
+
+	dreg->bitwise.set = true;
+}
+
+static void nft_parse_icmp(struct nft_xt_ctx *ctx,
+			   struct iptables_command_state *cs,
+			   struct nft_xt_ctx_reg *sreg,
+			   uint8_t op, const char *data, size_t dlen)
+{
+	struct ipt_icmp icmp = {
+		.type = UINT8_MAX,
+		.code = { 0, UINT8_MAX },
+	}, *icmpp;
+
+	if (dlen < 1)
+		goto out_err_len;
+
+	switch (sreg->payload.offset) {
+	case 0:
+		icmp.type = data[0];
+		if (dlen == 1)
+			break;
+		dlen--;
+		data++;
+		/* fall through */
+	case 1:
+		if (dlen > 1)
+			goto out_err_len;
+		icmp.code[0] = icmp.code[1] = data[0];
+		break;
+	default:
+		ctx->errmsg = "unexpected payload offset";
+		return;
+	}
+
+	switch (ctx->h->family) {
+	case NFPROTO_IPV4:
+		icmpp = nft_create_match(ctx, cs, "icmp", false);
+		break;
+	case NFPROTO_IPV6:
+		if (icmp.type == UINT8_MAX) {
+			ctx->errmsg = "icmp6 code with any type match not supported";
+			return;
+		}
+		icmpp = nft_create_match(ctx, cs, "icmp6", false);
+		break;
+	default:
+		ctx->errmsg = "unexpected family for icmp match";
+		return;
+	}
+
+	if (!icmpp) {
+		ctx->errmsg = "icmp match extension not found";
+		return;
+	}
+	memcpy(icmpp, &icmp, sizeof(icmp));
+	return;
+
+out_err_len:
+	ctx->errmsg = "unexpected RHS data length";
+}
+
+static void port_match_single_to_range(__u16 *ports, __u8 *invflags,
+				       uint8_t op, int port, __u8 invflag)
+{
+	if (port < 0)
+		return;
+
+	switch (op) {
+	case NFT_CMP_NEQ:
+		*invflags |= invflag;
+		/* fallthrough */
+	case NFT_CMP_EQ:
+		ports[0] = port;
+		ports[1] = port;
+		break;
+	case NFT_CMP_LT:
+		ports[1] = max(port - 1, 1);
+		break;
+	case NFT_CMP_LTE:
+		ports[1] = port;
+		break;
+	case NFT_CMP_GT:
+		ports[0] = min(port + 1, UINT16_MAX);
+		break;
+	case NFT_CMP_GTE:
+		ports[0] = port;
+		break;
+	}
+}
+
+static void nft_parse_udp(struct nft_xt_ctx *ctx,
+			  struct iptables_command_state *cs,
+			  int sport, int dport,
+			  uint8_t op)
+{
+	struct xt_udp *udp = nft_create_match(ctx, cs, "udp", true);
+
+	if (!udp) {
+		ctx->errmsg = "udp match extension not found";
+		return;
+	}
+
+	port_match_single_to_range(udp->spts, &udp->invflags,
+				   op, sport, XT_UDP_INV_SRCPT);
+	port_match_single_to_range(udp->dpts, &udp->invflags,
+				   op, dport, XT_UDP_INV_DSTPT);
+}
+
+static void nft_parse_tcp(struct nft_xt_ctx *ctx,
+			  struct iptables_command_state *cs,
+			  int sport, int dport,
+			  uint8_t op)
+{
+	struct xt_tcp *tcp = nft_create_match(ctx, cs, "tcp", true);
+
+	if (!tcp) {
+		ctx->errmsg = "tcp match extension not found";
+		return;
+	}
+
+	port_match_single_to_range(tcp->spts, &tcp->invflags,
+				   op, sport, XT_TCP_INV_SRCPT);
+	port_match_single_to_range(tcp->dpts, &tcp->invflags,
+				   op, dport, XT_TCP_INV_DSTPT);
+}
+
+static void nft_parse_th_port(struct nft_xt_ctx *ctx,
+			      struct iptables_command_state *cs,
+			      uint8_t proto,
+			      int sport, int dport, uint8_t op)
+{
+	switch (proto) {
+	case IPPROTO_UDP:
+		nft_parse_udp(ctx, cs, sport, dport, op);
+		break;
+	case IPPROTO_TCP:
+		nft_parse_tcp(ctx, cs, sport, dport, op);
+		break;
+	default:
+		ctx->errmsg = "unknown layer 4 protocol for TH match";
+	}
+}
+
+static void nft_parse_tcp_flags(struct nft_xt_ctx *ctx,
+				struct iptables_command_state *cs,
+				uint8_t op, uint8_t flags, uint8_t mask)
+{
+	struct xt_tcp *tcp = nft_create_match(ctx, cs, "tcp", true);
+
+	if (!tcp) {
+		ctx->errmsg = "tcp match extension not found";
+		return;
+	}
+
+	if (op == NFT_CMP_NEQ)
+		tcp->invflags |= XT_TCP_INV_FLAGS;
+	tcp->flg_cmp = flags;
+	tcp->flg_mask = mask;
+}
+
+static void nft_parse_transport(struct nft_xt_ctx *ctx,
+				struct nftnl_expr *e,
+				struct iptables_command_state *cs)
+{
+	struct nft_xt_ctx_reg *sreg;
+	enum nft_registers reg;
+	uint32_t sdport;
+	uint16_t port;
+	uint8_t proto, op;
+	unsigned int len;
+
+	switch (ctx->h->family) {
+	case NFPROTO_IPV4:
+		proto = ctx->cs->fw.ip.proto;
+		break;
+	case NFPROTO_IPV6:
+		proto = ctx->cs->fw6.ipv6.proto;
+		break;
+	default:
+		ctx->errmsg = "invalid family for TH match";
+		return;
+	}
+
+	nftnl_expr_get(e, NFTNL_EXPR_CMP_DATA, &len);
+	op = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP);
+
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
+	switch (proto) {
+	case IPPROTO_UDP:
+	case IPPROTO_TCP:
+		break;
+	case IPPROTO_ICMP:
+	case IPPROTO_ICMPV6:
+		nft_parse_icmp(ctx, cs, sreg, op,
+			       nftnl_expr_get(e, NFTNL_EXPR_CMP_DATA, &len),
+			       len);
+		return;
+	default:
+		ctx->errmsg = "unsupported layer 4 protocol value";
+		return;
+	}
+
+	switch(sreg->payload.offset) {
+	case 0: /* th->sport */
+		switch (len) {
+		case 2: /* load sport only */
+			port = ntohs(nftnl_expr_get_u16(e, NFTNL_EXPR_CMP_DATA));
+			nft_parse_th_port(ctx, cs, proto, port, -1, op);
+			return;
+		case 4: /* load both src and dst port */
+			sdport = ntohl(nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_DATA));
+			nft_parse_th_port(ctx, cs, proto, sdport >> 16, sdport & 0xffff, op);
+			return;
+		}
+		break;
+	case 2: /* th->dport */
+		switch (len) {
+		case 2:
+			port = ntohs(nftnl_expr_get_u16(e, NFTNL_EXPR_CMP_DATA));
+			nft_parse_th_port(ctx, cs, proto, -1, port, op);
+			return;
+		}
+		break;
+	case 13: /* th->flags */
+		if (len == 1 && proto == IPPROTO_TCP) {
+			uint8_t flags = nftnl_expr_get_u8(e, NFTNL_EXPR_CMP_DATA);
+			uint8_t mask = ~0;
+
+			if (sreg->bitwise.set)
+				memcpy(&mask, &sreg->bitwise.mask, sizeof(mask));
+
+			nft_parse_tcp_flags(ctx, cs, op, flags, mask);
+		}
+		return;
+	}
+}
+
+static void nft_parse_cmp(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
+{
+	struct nft_xt_ctx_reg *sreg;
+	uint32_t reg;
+
+	reg = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_SREG);
+
+	sreg = nft_xt_ctx_get_sreg(ctx, reg);
+	if (!sreg)
+		return;
+
+	switch (sreg->type) {
+	case NFT_XT_REG_UNDEF:
+		ctx->errmsg = "cmp sreg undef";
+		break;
+	case NFT_XT_REG_META_DREG:
+		ctx->h->ops->parse_meta(ctx, sreg, e, ctx->cs);
+		break;
+	case NFT_XT_REG_PAYLOAD:
+		switch (sreg->payload.base) {
+		case NFT_PAYLOAD_LL_HEADER:
+			if (ctx->h->family == NFPROTO_BRIDGE)
+				ctx->h->ops->parse_payload(ctx, sreg, e, ctx->cs);
+			break;
+		case NFT_PAYLOAD_NETWORK_HEADER:
+			ctx->h->ops->parse_payload(ctx, sreg, e, ctx->cs);
+			break;
+		case NFT_PAYLOAD_TRANSPORT_HEADER:
+			nft_parse_transport(ctx, e, ctx->cs);
+			break;
+		}
+
+		break;
+	default:
+		ctx->errmsg = "cmp sreg has unknown type";
+		break;
+	}
+}
+
+static void nft_parse_immediate(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
+{
+	const char *chain = nftnl_expr_get_str(e, NFTNL_EXPR_IMM_CHAIN);
+	struct iptables_command_state *cs = ctx->cs;
+	struct xt_entry_target *t;
+	uint32_t size;
+	int verdict;
+
+	if (nftnl_expr_is_set(e, NFTNL_EXPR_IMM_DATA)) {
+		struct nft_xt_ctx_reg *dreg;
+		const void *imm_data;
+		uint32_t len;
+
+		imm_data = nftnl_expr_get(e, NFTNL_EXPR_IMM_DATA, &len);
+		dreg = nft_xt_ctx_get_dreg(ctx, nftnl_expr_get_u32(e, NFTNL_EXPR_IMM_DREG));
+		if (!dreg)
+			return;
+
+		if (len > sizeof(dreg->immediate.data)) {
+			ctx->errmsg = "oversized immediate data";
+			return;
+		}
+
+		memcpy(dreg->immediate.data, imm_data, len);
+		dreg->immediate.len = len;
+		dreg->type = NFT_XT_REG_IMMEDIATE;
+
+		return;
+	}
+
+	verdict = nftnl_expr_get_u32(e, NFTNL_EXPR_IMM_VERDICT);
+	/* Standard target? */
+	switch(verdict) {
+	case NF_ACCEPT:
+		if (cs->jumpto && strcmp(ctx->table, "broute") == 0)
+			break;
+		cs->jumpto = "ACCEPT";
+		break;
+	case NF_DROP:
+		cs->jumpto = "DROP";
+		break;
+	case NFT_RETURN:
+		cs->jumpto = "RETURN";
+		break;;
+	case NFT_GOTO:
+		if (ctx->h->ops->set_goto_flag)
+			ctx->h->ops->set_goto_flag(cs);
+		/* fall through */
+	case NFT_JUMP:
+		cs->jumpto = chain;
+		/* fall through */
+	default:
+		return;
+	}
+
+	cs->target = xtables_find_target(cs->jumpto, XTF_TRY_LOAD);
+	if (!cs->target) {
+		ctx->errmsg = "verdict extension not found";
+		return;
+	}
+
+	size = XT_ALIGN(sizeof(struct xt_entry_target)) + cs->target->size;
+	t = xtables_calloc(1, size);
+	t->u.target_size = size;
+	t->u.user.revision = cs->target->revision;
+	strcpy(t->u.user.name, cs->jumpto);
+	cs->target->t = t;
+}
+
+static void nft_parse_match(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
+{
+	uint32_t mt_len;
+	const char *mt_name = nftnl_expr_get_str(e, NFTNL_EXPR_MT_NAME);
+	const void *mt_info = nftnl_expr_get(e, NFTNL_EXPR_MT_INFO, &mt_len);
+	struct xtables_match *match;
+	struct xtables_rule_match **matches;
+	struct xt_entry_match *m;
+
+	switch (ctx->h->family) {
+	case NFPROTO_IPV4:
+	case NFPROTO_IPV6:
+	case NFPROTO_BRIDGE:
+		matches = &ctx->cs->matches;
+		break;
+	default:
+		fprintf(stderr, "BUG: nft_parse_match() unknown family %d\n",
+			ctx->h->family);
+		exit(EXIT_FAILURE);
+	}
+
+	match = xtables_find_match(mt_name, XTF_TRY_LOAD, matches);
+	if (match == NULL) {
+		ctx->errmsg = "match extension not found";
+		return;
+	}
+
+	m = xtables_calloc(1, sizeof(struct xt_entry_match) + mt_len);
+	memcpy(&m->data, mt_info, mt_len);
+	m->u.match_size = mt_len + XT_ALIGN(sizeof(struct xt_entry_match));
+	m->u.user.revision = nftnl_expr_get_u32(e, NFTNL_EXPR_TG_REV);
+	strcpy(m->u.user.name, match->name);
+
+	match->m = m;
+
+	if (ctx->h->ops->parse_match != NULL)
+		ctx->h->ops->parse_match(match, ctx->cs);
+}
+
+static void nft_parse_target(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
+{
+	uint32_t tg_len;
+	const char *targname = nftnl_expr_get_str(e, NFTNL_EXPR_TG_NAME);
+	const void *targinfo = nftnl_expr_get(e, NFTNL_EXPR_TG_INFO, &tg_len);
+	struct xtables_target *target;
+	struct xt_entry_target *t;
+	size_t size;
+
+	target = xtables_find_target(targname, XTF_TRY_LOAD);
+	if (target == NULL) {
+		ctx->errmsg = "target extension not found";
+		return;
+	}
+
+	size = XT_ALIGN(sizeof(struct xt_entry_target)) + tg_len;
+
+	t = xtables_calloc(1, size);
+	memcpy(&t->data, targinfo, tg_len);
+	t->u.target_size = size;
+	t->u.user.revision = nftnl_expr_get_u32(e, NFTNL_EXPR_TG_REV);
+	strcpy(t->u.user.name, target->name);
+
+	target->t = t;
+
+	ctx->h->ops->parse_target(target, ctx->cs);
+}
+
+static void nft_parse_limit(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
+{
+	__u32 burst = nftnl_expr_get_u32(e, NFTNL_EXPR_LIMIT_BURST);
+	__u64 unit = nftnl_expr_get_u64(e, NFTNL_EXPR_LIMIT_UNIT);
+	__u64 rate = nftnl_expr_get_u64(e, NFTNL_EXPR_LIMIT_RATE);
+	struct xt_rateinfo *rinfo;
+
+	switch (ctx->h->family) {
+	case NFPROTO_IPV4:
+	case NFPROTO_IPV6:
+	case NFPROTO_BRIDGE:
+		break;
+	default:
+		fprintf(stderr, "BUG: nft_parse_limit() unknown family %d\n",
+			ctx->h->family);
+		exit(EXIT_FAILURE);
+	}
+
+	rinfo = nft_create_match(ctx, ctx->cs, "limit", false);
+	if (!rinfo) {
+		ctx->errmsg = "limit match extension not found";
+		return;
+	}
+
+	rinfo->avg = XT_LIMIT_SCALE * unit / rate;
+	rinfo->burst = burst;
+}
+
+static void nft_parse_lookup(struct nft_xt_ctx *ctx, struct nft_handle *h,
+			     struct nftnl_expr *e)
+{
+	if (ctx->h->ops->parse_lookup)
+		ctx->h->ops->parse_lookup(ctx, e);
+}
+
+static void nft_parse_log(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
+{
+	struct xtables_target *target;
+	struct xt_entry_target *t;
+	size_t target_size;
+	/*
+	 * In order to handle the longer log-prefix supported by nft, instead of
+	 * using struct xt_nflog_info, we use a struct with a compatible layout, but
+	 * a larger buffer for the prefix.
+	 */
+	struct xt_nflog_info_nft {
+		__u32 len;
+		__u16 group;
+		__u16 threshold;
+		__u16 flags;
+		__u16 pad;
+		char  prefix[NF_LOG_PREFIXLEN];
+	} info = {
+		.group     = nftnl_expr_get_u16(e, NFTNL_EXPR_LOG_GROUP),
+		.threshold = nftnl_expr_get_u16(e, NFTNL_EXPR_LOG_QTHRESHOLD),
+	};
+	if (nftnl_expr_is_set(e, NFTNL_EXPR_LOG_SNAPLEN)) {
+		info.len = nftnl_expr_get_u32(e, NFTNL_EXPR_LOG_SNAPLEN);
+		info.flags = XT_NFLOG_F_COPY_LEN;
+	}
+	if (nftnl_expr_is_set(e, NFTNL_EXPR_LOG_PREFIX))
+		snprintf(info.prefix, sizeof(info.prefix), "%s",
+			 nftnl_expr_get_str(e, NFTNL_EXPR_LOG_PREFIX));
+
+	target = xtables_find_target("NFLOG", XTF_TRY_LOAD);
+	if (target == NULL) {
+		ctx->errmsg = "NFLOG target extension not found";
+		return;
+	}
+
+	target_size = XT_ALIGN(sizeof(struct xt_entry_target)) +
+		      XT_ALIGN(sizeof(struct xt_nflog_info_nft));
+
+	t = xtables_calloc(1, target_size);
+	t->u.target_size = target_size;
+	strcpy(t->u.user.name, target->name);
+	t->u.user.revision = target->revision;
+
+	target->t = t;
+
+	memcpy(&target->t->data, &info, sizeof(info));
+
+	ctx->h->ops->parse_target(target, ctx->cs);
+}
+
+static void nft_parse_udp_range(struct nft_xt_ctx *ctx,
+			        struct iptables_command_state *cs,
+			        int sport_from, int sport_to,
+			        int dport_from, int dport_to,
+				uint8_t op)
+{
+	struct xt_udp *udp = nft_create_match(ctx, cs, "udp", true);
+
+	if (!udp) {
+		ctx->errmsg = "udp match extension not found";
+		return;
+	}
+
+	if (sport_from >= 0) {
+		switch (op) {
+		case NFT_RANGE_NEQ:
+			udp->invflags |= XT_UDP_INV_SRCPT;
+			/* fallthrough */
+		case NFT_RANGE_EQ:
+			udp->spts[0] = sport_from;
+			udp->spts[1] = sport_to;
+			break;
+		}
+	}
+
+	if (dport_to >= 0) {
+		switch (op) {
+		case NFT_CMP_NEQ:
+			udp->invflags |= XT_UDP_INV_DSTPT;
+			/* fallthrough */
+		case NFT_CMP_EQ:
+			udp->dpts[0] = dport_from;
+			udp->dpts[1] = dport_to;
+			break;
+		}
+	}
+}
+
+static void nft_parse_tcp_range(struct nft_xt_ctx *ctx,
+			        struct iptables_command_state *cs,
+			        int sport_from, int sport_to,
+			        int dport_from, int dport_to,
+				uint8_t op)
+{
+	struct xt_tcp *tcp = nft_create_match(ctx, cs, "tcp", true);
+
+	if (!tcp) {
+		ctx->errmsg = "tcp match extension not found";
+		return;
+	}
+
+	if (sport_from >= 0) {
+		switch (op) {
+		case NFT_RANGE_NEQ:
+			tcp->invflags |= XT_TCP_INV_SRCPT;
+			/* fallthrough */
+		case NFT_RANGE_EQ:
+			tcp->spts[0] = sport_from;
+			tcp->spts[1] = sport_to;
+			break;
+		}
+	}
+
+	if (dport_to >= 0) {
+		switch (op) {
+		case NFT_CMP_NEQ:
+			tcp->invflags |= XT_TCP_INV_DSTPT;
+			/* fallthrough */
+		case NFT_CMP_EQ:
+			tcp->dpts[0] = dport_from;
+			tcp->dpts[1] = dport_to;
+			break;
+		}
+	}
+}
+
+static void nft_parse_th_port_range(struct nft_xt_ctx *ctx,
+				    struct iptables_command_state *cs,
+				    uint8_t proto,
+				    int sport_from, int sport_to,
+				    int dport_from, int dport_to, uint8_t op)
+{
+	switch (proto) {
+	case IPPROTO_UDP:
+		nft_parse_udp_range(ctx, cs, sport_from, sport_to, dport_from, dport_to, op);
+		break;
+	case IPPROTO_TCP:
+		nft_parse_tcp_range(ctx, cs, sport_from, sport_to, dport_from, dport_to, op);
+		break;
+	}
+}
+
+static void nft_parse_transport_range(struct nft_xt_ctx *ctx,
+				      const struct nft_xt_ctx_reg *sreg,
+				      struct nftnl_expr *e,
+				      struct iptables_command_state *cs)
+{
+	unsigned int len_from, len_to;
+	uint8_t proto, op;
+	uint16_t from, to;
+
+	switch (ctx->h->family) {
+	case NFPROTO_IPV4:
+		proto = ctx->cs->fw.ip.proto;
+		break;
+	case NFPROTO_IPV6:
+		proto = ctx->cs->fw6.ipv6.proto;
+		break;
+	default:
+		proto = 0;
+		break;
+	}
+
+	nftnl_expr_get(e, NFTNL_EXPR_RANGE_FROM_DATA, &len_from);
+	nftnl_expr_get(e, NFTNL_EXPR_RANGE_FROM_DATA, &len_to);
+	if (len_to != len_from || len_to != 2)
+		return;
+
+	op = nftnl_expr_get_u32(e, NFTNL_EXPR_RANGE_OP);
+
+	from = ntohs(nftnl_expr_get_u16(e, NFTNL_EXPR_RANGE_FROM_DATA));
+	to = ntohs(nftnl_expr_get_u16(e, NFTNL_EXPR_RANGE_TO_DATA));
+
+	switch (sreg->payload.offset) {
+	case 0:
+		nft_parse_th_port_range(ctx, cs, proto, from, to, -1, -1, op);
+		return;
+	case 2:
+		to = ntohs(nftnl_expr_get_u16(e, NFTNL_EXPR_RANGE_TO_DATA));
+		nft_parse_th_port_range(ctx, cs, proto, -1, -1, from, to, op);
+		return;
+	}
+}
+
+static void nft_parse_range(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
+{
+	struct nft_xt_ctx_reg *sreg;
+	uint32_t reg;
+
+	reg = nftnl_expr_get_u32(e, NFTNL_EXPR_RANGE_SREG);
+	sreg = nft_xt_ctx_get_sreg(ctx, reg);
+
+	switch (sreg->type) {
+	case NFT_XT_REG_UNDEF:
+		ctx->errmsg = "range sreg undef";
+		break;
+	case NFT_XT_REG_PAYLOAD:
+		switch (sreg->payload.base) {
+		case NFT_PAYLOAD_TRANSPORT_HEADER:
+			nft_parse_transport_range(ctx, sreg, e, ctx->cs);
+			break;
+		default:
+			ctx->errmsg = "range with unknown payload base";
+			break;
+		}
+		break;
+	default:
+		ctx->errmsg = "range sreg type unsupported";
+		break;
+	}
+}
+
+bool nft_rule_to_iptables_command_state(struct nft_handle *h,
+					const struct nftnl_rule *r,
+					struct iptables_command_state *cs)
+{
+	struct nftnl_expr_iter *iter;
+	struct nftnl_expr *expr;
+	struct nft_xt_ctx ctx = {
+		.cs = cs,
+		.h = h,
+		.table = nftnl_rule_get_str(r, NFTNL_RULE_TABLE),
+	};
+	bool ret = true;
+
+	iter = nftnl_expr_iter_create(r);
+	if (iter == NULL)
+		return false;
+
+	ctx.iter = iter;
+	expr = nftnl_expr_iter_next(iter);
+	while (expr != NULL) {
+		const char *name =
+			nftnl_expr_get_str(expr, NFTNL_EXPR_NAME);
+
+		if (strcmp(name, "counter") == 0)
+			nft_parse_counter(expr, &ctx.cs->counters);
+		else if (strcmp(name, "payload") == 0)
+			nft_parse_payload(&ctx, expr);
+		else if (strcmp(name, "meta") == 0)
+			nft_parse_meta(&ctx, expr);
+		else if (strcmp(name, "bitwise") == 0)
+			nft_parse_bitwise(&ctx, expr);
+		else if (strcmp(name, "cmp") == 0)
+			nft_parse_cmp(&ctx, expr);
+		else if (strcmp(name, "immediate") == 0)
+			nft_parse_immediate(&ctx, expr);
+		else if (strcmp(name, "match") == 0)
+			nft_parse_match(&ctx, expr);
+		else if (strcmp(name, "target") == 0)
+			nft_parse_target(&ctx, expr);
+		else if (strcmp(name, "limit") == 0)
+			nft_parse_limit(&ctx, expr);
+		else if (strcmp(name, "lookup") == 0)
+			nft_parse_lookup(&ctx, h, expr);
+		else if (strcmp(name, "log") == 0)
+			nft_parse_log(&ctx, expr);
+		else if (strcmp(name, "range") == 0)
+			nft_parse_range(&ctx, expr);
+
+		if (ctx.errmsg) {
+			fprintf(stderr, "Error: %s\n", ctx.errmsg);
+			ctx.errmsg = NULL;
+			ret = false;
+		}
+
+		expr = nftnl_expr_iter_next(iter);
+	}
+
+	nftnl_expr_iter_destroy(iter);
+
+	if (nftnl_rule_is_set(r, NFTNL_RULE_USERDATA)) {
+		const void *data;
+		uint32_t len, size;
+		const char *comment;
+
+		data = nftnl_rule_get_data(r, NFTNL_RULE_USERDATA, &len);
+		comment = get_comment(data, len);
+		if (comment) {
+			struct xtables_match *match;
+			struct xt_entry_match *m;
+
+			match = xtables_find_match("comment", XTF_TRY_LOAD,
+						   &cs->matches);
+			if (match == NULL)
+				return false;
+
+			size = XT_ALIGN(sizeof(struct xt_entry_match))
+				+ match->size;
+			m = xtables_calloc(1, size);
+
+			strncpy((char *)m->data, comment, match->size - 1);
+			m->u.match_size = size;
+			m->u.user.revision = 0;
+			strcpy(m->u.user.name, match->name);
+
+			match->m = m;
+		}
+	}
+
+	if (!cs->jumpto)
+		cs->jumpto = "";
+
+	if (!ret)
+		xtables_error(VERSION_PROBLEM, "Parsing nftables rule failed");
+	return ret;
+}
+
+static void parse_ifname(const char *name, unsigned int len,
+			 char *dst, unsigned char *mask)
+{
+	if (len == 0)
+		return;
+
+	memcpy(dst, name, len);
+	if (name[len - 1] == '\0') {
+		if (mask)
+			memset(mask, 0xff, strlen(name) + 1);
+		return;
+	}
+
+	if (len >= IFNAMSIZ)
+		return;
+
+	/* wildcard */
+	dst[len++] = '+';
+	if (len >= IFNAMSIZ)
+		return;
+	dst[len++] = 0;
+	if (mask)
+		memset(mask, 0xff, len - 2);
+}
+
+static void parse_invalid_iface(char *iface, unsigned char *mask,
+				uint8_t *invflags, uint8_t invbit)
+{
+	if (*invflags & invbit || strcmp(iface, "INVAL/D"))
+		return;
+
+	/* nft's poor "! -o +" excuse */
+	*invflags |= invbit;
+	iface[0] = '+';
+	iface[1] = '\0';
+	mask[0] = 0xff;
+	mask[1] = 0xff;
+	memset(mask + 2, 0, IFNAMSIZ - 2);
+}
+
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
+static int parse_meta_mark(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
+{
+	struct xt_mark_mtinfo1 *mark;
+	uint32_t value;
+
+	mark = nft_create_match(ctx, ctx->cs, "mark", false);
+	if (!mark)
+		return -1;
+
+	if (nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP) == NFT_CMP_NEQ)
+		mark->invert = 1;
+
+	value = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_DATA);
+	mark->mark = value;
+	mark->mask = get_meta_mask(ctx, nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_SREG));
+
+	return 0;
+}
+
+static int parse_meta_pkttype(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
+{
+	struct xt_pkttype_info *pkttype;
+	uint8_t value;
+
+	pkttype = nft_create_match(ctx, ctx->cs, "pkttype", false);
+	if (!pkttype)
+		return -1;
+
+	if (nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP) == NFT_CMP_NEQ)
+		pkttype->invert = 1;
+
+	value = nftnl_expr_get_u8(e, NFTNL_EXPR_CMP_DATA);
+	pkttype->pkttype = value;
+
+	return 0;
+}
+
+int parse_meta(struct nft_xt_ctx *ctx, struct nftnl_expr *e, uint8_t key,
+	       char *iniface, unsigned char *iniface_mask,
+	       char *outiface, unsigned char *outiface_mask, uint8_t *invflags)
+{
+	uint32_t value;
+	const void *ifname;
+	uint32_t len;
+
+	switch(key) {
+	case NFT_META_IIF:
+		value = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_DATA);
+		if (nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP) == NFT_CMP_NEQ)
+			*invflags |= IPT_INV_VIA_IN;
+
+		if_indextoname(value, iniface);
+
+		memset(iniface_mask, 0xff, strlen(iniface)+1);
+		break;
+	case NFT_META_OIF:
+		value = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_DATA);
+		if (nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP) == NFT_CMP_NEQ)
+			*invflags |= IPT_INV_VIA_OUT;
+
+		if_indextoname(value, outiface);
+
+		memset(outiface_mask, 0xff, strlen(outiface)+1);
+		break;
+	case NFT_META_BRI_IIFNAME:
+	case NFT_META_IIFNAME:
+		ifname = nftnl_expr_get(e, NFTNL_EXPR_CMP_DATA, &len);
+		if (nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP) == NFT_CMP_NEQ)
+			*invflags |= IPT_INV_VIA_IN;
+
+		parse_ifname(ifname, len, iniface, iniface_mask);
+		parse_invalid_iface(iniface, iniface_mask,
+				    invflags, IPT_INV_VIA_IN);
+		break;
+	case NFT_META_BRI_OIFNAME:
+	case NFT_META_OIFNAME:
+		ifname = nftnl_expr_get(e, NFTNL_EXPR_CMP_DATA, &len);
+		if (nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP) == NFT_CMP_NEQ)
+			*invflags |= IPT_INV_VIA_OUT;
+
+		parse_ifname(ifname, len, outiface, outiface_mask);
+		parse_invalid_iface(outiface, outiface_mask,
+				    invflags, IPT_INV_VIA_OUT);
+		break;
+	case NFT_META_MARK:
+		parse_meta_mark(ctx, e);
+		break;
+	case NFT_META_PKTTYPE:
+		parse_meta_pkttype(ctx, e);
+		break;
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
+void nft_ipv46_parse_target(struct xtables_target *t,
+			    struct iptables_command_state *cs)
+{
+	cs->target = t;
+	cs->jumpto = t->name;
+}
+
+int nft_parse_hl(struct nft_xt_ctx *ctx, struct nftnl_expr *e,
+		 struct iptables_command_state *cs)
+{
+	struct ip6t_hl_info *info;
+	uint8_t hl, mode;
+	int op;
+
+	hl = nftnl_expr_get_u8(e, NFTNL_EXPR_CMP_DATA);
+	op = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP);
+
+	switch (op) {
+	case NFT_CMP_NEQ:
+		mode = IP6T_HL_NE;
+		break;
+	case NFT_CMP_EQ:
+		mode = IP6T_HL_EQ;
+		break;
+	case NFT_CMP_LT:
+		mode = IP6T_HL_LT;
+		break;
+	case NFT_CMP_GT:
+		mode = IP6T_HL_GT;
+		break;
+	case NFT_CMP_LTE:
+		mode = IP6T_HL_LT;
+		if (hl == 255)
+			return -1;
+		hl++;
+		break;
+	case NFT_CMP_GTE:
+		mode = IP6T_HL_GT;
+		if (hl == 0)
+			return -1;
+		hl--;
+		break;
+	default:
+		return -1;
+	}
+
+	/* ipt_ttl_info and ip6t_hl_info have same layout,
+	 * IPT_TTL_x and IP6T_HL_x are aliases as well, so
+	 * just use HL for both ipv4 and ipv6.
+	 */
+	switch (ctx->h->family) {
+	case NFPROTO_IPV4:
+		info = nft_create_match(ctx, ctx->cs, "ttl", false);
+		break;
+	case NFPROTO_IPV6:
+		info = nft_create_match(ctx, ctx->cs, "hl", false);
+		break;
+	default:
+		return -1;
+	}
+
+	if (!info)
+		return -1;
+
+	info->hop_limit = hl;
+	info->mode = mode;
+
+	return 0;
+}
diff --git a/iptables/nft-ruleparse.h b/iptables/nft-ruleparse.h
new file mode 100644
index 0000000000000..7fac6c7969645
--- /dev/null
+++ b/iptables/nft-ruleparse.h
@@ -0,0 +1,117 @@
+#ifndef _NFT_RULEPARSE_H_
+#define _NFT_RULEPARSE_H_
+
+#include <linux/netfilter/nf_tables.h>
+
+#include <libnftnl/expr.h>
+
+#include "xshared.h"
+
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
+		struct {
+			uint32_t key;
+		} meta_sreg;
+	};
+
+	struct {
+		uint32_t mask[4];
+		uint32_t xor[4];
+		bool set;
+	} bitwise;
+};
+
+struct nft_xt_ctx {
+	struct iptables_command_state *cs;
+	struct nftnl_expr_iter *iter;
+	struct nft_handle *h;
+	uint32_t flags;
+	const char *table;
+
+	struct nft_xt_ctx_reg regs[1 + 16];
+
+	const char *errmsg;
+};
+
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
+void *nft_create_match(struct nft_xt_ctx *ctx,
+		       struct iptables_command_state *cs,
+		       const char *name, bool reuse);
+
+bool nft_rule_to_iptables_command_state(struct nft_handle *h,
+					const struct nftnl_rule *r,
+					struct iptables_command_state *cs);
+
+#define min(x, y) ((x) < (y) ? (x) : (y))
+#define max(x, y) ((x) > (y) ? (x) : (y))
+
+int parse_meta(struct nft_xt_ctx *ctx, struct nftnl_expr *e, uint8_t key,
+	       char *iniface, unsigned char *iniface_mask, char *outiface,
+	       unsigned char *outiface_mask, uint8_t *invflags);
+
+void nft_ipv46_parse_target(struct xtables_target *t,
+			    struct iptables_command_state *cs);
+
+int nft_parse_hl(struct nft_xt_ctx *ctx, struct nftnl_expr *e,
+		 struct iptables_command_state *cs);
+
+#endif /* _NFT_RULEPARSE_H_ */
diff --git a/iptables/nft-shared.c b/iptables/nft-shared.c
index 79f6a7d3fbb85..12860fbf6d575 100644
--- a/iptables/nft-shared.c
+++ b/iptables/nft-shared.c
@@ -21,14 +21,6 @@
 
 #include <xtables.h>
 
-#include <linux/netfilter/nf_log.h>
-#include <linux/netfilter/xt_limit.h>
-#include <linux/netfilter/xt_NFLOG.h>
-#include <linux/netfilter/xt_mark.h>
-#include <linux/netfilter/xt_pkttype.h>
-
-#include <linux/netfilter_ipv6/ip6t_hl.h>
-
 #include <libmnl/libmnl.h>
 #include <libnftnl/rule.h>
 #include <libnftnl/expr.h>
@@ -276,224 +268,6 @@ bool is_same_interfaces(const char *a_iniface, const char *a_outiface,
 	return true;
 }
 
-static void parse_ifname(const char *name, unsigned int len, char *dst, unsigned char *mask)
-{
-	if (len == 0)
-		return;
-
-	memcpy(dst, name, len);
-	if (name[len - 1] == '\0') {
-		if (mask)
-			memset(mask, 0xff, strlen(name) + 1);
-		return;
-	}
-
-	if (len >= IFNAMSIZ)
-		return;
-
-	/* wildcard */
-	dst[len++] = '+';
-	if (len >= IFNAMSIZ)
-		return;
-	dst[len++] = 0;
-	if (mask)
-		memset(mask, 0xff, len - 2);
-}
-
-static void *
-nft_create_match(struct nft_xt_ctx *ctx,
-		 struct iptables_command_state *cs,
-		 const char *name, bool reuse);
-
-static uint32_t get_meta_mask(struct nft_xt_ctx *ctx, enum nft_registers sreg)
-{
-	struct nft_xt_ctx_reg *reg = nft_xt_ctx_get_sreg(ctx, sreg);
-
-	if (reg->bitwise.set)
-		return reg->bitwise.mask[0];
-
-	return ~0u;
-}
-
-static int parse_meta_mark(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
-{
-	struct xt_mark_mtinfo1 *mark;
-	uint32_t value;
-
-	mark = nft_create_match(ctx, ctx->cs, "mark", false);
-	if (!mark)
-		return -1;
-
-	if (nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP) == NFT_CMP_NEQ)
-		mark->invert = 1;
-
-	value = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_DATA);
-	mark->mark = value;
-	mark->mask = get_meta_mask(ctx, nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_SREG));
-
-	return 0;
-}
-
-static int parse_meta_pkttype(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
-{
-	struct xt_pkttype_info *pkttype;
-	uint8_t value;
-
-	pkttype = nft_create_match(ctx, ctx->cs, "pkttype", false);
-	if (!pkttype)
-		return -1;
-
-	if (nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP) == NFT_CMP_NEQ)
-		pkttype->invert = 1;
-
-	value = nftnl_expr_get_u8(e, NFTNL_EXPR_CMP_DATA);
-	pkttype->pkttype = value;
-
-	return 0;
-}
-
-static void parse_invalid_iface(char *iface, unsigned char *mask,
-				uint8_t *invflags, uint8_t invbit)
-{
-	if (*invflags & invbit || strcmp(iface, "INVAL/D"))
-		return;
-
-	/* nft's poor "! -o +" excuse */
-	*invflags |= invbit;
-	iface[0] = '+';
-	iface[1] = '\0';
-	mask[0] = 0xff;
-	mask[1] = 0xff;
-	memset(mask + 2, 0, IFNAMSIZ - 2);
-}
-
-int parse_meta(struct nft_xt_ctx *ctx, struct nftnl_expr *e, uint8_t key,
-	       char *iniface, unsigned char *iniface_mask,
-	       char *outiface, unsigned char *outiface_mask, uint8_t *invflags)
-{
-	uint32_t value;
-	const void *ifname;
-	uint32_t len;
-
-	switch(key) {
-	case NFT_META_IIF:
-		value = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_DATA);
-		if (nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP) == NFT_CMP_NEQ)
-			*invflags |= IPT_INV_VIA_IN;
-
-		if_indextoname(value, iniface);
-
-		memset(iniface_mask, 0xff, strlen(iniface)+1);
-		break;
-	case NFT_META_OIF:
-		value = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_DATA);
-		if (nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP) == NFT_CMP_NEQ)
-			*invflags |= IPT_INV_VIA_OUT;
-
-		if_indextoname(value, outiface);
-
-		memset(outiface_mask, 0xff, strlen(outiface)+1);
-		break;
-	case NFT_META_BRI_IIFNAME:
-	case NFT_META_IIFNAME:
-		ifname = nftnl_expr_get(e, NFTNL_EXPR_CMP_DATA, &len);
-		if (nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP) == NFT_CMP_NEQ)
-			*invflags |= IPT_INV_VIA_IN;
-
-		parse_ifname(ifname, len, iniface, iniface_mask);
-		parse_invalid_iface(iniface, iniface_mask,
-				    invflags, IPT_INV_VIA_IN);
-		break;
-	case NFT_META_BRI_OIFNAME:
-	case NFT_META_OIFNAME:
-		ifname = nftnl_expr_get(e, NFTNL_EXPR_CMP_DATA, &len);
-		if (nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP) == NFT_CMP_NEQ)
-			*invflags |= IPT_INV_VIA_OUT;
-
-		parse_ifname(ifname, len, outiface, outiface_mask);
-		parse_invalid_iface(outiface, outiface_mask,
-				    invflags, IPT_INV_VIA_OUT);
-		break;
-	case NFT_META_MARK:
-		parse_meta_mark(ctx, e);
-		break;
-	case NFT_META_PKTTYPE:
-		parse_meta_pkttype(ctx, e);
-		break;
-	default:
-		return -1;
-	}
-
-	return 0;
-}
-
-static void nft_parse_target(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
-{
-	uint32_t tg_len;
-	const char *targname = nftnl_expr_get_str(e, NFTNL_EXPR_TG_NAME);
-	const void *targinfo = nftnl_expr_get(e, NFTNL_EXPR_TG_INFO, &tg_len);
-	struct xtables_target *target;
-	struct xt_entry_target *t;
-	size_t size;
-
-	target = xtables_find_target(targname, XTF_TRY_LOAD);
-	if (target == NULL) {
-		ctx->errmsg = "target extension not found";
-		return;
-	}
-
-	size = XT_ALIGN(sizeof(struct xt_entry_target)) + tg_len;
-
-	t = xtables_calloc(1, size);
-	memcpy(&t->data, targinfo, tg_len);
-	t->u.target_size = size;
-	t->u.user.revision = nftnl_expr_get_u32(e, NFTNL_EXPR_TG_REV);
-	strcpy(t->u.user.name, target->name);
-
-	target->t = t;
-
-	ctx->h->ops->parse_target(target, ctx->cs);
-}
-
-static void nft_parse_match(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
-{
-	uint32_t mt_len;
-	const char *mt_name = nftnl_expr_get_str(e, NFTNL_EXPR_MT_NAME);
-	const void *mt_info = nftnl_expr_get(e, NFTNL_EXPR_MT_INFO, &mt_len);
-	struct xtables_match *match;
-	struct xtables_rule_match **matches;
-	struct xt_entry_match *m;
-
-	switch (ctx->h->family) {
-	case NFPROTO_IPV4:
-	case NFPROTO_IPV6:
-	case NFPROTO_BRIDGE:
-		matches = &ctx->cs->matches;
-		break;
-	default:
-		fprintf(stderr, "BUG: nft_parse_match() unknown family %d\n",
-			ctx->h->family);
-		exit(EXIT_FAILURE);
-	}
-
-	match = xtables_find_match(mt_name, XTF_TRY_LOAD, matches);
-	if (match == NULL) {
-		ctx->errmsg = "match extension not found";
-		return;
-	}
-
-	m = xtables_calloc(1, sizeof(struct xt_entry_match) + mt_len);
-	memcpy(&m->data, mt_info, mt_len);
-	m->u.match_size = mt_len + XT_ALIGN(sizeof(struct xt_entry_match));
-	m->u.user.revision = nftnl_expr_get_u32(e, NFTNL_EXPR_TG_REV);
-	strcpy(m->u.user.name, match->name);
-
-	match->m = m;
-
-	if (ctx->h->ops->parse_match != NULL)
-		ctx->h->ops->parse_match(match, ctx->cs);
-}
-
 void __get_cmp_data(struct nftnl_expr *e, void *data, size_t dlen, uint8_t *op)
 {
 	uint32_t len;
@@ -510,899 +284,6 @@ void get_cmp_data(struct nftnl_expr *e, void *data, size_t dlen, bool *inv)
 	*inv = (op == NFT_CMP_NEQ);
 }
 
-static bool nft_parse_meta_set_common(struct nft_xt_ctx* ctx,
-				      struct nft_xt_ctx_reg *sreg)
-{
-	if ((sreg->type != NFT_XT_REG_IMMEDIATE)) {
-		ctx->errmsg = "meta sreg is not an immediate";
-		return false;
-	}
-
-	if (sreg->immediate.data[0] == 0) {
-		ctx->errmsg = "meta sreg immediate is 0";
-		return false;
-	}
-
-	return true;
-}
-
-static void nft_parse_meta_set(struct nft_xt_ctx *ctx,
-			       struct nftnl_expr *e)
-{
-	struct xtables_target *target;
-	struct nft_xt_ctx_reg *sreg;
-	enum nft_registers sregnum;
-	struct xt_entry_target *t;
-	unsigned int size;
-	const char *targname;
-
-	sregnum = nftnl_expr_get_u32(e, NFTNL_EXPR_META_SREG);
-	sreg = nft_xt_ctx_get_sreg(ctx, sregnum);
-	if (!sreg)
-		return;
-
-	switch (nftnl_expr_get_u32(e, NFTNL_EXPR_META_KEY)) {
-	case NFT_META_NFTRACE:
-		if (!nft_parse_meta_set_common(ctx, sreg))
-			return;
-
-		targname = "TRACE";
-		break;
-	case NFT_META_BRI_BROUTE:
-		if (!nft_parse_meta_set_common(ctx, sreg))
-			return;
-
-		ctx->cs->jumpto = "DROP";
-		return;
-	default:
-		ctx->errmsg = "meta sreg key not supported";
-		return;
-	}
-
-	target = xtables_find_target(targname, XTF_TRY_LOAD);
-	if (target == NULL) {
-		ctx->errmsg = "target TRACE not found";
-		return;
-	}
-
-	size = XT_ALIGN(sizeof(struct xt_entry_target)) + target->size;
-
-	t = xtables_calloc(1, size);
-	t->u.target_size = size;
-	t->u.user.revision = target->revision;
-	strcpy(t->u.user.name, targname);
-
-	target->t = t;
-
-	ctx->h->ops->parse_target(target, ctx->cs);
-}
-
-static void nft_parse_meta(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
-{
-        struct nft_xt_ctx_reg *reg;
-
-	if (nftnl_expr_is_set(e, NFTNL_EXPR_META_SREG)) {
-		nft_parse_meta_set(ctx, e);
-		return;
-	}
-
-	reg = nft_xt_ctx_get_dreg(ctx, nftnl_expr_get_u32(e, NFTNL_EXPR_META_DREG));
-	if (!reg)
-		return;
-
-	reg->meta_dreg.key = nftnl_expr_get_u32(e, NFTNL_EXPR_META_KEY);
-	reg->type = NFT_XT_REG_META_DREG;
-}
-
-static void nft_parse_payload(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
-{
-	enum nft_registers regnum = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_DREG);
-	struct nft_xt_ctx_reg *reg = nft_xt_ctx_get_dreg(ctx, regnum);
-
-	if (!reg)
-		return;
-
-	reg->type = NFT_XT_REG_PAYLOAD;
-	reg->payload.base = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_BASE);
-	reg->payload.offset = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_OFFSET);
-	reg->payload.len = nftnl_expr_get_u32(e, NFTNL_EXPR_PAYLOAD_LEN);
-}
-
-static void nft_parse_bitwise(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
-{
-	enum nft_registers sregnum = nftnl_expr_get_u32(e, NFTNL_EXPR_BITWISE_SREG);
-	enum nft_registers dregnum = nftnl_expr_get_u32(e, NFTNL_EXPR_BITWISE_DREG);
-	struct nft_xt_ctx_reg *sreg = nft_xt_ctx_get_sreg(ctx, sregnum);
-	struct nft_xt_ctx_reg *dreg = sreg;
-	const void *data;
-	uint32_t len;
-
-	if (!sreg)
-		return;
-
-	if (sregnum != dregnum) {
-		dreg = nft_xt_ctx_get_sreg(ctx, dregnum); /* sreg, do NOT clear ... */
-		if (!dreg)
-			return;
-
-		*dreg = *sreg;  /* .. and copy content instead */
-	}
-
-	data = nftnl_expr_get(e, NFTNL_EXPR_BITWISE_XOR, &len);
-
-	if (len > sizeof(dreg->bitwise.xor)) {
-		ctx->errmsg = "bitwise xor too large";
-		return;
-	}
-
-	memcpy(dreg->bitwise.xor, data, len);
-
-	data = nftnl_expr_get(e, NFTNL_EXPR_BITWISE_MASK, &len);
-
-	if (len > sizeof(dreg->bitwise.mask)) {
-		ctx->errmsg = "bitwise mask too large";
-		return;
-	}
-
-	memcpy(dreg->bitwise.mask, data, len);
-
-	dreg->bitwise.set = true;
-}
-
-static struct xtables_match *
-nft_find_match_in_cs(struct iptables_command_state *cs, const char *name)
-{
-	struct xtables_rule_match *rm;
-	struct ebt_match *ebm;
-
-	for (ebm = cs->match_list; ebm; ebm = ebm->next) {
-		if (ebm->ismatch &&
-		    !strcmp(ebm->u.match->m->u.user.name, name))
-			return ebm->u.match;
-	}
-	for (rm = cs->matches; rm; rm = rm->next) {
-		if (!strcmp(rm->match->m->u.user.name, name))
-			return rm->match;
-	}
-	return NULL;
-}
-
-static void *
-nft_create_match(struct nft_xt_ctx *ctx,
-		 struct iptables_command_state *cs,
-		 const char *name, bool reuse)
-{
-	struct xtables_match *match;
-	struct xt_entry_match *m;
-	unsigned int size;
-
-	if (reuse) {
-		match = nft_find_match_in_cs(cs, name);
-		if (match)
-			return match->m->data;
-	}
-
-	match = xtables_find_match(name, XTF_TRY_LOAD,
-				   &cs->matches);
-	if (!match)
-		return NULL;
-
-	size = XT_ALIGN(sizeof(struct xt_entry_match)) + match->size;
-	m = xtables_calloc(1, size);
-	m->u.match_size = size;
-	m->u.user.revision = match->revision;
-
-	strcpy(m->u.user.name, match->name);
-	match->m = m;
-
-	xs_init_match(match);
-
-	if (ctx->h->ops->parse_match)
-		ctx->h->ops->parse_match(match, cs);
-
-	return match->m->data;
-}
-
-static void nft_parse_udp_range(struct nft_xt_ctx *ctx,
-			        struct iptables_command_state *cs,
-			        int sport_from, int sport_to,
-			        int dport_from, int dport_to,
-				uint8_t op)
-{
-	struct xt_udp *udp = nft_create_match(ctx, cs, "udp", true);
-
-	if (!udp) {
-		ctx->errmsg = "udp match extension not found";
-		return;
-	}
-
-	if (sport_from >= 0) {
-		switch (op) {
-		case NFT_RANGE_NEQ:
-			udp->invflags |= XT_UDP_INV_SRCPT;
-			/* fallthrough */
-		case NFT_RANGE_EQ:
-			udp->spts[0] = sport_from;
-			udp->spts[1] = sport_to;
-			break;
-		}
-	}
-
-	if (dport_to >= 0) {
-		switch (op) {
-		case NFT_CMP_NEQ:
-			udp->invflags |= XT_UDP_INV_DSTPT;
-			/* fallthrough */
-		case NFT_CMP_EQ:
-			udp->dpts[0] = dport_from;
-			udp->dpts[1] = dport_to;
-			break;
-		}
-	}
-}
-
-static void nft_parse_tcp_range(struct nft_xt_ctx *ctx,
-			        struct iptables_command_state *cs,
-			        int sport_from, int sport_to,
-			        int dport_from, int dport_to,
-				uint8_t op)
-{
-	struct xt_tcp *tcp = nft_create_match(ctx, cs, "tcp", true);
-
-	if (!tcp) {
-		ctx->errmsg = "tcp match extension not found";
-		return;
-	}
-
-	if (sport_from >= 0) {
-		switch (op) {
-		case NFT_RANGE_NEQ:
-			tcp->invflags |= XT_TCP_INV_SRCPT;
-			/* fallthrough */
-		case NFT_RANGE_EQ:
-			tcp->spts[0] = sport_from;
-			tcp->spts[1] = sport_to;
-			break;
-		}
-	}
-
-	if (dport_to >= 0) {
-		switch (op) {
-		case NFT_CMP_NEQ:
-			tcp->invflags |= XT_TCP_INV_DSTPT;
-			/* fallthrough */
-		case NFT_CMP_EQ:
-			tcp->dpts[0] = dport_from;
-			tcp->dpts[1] = dport_to;
-			break;
-		}
-	}
-}
-
-static void port_match_single_to_range(__u16 *ports, __u8 *invflags,
-				       uint8_t op, int port, __u8 invflag)
-{
-	if (port < 0)
-		return;
-
-	switch (op) {
-	case NFT_CMP_NEQ:
-		*invflags |= invflag;
-		/* fallthrough */
-	case NFT_CMP_EQ:
-		ports[0] = port;
-		ports[1] = port;
-		break;
-	case NFT_CMP_LT:
-		ports[1] = max(port - 1, 1);
-		break;
-	case NFT_CMP_LTE:
-		ports[1] = port;
-		break;
-	case NFT_CMP_GT:
-		ports[0] = min(port + 1, UINT16_MAX);
-		break;
-	case NFT_CMP_GTE:
-		ports[0] = port;
-		break;
-	}
-}
-
-static void nft_parse_udp(struct nft_xt_ctx *ctx,
-			  struct iptables_command_state *cs,
-			  int sport, int dport,
-			  uint8_t op)
-{
-	struct xt_udp *udp = nft_create_match(ctx, cs, "udp", true);
-
-	if (!udp) {
-		ctx->errmsg = "udp match extension not found";
-		return;
-	}
-
-	port_match_single_to_range(udp->spts, &udp->invflags,
-				   op, sport, XT_UDP_INV_SRCPT);
-	port_match_single_to_range(udp->dpts, &udp->invflags,
-				   op, dport, XT_UDP_INV_DSTPT);
-}
-
-static void nft_parse_tcp(struct nft_xt_ctx *ctx,
-			  struct iptables_command_state *cs,
-			  int sport, int dport,
-			  uint8_t op)
-{
-	struct xt_tcp *tcp = nft_create_match(ctx, cs, "tcp", true);
-
-	if (!tcp) {
-		ctx->errmsg = "tcp match extension not found";
-		return;
-	}
-
-	port_match_single_to_range(tcp->spts, &tcp->invflags,
-				   op, sport, XT_TCP_INV_SRCPT);
-	port_match_single_to_range(tcp->dpts, &tcp->invflags,
-				   op, dport, XT_TCP_INV_DSTPT);
-}
-
-static void nft_parse_icmp(struct nft_xt_ctx *ctx,
-			   struct iptables_command_state *cs,
-			   struct nft_xt_ctx_reg *sreg,
-			   uint8_t op, const char *data, size_t dlen)
-{
-	struct ipt_icmp icmp = {
-		.type = UINT8_MAX,
-		.code = { 0, UINT8_MAX },
-	}, *icmpp;
-
-	if (dlen < 1)
-		goto out_err_len;
-
-	switch (sreg->payload.offset) {
-	case 0:
-		icmp.type = data[0];
-		if (dlen == 1)
-			break;
-		dlen--;
-		data++;
-		/* fall through */
-	case 1:
-		if (dlen > 1)
-			goto out_err_len;
-		icmp.code[0] = icmp.code[1] = data[0];
-		break;
-	default:
-		ctx->errmsg = "unexpected payload offset";
-		return;
-	}
-
-	switch (ctx->h->family) {
-	case NFPROTO_IPV4:
-		icmpp = nft_create_match(ctx, cs, "icmp", false);
-		break;
-	case NFPROTO_IPV6:
-		if (icmp.type == UINT8_MAX) {
-			ctx->errmsg = "icmp6 code with any type match not supported";
-			return;
-		}
-		icmpp = nft_create_match(ctx, cs, "icmp6", false);
-		break;
-	default:
-		ctx->errmsg = "unexpected family for icmp match";
-		return;
-	}
-
-	if (!icmpp) {
-		ctx->errmsg = "icmp match extension not found";
-		return;
-	}
-	memcpy(icmpp, &icmp, sizeof(icmp));
-	return;
-
-out_err_len:
-	ctx->errmsg = "unexpected RHS data length";
-}
-
-static void nft_parse_th_port(struct nft_xt_ctx *ctx,
-			      struct iptables_command_state *cs,
-			      uint8_t proto,
-			      int sport, int dport, uint8_t op)
-{
-	switch (proto) {
-	case IPPROTO_UDP:
-		nft_parse_udp(ctx, cs, sport, dport, op);
-		break;
-	case IPPROTO_TCP:
-		nft_parse_tcp(ctx, cs, sport, dport, op);
-		break;
-	default:
-		ctx->errmsg = "unknown layer 4 protocol for TH match";
-	}
-}
-
-static void nft_parse_th_port_range(struct nft_xt_ctx *ctx,
-				    struct iptables_command_state *cs,
-				    uint8_t proto,
-				    int sport_from, int sport_to,
-				    int dport_from, int dport_to, uint8_t op)
-{
-	switch (proto) {
-	case IPPROTO_UDP:
-		nft_parse_udp_range(ctx, cs, sport_from, sport_to, dport_from, dport_to, op);
-		break;
-	case IPPROTO_TCP:
-		nft_parse_tcp_range(ctx, cs, sport_from, sport_to, dport_from, dport_to, op);
-		break;
-	}
-}
-
-static void nft_parse_tcp_flags(struct nft_xt_ctx *ctx,
-				struct iptables_command_state *cs,
-				uint8_t op, uint8_t flags, uint8_t mask)
-{
-	struct xt_tcp *tcp = nft_create_match(ctx, cs, "tcp", true);
-
-	if (!tcp) {
-		ctx->errmsg = "tcp match extension not found";
-		return;
-	}
-
-	if (op == NFT_CMP_NEQ)
-		tcp->invflags |= XT_TCP_INV_FLAGS;
-	tcp->flg_cmp = flags;
-	tcp->flg_mask = mask;
-}
-
-static void nft_parse_transport(struct nft_xt_ctx *ctx,
-				struct nftnl_expr *e,
-				struct iptables_command_state *cs)
-{
-	struct nft_xt_ctx_reg *sreg;
-	enum nft_registers reg;
-	uint32_t sdport;
-	uint16_t port;
-	uint8_t proto, op;
-	unsigned int len;
-
-	switch (ctx->h->family) {
-	case NFPROTO_IPV4:
-		proto = ctx->cs->fw.ip.proto;
-		break;
-	case NFPROTO_IPV6:
-		proto = ctx->cs->fw6.ipv6.proto;
-		break;
-	default:
-		ctx->errmsg = "invalid family for TH match";
-		return;
-	}
-
-	nftnl_expr_get(e, NFTNL_EXPR_CMP_DATA, &len);
-	op = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP);
-
-	reg = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_SREG);
-	sreg = nft_xt_ctx_get_sreg(ctx, reg);
-	if (!sreg)
-		return;
-
-	if (sreg->type != NFT_XT_REG_PAYLOAD) {
-		ctx->errmsg = "sgreg not payload";
-		return;
-	}
-
-	switch (proto) {
-	case IPPROTO_UDP:
-	case IPPROTO_TCP:
-		break;
-	case IPPROTO_ICMP:
-	case IPPROTO_ICMPV6:
-		nft_parse_icmp(ctx, cs, sreg, op,
-			       nftnl_expr_get(e, NFTNL_EXPR_CMP_DATA, &len),
-			       len);
-		return;
-	default:
-		ctx->errmsg = "unsupported layer 4 protocol value";
-		return;
-	}
-
-	switch(sreg->payload.offset) {
-	case 0: /* th->sport */
-		switch (len) {
-		case 2: /* load sport only */
-			port = ntohs(nftnl_expr_get_u16(e, NFTNL_EXPR_CMP_DATA));
-			nft_parse_th_port(ctx, cs, proto, port, -1, op);
-			return;
-		case 4: /* load both src and dst port */
-			sdport = ntohl(nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_DATA));
-			nft_parse_th_port(ctx, cs, proto, sdport >> 16, sdport & 0xffff, op);
-			return;
-		}
-		break;
-	case 2: /* th->dport */
-		switch (len) {
-		case 2:
-			port = ntohs(nftnl_expr_get_u16(e, NFTNL_EXPR_CMP_DATA));
-			nft_parse_th_port(ctx, cs, proto, -1, port, op);
-			return;
-		}
-		break;
-	case 13: /* th->flags */
-		if (len == 1 && proto == IPPROTO_TCP) {
-			uint8_t flags = nftnl_expr_get_u8(e, NFTNL_EXPR_CMP_DATA);
-			uint8_t mask = ~0;
-
-			if (sreg->bitwise.set)
-				memcpy(&mask, &sreg->bitwise.mask, sizeof(mask));
-
-			nft_parse_tcp_flags(ctx, cs, op, flags, mask);
-		}
-		return;
-	}
-}
-
-static void nft_parse_transport_range(struct nft_xt_ctx *ctx,
-				      const struct nft_xt_ctx_reg *sreg,
-				      struct nftnl_expr *e,
-				      struct iptables_command_state *cs)
-{
-	unsigned int len_from, len_to;
-	uint8_t proto, op;
-	uint16_t from, to;
-
-	switch (ctx->h->family) {
-	case NFPROTO_IPV4:
-		proto = ctx->cs->fw.ip.proto;
-		break;
-	case NFPROTO_IPV6:
-		proto = ctx->cs->fw6.ipv6.proto;
-		break;
-	default:
-		proto = 0;
-		break;
-	}
-
-	nftnl_expr_get(e, NFTNL_EXPR_RANGE_FROM_DATA, &len_from);
-	nftnl_expr_get(e, NFTNL_EXPR_RANGE_FROM_DATA, &len_to);
-	if (len_to != len_from || len_to != 2)
-		return;
-
-	op = nftnl_expr_get_u32(e, NFTNL_EXPR_RANGE_OP);
-
-	from = ntohs(nftnl_expr_get_u16(e, NFTNL_EXPR_RANGE_FROM_DATA));
-	to = ntohs(nftnl_expr_get_u16(e, NFTNL_EXPR_RANGE_TO_DATA));
-
-	switch (sreg->payload.offset) {
-	case 0:
-		nft_parse_th_port_range(ctx, cs, proto, from, to, -1, -1, op);
-		return;
-	case 2:
-		to = ntohs(nftnl_expr_get_u16(e, NFTNL_EXPR_RANGE_TO_DATA));
-		nft_parse_th_port_range(ctx, cs, proto, -1, -1, from, to, op);
-		return;
-	}
-}
-
-static void nft_parse_cmp(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
-{
-	struct nft_xt_ctx_reg *sreg;
-	uint32_t reg;
-
-	reg = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_SREG);
-
-	sreg = nft_xt_ctx_get_sreg(ctx, reg);
-	if (!sreg)
-		return;
-
-	switch (sreg->type) {
-	case NFT_XT_REG_UNDEF:
-		ctx->errmsg = "cmp sreg undef";
-		break;
-	case NFT_XT_REG_META_DREG:
-		ctx->h->ops->parse_meta(ctx, sreg, e, ctx->cs);
-		break;
-	case NFT_XT_REG_PAYLOAD:
-		switch (sreg->payload.base) {
-		case NFT_PAYLOAD_LL_HEADER:
-			if (ctx->h->family == NFPROTO_BRIDGE)
-				ctx->h->ops->parse_payload(ctx, sreg, e, ctx->cs);
-			break;
-		case NFT_PAYLOAD_NETWORK_HEADER:
-			ctx->h->ops->parse_payload(ctx, sreg, e, ctx->cs);
-			break;
-		case NFT_PAYLOAD_TRANSPORT_HEADER:
-			nft_parse_transport(ctx, e, ctx->cs);
-			break;
-		}
-
-		break;
-	default:
-		ctx->errmsg = "cmp sreg has unknown type";
-		break;
-	}
-}
-
-static void nft_parse_counter(struct nftnl_expr *e, struct xt_counters *counters)
-{
-	counters->pcnt = nftnl_expr_get_u64(e, NFTNL_EXPR_CTR_PACKETS);
-	counters->bcnt = nftnl_expr_get_u64(e, NFTNL_EXPR_CTR_BYTES);
-}
-
-static void nft_parse_immediate(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
-{
-	const char *chain = nftnl_expr_get_str(e, NFTNL_EXPR_IMM_CHAIN);
-	struct iptables_command_state *cs = ctx->cs;
-	struct xt_entry_target *t;
-	uint32_t size;
-	int verdict;
-
-	if (nftnl_expr_is_set(e, NFTNL_EXPR_IMM_DATA)) {
-		struct nft_xt_ctx_reg *dreg;
-		const void *imm_data;
-		uint32_t len;
-
-		imm_data = nftnl_expr_get(e, NFTNL_EXPR_IMM_DATA, &len);
-		dreg = nft_xt_ctx_get_dreg(ctx, nftnl_expr_get_u32(e, NFTNL_EXPR_IMM_DREG));
-		if (!dreg)
-			return;
-
-		if (len > sizeof(dreg->immediate.data)) {
-			ctx->errmsg = "oversized immediate data";
-			return;
-		}
-
-		memcpy(dreg->immediate.data, imm_data, len);
-		dreg->immediate.len = len;
-		dreg->type = NFT_XT_REG_IMMEDIATE;
-
-		return;
-	}
-
-	verdict = nftnl_expr_get_u32(e, NFTNL_EXPR_IMM_VERDICT);
-	/* Standard target? */
-	switch(verdict) {
-	case NF_ACCEPT:
-		if (cs->jumpto && strcmp(ctx->table, "broute") == 0)
-			break;
-		cs->jumpto = "ACCEPT";
-		break;
-	case NF_DROP:
-		cs->jumpto = "DROP";
-		break;
-	case NFT_RETURN:
-		cs->jumpto = "RETURN";
-		break;;
-	case NFT_GOTO:
-		if (ctx->h->ops->set_goto_flag)
-			ctx->h->ops->set_goto_flag(cs);
-		/* fall through */
-	case NFT_JUMP:
-		cs->jumpto = chain;
-		/* fall through */
-	default:
-		return;
-	}
-
-	cs->target = xtables_find_target(cs->jumpto, XTF_TRY_LOAD);
-	if (!cs->target) {
-		ctx->errmsg = "verdict extension not found";
-		return;
-	}
-
-	size = XT_ALIGN(sizeof(struct xt_entry_target)) + cs->target->size;
-	t = xtables_calloc(1, size);
-	t->u.target_size = size;
-	t->u.user.revision = cs->target->revision;
-	strcpy(t->u.user.name, cs->jumpto);
-	cs->target->t = t;
-}
-
-static void nft_parse_limit(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
-{
-	__u32 burst = nftnl_expr_get_u32(e, NFTNL_EXPR_LIMIT_BURST);
-	__u64 unit = nftnl_expr_get_u64(e, NFTNL_EXPR_LIMIT_UNIT);
-	__u64 rate = nftnl_expr_get_u64(e, NFTNL_EXPR_LIMIT_RATE);
-	struct xt_rateinfo *rinfo;
-
-	switch (ctx->h->family) {
-	case NFPROTO_IPV4:
-	case NFPROTO_IPV6:
-	case NFPROTO_BRIDGE:
-		break;
-	default:
-		fprintf(stderr, "BUG: nft_parse_limit() unknown family %d\n",
-			ctx->h->family);
-		exit(EXIT_FAILURE);
-	}
-
-	rinfo = nft_create_match(ctx, ctx->cs, "limit", false);
-	if (!rinfo) {
-		ctx->errmsg = "limit match extension not found";
-		return;
-	}
-
-	rinfo->avg = XT_LIMIT_SCALE * unit / rate;
-	rinfo->burst = burst;
-}
-
-static void nft_parse_log(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
-{
-	struct xtables_target *target;
-	struct xt_entry_target *t;
-	size_t target_size;
-	/*
-	 * In order to handle the longer log-prefix supported by nft, instead of
-	 * using struct xt_nflog_info, we use a struct with a compatible layout, but
-	 * a larger buffer for the prefix.
-	 */
-	struct xt_nflog_info_nft {
-		__u32 len;
-		__u16 group;
-		__u16 threshold;
-		__u16 flags;
-		__u16 pad;
-		char  prefix[NF_LOG_PREFIXLEN];
-	} info = {
-		.group     = nftnl_expr_get_u16(e, NFTNL_EXPR_LOG_GROUP),
-		.threshold = nftnl_expr_get_u16(e, NFTNL_EXPR_LOG_QTHRESHOLD),
-	};
-	if (nftnl_expr_is_set(e, NFTNL_EXPR_LOG_SNAPLEN)) {
-		info.len = nftnl_expr_get_u32(e, NFTNL_EXPR_LOG_SNAPLEN);
-		info.flags = XT_NFLOG_F_COPY_LEN;
-	}
-	if (nftnl_expr_is_set(e, NFTNL_EXPR_LOG_PREFIX))
-		snprintf(info.prefix, sizeof(info.prefix), "%s",
-			 nftnl_expr_get_str(e, NFTNL_EXPR_LOG_PREFIX));
-
-	target = xtables_find_target("NFLOG", XTF_TRY_LOAD);
-	if (target == NULL) {
-		ctx->errmsg = "NFLOG target extension not found";
-		return;
-	}
-
-	target_size = XT_ALIGN(sizeof(struct xt_entry_target)) +
-		      XT_ALIGN(sizeof(struct xt_nflog_info_nft));
-
-	t = xtables_calloc(1, target_size);
-	t->u.target_size = target_size;
-	strcpy(t->u.user.name, target->name);
-	t->u.user.revision = target->revision;
-
-	target->t = t;
-
-	memcpy(&target->t->data, &info, sizeof(info));
-
-	ctx->h->ops->parse_target(target, ctx->cs);
-}
-
-static void nft_parse_lookup(struct nft_xt_ctx *ctx, struct nft_handle *h,
-			     struct nftnl_expr *e)
-{
-	if (ctx->h->ops->parse_lookup)
-		ctx->h->ops->parse_lookup(ctx, e);
-}
-
-static void nft_parse_range(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
-{
-	struct nft_xt_ctx_reg *sreg;
-	uint32_t reg;
-
-	reg = nftnl_expr_get_u32(e, NFTNL_EXPR_RANGE_SREG);
-	sreg = nft_xt_ctx_get_sreg(ctx, reg);
-
-	switch (sreg->type) {
-	case NFT_XT_REG_UNDEF:
-		ctx->errmsg = "range sreg undef";
-		break;
-	case NFT_XT_REG_PAYLOAD:
-		switch (sreg->payload.base) {
-		case NFT_PAYLOAD_TRANSPORT_HEADER:
-			nft_parse_transport_range(ctx, sreg, e, ctx->cs);
-			break;
-		default:
-			ctx->errmsg = "range with unknown payload base";
-			break;
-		}
-		break;
-	default:
-		ctx->errmsg = "range sreg type unsupported";
-		break;
-	}
-}
-
-bool nft_rule_to_iptables_command_state(struct nft_handle *h,
-					const struct nftnl_rule *r,
-					struct iptables_command_state *cs)
-{
-	struct nftnl_expr_iter *iter;
-	struct nftnl_expr *expr;
-	struct nft_xt_ctx ctx = {
-		.cs = cs,
-		.h = h,
-		.table = nftnl_rule_get_str(r, NFTNL_RULE_TABLE),
-	};
-	bool ret = true;
-
-	iter = nftnl_expr_iter_create(r);
-	if (iter == NULL)
-		return false;
-
-	ctx.iter = iter;
-	expr = nftnl_expr_iter_next(iter);
-	while (expr != NULL) {
-		const char *name =
-			nftnl_expr_get_str(expr, NFTNL_EXPR_NAME);
-
-		if (strcmp(name, "counter") == 0)
-			nft_parse_counter(expr, &ctx.cs->counters);
-		else if (strcmp(name, "payload") == 0)
-			nft_parse_payload(&ctx, expr);
-		else if (strcmp(name, "meta") == 0)
-			nft_parse_meta(&ctx, expr);
-		else if (strcmp(name, "bitwise") == 0)
-			nft_parse_bitwise(&ctx, expr);
-		else if (strcmp(name, "cmp") == 0)
-			nft_parse_cmp(&ctx, expr);
-		else if (strcmp(name, "immediate") == 0)
-			nft_parse_immediate(&ctx, expr);
-		else if (strcmp(name, "match") == 0)
-			nft_parse_match(&ctx, expr);
-		else if (strcmp(name, "target") == 0)
-			nft_parse_target(&ctx, expr);
-		else if (strcmp(name, "limit") == 0)
-			nft_parse_limit(&ctx, expr);
-		else if (strcmp(name, "lookup") == 0)
-			nft_parse_lookup(&ctx, h, expr);
-		else if (strcmp(name, "log") == 0)
-			nft_parse_log(&ctx, expr);
-		else if (strcmp(name, "range") == 0)
-			nft_parse_range(&ctx, expr);
-
-		if (ctx.errmsg) {
-			fprintf(stderr, "Error: %s\n", ctx.errmsg);
-			ctx.errmsg = NULL;
-			ret = false;
-		}
-
-		expr = nftnl_expr_iter_next(iter);
-	}
-
-	nftnl_expr_iter_destroy(iter);
-
-	if (nftnl_rule_is_set(r, NFTNL_RULE_USERDATA)) {
-		const void *data;
-		uint32_t len, size;
-		const char *comment;
-
-		data = nftnl_rule_get_data(r, NFTNL_RULE_USERDATA, &len);
-		comment = get_comment(data, len);
-		if (comment) {
-			struct xtables_match *match;
-			struct xt_entry_match *m;
-
-			match = xtables_find_match("comment", XTF_TRY_LOAD,
-						   &cs->matches);
-			if (match == NULL)
-				return false;
-
-			size = XT_ALIGN(sizeof(struct xt_entry_match))
-				+ match->size;
-			m = xtables_calloc(1, size);
-
-			strncpy((char *)m->data, comment, match->size - 1);
-			m->u.match_size = size;
-			m->u.user.revision = 0;
-			strcpy(m->u.user.name, match->name);
-
-			match->m = m;
-		}
-	}
-
-	if (!cs->jumpto)
-		cs->jumpto = "";
-
-	if (!ret)
-		xtables_error(VERSION_PROBLEM, "Parsing nftables rule failed");
-	return ret;
-}
-
 void nft_ipv46_save_chain(const struct nftnl_chain *c, const char *policy)
 {
 	const char *chain = nftnl_chain_get_str(c, NFTNL_CHAIN_NAME);
@@ -1546,13 +427,6 @@ bool compare_targets(struct xtables_target *tg1, struct xtables_target *tg2)
 	return true;
 }
 
-void nft_ipv46_parse_target(struct xtables_target *t,
-			    struct iptables_command_state *cs)
-{
-	cs->target = t;
-	cs->jumpto = t->name;
-}
-
 void nft_check_xt_legacy(int family, bool is_ipt_save)
 {
 	static const char tables6[] = "/proc/net/ip6_tables_names";
@@ -1587,70 +461,6 @@ void nft_check_xt_legacy(int family, bool is_ipt_save)
 	fclose(fp);
 }
 
-int nft_parse_hl(struct nft_xt_ctx *ctx,
-		 struct nftnl_expr *e,
-		 struct iptables_command_state *cs)
-{
-	struct ip6t_hl_info *info;
-	uint8_t hl, mode;
-	int op;
-
-	hl = nftnl_expr_get_u8(e, NFTNL_EXPR_CMP_DATA);
-	op = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP);
-
-	switch (op) {
-	case NFT_CMP_NEQ:
-		mode = IP6T_HL_NE;
-		break;
-	case NFT_CMP_EQ:
-		mode = IP6T_HL_EQ;
-		break;
-	case NFT_CMP_LT:
-		mode = IP6T_HL_LT;
-		break;
-	case NFT_CMP_GT:
-		mode = IP6T_HL_GT;
-		break;
-	case NFT_CMP_LTE:
-		mode = IP6T_HL_LT;
-		if (hl == 255)
-			return -1;
-		hl++;
-		break;
-	case NFT_CMP_GTE:
-		mode = IP6T_HL_GT;
-		if (hl == 0)
-			return -1;
-		hl--;
-		break;
-	default:
-		return -1;
-	}
-
-	/* ipt_ttl_info and ip6t_hl_info have same layout,
-	 * IPT_TTL_x and IP6T_HL_x are aliases as well, so
-	 * just use HL for both ipv4 and ipv6.
-	 */
-	switch (ctx->h->family) {
-	case NFPROTO_IPV4:
-		info = nft_create_match(ctx, ctx->cs, "ttl", false);
-		break;
-	case NFPROTO_IPV6:
-		info = nft_create_match(ctx, ctx->cs, "hl", false);
-		break;
-	default:
-		return -1;
-	}
-
-	if (!info)
-		return -1;
-
-	info->hop_limit = hl;
-	info->mode = mode;
-
-	return 0;
-}
-
 enum nft_registers nft_get_next_reg(enum nft_registers reg, size_t size)
 {
 	/* convert size to NETLINK_ALIGN-sized chunks */
diff --git a/iptables/nft-shared.h b/iptables/nft-shared.h
index 2c4c0d90cd077..2edee64920e8b 100644
--- a/iptables/nft-shared.h
+++ b/iptables/nft-shared.h
@@ -11,6 +11,7 @@
 #include <linux/netfilter/nf_tables.h>
 
 #include "xshared.h"
+#include "nft-ruleparse.h"
 
 #ifdef DEBUG
 #define DEBUG_DEL
@@ -38,92 +39,6 @@ struct xtables_args;
 struct nft_handle;
 struct xt_xlate;
 
-enum nft_ctx_reg_type {
-	NFT_XT_REG_UNDEF,
-	NFT_XT_REG_PAYLOAD,
-	NFT_XT_REG_IMMEDIATE,
-	NFT_XT_REG_META_DREG,
-};
-
-struct nft_xt_ctx_reg {
-	enum nft_ctx_reg_type type:8;
-
-	union {
-		struct {
-			uint32_t base;
-			uint32_t offset;
-			uint32_t len;
-		} payload;
-		struct {
-			uint32_t data[4];
-			uint8_t len;
-		} immediate;
-		struct {
-			uint32_t key;
-		} meta_dreg;
-		struct {
-			uint32_t key;
-		} meta_sreg;
-	};
-
-	struct {
-		uint32_t mask[4];
-		uint32_t xor[4];
-		bool set;
-	} bitwise;
-};
-
-struct nft_xt_ctx {
-	struct iptables_command_state *cs;
-	struct nftnl_expr_iter *iter;
-	struct nft_handle *h;
-	uint32_t flags;
-	const char *table;
-
-	struct nft_xt_ctx_reg regs[1 + 16];
-
-	const char *errmsg;
-};
-
-static inline struct nft_xt_ctx_reg *nft_xt_ctx_get_sreg(struct nft_xt_ctx *ctx, enum nft_registers reg)
-{
-	switch (reg) {
-	case NFT_REG_VERDICT:
-		return &ctx->regs[0];
-	case NFT_REG_1:
-		return &ctx->regs[1];
-	case NFT_REG_2:
-		return &ctx->regs[5];
-	case NFT_REG_3:
-		return &ctx->regs[9];
-	case NFT_REG_4:
-		return &ctx->regs[13];
-	case NFT_REG32_00...NFT_REG32_15:
-		return &ctx->regs[reg - NFT_REG32_00];
-	default:
-		ctx->errmsg = "Unknown register requested";
-		break;
-	}
-
-	return NULL;
-}
-
-static inline void nft_xt_reg_clear(struct nft_xt_ctx_reg *r)
-{
-	r->type = 0;
-	r->bitwise.set = false;
-}
-
-static inline struct nft_xt_ctx_reg *nft_xt_ctx_get_dreg(struct nft_xt_ctx *ctx, enum nft_registers reg)
-{
-	struct nft_xt_ctx_reg *r = nft_xt_ctx_get_sreg(ctx, reg);
-
-	if (r)
-		nft_xt_reg_clear(r);
-
-	return r;
-}
-
 struct nft_family_ops {
 	int (*add)(struct nft_handle *h, struct nftnl_rule *r,
 		   struct iptables_command_state *cs);
@@ -207,14 +122,8 @@ bool is_same_interfaces(const char *a_iniface, const char *a_outiface,
 			unsigned const char *b_iniface_mask,
 			unsigned const char *b_outiface_mask);
 
-int parse_meta(struct nft_xt_ctx *ctx, struct nftnl_expr *e, uint8_t key,
-	       char *iniface, unsigned char *iniface_mask, char *outiface,
-	       unsigned char *outiface_mask, uint8_t *invflags);
 void __get_cmp_data(struct nftnl_expr *e, void *data, size_t dlen, uint8_t *op);
 void get_cmp_data(struct nftnl_expr *e, void *data, size_t dlen, bool *inv);
-bool nft_rule_to_iptables_command_state(struct nft_handle *h,
-					const struct nftnl_rule *r,
-					struct iptables_command_state *cs);
 void print_matches_and_target(struct iptables_command_state *cs,
 			      unsigned int format);
 void nft_ipv46_save_chain(const struct nftnl_chain *c, const char *policy);
@@ -224,9 +133,6 @@ void save_matches_and_target(const struct iptables_command_state *cs,
 
 struct nft_family_ops *nft_family_ops_lookup(int family);
 
-void nft_ipv46_parse_target(struct xtables_target *t,
-			    struct iptables_command_state *cs);
-
 bool compare_matches(struct xtables_rule_match *mt1, struct xtables_rule_match *mt2);
 bool compare_targets(struct xtables_target *tg1, struct xtables_target *tg2);
 
@@ -263,11 +169,6 @@ void xtables_restore_parse(struct nft_handle *h,
 
 void nft_check_xt_legacy(int family, bool is_ipt_save);
 
-int nft_parse_hl(struct nft_xt_ctx *ctx, struct nftnl_expr *e, struct iptables_command_state *cs);
-
-#define min(x, y) ((x) < (y) ? (x) : (y))
-#define max(x, y) ((x) > (y) ? (x) : (y))
-
 /* simplified nftables:include/netlink.h, netlink_padded_len() */
 #define NETLINK_ALIGN		4
 
-- 
2.40.0

