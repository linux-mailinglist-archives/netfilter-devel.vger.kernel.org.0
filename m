Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49442136B77
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jan 2020 11:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgAJKzy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 10 Jan 2020 05:55:54 -0500
Received: from correo.us.es ([193.147.175.20]:38614 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbgAJKzy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:55:54 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 117369A924
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Jan 2020 11:55:51 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 03027DA709
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Jan 2020 11:55:51 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id EC4F5DA716; Fri, 10 Jan 2020 11:55:50 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8CDD3DA709
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Jan 2020 11:55:48 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 10 Jan 2020 11:55:48 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 71A9C42EE38F
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Jan 2020 11:55:48 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] evaluate: better error notice when interval flag is not set on
Date:   Fri, 10 Jan 2020 11:55:46 +0100
Message-Id: <20200110105546.241847-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Users get confused with the existing error notice, let's try a different one:

 # nft add element x y { 1.1.1.0/24 }
 Error: You must add 'flags interval' to your set declaration if you want to add prefix elements
 add element x y { 1.1.1.0/24 }
                   ^^^^^^^^^^

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1395
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 34e4473e4c9a..e7881543d2de 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1299,13 +1299,10 @@ static int expr_evaluate_set_elem(struct eval_ctx *ctx, struct expr **expr)
 	    !(ctx->set->flags & (NFT_SET_ANONYMOUS | NFT_SET_INTERVAL))) {
 		switch (elem->key->etype) {
 		case EXPR_PREFIX:
-			return expr_error(ctx->msgs, elem,
-					  "Set member cannot be prefix, "
-					  "missing interval flag on declaration");
 		case EXPR_RANGE:
 			return expr_error(ctx->msgs, elem,
-					  "Set member cannot be range, "
-					  "missing interval flag on declaration");
+					  "You must add 'flags interval' to your %s declaration if you want to add %s elements",
+					  set_is_map(ctx->set->flags) ? "map" : "set", expr_name(elem->key));
 		default:
 			break;
 		}
-- 
2.11.0

