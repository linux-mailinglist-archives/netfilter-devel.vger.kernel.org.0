Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC4E58DCC1
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Aug 2022 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245390AbiHIREY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Aug 2022 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245344AbiHIREM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:04:12 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80EB2EA;
        Tue,  9 Aug 2022 10:04:11 -0700 (PDT)
Received: from localhost.localdomain (1.general.cascardo.us.vpn [10.172.70.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A5A9D402AF;
        Tue,  9 Aug 2022 17:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660064650;
        bh=2KIyslzA71NE4KrtGvjYhMEp3DbKFTnFSf4c5Wj723o=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=m96RTTzrX/dtdWQNlYeHi4ZEbZ5pCTkRTlqVItX7rQsZMm4P8VJvExdeaSGy/i/ts
         /cqmLMv7eyankDwefaZSTX9QbsFIde920CEBDFqOQS4K0ftMFkWOFIIObMYfWXngRl
         E08oVgmwGIL4/k/LgcSWJkNStW2NyPnynMIrK1o9Q2xjwT8uWr9okWpSlDtKEt1+kp
         Xak2is64n7t9eI05RrFUFNoxPo9/Sddb8xgiVEZlsX2kUlnY1sNZrBEFooatDpUU4q
         vshC3R92pw0BvEbAdkReJ/DcOSn+Paegr9/6rt/tKGqh+XQo7hZUR+4Rd9EE9EPOca
         oeufQnc7RAuOg==
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     netfilter-devel@vger.kernel.org
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/3] netfilter: nf_tables: do not allow CHAIN_ID to refer to another table
Date:   Tue,  9 Aug 2022 14:01:47 -0300
Message-Id: <20220809170148.164591-2-cascardo@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809170148.164591-1-cascardo@canonical.com>
References: <20220809170148.164591-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When doing lookups for chains on the same batch by using its ID, a chain
from a different table can be used. If a rule is added to a table but
refers to a chain in a different table, it will be linked to the chain in
table2, but would have expressions referring to objects in table1.

Then, when table1 is removed, the rule will not be removed as its linked to
a chain in table2. When expressions in the rule are processed or removed,
that will lead to a use-after-free.

When looking for chains by ID, use the table that was used for the lookup
by name, and only return chains belonging to that same table.

Fixes: 837830a4b439 ("netfilter: nf_tables: add NFTA_RULE_CHAIN_ID attribute")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: <stable@vger.kernel.org>
---
 net/netfilter/nf_tables_api.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 86fae065f1d2..ae59784db9aa 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2472,6 +2472,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 }
 
 static struct nft_chain *nft_chain_lookup_byid(const struct net *net,
+					       const struct nft_table *table,
 					       const struct nlattr *nla)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
@@ -2482,6 +2483,7 @@ static struct nft_chain *nft_chain_lookup_byid(const struct net *net,
 		struct nft_chain *chain = trans->ctx.chain;
 
 		if (trans->msg_type == NFT_MSG_NEWCHAIN &&
+		    chain->table == table &&
 		    id == nft_trans_chain_id(trans))
 			return chain;
 	}
@@ -3417,7 +3419,7 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 			return -EOPNOTSUPP;
 
 	} else if (nla[NFTA_RULE_CHAIN_ID]) {
-		chain = nft_chain_lookup_byid(net, nla[NFTA_RULE_CHAIN_ID]);
+		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID]);
 		if (IS_ERR(chain)) {
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN_ID]);
 			return PTR_ERR(chain);
@@ -9607,7 +9609,7 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 						 tb[NFTA_VERDICT_CHAIN],
 						 genmask);
 		} else if (tb[NFTA_VERDICT_CHAIN_ID]) {
-			chain = nft_chain_lookup_byid(ctx->net,
+			chain = nft_chain_lookup_byid(ctx->net, ctx->table,
 						      tb[NFTA_VERDICT_CHAIN_ID]);
 			if (IS_ERR(chain))
 				return PTR_ERR(chain);
-- 
2.34.1

