Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35361B7F67
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 Apr 2020 21:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDXTzr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 24 Apr 2020 15:55:47 -0400
Received: from correo.us.es ([193.147.175.20]:46106 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbgDXTzq (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:55:46 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1FAA0D28C2
        for <netfilter-devel@vger.kernel.org>; Fri, 24 Apr 2020 21:55:45 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 11764BAAA3
        for <netfilter-devel@vger.kernel.org>; Fri, 24 Apr 2020 21:55:45 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 07329BAABD; Fri, 24 Apr 2020 21:55:45 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1D46EBAAA3
        for <netfilter-devel@vger.kernel.org>; Fri, 24 Apr 2020 21:55:43 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 24 Apr 2020 21:55:43 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 09F9242EF4E0
        for <netfilter-devel@vger.kernel.org>; Fri, 24 Apr 2020 21:55:43 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 3/5] netfilter: nft_nat: set flags from initialization path
Date:   Fri, 24 Apr 2020 21:55:35 +0200
Message-Id: <20200424195537.23975-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424195537.23975-1-pablo@netfilter.org>
References: <20200424195537.23975-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch sets the NAT flags from the control plane path.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_nat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_nat.c b/net/netfilter/nft_nat.c
index bb49a217635e..5c7ff213c030 100644
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -55,7 +55,6 @@ static void nft_nat_eval(const struct nft_expr *expr,
 			       &regs->data[priv->sreg_addr_max],
 			       sizeof(range.max_addr.ip6));
 		}
-		range.flags |= NF_NAT_RANGE_MAP_IPS;
 	}
 
 	if (priv->sreg_proto_min) {
@@ -63,10 +62,9 @@ static void nft_nat_eval(const struct nft_expr *expr,
 			&regs->data[priv->sreg_proto_min]);
 		range.max_proto.all = (__force __be16)nft_reg_load16(
 			&regs->data[priv->sreg_proto_max]);
-		range.flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
 	}
 
-	range.flags |= priv->flags;
+	range.flags = priv->flags;
 
 	regs->verdict.code = nf_nat_setup_info(ct, &range, priv->type);
 }
@@ -169,6 +167,8 @@ static int nft_nat_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		} else {
 			priv->sreg_addr_max = priv->sreg_addr_min;
 		}
+
+		priv->flags |= NF_NAT_RANGE_MAP_IPS;
 	}
 
 	plen = sizeof_field(struct nf_nat_range, min_addr.all);
@@ -191,10 +191,12 @@ static int nft_nat_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		} else {
 			priv->sreg_proto_max = priv->sreg_proto_min;
 		}
+
+		priv->flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
 	}
 
 	if (tb[NFTA_NAT_FLAGS]) {
-		priv->flags = ntohl(nla_get_be32(tb[NFTA_NAT_FLAGS]));
+		priv->flags |= ntohl(nla_get_be32(tb[NFTA_NAT_FLAGS]));
 		if (priv->flags & ~NF_NAT_RANGE_MASK)
 			return -EOPNOTSUPP;
 	}
-- 
2.20.1

