Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D2D20A4A2
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jun 2020 20:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgFYSRC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Jun 2020 14:17:02 -0400
Received: from correo.us.es ([193.147.175.20]:58822 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389788AbgFYSRB (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:17:01 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7AADBFC529
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Jun 2020 20:16:59 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 67104DA78D
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Jun 2020 20:16:59 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 5CBBCDA78C; Thu, 25 Jun 2020 20:16:59 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 40619DA72F
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Jun 2020 20:16:57 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 25 Jun 2020 20:16:57 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 2C82E42EE393
        for <netfilter-devel@vger.kernel.org>; Thu, 25 Jun 2020 20:16:57 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 4/5] netfilter: nf_tables: expose enum nft_chain_flags through UAPI
Date:   Thu, 25 Jun 2020 20:16:50 +0200
Message-Id: <20200625181651.1481-5-pablo@netfilter.org>
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

This enum definition was never exposed through UAPI. Rename
NFT_BASE_CHAIN to NFT_CHAIN_BASE for consistency.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h        | 7 +------
 include/uapi/linux/netfilter/nf_tables.h | 5 +++++
 net/netfilter/nf_tables_api.c            | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 3e5226684017..6d1e7da6e00a 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -921,11 +921,6 @@ static inline void nft_set_elem_update_expr(const struct nft_set_ext *ext,
 	     (expr) != (last); \
 	     (expr) = nft_expr_next(expr))
 
-enum nft_chain_flags {
-	NFT_BASE_CHAIN			= 0x1,
-	NFT_CHAIN_HW_OFFLOAD		= 0x2,
-};
-
 #define NFT_CHAIN_POLICY_UNSET		U8_MAX
 
 /**
@@ -1036,7 +1031,7 @@ static inline struct nft_base_chain *nft_base_chain(const struct nft_chain *chai
 
 static inline bool nft_is_base_chain(const struct nft_chain *chain)
 {
-	return chain->flags & NFT_BASE_CHAIN;
+	return chain->flags & NFT_CHAIN_BASE;
 }
 
 int __nft_release_basechain(struct nft_ctx *ctx);
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 683e75126d68..2cf7cc3b50c1 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -184,6 +184,11 @@ enum nft_table_attributes {
 };
 #define NFTA_TABLE_MAX		(__NFTA_TABLE_MAX - 1)
 
+enum nft_chain_flags {
+	NFT_CHAIN_BASE		= (1 << 0),
+	NFT_CHAIN_HW_OFFLOAD	= (1 << 1),
+};
+
 /**
  * enum nft_chain_attributes - nf_tables chain netlink attributes
  *
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 9be978788aef..03fc2538e7c9 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1903,7 +1903,7 @@ static int nft_basechain_init(struct nft_base_chain *basechain, u8 family,
 		nft_basechain_hook_init(&basechain->ops, family, hook, chain);
 	}
 
-	chain->flags |= NFT_BASE_CHAIN | flags;
+	chain->flags |= NFT_CHAIN_BASE | flags;
 	basechain->policy = NF_ACCEPT;
 	if (chain->flags & NFT_CHAIN_HW_OFFLOAD &&
 	    nft_chain_offload_priority(basechain) < 0)
@@ -2255,7 +2255,7 @@ static int nf_tables_newchain(struct net *net, struct sock *nlsk,
 		if (nlh->nlmsg_flags & NLM_F_REPLACE)
 			return -EOPNOTSUPP;
 
-		flags |= chain->flags & NFT_BASE_CHAIN;
+		flags |= chain->flags & NFT_CHAIN_BASE;
 		return nf_tables_updchain(&ctx, genmask, policy, flags);
 	}
 
-- 
2.20.1

