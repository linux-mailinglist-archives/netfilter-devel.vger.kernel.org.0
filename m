Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97458229B6E
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Jul 2020 17:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgGVPcO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Jul 2020 11:32:14 -0400
Received: from correo.us.es ([193.147.175.20]:44328 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbgGVPcM (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:32:12 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E63B361528
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jul 2020 17:32:09 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D8673DA3A3
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jul 2020 17:32:09 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id CDB69DA3AD; Wed, 22 Jul 2020 17:32:09 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9EF59DA3A3
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jul 2020 17:32:07 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 22 Jul 2020 17:32:07 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 8318F4265A2F
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jul 2020 17:32:07 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] evaluate: bail out with concatenations and singleton values
Date:   Wed, 22 Jul 2020 17:32:04 +0200
Message-Id: <20200722153204.5175-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The rule:

 # nft add rule x y iifname . oifname p . q

is equivalent to:

 # nft add rule x y iifname p oifname q

Bail out with:

 Error: Use concatenations with sets and maps, not singleton values
 add rule x y iifname . oifname p . q
              ^^^^^^^^^^^^^^^^^ ~~~~~

instead of:

 BUG: invalid expression type concat
 nft: evaluate.c:1916: expr_evaluate_relational: Assertion `0' failed.
 Aborted

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index 9290c6ff39ef..1f56dae5ec13 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1912,6 +1912,10 @@ static int expr_evaluate_relational(struct eval_ctx *ctx, struct expr **expr)
 			    byteorder_conversion(ctx, &rel->left, BYTEORDER_BIG_ENDIAN) < 0)
 				return -1;
 			break;
+		case EXPR_CONCAT:
+			return expr_binary_error(ctx->msgs, left, right,
+						 "Use concatenations with sets and maps, not singleton values");
+			break;
 		default:
 			BUG("invalid expression type %s\n", expr_name(right));
 		}
-- 
2.20.1

