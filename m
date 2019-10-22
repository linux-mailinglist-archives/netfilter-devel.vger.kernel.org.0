Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD1BEE07C5
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Oct 2019 17:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387914AbfJVPrr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Oct 2019 11:47:47 -0400
Received: from correo.us.es ([193.147.175.20]:41910 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387918AbfJVPrq (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:47:46 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 05EE81C442B
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Oct 2019 17:47:42 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E8D6FA7EC5
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Oct 2019 17:47:41 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id DC69BA7EC2; Tue, 22 Oct 2019 17:47:41 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D708DB7FF9;
        Tue, 22 Oct 2019 17:47:39 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 22 Oct 2019 17:47:39 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id B05DF42EE38E;
        Tue, 22 Oct 2019 17:47:39 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, wenxu@ucloud.cn
Subject: [PATCH nf-next,RFC 1/2] netfilter: nf_tables: add decapsulation support
Date:   Tue, 22 Oct 2019 17:47:32 +0200
Message-Id: <20191022154733.8789-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191022154733.8789-1-pablo@netfilter.org>
References: <20191022154733.8789-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds support for the decapsulation infrastructure, including
VLAN support for this.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/uapi/linux/netfilter/nf_tables.h |  16 +++++
 net/netfilter/Kconfig                    |   6 ++
 net/netfilter/Makefile                   |   1 +
 net/netfilter/nft_encap.c                | 119 +++++++++++++++++++++++++++++++
 4 files changed, 142 insertions(+)
 create mode 100644 net/netfilter/nft_encap.c

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 81fed16fe2b2..25e26340a0ba 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1625,6 +1625,22 @@ enum nft_xfrm_keys {
 };
 #define NFT_XFRM_KEY_MAX (__NFT_XFRM_KEY_MAX - 1)
 
+enum nft_encap_type {
+	NFT_ENCAP_VLAN	= 0,
+};
+
+/**
+ * enum nft_decap_attributes - nf_tables decapsulation expression netlink attributes
+ *
+ * @NFTA_DECAP_TYPE: decapsulation type (NLA_U32)
+ */
+enum nft_decap_attributes {
+	NFTA_DECAP_UNSPEC,
+	NFTA_DECAP_TYPE,
+	__NFTA_DECAP_MAX,
+};
+#define NFTA_DECAP_MAX	(__NFTA_DECAP_MAX - 1)
+
 /**
  * enum nft_trace_attributes - nf_tables trace netlink attributes
  *
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 91efae88e8c2..573ea56aecfe 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -489,6 +489,12 @@ config NFT_CT
 	  This option adds the "ct" expression that you can use to match
 	  connection tracking information such as the flow state.
 
+config NFT_ENCAP
+	tristate "Netfilter nf_tables encapsulation/decapsulation module"
+	help
+	  This option adds the encapsulation expression used to decapsulate
+	  and to encapsulate packets through VLAN.
+
 config NFT_FLOW_OFFLOAD
 	depends on NF_CONNTRACK && NF_FLOW_TABLE
 	tristate "Netfilter nf_tables hardware flow offload module"
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index 4fc075b612fe..be8345c14a6e 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_NFT_COMPAT)	+= nft_compat.o
 obj-$(CONFIG_NFT_CONNLIMIT)	+= nft_connlimit.o
 obj-$(CONFIG_NFT_NUMGEN)	+= nft_numgen.o
 obj-$(CONFIG_NFT_CT)		+= nft_ct.o
+obj-$(CONFIG_NFT_ENCAP)		+= nft_encap.o
 obj-$(CONFIG_NFT_FLOW_OFFLOAD)	+= nft_flow_offload.o
 obj-$(CONFIG_NFT_LIMIT)		+= nft_limit.o
 obj-$(CONFIG_NFT_NAT)		+= nft_nat.o
diff --git a/net/netfilter/nft_encap.c b/net/netfilter/nft_encap.c
new file mode 100644
index 000000000000..657a62e4c283
--- /dev/null
+++ b/net/netfilter/nft_encap.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/netlink.h>
+#include <linux/netfilter.h>
+#include <linux/netfilter/nf_tables.h>
+#include <net/netfilter/nf_tables_core.h>
+#include <net/netfilter/nf_tables.h>
+
+struct nft_decap {
+	enum nft_encap_type	type;
+};
+
+void nft_decap_eval(const struct nft_expr *expr,
+		    struct nft_regs *regs,
+		    const struct nft_pktinfo *pkt)
+{
+	const struct nft_decap *priv = nft_expr_priv(expr);
+	int err;
+
+	switch (priv->type) {
+	case NFT_ENCAP_VLAN:
+		err = skb_vlan_pop(pkt->skb);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		err = -1;
+	}
+
+	if (err < 0)
+		goto decap_error;
+
+	return;
+decap_error:
+	regs->verdict.code = NFT_BREAK;
+}
+
+static const struct nla_policy nft_decap_policy[NFTA_DECAP_MAX + 1] = {
+	[NFTA_DECAP_TYPE]	= { .type = NLA_U32 },
+};
+
+static int nft_decap_init(const struct nft_ctx *ctx,
+			  const struct nft_expr *expr,
+			  const struct nlattr * const tb[])
+{
+	struct nft_decap *priv = nft_expr_priv(expr);
+
+	if (!tb[NFTA_DECAP_TYPE])
+		return -EINVAL;
+
+	priv->type = ntohl(nla_get_be32(tb[NFTA_DECAP_TYPE]));
+	switch (priv->type) {
+	case NFT_ENCAP_VLAN:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int nft_decap_dump(struct sk_buff *skb, const struct nft_expr *expr)
+{
+	const struct nft_decap *priv = nft_expr_priv(expr);
+
+	if (nla_put_be32(skb, NFTA_DECAP_TYPE, htonl(priv->type)))
+		goto nla_put_failure;
+
+	return 0;
+
+nla_put_failure:
+	return -1;
+}
+
+static int nft_decap_validate(const struct nft_ctx *ctx,
+			      const struct nft_expr *expr,
+			      const struct nft_data **data)
+{
+	if (ctx->family != NFPROTO_NETDEV)
+		return -EOPNOTSUPP;
+
+	return nft_chain_validate_hooks(ctx->chain, 1 << NF_NETDEV_INGRESS);
+}
+
+static struct nft_expr_type nft_decap_type;
+static const struct nft_expr_ops nft_decap_ops = {
+	.type		= &nft_decap_type,
+	.size		= NFT_EXPR_SIZE(sizeof(struct nft_decap)),
+	.eval		= nft_decap_eval,
+	.init		= nft_decap_init,
+	.dump		= nft_decap_dump,
+	.validate	= nft_decap_validate,
+};
+
+static struct nft_expr_type nft_decap_type __read_mostly = {
+	.name		= "decap",
+	.ops		= &nft_decap_ops,
+	.policy		= nft_decap_policy,
+	.maxattr	= NFTA_DECAP_MAX,
+	.owner		= THIS_MODULE,
+};
+
+static int __init nft_encap_netdev_module_init(void)
+{
+	return nft_register_expr(&nft_decap_type);
+}
+
+static void __exit nft_encap_netdev_module_exit(void)
+{
+	nft_unregister_expr(&nft_decap_type);
+}
+
+module_init(nft_encap_netdev_module_init);
+module_exit(nft_encap_netdev_module_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Pablo Neira Ayuso <pablo@netfilter.org>");
+MODULE_ALIAS_NFT_AF_EXPR(5, "decap");
-- 
2.11.0

