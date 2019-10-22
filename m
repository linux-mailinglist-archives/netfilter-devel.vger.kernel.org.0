Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 205EBE07C6
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Oct 2019 17:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbfJVPrr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Oct 2019 11:47:47 -0400
Received: from correo.us.es ([193.147.175.20]:41934 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387922AbfJVPrr (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:47:47 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id EE2661C4442
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Oct 2019 17:47:42 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DED21B8005
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Oct 2019 17:47:42 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D44BBB8001; Tue, 22 Oct 2019 17:47:42 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BFB2AB8005;
        Tue, 22 Oct 2019 17:47:40 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 22 Oct 2019 17:47:40 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 9853542EE38E;
        Tue, 22 Oct 2019 17:47:40 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, wenxu@ucloud.cn
Subject: [PATCH nf-next,RFC 2/2] netfilter: nf_tables: add encapsulation support
Date:   Tue, 22 Oct 2019 17:47:33 +0200
Message-Id: <20191022154733.8789-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191022154733.8789-1-pablo@netfilter.org>
References: <20191022154733.8789-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds encapsulation support through the encapsulation object,
that specifies the encapsulation policy.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/uapi/linux/netfilter/nf_tables.h |  40 +++++-
 net/netfilter/nft_encap.c                | 224 ++++++++++++++++++++++++++++++-
 2 files changed, 262 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 25e26340a0ba..e5997a13ba71 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1484,7 +1484,8 @@ enum nft_ct_expectation_attributes {
 #define NFT_OBJECT_SECMARK	8
 #define NFT_OBJECT_CT_EXPECT	9
 #define NFT_OBJECT_SYNPROXY	10
-#define __NFT_OBJECT_MAX	11
+#define NFT_OBJECT_ENCAP	11
+#define __NFT_OBJECT_MAX	12
 #define NFT_OBJECT_MAX		(__NFT_OBJECT_MAX - 1)
 
 /**
@@ -1629,6 +1630,43 @@ enum nft_encap_type {
 	NFT_ENCAP_VLAN	= 0,
 };
 
+enum nft_encap_op {
+	NFT_ENCAP_ADD	= 0,
+	NFT_ENCAP_UPDATE,
+};
+
+/**
+ * enum nft_encap_vlan_attributes - nf_tables VLAN encapsulation expression netlink attributes
+ *
+ * @NFTA_ENCAP_VLAN_ID: VLAN id (NLA_U16)
+ * @NFTA_ENCAP_VLAN_PROTO: VLAN protocol (NLA_U16)
+ * @NFTA_ENCAP_VLAN_PRIO: VLAN priority (NLA_U8)
+ */
+enum nft_encap_vlan_attributes {
+	NFTA_ENCAP_VLAN_UNSPEC,
+	NFTA_ENCAP_VLAN_ID,
+	NFTA_ENCAP_VLAN_PROTO,
+	NFTA_ENCAP_VLAN_PRIO,
+	__NFTA_ENCAP_VLAN_MAX
+};
+#define NFTA_ENCAP_VLAN_MAX	(__NFTA_ENCAP_VLAN_MAX - 1)
+
+/**
+ * enum nft_encap_attributes - nf_tables encapsulation expression netlink attributes
+ *
+ * @NFTA_ENCAP_TYPE: encapsulation type (NLA_U32)
+ * @NFTA_ENCAP_OP: encapsulation operation (NLA_U32)
+ * @NFTA_ENCAP_DATA: encapsulation data (NLA_NESTED)
+ */
+enum nft_encap_attributes {
+	NFTA_ENCAP_UNSPEC,
+	NFTA_ENCAP_TYPE,
+	NFTA_ENCAP_OP,
+	NFTA_ENCAP_DATA,
+	__NFTA_ENCAP_MAX
+};
+#define NFTA_ENCAP_MAX	(__NFTA_ENCAP_MAX - 1)
+
 /**
  * enum nft_decap_attributes - nf_tables decapsulation expression netlink attributes
  *
diff --git a/net/netfilter/nft_encap.c b/net/netfilter/nft_encap.c
index 657a62e4c283..13643b3daf85 100644
--- a/net/netfilter/nft_encap.c
+++ b/net/netfilter/nft_encap.c
@@ -2,6 +2,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/if_vlan.h>
 #include <linux/netlink.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter/nf_tables.h>
@@ -101,14 +102,235 @@ static struct nft_expr_type nft_decap_type __read_mostly = {
 	.owner		= THIS_MODULE,
 };
 
+struct nft_encap {
+	enum nft_encap_type	type;
+	enum nft_encap_op	op;
+
+	union {
+		struct {
+			__u16	id;
+			__be16	proto;
+			__u8	prio;
+		} vlan;
+	};
+};
+
+static u16 nft_encap_vlan_tci(struct nft_encap *priv)
+{
+	return priv->vlan.id | (priv->vlan.prio << VLAN_PRIO_SHIFT);
+}
+
+static int nft_encap_vlan_eval(struct nft_encap *priv,
+			       struct nft_regs *regs,
+			       const struct nft_pktinfo *pkt)
+{
+	struct sk_buff *skb = pkt->skb;
+	int err;
+	u16 tci;
+
+	switch (priv->op) {
+	case NFT_ENCAP_ADD:
+		err = skb_vlan_push(skb, priv->vlan.proto,
+				    nft_encap_vlan_tci(priv));
+		if (err)
+			return err;
+		break;
+	case NFT_ENCAP_UPDATE:
+		if (!skb_vlan_tagged(skb))
+			return -1;
+
+		err = 0;
+		if (skb_vlan_tag_present(skb)) {
+			tci = skb_vlan_tag_get(skb);
+			__vlan_hwaccel_clear_tag(skb);
+		} else {
+			err = __skb_vlan_pop(skb, &tci);
+		}
+		if (err)
+			return err;
+
+		tci = (tci & ~VLAN_VID_MASK) | priv->vlan.id;
+		if (priv->vlan.prio) {
+			tci &= ~VLAN_PRIO_MASK;
+			tci |= priv->vlan.prio << VLAN_PRIO_SHIFT;
+		}
+
+		__vlan_hwaccel_put_tag(skb, priv->vlan.proto, tci);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void nft_encap_obj_eval(struct nft_object *obj,
+			       struct nft_regs *regs,
+			       const struct nft_pktinfo *pkt)
+{
+	struct nft_encap *priv = nft_obj_data(obj);
+	int err;
+
+	switch (priv->type) {
+	case NFT_ENCAP_VLAN:
+		err = nft_encap_vlan_eval(priv, regs, pkt);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		err = -1;
+	}
+
+	if (err < 0)
+		regs->verdict.code = NFT_BREAK;
+}
+
+static const struct nla_policy nft_encap_vlan_policy[NFTA_ENCAP_VLAN_MAX + 1] = {
+	[NFTA_ENCAP_VLAN_ID]	= { .type = NLA_U16 },
+	[NFTA_ENCAP_VLAN_PROTO]	= { .type = NLA_U16 },
+	[NFTA_ENCAP_VLAN_PRIO]	= { .type = NLA_U8 },
+};
+
+static int nft_encap_vlan_parse(const struct nlattr *attr,
+				struct nft_encap *priv)
+{
+	struct nlattr *tb[NFTA_ENCAP_VLAN_MAX + 1];
+	int err;
+
+	err = nla_parse_nested_deprecated(tb, NFTA_ENCAP_VLAN_MAX, attr,
+					  nft_encap_vlan_policy, NULL);
+	if (err < 0)
+		return err;
+
+	if (!tb[NFTA_ENCAP_VLAN_PRIO] ||
+	    !tb[NFTA_ENCAP_VLAN_PROTO] ||
+	    !tb[NFTA_ENCAP_VLAN_ID])
+		return -EINVAL;
+
+	priv->vlan.id = ntohs(nla_get_be16(tb[NFTA_ENCAP_VLAN_ID]));
+	priv->vlan.proto = nla_get_be16(tb[NFTA_ENCAP_VLAN_PROTO]);
+	priv->vlan.prio = nla_get_u8(tb[NFTA_ENCAP_VLAN_PRIO]);
+
+	return 0;
+}
+
+static int nft_encap_obj_init(const struct nft_ctx *ctx,
+			      const struct nlattr * const tb[],
+			      struct nft_object *obj)
+{
+	struct nft_encap *priv = nft_obj_data(obj);
+	int err = 0;
+
+	if (!tb[NFTA_ENCAP_TYPE] ||
+	    !tb[NFTA_ENCAP_OP])
+		return -EINVAL;
+
+	priv->type = ntohl(nla_get_be32(tb[NFTA_ENCAP_TYPE]));
+	priv->op = ntohl(nla_get_be32(tb[NFTA_ENCAP_OP]));
+
+	switch (priv->type) {
+	case NFT_ENCAP_VLAN:
+		if (priv->op != NFT_ENCAP_ADD &&
+		    priv->op != NFT_ENCAP_UPDATE)
+			return -EOPNOTSUPP;
+
+		err = nft_encap_vlan_parse(tb[NFTA_ENCAP_DATA], priv);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
+static int nft_encap_type_dump(struct sk_buff *skb, struct nft_encap *priv)
+{
+	struct nlattr *nest;
+
+	nest = nla_nest_start_noflag(skb, NFTA_ENCAP_DATA);
+	if (!nest)
+		goto nla_put_failure;
+
+	switch (priv->type) {
+	case NFT_ENCAP_VLAN:
+		if (nla_put_be16(skb, NFTA_ENCAP_VLAN_ID, htons(priv->vlan.id)) ||
+		    nla_put_be16(skb, NFTA_ENCAP_VLAN_PROTO, priv->vlan.proto) ||
+		    nla_put_u8(skb, NFTA_ENCAP_VLAN_PRIO, priv->vlan.prio))
+			goto nla_put_failure;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+	nla_nest_end(skb, nest);
+
+	return 0;
+
+nla_put_failure:
+	return -1;
+}
+
+static int nft_encap_obj_dump(struct sk_buff *skb, struct nft_object *obj,
+			      bool reset)
+{
+	struct nft_encap *priv = nft_obj_data(obj);
+
+	if (nla_put_be32(skb, NFTA_ENCAP_TYPE, htonl(priv->type)) ||
+	    nla_put_be32(skb, NFTA_ENCAP_OP, htonl(priv->op)) ||
+	    nft_encap_type_dump(skb, priv))
+		goto nla_put_failure;
+
+	return 0;
+
+nla_put_failure:
+	return -1;
+}
+
+static const struct nla_policy nft_encap_policy[NFTA_ENCAP_MAX + 1] = {
+	[NFTA_ENCAP_TYPE]	= { .type = NLA_U32 },
+	[NFTA_ENCAP_OP]		= { .type = NLA_U32 },
+	[NFTA_ENCAP_DATA]	= { .type = NLA_NESTED },
+};
+
+static struct nft_object_type nft_encap_obj_type;
+static const struct nft_object_ops nft_encap_obj_ops = {
+	.type		= &nft_encap_obj_type,
+	.size		= sizeof(struct nft_encap),
+	.eval		= nft_encap_obj_eval,
+	.init		= nft_encap_obj_init,
+	.dump		= nft_encap_obj_dump,
+};
+
+static struct nft_object_type nft_encap_obj_type __read_mostly = {
+	.type           = NFT_OBJECT_ENCAP,
+	.ops            = &nft_encap_obj_ops,
+	.maxattr        = NFTA_ENCAP_MAX,
+	.policy         = nft_encap_policy,
+	.owner          = THIS_MODULE,
+};
+
 static int __init nft_encap_netdev_module_init(void)
 {
-	return nft_register_expr(&nft_decap_type);
+	int err;
+
+	err = nft_register_obj(&nft_encap_obj_type);
+	if (err < 0)
+		return err;
+
+	err = nft_register_expr(&nft_decap_type);
+	if (err < 0)
+		goto err_unregister;
+
+	return 0;
+
+err_unregister:
+	nft_unregister_obj(&nft_encap_obj_type);
+	return err;
 }
 
 static void __exit nft_encap_netdev_module_exit(void)
 {
 	nft_unregister_expr(&nft_decap_type);
+	nft_unregister_obj(&nft_encap_obj_type);
 }
 
 module_init(nft_encap_netdev_module_init);
-- 
2.11.0

