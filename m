Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA55231177
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jul 2020 20:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgG1SRU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Jul 2020 14:17:20 -0400
Received: from correo.us.es ([193.147.175.20]:41604 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbgG1SRT (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:17:19 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4485615AEA8
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jul 2020 20:17:18 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 383B3DA72F
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jul 2020 20:17:18 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2E0A8DA78E; Tue, 28 Jul 2020 20:17:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3A8EBDA73D
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jul 2020 20:17:16 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 28 Jul 2020 20:17:16 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 1C9F74265A32
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jul 2020 20:17:16 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 3/3] evaluate: UAF in hook priority expression
Date:   Tue, 28 Jul 2020 20:17:10 +0200
Message-Id: <20200728181710.14919-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200728181710.14919-1-pablo@netfilter.org>
References: <20200728181710.14919-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Release priority expression right before assigning the constant
expression that results from the evaluation.

Fixes: 627c451b2351 ("src: allow variables in the chain priority specification")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 536325e83537..7f93621827e6 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3707,7 +3707,6 @@ static bool evaluate_priority(struct eval_ctx *ctx, struct prio_spec *prio,
 	mpz_export_data(prio_str, prio->expr->value, BYTEORDER_HOST_ENDIAN,
 			NFT_NAME_MAXLEN);
 	loc = prio->expr->location;
-	expr_free(prio->expr);
 
 	if (sscanf(prio_str, "%s %c %d", prio_fst, &op, &prio_snd) < 3) {
 		priority = std_prio_lookup(prio_str, family, hook);
@@ -3724,6 +3723,7 @@ static bool evaluate_priority(struct eval_ctx *ctx, struct prio_spec *prio,
 		else
 			return false;
 	}
+	expr_free(prio->expr);
 	prio->expr = constant_expr_alloc(&loc, &integer_type,
 					 BYTEORDER_HOST_ENDIAN,
 					 sizeof(int) * BITS_PER_BYTE,
-- 
2.20.1

