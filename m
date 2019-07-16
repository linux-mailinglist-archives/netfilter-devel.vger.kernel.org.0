Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC8F96AFAE
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jul 2019 21:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfGPTUb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 Jul 2019 15:20:31 -0400
Received: from mail.us.es ([193.147.175.20]:44510 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfGPTUb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:20:31 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id F05DBBEBAA
        for <netfilter-devel@vger.kernel.org>; Tue, 16 Jul 2019 21:20:28 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E229BDA732
        for <netfilter-devel@vger.kernel.org>; Tue, 16 Jul 2019 21:20:28 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D7BADDA704; Tue, 16 Jul 2019 21:20:28 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BBCE79615B;
        Tue, 16 Jul 2019 21:20:26 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 16 Jul 2019 21:20:26 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 9AE7140705C3;
        Tue, 16 Jul 2019 21:20:26 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     sveyret@gmail.com
Subject: [PATCH nft] evaluate: missing basic evaluation of expectations
Date:   Tue, 16 Jul 2019 21:20:21 +0200
Message-Id: <20190716192021.4729-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Basic ct expectation object evaluation. This fixes tests/py errors.

Error reporting is very sparse at this stage. I'm intentionally leaving
this as future work to store location objects for each field, so user
gets better indication on what is missing when configuring expectations.

Fixes: 65ae2cb6509b ("src: add ct expectations support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index ff0271c757c2..5f2e0a01d0ca 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3425,15 +3425,26 @@ static int chain_evaluate(struct eval_ctx *ctx, struct chain *chain)
 	return 0;
 }
 
-static int obj_evaluate(struct eval_ctx *ctx, struct obj *obj)
+static int ct_expect_evaluate(struct eval_ctx *ctx, struct obj *obj)
+{
+	struct ct_expect *ct = &obj->ct_expect;
+
+	if (!ct->l4proto ||
+	    !ct->dport ||
+	    !ct->timeout ||
+	    !ct->size)
+		return __stmt_binary_error(ctx, &obj->location, NULL,
+					   "missing configuration options");
+
+	return 0;
+}
+
+static int ct_timeout_evaluate(struct eval_ctx *ctx, struct obj *obj)
 {
 	struct ct_timeout *ct = &obj->ct_timeout;
 	struct timeout_state *ts, *next;
 	unsigned int i;
 
-	if (obj->type != NFT_OBJECT_CT_TIMEOUT)
-		return 0;
-
 	for (i = 0; i < timeout_protocol[ct->l4proto].array_size; i++)
 		ct->timeout[i] = timeout_protocol[ct->l4proto].dflt_timeout[i];
 
@@ -3446,6 +3457,21 @@ static int obj_evaluate(struct eval_ctx *ctx, struct obj *obj)
 		list_del(&ts->head);
 		xfree(ts);
 	}
+
+	return 0;
+}
+
+static int obj_evaluate(struct eval_ctx *ctx, struct obj *obj)
+{
+	switch (obj->type) {
+	case NFT_OBJECT_CT_TIMEOUT:
+		return ct_timeout_evaluate(ctx, obj);
+	case NFT_OBJECT_CT_EXPECT:
+		return ct_expect_evaluate(ctx, obj);
+	default:
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.11.0

