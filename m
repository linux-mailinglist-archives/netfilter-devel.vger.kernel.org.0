Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6C620A4A1
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jun 2020 20:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389473AbgFYSRB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Jun 2020 14:17:01 -0400
Received: from correo.us.es ([193.147.175.20]:58820 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgFYSRB (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:17:01 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 21925FC543
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Jun 2020 20:16:59 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 134FEDA78C
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Jun 2020 20:16:59 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 08F59DA78B; Thu, 25 Jun 2020 20:16:59 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CEE1BDA73F
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Jun 2020 20:16:56 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 25 Jun 2020 20:16:56 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id B8EB442EE395
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Jun 2020 20:16:56 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 3/5] netfilter: nf_tables: add NFTA_VERDICT_CHAIN_ID attribute
Date:   Thu, 25 Jun 2020 20:16:49 +0200
Message-Id: <20200625181651.1481-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625181651.1481-1-pablo@netfilter.org>
References: <20200625181651.1481-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This netlink attribute allows you to identify the chain to jump/goto by
means of the chain ID.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/uapi/linux/netfilter/nf_tables.h |  2 ++
 net/netfilter/nf_tables_api.c            | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 2304d1b7ba5e..683e75126d68 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -471,11 +471,13 @@ enum nft_data_attributes {
  *
  * @NFTA_VERDICT_CODE: nf_tables verdict (NLA_U32: enum nft_verdicts)
  * @NFTA_VERDICT_CHAIN: jump target chain name (NLA_STRING)
+ * @NFTA_VERDICT_CHAIN_ID: jump target chain ID (NLA_U32)
  */
 enum nft_verdict_attributes {
 	NFTA_VERDICT_UNSPEC,
 	NFTA_VERDICT_CODE,
 	NFTA_VERDICT_CHAIN,
+	NFTA_VERDICT_CHAIN_ID,
 	__NFTA_VERDICT_MAX
 };
 #define NFTA_VERDICT_MAX	(__NFTA_VERDICT_MAX - 1)
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index fbe8f9209813..9be978788aef 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8242,6 +8242,7 @@ static const struct nla_policy nft_verdict_policy[NFTA_VERDICT_MAX + 1] = {
 	[NFTA_VERDICT_CODE]	= { .type = NLA_U32 },
 	[NFTA_VERDICT_CHAIN]	= { .type = NLA_STRING,
 				    .len = NFT_CHAIN_MAXNAMELEN - 1 },
+	[NFTA_VERDICT_CHAIN_ID]	= { .type = NLA_U32 },
 };
 
 static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
@@ -8278,10 +8279,19 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 		break;
 	case NFT_JUMP:
 	case NFT_GOTO:
-		if (!tb[NFTA_VERDICT_CHAIN])
+		if (tb[NFTA_VERDICT_CHAIN]) {
+			chain = nft_chain_lookup(ctx->net, ctx->table,
+						 tb[NFTA_VERDICT_CHAIN],
+						 genmask);
+		} else if (tb[NFTA_VERDICT_CHAIN_ID]) {
+			chain = nft_chain_lookup_byid(ctx->net,
+						      tb[NFTA_VERDICT_CHAIN_ID]);
+			if (chain->use != 0)
+				return -EBUSY;
+		} else {
 			return -EINVAL;
-		chain = nft_chain_lookup(ctx->net, ctx->table,
-					 tb[NFTA_VERDICT_CHAIN], genmask);
+		}
+
 		if (IS_ERR(chain))
 			return PTR_ERR(chain);
 		if (nft_is_base_chain(chain))
-- 
2.20.1

