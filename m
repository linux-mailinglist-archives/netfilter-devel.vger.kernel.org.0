Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5881FDC1B3
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Oct 2019 11:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407762AbfJRJty (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Oct 2019 05:49:54 -0400
Received: from correo.us.es ([193.147.175.20]:56032 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391488AbfJRJty (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:49:54 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BFE4C1C438D
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Oct 2019 11:49:49 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AB0F1A6AD
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Oct 2019 11:49:49 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A09F9CA0F3; Fri, 18 Oct 2019 11:49:49 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9A5EEFF13C
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Oct 2019 11:49:47 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 18 Oct 2019 11:49:47 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 8265C42EF4E0
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Oct 2019 11:49:47 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnftnl 1/2] flowtable: device array dynamic allocation
Date:   Fri, 18 Oct 2019 11:49:46 +0200
Message-Id: <20191018094947.9531-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Remove artificial upper limit of 8 devices per flowtable.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/flowtable.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/src/flowtable.c b/src/flowtable.c
index 1f7ba3052d4f..54e1bea25775 100644
--- a/src/flowtable.c
+++ b/src/flowtable.c
@@ -358,30 +358,31 @@ static int nftnl_flowtable_parse_hook_cb(const struct nlattr *attr, void *data)
 static int nftnl_flowtable_parse_devs(struct nlattr *nest,
 				      struct nftnl_flowtable *c)
 {
+	const char **dev_array;
+	int len = 0, size = 8;
 	struct nlattr *attr;
-	char *dev_array[8];
-	int len = 0, i;
+
+	dev_array = calloc(8, sizeof(char *));
+	if (!dev_array)
+		return -1;
 
 	mnl_attr_for_each_nested(attr, nest) {
 		if (mnl_attr_get_type(attr) != NFTA_DEVICE_NAME)
 			goto err;
 		dev_array[len++] = strdup(mnl_attr_get_str(attr));
-		if (len >= 8)
-			break;
-	}
+		if (len >= size) {
+			dev_array = realloc(dev_array, size * 2);
+			if (!dev_array)
+				goto err;
 
-	if (!len)
-		return -1;
-
-	c->dev_array = calloc(len + 1, sizeof(char *));
-	if (!c->dev_array)
-		goto err;
+			size *= 2;
+			memset(&dev_array[len], 0, size - len);
+		}
+	}
 
+	c->dev_array = dev_array;
 	c->dev_array_len = len;
 
-	for (i = 0; i < len; i++)
-		c->dev_array[i] = dev_array[i];
-
 	return 0;
 err:
 	while (len--)
-- 
2.11.0

