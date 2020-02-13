Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4BFF15BE77
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Feb 2020 13:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgBMMc7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 13 Feb 2020 07:32:59 -0500
Received: from correo.us.es ([193.147.175.20]:55918 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbgBMMc7 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:32:59 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 9D59B127C61
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Feb 2020 13:32:58 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8FE8EDA703
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Feb 2020 13:32:58 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 857C6DA70E; Thu, 13 Feb 2020 13:32:58 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 81399DA703;
        Thu, 13 Feb 2020 13:32:56 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 13 Feb 2020 13:32:56 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 62DAE42EE38E;
        Thu, 13 Feb 2020 13:32:56 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fasnacht@protonmail.ch
Subject: [PATCH nft] scanner: use list_is_first() from scanner_pop_indesc()
Date:   Thu, 13 Feb 2020 13:32:52 +0100
Message-Id: <20200213123252.629687-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

!list_empty() always stands true since the list is never empty
when calling scanner_pop_indesc().

Check for list_is_first() which actually tells us this is the
initial input file, hence, state->indesc is set to NULL.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
@Fasnacht: this is a follow up on top of your patchset, that is already
           in git.netfilter.org/nftables.

 include/list.h | 11 +++++++++++
 src/scanner.l  |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/list.h b/include/list.h
index 75d292124010..9c4da81749de 100644
--- a/include/list.h
+++ b/include/list.h
@@ -33,6 +33,17 @@ static inline void init_list_head(struct list_head *list)
 	list->prev = list;
 }
 
+/**
+ * list_is_first -- tests whether @list is the first entry in list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_first(const struct list_head *list,
+				const struct list_head *head)
+{
+	return list->prev == head;
+}
+
 /*
  * Insert a new entry between two known consecutive entries.
  *
diff --git a/src/scanner.l b/src/scanner.l
index ed29833b6fc4..3932883b9ade 100644
--- a/src/scanner.l
+++ b/src/scanner.l
@@ -678,7 +678,7 @@ static void scanner_push_indesc(struct parser_state *state,
 
 static void scanner_pop_indesc(struct parser_state *state)
 {
-	if (!list_empty(&state->indesc_list)) {
+	if (!list_is_first(&state->indesc->list, &state->indesc_list)) {
 		state->indesc = list_entry(state->indesc->list.prev,
 					   struct input_descriptor, list);
 	} else {
-- 
2.11.0

