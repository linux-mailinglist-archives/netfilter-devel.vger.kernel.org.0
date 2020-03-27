Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A812195DBC
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Mar 2020 19:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgC0Shc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 27 Mar 2020 14:37:32 -0400
Received: from correo.us.es ([193.147.175.20]:43710 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgC0Shc (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:37:32 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 976AC4FFE08
        for <netfilter-devel@vger.kernel.org>; Fri, 27 Mar 2020 19:37:30 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 885B6DA736
        for <netfilter-devel@vger.kernel.org>; Fri, 27 Mar 2020 19:37:30 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 86E82DA72F; Fri, 27 Mar 2020 19:37:30 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A025AFC55C
        for <netfilter-devel@vger.kernel.org>; Fri, 27 Mar 2020 19:37:28 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 27 Mar 2020 19:37:28 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 8BE8242EE38F
        for <netfilter-devel@vger.kernel.org>; Fri, 27 Mar 2020 19:37:28 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] evaluate: display error if statement is missing
Date:   Fri, 27 Mar 2020 19:37:25 +0100
Message-Id: <20200327183725.129061-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

 # cat /tmp/x
 table x {
        set y {
                type ipv4_addr
                elements = {
                        1.1.1.1 counter packets 1 bytes 67,
                }
        }
 }
 # nft -f /tmp/x
 /tmp/x:5:12-18: Error: missing counter statement in set definition
                        1.1.1.1 counter packets 1 bytes 67,
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^

Instead, this should be:

 table x {
        set y {
                type ipv4_addr
		counter               <-------
                elements = {
                        1.1.1.1 counter packets 1 bytes 67,
                }
        }
 }

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 6325f52e49ff..8b03e1f3cfb8 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1310,13 +1310,21 @@ static int expr_evaluate_set_elem(struct eval_ctx *ctx, struct expr **expr)
 	struct set *set = ctx->set;
 	struct expr *elem = *expr;
 
-	if (elem->stmt && set->stmt && set->stmt->ops != elem->stmt->ops)
-		return stmt_binary_error(ctx, set->stmt, elem,
-					 "statement mismatch, element expects %s, "
-					 "%s has type %s",
-					 elem->stmt->ops->name,
-					 set_is_map(set->flags) ? "map" : "set",
-					 set->stmt->ops->name);
+	if (elem->stmt) {
+		if (set->stmt && set->stmt->ops != elem->stmt->ops) {
+			return stmt_error(ctx, elem->stmt,
+					  "statement mismatch, element expects %s, "
+					  "but %s has type %s",
+					  elem->stmt->ops->name,
+					  set_is_map(set->flags) ? "map" : "set",
+					  set->stmt->ops->name);
+		} else if (!set->stmt && !(set->flags & NFT_SET_EVAL)) {
+			return stmt_error(ctx, elem->stmt,
+					  "missing %s statement in %s definition",
+					  elem->stmt->ops->name,
+					  set_is_map(set->flags) ? "map" : "set");
+		}
+	}
 
 	if (expr_evaluate(ctx, &elem->key) < 0)
 		return -1;
-- 
2.11.0

