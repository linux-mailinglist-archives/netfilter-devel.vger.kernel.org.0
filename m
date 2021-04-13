Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4994135DDF7
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Apr 2021 13:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245106AbhDMLn5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Apr 2021 07:43:57 -0400
Received: from mail.netfilter.org ([217.70.188.207]:51788 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245086AbhDMLn4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:43:56 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id D31B263E34;
        Tue, 13 Apr 2021 13:43:10 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     wenxu@ucloud.cn
Subject: [PATCH nf-next,v3 2/3] netfilter: nftables_offload: VLAN id needs host byteorder in flow dissector
Date:   Tue, 13 Apr 2021 13:43:29 +0200
Message-Id: <20210413114330.273319-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210413114330.273319-1-pablo@netfilter.org>
References: <20210413114330.273319-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The flow dissector representation expects the VLAN id in host byteorder.
Add the NFT_OFFLOAD_F_NETWORK2HOST flag to swap the bytes from nft_cmp.

Fixes: a82055af5959 ("netfilter: nft_payload: add VLAN offload support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Reported-by: kernel test robot <lkp@intel.com>
---
v3: fix sparse warnings.

 include/net/netfilter/nf_tables_offload.h | 11 +++++-
 net/netfilter/nft_cmp.c                   | 41 +++++++++++++++++++++--
 net/netfilter/nft_payload.c               | 10 +++---
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/include/net/netfilter/nf_tables_offload.h b/include/net/netfilter/nf_tables_offload.h
index b4d080061399..434a6158852f 100644
--- a/include/net/netfilter/nf_tables_offload.h
+++ b/include/net/netfilter/nf_tables_offload.h
@@ -4,11 +4,16 @@
 #include <net/flow_offload.h>
 #include <net/netfilter/nf_tables.h>
 
+enum nft_offload_reg_flags {
+	NFT_OFFLOAD_F_NETWORK2HOST	= (1 << 0),
+};
+
 struct nft_offload_reg {
 	u32		key;
 	u32		len;
 	u32		base_offset;
 	u32		offset;
+	u32		flags;
 	struct nft_data data;
 	struct nft_data	mask;
 };
@@ -72,13 +77,17 @@ struct nft_flow_rule *nft_flow_rule_create(struct net *net, const struct nft_rul
 void nft_flow_rule_destroy(struct nft_flow_rule *flow);
 int nft_flow_rule_offload_commit(struct net *net);
 
-#define NFT_OFFLOAD_MATCH(__key, __base, __field, __len, __reg)		\
+#define NFT_OFFLOAD_MATCH_FLAGS(__key, __base, __field, __len, __reg, __flags)	\
 	(__reg)->base_offset	=					\
 		offsetof(struct nft_flow_key, __base);			\
 	(__reg)->offset		=					\
 		offsetof(struct nft_flow_key, __base.__field);		\
 	(__reg)->len		= __len;				\
 	(__reg)->key		= __key;				\
+	(__reg)->flags		= __flags;
+
+#define NFT_OFFLOAD_MATCH(__key, __base, __field, __len, __reg)		\
+	NFT_OFFLOAD_MATCH_FLAGS(__key, __base, __field, __len, __reg, 0)
 
 #define NFT_OFFLOAD_MATCH_EXACT(__key, __base, __field, __len, __reg)	\
 	NFT_OFFLOAD_MATCH(__key, __base, __field, __len, __reg)		\
diff --git a/net/netfilter/nft_cmp.c b/net/netfilter/nft_cmp.c
index eb6a43a180bb..e78de1fb547a 100644
--- a/net/netfilter/nft_cmp.c
+++ b/net/netfilter/nft_cmp.c
@@ -114,19 +114,56 @@ static int nft_cmp_dump(struct sk_buff *skb, const struct nft_expr *expr)
 	return -1;
 }
 
+union nft_cmp_offload_data {
+	u16	val16;
+	u32	val32;
+	u64	val64;
+};
+
+static void nft_payload_n2h(union nft_cmp_offload_data *data,
+			    const u8 *val, u32 len)
+{
+	switch (len) {
+	case 2:
+		data->val16 = ntohs(*((__be16 *)val));
+		break;
+	case 4:
+		data->val32 = ntohl(*((__be32 *)val));
+		break;
+	case 8:
+		data->val64 = be64_to_cpu(*((__be64 *)val));
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+}
+
 static int __nft_cmp_offload(struct nft_offload_ctx *ctx,
 			     struct nft_flow_rule *flow,
 			     const struct nft_cmp_expr *priv)
 {
 	struct nft_offload_reg *reg = &ctx->regs[priv->sreg];
+	union nft_cmp_offload_data _data, _datamask;
 	u8 *mask = (u8 *)&flow->match.mask;
 	u8 *key = (u8 *)&flow->match.key;
+	u8 *data, *datamask;
 
 	if (priv->op != NFT_CMP_EQ || priv->len > reg->len)
 		return -EOPNOTSUPP;
 
-	memcpy(key + reg->offset, &priv->data, reg->len);
-	memcpy(mask + reg->offset, &reg->mask, reg->len);
+	if (reg->flags & NFT_OFFLOAD_F_NETWORK2HOST) {
+		nft_payload_n2h(&_data, (u8 *)&priv->data, reg->len);
+		nft_payload_n2h(&_datamask, (u8 *)&reg->mask, reg->len);
+		data = (u8 *)&_data;
+		datamask = (u8 *)&_datamask;
+	} else {
+		data = (u8 *)&priv->data;
+		datamask = (u8 *)&reg->mask;
+	}
+
+	memcpy(key + reg->offset, data, reg->len);
+	memcpy(mask + reg->offset, datamask, reg->len);
 
 	flow->match.dissector.used_keys |= BIT(reg->key);
 	flow->match.dissector.offset[reg->key] = reg->base_offset;
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index a990f37e0a60..501c5b24cc39 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -226,8 +226,9 @@ static int nft_payload_offload_ll(struct nft_offload_ctx *ctx,
 		if (!nft_payload_offload_mask(reg, priv->len, sizeof(__be16)))
 			return -EOPNOTSUPP;
 
-		NFT_OFFLOAD_MATCH(FLOW_DISSECTOR_KEY_VLAN, vlan,
-				  vlan_tci, sizeof(__be16), reg);
+		NFT_OFFLOAD_MATCH_FLAGS(FLOW_DISSECTOR_KEY_VLAN, vlan,
+					vlan_tci, sizeof(__be16), reg,
+					NFT_OFFLOAD_F_NETWORK2HOST);
 		break;
 	case offsetof(struct vlan_ethhdr, h_vlan_encapsulated_proto):
 		if (!nft_payload_offload_mask(reg, priv->len, sizeof(__be16)))
@@ -241,8 +242,9 @@ static int nft_payload_offload_ll(struct nft_offload_ctx *ctx,
 		if (!nft_payload_offload_mask(reg, priv->len, sizeof(__be16)))
 			return -EOPNOTSUPP;
 
-		NFT_OFFLOAD_MATCH(FLOW_DISSECTOR_KEY_CVLAN, cvlan,
-				  vlan_tci, sizeof(__be16), reg);
+		NFT_OFFLOAD_MATCH_FLAGS(FLOW_DISSECTOR_KEY_CVLAN, cvlan,
+					vlan_tci, sizeof(__be16), reg,
+					NFT_OFFLOAD_F_NETWORK2HOST);
 		break;
 	case offsetof(struct vlan_ethhdr, h_vlan_encapsulated_proto) +
 							sizeof(struct vlan_hdr):
-- 
2.30.2

