Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0D0195B53
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Mar 2020 17:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgC0QnN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 27 Mar 2020 12:43:13 -0400
Received: from correo.us.es ([193.147.175.20]:45970 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbgC0QnN (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:43:13 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BBA7FF2584
        for <netfilter-devel@vger.kernel.org>; Fri, 27 Mar 2020 17:43:11 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AE5E7DA3C4
        for <netfilter-devel@vger.kernel.org>; Fri, 27 Mar 2020 17:43:11 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A3ECDDA736; Fri, 27 Mar 2020 17:43:11 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DC2ECDA38D
        for <netfilter-devel@vger.kernel.org>; Fri, 27 Mar 2020 17:43:09 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 27 Mar 2020 17:43:09 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id C06C242EE38E
        for <netfilter-devel@vger.kernel.org>; Fri, 27 Mar 2020 17:43:09 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 2/3] netfilter: nft_dynset: validate set expression definition
Date:   Fri, 27 Mar 2020 17:43:05 +0100
Message-Id: <20200327164306.19324-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200327164306.19324-1-pablo@netfilter.org>
References: <20200327164306.19324-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If the global set expression definition mismatches the dynset
expression, then bail out.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_dynset.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index d1b64c8de585..64ca13a1885b 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -187,6 +187,11 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 						     tb[NFTA_DYNSET_EXPR]);
 		if (IS_ERR(priv->expr))
 			return PTR_ERR(priv->expr);
+
+		if (set->expr && set->expr->ops != priv->expr->ops) {
+			err = -EOPNOTSUPP;
+			goto err_expr_free;
+		}
 	}
 
 	nft_set_ext_prepare(&priv->tmpl);
@@ -205,7 +210,7 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 
 	err = nf_tables_bind_set(ctx, set, &priv->binding);
 	if (err < 0)
-		goto err1;
+		goto err_expr_free;
 
 	if (set->size == 0)
 		set->size = 0xffff;
@@ -213,7 +218,7 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 	priv->set = set;
 	return 0;
 
-err1:
+err_expr_free:
 	if (priv->expr != NULL)
 		nft_expr_destroy(ctx, priv->expr);
 	return err;
-- 
2.11.0

