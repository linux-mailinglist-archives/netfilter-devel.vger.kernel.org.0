Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14FA4164F8E
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Feb 2020 21:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBSUI0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Feb 2020 15:08:26 -0500
Received: from correo.us.es ([193.147.175.20]:53272 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgBSUIZ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:08:25 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 315556D4E1
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Feb 2020 21:08:23 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 23108DA736
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Feb 2020 21:08:23 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1831EDA72F; Wed, 19 Feb 2020 21:08:23 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C21FADA3C2
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Feb 2020 21:08:20 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 19 Feb 2020 21:08:20 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id AEF3242EF532
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Feb 2020 21:08:20 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/2] mnl: do not use expr->identifier to fetch device name
Date:   Wed, 19 Feb 2020 21:08:17 +0100
Message-Id: <20200219200817.1146947-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200219200817.1146947-1-pablo@netfilter.org>
References: <20200219200817.1146947-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This string might not be nul-terminated, resulting in spurious errors
when adding netdev chains.

Fixes: 3fdc7541fba0 ("src: add multidevice support for netdev chain")
Fixes: 92911b362e90 ("src: add support to add flowtables")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/mnl.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/src/mnl.c b/src/mnl.c
index 4f42795e0f12..bca5add0f8eb 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -26,6 +26,7 @@
 
 #include <mnl.h>
 #include <string.h>
+#include <net/if.h>
 #include <sys/socket.h>
 #include <arpa/inet.h>
 #include <fcntl.h>
@@ -609,7 +610,9 @@ int mnl_nft_chain_add(struct netlink_ctx *ctx, struct cmd *cmd,
 {
 	int priority, policy, i = 0;
 	struct nftnl_chain *nlc;
+	unsigned int ifname_len;
 	const char **dev_array;
+	char ifname[IFNAMSIZ];
 	struct nlmsghdr *nlh;
 	struct expr *expr;
 	int dev_array_len;
@@ -635,7 +638,12 @@ int mnl_nft_chain_add(struct netlink_ctx *ctx, struct cmd *cmd,
 			dev_array = xmalloc(sizeof(char *) * 8);
 			dev_array_len = 8;
 			list_for_each_entry(expr, &cmd->chain->dev_expr->expressions, list) {
-				dev_array[i++] = expr->identifier;
+				ifname_len = div_round_up(expr->len, BITS_PER_BYTE);
+				memset(ifname, 0, sizeof(ifname));
+				mpz_export_data(ifname, expr->value,
+						BYTEORDER_HOST_ENDIAN,
+						ifname_len);
+				dev_array[i++] = xstrdup(ifname);
 				if (i == dev_array_len) {
 					dev_array_len *= 2;
 					dev_array = xrealloc(dev_array,
@@ -650,6 +658,10 @@ int mnl_nft_chain_add(struct netlink_ctx *ctx, struct cmd *cmd,
 				nftnl_chain_set_data(nlc, NFTNL_CHAIN_DEVICES, dev_array,
 						     sizeof(char *) * dev_array_len);
 
+			i = 0;
+			while (dev_array[i] != NULL)
+				xfree(dev_array[i++]);
+
 			xfree(dev_array);
 		}
 	}
@@ -1565,7 +1577,9 @@ int mnl_nft_flowtable_add(struct netlink_ctx *ctx, struct cmd *cmd,
 			  unsigned int flags)
 {
 	struct nftnl_flowtable *flo;
+	unsigned int ifname_len;
 	const char **dev_array;
+	char ifname[IFNAMSIZ];
 	struct nlmsghdr *nlh;
 	int i = 0, len = 1;
 	struct expr *expr;
@@ -1586,13 +1600,24 @@ int mnl_nft_flowtable_add(struct netlink_ctx *ctx, struct cmd *cmd,
 	list_for_each_entry(expr, &cmd->flowtable->dev_expr->expressions, list)
 		len++;
 
-	dev_array = calloc(len, sizeof(char *));
-	list_for_each_entry(expr, &cmd->flowtable->dev_expr->expressions, list)
-		dev_array[i++] = expr->identifier;
+	dev_array = xmalloc(sizeof(char *) * len);
+
+	list_for_each_entry(expr, &cmd->flowtable->dev_expr->expressions, list) {
+		ifname_len = div_round_up(expr->len, BITS_PER_BYTE);
+		memset(ifname, 0, sizeof(ifname));
+		mpz_export_data(ifname, expr->value, BYTEORDER_HOST_ENDIAN,
+				ifname_len);
+		dev_array[i++] = xstrdup(ifname);
+	}
 
 	dev_array[i] = NULL;
 	nftnl_flowtable_set_data(flo, NFTNL_FLOWTABLE_DEVICES,
 				 dev_array, sizeof(char *) * len);
+
+	i = 0;
+	while (dev_array[i] != NULL)
+		xfree(dev_array[i++]);
+
 	free(dev_array);
 
 	netlink_dump_flowtable(flo, ctx);
-- 
2.11.0

