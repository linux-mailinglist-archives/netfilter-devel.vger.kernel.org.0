Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61351DBCBF
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 May 2020 20:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgETSXo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 20 May 2020 14:23:44 -0400
Received: from correo.us.es ([193.147.175.20]:46584 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgETSXo (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 20 May 2020 14:23:44 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C9BD2DA722
        for <netfilter-devel@vger.kernel.org>; Wed, 20 May 2020 20:23:42 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BB31FDA70E
        for <netfilter-devel@vger.kernel.org>; Wed, 20 May 2020 20:23:42 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B0DF4DA711; Wed, 20 May 2020 20:23:42 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BB1E6DA70E
        for <netfilter-devel@vger.kernel.org>; Wed, 20 May 2020 20:23:40 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 20 May 2020 20:23:40 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id A5C1442EF42A
        for <netfilter-devel@vger.kernel.org>; Wed, 20 May 2020 20:23:40 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/4] mnl: add function to convert flowtable device list to array
Date:   Wed, 20 May 2020 20:23:34 +0200
Message-Id: <20200520182337.31295-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds nft_flowtable_dev_array() to convert the list of devices
into an array. This array is released through
nft_flowtable_dev_array_free().

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/mnl.c | 54 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/src/mnl.c b/src/mnl.c
index 94e80261afb7..2890014ebf3d 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -1590,29 +1590,13 @@ err:
 	return NULL;
 }
 
-int mnl_nft_flowtable_add(struct netlink_ctx *ctx, struct cmd *cmd,
-			  unsigned int flags)
+static const char **nft_flowtable_dev_array(struct cmd *cmd)
 {
-	struct nftnl_flowtable *flo;
 	unsigned int ifname_len;
 	const char **dev_array;
 	char ifname[IFNAMSIZ];
-	struct nlmsghdr *nlh;
 	int i = 0, len = 1;
 	struct expr *expr;
-	int priority;
-
-	flo = nftnl_flowtable_alloc();
-	if (!flo)
-		memory_allocation_error();
-
-	nftnl_flowtable_set_u32(flo, NFTNL_FLOWTABLE_FAMILY,
-				cmd->handle.family);
-	nftnl_flowtable_set_u32(flo, NFTNL_FLOWTABLE_HOOKNUM,
-				cmd->flowtable->hook.num);
-	mpz_export_data(&priority, cmd->flowtable->priority.expr->value,
-			BYTEORDER_HOST_ENDIAN, sizeof(int));
-	nftnl_flowtable_set_u32(flo, NFTNL_FLOWTABLE_PRIO, priority);
 
 	list_for_each_entry(expr, &cmd->flowtable->dev_expr->expressions, list)
 		len++;
@@ -1628,14 +1612,44 @@ int mnl_nft_flowtable_add(struct netlink_ctx *ctx, struct cmd *cmd,
 	}
 
 	dev_array[i] = NULL;
-	nftnl_flowtable_set_data(flo, NFTNL_FLOWTABLE_DEVICES,
-				 dev_array, sizeof(char *) * len);
 
-	i = 0;
+	return dev_array;
+}
+
+static void nft_flowtable_dev_array_free(const char **dev_array)
+{
+	int i = 0;
+
 	while (dev_array[i] != NULL)
 		xfree(dev_array[i++]);
 
 	free(dev_array);
+}
+
+int mnl_nft_flowtable_add(struct netlink_ctx *ctx, struct cmd *cmd,
+			  unsigned int flags)
+{
+	struct nftnl_flowtable *flo;
+	const char **dev_array;
+	struct nlmsghdr *nlh;
+	int priority;
+
+	flo = nftnl_flowtable_alloc();
+	if (!flo)
+		memory_allocation_error();
+
+	nftnl_flowtable_set_u32(flo, NFTNL_FLOWTABLE_FAMILY,
+				cmd->handle.family);
+	nftnl_flowtable_set_u32(flo, NFTNL_FLOWTABLE_HOOKNUM,
+				cmd->flowtable->hook.num);
+	mpz_export_data(&priority, cmd->flowtable->priority.expr->value,
+			BYTEORDER_HOST_ENDIAN, sizeof(int));
+	nftnl_flowtable_set_u32(flo, NFTNL_FLOWTABLE_PRIO, priority);
+
+	dev_array = nft_flowtable_dev_array(cmd);
+	nftnl_flowtable_set_data(flo, NFTNL_FLOWTABLE_DEVICES,
+				 dev_array, 0);
+	nft_flowtable_dev_array_free(dev_array);
 
 	nftnl_flowtable_set_u32(flo, NFTNL_FLOWTABLE_FLAGS,
 				cmd->flowtable->flags);
-- 
2.20.1

