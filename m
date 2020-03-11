Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A14B4181ADF
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2020 15:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgCKON1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Mar 2020 10:13:27 -0400
Received: from correo.us.es ([193.147.175.20]:59636 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729676AbgCKON0 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:13:26 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DF68BDA388
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2020 15:13:02 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D0ED7DA39F
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2020 15:13:02 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D05E1DA38F; Wed, 11 Mar 2020 15:13:02 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 155CEDA3A9
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2020 15:13:01 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 11 Mar 2020 15:13:01 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id EC82142EF42A
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2020 15:13:00 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 1/4] netfilter: nf_tables: remove EXPORT_SYMBOL_GPL for nft_expr_init()
Date:   Wed, 11 Mar 2020 15:13:15 +0100
Message-Id: <20200311141318.3633-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200311141318.3633-1-pablo@netfilter.org>
References: <20200311141318.3633-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Not exposed anymore to modules, remove it.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h | 2 --
 net/netfilter/nf_tables_api.c     | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index da2b8ff9f066..13c257f7dd44 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -853,8 +853,6 @@ static inline void *nft_expr_priv(const struct nft_expr *expr)
 	return (void *)expr->data;
 }
 
-struct nft_expr *nft_expr_init(const struct nft_ctx *ctx,
-			       const struct nlattr *nla);
 void nft_expr_destroy(const struct nft_ctx *ctx, struct nft_expr *expr);
 int nft_expr_dump(struct sk_buff *skb, unsigned int attr,
 		  const struct nft_expr *expr);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a9f4169c8610..0f670d13ae27 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2523,8 +2523,8 @@ static void nf_tables_expr_destroy(const struct nft_ctx *ctx,
 	module_put(type->owner);
 }
 
-struct nft_expr *nft_expr_init(const struct nft_ctx *ctx,
-			       const struct nlattr *nla)
+static struct nft_expr *nft_expr_init(const struct nft_ctx *ctx,
+				      const struct nlattr *nla)
 {
 	struct nft_expr_info info;
 	struct nft_expr *expr;
-- 
2.11.0

