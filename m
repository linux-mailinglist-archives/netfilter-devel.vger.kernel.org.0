Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F82323116B
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jul 2020 20:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgG1SPx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Jul 2020 14:15:53 -0400
Received: from correo.us.es ([193.147.175.20]:41196 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732258AbgG1SPx (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:15:53 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B139615AEAA
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jul 2020 20:15:52 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A36BBDA78B
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jul 2020 20:15:52 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 992FADA789; Tue, 28 Jul 2020 20:15:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8D14FDA78B
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jul 2020 20:15:50 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 28 Jul 2020 20:15:50 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 6FF184265A2F
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jul 2020 20:15:50 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/3] evaluate: memleak in invalid default policy definition
Date:   Tue, 28 Jul 2020 20:15:45 +0200
Message-Id: <20200728181546.12663-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200728181546.12663-1-pablo@netfilter.org>
References: <20200728181546.12663-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Release the clone expression from the exit path.

Fixes: 5173151863d3 ("evaluate: replace variable expression by the value expression")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index e529a7f08e14..536325e83537 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2017,8 +2017,10 @@ static int expr_evaluate_variable(struct eval_ctx *ctx, struct expr **exprp)
 {
 	struct expr *new = expr_clone((*exprp)->sym->expr);
 
-	if (expr_evaluate(ctx, &new) < 0)
+	if (expr_evaluate(ctx, &new) < 0) {
+		expr_free(new);
 		return -1;
+	}
 
 	expr_free(*exprp);
 	*exprp = new;
-- 
2.20.1

