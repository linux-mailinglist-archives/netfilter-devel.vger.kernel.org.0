Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA9315352
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Feb 2021 17:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhBIP7v (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Feb 2021 10:59:51 -0500
Received: from correo.us.es ([193.147.175.20]:54142 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232506AbhBIP7t (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:59:49 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C0C422788C7
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Feb 2021 16:59:06 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AF6AFDA730
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Feb 2021 16:59:06 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A48ABDA72F; Tue,  9 Feb 2021 16:59:06 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6AF42DA78A
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Feb 2021 16:59:04 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 09 Feb 2021 16:59:04 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 5366342DC6DD
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Feb 2021 16:59:04 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH] evaluate: incorrect usage of stmt_binary_error() in reject
Date:   Tue,  9 Feb 2021 16:59:00 +0100
Message-Id: <20210209155900.25017-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Don't pass ctx->pctx.protocol[PROTO_BASE_LL_HDR] to stmt_binary_error(),
it's not useful for the error reporting as location is not available.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 030bbde4ab2c..782a5bca98bb 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2729,9 +2729,8 @@ static int stmt_evaluate_reject_bridge(struct eval_ctx *ctx, struct stmt *stmt,
 
 	desc = ctx->pctx.protocol[PROTO_BASE_LL_HDR].desc;
 	if (desc != &proto_eth && desc != &proto_vlan && desc != &proto_netdev)
-		return stmt_binary_error(ctx,
-					 &ctx->pctx.protocol[PROTO_BASE_LL_HDR],
-					 stmt, "unsupported link layer protocol");
+		return __stmt_binary_error(ctx, &stmt->location, NULL,
+					   "cannot reject from this link layer protocol");
 
 	desc = ctx->pctx.protocol[PROTO_BASE_NETWORK_HDR].desc;
 	if (desc != NULL &&
-- 
2.20.1

