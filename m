Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6102323C5
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Jul 2020 19:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgG2RxQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 29 Jul 2020 13:53:16 -0400
Received: from correo.us.es ([193.147.175.20]:47898 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgG2RxQ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 29 Jul 2020 13:53:16 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 88648E4B84
        for <netfilter-devel@vger.kernel.org>; Wed, 29 Jul 2020 19:53:14 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 78073DA722
        for <netfilter-devel@vger.kernel.org>; Wed, 29 Jul 2020 19:53:14 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6D82FDA78D; Wed, 29 Jul 2020 19:53:14 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3DFEFDA722
        for <netfilter-devel@vger.kernel.org>; Wed, 29 Jul 2020 19:53:12 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 29 Jul 2020 19:53:12 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 1CB9F42EFB81
        for <netfilter-devel@vger.kernel.org>; Wed, 29 Jul 2020 19:53:12 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] netlink_delinearize: transform binary operation to prefix only with values
Date:   Wed, 29 Jul 2020 19:53:09 +0200
Message-Id: <20200729175309.24724-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The following rule:

 nft add rule inet filter input ip6 saddr and ffff:ffff:ffff:ffff:: @allowable counter

when listing the ruleset becomes:

 ip6 saddr @allowable/64 counter packets 3 bytes 212

This transformation is unparseable, allow prefix transformation only for
values.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/netlink_delinearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index d0438f44058d..9e3ed53d09f1 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -2102,7 +2102,7 @@ static void relational_binop_postprocess(struct rule_pp_ctx *ctx, struct expr *e
 
 		expr_free(binop);
 	} else if (binop->left->dtype->flags & DTYPE_F_PREFIX &&
-		   binop->op == OP_AND &&
+		   binop->op == OP_AND && expr->right->etype == EXPR_VALUE &&
 		   expr_mask_is_prefix(binop->right)) {
 		expr->left = expr_get(binop->left);
 		expr->right = prefix_expr_alloc(&expr->location,
-- 
2.20.1

