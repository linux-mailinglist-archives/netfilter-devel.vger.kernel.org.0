Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF6A43E9E2
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Oct 2021 22:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhJ1Uvj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 Oct 2021 16:51:39 -0400
Received: from mail.netfilter.org ([217.70.188.207]:51536 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhJ1Uvi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 Oct 2021 16:51:38 -0400
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 29B3463F1F
        for <netfilter-devel@vger.kernel.org>; Thu, 28 Oct 2021 22:47:21 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 2/2,v2] netfilter: nft_payload: support for inner header matching / mangling
Date:   Thu, 28 Oct 2021 22:49:01 +0200
Message-Id: <20211028204901.2183-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211028204901.2183-1-pablo@netfilter.org>
References: <20211028204901.2183-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Allow to match and mangle on inner headers from the transport payload
offset. There is a new field in the pktinfo structure that stores this
offset which is calculated only when requested.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: - missing check for NFT_PAYLOAD_INNER_HEADER in nft_payload_select_ops
    - use pktinfo->flags
    - consolidate nft_payload_inner_offset() for stmt and expr

 include/net/netfilter/nf_tables.h        |  2 +
 include/uapi/linux/netfilter/nf_tables.h |  2 +
 net/netfilter/nft_payload.c              | 52 +++++++++++++++++++++++-
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 7e3188cf4a7d..a0d9e0b47ab8 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -23,6 +23,7 @@ struct module;
 
 enum {
 	NFT_PKTINFO_L4PROTO	= (1 << 0),
+	NFT_PKTINFO_INNER	= (1 << 1),
 };
 
 struct nft_pktinfo {
@@ -32,6 +33,7 @@ struct nft_pktinfo {
 	u8				tprot;
 	u16				fragoff;
 	unsigned int			thoff;
+	unsigned int			inneroff;
 };
 
 static inline struct sock *nft_sk(const struct nft_pktinfo *pkt)
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 08db4ee06ab6..466fd3f4447c 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -753,11 +753,13 @@ enum nft_dynset_attributes {
  * @NFT_PAYLOAD_LL_HEADER: link layer header
  * @NFT_PAYLOAD_NETWORK_HEADER: network header
  * @NFT_PAYLOAD_TRANSPORT_HEADER: transport header
+ * @NFT_PAYLOAD_INNER_HEADER: inner header / payload
  */
 enum nft_payload_bases {
 	NFT_PAYLOAD_LL_HEADER,
 	NFT_PAYLOAD_NETWORK_HEADER,
 	NFT_PAYLOAD_TRANSPORT_HEADER,
+	NFT_PAYLOAD_INNER_HEADER,
 };
 
 /**
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index d1cd6583ee00..2b65b83775b3 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -22,6 +22,7 @@
 #include <linux/icmpv6.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/ip.h>
 #include <net/sctp/checksum.h>
 
 static bool nft_payload_rebuild_vlan_hdr(const struct sk_buff *skb, int mac_off,
@@ -79,6 +80,45 @@ nft_payload_copy_vlan(u32 *d, const struct sk_buff *skb, u8 offset, u8 len)
 	return skb_copy_bits(skb, offset + mac_off, dst_u8, len) == 0;
 }
 
+static int __nft_payload_inner_offset(struct nft_pktinfo *pkt)
+{
+	unsigned int thoff = nft_thoff(pkt);
+
+	switch (pkt->tprot) {
+	case IPPROTO_UDP:
+		pkt->inneroff = thoff + sizeof(struct udphdr);
+		break;
+	case IPPROTO_TCP: {
+		struct tcphdr *th, _tcph;
+
+		th = skb_header_pointer(pkt->skb, thoff, sizeof(_tcph), &_tcph);
+		if (!th)
+			return -1;
+
+		pkt->inneroff = thoff + __tcp_hdrlen(th);
+		}
+		break;
+	default:
+		return -1;
+	}
+
+	pkt->flags |= NFT_PKTINFO_INNER;
+
+	return 0;
+}
+
+static int nft_payload_inner_offset(const struct nft_pktinfo *pkt)
+{
+	if (!(pkt->flags & NFT_PKTINFO_L4PROTO))
+		return -1;
+
+	if (!(pkt->flags & NFT_PKTINFO_INNER) &&
+	    __nft_payload_inner_offset((struct nft_pktinfo *)pkt) < 0)
+		return -1;
+
+	return pkt->inneroff;
+}
+
 void nft_payload_eval(const struct nft_expr *expr,
 		      struct nft_regs *regs,
 		      const struct nft_pktinfo *pkt)
@@ -112,6 +152,9 @@ void nft_payload_eval(const struct nft_expr *expr,
 			goto err;
 		offset = nft_thoff(pkt);
 		break;
+	case NFT_PAYLOAD_INNER_HEADER:
+		offset = nft_payload_inner_offset(pkt);
+		break;
 	default:
 		BUG();
 	}
@@ -614,6 +657,9 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 			goto err;
 		offset = nft_thoff(pkt);
 		break;
+	case NFT_PAYLOAD_INNER_HEADER:
+		offset = nft_payload_inner_offset(pkt);
+		break;
 	default:
 		BUG();
 	}
@@ -622,7 +668,8 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 	offset += priv->offset;
 
 	if ((priv->csum_type == NFT_PAYLOAD_CSUM_INET || priv->csum_flags) &&
-	    (priv->base != NFT_PAYLOAD_TRANSPORT_HEADER ||
+	    ((priv->base != NFT_PAYLOAD_TRANSPORT_HEADER &&
+	      priv->base != NFT_PAYLOAD_INNER_HEADER) ||
 	     skb->ip_summed != CHECKSUM_PARTIAL)) {
 		fsum = skb_checksum(skb, offset, priv->len, 0);
 		tsum = csum_partial(src, priv->len, 0);
@@ -741,6 +788,7 @@ nft_payload_select_ops(const struct nft_ctx *ctx,
 	case NFT_PAYLOAD_LL_HEADER:
 	case NFT_PAYLOAD_NETWORK_HEADER:
 	case NFT_PAYLOAD_TRANSPORT_HEADER:
+	case NFT_PAYLOAD_INNER_HEADER:
 		break;
 	default:
 		return ERR_PTR(-EOPNOTSUPP);
@@ -759,7 +807,7 @@ nft_payload_select_ops(const struct nft_ctx *ctx,
 	len    = ntohl(nla_get_be32(tb[NFTA_PAYLOAD_LEN]));
 
 	if (len <= 4 && is_power_of_2(len) && IS_ALIGNED(offset, len) &&
-	    base != NFT_PAYLOAD_LL_HEADER)
+	    base != NFT_PAYLOAD_LL_HEADER && base != NFT_PAYLOAD_INNER_HEADER)
 		return &nft_payload_fast_ops;
 	else
 		return &nft_payload_ops;
-- 
2.30.2

