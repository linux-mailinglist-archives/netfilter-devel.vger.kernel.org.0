Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92E09135F22
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jan 2020 18:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbgAIRTN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Jan 2020 12:19:13 -0500
Received: from correo.us.es ([193.147.175.20]:57784 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729640AbgAIRTN (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:19:13 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B5194E8D69
        for <netfilter-devel@vger.kernel.org>; Thu,  9 Jan 2020 18:19:10 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A65BCDA713
        for <netfilter-devel@vger.kernel.org>; Thu,  9 Jan 2020 18:19:10 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9BA67DA712; Thu,  9 Jan 2020 18:19:10 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A2595DA71F
        for <netfilter-devel@vger.kernel.org>; Thu,  9 Jan 2020 18:19:08 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 09 Jan 2020 18:19:08 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 80F4C42EE38E
        for <netfilter-devel@vger.kernel.org>; Thu,  9 Jan 2020 18:19:08 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] main: restore --debug
Date:   Thu,  9 Jan 2020 18:19:05 +0100
Message-Id: <20200109171905.229555-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Broken since options are mandatory before commands.

Fixes: fb9cea50e8b3 ("main: enforce options before commands")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index 74199f93fa66..6ab1b89f4dd5 100644
--- a/src/main.c
+++ b/src/main.c
@@ -46,7 +46,7 @@ enum opt_vals {
 	OPT_TERSE		= 't',
 	OPT_INVALID		= '?',
 };
-#define OPTSTRING	"+hvcf:iI:jvnsNaeSupypTt"
+#define OPTSTRING	"+hvd:cf:iI:jvnsNaeSupypTt"
 
 static const struct option options[] = {
 	{
@@ -228,8 +228,10 @@ static bool nft_options_check(int argc, char * const argv[])
 			if (nonoption) {
 				nft_options_error(argc, argv, pos);
 				return false;
-			} else if (argv[i][1] == 'I' ||
+			} else if (argv[i][1] == 'd' ||
+				   argv[i][1] == 'I' ||
 				   argv[i][1] == 'f' ||
+				   !strcmp(argv[i], "--debug") ||
 				   !strcmp(argv[i], "--includepath") ||
 				   !strcmp(argv[i], "--file")) {
 				skip = true;
-- 
2.11.0

