Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7229360D64
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jul 2019 23:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfGEV4a (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 5 Jul 2019 17:56:30 -0400
Received: from mail.us.es ([193.147.175.20]:51284 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727390AbfGEV4a (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 5 Jul 2019 17:56:30 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A5A21FC537
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Jul 2019 23:56:27 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9765DDA732
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Jul 2019 23:56:27 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 8D0F6DA801; Fri,  5 Jul 2019 23:56:27 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 924A7DA732
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Jul 2019 23:56:25 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 05 Jul 2019 23:56:25 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 6FFD84265A31
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Jul 2019 23:56:25 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 3/3] netfilter: nf_tables: force module load in case select_ops() returns -EAGAIN
Date:   Fri,  5 Jul 2019 23:56:19 +0200
Message-Id: <20190705215619.26558-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190705215619.26558-1-pablo@netfilter.org>
References: <20190705215619.26558-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nft_meta needs to pull in the nft_meta_bridge module in case that this
is a bridge family rule from the select_ops() path.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 6 ++++++
 net/netfilter/nft_meta.c      | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 5e97bf64975a..d22d00ca78c1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2144,6 +2144,12 @@ static int nf_tables_expr_parse(const struct nft_ctx *ctx,
 				       (const struct nlattr * const *)info->tb);
 		if (IS_ERR(ops)) {
 			err = PTR_ERR(ops);
+#ifdef CONFIG_MODULES
+			if (err == -EAGAIN)
+				nft_expr_type_request_module(ctx->net,
+							     ctx->family,
+							     tb[NFTA_EXPR_NAME]);
+#endif
 			goto err1;
 		}
 	} else
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 18a848b01759..13f7abeffed1 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -516,6 +516,10 @@ nft_meta_select_ops(const struct nft_ctx *ctx,
 	if (tb[NFTA_META_KEY] == NULL)
 		return ERR_PTR(-EINVAL);
 
+#ifdef CONFIG_NF_TABLES_BRIDGE
+	if (ctx->family == NFPROTO_BRIDGE)
+		return ERR_PTR(-EAGAIN);
+#endif
 	if (tb[NFTA_META_DREG] && tb[NFTA_META_SREG])
 		return ERR_PTR(-EINVAL);
 
-- 
2.11.0

