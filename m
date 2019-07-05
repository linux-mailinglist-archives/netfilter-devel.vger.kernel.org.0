Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D44B65FE7E
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jul 2019 00:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfGDW7a (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 4 Jul 2019 18:59:30 -0400
Received: from mail.us.es ([193.147.175.20]:51634 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfGDW73 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 4 Jul 2019 18:59:29 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 137AB11456E
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Jul 2019 00:59:27 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 06E096DA85
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Jul 2019 00:59:27 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id F0BEBFB37C; Fri,  5 Jul 2019 00:59:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0DA56DA732;
        Fri,  5 Jul 2019 00:59:25 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 05 Jul 2019 00:59:25 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id D95124265A31;
        Fri,  5 Jul 2019 00:59:24 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nft 2/3] main: replace NFT_EXIT_NOMEM by EXIT_FAILURE
Date:   Fri,  5 Jul 2019 00:59:19 +0200
Message-Id: <20190704225920.3671-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190704225920.3671-1-pablo@netfilter.org>
References: <20190704225920.3671-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The main.c file always uses either EXIT_FAILURE or EXIT_SUCCESS, replace
this.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index 694611224d07..9db3d9aa0a15 100644
--- a/src/main.c
+++ b/src/main.c
@@ -19,7 +19,6 @@
 #include <sys/types.h>
 
 #include <nftables/libnftables.h>
-#include <nftables.h>
 #include <utils.h>
 #include <cli.h>
 
@@ -307,7 +306,7 @@ int main(int argc, char * const *argv)
 		if (buf == NULL) {
 			fprintf(stderr, "%s:%u: Memory allocation failure\n",
 				__FILE__, __LINE__);
-			exit(NFT_EXIT_NOMEM);
+			exit(EXIT_FAILURE);
 		}
 		for (i = optind; i < argc; i++) {
 			strcat(buf, argv[i]);
-- 
2.11.0

