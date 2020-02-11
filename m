Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 466A1159A75
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Feb 2020 21:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbgBKUXT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 11 Feb 2020 15:23:19 -0500
Received: from correo.us.es ([193.147.175.20]:39196 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731076AbgBKUXT (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:23:19 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0B3BFEBACC
        for <netfilter-devel@vger.kernel.org>; Tue, 11 Feb 2020 21:23:19 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F08ABDA709
        for <netfilter-devel@vger.kernel.org>; Tue, 11 Feb 2020 21:23:18 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E6222DA705; Tue, 11 Feb 2020 21:23:18 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F3EA4DA702;
        Tue, 11 Feb 2020 21:23:16 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 11 Feb 2020 21:23:16 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id C399C42EF9E1;
        Tue, 11 Feb 2020 21:23:16 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fasnacht@protonmail.ch
Subject: [PATCH nft 2/4] scanner: add indesc_file_alloc() helper function
Date:   Tue, 11 Feb 2020 21:23:06 +0100
Message-Id: <20200211202308.90575-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200211202308.90575-1-pablo@netfilter.org>
References: <20200211202308.90575-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

New helper function to allocate the file input_descriptor.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/scanner.l | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/src/scanner.l b/src/scanner.l
index fe70df5c18ec..56f6e9956791 100644
--- a/src/scanner.l
+++ b/src/scanner.l
@@ -665,6 +665,22 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 
 %%
 
+static struct input_descriptor *
+indesc_file_alloc(FILE *f, const char *filename, const struct location *loc)
+{
+	struct input_descriptor *indesc;
+
+	indesc = xzalloc(sizeof(struct input_descriptor));
+	if (loc != NULL)
+		indesc->location = *loc;
+	indesc->type	= INDESC_FILE;
+	indesc->name	= xstrdup(filename);
+	indesc->f	= f;
+	init_pos(indesc);
+
+	return indesc;
+}
+
 static void scanner_push_indesc(struct parser_state *state,
 				struct input_descriptor *indesc)
 {
@@ -702,15 +718,7 @@ static void scanner_push_file(struct nft_ctx *nft, void *scanner,
 	b = yy_create_buffer(f, YY_BUF_SIZE, scanner);
 	yypush_buffer_state(b, scanner);
 
-	indesc = xzalloc(sizeof(struct input_descriptor));
-
-	if (loc != NULL)
-		indesc->location = *loc;
-	indesc->type	= INDESC_FILE;
-	indesc->name	= xstrdup(filename);
-	indesc->f	= f;
-	init_pos(indesc);
-
+	indesc = indesc_file_alloc(f, filename, loc);
 	scanner_push_indesc(state, indesc);
 }
 
-- 
2.11.0

