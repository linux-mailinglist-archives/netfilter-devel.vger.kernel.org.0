Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C8C5FE7D
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jul 2019 00:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfGDW73 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 4 Jul 2019 18:59:29 -0400
Received: from mail.us.es ([193.147.175.20]:51632 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbfGDW73 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 4 Jul 2019 18:59:29 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5183111456B
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Jul 2019 00:59:26 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 43F32A0AAB
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Jul 2019 00:59:26 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 395D46DA85; Fri,  5 Jul 2019 00:59:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B3325DA704;
        Fri,  5 Jul 2019 00:59:23 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 05 Jul 2019 00:59:23 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 916924265A31;
        Fri,  5 Jul 2019 00:59:23 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nft 1/3,v2] src: use malloc() and free() from cli and main
Date:   Fri,  5 Jul 2019 00:59:18 +0200
Message-Id: <20190704225920.3671-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

xmalloc() and xfree() are internal symbols of the library, do not use
them.

Fixes: 16543a0136c0 ("libnftables: export public symbols only")
Reported-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: exit() in case of OOM from cli

 src/cli.c  | 12 +++++++++---
 src/main.c |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/src/cli.c b/src/cli.c
index ca3869abe335..bbdd0fdbeeb8 100644
--- a/src/cli.c
+++ b/src/cli.c
@@ -63,9 +63,15 @@ static char *cli_append_multiline(char *line)
 		rl_set_prompt(".... ");
 	} else {
 		len += strlen(multiline);
-		s = xmalloc(len + 1);
+		s = malloc(len + 1);
+		if (!s) {
+			fprintf(stderr, "%s:%u: Memory allocation failure\n",
+				__FILE__, __LINE__);
+			cli_exit();
+			exit(EXIT_FAILURE);
+		}
 		snprintf(s, len + 1, "%s%s", multiline, line);
-		xfree(multiline);
+		free(multiline);
 		multiline = s;
 	}
 	line = NULL;
@@ -111,7 +117,7 @@ static void cli_complete(char *line)
 		add_history(line);
 
 	nft_run_cmd_from_buffer(cli_nft, line);
-	xfree(line);
+	free(line);
 }
 
 static char **cli_completion(const char *text, int start, int end)
diff --git a/src/main.c b/src/main.c
index 8e6c897cdd36..694611224d07 100644
--- a/src/main.c
+++ b/src/main.c
@@ -329,7 +329,7 @@ int main(int argc, char * const *argv)
 		exit(EXIT_FAILURE);
 	}
 
-	xfree(buf);
+	free(buf);
 	nft_ctx_free(nft);
 
 	return rc;
-- 
2.11.0

