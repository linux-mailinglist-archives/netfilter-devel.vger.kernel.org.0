Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681CD28C36D
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Oct 2020 22:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgJLUz4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 12 Oct 2020 16:55:56 -0400
Received: from correo.us.es ([193.147.175.20]:34652 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731627AbgJLUzy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:55:54 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C74A9DA709
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Oct 2020 22:55:52 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B8C4DDA72F
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Oct 2020 22:55:52 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id AE7BBDA722; Mon, 12 Oct 2020 22:55:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BC8FFDA789
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Oct 2020 22:55:50 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 12 Oct 2020 22:55:50 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id AAC2B42EF535
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Oct 2020 22:55:50 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nftables: extend error reporting for chain updates
Date:   Mon, 12 Oct 2020 22:55:45 +0200
Message-Id: <20201012205545.24927-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012205545.24927-1-pablo@netfilter.org>
References: <20201012205545.24927-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The initial support for netlink extended ACK is missing the chain update
path, which results in misleading error reporting in case of EEXIST.

Fixes 36dd1bcc07e5 ("netfilter: nf_tables: initial support for extended ACK reporting")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 4603b667973a..0e43063767d6 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2103,7 +2103,8 @@ static bool nft_hook_list_equal(struct list_head *hook_list1,
 }
 
 static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
-			      u32 flags)
+			      u32 flags, const struct nlattr *attr,
+			      struct netlink_ext_ack *extack)
 {
 	const struct nlattr * const *nla = ctx->nla;
 	struct nft_table *table = ctx->table;
@@ -2119,9 +2120,10 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 		return -EOPNOTSUPP;
 
 	if (nla[NFTA_CHAIN_HOOK]) {
-		if (!nft_is_base_chain(chain))
+		if (!nft_is_base_chain(chain)) {
+			NL_SET_BAD_ATTR(extack, attr);
 			return -EEXIST;
-
+		}
 		err = nft_chain_parse_hook(ctx->net, nla, &hook, ctx->family,
 					   false);
 		if (err < 0)
@@ -2130,6 +2132,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 		basechain = nft_base_chain(chain);
 		if (basechain->type != hook.type) {
 			nft_chain_release_hook(&hook);
+			NL_SET_BAD_ATTR(extack, attr);
 			return -EEXIST;
 		}
 
@@ -2137,6 +2140,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 			if (!nft_hook_list_equal(&basechain->hook_list,
 						 &hook.list)) {
 				nft_chain_release_hook(&hook);
+				NL_SET_BAD_ATTR(extack, attr);
 				return -EEXIST;
 			}
 		} else {
@@ -2144,6 +2148,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 			if (ops->hooknum != hook.num ||
 			    ops->priority != hook.priority) {
 				nft_chain_release_hook(&hook);
+				NL_SET_BAD_ATTR(extack, attr);
 				return -EEXIST;
 			}
 		}
@@ -2156,8 +2161,10 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 
 		chain2 = nft_chain_lookup(ctx->net, table,
 					  nla[NFTA_CHAIN_NAME], genmask);
-		if (!IS_ERR(chain2))
+		if (!IS_ERR(chain2)) {
+			NL_SET_BAD_ATTR(extack, nla[NFTA_CHAIN_NAME]);
 			return -EEXIST;
+		}
 	}
 
 	if (nla[NFTA_CHAIN_COUNTERS]) {
@@ -2200,6 +2207,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 			    nft_trans_chain_update(tmp) &&
 			    nft_trans_chain_name(tmp) &&
 			    strcmp(name, nft_trans_chain_name(tmp)) == 0) {
+				NL_SET_BAD_ATTR(extack, nla[NFTA_CHAIN_NAME]);
 				kfree(name);
 				goto err;
 			}
@@ -2322,7 +2330,8 @@ static int nf_tables_newchain(struct net *net, struct sock *nlsk,
 			return -EOPNOTSUPP;
 
 		flags |= chain->flags & NFT_CHAIN_BASE;
-		return nf_tables_updchain(&ctx, genmask, policy, flags);
+		return nf_tables_updchain(&ctx, genmask, policy, flags, attr,
+					  extack);
 	}
 
 	return nf_tables_addchain(&ctx, family, genmask, policy, flags);
-- 
2.20.1

