Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09C525C07B
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Sep 2020 13:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgICLlX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 3 Sep 2020 07:41:23 -0400
Received: from correo.us.es ([193.147.175.20]:45098 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728746AbgICLlL (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:41:11 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 75DFAD28C6
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Sep 2020 13:41:09 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 663FCDA704
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Sep 2020 13:41:09 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 5BDFADA73D; Thu,  3 Sep 2020 13:41:09 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 243D8DA789
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Sep 2020 13:41:07 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 03 Sep 2020 13:41:07 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 1123B42EF4E2
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Sep 2020 13:41:07 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] mergesort: find base value expression type via recursion
Date:   Thu,  3 Sep 2020 13:41:03 +0200
Message-Id: <20200903114103.6803-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Sets that store flags might contain a mixture of values and binary
trees. Find the base value type via recursion to compare the
expressions.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/mergesort.c                               | 30 +++++++++++++------
 tests/shell/testcases/sets/0055tcpflags_0     | 27 +++++++++++++++++
 .../testcases/sets/dumps/0055tcpflags_0.nft   | 10 +++++++
 3 files changed, 58 insertions(+), 9 deletions(-)
 create mode 100755 tests/shell/testcases/sets/0055tcpflags_0
 create mode 100644 tests/shell/testcases/sets/dumps/0055tcpflags_0.nft

diff --git a/src/mergesort.c b/src/mergesort.c
index 02094b486aeb..6494b19844fa 100644
--- a/src/mergesort.c
+++ b/src/mergesort.c
@@ -13,6 +13,21 @@
 
 static int expr_msort_cmp(const struct expr *e1, const struct expr *e2);
 
+static const struct expr *expr_msort_value(const struct expr *expr)
+{
+	switch (expr->etype) {
+	case EXPR_SET_ELEM:
+		return expr_msort_value(expr->key);
+	case EXPR_BINOP:
+	case EXPR_MAPPING:
+		return expr_msort_value(expr->left);
+	case EXPR_VALUE:
+		return expr;
+	default:
+		BUG("Unknown expression %s\n", expr_name(expr));
+	}
+}
+
 static int concat_expr_msort_cmp(const struct expr *e1, const struct expr *e2)
 {
 	struct list_head *l = (&e2->expressions)->next;
@@ -35,18 +50,15 @@ static int concat_expr_msort_cmp(const struct expr *e1, const struct expr *e2)
 static int expr_msort_cmp(const struct expr *e1, const struct expr *e2)
 {
 	switch (e1->etype) {
-	case EXPR_SET_ELEM:
-		return expr_msort_cmp(e1->key, e2->key);
-	case EXPR_VALUE:
-		return mpz_cmp(e1->value, e2->value);
 	case EXPR_CONCAT:
 		return concat_expr_msort_cmp(e1, e2);
-	case EXPR_MAPPING:
-		return expr_msort_cmp(e1->left, e2->left);
-	case EXPR_BINOP:
-		return expr_msort_cmp(e1->left, e2->left);
 	default:
-		BUG("Unknown expression %s\n", expr_name(e1));
+		e1 = expr_msort_value(e1);
+		e2 = expr_msort_value(e2);
+
+		assert(e1->etype == e2->etype && e1->etype == EXPR_VALUE);
+
+		return mpz_cmp(e1->value, e2->value);
 	}
 }
 
diff --git a/tests/shell/testcases/sets/0055tcpflags_0 b/tests/shell/testcases/sets/0055tcpflags_0
new file mode 100755
index 000000000000..a2b24eb2981b
--- /dev/null
+++ b/tests/shell/testcases/sets/0055tcpflags_0
@@ -0,0 +1,27 @@
+#!/bin/bash
+
+EXPECTED="add table ip test
+
+add set ip test tcp_good_flags { type tcp_flag ; flags constant ; elements = {
+  ( 0 | 0 | 0 |ack| 0 | 0 ),  \
+  ( 0 | 0 | 0 |ack| 0 |urg),  \
+  ( 0 | 0 | 0 |ack|psh| 0 ),  \
+  ( 0 | 0 | 0 |ack|psh|urg),  \
+  ( 0 | 0 |rst| 0 | 0 | 0 ),  \
+  ( 0 | 0 |rst|ack| 0 | 0 ),  \
+  ( 0 | 0 |rst|ack| 0 |urg),  \
+  ( 0 | 0 |rst|ack|psh| 0 ),  \
+  ( 0 | 0 |rst|ack|psh|urg),  \
+  ( 0 |syn| 0 | 0 | 0 | 0 ),  \
+  ( 0 |syn| 0 |ack| 0 | 0 ),  \
+  ( 0 |syn| 0 |ack| 0 |urg),  \
+  ( 0 |syn| 0 |ack|psh| 0 ),  \
+  ( 0 |syn| 0 |ack|psh|urg),  \
+  (fin| 0 | 0 |ack| 0 | 0 ),  \
+  (fin| 0 | 0 |ack| 0 |urg),  \
+  (fin| 0 | 0 |ack|psh| 0 ),  \
+  (fin| 0 | 0 |ack|psh|urg)   \
+} ; }"
+
+set -e
+$NFT -f - <<< $EXPECTED
diff --git a/tests/shell/testcases/sets/dumps/0055tcpflags_0.nft b/tests/shell/testcases/sets/dumps/0055tcpflags_0.nft
new file mode 100644
index 000000000000..ffed5426577e
--- /dev/null
+++ b/tests/shell/testcases/sets/dumps/0055tcpflags_0.nft
@@ -0,0 +1,10 @@
+table ip test {
+	set tcp_good_flags {
+		type tcp_flag
+		flags constant
+		elements = { fin | psh | ack | urg, fin | psh | ack, fin | ack | urg, fin | ack, syn | psh | ack | urg,
+			     syn | psh | ack, syn | ack | urg, syn | ack, syn, rst | psh | ack | urg,
+			     rst | psh | ack, rst | ack | urg, rst | ack, rst, psh | ack | urg,
+			     psh | ack, ack | urg, ack }
+	}
+}
-- 
2.20.1

