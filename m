Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6522D27373A
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Sep 2020 02:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgIVAVl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Sep 2020 20:21:41 -0400
Received: from correo.us.es ([193.147.175.20]:34266 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbgIVAVl (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:21:41 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 723BE9B7E7
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Sep 2020 02:21:39 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 621EADA78A
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Sep 2020 02:21:39 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 57D7EDA789; Tue, 22 Sep 2020 02:21:39 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 26817DA722;
        Tue, 22 Sep 2020 02:21:37 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 22 Sep 2020 02:21:37 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.lan (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 0B3E642EF4E0;
        Tue, 22 Sep 2020 02:21:37 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     steve@opendium.com
Subject: [PATCH nf] netfilter: nft_immediate: No increment ctx->level for NFT_GOTO
Date:   Tue, 22 Sep 2020 02:21:34 +0200
Message-Id: <20200922002134.11132-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Steve Hill <steve@opendium.com>

nft_immediate_validate() and nft_lookup_validate_setelem() treat NFT_GOTO and
NFT_JUMP identically, incrementing pctx->level for both. This results in a
-EMLINK ("Too many links") being unexpectedly returned for rulesets that use
lots of gotos.

This fixes this problem by not incrementing pctx->level when following gotos.

[ pablo@netfilter.org: Rebased. Restore pctx->level on error for clarity ]

Fixes: 26b2f552525c ("netfilter: nf_tables: fix jumpstack depth validation")
Signed-off-by: Steve Hill <steve@opendium.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_immediate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index c63eb3b17178..303c19e94a11 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -158,21 +158,21 @@ static int nft_immediate_validate(const struct nft_ctx *ctx,
 		return 0;
 
 	data = &priv->data;
-
+	err = 0;
 	switch (data->verdict.code) {
 	case NFT_JUMP:
-	case NFT_GOTO:
 		pctx->level++;
 		err = nft_chain_validate(ctx, data->verdict.chain);
-		if (err < 0)
-			return err;
 		pctx->level--;
 		break;
+	case NFT_GOTO:
+		err = nft_chain_validate(ctx, data->verdict.chain);
+		break;
 	default:
 		break;
 	}
 
-	return 0;
+	return err;
 }
 
 static int nft_immediate_offload_verdict(struct nft_offload_ctx *ctx,
-- 
2.20.1

