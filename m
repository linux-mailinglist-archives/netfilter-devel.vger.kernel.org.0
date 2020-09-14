Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EBC269611
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Sep 2020 22:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgINUI4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Sep 2020 16:08:56 -0400
Received: from correo.us.es ([193.147.175.20]:55472 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgINUIy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:08:54 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 89FDD4A7068
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Sep 2020 22:08:53 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7A0E5DA704
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Sep 2020 22:08:53 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6FBB6DA73F; Mon, 14 Sep 2020 22:08:53 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5494BDA704
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Sep 2020 22:08:51 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 14 Sep 2020 22:08:51 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 439374301DE0
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Sep 2020 22:08:51 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] evaluate: remove one indent level in __expr_evaluate_payload()
Date:   Mon, 14 Sep 2020 22:08:45 +0200
Message-Id: <20200914200846.31726-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914200846.31726-1-pablo@netfilter.org>
References: <20200914200846.31726-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If there is protocol context for this base, just return from function
to remove one level of indentation. This patch is cleanup.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 8f133ea8c384..e3fe70624699 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -707,33 +707,32 @@ static int __expr_evaluate_payload(struct eval_ctx *ctx, struct expr *expr)
 			return -1;
 
 		rule_stmt_insert_at(ctx->rule, nstmt, ctx->stmt);
-	} else {
-		/* No conflict: Same payload protocol as context, adjust offset
-		 * if needed.
-		 */
-		if (desc == payload->payload.desc) {
-			payload->payload.offset +=
-				ctx->pctx.protocol[base].offset;
-			return 0;
-		}
-		/* If we already have context and this payload is on the same
-		 * base, try to resolve the protocol conflict.
-		 */
-		if (payload->payload.base == desc->base) {
-			err = resolve_protocol_conflict(ctx, desc, payload);
-			if (err <= 0)
-				return err;
+		return 0;
+	}
 
-			desc = ctx->pctx.protocol[base].desc;
-			if (desc == payload->payload.desc)
-				return 0;
-		}
-		return expr_error(ctx->msgs, payload,
-				  "conflicting protocols specified: %s vs. %s",
-				  ctx->pctx.protocol[base].desc->name,
-				  payload->payload.desc->name);
+	/* No conflict: Same payload protocol as context, adjust offset
+	 * if needed.
+	 */
+	if (desc == payload->payload.desc) {
+		payload->payload.offset += ctx->pctx.protocol[base].offset;
+		return 0;
 	}
-	return 0;
+	/* If we already have context and this payload is on the same
+	 * base, try to resolve the protocol conflict.
+	 */
+	if (payload->payload.base == desc->base) {
+		err = resolve_protocol_conflict(ctx, desc, payload);
+		if (err <= 0)
+			return err;
+
+		desc = ctx->pctx.protocol[base].desc;
+		if (desc == payload->payload.desc)
+			return 0;
+	}
+	return expr_error(ctx->msgs, payload,
+			  "conflicting protocols specified: %s vs. %s",
+			  ctx->pctx.protocol[base].desc->name,
+			  payload->payload.desc->name);
 }
 
 static bool payload_needs_adjustment(const struct expr *expr)
-- 
2.20.1

