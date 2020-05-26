Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4471996C0
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 Mar 2020 14:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgCaMqA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 31 Mar 2020 08:46:00 -0400
Received: from correo.us.es ([193.147.175.20]:41220 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730686AbgCaMqA (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:46:00 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A9CB84FFE03
        for <netfilter-devel@vger.kernel.org>; Tue, 31 Mar 2020 14:45:58 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9CA9F12395A
        for <netfilter-devel@vger.kernel.org>; Tue, 31 Mar 2020 14:45:58 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 92150DA736; Tue, 31 Mar 2020 14:45:58 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B7838123976
        for <netfilter-devel@vger.kernel.org>; Tue, 31 Mar 2020 14:45:56 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 31 Mar 2020 14:45:56 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id A1EE94301DE0
        for <netfilter-devel@vger.kernel.org>; Tue, 31 Mar 2020 14:45:56 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/3] parser_bison: store location of basechain definition
Date:   Tue, 31 Mar 2020 14:45:50 +0200
Message-Id: <20200331124551.403893-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200331124551.403893-1-pablo@netfilter.org>
References: <20200331124551.403893-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Wrap basechain definition field around structure, add field later.
This is useful for error reporting.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/rule.h     | 17 ++++++++++-------
 src/parser_bison.y |  1 +
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/rule.h b/include/rule.h
index 06fefef8a5d8..ac69b30673e8 100644
--- a/include/rule.h
+++ b/include/rule.h
@@ -217,13 +217,16 @@ struct chain {
 	struct location		location;
 	unsigned int		refcnt;
 	uint32_t		flags;
-	struct prio_spec	priority;
-	struct hook_spec	hook;
-	struct expr		*policy;
-	const char		*type;
-	const char		**dev_array;
-	struct expr		*dev_expr;
-	int			dev_array_len;
+	struct {
+		struct location		loc;
+		struct prio_spec	priority;
+		struct hook_spec	hook;
+		struct expr		*policy;
+		const char		*type;
+		const char		**dev_array;
+		struct expr		*dev_expr;
+		int			dev_array_len;
+	};
 	struct scope		scope;
 	struct list_head	rules;
 };
diff --git a/src/parser_bison.y b/src/parser_bison.y
index ebaef17c904c..735f2dffc6e6 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -2057,6 +2057,7 @@ hook_spec		:	TYPE		STRING		HOOK		STRING		dev_spec	prio_spec
 				$<chain>0->type		= xstrdup(chain_type);
 				xfree($2);
 
+				$<chain>0->loc = @$;
 				$<chain>0->hook.loc = @4;
 				$<chain>0->hook.name = chain_hookname_lookup($4);
 				if ($<chain>0->hook.name == NULL) {
-- 
2.11.0

