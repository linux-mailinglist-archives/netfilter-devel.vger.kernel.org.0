Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2625C199E08
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 Mar 2020 20:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgCaS3j (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 31 Mar 2020 14:29:39 -0400
Received: from correo.us.es ([193.147.175.20]:39024 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgCaS3j (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:29:39 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4721A4FFE03
        for <netfilter-devel@vger.kernel.org>; Tue, 31 Mar 2020 20:29:37 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2CB14165CB0
        for <netfilter-devel@vger.kernel.org>; Tue, 31 Mar 2020 20:29:37 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1B753165CB2; Tue, 31 Mar 2020 20:29:37 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 28D03165CB0
        for <netfilter-devel@vger.kernel.org>; Tue, 31 Mar 2020 20:29:35 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 31 Mar 2020 20:29:35 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 0A6DE4301DF5
        for <netfilter-devel@vger.kernel.org>; Tue, 31 Mar 2020 20:29:35 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] evaluate: check for device in non-netdev chains
Date:   Tue, 31 Mar 2020 20:29:31 +0200
Message-Id: <20200331182932.34515-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

 # nft -f /tmp/x
 /tmp/x:3:26-36: Error: This chain type cannot be bound to device
                 type filter hook input device eth0 priority 0
                                        ^^^^^^^^^^^

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index 84fe89eed657..fcc79386b325 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3805,6 +3805,9 @@ static int chain_evaluate(struct eval_ctx *ctx, struct chain *chain)
 			if (!chain->dev_expr)
 				return __stmt_binary_error(ctx, &chain->loc, NULL,
 							   "Missing `device' in this chain definition");
+		} else if (chain->dev_expr) {
+			return __stmt_binary_error(ctx, &chain->dev_expr->location, NULL,
+						   "This chain type cannot be bound to device");
 		}
 	}
 
-- 
2.11.0

