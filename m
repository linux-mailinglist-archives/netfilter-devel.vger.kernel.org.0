Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7D65F5CCB
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Oct 2022 00:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJEWht (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Oct 2022 18:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJEWhs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:37:48 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74EB163F31
        for <netfilter-devel@vger.kernel.org>; Wed,  5 Oct 2022 15:37:46 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v2 3/6] netfilter: nft_inner: support for inner tunnel header matching
Date:   Thu,  6 Oct 2022 00:37:37 +0200
Message-Id: <20221005223740.22991-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221005223740.22991-1-pablo@netfilter.org>
References: <20221005223740.22991-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This new expression allows you to match on the inner headers that are
encapsulated by any of the existing tunneling protocols.

This expression parses the inner packet to set the link, network and
transport offsets, so the existing expressions (with a few updates) can
be reused to match on the inner headers.

The inner expression supports for different tunnel combinations such as:

- ethernet frame over IPv4/IPv6 packet, eg. VxLAN.
- IPv4/IPv6 packet over IPv4/IPv6 packet, eg. IPIP.
- IPv4/IPv6 packet over IPv4/IPv6 + transport header, eg. GRE.
- transport header (ESP or SCTP) over transport header (usually UDP)

The following fields are used to describe the tunnel protocol:

- flags, which describe how to parse the inner headers:

  NFT_PAYLOAD_CTX_INNER_TUN, the tunnel provides its own header.
  NFT_PAYLOAD_CTX_INNER_ETHER, the ethernet frame is available as inner header.
  NFT_PAYLOAD_CTX_INNER_NH, the network header is available as inner header.
  NFT_PAYLOAD_CTX_INNER_TH, the transport header is available as inner header.

For example, VxLAN sets on all of these flags. While GRE only sets on
NFT_PAYLOAD_CTX_INNER_NH and NFT_PAYLOAD_CTX_INNER_TH. Then, ESP over
UDP only sets on NFT_PAYLOAD_CTX_INNER_TH.

The tunnel description is composed of the following attributes:

- header size: in case the tunnel comes with its own header, eg. VxLAN.

- type: this provides a hint to userspace on how to delinearize the rule.
  This is useful for VxLAN and Geneve since they run over UDP, since
  transport does not provide a hint. This is also useful in case hardware
  offload is ever supported. The type is not currently interpreted by the
  kernel.

- expression: currently only payload supported. Follow up patch adds
  also inner meta support which is required by autogenerated
  dependencies. The exthdr expression should be supported too
  at some point. There is a new inner_ops operation that needs to be
  set on to allow to use an existing expression from the inner expression.

This patch adds a new NFT_PAYLOAD_TUN_HEADER base which allows to match
on the tunnel header fields, eg. vxlan vni.

The payload expression is embedded into nft_inner private area and this
private data area is passed to the payload inner eval function via
direct call.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h        |   5 +
 include/net/netfilter/nf_tables_core.h   |  24 ++
 include/uapi/linux/netfilter/nf_tables.h |  26 ++
 net/netfilter/Makefile                   |   3 +-
 net/netfilter/nf_tables_api.c            |  37 +++
 net/netfilter/nf_tables_core.c           |   1 +
 net/netfilter/nft_inner.c                | 322 +++++++++++++++++++++++
 net/netfilter/nft_payload.c              |  89 ++++++-
 8 files changed, 505 insertions(+), 2 deletions(-)
 create mode 100644 net/netfilter/nft_inner.c

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index cdb7db9b0e25..c5827f8a0010 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -375,6 +375,10 @@ static inline void *nft_expr_priv(const struct nft_expr *expr)
 	return (void *)expr->data;
 }
 
+struct nft_expr_info;
+
+int nft_expr_inner_parse(const struct nft_ctx *ctx, const struct nlattr *nla,
+			 struct nft_expr_info *info);
 int nft_expr_clone(struct nft_expr *dst, struct nft_expr *src);
 void nft_expr_destroy(const struct nft_ctx *ctx, struct nft_expr *expr);
 int nft_expr_dump(struct sk_buff *skb, unsigned int attr,
@@ -864,6 +868,7 @@ struct nft_expr_type {
 						       const struct nlattr * const tb[]);
 	void				(*release_ops)(const struct nft_expr_ops *ops);
 	const struct nft_expr_ops	*ops;
+	const struct nft_expr_ops	*inner_ops;
 	struct list_head		list;
 	const char			*name;
 	struct module			*owner;
diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
index 990c3767a350..d80ec9a371a9 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -18,6 +18,7 @@ extern struct nft_expr_type nft_meta_type;
 extern struct nft_expr_type nft_rt_type;
 extern struct nft_expr_type nft_exthdr_type;
 extern struct nft_expr_type nft_last_type;
+extern struct nft_expr_type nft_inner_type;
 
 #ifdef CONFIG_NETWORK_SECMARK
 extern struct nft_object_type nft_secmark_obj_type;
@@ -138,4 +139,27 @@ void nft_rt_get_eval(const struct nft_expr *expr,
 		     struct nft_regs *regs, const struct nft_pktinfo *pkt);
 void nft_counter_eval(const struct nft_expr *expr, struct nft_regs *regs,
                       const struct nft_pktinfo *pkt);
+
+enum {
+	NFT_PAYLOAD_CTX_INNER_TUN	= (1 << 0),
+	NFT_PAYLOAD_CTX_INNER_LL	= (1 << 1),
+	NFT_PAYLOAD_CTX_INNER_NH	= (1 << 2),
+	NFT_PAYLOAD_CTX_INNER_TH	= (1 << 3),
+};
+
+struct nft_inner_tun_ctx {
+	u8	inner_tunoff;
+	u8	inner_lloff;
+	u8	inner_nhoff;
+	u8	inner_thoff;
+	__be16	llproto;
+	u8	l4proto;
+	u8      flags;
+};
+
+int nft_payload_inner_offset(const struct nft_pktinfo *pkt);
+void nft_payload_inner_eval(const struct nft_expr *expr, struct nft_regs *regs,
+			    const struct nft_pktinfo *pkt,
+			    struct nft_inner_tun_ctx *ctx);
+
 #endif /* _NET_NF_TABLES_CORE_H */
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 466fd3f4447c..4608646f2103 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -760,6 +760,7 @@ enum nft_payload_bases {
 	NFT_PAYLOAD_NETWORK_HEADER,
 	NFT_PAYLOAD_TRANSPORT_HEADER,
 	NFT_PAYLOAD_INNER_HEADER,
+	NFT_PAYLOAD_TUN_HEADER,
 };
 
 /**
@@ -779,6 +780,31 @@ enum nft_payload_csum_flags {
 	NFT_PAYLOAD_L4CSUM_PSEUDOHDR = (1 << 0),
 };
 
+enum nft_inner_type {
+	NFT_INNER_UNSPEC	= 0,
+	NFT_INNER_VXLAN,
+};
+
+enum nft_inner_flags {
+	NFT_INNER_HDRSIZE	= (1 << 0),
+	NFT_INNER_LL		= (1 << 1),
+	NFT_INNER_NH		= (1 << 2),
+	NFT_INNER_TH		= (1 << 3),
+};
+#define NFT_INNER_MASK		(NFT_INNER_HDRSIZE | NFT_INNER_LL | \
+				 NFT_INNER_NH |  NFT_INNER_TH)
+
+enum nft_inner_attributes {
+	NFTA_INNER_UNSPEC,
+	NFTA_INNER_NUM,
+	NFTA_INNER_TYPE,
+	NFTA_INNER_FLAGS,
+	NFTA_INNER_HDRSIZE,
+	NFTA_INNER_EXPR,
+	__NFTA_INNER_MAX
+};
+#define NFTA_INNER_MAX	(__NFTA_INNER_MAX - 1)
+
 /**
  * enum nft_payload_attributes - nf_tables payload expression netlink attributes
  *
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index 06df49ea6329..5252f6ffc7ce 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -80,7 +80,8 @@ nf_tables-objs := nf_tables_core.o nf_tables_api.o nft_chain_filter.o \
 		  nf_tables_trace.o nft_immediate.o nft_cmp.o nft_range.o \
 		  nft_bitwise.o nft_byteorder.o nft_payload.o nft_lookup.o \
 		  nft_dynset.o nft_meta.o nft_rt.o nft_exthdr.o nft_last.o \
-		  nft_counter.o nft_chain_route.o nf_tables_offload.o \
+		  nft_counter.o nft_inner.o nft_chain_route.o \
+		  nf_tables_offload.o \
 		  nft_set_hash.o nft_set_bitmap.o nft_set_rbtree.o \
 		  nft_set_pipapo.o
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 63c70141b3e5..486994d2118e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2857,6 +2857,43 @@ static int nf_tables_expr_parse(const struct nft_ctx *ctx,
 	return err;
 }
 
+int nft_expr_inner_parse(const struct nft_ctx *ctx, const struct nlattr *nla,
+			 struct nft_expr_info *info)
+{
+	struct nlattr *tb[NFTA_EXPR_MAX + 1];
+	const struct nft_expr_type *type;
+	int err;
+
+	err = nla_parse_nested_deprecated(tb, NFTA_EXPR_MAX, nla,
+					  nft_expr_policy, NULL);
+	if (err < 0)
+		return err;
+
+	if (!tb[NFTA_EXPR_DATA])
+		return -EINVAL;
+
+	type = __nft_expr_type_get(ctx->family, tb[NFTA_EXPR_NAME]);
+	if (IS_ERR(type))
+		return PTR_ERR(type);
+
+	if (!type->inner_ops)
+		return -EOPNOTSUPP;
+
+	err = nla_parse_nested_deprecated(info->tb, type->maxattr,
+					  tb[NFTA_EXPR_DATA],
+					  type->policy, NULL);
+	if (err < 0)
+		goto err_nla_parse;
+
+	info->attr = nla;
+	info->ops = type->inner_ops;
+
+	return 0;
+
+err_nla_parse:
+	return err;
+}
+
 static int nf_tables_newexpr(const struct nft_ctx *ctx,
 			     const struct nft_expr_info *expr_info,
 			     struct nft_expr *expr)
diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index cee3e4e905ec..75580517f385 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -340,6 +340,7 @@ static struct nft_expr_type *nft_basic_types[] = {
 	&nft_exthdr_type,
 	&nft_last_type,
 	&nft_counter_type,
+	&nft_inner_type,
 };
 
 static struct nft_object_type *nft_basic_objects[] = {
diff --git a/net/netfilter/nft_inner.c b/net/netfilter/nft_inner.c
new file mode 100644
index 000000000000..53a9c07299e0
--- /dev/null
+++ b/net/netfilter/nft_inner.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Pablo Neira Ayuso <pablo@netfilter.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/if_vlan.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/netlink.h>
+#include <linux/netfilter.h>
+#include <linux/netfilter/nf_tables.h>
+#include <net/netfilter/nf_tables_core.h>
+#include <net/netfilter/nf_tables.h>
+#include <net/netfilter/nf_tables_offload.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <net/gre.h>
+#include <net/ip.h>
+#include <linux/icmpv6.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+
+struct __nft_expr {
+	const struct nft_expr_ops	*ops;
+	union {
+		struct nft_payload	payload;
+	} __attribute__((aligned(__alignof__(u64))));
+};
+
+enum {
+	NFT_INNER_EXPR_PAYLOAD,
+};
+
+struct nft_inner {
+	u8			flags;
+	u8			hdrsize;
+	u8			type;
+	u8			expr_type;
+
+	struct __nft_expr	expr;
+};
+
+static int nft_inner_parse_l2l3(const struct nft_inner *priv,
+				const struct nft_pktinfo *pkt,
+				struct nft_inner_tun_ctx *ctx, u32 off)
+{
+	u32 nhoff, thoff;
+
+	if (priv->flags & NFT_INNER_LL) {
+		struct vlan_ethhdr *veth, _veth;
+		struct ethhdr *eth, _eth;
+		u32 hdrsize;
+
+		eth = skb_header_pointer(pkt->skb, off, sizeof(_eth), &_eth);
+		if (!eth)
+			return -1;
+
+		switch (eth->h_proto) {
+		case htons(ETH_P_IP):
+		case htons(ETH_P_IPV6):
+			ctx->llproto = eth->h_proto;
+			hdrsize = sizeof(_eth);
+			break;
+		case htons(ETH_P_8021Q):
+			veth = skb_header_pointer(pkt->skb, off, sizeof(_veth), &_veth);
+			if (!eth)
+				return -1;
+
+			ctx->llproto = veth->h_vlan_encapsulated_proto;
+			hdrsize = sizeof(_veth);
+			break;
+		default:
+			return -1;
+		}
+
+		ctx->inner_lloff = off - pkt->inneroff;
+		ctx->flags |= NFT_PAYLOAD_CTX_INNER_LL;
+		off += hdrsize;
+	} else {
+		struct iphdr *iph;
+		u32 _version;
+
+		iph = skb_header_pointer(pkt->skb, off, sizeof(_version), &_version);
+		if (!iph)
+			return -1;
+
+		switch (iph->version) {
+		case 4:
+			ctx->llproto = htons(ETH_P_IP);
+			break;
+		case 6:
+			ctx->llproto = htons(ETH_P_IPV6);
+			break;
+		default:
+			return -1;
+		}
+	}
+
+	nhoff = off;
+
+	switch (ctx->llproto) {
+	case htons(ETH_P_IP): {
+		struct iphdr *iph, _iph;
+
+		iph = skb_header_pointer(pkt->skb, nhoff, sizeof(_iph), &_iph);
+		if (!iph)
+			return -1;
+
+		if (iph->ihl < 5 || iph->version != 4)
+			return -1;
+
+		ctx->inner_nhoff = nhoff - pkt->inneroff;
+		ctx->flags |= NFT_PAYLOAD_CTX_INNER_NH;
+
+		thoff = nhoff + (iph->ihl * 4);
+		if ((ntohs(iph->frag_off) & IP_OFFSET) == 0) {
+			ctx->flags |= NFT_PAYLOAD_CTX_INNER_TH;
+			ctx->inner_thoff = thoff - pkt->inneroff;
+			ctx->l4proto = iph->protocol;
+		}
+		}
+		break;
+	case htons(ETH_P_IPV6): {
+		struct ipv6hdr *ip6h, _ip6h;
+		int fh_flags = IP6_FH_F_AUTH;
+		unsigned short frag_off;
+		int l4proto;
+
+		ip6h = skb_header_pointer(pkt->skb, nhoff, sizeof(_ip6h), &_ip6h);
+		if (!ip6h)
+			return -1;
+
+		if (ip6h->version != 6)
+			return -1;
+
+		ctx->inner_nhoff = nhoff - pkt->inneroff;
+		ctx->flags |= NFT_PAYLOAD_CTX_INNER_NH;
+
+		thoff = nhoff;
+		l4proto = ipv6_find_hdr(pkt->skb, &thoff, -1, &frag_off, &fh_flags);
+		if (l4proto < 0)
+			return -1;
+
+		if (frag_off == 0) {
+			thoff = nhoff + sizeof(_ip6h);
+			ctx->flags |= NFT_PAYLOAD_CTX_INNER_TH;
+			ctx->inner_thoff = thoff - pkt->inneroff;
+			ctx->l4proto = l4proto;
+		}
+		}
+		break;
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
+static int nft_inner_parse_tunhdr(const struct nft_inner *priv,
+				  const struct nft_pktinfo *pkt,
+				  struct nft_inner_tun_ctx *ctx, u32 *off)
+{
+	ctx->inner_tunoff = *off - pkt->inneroff;
+	ctx->flags |= NFT_PAYLOAD_CTX_INNER_TUN;
+	*off += priv->hdrsize;
+
+	return 0;
+}
+
+static int nft_inner_parse(const struct nft_inner *priv,
+			   const struct nft_pktinfo *pkt,
+			   struct nft_inner_tun_ctx *ctx)
+{
+	u32 off = pkt->inneroff;
+
+	if (priv->flags & NFT_INNER_HDRSIZE &&
+	    nft_inner_parse_tunhdr(priv, pkt, ctx, &off) < 0)
+		return -1;
+
+	if (priv->flags & (NFT_INNER_LL | NFT_INNER_NH)) {
+		if (nft_inner_parse_l2l3(priv, pkt, ctx, off) < 0)
+			return -1;
+	} else if (priv->flags & NFT_INNER_TH) {
+		ctx->inner_thoff = off - pkt->inneroff;
+		ctx->flags |= NFT_PAYLOAD_CTX_INNER_TH;
+	}
+
+	return 0;
+}
+
+static void nft_inner_eval(const struct nft_expr *expr, struct nft_regs *regs,
+			   const struct nft_pktinfo *pkt)
+{
+	const struct nft_inner *priv = nft_expr_priv(expr);
+	struct nft_inner_tun_ctx tun_ctx = {};
+
+	if (nft_payload_inner_offset(pkt) < 0)
+		goto err;
+
+	if (nft_inner_parse(priv, pkt, &tun_ctx) < 0)
+		goto err;
+
+	switch (priv->expr_type) {
+	case NFT_INNER_EXPR_PAYLOAD:
+		nft_payload_inner_eval((struct nft_expr *)&priv->expr, regs, pkt, &tun_ctx);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		goto err;
+	}
+	return;
+err:
+	regs->verdict.code = NFT_BREAK;
+}
+
+static const struct nla_policy nft_inner_policy[NFTA_INNER_MAX + 1] = {
+	[NFTA_INNER_NUM]	= { .type = NLA_U32 },
+	[NFTA_INNER_FLAGS]	= { .type = NLA_U32 },
+	[NFTA_INNER_HDRSIZE]	= { .type = NLA_U32 },
+	[NFTA_INNER_TYPE]	= { .type = NLA_U32 },
+	[NFTA_INNER_EXPR]	= { .type = NLA_NESTED },
+};
+
+struct nft_expr_info {
+	const struct nft_expr_ops	*ops;
+	const struct nlattr		*attr;
+	struct nlattr			*tb[NFT_EXPR_MAXATTR + 1];
+};
+
+static int nft_inner_init(const struct nft_ctx *ctx,
+			  const struct nft_expr *expr,
+			  const struct nlattr * const tb[])
+{
+	struct nft_inner *priv = nft_expr_priv(expr);
+	u32 flags, hdrsize, type, num;
+	struct nft_expr_info expr_info;
+	int err;
+
+	if (!tb[NFTA_INNER_FLAGS] ||
+	    !tb[NFTA_INNER_HDRSIZE] ||
+	    !tb[NFTA_INNER_TYPE] ||
+	    !tb[NFTA_INNER_EXPR])
+		return -EINVAL;
+
+	flags = ntohl(nla_get_be32(tb[NFTA_INNER_FLAGS]));
+	if (flags & ~NFT_INNER_MASK)
+		return -EOPNOTSUPP;
+
+	num = ntohl(nla_get_be32(tb[NFTA_INNER_NUM]));
+	if (num != 0)
+		return -EOPNOTSUPP;
+
+	hdrsize = ntohl(nla_get_be32(tb[NFTA_INNER_HDRSIZE]));
+	type = ntohl(nla_get_be32(tb[NFTA_INNER_TYPE]));
+
+	if (type > U8_MAX)
+		return -EINVAL;
+
+	if (flags & NFT_INNER_HDRSIZE) {
+		if (hdrsize == 0 || hdrsize > 64)
+			return -EOPNOTSUPP;
+	}
+
+	priv->flags = flags;
+	priv->hdrsize = hdrsize;
+	priv->type = type;
+
+	err = nft_expr_inner_parse(ctx, tb[NFTA_INNER_EXPR], &expr_info);
+	if (err < 0)
+		return err;
+
+	priv->expr.ops = expr_info.ops;
+
+	if (!strcmp(expr_info.ops->type->name, "payload"))
+		priv->expr_type = NFT_INNER_EXPR_PAYLOAD;
+	else
+		return -EINVAL;
+
+	err = expr_info.ops->init(ctx, (struct nft_expr *)&priv->expr,
+				  (const struct nlattr * const*)expr_info.tb);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int nft_inner_dump(struct sk_buff *skb, const struct nft_expr *expr)
+{
+	const struct nft_inner *priv = nft_expr_priv(expr);
+
+	if (nla_put_be32(skb, NFTA_INNER_NUM, htonl(0)) ||
+	    nla_put_be32(skb, NFTA_INNER_TYPE, htonl(priv->type)) ||
+	    nla_put_be32(skb, NFTA_INNER_FLAGS, htonl(priv->flags)) ||
+	    nla_put_be32(skb, NFTA_INNER_HDRSIZE, htonl(priv->hdrsize)))
+		goto nla_put_failure;
+
+	if (nft_expr_dump(skb, NFTA_INNER_EXPR,
+			  (struct nft_expr *)&priv->expr) < 0)
+		goto nla_put_failure;
+
+	return 0;
+
+nla_put_failure:
+	return -1;
+}
+
+static const struct nft_expr_ops nft_inner_ops = {
+	.type		= &nft_inner_type,
+	.size		= NFT_EXPR_SIZE(sizeof(struct nft_inner)),
+	.eval		= nft_inner_eval,
+	.init		= nft_inner_init,
+	.dump		= nft_inner_dump,
+};
+
+struct nft_expr_type nft_inner_type __read_mostly = {
+	.name		= "inner",
+	.ops		= &nft_inner_ops,
+	.policy		= nft_inner_policy,
+	.maxattr	= NFTA_INNER_MAX,
+	.owner		= THIS_MODULE,
+};
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index daf336331620..42350cd8251d 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -134,7 +134,7 @@ static int __nft_payload_inner_offset(struct nft_pktinfo *pkt)
 	return 0;
 }
 
-static int nft_payload_inner_offset(const struct nft_pktinfo *pkt)
+int nft_payload_inner_offset(const struct nft_pktinfo *pkt)
 {
 	if (!(pkt->flags & NFT_PKTINFO_INNER) &&
 	    __nft_payload_inner_offset((struct nft_pktinfo *)pkt) < 0)
@@ -577,6 +577,92 @@ const struct nft_expr_ops nft_payload_fast_ops = {
 	.offload	= nft_payload_offload,
 };
 
+void nft_payload_inner_eval(const struct nft_expr *expr, struct nft_regs *regs,
+			    const struct nft_pktinfo *pkt,
+			    struct nft_inner_tun_ctx *tun_ctx)
+{
+	const struct nft_payload *priv = nft_expr_priv(expr);
+	const struct sk_buff *skb = pkt->skb;
+	u32 *dest = &regs->data[priv->dreg];
+	int offset;
+
+	if (priv->len % NFT_REG32_SIZE)
+		dest[priv->len / NFT_REG32_SIZE] = 0;
+
+	switch (priv->base) {
+	case NFT_PAYLOAD_TUN_HEADER:
+		if (!(tun_ctx->flags & NFT_PAYLOAD_CTX_INNER_TUN))
+			goto err;
+
+		offset = pkt->inneroff + tun_ctx->inner_tunoff;
+		break;
+	case NFT_PAYLOAD_LL_HEADER:
+		if (!(tun_ctx->flags & NFT_PAYLOAD_CTX_INNER_LL))
+			goto err;
+
+		offset = pkt->inneroff + tun_ctx->inner_lloff;
+		break;
+	case NFT_PAYLOAD_NETWORK_HEADER:
+		if (!(tun_ctx->flags & NFT_PAYLOAD_CTX_INNER_NH))
+			goto err;
+
+		offset = pkt->inneroff + tun_ctx->inner_nhoff;
+		break;
+	case NFT_PAYLOAD_TRANSPORT_HEADER:
+		if (!(tun_ctx->flags & NFT_PAYLOAD_CTX_INNER_TH))
+			goto err;
+
+		offset = pkt->inneroff + tun_ctx->inner_thoff;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		goto err;
+	}
+	offset += priv->offset;
+
+	if (skb_copy_bits(skb, offset, dest, priv->len) < 0)
+		goto err;
+
+	return;
+err:
+	regs->verdict.code = NFT_BREAK;
+}
+
+static int nft_payload_inner_init(const struct nft_ctx *ctx,
+				  const struct nft_expr *expr,
+				  const struct nlattr * const tb[])
+{
+	struct nft_payload *priv = nft_expr_priv(expr);
+	u32 base;
+
+	base   = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_BASE]));
+	switch (base) {
+	case NFT_PAYLOAD_TUN_HEADER:
+	case NFT_PAYLOAD_LL_HEADER:
+	case NFT_PAYLOAD_NETWORK_HEADER:
+	case NFT_PAYLOAD_TRANSPORT_HEADER:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	priv->base   = base;
+	priv->offset = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_OFFSET]));
+	priv->len    = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_LEN]));
+
+	return nft_parse_register_store(ctx, tb[NFTA_PAYLOAD_DREG],
+					&priv->dreg, NULL, NFT_DATA_VALUE,
+					priv->len);
+}
+
+static const struct nft_expr_ops nft_payload_inner_ops = {
+	.type		= &nft_payload_type,
+	.size		= NFT_EXPR_SIZE(sizeof(struct nft_payload)),
+	.init		= nft_payload_inner_init,
+	.dump		= nft_payload_dump,
+	/* direct call to nft_payload_inner_eval(). */
+};
+
 static inline void nft_csum_replace(__sum16 *sum, __wsum fsum, __wsum tsum)
 {
 	*sum = csum_fold(csum_add(csum_sub(~csum_unfold(*sum), fsum), tsum));
@@ -920,6 +1006,7 @@ nft_payload_select_ops(const struct nft_ctx *ctx,
 struct nft_expr_type nft_payload_type __read_mostly = {
 	.name		= "payload",
 	.select_ops	= nft_payload_select_ops,
+	.inner_ops	= &nft_payload_inner_ops,
 	.policy		= nft_payload_policy,
 	.maxattr	= NFTA_PAYLOAD_MAX,
 	.owner		= THIS_MODULE,
-- 
2.30.2

