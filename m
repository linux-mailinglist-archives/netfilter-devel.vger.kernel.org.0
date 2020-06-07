Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F33C1F0CE7
	for <lists+netfilter-devel@lfdr.de>; Sun,  7 Jun 2020 18:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgFGQVU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 7 Jun 2020 12:21:20 -0400
Received: from correo.us.es ([193.147.175.20]:40280 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbgFGQVT (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 7 Jun 2020 12:21:19 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 01453B6322
        for <netfilter-devel@vger.kernel.org>; Sun,  7 Jun 2020 18:21:18 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E77FDDA73D
        for <netfilter-devel@vger.kernel.org>; Sun,  7 Jun 2020 18:21:17 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id DBA9FDA840; Sun,  7 Jun 2020 18:21:17 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C44E7DA73D
        for <netfilter-devel@vger.kernel.org>; Sun,  7 Jun 2020 18:21:15 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 07 Jun 2020 18:21:15 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id A637141E4800
        for <netfilter-devel@vger.kernel.org>; Sun,  7 Jun 2020 18:21:15 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] evaluate: remove superfluous check in set_evaluate()
Date:   Sun,  7 Jun 2020 18:21:11 +0200
Message-Id: <20200607162112.13486-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If set_is_objmap() is true, then set->data is always NULL.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index fb58c053d4ae..42040b6efe02 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3532,11 +3532,6 @@ static int set_evaluate(struct eval_ctx *ctx, struct set *set)
 			return set_key_data_error(ctx, set,
 						  set->data->dtype, type);
 	} else if (set_is_objmap(set->flags)) {
-		if (set->data) {
-			assert(set->data->etype == EXPR_VALUE);
-			assert(set->data->dtype == &string_type);
-		}
-
 		assert(set->data == NULL);
 		set->data = constant_expr_alloc(&netlink_location, &string_type,
 						BYTEORDER_HOST_ENDIAN,
-- 
2.20.1

