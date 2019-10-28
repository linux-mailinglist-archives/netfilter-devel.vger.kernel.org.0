Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB1BE7357
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Oct 2019 15:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfJ1OHO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Oct 2019 10:07:14 -0400
Received: from correo.us.es ([193.147.175.20]:44576 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730638AbfJ1OHO (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:07:14 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DEAE211EB27
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Oct 2019 15:07:09 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D0656DA72F
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Oct 2019 15:07:09 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C60F9B7FF6; Mon, 28 Oct 2019 15:07:09 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E4935DA72F
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Oct 2019 15:07:07 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 28 Oct 2019 15:07:07 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id CBDA942EE393
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Oct 2019 15:07:07 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v2] netfilter: nf_tables_offload: check for register data length mismatches
Date:   Mon, 28 Oct 2019 15:07:06 +0100
Message-Id: <20191028140706.13383-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Make sure register data length does not mismatch immediate data length,
otherwise hit EOPNOTSUPP.

Fixes: c9626a2cbdb2 ("netfilter: nf_tables: add hardware offload support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: update bitwise too.

 net/netfilter/nft_bitwise.c | 5 +++--
 net/netfilter/nft_cmp.c     | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index 974300178fa9..02afa752dd2e 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -134,12 +134,13 @@ static int nft_bitwise_offload(struct nft_offload_ctx *ctx,
                                const struct nft_expr *expr)
 {
 	const struct nft_bitwise *priv = nft_expr_priv(expr);
+	struct nft_offload_reg *reg = &ctx->regs[priv->dreg];
 
 	if (memcmp(&priv->xor, &zero, sizeof(priv->xor)) ||
-	    priv->sreg != priv->dreg)
+	    priv->sreg != priv->dreg || priv->len != reg->len)
 		return -EOPNOTSUPP;
 
-	memcpy(&ctx->regs[priv->dreg].mask, &priv->mask, sizeof(priv->mask));
+	memcpy(&reg->mask, &priv->mask, sizeof(priv->mask));
 
 	return 0;
 }
diff --git a/net/netfilter/nft_cmp.c b/net/netfilter/nft_cmp.c
index bd173b1824c6..0744b2bb46da 100644
--- a/net/netfilter/nft_cmp.c
+++ b/net/netfilter/nft_cmp.c
@@ -116,7 +116,7 @@ static int __nft_cmp_offload(struct nft_offload_ctx *ctx,
 	u8 *mask = (u8 *)&flow->match.mask;
 	u8 *key = (u8 *)&flow->match.key;
 
-	if (priv->op != NFT_CMP_EQ)
+	if (priv->op != NFT_CMP_EQ || reg->len != priv->len)
 		return -EOPNOTSUPP;
 
 	memcpy(key + reg->offset, &priv->data, priv->len);
-- 
2.11.0

