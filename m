Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 046BC459B7
	for <lists+netfilter-devel@lfdr.de>; Fri, 14 Jun 2019 11:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfFNJ6t (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 14 Jun 2019 05:58:49 -0400
Received: from mail.us.es ([193.147.175.20]:48872 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfFNJ6t (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:58:49 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 52B27C1A6F
        for <netfilter-devel@vger.kernel.org>; Fri, 14 Jun 2019 11:58:47 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 45BA8DA70B
        for <netfilter-devel@vger.kernel.org>; Fri, 14 Jun 2019 11:58:47 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 3B193DA70A; Fri, 14 Jun 2019 11:58:47 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4988CDA711
        for <netfilter-devel@vger.kernel.org>; Fri, 14 Jun 2019 11:58:45 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 14 Jun 2019 11:58:45 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 289AA4265A5B
        for <netfilter-devel@vger.kernel.org>; Fri, 14 Jun 2019 11:58:45 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] evaluate: update byteorder only for implicit maps
Date:   Fri, 14 Jun 2019 11:58:40 +0200
Message-Id: <20190614095841.18119-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The byteorder adjustment for the integer datatype is only required by
implicit maps.

Fixes: b9b6092304ae ("evaluate: store byteorder for set keys")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index a41a28e97288..337b66c5ad2d 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -84,7 +84,8 @@ static struct expr *implicit_set_declaration(struct eval_ctx *ctx,
 	struct set *set;
 	struct handle h;
 
-	key_fix_dtype_byteorder(key);
+	if (expr->set_flags & NFT_SET_MAP)
+		key_fix_dtype_byteorder(key);
 
 	set = set_alloc(&expr->location);
 	set->flags	= NFT_SET_ANONYMOUS | expr->set_flags;
-- 
2.11.0

