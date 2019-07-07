Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACBEF60D63
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jul 2019 23:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfGEV43 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 5 Jul 2019 17:56:29 -0400
Received: from mail.us.es ([193.147.175.20]:51282 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbfGEV42 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 5 Jul 2019 17:56:28 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1E36EFC53C
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Jul 2019 23:56:27 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0FBA7DA801
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Jul 2019 23:56:27 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 057A1DA704; Fri,  5 Jul 2019 23:56:27 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 10D1BD1929
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Jul 2019 23:56:25 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 05 Jul 2019 23:56:25 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id E33DA4265A31
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Jul 2019 23:56:24 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 2/3] netfilter: nf_tables: __nft_expr_type_get() selects specific family type
Date:   Fri,  5 Jul 2019 23:56:18 +0200
Message-Id: <20190705215619.26558-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190705215619.26558-1-pablo@netfilter.org>
References: <20190705215619.26558-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In case that there are two types, prefer the family specify extension.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 582f4e475d67..5e97bf64975a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2009,14 +2009,17 @@ EXPORT_SYMBOL_GPL(nft_unregister_expr);
 static const struct nft_expr_type *__nft_expr_type_get(u8 family,
 						       struct nlattr *nla)
 {
-	const struct nft_expr_type *type;
+	const struct nft_expr_type *type, *candidate = NULL;
 
 	list_for_each_entry(type, &nf_tables_expressions, list) {
-		if (!nla_strcmp(nla, type->name) &&
-		    (!type->family || type->family == family))
-			return type;
+		if (!nla_strcmp(nla, type->name)) {
+			if (!type->family && !candidate)
+				candidate = type;
+			else if (type->family == family)
+				candidate = type;
+		}
 	}
-	return NULL;
+	return candidate;
 }
 
 #ifdef CONFIG_MODULES
-- 
2.11.0

