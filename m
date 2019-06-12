Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E2542E66
	for <lists+netfilter-devel@lfdr.de>; Wed, 12 Jun 2019 20:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfFLSNw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 12 Jun 2019 14:13:52 -0400
Received: from mail.us.es ([193.147.175.20]:39138 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbfFLSNv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:13:51 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 282B9B60C2
        for <netfilter-devel@vger.kernel.org>; Wed, 12 Jun 2019 20:13:50 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 198BDDA702
        for <netfilter-devel@vger.kernel.org>; Wed, 12 Jun 2019 20:13:50 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0F425DA704; Wed, 12 Jun 2019 20:13:50 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1D661DA702
        for <netfilter-devel@vger.kernel.org>; Wed, 12 Jun 2019 20:13:48 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 12 Jun 2019 20:13:48 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [31.4.223.99])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id E09964265A2F
        for <netfilter-devel@vger.kernel.org>; Wed, 12 Jun 2019 20:13:47 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH 2/2 nft,v2] datatype: dtype_clone() should clone flags too
Date:   Wed, 12 Jun 2019 20:13:40 +0200
Message-Id: <20190612181340.31166-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190612181340.31166-1-pablo@netfilter.org>
References: <20190612181340.31166-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Clone original flags too.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes.

 src/datatype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/datatype.c b/src/datatype.c
index c04fc0c6badf..1271cd844755 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -1103,7 +1103,7 @@ static struct datatype *dtype_clone(const struct datatype *orig_dtype)
 	*dtype = *orig_dtype;
 	dtype->name = xstrdup(orig_dtype->name);
 	dtype->desc = xstrdup(orig_dtype->desc);
-	dtype->flags = DTYPE_F_ALLOC;
+	dtype->flags = DTYPE_F_ALLOC | orig_dtype->flags;
 
 	return dtype;
 }
-- 
2.11.0


