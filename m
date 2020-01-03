Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC5812F896
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Jan 2020 14:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgACNFy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Jan 2020 08:05:54 -0500
Received: from correo.us.es ([193.147.175.20]:47608 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbgACNFy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Jan 2020 08:05:54 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id AE2081C4385
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Jan 2020 14:05:50 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A0425DA709
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Jan 2020 14:05:50 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 95B26DA707; Fri,  3 Jan 2020 14:05:50 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 269FCDA702;
        Fri,  3 Jan 2020 14:05:48 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 03 Jan 2020 14:05:48 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 0D06441E4800;
        Fri,  3 Jan 2020 14:05:48 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     arturo@netfilter.org
Subject: [PATCH nft] scanner: incorrect error reporting after file inclusion
Date:   Fri,  3 Jan 2020 14:05:42 +0100
Message-Id: <20200103130542.62490-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

scanner_pop_buffer() incorrectly sets the current input descriptor. The
state->indesc_idx field actually stores the number of input descriptors
in the stack, decrement it and then update the current input descriptor
accordingly.

Fixes: 60e917fa7cb5 ("src: dynamic input_descriptor allocation")
Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1383
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/scanner.l | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/src/scanner.l b/src/scanner.l
index 4fbdcf2afa4b..99ee83559d2e 100644
--- a/src/scanner.l
+++ b/src/scanner.l
@@ -665,12 +665,29 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
 
 %%
 
+static void scanner_push_indesc(struct parser_state *state,
+				struct input_descriptor *indesc)
+{
+	state->indescs[state->indesc_idx] = indesc;
+	state->indesc = state->indescs[state->indesc_idx++];
+}
+
+static void scanner_pop_indesc(struct parser_state *state)
+{
+	state->indesc_idx--;
+
+	if (state->indesc_idx > 0)
+		state->indesc = state->indescs[state->indesc_idx - 1];
+	else
+		state->indesc = NULL;
+}
+
 static void scanner_pop_buffer(yyscan_t scanner)
 {
 	struct parser_state *state = yyget_extra(scanner);
 
 	yypop_buffer_state(scanner);
-	state->indesc = state->indescs[--state->indesc_idx];
+	scanner_pop_indesc(state);
 }
 
 static void scanner_push_file(struct nft_ctx *nft, void *scanner,
@@ -691,8 +708,7 @@ static void scanner_push_file(struct nft_ctx *nft, void *scanner,
 	indesc->name	= xstrdup(filename);
 	init_pos(indesc);
 
-	state->indescs[state->indesc_idx] = indesc;
-	state->indesc = state->indescs[state->indesc_idx++];
+	scanner_push_indesc(state, indesc);
 	list_add_tail(&indesc->list, &state->indesc_list);
 }
 
-- 
2.11.0

