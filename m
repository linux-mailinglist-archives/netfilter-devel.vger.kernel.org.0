Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D71C2286C6
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Jul 2020 19:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgGURFc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Jul 2020 13:05:32 -0400
Received: from correo.us.es ([193.147.175.20]:50736 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgGURFb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:05:31 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 407A8120821
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 19:05:30 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 32278DA72F
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 19:05:30 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 27D2ADA722; Tue, 21 Jul 2020 19:05:30 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F06EBDA72F
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 19:05:27 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 21 Jul 2020 19:05:27 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id D52944265A32
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 19:05:27 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] evaluate: replace variable expression by the value expression
Date:   Tue, 21 Jul 2020 19:05:24 +0200
Message-Id: <20200721170525.3982-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The variable expression provides the binding between the variable
dereference and the value expression. Replace the variable expression by
the real value expression after the evaluation.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 4ec91a1ce771..5111dce55eb6 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2013,10 +2013,13 @@ static int expr_evaluate_variable(struct eval_ctx *ctx, struct expr **exprp)
 {
 	struct expr *new = expr_clone((*exprp)->sym->expr);
 
+	if (expr_evaluate(ctx, &new) < 0)
+		return -1;
+
 	expr_free(*exprp);
 	*exprp = new;
 
-	return expr_evaluate(ctx, exprp);
+	return 0;
 }
 
 static int expr_evaluate_xfrm(struct eval_ctx *ctx, struct expr **exprp)
-- 
2.20.1

